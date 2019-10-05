Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C89C4360C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 03:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA956206C0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 03:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="y7i/bh3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfJEDZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 23:25:33 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:26070 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfJEDZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 23:25:32 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x953PHUW016112
        for <linux-kernel@vger.kernel.org>; Sat, 5 Oct 2019 12:25:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x953PHUW016112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570245919;
        bh=CzFqgt/RCBxVczdLz7YZTh6TWXFPuhMLi7QdDPzfle4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y7i/bh3YIbfdRm6QTVFXgN+9oNyz93rS9E2fAc320YdhUKJjBdPXSGi0KDVwr4cHM
         kzbzxhoDmSVkYeTRvpLhPM+baMMcj50K5iHnIYX2BOzG321+LcrJHCxISH+IYqULdF
         V/Wy5QObfrK7T2CzeNY+4b/b4gaRxWicFWMCgwkBK4dtzgkUev8L3XzwTMevFn84gB
         Kmxcj2yebV7EoZOtg8aqFOu4D4Si4bu/ph/feLAYP8QczbVv/fKSrVKKTsG5zLA1/p
         c7dIBFN7a6zB3DvZ4OqEVnEgeKraqhFVeH7YX47BrVut+OWLaucBb2AmnQo86M2g5F
         oJ0inhjH/TBmQ==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id i13so2633225uaq.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 20:25:18 -0700 (PDT)
X-Gm-Message-State: APjAAAV6H6VcK7XhFYvpex+NNjLNQrIeh6ZGMLXYd8uiXB0HnkU4kbaM
        4AfUCO2rj6q97CMzoTnVeA0bLAkARNRKef4EY0s=
X-Google-Smtp-Source: APXvYqzdxqsXAaRsCvC2uuekWzSIauGAAR33V7TOeM7d7W03t0fPbaGlMobJoEIy1s9VPksLWthhFuNn10fZFlvfZ58=
X-Received: by 2002:ab0:20b4:: with SMTP id y20mr9673912ual.121.1570245916807;
 Fri, 04 Oct 2019 20:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <cf947abb-c94e-9b6f-229a-1e219fd38e94@skogtun.org>
In-Reply-To: <cf947abb-c94e-9b6f-229a-1e219fd38e94@skogtun.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 5 Oct 2019 12:24:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS-msvdv+=msqfSYX3ZKPQm_AJ0B=Uu7hfah1V+NGPjmQ@mail.gmail.com>
Message-ID: <CAK7LNAS-msvdv+=msqfSYX3ZKPQm_AJ0B=Uu7hfah1V+NGPjmQ@mail.gmail.com>
Subject: Re: BISECTED: Compile error on 5.4-rc1
To:     Harald Arnesen <harald@skogtun.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 5:26 PM Harald Arnesen <harald@skogtun.org> wrote:
>
> I just tried to compile kernel 5.4-rc1 on my ThinkPad, which runs Devuan
> Beowulf. Got the following:
>
> $ make bindeb-pkg
>   UPD     include/config/kernel.release
> sh ./scripts/package/mkdebian
> dpkg-buildpackage -r"fakeroot -u" -a$(cat debian/arch)  -b -nc -uc
> dpkg-buildpackage: info: source package linux-5.4.0-rc1-00014-gcc3a7bfe62b9
> dpkg-buildpackage: info: source version 5.4.0-rc1-00014-gcc3a7bfe62b9-1
> dpkg-buildpackage: info: source distribution beowulf
> dpkg-buildpackage: info: source changed by Harald Arnesen
> <harald@skogtun.org>
> dpkg-architecture: warning: specified GNU system type x86_64-linux-gnu
> does not match CC system type x86_64-pc-linux-gnu, try setting a correct
> CC environment variable
> dpkg-buildpackage: info: host architecture amd64
>  dpkg-source --before-build .
> dpkg-source: warning: can't parse dependency -n libelf-dev
> dpkg-source: error: error occurred while parsing Build-Depends
> dpkg-buildpackage: error: dpkg-source --before-build . subprocess
> returned exit status 255
> make[1]: *** [scripts/Makefile.package:83: bindeb-pkg] Error 255
> make: *** [Makefile:1448: bindeb-pkg] Error 2
>
>
> Bisecting gives me
>
> 858805b336be1cabb3d9033adaa3676574d12e37 is the first bad commit
> commit 858805b336be1cabb3d9033adaa3676574d12e37
> Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> Date:   Sun Aug 25 22:28:37 2019 +0900
> ...
>
> By reverting commit 858805b336be1cabb3d9033adaa3676574d12e37 I could
> compile the kernel.
> --
> Hilsen Harald
>


I cannot reproduce it.

I tested bindeb-pkg for the latest Linus tree successfully.



masahiro@grover:~/ref/linux$ git log --oneline -1
4ea655343ce4 (HEAD -> master, origin/master, origin/HEAD) Merge tag
'mips_fixes_5.4_1' of
git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
masahiro@grover:~/ref/linux$ make bindeb-pkg
sh ./scripts/package/mkdebian
dpkg-buildpackage -r"fakeroot -u" -a$(cat debian/arch)  -b -nc -uc
dpkg-buildpackage: info: source package linux-5.4.0-rc1+
dpkg-buildpackage: info: source version 5.4.0-rc1+-4
dpkg-buildpackage: info: source distribution bionic
dpkg-buildpackage: info: source changed by Masahiro Yamada
<yamada.masahiro@socionext.com>
dpkg-buildpackage: info: host architecture amd64
 dpkg-source --before-build linux
 debian/rules build
make KERNELRELEASE=5.4.0-rc1+ ARCH=x86 KBUILD_BUILD_VERSION=4 -f ./Makefile
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  AR      init/built-in.a
  GEN     .version
  CHK     include/generated/compile.h
  LD      vmlinux.o
  MODPOST vmlinux.o
  MODINFO modules.builtin.modinfo
  LD      .tmp_vmlinux1
  KSYM    .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
  KSYM    .tmp_kallsyms2.o
  LD      vmlinux
  SORTEX  vmlinux
  SYSMAP  System.map
  VOFFSET arch/x86/boot/compressed/../voffset.h
  CC      arch/x86/boot/compressed/misc.o
  OBJCOPY arch/x86/boot/compressed/vmlinux.bin
  RELOCS  arch/x86/boot/compressed/vmlinux.relocs
  GZIP    arch/x86/boot/compressed/vmlinux.bin.gz
  MKPIGGY arch/x86/boot/compressed/piggy.S
  AS      arch/x86/boot/compressed/piggy.o
  CC      arch/x86/boot/compressed/kaslr.o
  LD      arch/x86/boot/compressed/vmlinux
  ZOFFSET arch/x86/boot/zoffset.h
  AS      arch/x86/boot/header.o
  CC      arch/x86/boot/version.o
  LD      arch/x86/boot/setup.elf
  OBJCOPY arch/x86/boot/setup.bin
  OBJCOPY arch/x86/boot/vmlinux.bin
  BUILD   arch/x86/boot/bzImage
Setup is 16124 bytes (padded to 16384 bytes).
System is 8661 kB
CRC fab8ebd9
Kernel: arch/x86/boot/bzImage is ready  (#5)
  Building modules, stage 2.
  MODPOST 12 modules
 fakeroot -u debian/rules binary
make KERNELRELEASE=5.4.0-rc1+ ARCH=x86 KBUILD_BUILD_VERSION=4 -f
./Makefile intdeb-pkg
sh ./scripts/package/builddeb
  INSTALL drivers/thermal/intel/x86_pkg_temp_thermal.ko
  INSTALL fs/efivarfs/efivarfs.ko
  INSTALL net/ipv4/netfilter/iptable_nat.ko
  INSTALL net/ipv4/netfilter/nf_log_arp.ko
  INSTALL net/ipv4/netfilter/nf_log_ipv4.ko
  INSTALL net/ipv6/netfilter/nf_log_ipv6.ko
  INSTALL net/netfilter/nf_log_common.ko
  INSTALL net/netfilter/xt_LOG.ko
  INSTALL net/netfilter/xt_MASQUERADE.ko
  INSTALL net/netfilter/xt_addrtype.ko
  INSTALL net/netfilter/xt_mark.ko
  INSTALL net/netfilter/xt_nat.ko
  DEPMOD  5.4.0-rc1+
  INSTALL ./debian/headertmp/usr/include
dpkg-deb: building package 'linux-headers-5.4.0-rc1+' in
'../linux-headers-5.4.0-rc1+_5.4.0-rc1+-4_amd64.deb'.
dpkg-deb: building package 'linux-libc-dev' in
'../linux-libc-dev_5.4.0-rc1+-4_amd64.deb'.
dpkg-deb: building package 'linux-image-5.4.0-rc1+' in
'../linux-image-5.4.0-rc1+_5.4.0-rc1+-4_amd64.deb'.
 dpkg-genbuildinfo --build=binary
 dpkg-genchanges --build=binary >../linux-5.4.0-rc1+_5.4.0-rc1+-4_amd64.changes
dpkg-genchanges: warning: package linux-image-5.4.0-rc1+-dbg in
control file but not in files list
dpkg-genchanges: info: binary-only upload (no source code included)
 dpkg-source --after-build linux
dpkg-buildpackage: info: binary-only upload (no source included)



-- 
Best Regards
Masahiro Yamada
