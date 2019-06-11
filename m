Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41043C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233DB2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 09:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405046AbfFKJis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:38:48 -0400
Received: from foss.arm.com ([217.140.110.172]:56388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404990AbfFKJic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:38:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C8ECED1;
        Tue, 11 Jun 2019 02:38:32 -0700 (PDT)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DDBBB3F73C;
        Tue, 11 Jun 2019 02:38:30 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        marc.zyngier@arm.com, yuzenghui@huawei.com,
        wanghaibin.wang@huawei.com, james.morse@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        liwei391@huawei.com, Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v4 6/8] arm64: irqflags: Introduce explicit debugging for IRQ priorities
Date:   Tue, 11 Jun 2019 10:38:11 +0100
Message-Id: <1560245893-46998-7-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560245893-46998-1-git-send-email-julien.thierry@arm.com>
References: <1560245893-46998-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using IRQ priority masking to enable/disable interrupts is a bit
sensitive as it requires to deal with both ICC_PMR_EL1 and PSR.I.

Introduce some validity checks to both highlight the states in which
functions dealing with IRQ enabling/disabling can (not) be called, and
bark a warning when called in an unexpected state.

Since these checks are done on hotpaths, introduce a build option to
choose whether to do the checking.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                  | 11 +++++++++++
 arch/arm64/include/asm/cpufeature.h |  6 ++++++
 arch/arm64/include/asm/daifflags.h  |  7 +++++++
 arch/arm64/include/asm/irqflags.h   | 12 ++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 697ea05..8acc40e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1436,6 +1436,17 @@ config ARM64_PSEUDO_NMI

 	  If unsure, say N

+if ARM64_PSEUDO_NMI
+config ARM64_DEBUG_PRIORITY_MASKING
+	bool "Debug interrupt priority masking"
+	help
+	  This adds runtime checks to functions enabling/disabling
+	  interrupts when using priority masking. The additional checks verify
+	  the validity of ICC_PMR_EL1 when calling concerned functions.
+
+	  If unsure, say N
+endif
+
 config RELOCATABLE
 	bool
 	help
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index bc895c8..693a086 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -617,6 +617,12 @@ static inline bool system_uses_irq_prio_masking(void)
 	       cpus_have_const_cap(ARM64_HAS_IRQ_PRIO_MASKING);
 }

+static inline bool system_has_prio_mask_debugging(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_DEBUG_PRIORITY_MASKING) &&
+	       system_uses_irq_prio_masking();
+}
+
 #define ARM64_SSBD_UNKNOWN		-1
 #define ARM64_SSBD_FORCE_DISABLE	0
 #define ARM64_SSBD_KERNEL		1
diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index f93204f..eca5bee 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -28,6 +28,10 @@
 /* mask/save/unmask/restore all exceptions, including interrupts. */
 static inline void local_daif_mask(void)
 {
+	WARN_ON(system_has_prio_mask_debugging() &&
+		(read_sysreg_s(SYS_ICC_PMR_EL1) == (GIC_PRIO_IRQOFF |
+						    GIC_PRIO_PSR_I_SET)));
+
 	asm volatile(
 		"msr	daifset, #0xf		// local_daif_mask\n"
 		:
@@ -62,6 +66,9 @@ static inline void local_daif_restore(unsigned long flags)
 {
 	bool irq_disabled = flags & PSR_I_BIT;

+	WARN_ON(system_has_prio_mask_debugging() &&
+		!(read_sysreg(daif) & PSR_I_BIT));
+
 	if (!irq_disabled) {
 		trace_hardirqs_on();

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index a137272..cac2d2a 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -40,6 +40,12 @@
  */
 static inline void arch_local_irq_enable(void)
 {
+	if (system_has_prio_mask_debugging()) {
+		u32 pmr = read_sysreg_s(SYS_ICC_PMR_EL1);
+
+		WARN_ON_ONCE(pmr != GIC_PRIO_IRQON && pmr != GIC_PRIO_IRQOFF);
+	}
+
 	asm volatile(ALTERNATIVE(
 		"msr	daifclr, #2		// arch_local_irq_enable\n"
 		"nop",
@@ -53,6 +59,12 @@ static inline void arch_local_irq_enable(void)

 static inline void arch_local_irq_disable(void)
 {
+	if (system_has_prio_mask_debugging()) {
+		u32 pmr = read_sysreg_s(SYS_ICC_PMR_EL1);
+
+		WARN_ON_ONCE(pmr != GIC_PRIO_IRQON && pmr != GIC_PRIO_IRQOFF);
+	}
+
 	asm volatile(ALTERNATIVE(
 		"msr	daifset, #2		// arch_local_irq_disable",
 		__msr_s(SYS_ICC_PMR_EL1, "%0"),
--
1.9.1
