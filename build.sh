#!/bin/sh

sudo rm -rf tbb-*
sudo rm -rf 2017*
sudo rm -rf libtbb*

wget https://github.com/01org/tbb/archive/2017_U7.tar.gz
tar xvf 2017_U7.tar.gz

cd tbb-2017_U7 && make tbb -j4 arch=armv71 CXXFLAGS+="-DTBB_USE_GCC_BUILTINS=1 -D__TBB_64BIT_ATOMICS=0"
cd ..

mkdir libtbb-dev_2017_U7_armhf
cd libtbb-dev_2017_U7_armhf && mkdir -p usr/local/lib/pkgconfig && mkdir -p usr/local/include && mkdir DEBIAN
cd ..

cd libtbb-dev_2017_U7_armhf/DEBIAN && cp ../../control .
cd ..
cd ..

cp tbb-2017_U7/build/*_release/libtbb.so.2 libtbb-dev_2017_U7_armhf/usr/local/lib

cd libtbb-dev_2017_U7_armhf/usr/local/lib 
ln -s libtbb.so.2 libtbb.so
cd ..
cd ..
cd ..
cd ..

cd tbb-2017_U7/include
cp -r serial tbb ../../libtbb-dev_2017_U7_armhf/usr/local/include
cd ..
cd ..

cd libtbb-dev_2017_U7_armhf/usr/local/lib/pkgconfig
cp ../../../../../tbb.pc .
cd ..
cd ..
cd ..
cd ..
cd ..

# Build package
sudo chown -R root:staff libtbb-dev_2017_U7_armhf
sudo dpkg-deb --build libtbb-dev_2017_U7_armhf
sudo dpkg -i libtbb-dev_2017_U7_armhf.deb
sudo ldconfig
