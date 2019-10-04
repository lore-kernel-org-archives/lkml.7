Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB05C10F14
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28D3208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="iQsfqEkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbfJDBMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 21:12:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38085 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfJDBMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 21:12:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id w12so4938725wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 18:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=DKsJAYsG3R6WTDZ7vrufzUjGaFS50c5seUNBMLQ5BAM=;
        b=iQsfqEkWhW0KUpadNu2P5LzzZERTOsZLVZCIgt9LSo6I6msGZN9S8dI/Lz7PoHPhir
         F0ef67IpKR7QKCIFS9oep/YvSECkQQA5Xr/kxCdXRQO8GVolIi94ayO7Jc4mlVruzJ4x
         DMhAJyVQxe87zz6ZjUrEESlgIO7RiGZVr4LIpXwgfA9/I0464bhn3B4adbB7KCnZEhdc
         P4Mglnv7IaEvdPanSUs0htj5/AedVP214ClPN+4iZahGOn15uDsEAR4TG94joL7wdrPQ
         fsem36tL1MnJYEm1ihTpoESXCStIw6+dZeWORiRccPA6n46s4bknAV3wMOjIuZQ603t8
         zGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=DKsJAYsG3R6WTDZ7vrufzUjGaFS50c5seUNBMLQ5BAM=;
        b=NfqlJgrnYMrKH9SIP/rfvb3zLYbQGxYBZHxsG3DJkSDfBTqakODGuM8fqNd4tmirtM
         CJc/0fA9pbQc8NZ5yVzTsgbGDEUBsVsaAO3oBDdJPcFz1hLFxSqWIaYnC+J64Vkok+p+
         QQrksPOrfU9+AOnEWj1ZzGF5QesXxEKckUhMpS+d2MJHu32r9UazRTBkc/g/w6ejVPqb
         4ocXWVBU2D77Xpn0X0gCoXP0K8ka83YyzdNc5XRRvUbQiFaH0swAqBCOfnRLTgjFKdS4
         4oNR9A6HyAIRgb/uE+urJLG5D4s/ZR5PqecnwnfV67BpNCPUZwWyvn1qUF9xXKtE92lX
         AB9g==
X-Gm-Message-State: APjAAAUiFINPQ64UaZ2II4MioP382mbs4hzS4oT/Lj71gTboZFpWU/3t
        L19yMKoHHcKEAtTn1QHdNCes04Hc46AP4g==
X-Google-Smtp-Source: APXvYqykjMOEuZlt5ZolCHt1szftrBD6oYbW+nciJ19DYF3A241KXsvMprjtTru7Db1ybnCT2pIZCg==
X-Received: by 2002:adf:eccd:: with SMTP id s13mr9868120wro.288.1570151549301;
        Thu, 03 Oct 2019 18:12:29 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id y19sm7186869wmi.13.2019.10.03.18.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 18:12:28 -0700 (PDT)
Message-ID: <5d969c7c.1c69fb81.bd2e6.3862@mx.google.com>
Date:   Thu, 03 Oct 2019 18:12:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: v5.4-rc1-17-g25812fcf7403
X-Kernelci-Branch: next
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Tree: ulfh
Subject: ulfh/next boot bisection: v5.4-rc1-17-g25812fcf7403 on
 bcm2837-rpi-3-b-32
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
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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

ulfh/next boot bisection: v5.4-rc1-17-g25812fcf7403 on bcm2837-rpi-3-b-32

Summary:
  Start:      25812fcf7403 mmc: mmci: make unexported functions static
  Details:    https://kernelci.org/boot/id/5d96538e59b514aa6fd85813
  Plain log:  https://storage.kernelci.org//ulfh/next/v5.4-rc1-17-g25812fcf=
7403/arm/bcm2835_defconfig/gcc-8/lab-baylibre/boot-bcm2837-rpi-3-b.txt
  HTML log:   https://storage.kernelci.org//ulfh/next/v5.4-rc1-17-g25812fcf=
7403/arm/bcm2835_defconfig/gcc-8/lab-baylibre/boot-bcm2837-rpi-3-b.html
  Result:     ac7c3e4ff401 compiler: enable CONFIG_OPTIMIZE_INLINING forcib=
ly

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       ulfh
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
  Branch:     next
  Target:     bcm2837-rpi-3-b-32
  CPU arch:   arm
  Lab:        lab-baylibre
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
# good: [e51df6ce668a8f75ce27f83ce0f60103c568c375] mmc: host: sdhci-pci: Ad=
d Genesys Logic GL975x support
git bisect good e51df6ce668a8f75ce27f83ce0f60103c568c375
# bad: [25812fcf74030d9c1be8b898573eaf28de21efee] mmc: mmci: make unexporte=
d functions static
git bisect bad 25812fcf74030d9c1be8b898573eaf28de21efee
# bad: [972a2bf7dfe39ebf49dd47f68d27c416392e53b1] Merge tag 'nfs-for-5.4-1'=
 of git://git.linux-nfs.org/projects/anna/linux-nfs
git bisect bad 972a2bf7dfe39ebf49dd47f68d27c416392e53b1
# good: [9c9fa97a8edbc3668dfc7a25de516e80c146e86f] Merge branch 'akpm' (pat=
ches from Andrew)
git bisect good 9c9fa97a8edbc3668dfc7a25de516e80c146e86f
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
