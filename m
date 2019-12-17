Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14925C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97E124687
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfLQSeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:34:24 -0500
Received: from foss.arm.com ([217.140.110.172]:44770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbfLQSeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:34:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F384330E;
        Tue, 17 Dec 2019 10:34:19 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A6283F67D;
        Tue, 17 Dec 2019 10:34:18 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, maz@kernel.org,
        mark.rutland@arm.com, dave.martin@arm.com, catalin.marinas@arm.com,
        ard.biesheuvel@linaro.org, christoffer.dall@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 2/7] arm64: fpsimd: Make sure SVE setup is complete before SIMD is used
Date:   Tue, 17 Dec 2019 18:33:57 +0000
Message-Id: <20191217183402.2259904-3-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217183402.2259904-1-suzuki.poulose@arm.com>
References: <20191217183402.2259904-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In-kernel users of NEON rely on may_use_simd() to check if the SIMD
can be used. However, we must initialize the SVE before SIMD can
be used. Add a sanity check to make sure that we have completed the
SVE setup before anyone uses the SIMD.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Discussion here : https://lkml.kernel.org/r/20191014145204.GS27757@arm.com
---
 arch/arm64/include/asm/simd.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
index 7434844036d3..afce6409be51 100644
--- a/arch/arm64/include/asm/simd.h
+++ b/arch/arm64/include/asm/simd.h
@@ -26,6 +26,8 @@ DECLARE_PER_CPU(bool, fpsimd_context_busy);
 static __must_check inline bool may_use_simd(void)
 {
 	/*
+	 * We must make sure that the SVE has been initialized properly
+	 * before using the SIMD in kernel.
 	 * fpsimd_context_busy is only set while preemption is disabled,
 	 * and is clear whenever preemption is enabled. Since
 	 * this_cpu_read() is atomic w.r.t. preemption, fpsimd_context_busy
@@ -33,8 +35,10 @@ static __must_check inline bool may_use_simd(void)
 	 * migrated, and if it's clear we cannot be migrated to a CPU
 	 * where it is set.
 	 */
-	return !in_irq() && !irqs_disabled() && !in_nmi() &&
-		!this_cpu_read(fpsimd_context_busy);
+	return system_capabilities_finalized() &&
+	       system_supports_fpsimd() &&
+	       !in_irq() && !irqs_disabled() && !in_nmi() &&
+	       !this_cpu_read(fpsimd_context_busy);
 }
 
 #else /* ! CONFIG_KERNEL_MODE_NEON */
-- 
2.23.0

