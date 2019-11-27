Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB52C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E516A20684
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="Qj/sTnIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfK0Pcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:32:42 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:37669 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK0Pcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:32:41 -0500
Received: by mail-wm1-f52.google.com with SMTP id f129so8018454wmf.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 07:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=P9nMQxSP/3NbW0UOaTbVrg7hl3NJPIkHjpOMC3L7ViE=;
        b=Qj/sTnImXd2O7/co+8S1Bx13nh6n4TqCSjB+Y2pusb6fKI8++KJDZgsFX2BIyayDTY
         v5iqBI6o8okDpcBsA+BKP1P+UXracdmaaWgyuc8wG1Q95g72esloO51kWFL0tzQzH0yt
         zjtJW4lUxCvgq2VOL8xaYcVjhl7aVeaMt7Jh+whkR37EGVSulj+GeHTFFkoMtX/+6LpU
         b2xKZNzu0g8dPJQ2/Qd/xCNUVVXMpFnuGFu5gYesRa1dtQH/EkmGU9CNUIj4/tBjh5ES
         gNMCJMVT3LvCr5qJRewv8Ea+s0DP2n1ZKJOq3Pmc90ecU/tZIrYr0ya8bGP1pzlXt6zt
         4vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=P9nMQxSP/3NbW0UOaTbVrg7hl3NJPIkHjpOMC3L7ViE=;
        b=JmZcGVI65aCiWQ3iHL7/u1kT6umW7N9pOmew0dc80nruJxgMom/9NqkU+x3zUDhrIt
         ahh49fK9ZicjmYqVCINnHgaZCYntkGsIsjM7X2WRXfF4RS9XqfXqh/1ycDD8dc54Xt3r
         sTyGtc7JwDNvk1HHoTP4dMoUHltgGh77jEh7IpkDFDvqkaw90BwBNnBFDRZkBVTQRWNu
         E4ufacRwkA4f++qvGWUCdPBgyahHr1yJ9OBm9j+aLwpFfs1RvmBgBDo7az2XthQXfOYP
         Sk9JouNtAr0RtM2h9ogTvkR53hBZ3oSWw0/6MQGyYZVLkpBCvQJjUpi6zRlBguB1abbw
         hYTw==
X-Gm-Message-State: APjAAAUmYqHahtyEqEcrliP2haNr3unm8UubdBn4ytW+hzia8xEk3b+M
        ttPYowMbnMDWzJ8wwpZytIm9rQ==
X-Google-Smtp-Source: APXvYqxMtS1i98CzXeUjBl/Hd4banyRZFsV+Tb1x6A+nVEEC/28VLs/7GEvvaSa+/5mWkapx5hpJkw==
X-Received: by 2002:a1c:731a:: with SMTP id d26mr4786136wmb.11.1574868756992;
        Wed, 27 Nov 2019 07:32:36 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id c72sm7558445wmd.11.2019.11.27.07.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 07:32:35 -0800 (PST)
Message-ID: <5dde9713.1c69fb81.b2d5b.6240@mx.google.com>
Date:   Wed, 27 Nov 2019 07:32:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: for-kernelci
X-Kernelci-Tree: ardb
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Kernel: v5.4-5284-g0086acf6c8a3
X-Kernelci-Report-Type: bisect
Subject: ardb/for-kernelci bisection: boot on
 ox820-cloudengines-pogoplug-series-3
To:     Ard Biesheuvel <ardb@kernel.org>, tomeu.vizoso@collabora.com,
        guillaume.tucker@collabora.com, broonie@kernel.org,
        khilman@baylibre.com, mgalka@collabora.com,
        enric.balletbo@collabora.com
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Roy Franz <rfranz@marvell.com>,
        "kernelci.org bot" <bot@kernelci.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
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

ardb/for-kernelci bisection: boot on ox820-cloudengines-pogoplug-series-3

Summary:
  Start:      0086acf6c8a3 crypto: remove cipher routines from public crypt=
o API
  Details:    https://kernelci.org/boot/id/5dde4ea062298c36b5a1b79e
  Plain log:  https://storage.kernelci.org//ardb/for-kernelci/v5.4-5284-g00=
86acf6c8a3/arm/oxnas_v6_defconfig/gcc-8/lab-baylibre/boot-ox820-cloudengine=
s-pogoplug-series-3.txt
  HTML log:   https://storage.kernelci.org//ardb/for-kernelci/v5.4-5284-g00=
86acf6c8a3/arm/oxnas_v6_defconfig/gcc-8/lab-baylibre/boot-ox820-cloudengine=
s-pogoplug-series-3.html
  Result:     a639d59db09e ARM/decompressor: avoid CP15 barrier instruction=
s in v7 cache setup code

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       ardb
  URL:        git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
  Branch:     for-kernelci
  Target:     ox820-cloudengines-pogoplug-series-3
  CPU arch:   arm
  Lab:        lab-baylibre
  Compiler:   gcc-8
  Config:     oxnas_v6_defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit a639d59db09e39306fd9958b412170fb8d075e25
Author: Ard Biesheuvel <ardb@kernel.org>
Date:   Wed Nov 6 09:58:14 2019 +0100

    ARM/decompressor: avoid CP15 barrier instructions in v7 cache setup code
    =

    Commit e17b1af96b2afc38e684aa2f1033387e2ed10029
    =

      "ARM: 8857/1: efi: enable CP15 DMB instructions before cleaning the c=
ache"
    =

    added some explicit handling of the CP15BEN bit in the SCTLR system
    register, to ensure that CP15 barrier instructions are enabled, even
    if we enter the decompressor via the EFI stub.
    =

    However, as it turns out, there are other ways in which we may end up
    using CP15 barrier instructions without them being enabled. I.e., when
    the decompressor startup code skips the cache_on() initially, we end
    up calling cache_clean_flush() with the caches and MMU off, in which
    case the CP15BEN bit in SCTLR may not be programmed either. And in
    fact, cache_on() itself issues CP15 barrier instructions before actually
    enabling them by programming the new SCTLR value (and issuing an ISB)
    =

    Since all these routines are specific to v7, let's clean this up by
    using the ordinary v7 barrier instructions in the v7 specific cache
    handling routines, so that we never rely on the CP15 ones. This also
    avoids the issue where a barrier is required between programming SCTLR
    and using the CP15 barrier instructions, which would result in two
    different kinds of barriers being used in the same function.
    =

    Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/hea=
d.S
index 93dffed0ac6e..ec14687aea3c 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -656,6 +656,21 @@ params:		ldr	r0, =3D0x10000100		@ params_phys for RPC
 		.align
 #endif
 =

+		.macro	v7dsb
+ ARM(		.inst	0xf57ff04f		@ v7+ dsb	)
+ THUMB(		dsb						)
+		.endm
+
+		.macro	v7dmb
+ ARM(		.inst	0xf57ff05f		@ v7+ dmb	)
+ THUMB(		dmb						)
+		.endm
+
+		.macro	v7isb
+ ARM(		.inst	0xf57ff06f		@ v7+ isb	)
+ THUMB(		isb						)
+		.endm
+
 /*
  * Turn on the cache.  We need to setup some page tables so that we
  * can have both the I and D caches on.
@@ -827,7 +842,7 @@ __armv7_mmu_cache_on:
 		movne	r6, #CB_BITS | 0x02	@ !XN
 		blne	__setup_mmu
 		mov	r0, #0
-		mcr	p15, 0, r0, c7, c10, 4	@ drain write buffer
+		v7dsb				@ drain write buffer
 		tst	r11, #0xf		@ VMSA
 		mcrne	p15, 0, r0, c8, c7, 0	@ flush I,D TLBs
 #endif
@@ -849,11 +864,11 @@ __armv7_mmu_cache_on:
 		mcrne	p15, 0, r1, c3, c0, 0	@ load domain access control
 		mcrne   p15, 0, r6, c2, c0, 2   @ load ttb control
 #endif
-		mcr	p15, 0, r0, c7, c5, 4	@ ISB
+		v7isb
 		mcr	p15, 0, r0, c1, c0, 0	@ load control register
 		mrc	p15, 0, r0, c1, c0, 0	@ and read it back
 		mov	r0, #0
-		mcr	p15, 0, r0, c7, c5, 4	@ ISB
+		v7isb
 		mov	pc, r12
 =

 __fa526_cache_on:
@@ -1154,8 +1169,8 @@ __armv7_mmu_cache_off:
 		mcr	p15, 0, r0, c8, c7, 0	@ invalidate whole TLB
 #endif
 		mcr	p15, 0, r0, c7, c5, 6	@ invalidate BTC
-		mcr	p15, 0, r0, c7, c10, 4	@ DSB
-		mcr	p15, 0, r0, c7, c5, 4	@ ISB
+		v7dsb
+		v7isb
 		mov	pc, r12
 =

 /*
@@ -1218,7 +1233,7 @@ __armv7_mmu_cache_flush:
 		mcr	p15, 0, r10, c7, c14, 0	@ clean+invalidate D
 		b	iflush
 hierarchical:
-		mcr	p15, 0, r10, c7, c10, 5	@ DMB
+		v7dmb
 		stmfd	sp!, {r0-r7, r9-r11}
 		mrc	p15, 1, r0, c0, c0, 1	@ read clidr
 		ands	r3, r0, #0x7000000	@ extract loc from clidr
@@ -1232,7 +1247,7 @@ loop1:
 		cmp	r1, #2			@ see what cache we have at this level
 		blt	skip			@ skip if no cache, or just i-cache
 		mcr	p15, 2, r10, c0, c0, 0	@ select current cache level in cssr
-		mcr	p15, 0, r10, c7, c5, 4	@ isb to sych the new cssr&csidr
+		v7isb				@ isb to sych the new cssr&csidr
 		mrc	p15, 1, r1, c0, c0, 0	@ read the new csidr
 		and	r2, r1, #7		@ extract the length of the cache lines
 		add	r2, r2, #4		@ add 4 (line length offset)
@@ -1264,10 +1279,10 @@ finished:
 		mov	r10, #0			@ switch back to cache level 0
 		mcr	p15, 2, r10, c0, c0, 0	@ select current cache level in cssr
 iflush:
-		mcr	p15, 0, r10, c7, c10, 4	@ DSB
+		v7dsb
 		mcr	p15, 0, r10, c7, c5, 0	@ invalidate I+BTB
-		mcr	p15, 0, r10, c7, c10, 4	@ DSB
-		mcr	p15, 0, r10, c7, c5, 4	@ ISB
+		v7dsb
+		v7isb
 		mov	pc, lr
 =

 __armv5tej_mmu_cache_flush:
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [89d57dddd7d319ded00415790a0bb3c954b7e386] Merge tag 'media/v5.5-1'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect good 89d57dddd7d319ded00415790a0bb3c954b7e386
# bad: [0086acf6c8a3010db4cf2226327c43ae78c18e07] crypto: remove cipher rou=
tines from public crypto API
git bisect bad 0086acf6c8a3010db4cf2226327c43ae78c18e07
# bad: [39d72c3eb15d16844565abba94ef2aa9d76526eb] Revert "ARM: 8857/1: efi:=
 enable CP15 DMB instructions before cleaning the cache"
git bisect bad 39d72c3eb15d16844565abba94ef2aa9d76526eb
# bad: [a639d59db09e39306fd9958b412170fb8d075e25] ARM/decompressor: avoid C=
P15 barrier instructions in v7 cache setup code
git bisect bad a639d59db09e39306fd9958b412170fb8d075e25
# first bad commit: [a639d59db09e39306fd9958b412170fb8d075e25] ARM/decompre=
ssor: avoid CP15 barrier instructions in v7 cache setup code
---------------------------------------------------------------------------=
----
