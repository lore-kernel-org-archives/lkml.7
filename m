Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDBCC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0107B208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="opTctyyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfFZMgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:36:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36253 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfFZMgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:36:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5QCa0o64104321
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 05:36:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5QCa0o64104321
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561552561;
        bh=42+yJjAoGpxbbBcXAXkO7smhtLvMGHoPbOt+S/aE0Mg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=opTctyyKRDAiqeaPBRPgPdfxItUVMNCUWdWhTwFeQuiD6vWsggDKr/VKuk5TkVBh1
         vvs0ab43ETbmbosc/J7Bi9mw4zdA8fFwvuVbnnIlgIp2m/IC+dvsFMPfhtAss0C3NP
         op+zHYxYy9teNSuJJ7o4v/FbB/fTd5JTJzxmhy483yaG2AHe1wjwjFiFDYTu9ay0aY
         0XsH5j9vpo/8yhDZ2vU6nboZX45PhURDj6g+GMpz4RX0ZfuVV1wXUDK0HqXXYYhmXI
         42tnu1E3/wbjpS62KSYru0bHVa6SijfNAVDsBa96EiGMeEC5Zu2SzA+v164JpUzViA
         skDrUVrKSTMOw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5QCa0A04104316;
        Wed, 26 Jun 2019 05:36:00 -0700
Date:   Wed, 26 Jun 2019 05:36:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Catalin Marinas <tipbot@zytor.com>
Message-ID: <tip-6a5b78b32d10cd7901f639870eca304b270769f9@git.kernel.org>
Cc:     will.deacon@arm.com, linux-kernel@vger.kernel.org,
        huw@codeweavers.com, vincenzo.frascino@arm.com, shuah@kernel.org,
        linux@armlinux.org.uk, paul.burton@mips.com, arnd@arndb.de,
        pcc@google.com, andre.przywara@arm.com, tglx@linutronix.de,
        ralf@linux-mips.org, linux@rasmusvillemoes.dk,
        daniel.lezcano@linaro.org, mingo@kernel.org, sthotton@marvell.com,
        salyzyn@android.com, catalin.marinas@arm.com, hpa@zytor.com,
        0x7f454c46@gmail.com
Reply-To: huw@codeweavers.com, linux-kernel@vger.kernel.org,
          vincenzo.frascino@arm.com, shuah@kernel.org, will.deacon@arm.com,
          andre.przywara@arm.com, paul.burton@mips.com, arnd@arndb.de,
          pcc@google.com, linux@armlinux.org.uk, ralf@linux-mips.org,
          linux@rasmusvillemoes.dk, tglx@linutronix.de,
          catalin.marinas@arm.com, salyzyn@android.com,
          0x7f454c46@gmail.com, hpa@zytor.com, sthotton@marvell.com,
          mingo@kernel.org, daniel.lezcano@linaro.org
In-Reply-To: <20190624140018.GD29120@arrakis.emea.arm.com>
References: <20190624140018.GD29120@arrakis.emea.arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] arm64: compat: No need for pre-ARMv7 barriers on
 an ARMv8 system
Git-Commit-ID: 6a5b78b32d10cd7901f639870eca304b270769f9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6a5b78b32d10cd7901f639870eca304b270769f9
Gitweb:     https://git.kernel.org/tip/6a5b78b32d10cd7901f639870eca304b270769f9
Author:     Catalin Marinas <catalin.marinas@arm.com>
AuthorDate: Mon, 24 Jun 2019 15:00:19 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 07:28:10 +0200

arm64: compat: No need for pre-ARMv7 barriers on an ARMv8 system

Remove the deprecated (pre-ARMv7) compat barriers as they would not be used
on an ARMv8 system.

Fixes: a7f71a2c8903 ("arm64: compat: Add vDSO")
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mark Salyzyn <salyzyn@android.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Huw Davies <huw@codeweavers.com>
Cc: Shijith Thotton <sthotton@marvell.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Link: https://lkml.kernel.org/r/20190624140018.GD29120@arrakis.emea.arm.com

---
 arch/arm64/include/asm/vdso/compat_barrier.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/compat_barrier.h b/arch/arm64/include/asm/vdso/compat_barrier.h
index ea24ea856b07..fb60a88b5ed4 100644
--- a/arch/arm64/include/asm/vdso/compat_barrier.h
+++ b/arch/arm64/include/asm/vdso/compat_barrier.h
@@ -18,14 +18,7 @@
 #undef dmb
 #endif
 
-#if __LINUX_ARM_ARCH__ >= 7
 #define dmb(option) __asm__ __volatile__ ("dmb " #option : : : "memory")
-#elif __LINUX_ARM_ARCH__ == 6
-#define dmb(x) __asm__ __volatile__ ("mcr p15, 0, %0, c7, c10, 5" \
-				    : : "r" (0) : "memory")
-#else
-#define dmb(x) __asm__ __volatile__ ("" : : : "memory")
-#endif
 
 #if __LINUX_ARM_ARCH__ >= 8
 #define aarch32_smp_mb()	dmb(ish)
