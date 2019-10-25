Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55359CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2837D2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505824AbfJYRL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 13:11:56 -0400
Received: from foss.arm.com ([217.140.110.172]:43494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502873AbfJYRLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 13:11:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09FEE328;
        Fri, 25 Oct 2019 10:11:02 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06E883F71A;
        Fri, 25 Oct 2019 10:11:00 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     will@kernel.org, catalin.marinas@arm.com, suzuki.poulose@arm.com,
        Dave.Martin@arm.com, Julien Grall <julien.grall@arm.com>
Subject: [PATCH] arm64: cpufeature: Export Armv8.6 Matrix feature to userspace
Date:   Fri, 25 Oct 2019 18:10:56 +0100
Message-Id: <20191025171056.30641-1-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides support for reporting the presence of Armv8.6
Matrix and its optional features to userspace.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---

This based on [1] + commit ec52c7134b1f "arm64: cpufeature: Treat
ID_AA64ZFR0_EL1 as RAZ when SVE is not enabled" (taken from v5.4-rc4).

[1]  arm64/for-next/elf-hwcap-docs
---
 Documentation/arm64/cpu-feature-registers.rst |  8 ++++++++
 Documentation/arm64/elf_hwcaps.rst            | 15 +++++++++++++++
 arch/arm64/include/asm/hwcap.h                |  4 ++++
 arch/arm64/include/asm/sysreg.h               |  7 +++++++
 arch/arm64/include/uapi/asm/hwcap.h           |  4 ++++
 arch/arm64/kernel/cpufeature.c                | 11 +++++++++++
 arch/arm64/kernel/cpuinfo.c                   |  4 ++++
 7 files changed, 53 insertions(+)

diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
index ffcf4e2c71ef..d1d6d56a7b08 100644
--- a/Documentation/arm64/cpu-feature-registers.rst
+++ b/Documentation/arm64/cpu-feature-registers.rst
@@ -193,6 +193,8 @@ infrastructure:
      +------------------------------+---------+---------+
      | Name                         |  bits   | visible |
      +------------------------------+---------+---------+
+     | I8MM                         | [52-55] |    y    |
+     +------------------------------+---------+---------+
      | SB                           | [36-39] |    y    |
      +------------------------------+---------+---------+
      | FRINTTS                      | [32-35] |    y    |
@@ -227,6 +229,12 @@ infrastructure:
      +------------------------------+---------+---------+
      | Name                         |  bits   | visible |
      +------------------------------+---------+---------+
+     | F64MM                        | [56-59] |    y    |
+     +------------------------------+---------+---------+
+     | F32MM                        | [52-55] |    y    |
+     +------------------------------+---------+---------+
+     | I8MM                         | [44-47] |    y    |
+     +------------------------------+---------+---------+
      | SM4                          | [43-40] |    y    |
      +------------------------------+---------+---------+
      | SHA3                         | [35-32] |    y    |
diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index 7fa3d215ae6a..b2bcc6868f4a 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -204,6 +204,21 @@ HWCAP2_FRINT
 
     Functionality implied by ID_AA64ISAR1_EL1.FRINTTS == 0b0001.
 
+HWCAP2_SVEI8MM
+
+    Functionality implied by ID_AA64ZFR0_EL1.I8MM == 0b0001.
+
+HWCAP2_SVEF32MM
+
+    Functionality implied by ID_AA64ZFR0_EL1.F32MM == 0b0001.
+
+HWCAP2_SVEF64MM
+
+    Functionality implied by ID_AA64ZFR0_EL1.F64MM == 0b0001.
+
+HWCAP2_I8MM
+
+    Functionality implied by ID_AA64ISAR1_EL1.I8MM == 0b0001.
 
 4. Unused AT_HWCAP bits
 -----------------------
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 3d2f2472a36c..99dc0e08b4d3 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -86,6 +86,10 @@
 #define KERNEL_HWCAP_SVESM4		__khwcap2_feature(SVESM4)
 #define KERNEL_HWCAP_FLAGM2		__khwcap2_feature(FLAGM2)
 #define KERNEL_HWCAP_FRINT		__khwcap2_feature(FRINT)
+#define KERNEL_HWCAP_SVEI8MM		__khwcap2_feature(SVEI8MM)
+#define KERNEL_HWCAP_SVEF32MM		__khwcap2_feature(SVEF32MM)
+#define KERNEL_HWCAP_SVEF64MM		__khwcap2_feature(SVEF64MM)
+#define KERNEL_HWCAP_I8MM		__khwcap2_feature(I8MM)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 972d196c7714..35b27a9620ef 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -553,6 +553,7 @@
 #define ID_AA64ISAR0_AES_SHIFT		4
 
 /* id_aa64isar1 */
+#define ID_AA64ISAR1_I8MM_SHIFT		52
 #define ID_AA64ISAR1_SB_SHIFT		36
 #define ID_AA64ISAR1_FRINTTS_SHIFT	32
 #define ID_AA64ISAR1_GPI_SHIFT		28
@@ -605,12 +606,18 @@
 #define ID_AA64PFR1_SSBS_PSTATE_INSNS	2
 
 /* id_aa64zfr0 */
+#define ID_AA64ZFR0_F64MM_SHIFT		56
+#define ID_AA64ZFR0_F32MM_SHIFT		52
+#define ID_AA64ZFR0_I8MM_SHIFT		44
 #define ID_AA64ZFR0_SM4_SHIFT		40
 #define ID_AA64ZFR0_SHA3_SHIFT		32
 #define ID_AA64ZFR0_BITPERM_SHIFT	16
 #define ID_AA64ZFR0_AES_SHIFT		4
 #define ID_AA64ZFR0_SVEVER_SHIFT	0
 
+#define ID_AA64ZFR0_F64MM		0x1
+#define ID_AA64ZFR0_F32MM		0x1
+#define ID_AA64ZFR0_I8MM		0x1
 #define ID_AA64ZFR0_SM4			0x1
 #define ID_AA64ZFR0_SHA3		0x1
 #define ID_AA64ZFR0_BITPERM		0x1
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index a1e72886b30c..10f207b81091 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -65,5 +65,9 @@
 #define HWCAP2_SVESM4		(1 << 6)
 #define HWCAP2_FLAGM2		(1 << 7)
 #define HWCAP2_FRINT		(1 << 8)
+#define HWCAP2_SVEI8MM		(1 << 9)
+#define HWCAP2_SVEF32MM		(1 << 10)
+#define HWCAP2_SVEF64MM		(1 << 11)
+#define HWCAP2_I8MM		(1 << 12)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 80f459ad0190..6d196c66f80d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -135,6 +135,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_I8MM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_SB_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_FRINTTS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
@@ -177,6 +178,12 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
 
 static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
+		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_F64MM_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
+		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_F32MM_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
+		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_I8MM_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_SM4_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_SHA3_SHIFT, 4, 0),
@@ -1650,6 +1657,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_LRCPC_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, KERNEL_HWCAP_ILRCPC),
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_FRINTTS_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_FRINT),
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_SB_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SB),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_I8MM_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_I8MM),
 	HWCAP_CAP(SYS_ID_AA64MMFR2_EL1, ID_AA64MMFR2_AT_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_USCAT),
 #ifdef CONFIG_ARM64_SVE
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_SVE_SHIFT, FTR_UNSIGNED, ID_AA64PFR0_SVE, CAP_HWCAP, KERNEL_HWCAP_SVE),
@@ -1659,6 +1667,9 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_BITPERM_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_BITPERM, CAP_HWCAP, KERNEL_HWCAP_SVEBITPERM),
 	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_SHA3_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_SHA3, CAP_HWCAP, KERNEL_HWCAP_SVESHA3),
 	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_SM4_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_SM4, CAP_HWCAP, KERNEL_HWCAP_SVESM4),
+	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_I8MM_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_I8MM, CAP_HWCAP, KERNEL_HWCAP_SVEI8MM),
+	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_F32MM_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_F32MM, CAP_HWCAP, KERNEL_HWCAP_SVEF32MM),
+	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_F64MM_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_F64MM, CAP_HWCAP, KERNEL_HWCAP_SVEF64MM),
 #endif
 	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_SSBS_SHIFT, FTR_UNSIGNED, ID_AA64PFR1_SSBS_PSTATE_INSNS, CAP_HWCAP, KERNEL_HWCAP_SSBS),
 #ifdef CONFIG_ARM64_PTR_AUTH
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 05933c065732..ae76c794bd09 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -84,6 +84,10 @@ static const char *const hwcap_str[] = {
 	"svesm4",
 	"flagm2",
 	"frint",
+	"svei8mm",
+	"svef32mm",
+	"svef64mm",
+	"i8mm",
 	NULL
 };
 
-- 
2.11.0

