Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249A2C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DAF21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="WqWplUDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfJBKFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 06:05:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34214 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJBKFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 06:05:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id a11so18953412wrx.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 03:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=zybNFwhxEGOCo5hzmpRWM7nKebTYrmTanuYq/1eqYFw=;
        b=WqWplUDNPCd4XDF/t9CucnzoslXSfLuI4kldDGVvXdoV/CyJqPk0yblQiBr4OrVfCF
         Tang+sqbvJ6TG/DJ0jjPG4qXcffHjTnj3fNRzhgKyckMNLXEek0yM4a33g1EU93guySu
         v6Cbn8wH9UmNfR01cZ6phEk5wFwsdMJdbdiw0SzbP20+PhLn3HLq31jRvcQvjQ7F34R2
         puRRagZkTc7iXfhAdlebdg7B0slkdCvNm1duCU3/1Ci82DacivmcsT/TfvRQF4JEgJ1n
         OHe9ihpYx3Jt45Ot7uMuitKiIvL2oV54SqTZDVzdfsW1ixzX9Pyv5kXpwaRugE1lHRzq
         BPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=zybNFwhxEGOCo5hzmpRWM7nKebTYrmTanuYq/1eqYFw=;
        b=Gv6tKdIjTdTX1YXKkfEm+u/ON6RDU8AeS63fGOZ/Yfx/pj4Z07ytWInIkpbW6qMwD7
         ckMHi/IDQPHJEgMLhgM4GYDkFF18FoC6MINhtD8pu8I+hdlTe2hRoW1jw49Qkuq2V6Gj
         ADNCvxen0rwlGuMhzmeOwaCxEiDVqfbRIFafyoSMvmphj7z6IHwSplvttgai0rbOMew2
         dtDhMzdY5Kycb9rSClerWIVKEsCO7N6fgCY5JWzfrS1lRNhKU9GtizGebWuye9RsimV9
         tBuMeBP9ZrjQBFGQteTpC0zIMg2ln7qQGb1tGiKTb3XlrhG/e5RUID8r05dmmpU5MkvI
         Qykg==
X-Gm-Message-State: APjAAAUuxFY/tHupA/zUTtrGgCXutLzH+6dL9UVqlyuucJcfb9BPbIzl
        rLOgRWfgGXrjRex/tBm9Z+H7qQ==
X-Google-Smtp-Source: APXvYqyxbdkWyOVkHIbcwgGcdx+uvXK1ykG08PdmIQ/UuFYCf6LRACURB616KSDl7Vt0rWdRyOClYA==
X-Received: by 2002:a5d:66cb:: with SMTP id k11mr1983572wrw.174.1570010732438;
        Wed, 02 Oct 2019 03:05:32 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id t4sm20097593wrm.13.2019.10.02.03.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 03:05:31 -0700 (PDT)
Message-ID: <5d94766b.1c69fb81.6d9f4.dc6d@mx.google.com>
Date:   Wed, 02 Oct 2019 03:05:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: v5.3-13203-gc01ebd6c4698
X-Kernelci-Branch: master
X-Kernelci-Lab-Name: lab-collabora
X-Kernelci-Tree: net-next
Subject: net-next/master boot bisection: v5.3-13203-gc01ebd6c4698 on
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
        "David S. Miller" <davem@davemloft.net>,
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

net-next/master boot bisection: v5.3-13203-gc01ebd6c4698 on bcm2836-rpi-2-b

Summary:
  Start:      c01ebd6c4698 r8152: Use guard clause and fix comment typos
  Details:    https://kernelci.org/boot/id/5d942a9059b514a119d857e9
  Plain log:  https://storage.kernelci.org//net-next/master/v5.3-13203-gc01=
ebd6c4698/arm/bcm2835_defconfig/gcc-8/lab-collabora/boot-bcm2836-rpi-2-b.txt
  HTML log:   https://storage.kernelci.org//net-next/master/v5.3-13203-gc01=
ebd6c4698/arm/bcm2835_defconfig/gcc-8/lab-collabora/boot-bcm2836-rpi-2-b.ht=
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
# bad: [c01ebd6c46980654220f6d2b660308a074ee29df] r8152: Use guard clause a=
nd fix comment typos
git bisect bad c01ebd6c46980654220f6d2b660308a074ee29df
# good: [45824fc0da6e46cc5d563105e1eaaf3098a686f9] Merge tag 'powerpc-5.4-1=
' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect good 45824fc0da6e46cc5d563105e1eaaf3098a686f9
# good: [bfe7b00de6d1e25fee08484c4fbf1c1ed175be78] mm, thp: introduce FOLL_=
SPLIT_PMD
git bisect good bfe7b00de6d1e25fee08484c4fbf1c1ed175be78
# bad: [972a2bf7dfe39ebf49dd47f68d27c416392e53b1] Merge tag 'nfs-for-5.4-1'=
 of git://git.linux-nfs.org/projects/anna/linux-nfs
git bisect bad 972a2bf7dfe39ebf49dd47f68d27c416392e53b1
# good: [2e959dd87a9f58f1ad824d830e06388c9e328239] Merge tag 'for-5.4/post-=
2019-09-24' of git://git.kernel.dk/linux-block
git bisect good 2e959dd87a9f58f1ad824d830e06388c9e328239
# bad: [a22fea94992a2bc5328005e62f368413ede49c14] arch/sparc/include/asm/pg=
table_64.h: fix build
git bisect bad a22fea94992a2bc5328005e62f368413ede49c14
# good: [351c8a09b00b5c51c8f58b016fffe51f87e2d820] Merge branch 'i2c/for-5.=
4' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
git bisect good 351c8a09b00b5c51c8f58b016fffe51f87e2d820
# bad: [ac7c3e4ff401b304489a031938dbeaab585bfe0a] compiler: enable CONFIG_O=
PTIMIZE_INLINING forcibly
git bisect bad ac7c3e4ff401b304489a031938dbeaab585bfe0a
# good: [94fb98450456da82a16a378816390d99b85edb55] checkpatch: allow consec=
utive close braces
git bisect good 94fb98450456da82a16a378816390d99b85edb55
# good: [4fadcd1c14d810ec6a695039cfc71e03ae742deb] fs/reiserfs/fix_node.c: =
remove set but not used variables
git bisect good 4fadcd1c14d810ec6a695039cfc71e03ae742deb
# good: [8495f7e6732ed248b648d36439795b42ec650b9e] fork: improve error mess=
age for corrupted page tables
git bisect good 8495f7e6732ed248b648d36439795b42ec650b9e
# good: [7c3a6aedcd6aae0a32a527e68669f7dd667492d1] kexec: bail out upon SIG=
KILL when allocating memory.
git bisect good 7c3a6aedcd6aae0a32a527e68669f7dd667492d1
# good: [9dd819a15162f8f82a6001b090caa38c18297b39] uaccess: add missing __m=
ust_check attributes
git bisect good 9dd819a15162f8f82a6001b090caa38c18297b39
# first bad commit: [ac7c3e4ff401b304489a031938dbeaab585bfe0a] compiler: en=
able CONFIG_OPTIMIZE_INLINING forcibly
---------------------------------------------------------------------------=
----
