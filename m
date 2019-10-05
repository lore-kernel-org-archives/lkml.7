Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D889C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 10:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D324D20830
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 10:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="QI4Zpqua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfJEKGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 06:06:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39651 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbfJEKGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 06:06:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id v17so8037118wml.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 03:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=wDC0HitaGCsDnggKGc/jN4+3DNwnqL8v1NO0UBFQAt8=;
        b=QI4ZpquaDvZ2IbkgslRdiBgAxt0AwiPaFA30BZrOvGmYVNKwUdNlNNPNBrcPdDbZ1G
         2DRY+FbASa+pVzpn0ruFAnTSSZQB7F4S740Yw8SFzc1rkcnZg1YaFSTWuu6sQ9weC1M+
         MDfdTqYxouDgEUe8girpUqZdwvursYSbpZnenhcXRWGli3E1fG+GzT5HxjL6qlRZqcXt
         pdO5QBdKZxmr8K2WOZFUE69cufCHi+eKnmUAwMOJomp8JXK/lLx78bQlWCG4Uved+DG/
         nj+A9sl7kh1YqWCnLUJZF45zLvof9iUwJ4F7DB05rt8aBL/Q7XFpJqFmCgSSm110CMIn
         yGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=wDC0HitaGCsDnggKGc/jN4+3DNwnqL8v1NO0UBFQAt8=;
        b=iegovKRSgbh2fNfPMblIeRo8h5gPow8X4SKjtZNJkh1bIqMSrOVHt8hXvjdO4YFoku
         XVBAxoTJGrb9uMYqU42Jk3dCkx6OryZoxPiIUzxmy37RV8brHfJtlZzekc6FV7lxrvSW
         5IJHh56cgKK8dGoAGJK9mp5SbHK9jPuoqSAkS8SiOkJ0mEkQt5TNWkStAMOiLd0DzSea
         Zcn6FVf+7BS+6jRySCUlBpx+Ss1Cl3RCKTwjK8bXZ8HN69QgL1y8BGoFhVnRSYjZqWqm
         7bgfzm5XNvzArEO/WSJ0I7BamsdCkDGWQDgSEsk8DxftnZLpM6oiKyygbaSbO9Eohkvo
         4D5g==
X-Gm-Message-State: APjAAAXMMc90T7rN3qjOKWVSZMXWnSgCtjjcdqC1DVatjfwZn6QFjCEs
        zk8PcDxNISa7Z/uE40+NhwBz6Q==
X-Google-Smtp-Source: APXvYqwEbPt5BDPhyXKysVm+zGR6eV51bRGH9RPfk6nqiwAbpzOCRTELcPNK51ATARLsP2Pv0SpmFQ==
X-Received: by 2002:a05:600c:2290:: with SMTP id 16mr13302557wmf.161.1570269958197;
        Sat, 05 Oct 2019 03:05:58 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id l18sm9390053wrc.18.2019.10.05.03.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Oct 2019 03:05:57 -0700 (PDT)
Message-ID: <5d986b05.1c69fb81.bc6c7.9571@mx.google.com>
Date:   Sat, 05 Oct 2019 03:05:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: v5.3-13271-g26e010555086
X-Kernelci-Tree: net-next
X-Kernelci-Branch: master
X-Kernelci-Lab-Name: lab-collabora
Subject: net-next/master boot bisection: v5.3-13271-g26e010555086 on
 bcm2836-rpi-2-b
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        tomeu.vizoso@collabora.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        guillaume.tucker@collabora.com, mgalka@collabora.com,
        broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

net-next/master boot bisection: v5.3-13271-g26e010555086 on bcm2836-rpi-2-b

Summary:
  Start:      26e010555086 net: dsa: sja1105: Make function sja1105_xfer_lo=
ng_buf static
  Details:    https://kernelci.org/boot/id/5d9823ab59b514c449857c02
  Plain log:  https://storage.kernelci.org//net-next/master/v5.3-13271-g26e=
010555086/arm/bcm2835_defconfig/gcc-8/lab-collabora/boot-bcm2836-rpi-2-b.txt
  HTML log:   https://storage.kernelci.org//net-next/master/v5.3-13271-g26e=
010555086/arm/bcm2835_defconfig/gcc-8/lab-collabora/boot-bcm2836-rpi-2-b.ht=
ml
  Result:     ac7c3e4ff401 compiler: enable CONFIG_OPTIMIZE_INLINING forcib=
ly

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       net-next
  URL:        git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.=
git
  Branch:     master
  Target:     bcm2836-rpi-2-b
  CPU arch:   arm
  Lab:        lab-collabora
  Compiler:   gcc-8
  Config:     bcm2835_defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit ac7c3e4ff401b304489a031938dbeaab585bfe0a
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed Sep 25 16:47:42 2019 -0700

    compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
    =

    Commit 9012d011660e ("compiler: allow all arches to enable
    CONFIG_OPTIMIZE_INLINING") allowed all architectures to enable this
    option.  A couple of build errors were reported by randconfig, but all =
of
    them have been ironed out.
    =

    Towards the goal of removing CONFIG_OPTIMIZE_INLINING entirely (and it
    will simplify the 'inline' macro in compiler_types.h), this commit chan=
ges
    it to always-on option.  Going forward, the compiler will always be
    allowed to not inline functions marked 'inline'.
    =

    This is not a problem for x86 since it has been long used by
    arch/x86/configs/{x86_64,i386}_defconfig.
    =

    I am keeping the config option just in case any problem crops up for ot=
her
    architectures.
    =

    The code clean-up will be done after confirming this is solid.
    =

    Link: http://lkml.kernel.org/r/20190830034304.24259-1-yamada.masahiro@s=
ocionext.com
    Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
    Acked-by: Nick Desaulniers <ndesaulniers@google.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6b1b1703a646..93d97f9b0157 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -311,7 +311,7 @@ config HEADERS_CHECK
 	  relevant for userspace, say 'Y'.
 =

 config OPTIMIZE_INLINING
-	bool "Allow compiler to uninline functions marked 'inline'"
+	def_bool y
 	help
 	  This option determines if the kernel forces gcc to inline the functions
 	  developers have marked 'inline'. Doing so takes away freedom from gcc to
@@ -322,8 +322,6 @@ config OPTIMIZE_INLINING
 	  decision will become the default in the future. Until then this option
 	  is there to test gcc for this.
 =

-	  If unsure, say N.
-
 config DEBUG_SECTION_MISMATCH
 	bool "Enable full Section mismatch analysis"
 	help
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [b41dae061bbd722b9d7fa828f35d22035b218e18] Merge tag 'xfs-5.4-merge=
-7' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect good b41dae061bbd722b9d7fa828f35d22035b218e18
# bad: [26e0105550862a137eba701e2f4e3eeb343759e9] net: dsa: sja1105: Make f=
unction sja1105_xfer_long_buf static
git bisect bad 26e0105550862a137eba701e2f4e3eeb343759e9
# good: [45824fc0da6e46cc5d563105e1eaaf3098a686f9] Merge tag 'powerpc-5.4-1=
' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect good 45824fc0da6e46cc5d563105e1eaaf3098a686f9
# good: [2b38d01b4de8b1bbda7f5f7e91252609557635fc] mm/zsmalloc.c: fix a -Wu=
nused-function warning
git bisect good 2b38d01b4de8b1bbda7f5f7e91252609557635fc
# bad: [7897c04ad09f815aea1f2dbb05825887d4494a74] Merge tag 'trace-v5.4-2' =
of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
git bisect bad 7897c04ad09f815aea1f2dbb05825887d4494a74
# good: [3cf7487c5de713b706ca2e1f66ec5f9b27fe265a] Merge tag 'sound-fix-5.4=
-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good 3cf7487c5de713b706ca2e1f66ec5f9b27fe265a
# good: [f41def397161053eb0d3ed6861ef65985efbf293] Merge tag 'ceph-for-5.4-=
rc1' of git://github.com/ceph/ceph-client
git bisect good f41def397161053eb0d3ed6861ef65985efbf293
# bad: [ec56103e18c7590303c69329dd4aaadf8a898c19] Merge tag 'for-linus-5.4-=
rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip
git bisect bad ec56103e18c7590303c69329dd4aaadf8a898c19
# bad: [da036ae147624b70f7d3784ff3a53bd4fda20d2a] scripts/gdb: handle split=
 debug
git bisect bad da036ae147624b70f7d3784ff3a53bd4fda20d2a
# good: [5a7f4455ad321400e1361ab94fd6858c5b2fe0cf] checkpatch: remove obsol=
ete period from "ambiguous SHA1" query
git bisect good 5a7f4455ad321400e1361ab94fd6858c5b2fe0cf
# good: [3e9fd5a48cb7b0ef93be097c2c1066738d37f5b7] fs/reiserfs/journal.c: r=
emove set but not used variable
git bisect good 3e9fd5a48cb7b0ef93be097c2c1066738d37f5b7
# good: [7c3a6aedcd6aae0a32a527e68669f7dd667492d1] kexec: bail out upon SIG=
KILL when allocating memory.
git bisect good 7c3a6aedcd6aae0a32a527e68669f7dd667492d1
# good: [9dd819a15162f8f82a6001b090caa38c18297b39] uaccess: add missing __m=
ust_check attributes
git bisect good 9dd819a15162f8f82a6001b090caa38c18297b39
# bad: [7d92bda271ddcbb2d1be2f82733dcb9bf8378010] kgdb: don't use a notifie=
r to enter kgdb at panic; call directly
git bisect bad 7d92bda271ddcbb2d1be2f82733dcb9bf8378010
# bad: [ac7c3e4ff401b304489a031938dbeaab585bfe0a] compiler: enable CONFIG_O=
PTIMIZE_INLINING forcibly
git bisect bad ac7c3e4ff401b304489a031938dbeaab585bfe0a
# first bad commit: [ac7c3e4ff401b304489a031938dbeaab585bfe0a] compiler: en=
able CONFIG_OPTIMIZE_INLINING forcibly
---------------------------------------------------------------------------=
----
