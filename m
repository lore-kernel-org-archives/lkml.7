Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB77BC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D4D21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfJBOmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:42:18 -0400
Received: from foss.arm.com ([217.140.110.172]:45800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728302AbfJBOmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:42:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DA671684;
        Wed,  2 Oct 2019 07:42:15 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8A5F3F706;
        Wed,  2 Oct 2019 07:42:13 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     vincenzo.frascino@arm.com, ard.biesheuvel@linaro.org,
        ndesaulniers@google.com, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, luto@kernel.org
Subject: [PATCH v4 5/6] arm64: Remove vdso_datapage.h
Date:   Wed,  2 Oct 2019 15:41:55 +0100
Message-Id: <20191002144156.2174-6-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002144156.2174-1-vincenzo.frascino@arm.com>
References: <20191002144156.2174-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vdso_datapage.h  was originally removed with the introduction of the
support for Unified vDSOs in arm64 and replaced with the C
implementation.

The file seems again present in the repository due to a side effect of
rebase.

Remove the file again.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/vdso_datapage.h | 33 --------------------------
 1 file changed, 33 deletions(-)
 delete mode 100644 arch/arm64/include/asm/vdso_datapage.h

diff --git a/arch/arm64/include/asm/vdso_datapage.h b/arch/arm64/include/asm/vdso_datapage.h
deleted file mode 100644
index 1f38bf330a6e..000000000000
--- a/arch/arm64/include/asm/vdso_datapage.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2012 ARM Limited
- */
-#ifndef __ASM_VDSO_DATAPAGE_H
-#define __ASM_VDSO_DATAPAGE_H
-
-#ifndef __ASSEMBLY__
-
-struct vdso_data {
-	__u64 cs_cycle_last;	/* Timebase at clocksource init */
-	__u64 raw_time_sec;	/* Raw time */
-	__u64 raw_time_nsec;
-	__u64 xtime_clock_sec;	/* Kernel time */
-	__u64 xtime_clock_nsec;
-	__u64 xtime_coarse_sec;	/* Coarse time */
-	__u64 xtime_coarse_nsec;
-	__u64 wtm_clock_sec;	/* Wall to monotonic time */
-	__u64 wtm_clock_nsec;
-	__u32 tb_seq_count;	/* Timebase sequence counter */
-	/* cs_* members must be adjacent and in this order (ldp accesses) */
-	__u32 cs_mono_mult;	/* NTP-adjusted clocksource multiplier */
-	__u32 cs_shift;		/* Clocksource shift (mono = raw) */
-	__u32 cs_raw_mult;	/* Raw clocksource multiplier */
-	__u32 tz_minuteswest;	/* Whacky timezone stuff */
-	__u32 tz_dsttime;
-	__u32 use_syscall;
-	__u32 hrtimer_res;
-};
-
-#endif /* !__ASSEMBLY__ */
-
-#endif /* __ASM_VDSO_DATAPAGE_H */
-- 
2.23.0

