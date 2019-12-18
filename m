Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAA8C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100F02465E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfLRS1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:27:02 -0500
Received: from foss.arm.com ([217.140.110.172]:56536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfLRS1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 13:27:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C64801FB;
        Wed, 18 Dec 2019 10:27:00 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E695A3F67D;
        Wed, 18 Dec 2019 10:26:58 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, ggherdovich@suse.cz,
        vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] arm64: add support for the AMU extension v1
Date:   Wed, 18 Dec 2019 18:26:02 +0000
Message-Id: <20191218182607.21607-2-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218182607.21607-1-ionela.voinescu@arm.com>
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The activity monitors extension is an optional extension introduced
by the ARMv8.4 CPU architecture. This implements basic support for
version 1 of the activity monitors architecture, AMUv1.

This support includes:
- Extension detection on each CPU (boot, secondary, hotplugged)
- Register interface for AMU aarch64 registers
- (while here) create defines for ID_PFR0_EL1 fields when adding
  the AMU field information.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/Kconfig                  | 27 ++++++++++
 arch/arm64/include/asm/cpucaps.h    |  3 +-
 arch/arm64/include/asm/cpufeature.h |  4 ++
 arch/arm64/include/asm/sysreg.h     | 44 ++++++++++++++++
 arch/arm64/kernel/cpufeature.c      | 81 +++++++++++++++++++++++++++--
 5 files changed, 154 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ac31ed6184d0..6ae7bfa5812e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1485,6 +1485,33 @@ config ARM64_PTR_AUTH
 
 endmenu
 
+menu "ARMv8.4 architectural features"
+
+config ARM64_AMU_EXTN
+	bool "Enable support for the Activity Monitors Unit CPU extension"
+	default y
+	help
+          The activity monitors extension is an optional extension introduced
+          by the ARMv8.4 CPU architecture. This enables support for version 1
+          of the activity monitors architecture, AMUv1.
+
+          To enable the use of this extension on CPUs that implement it, say Y.
+
+          Note that for architectural reasons, firmware _must_ implement AMU
+          support when running on CPUs that present the activity monitors
+          extension. The required support is present in:
+            * Version 1.5 and later of the ARM Trusted Firmware
+
+          For kernels that have this configuration enabled but boot with broken
+          firmware, you may need to say N here until the firmware is fixed.
+          Otherwise you may experience firmware panics or lockups when
+          accessing the counter registers. Even if you are not observing these
+          symptoms, the values returned by the register reads might not
+          correctly reflect reality. Most commonly, the value read will be 0,
+          indicating that the counter is not enabled.
+
+endmenu
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index b92683871119..7dde890bde50 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -56,7 +56,8 @@
 #define ARM64_WORKAROUND_CAVIUM_TX2_219_PRFM	46
 #define ARM64_WORKAROUND_1542419		47
 #define ARM64_WORKAROUND_1319367		48
+#define ARM64_HAS_AMU_EXTN			49
 
-#define ARM64_NCAPS				49
+#define ARM64_NCAPS				50
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 4261d55e8506..b89e799d6972 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -673,6 +673,10 @@ static inline bool cpu_has_hw_af(void)
 						ID_AA64MMFR1_HADBS_SHIFT);
 }
 
+#ifdef CONFIG_ARM64_AMU_EXTN
+extern inline bool cpu_has_amu_feat(void);
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6e919fafb43d..bfcc87953a68 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -382,6 +382,42 @@
 #define SYS_TPIDR_EL0			sys_reg(3, 3, 13, 0, 2)
 #define SYS_TPIDRRO_EL0			sys_reg(3, 3, 13, 0, 3)
 
+/* Definitions for system register interface to AMU for ARMv8.4 onwards */
+#define SYS_AM_EL0(crm, op2)		sys_reg(3, 3, 13, crm, op2)
+#define SYS_AMCR_EL0			SYS_AM_EL0(2, 0)
+#define SYS_AMCFGR_EL0			SYS_AM_EL0(2, 1)
+#define SYS_AMCGCR_EL0			SYS_AM_EL0(2, 2)
+#define SYS_AMUSERENR_EL0		SYS_AM_EL0(2, 3)
+#define SYS_AMCNTENCLR0_EL0		SYS_AM_EL0(2, 4)
+#define SYS_AMCNTENSET0_EL0		SYS_AM_EL0(2, 5)
+#define SYS_AMCNTENCLR1_EL0		SYS_AM_EL0(3, 0)
+#define SYS_AMCNTENSET1_EL0		SYS_AM_EL0(3, 1)
+
+/*
+ * Group 0 of activity monitors (architected):
+ *                op0 CRn   op1   op2     CRm
+ * Counter:       11  1101  011   n<2:0>  010:n<3>
+ * Type:          11  1101  011   n<2:0>  011:n<3>
+ * n: 0-3
+ *
+ * Group 1 of activity monitors (auxiliary):
+ *                op0 CRn   op1   op2     CRm
+ * Counter:       11  1101  011   n<2:0>  110:n<3>
+ * Type:          11  1101  011   n<2:0>  111:n<3>
+ * n: 0-15
+ */
+
+#define SYS_AMEVCNTR0_EL0(n)            SYS_AM_EL0(4 + ((n) >> 3), (n) & 0x7)
+#define SYS_AMEVTYPE0_EL0(n)            SYS_AM_EL0(6 + ((n) >> 3), (n) & 0x7)
+#define SYS_AMEVCNTR1_EL0(n)            SYS_AM_EL0(12 + ((n) >> 3), (n) & 0x7)
+#define SYS_AMEVTYPE1_EL0(n)            SYS_AM_EL0(14 + ((n) >> 3), (n) & 0x7)
+
+/* V1: Fixed (architecturally defined) activity monitors */
+#define SYS_AMEVCNTR0_CORE_EL0          SYS_AMEVCNTR0_EL0(0)
+#define SYS_AMEVCNTR0_CONST_EL0         SYS_AMEVCNTR0_EL0(1)
+#define SYS_AMEVCNTR0_INST_RET_EL0      SYS_AMEVCNTR0_EL0(2)
+#define SYS_AMEVCNTR0_MEM_STALL         SYS_AMEVCNTR0_EL0(3)
+
 #define SYS_CNTFRQ_EL0			sys_reg(3, 3, 14, 0, 0)
 
 #define SYS_CNTP_TVAL_EL0		sys_reg(3, 3, 14, 2, 0)
@@ -577,6 +613,7 @@
 #define ID_AA64PFR0_CSV3_SHIFT		60
 #define ID_AA64PFR0_CSV2_SHIFT		56
 #define ID_AA64PFR0_DIT_SHIFT		48
+#define ID_AA64PFR0_AMU_SHIFT		44
 #define ID_AA64PFR0_SVE_SHIFT		32
 #define ID_AA64PFR0_RAS_SHIFT		28
 #define ID_AA64PFR0_GIC_SHIFT		24
@@ -587,6 +624,7 @@
 #define ID_AA64PFR0_EL1_SHIFT		4
 #define ID_AA64PFR0_EL0_SHIFT		0
 
+#define ID_AA64PFR0_AMU			0x1
 #define ID_AA64PFR0_SVE			0x1
 #define ID_AA64PFR0_RAS_V1		0x1
 #define ID_AA64PFR0_FP_NI		0xf
@@ -709,6 +747,12 @@
 #define ID_AA64MMFR0_TGRAN16_NI		0x0
 #define ID_AA64MMFR0_TGRAN16_SUPPORTED	0x1
 
+#define ID_PFR0_AMU_SHIFT		20
+#define ID_PFR0_STATE3_SHIFT		12
+#define ID_PFR0_STATE2_SHIFT		8
+#define ID_PFR0_STATE1_SHIFT		4
+#define ID_PFR0_STATE0_SHIFT		0
+
 #if defined(CONFIG_ARM64_4K_PAGES)
 #define ID_AA64MMFR0_TGRAN_SHIFT	ID_AA64MMFR0_TGRAN4_SHIFT
 #define ID_AA64MMFR0_TGRAN_SUPPORTED	ID_AA64MMFR0_TGRAN4_SUPPORTED
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 04cf64e9f0c9..c639b3e052d7 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -156,6 +156,7 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_CSV3_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_CSV2_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_DIT_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_AMU_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
 				   FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_SVE_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_RAS_SHIFT, 4, 0),
@@ -314,10 +315,11 @@ static const struct arm64_ftr_bits ftr_id_mmfr4[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_pfr0[] = {
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 12, 4, 0),		/* State3 */
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 8, 4, 0),		/* State2 */
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 4, 4, 0),		/* State1 */
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),		/* State0 */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_AMU_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_STATE3_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_STATE2_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_STATE1_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_STATE0_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
@@ -1150,6 +1152,59 @@ static bool has_hw_dbm(const struct arm64_cpu_capabilities *cap,
 
 #endif
 
+#ifdef CONFIG_ARM64_AMU_EXTN
+
+/*
+ * This per cpu variable only signals that the CPU implementation supports
+ * the Activity Monitors Unit (AMU) but does not provide information
+ * regarding all the events that it supports.
+ * When this amu_feat per CPU variable is true, the user of this feature
+ * can only rely on the presence of the 4 fixed counters. But this does
+ * not guarantee that the counters are enabled or access to these counters
+ * is provided by code executed at higher exception levels.
+ *
+ * Also, to ensure the safe use of this per_cpu variable, the following
+ * accessor is defined to allow a read of amu_feat for the current cpu only
+ * from the current cpu.
+ *  - cpu_has_amu_feat()
+ */
+static DEFINE_PER_CPU_READ_MOSTLY(u8, amu_feat);
+
+inline bool cpu_has_amu_feat(void)
+{
+	return !!this_cpu_read(amu_feat);
+}
+
+static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
+{
+	if (has_cpuid_feature(cap, SCOPE_LOCAL_CPU)) {
+		pr_info("detected CPU%d: Activity Monitors Unit (AMU)\n",
+			smp_processor_id());
+		this_cpu_write(amu_feat, 1);
+	}
+}
+
+static bool has_amu(const struct arm64_cpu_capabilities *cap,
+		       int __unused)
+{
+	/*
+	 * The AMU extension is a non-conflicting feature: the kernel can
+	 * safely run a mix of CPUs with and without support for the
+	 * activity monitors extension.
+	 * Therefore, unconditionally enable the capability to allow
+	 * any late CPU to use the feature.
+	 *
+	 * With this feature unconditionally enabled, the cpu_enable
+	 * function will be called for all CPUs that match the criteria,
+	 * including secondary and hotplugged, marking this feature as
+	 * present on that respective CPU. The enable function will also
+	 * print a detection message.
+	 */
+
+	return true;
+}
+#endif
+
 #ifdef CONFIG_ARM64_VHE
 static bool runs_at_el2(const struct arm64_cpu_capabilities *entry, int __unused)
 {
@@ -1419,6 +1474,24 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.cpu_enable = cpu_clear_disr,
 	},
 #endif /* CONFIG_ARM64_RAS_EXTN */
+#ifdef CONFIG_ARM64_AMU_EXTN
+	{
+		/*
+		 * The feature is enabled by default if CONFIG_ARM64_AMU_EXTN=y.
+		 * Therefore, don't provide .desc as we don't want the detection
+		 * message to be shown until at least one CPU is detected to
+		 * support the feature.
+		 */
+		.capability = ARM64_HAS_AMU_EXTN,
+		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
+		.matches = has_amu,
+		.sys_reg = SYS_ID_AA64PFR0_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64PFR0_AMU_SHIFT,
+		.min_field_value = ID_AA64PFR0_AMU,
+		.cpu_enable = cpu_amu_enable,
+	},
+#endif /* CONFIG_ARM64_AMU_EXTN */
 	{
 		.desc = "Data cache clean to the PoU not required for I/D coherence",
 		.capability = ARM64_HAS_CACHE_IDC,
-- 
2.17.1

