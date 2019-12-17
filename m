Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD2BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103BD2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfLQOqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:46:40 -0500
Received: from foss.arm.com ([217.140.110.172]:39380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbfLQOqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:46:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD0901FB;
        Tue, 17 Dec 2019 06:46:39 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7BA513F67D;
        Tue, 17 Dec 2019 06:46:34 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: [PATCH V2] arm64: Introduce ID_ISAR6 CPU register
Date:   Tue, 17 Dec 2019 20:17:32 +0530
Message-Id: <1576594052-10285-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds basic building blocks required for ID_ISAR6 CPU register which
identifies support for various instruction implementation on AArch32 state.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: kvmarm@lists.cs.columbia.edu
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V2:

- Added an explicit ftr_id_isar6[] instead of using ftr_generic_32bits per Mark
- Dropped ID_ISAR6_SPECRES_SHIFT exposure in ftr_id_isar6[] per Mark
- Reversed ID_ISAR6_* definitions sequence to meet existing pattern in the file

 arch/arm64/include/asm/cpu.h    |  1 +
 arch/arm64/include/asm/sysreg.h |  9 +++++++++
 arch/arm64/kernel/cpufeature.c  | 15 +++++++++++++++
 arch/arm64/kernel/cpuinfo.c     |  1 +
 arch/arm64/kvm/sys_regs.c       |  2 +-
 5 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index d72d995..b4a4053 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -39,6 +39,7 @@ struct cpuinfo_arm64 {
 	u32		reg_id_isar3;
 	u32		reg_id_isar4;
 	u32		reg_id_isar5;
+	u32		reg_id_isar6;
 	u32		reg_id_mmfr0;
 	u32		reg_id_mmfr1;
 	u32		reg_id_mmfr2;
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6e919fa..7a176e1 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -146,6 +146,7 @@
 #define SYS_ID_ISAR4_EL1		sys_reg(3, 0, 0, 2, 4)
 #define SYS_ID_ISAR5_EL1		sys_reg(3, 0, 0, 2, 5)
 #define SYS_ID_MMFR4_EL1		sys_reg(3, 0, 0, 2, 6)
+#define SYS_ID_ISAR6_EL1		sys_reg(3, 0, 0, 2, 7)
 
 #define SYS_MVFR0_EL1			sys_reg(3, 0, 0, 3, 0)
 #define SYS_MVFR1_EL1			sys_reg(3, 0, 0, 3, 1)
@@ -679,6 +680,14 @@
 #define ID_ISAR5_AES_SHIFT		4
 #define ID_ISAR5_SEVL_SHIFT		0
 
+#define ID_ISAR6_I8MM_SHIFT		24
+#define ID_ISAR6_BF16_SHIFT		20
+#define ID_ISAR6_SPECRES_SHIFT		16
+#define ID_ISAR6_SB_SHIFT		12
+#define ID_ISAR6_FHM_SHIFT		8
+#define ID_ISAR6_DP_SHIFT		4
+#define ID_ISAR6_JSCVT_SHIFT		0
+
 #define MVFR0_FPROUND_SHIFT		28
 #define MVFR0_FPSHVEC_SHIFT		24
 #define MVFR0_FPSQRT_SHIFT		20
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 04cf64e..6cec9aad 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -313,6 +313,16 @@ static const struct arm64_ftr_bits ftr_id_mmfr4[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_id_isar6[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR6_I8MM_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR6_BF16_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR6_SB_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR6_FHM_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR6_DP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR6_JSCVT_SHIFT, 4, 0),
+	ARM64_FTR_END,
+};
+
 static const struct arm64_ftr_bits ftr_id_pfr0[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 12, 4, 0),		/* State3 */
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 8, 4, 0),		/* State2 */
@@ -396,6 +406,7 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG(SYS_ID_ISAR4_EL1, ftr_generic_32bits),
 	ARM64_FTR_REG(SYS_ID_ISAR5_EL1, ftr_id_isar5),
 	ARM64_FTR_REG(SYS_ID_MMFR4_EL1, ftr_id_mmfr4),
+	ARM64_FTR_REG(SYS_ID_ISAR6_EL1, ftr_id_isar6),
 
 	/* Op1 = 0, CRn = 0, CRm = 3 */
 	ARM64_FTR_REG(SYS_MVFR0_EL1, ftr_generic_32bits),
@@ -600,6 +611,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 		init_cpu_ftr_reg(SYS_ID_ISAR3_EL1, info->reg_id_isar3);
 		init_cpu_ftr_reg(SYS_ID_ISAR4_EL1, info->reg_id_isar4);
 		init_cpu_ftr_reg(SYS_ID_ISAR5_EL1, info->reg_id_isar5);
+		init_cpu_ftr_reg(SYS_ID_ISAR6_EL1, info->reg_id_isar6);
 		init_cpu_ftr_reg(SYS_ID_MMFR0_EL1, info->reg_id_mmfr0);
 		init_cpu_ftr_reg(SYS_ID_MMFR1_EL1, info->reg_id_mmfr1);
 		init_cpu_ftr_reg(SYS_ID_MMFR2_EL1, info->reg_id_mmfr2);
@@ -753,6 +765,8 @@ void update_cpu_features(int cpu,
 					info->reg_id_isar4, boot->reg_id_isar4);
 		taint |= check_update_ftr_reg(SYS_ID_ISAR5_EL1, cpu,
 					info->reg_id_isar5, boot->reg_id_isar5);
+		taint |= check_update_ftr_reg(SYS_ID_ISAR6_EL1, cpu,
+					info->reg_id_isar6, boot->reg_id_isar6);
 
 		/*
 		 * Regardless of the value of the AuxReg field, the AIFSR, ADFSR, and
@@ -831,6 +845,7 @@ static u64 __read_sysreg_by_encoding(u32 sys_id)
 	read_sysreg_case(SYS_ID_ISAR3_EL1);
 	read_sysreg_case(SYS_ID_ISAR4_EL1);
 	read_sysreg_case(SYS_ID_ISAR5_EL1);
+	read_sysreg_case(SYS_ID_ISAR6_EL1);
 	read_sysreg_case(SYS_MVFR0_EL1);
 	read_sysreg_case(SYS_MVFR1_EL1);
 	read_sysreg_case(SYS_MVFR2_EL1);
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 56bba74..e4e212f 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -360,6 +360,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 		info->reg_id_isar3 = read_cpuid(ID_ISAR3_EL1);
 		info->reg_id_isar4 = read_cpuid(ID_ISAR4_EL1);
 		info->reg_id_isar5 = read_cpuid(ID_ISAR5_EL1);
+		info->reg_id_isar6 = read_cpuid(ID_ISAR6_EL1);
 		info->reg_id_mmfr0 = read_cpuid(ID_MMFR0_EL1);
 		info->reg_id_mmfr1 = read_cpuid(ID_MMFR1_EL1);
 		info->reg_id_mmfr2 = read_cpuid(ID_MMFR2_EL1);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 9f21659..3e909b1 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1424,7 +1424,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_SANITISED(ID_ISAR4_EL1),
 	ID_SANITISED(ID_ISAR5_EL1),
 	ID_SANITISED(ID_MMFR4_EL1),
-	ID_UNALLOCATED(2,7),
+	ID_SANITISED(ID_ISAR6_EL1),
 
 	/* CRm=3 */
 	ID_SANITISED(MVFR0_EL1),
-- 
2.7.4

