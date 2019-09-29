Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18DFC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 12:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6A920863
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 12:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="lAmmapGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfI2MxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 08:53:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41528 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfI2MxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 08:53:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id h7so7976597wrw.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 05:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=fs5v+weLFPwRRRI3FkXGE9cOtwhFavNV8bkARXetJUg=;
        b=lAmmapGtOyN+qK6w+9yVVpZkIKm6E+hmn8zHxBOg5zPd5cLOM6vvZL+QhJleU9fHH5
         msBHmeBOljrWqOhKKNm0znPYEpQX9IL9BqCqa8no0RwKNf/gfoW2KtYmm0s3ft9a6dP+
         Cxjh+v8SZ7KiKWQot9SG31H0V7SY+w5JeHMxGUvwJJqhiJzP+eumZOHbyQEYgVJMKOj7
         adK6/DpIm2PmorgRmHdvJvzjUO7vclqg78Ck4K1ZfBrBWWy1T4GNRRGk6pZTzyKXOO4F
         F7wElI8znubjspxG7DMFydwLIem+vw6A7/JQKAwunJ3DDa78Vi8WKx4o2PKwVzfdHjTo
         LMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=fs5v+weLFPwRRRI3FkXGE9cOtwhFavNV8bkARXetJUg=;
        b=rdI0A4d/6T4DramnaS8CK3DbA7uT/MjN6s4/6mhUsgWqk3g2zPGxpsQDMcst6eC3TX
         Uw90CTd0tSRZEWEcFk/MzhlUV4YH4sChnJAs+6e2yKGRmyOdxhXwitf8Oh8o5JBQ6DEf
         9CdcGuk4gBIVClJgHgvh1G4DJ+f+YR7ob8fWwKjirZDKb+BOKeEB23C88PML64iWQb7T
         TA2KiFDdFsNOgzm9x4V3lSWAVHlvFPzm1v/9wUOsKph0hFzIIHKS22r0eSSR9U5Yjd4D
         uHh5nCqCiqDQFp4TWDuCybicdFBp29vRQo6uu/fUTT4t9jSbPjB9qqUCP8o46v913IsI
         WIxA==
X-Gm-Message-State: APjAAAXU/GnfIyAypkS09E1hxWjChXJxR+r/k3h/2tVwBrHyk15Y8nnE
        MSbLea34wRg0wmqeOKF/Xv05pJ7IrSg=
X-Google-Smtp-Source: APXvYqwQ++tYEr6bUH90x9+qABbXbO01MUOf6qKmw0nUFxL4osDRIfFuvlyweYIvCsfetWqF6NdsRw==
X-Received: by 2002:adf:fa10:: with SMTP id m16mr9555181wrr.322.1569761590988;
        Sun, 29 Sep 2019 05:53:10 -0700 (PDT)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id u68sm28825342wmu.12.2019.09.29.05.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Sep 2019 05:53:10 -0700 (PDT)
Message-ID: <5d90a936.1c69fb81.90f7c.21e0@mx.google.com>
Date:   Sun, 29 Sep 2019 05:53:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: v5.3-13186-g02dc96ef6c25
X-Kernelci-Branch: master
X-Kernelci-Lab-Name: lab-collabora
X-Kernelci-Tree: net-next
Subject: net-next/master boot bisection: v5.3-13186-g02dc96ef6c25 on
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

net-next/master boot bisection: v5.3-13186-g02dc96ef6c25 on bcm2836-rpi-2-b

Summary:
  Start:      02dc96ef6c25 Merge git://git.kernel.org/pub/scm/linux/kernel/=
git/netdev/net
  Details:    https://kernelci.org/boot/id/5d905d6d59b514ae41d857e9
  Plain log:  https://storage.kernelci.org//net-next/master/v5.3-13186-g02d=
c96ef6c25/arm/bcm2835_defconfig/gcc-8/lab-collabora/boot-bcm2836-rpi-2-b.txt
  HTML log:   https://storage.kernelci.org//net-next/master/v5.3-13186-g02d=
c96ef6c25/arm/bcm2835_defconfig/gcc-8/lab-collabora/boot-bcm2836-rpi-2-b.ht=
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
# bad: [02dc96ef6c25f990452c114c59d75c368a1f4c8f] Merge git://git.kernel.or=
g/pub/scm/linux/kernel/git/netdev/net
git bisect bad 02dc96ef6c25f990452c114c59d75c368a1f4c8f
# good: [8c2b418c3f95a488f5226870eee68574d323f0f8] Merge tag 'arm64-fixes' =
of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect good 8c2b418c3f95a488f5226870eee68574d323f0f8
# good: [9dbd83f665298c9dcf647f20d6d6488e9019114b] Merge tag 'rtc-5.4' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
git bisect good 9dbd83f665298c9dcf647f20d6d6488e9019114b
# bad: [cbafe18c71028d5e0ee1626b4776fea5d5824a78] Merge branch 'akpm' (patc=
hes from Andrew)
git bisect bad cbafe18c71028d5e0ee1626b4776fea5d5824a78
# good: [5184d449600f501a8688069f35c138c6b3bf8b94] Merge tag 'microblaze-v5=
.4-rc1' of git://git.monstr.eu/linux-2.6-microblaze
git bisect good 5184d449600f501a8688069f35c138c6b3bf8b94
# good: [351c8a09b00b5c51c8f58b016fffe51f87e2d820] Merge branch 'i2c/for-5.=
4' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
git bisect good 351c8a09b00b5c51c8f58b016fffe51f87e2d820
# good: [f41def397161053eb0d3ed6861ef65985efbf293] Merge tag 'ceph-for-5.4-=
rc1' of git://github.com/ceph/ceph-client
git bisect good f41def397161053eb0d3ed6861ef65985efbf293
# bad: [7d92bda271ddcbb2d1be2f82733dcb9bf8378010] kgdb: don't use a notifie=
r to enter kgdb at panic; call directly
git bisect bad 7d92bda271ddcbb2d1be2f82733dcb9bf8378010
# good: [94fb98450456da82a16a378816390d99b85edb55] checkpatch: allow consec=
utive close braces
git bisect good 94fb98450456da82a16a378816390d99b85edb55
# good: [da5184c2ab10b57bf9b58f818405aa0054a2f829] fs/reiserfs/do_balan.c: =
remove set but not used variables
git bisect good da5184c2ab10b57bf9b58f818405aa0054a2f829
# good: [2a4a4082cd4438333b5ecffdd15d1a484e5a83c7] cpumask: nicer for_each_=
cpumask_and() signature
git bisect good 2a4a4082cd4438333b5ecffdd15d1a484e5a83c7
# good: [d5372c39132958679c480d0295dd328c741c7a41] kexec: restore arch_kexe=
c_kernel_image_probe declaration
git bisect good d5372c39132958679c480d0295dd328c741c7a41
# bad: [ac7c3e4ff401b304489a031938dbeaab585bfe0a] compiler: enable CONFIG_O=
PTIMIZE_INLINING forcibly
git bisect bad ac7c3e4ff401b304489a031938dbeaab585bfe0a
# good: [9dd819a15162f8f82a6001b090caa38c18297b39] uaccess: add missing __m=
ust_check attributes
git bisect good 9dd819a15162f8f82a6001b090caa38c18297b39
# first bad commit: [ac7c3e4ff401b304489a031938dbeaab585bfe0a] compiler: en=
able CONFIG_OPTIMIZE_INLINING forcibly
---------------------------------------------------------------------------=
----
