Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B237CA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E7820873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="Kdjf4FJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfJaAkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 20:40:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50302 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfJaAkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 20:40:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id 11so4101169wmk.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 17:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=dqv30QEpmsa96vUmup68OojhijXDoxgb0FIePPWJW0k=;
        b=Kdjf4FJO2QxbxQ1BDQvrNtq4zrk4salH61XBBcReF8aXYCs+vK8+GT8Op3aFm34ZNe
         d0FbDmLr04e8cV8tqj63IxLBmByx2sih5wdT08VZhiw/hccl6YhU0l/R+X3k22UAhLHM
         g4w8jKE5dEOqhCNjIF6rWhGPmZ8t5HbxV0IwZ6MbEzEDbJHQBEy5muFO9eRoRJ+QwcCk
         3vnUiWnALwmChCb7A54MbRfjpyeXtJstS8zNWr9ZwPNdNvpzn1HppEUZn3Rq1jhWGQ+5
         PFWYNhRPLbqaW4kBozm3CmNKTRhi4nqYZncuG4V1sXtnxp478BM2NSuxoXxAzbwon4In
         c6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=dqv30QEpmsa96vUmup68OojhijXDoxgb0FIePPWJW0k=;
        b=k4O3GgysYNEv1N85x0Psn0yDDN2qFid5GjVW9z+YW/gkW2ZzUmkI2CB7sRjN9oWnx4
         QNqIrbjid4PyC+gebwFjqlgnf7O+YOmTmFMt5ZC7Yd4DkTzCBS+B/+E9oJx8ZmTBdkRP
         wY0LdZylrK6bA0i2FNzqr0NbaTJmjxvGpDVZYdbh9s/jPl6kA5TD7YlBvztxkcwOiYfj
         jpr/hrqm+RiwgPjyaNxRX7Nn2KhxCZjfL4n01gNCmKdSh6gmCS2chlk7HDAu/8I9Z39S
         jzIznWN9fSUHhJJCUXW6+cUidAq4GXCaUqQeLYoJhQj/bp/sRAbwD5dBljQg3SWoj2Ig
         0ghA==
X-Gm-Message-State: APjAAAV0KHFfTOH6G9N9+9ms7E5fN14KsReJSkawikn+qs9qbaja/EWR
        nTqRe4ZP5eKKQn2FkuvFrcm2CQ==
X-Google-Smtp-Source: APXvYqzGKdpC7rgK2/IQSuM4eq4/RkZF6PDnWfHphfj6qBqi0O59X2GRoF0Xgqjg1RLOEp1hleytug==
X-Received: by 2002:a1c:bc89:: with SMTP id m131mr2284368wmf.14.1572482415318;
        Wed, 30 Oct 2019 17:40:15 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id y2sm1869021wmy.2.2019.10.30.17.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 17:40:14 -0700 (PDT)
Message-ID: <5dba2d6e.1c69fb81.bb885.c0db@mx.google.com>
Date:   Wed, 30 Oct 2019 17:40:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Lab-Name: lab-collabora
X-Kernelci-Branch: next
X-Kernelci-Tree: ulfh
X-Kernelci-Kernel: mmc-v5.4-rc4-36-g3a07e0b48c98
X-Kernelci-Report-Type: bisect
Subject: ulfh/next boot bisection: mmc-v5.4-rc4-36-g3a07e0b48c98 on
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

ulfh/next boot bisection: mmc-v5.4-rc4-36-g3a07e0b48c98 on bcm2836-rpi-2-b

Summary:
  Start:      3a07e0b48c98 mmc: renesas_sdhi_internal_dmac: Add r8a774b1 su=
pport
  Details:    https://kernelci.org/boot/id/5db9c1f659b514bd8960ee84
  Plain log:  https://storage.kernelci.org//ulfh/next/mmc-v5.4-rc4-36-g3a07=
e0b48c98/arm/bcm2835_defconfig/gcc-8/lab-collabora/boot-bcm2836-rpi-2-b.txt
  HTML log:   https://storage.kernelci.org//ulfh/next/mmc-v5.4-rc4-36-g3a07=
e0b48c98/arm/bcm2835_defconfig/gcc-8/lab-collabora/boot-bcm2836-rpi-2-b.html
  Result:     ac7c3e4ff401 compiler: enable CONFIG_OPTIMIZE_INLINING forcib=
ly

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       ulfh
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
  Branch:     next
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
# good: [e51df6ce668a8f75ce27f83ce0f60103c568c375] mmc: host: sdhci-pci: Ad=
d Genesys Logic GL975x support
git bisect good e51df6ce668a8f75ce27f83ce0f60103c568c375
# bad: [3a07e0b48c98b64d061e9e55b33c98db00093368] mmc: renesas_sdhi_interna=
l_dmac: Add r8a774b1 support
git bisect bad 3a07e0b48c98b64d061e9e55b33c98db00093368
# bad: [edf445ad7c8d58c2784a5b733790e80999093d8f] Merge branch 'hugepage-fa=
llbacks' (hugepatch patches from David Rientjes)
git bisect bad edf445ad7c8d58c2784a5b733790e80999093d8f
# good: [8d6996630c03d7ceeabe2611378fea5ca1c3f1b3] block: fix null pointer =
dereference in blk_mq_rq_timed_out()
git bisect good 8d6996630c03d7ceeabe2611378fea5ca1c3f1b3
# bad: [289991ce1cac18e7cd489902986ef986baa49568] Merge tag 'drm-next-2019-=
09-27' of git://anongit.freedesktop.org/drm/drm
git bisect bad 289991ce1cac18e7cd489902986ef986baa49568
# bad: [797a3242755da1b7c1ada6fb153cb2700ef30a80] Merge tag 'linux-kselftes=
t-5.4-rc1.1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-k=
selftest
git bisect bad 797a3242755da1b7c1ada6fb153cb2700ef30a80
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
