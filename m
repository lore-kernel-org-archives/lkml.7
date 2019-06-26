Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CA6C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330482086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ktILwQSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfFZMfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:35:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33707 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfFZMfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:35:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5QCZEcw4104207
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 26 Jun 2019 05:35:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5QCZEcw4104207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561552515;
        bh=SZTf+2cdXAlpzE8KosxqlFWPqMPl1Kf9lyRbnACO8tM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ktILwQSx5F2uydn1wPTtnu3oyApzHJDTAUrVXgWybrsdTf1RdAH1U7IvO+Yua0dws
         FRTNVv1nfkZGmpdgyO+zi/bMOVvPkXYit+VOJIgQnOTU3AEGZAGNIKQsps7mB/STwT
         RTFxrAkobcVmPoAuODTikMQL5SupjqH0CtyYHd5zJW7X2kbXbuVrov36v4kzbhvUOc
         sQhgcionHP+CQs4o7iNnJm9ZUML0cJY1pNRcDLMGCKjJ/cXDQGvN9UaDIiI2goFwNP
         dfuOQdkMjYl1HB0nUDrGRcoxZ6ERUMiGvVSFVBRV9jPpGzCgYD+cyi/t6rfVukRBtH
         Ulw6c+Z7i00pA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5QCZDRs4104203;
        Wed, 26 Jun 2019 05:35:13 -0700
Date:   Wed, 26 Jun 2019 05:35:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Catalin Marinas <tipbot@zytor.com>
Message-ID: <tip-94fee4d43752b6022428d9de402632904968e15b@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        vincenzo.frascino@arm.com, paul.burton@mips.com,
        will.deacon@arm.com, andre.przywara@arm.com,
        catalin.marinas@arm.com, arnd@arndb.de, salyzyn@android.com,
        huw@codeweavers.com, sthotton@marvell.com,
        daniel.lezcano@linaro.org, linux@armlinux.org.uk,
        linux@rasmusvillemoes.dk, tglx@linutronix.de, 0x7f454c46@gmail.com,
        pcc@google.com, shuah@kernel.org, ralf@linux-mips.org
Reply-To: andre.przywara@arm.com, arnd@arndb.de, catalin.marinas@arm.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          vincenzo.frascino@arm.com, paul.burton@mips.com,
          will.deacon@arm.com, hpa@zytor.com, pcc@google.com,
          0x7f454c46@gmail.com, shuah@kernel.org, ralf@linux-mips.org,
          sthotton@marvell.com, salyzyn@android.com, huw@codeweavers.com,
          tglx@linutronix.de, linux@rasmusvillemoes.dk,
          daniel.lezcano@linaro.org, linux@armlinux.org.uk
In-Reply-To: <20190624135812.GC29120@arrakis.emea.arm.com>
References: <20190624135812.GC29120@arrakis.emea.arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] arm64: vdso: Remove unnecessary asm-offsets.c
 definitions
Git-Commit-ID: 94fee4d43752b6022428d9de402632904968e15b
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

Commit-ID:  94fee4d43752b6022428d9de402632904968e15b
Gitweb:     https://git.kernel.org/tip/94fee4d43752b6022428d9de402632904968e15b
Author:     Catalin Marinas <catalin.marinas@arm.com>
AuthorDate: Mon, 24 Jun 2019 14:58:12 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 07:28:10 +0200

arm64: vdso: Remove unnecessary asm-offsets.c definitions

Since the VDSO code has moved to C from assembly, there is no need to
define and maintain the corresponding asm offsets.

Fixes: 28b1a824a4f4 ("arm64: vdso: Substitute gettimeofday() with C implementation")
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
Link: https://lkml.kernel.org/r/20190624135812.GC29120@arrakis.emea.arm.com

---
 arch/arm64/kernel/asm-offsets.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index e6f7409a78a4..214685760e1c 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -14,7 +14,6 @@
 #include <linux/kvm_host.h>
 #include <linux/preempt.h>
 #include <linux/suspend.h>
-#include <vdso/datapage.h>
 #include <asm/cpufeature.h>
 #include <asm/fixmap.h>
 #include <asm/thread_info.h>
@@ -86,44 +85,6 @@ int main(void)
   BLANK();
   DEFINE(PREEMPT_DISABLE_OFFSET, PREEMPT_DISABLE_OFFSET);
   BLANK();
-  DEFINE(CLOCK_REALTIME,	CLOCK_REALTIME);
-  DEFINE(CLOCK_MONOTONIC,	CLOCK_MONOTONIC);
-  DEFINE(CLOCK_MONOTONIC_RAW,	CLOCK_MONOTONIC_RAW);
-  DEFINE(CLOCK_REALTIME_RES,	offsetof(struct vdso_data, hrtimer_res));
-  DEFINE(CLOCK_REALTIME_COARSE,	CLOCK_REALTIME_COARSE);
-  DEFINE(CLOCK_MONOTONIC_COARSE,CLOCK_MONOTONIC_COARSE);
-  DEFINE(CLOCK_COARSE_RES,	LOW_RES_NSEC);
-  DEFINE(NSEC_PER_SEC,		NSEC_PER_SEC);
-  BLANK();
-  DEFINE(VDSO_SEQ,		offsetof(struct vdso_data, seq));
-  DEFINE(VDSO_CLK_MODE,		offsetof(struct vdso_data, clock_mode));
-  DEFINE(VDSO_CYCLE_LAST,	offsetof(struct vdso_data, cycle_last));
-  DEFINE(VDSO_MASK,		offsetof(struct vdso_data, mask));
-  DEFINE(VDSO_MULT,		offsetof(struct vdso_data, mult));
-  DEFINE(VDSO_SHIFT,		offsetof(struct vdso_data, shift));
-  DEFINE(VDSO_REALTIME_SEC,	offsetof(struct vdso_data, basetime[CLOCK_REALTIME].sec));
-  DEFINE(VDSO_REALTIME_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_REALTIME].nsec));
-  DEFINE(VDSO_MONO_SEC,		offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC].sec));
-  DEFINE(VDSO_MONO_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC].nsec));
-  DEFINE(VDSO_MONO_RAW_SEC,	offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC_RAW].sec));
-  DEFINE(VDSO_MONO_RAW_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC_RAW].nsec));
-  DEFINE(VDSO_BOOTTIME_SEC,	offsetof(struct vdso_data, basetime[CLOCK_BOOTTIME].sec));
-  DEFINE(VDSO_BOOTTIME_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_BOOTTIME].nsec));
-  DEFINE(VDSO_TAI_SEC,		offsetof(struct vdso_data, basetime[CLOCK_TAI].sec));
-  DEFINE(VDSO_TAI_NSEC,		offsetof(struct vdso_data, basetime[CLOCK_TAI].nsec));
-  DEFINE(VDSO_RT_COARSE_SEC,	offsetof(struct vdso_data, basetime[CLOCK_REALTIME_COARSE].sec));
-  DEFINE(VDSO_RT_COARSE_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_REALTIME_COARSE].nsec));
-  DEFINE(VDSO_MONO_COARSE_SEC,	offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC_COARSE].sec));
-  DEFINE(VDSO_MONO_COARSE_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC_COARSE].nsec));
-  DEFINE(VDSO_TZ_MINWEST,	offsetof(struct vdso_data, tz_minuteswest));
-  DEFINE(VDSO_TZ_DSTTIME,	offsetof(struct vdso_data, tz_dsttime));
-  BLANK();
-  DEFINE(TVAL_TV_SEC,		offsetof(struct timeval, tv_sec));
-  DEFINE(TSPEC_TV_SEC,		offsetof(struct timespec, tv_sec));
-  BLANK();
-  DEFINE(TZ_MINWEST,		offsetof(struct timezone, tz_minuteswest));
-  DEFINE(TZ_DSTTIME,		offsetof(struct timezone, tz_dsttime));
-  BLANK();
   DEFINE(CPU_BOOT_STACK,	offsetof(struct secondary_data, stack));
   DEFINE(CPU_BOOT_TASK,		offsetof(struct secondary_data, task));
   BLANK();
