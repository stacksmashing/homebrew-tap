class OpenOcdTamarin < Formula
    desc "On-chip debugging, in-system programming and boundary-scan testing"
    homepage "https://openocd.org/"
    head "https://github.com/stacksmashing/openocd-tamarin.git", branch: "master"
    license "GPL-2.0-or-later"
    revision 1
  
    livecheck do
      url :stable
      regex(%r{url=.*?/openocd[._-]v?(\d+(?:\.\d+)+)\.t}i)
    end
  
    head do
      url "https://github.com/openocd-org/openocd.git", branch: "master"
  
      depends_on "autoconf" => :build
      depends_on "automake" => :build
      depends_on "libtool" => :build
      depends_on "texinfo" => :build
    end
  
    depends_on "pkg-config" => :build
    depends_on "capstone"
    depends_on "hidapi"
    depends_on "libftdi"
    depends_on "libusb"
  
    def install
      ENV["CCACHE"] = "none"
  
      system "./bootstrap", "nosubmodule" if build.head?
      system "./configure", "--disable-dependency-tracking",
                            "--prefix=#{prefix}",
                            "--enable-buspirate",
                            "--enable-stlink",
                            "--enable-dummy",
                            "--enable-jtag_vpi",
                            "--enable-remote-bitbang"
      system "make", "install"
    end
  end