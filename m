Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFB9C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547AF22B48
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfLLKGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:06:43 -0500
Received: from foss.arm.com ([217.140.110.172]:40748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728302AbfLLKGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:06:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41F39328;
        Thu, 12 Dec 2019 02:06:42 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 343F13F6CF;
        Thu, 12 Dec 2019 02:06:35 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/elf_hwcap: Add new flags for BFloat-16 extension
Date:   Thu, 12 Dec 2019 15:37:12 +0530
Message-Id: <1576145232-8311-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the availability of the BFloat16 (BF16) format support in the CPUs.
BF16 is a new 16-bit floating point format different from the half
precision format defined by the IEEE-754-2008.

BF16 extensions add support for new instructions for both FP/SIMD and SVE.
Advertise these features individually to the userspace via ELF HWCAP.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/arm64/elf_hwcaps.rst  | 7 +++++++
 arch/arm64/include/asm/hwcap.h      | 2 ++
 arch/arm64/include/asm/sysreg.h     | 4 ++++
 arch/arm64/include/uapi/asm/hwcap.h | 2 ++
 arch/arm64/kernel/cpufeature.c      | 5 +++++
 arch/arm64/kernel/cpuinfo.c         | 2 ++
 6 files changed, 22 insertions(+)

diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
index 7fa3d21..776b2fe 100644
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -204,6 +204,13 @@ HWCAP2_FRINT
 
     Functionality implied by ID_AA64ISAR1_EL1.FRINTTS == 0b0001.
 
+HWCAP2_BF16
+
+    Functionality implied by ID_AA64ISAR1_EL1.BF16 == 0b0001.
+
+HWCAP2_SVEBF16
+
+    Functionality implied by ID_AA64ZFR0_EL1.BF16 == 0b0001.
 
 4. Unused AT_HWCAP bits
 -----------------------
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 3d2f247..bd8bf48 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -86,6 +86,8 @@
 #define KERNEL_HWCAP_SVESM4		__khwcap2_feature(SVESM4)
 #define KERNEL_HWCAP_FLAGM2		__khwcap2_feature(FLAGM2)
 #define KERNEL_HWCAP_FRINT		__khwcap2_feature(FRINT)
+#define KERNEL_HWCAP_BF16		__khwcap2_feature(BF16)
+#define KERNEL_HWCAP_SVEBF16		__khwcap2_feature(SVEBF16)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6e919fa..6db3a9b 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -553,6 +553,7 @@
 #define ID_AA64ISAR0_AES_SHIFT		4
 
 /* id_aa64isar1 */
+#define ID_AA64ISAR1_BF16_SHIFT		44
 #define ID_AA64ISAR1_SB_SHIFT		36
 #define ID_AA64ISAR1_FRINTTS_SHIFT	32
 #define ID_AA64ISAR1_GPI_SHIFT		28
@@ -564,6 +565,7 @@
 #define ID_AA64ISAR1_APA_SHIFT		4
 #define ID_AA64ISAR1_DPB_SHIFT		0
 
+#define ID_AA64ISAR1_BF16		0x1
 #define ID_AA64ISAR1_APA_NI		0x0
 #define ID_AA64ISAR1_APA_ARCHITECTED	0x1
 #define ID_AA64ISAR1_API_NI		0x0
@@ -607,12 +609,14 @@
 /* id_aa64zfr0 */
 #define ID_AA64ZFR0_SM4_SHIFT		40
 #define ID_AA64ZFR0_SHA3_SHIFT		32
+#define ID_AA64ZFR0_BF16_SHIFT		20
 #define ID_AA64ZFR0_BITPERM_SHIFT	16
 #define ID_AA64ZFR0_AES_SHIFT		4
 #define ID_AA64ZFR0_SVEVER_SHIFT	0
 
 #define ID_AA64ZFR0_SM4			0x1
 #define ID_AA64ZFR0_SHA3		0x1
+#define ID_AA64ZFR0_BF16		0x1
 #define ID_AA64ZFR0_BITPERM		0x1
 #define ID_AA64ZFR0_AES			0x1
 #define ID_AA64ZFR0_AES_PMULL		0x2
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index a1e72886..095090c 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -65,5 +65,7 @@
 #define HWCAP2_SVESM4		(1 << 6)
 #define HWCAP2_FLAGM2		(1 << 7)
 #define HWCAP2_FRINT		(1 << 8)
+#define HWCAP2_BF16		(1 << 9)
+#define HWCAP2_SVEBF16		(1 << 10)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 04cf64e..f344cea 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -149,6 +149,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_APA_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_DPB_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_BF16_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
@@ -186,6 +187,8 @@ static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_AES_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_SVEVER_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SVE),
+		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ZFR0_BF16_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
@@ -1652,6 +1655,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_FRINTTS_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_FRINT),
 	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_SB_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SB),
 	HWCAP_CAP(SYS_ID_AA64MMFR2_EL1, ID_AA64MMFR2_AT_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_USCAT),
+	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_BF16_SHIFT, FTR_UNSIGNED, ID_AA64ISAR1_BF16, CAP_HWCAP, KERNEL_HWCAP_BF16),
 #ifdef CONFIG_ARM64_SVE
 	HWCAP_CAP(SYS_ID_AA64PFR0_EL1, ID_AA64PFR0_SVE_SHIFT, FTR_UNSIGNED, ID_AA64PFR0_SVE, CAP_HWCAP, KERNEL_HWCAP_SVE),
 	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_SVEVER_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_SVEVER_SVE2, CAP_HWCAP, KERNEL_HWCAP_SVE2),
@@ -1660,6 +1664,7 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_BITPERM_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_BITPERM, CAP_HWCAP, KERNEL_HWCAP_SVEBITPERM),
 	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_SHA3_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_SHA3, CAP_HWCAP, KERNEL_HWCAP_SVESHA3),
 	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_SM4_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_SM4, CAP_HWCAP, KERNEL_HWCAP_SVESM4),
+	HWCAP_CAP(SYS_ID_AA64ZFR0_EL1, ID_AA64ZFR0_BF16_SHIFT, FTR_UNSIGNED, ID_AA64ZFR0_BF16, CAP_HWCAP, KERNEL_HWCAP_SVEBF16),
 #endif
 	HWCAP_CAP(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_SSBS_SHIFT, FTR_UNSIGNED, ID_AA64PFR1_SSBS_PSTATE_INSNS, CAP_HWCAP, KERNEL_HWCAP_SSBS),
 #ifdef CONFIG_ARM64_PTR_AUTH
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 56bba74..10121f5 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -84,6 +84,8 @@ static const char *const hwcap_str[] = {
 	"svesm4",
 	"flagm2",
 	"frint",
+	"bf16",
+	"svebf16",
 	NULL
 };
 
-- 
2.7.4

