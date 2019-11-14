Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691C3C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47732206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfKNPAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:00:05 -0500
Received: from foss.arm.com ([217.140.110.172]:44630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfKNPAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:00:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4107328;
        Thu, 14 Nov 2019 07:00:01 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B5F243F52E;
        Thu, 14 Nov 2019 07:00:00 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, james.morse@arm.com, will@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org,
        suzuki.poulose@arm.com
Subject: [PATCH 3/5] arm64: Workaround Cortex-A77 erratum 1542418 on boot due to kexec
Date:   Thu, 14 Nov 2019 14:59:16 +0000
Message-Id: <20191114145918.235339-4-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191114145918.235339-1-suzuki.poulose@arm.com>
References: <20191114145918.235339-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

Kexec allows us to inherit dirty ASIDs from a previous kernel. We can't
wait until the next ASID rollover to cleanup, do it early as part of
the cpu-errata's enable callback.

This extends __arm64_workaround_1542418_asid_rollover() to put everything
back as it was.

Signed-off-by: James Morse <james.morse@arm.com>
[ skip CPUs not affected, refactor cpu_enable callback ]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/mmu_context.h |  1 +
 arch/arm64/kernel/cpu_errata.c       | 14 ++++++++++++++
 arch/arm64/mm/context.c              | 17 +++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 3827ff4040a3..434a5c661d78 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -247,6 +247,7 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
 void verify_cpu_asid_bits(void);
 void post_ttbr_update_workaround(void);
+void arm64_workaround_1542418_asid_rollover(void);
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index a66d433d0113..4656157ffa36 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -12,6 +12,7 @@
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/cpufeature.h>
+#include <asm/mmu_context.h>
 #include <asm/smp_plat.h>
 
 static bool __maybe_unused
@@ -650,6 +651,18 @@ needs_tx2_tvm_workaround(const struct arm64_cpu_capabilities *entry,
 	return false;
 }
 
+#ifdef CONFIG_ARM64_ERRATUM_1542418
+static void run_workaround_1542418_asid_rollover(const struct arm64_cpu_capabilities *c)
+{
+	/*
+	 * If this CPU is affected by the erratum, run the workaround
+	 * to protect us in case we are running on a kexec'ed kernel.
+	 */
+	if (c->matches(c, SCOPE_LOCAL_CPU))
+		arm64_workaround_1542418_asid_rollover();
+}
+#endif
+
 #ifdef CONFIG_HARDEN_EL2_VECTORS
 
 static const struct midr_range arm64_harden_el2_vectors[] = {
@@ -932,6 +945,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.desc = "ARM erratum 1542418",
 		.capability = ARM64_WORKAROUND_1542418,
 		ERRATA_MIDR_RANGE(MIDR_CORTEX_A77, 0, 0, 1, 0),
+		.cpu_enable = run_workaround_1542418_asid_rollover,
 	},
 #endif
 	{
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index ae3ee8e101d6..ad4e78bb68ed 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -129,6 +129,23 @@ static void __arm64_workaround_1542418_asid_rollover(void)
 	 */
 }
 
+void arm64_workaround_1542418_asid_rollover(void)
+{
+	u64 ttbr0 = read_sysreg(ttbr0_el1);
+
+	lockdep_assert_irqs_disabled();
+
+	/* Mirror check_and_switch_context() */
+	if (system_supports_cnp())
+		cpu_set_reserved_ttbr0();
+
+	__arm64_workaround_1542418_asid_rollover();
+	isb();
+
+	write_sysreg(ttbr0, ttbr0_el1);
+	isb();
+}
+
 static void flush_context(void)
 {
 	int i;
-- 
2.23.0

