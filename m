Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED55CC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2DF21783
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="y5+eQz53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbfI0D41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 23:56:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37783 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbfI0D41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 23:56:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id f22so4604763wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 20:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=9TQbaqdBIpUEPRYROq+PxDQz4YErOmOv61TNotnxtKw=;
        b=y5+eQz534ms5lt90I8RwTRCin1lxw7MaSqmxLn14SKG3qhrDC4nPEctAeLF1UDbEzL
         028ONNwbf4QqFdfr0MYptowRqWOAYcsYi6d1WvB2Rsx/R963qP4BoQvnsxt+eE2CaNy9
         PwyRkxBmaBkx9/SZS5osSoCXGAJue0DmZphFUSKlIlYdYDNsF6WXNHQT1LIj+2EMJsIT
         /Uq1Sc4XyydjL0dFxueu/XTeGnA4SDJtn1X4w/a+ZDWn3lhwBmRnULtEcZ4L2IJMbzRx
         d3BcFwMqJJdZLklatIkI64QLO+I52Au86uJLJkufKfhG3zl4gPZQbF1eemqjjhqJZTfY
         KFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=9TQbaqdBIpUEPRYROq+PxDQz4YErOmOv61TNotnxtKw=;
        b=P23UV1wA/L4UR/0/EXihW069J/E9nKjQZR/buBMqfAHwaoxV7O8SqYc8iZZhaXp17r
         5MdEpSDTWNO644dSRMCVVzbvh1RCPdt4G5K2opubYFgzyPoddWDCeYrhmlmXJ3fvQiWA
         0etB/SO+pWIMyHGdAotZz6BiQQfx0jl74nbPfUD0Mjf8apiaFtdgZ/8Faxu/4x0+Z4eB
         Z4Yo/aaXSTEBrvbnSq+0rLZKU0fj9Gj0kTx44ZHdSowEFIFtDwG+SpLDOSmENS/5QjY+
         dLGKlNjeG1Rlba/1Qp0zdyTOCX13HErB+JaO5FA6iCsMxxKwbywVKRLtGL6g6ToBxjH+
         IbeQ==
X-Gm-Message-State: APjAAAWzySd+Kdc/n+RQNanLIiGFimtjlu1BCO5OqCMVYRpXtxLpJI0F
        ngwWYX2uSSrFSq2GsHLRM5F/zw==
X-Google-Smtp-Source: APXvYqyueFvC25O8x6DrZ5AVmyiKzsC7UWr40DSbA+Kw/kzkRpC4+ll1WiAwxXJWq1CmfQ7K11q4gQ==
X-Received: by 2002:a1c:3182:: with SMTP id x124mr5777191wmx.168.1569556582646;
        Thu, 26 Sep 2019 20:56:22 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id e20sm4555129wrc.34.2019.09.26.20.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 20:56:21 -0700 (PDT)
Message-ID: <5d8d8865.1c69fb81.a6672.0fae@mx.google.com>
Date:   Thu, 26 Sep 2019 20:56:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Lab-Name: lab-collabora
X-Kernelci-Kernel: v5.3-12562-g7897c04ad09f
X-Kernelci-Tree: mainline
X-Kernelci-Report-Type: bisect
X-Kernelci-Branch: master
Subject: mainline/master boot bisection: v5.3-12562-g7897c04ad09f on
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
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
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

mainline/master boot bisection: v5.3-12562-g7897c04ad09f on bcm2836-rpi-2-b

Summary:
  Start:      7897c04ad09f Merge tag 'trace-v5.4-2' of git://git.kernel.org=
/pub/scm/linux/kernel/git/rostedt/linux-trace
  Details:    https://kernelci.org/boot/id/5d8d446459b51415c1f1224d
  Plain log:  https://storage.kernelci.org//mainline/master/v5.3-12562-g789=
7c04ad09f/arm/bcm2835_defconfig/gcc-8/lab-collabora/boot-bcm2836-rpi-2-b.txt
  HTML log:   https://storage.kernelci.org//mainline/master/v5.3-12562-g789=
7c04ad09f/arm/bcm2835_defconfig/gcc-8/lab-collabora/boot-bcm2836-rpi-2-b.ht=
ml
  Result:     ac7c3e4ff401 compiler: enable CONFIG_OPTIMIZE_INLINING forcib=
ly

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       mainline
  URL:        git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
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
# good: [f41def397161053eb0d3ed6861ef65985efbf293] Merge tag 'ceph-for-5.4-=
rc1' of git://github.com/ceph/ceph-client
git bisect good f41def397161053eb0d3ed6861ef65985efbf293
# bad: [7897c04ad09f815aea1f2dbb05825887d4494a74] Merge tag 'trace-v5.4-2' =
of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
git bisect bad 7897c04ad09f815aea1f2dbb05825887d4494a74
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
