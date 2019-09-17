Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7383C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2CC21881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfIQNnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:43:39 -0400
Received: from foss.arm.com ([217.140.110.172]:56204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfIQNnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:43:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AC0D28;
        Tue, 17 Sep 2019 06:43:38 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.199.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B7843F575;
        Tue, 17 Sep 2019 06:43:37 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        corbet@lwn.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 3/4] arm64/kvm: disable access to AMU registers from kvm guests
Date:   Tue, 17 Sep 2019 14:42:27 +0100
Message-Id: <20190917134228.5369-4-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190917134228.5369-1-ionela.voinescu@arm.com>
References: <20190917134228.5369-1-ionela.voinescu@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Access to the AMU counters should be disabled by default in kvm guests,
as information from the counters might reveal activity in other guests
or activity on the host.

Therefore, disable access to AMU registers from EL0 and EL1 in kvm
guests by:
 - Hiding the presence of the extension in the feature register
   (SYS_ID_AA64PFR0_EL1 and SYS_ID_PFR0_EL1) on the VCPU.
 - Disabling access to the AMU registers before switching to the guest.
 - Trapping accesses and injecting an undefined instruction into the
   guest.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kvm_arm.h |  7 ++-
 arch/arm64/kvm/hyp/switch.c      | 13 ++++-
 arch/arm64/kvm/sys_regs.c        | 95 +++++++++++++++++++++++++++++++-
 3 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index ddf9d762ac62..df957156d55e 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -267,10 +267,11 @@
 #define CPTR_EL2_TFP_SHIFT 10
 
 /* Hyp Coprocessor Trap Register */
-#define CPTR_EL2_TCPAC	(1 << 31)
-#define CPTR_EL2_TTA	(1 << 20)
-#define CPTR_EL2_TFP	(1 << CPTR_EL2_TFP_SHIFT)
 #define CPTR_EL2_TZ	(1 << 8)
+#define CPTR_EL2_TFP	(1 << CPTR_EL2_TFP_SHIFT)
+#define CPTR_EL2_TTA	(1 << 20)
+#define CPTR_EL2_TAM	(1 << 30)
+#define CPTR_EL2_TCPAC	(1 << 31)
 #define CPTR_EL2_RES1	0x000032ff /* known RES1 bits in CPTR_EL2 */
 #define CPTR_EL2_DEFAULT	CPTR_EL2_RES1
 
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 3d3815020e36..6cb37721eb94 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -90,6 +90,17 @@ static void activate_traps_vhe(struct kvm_vcpu *vcpu)
 	val = read_sysreg(cpacr_el1);
 	val |= CPACR_EL1_TTA;
 	val &= ~CPACR_EL1_ZEN;
+
+	/*
+	 * With VHE enabled, we have HCR_EL2.{E2H,TGE} = {1,1}. Note that in
+	 * this case CPACR_EL1 has the same bit layout as CPTR_EL2, and
+	 * CPACR_EL1 accessing instructions are redefined to access CPTR_EL2.
+	 * Therefore use CPTR_EL2.TAM bit reference to activate AMU register
+	 * traps.
+	 */
+
+	val |= CPTR_EL2_TAM;
+
 	if (update_fp_enabled(vcpu)) {
 		if (vcpu_has_sve(vcpu))
 			val |= CPACR_EL1_ZEN;
@@ -111,7 +122,7 @@ static void __hyp_text __activate_traps_nvhe(struct kvm_vcpu *vcpu)
 	__activate_traps_common(vcpu);
 
 	val = CPTR_EL2_DEFAULT;
-	val |= CPTR_EL2_TTA | CPTR_EL2_TZ;
+	val |= CPTR_EL2_TTA | CPTR_EL2_TZ | CPTR_EL2_TAM;
 	if (!update_fp_enabled(vcpu)) {
 		val |= CPTR_EL2_TFP;
 		__activate_traps_fpsimd32(vcpu);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 2071260a275b..1029cd1bc8cc 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -999,6 +999,20 @@ static bool access_pmuserenr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 	{ SYS_DESC(SYS_PMEVTYPERn_EL0(n)),					\
 	  access_pmu_evtyper, reset_unknown, (PMEVTYPER0_EL0 + n), }
 
+static bool access_amu(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
+			     const struct sys_reg_desc *r)
+{
+	kvm_inject_undefined(vcpu);
+
+	return false;
+}
+
+/* Macro to expand the AMU counter and type registers*/
+#define AMU_AMEVCNTR0_EL0(n) { SYS_DESC(SYS_AMEVCNTR0_EL0(n)), access_amu }
+#define AMU_AMEVTYPE0_EL0(n) { SYS_DESC(SYS_AMEVTYPE0_EL0(n)), access_amu }
+#define AMU_AMEVCNTR1_EL0(n) { SYS_DESC(SYS_AMEVCNTR1_EL0(n)), access_amu }
+#define AMU_AMEVTYPE1_EL0(n) { SYS_DESC(SYS_AMEVTYPE1_EL0(n)), access_amu }
+
 static bool trap_ptrauth(struct kvm_vcpu *vcpu,
 			 struct sys_reg_params *p,
 			 const struct sys_reg_desc *rd)
@@ -1074,8 +1088,12 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
 			 (u32)r->CRn, (u32)r->CRm, (u32)r->Op2);
 	u64 val = raz ? 0 : read_sanitised_ftr_reg(id);
 
-	if (id == SYS_ID_AA64PFR0_EL1 && !vcpu_has_sve(vcpu)) {
-		val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
+	if (id == SYS_ID_AA64PFR0_EL1) {
+		if (!vcpu_has_sve(vcpu))
+			val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
+		val &= ~(0xfUL << ID_AA64PFR0_AMU_SHIFT);
+	} else if (id == SYS_ID_PFR0_EL1) {
+		val &= ~(0xfUL << ID_PFR0_AMU_SHIFT);
 	} else if (id == SYS_ID_AA64ISAR1_EL1 && !vcpu_has_ptrauth(vcpu)) {
 		val &= ~((0xfUL << ID_AA64ISAR1_APA_SHIFT) |
 			 (0xfUL << ID_AA64ISAR1_API_SHIFT) |
@@ -1561,6 +1579,79 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_TPIDR_EL0), NULL, reset_unknown, TPIDR_EL0 },
 	{ SYS_DESC(SYS_TPIDRRO_EL0), NULL, reset_unknown, TPIDRRO_EL0 },
 
+	{ SYS_DESC(SYS_AMCR_EL0), access_amu },
+	{ SYS_DESC(SYS_AMCFGR_EL0), access_amu },
+	{ SYS_DESC(SYS_AMCGCR_EL0), access_amu },
+	{ SYS_DESC(SYS_AMUSERENR_EL0), access_amu },
+	{ SYS_DESC(SYS_AMCNTENCLR0_EL0), access_amu },
+	{ SYS_DESC(SYS_AMCNTENSET0_EL0), access_amu },
+	{ SYS_DESC(SYS_AMCNTENCLR1_EL0), access_amu },
+	{ SYS_DESC(SYS_AMCNTENSET1_EL0), access_amu },
+	AMU_AMEVCNTR0_EL0(0),
+	AMU_AMEVCNTR0_EL0(1),
+	AMU_AMEVCNTR0_EL0(2),
+	AMU_AMEVCNTR0_EL0(3),
+	AMU_AMEVCNTR0_EL0(4),
+	AMU_AMEVCNTR0_EL0(5),
+	AMU_AMEVCNTR0_EL0(6),
+	AMU_AMEVCNTR0_EL0(7),
+	AMU_AMEVCNTR0_EL0(8),
+	AMU_AMEVCNTR0_EL0(9),
+	AMU_AMEVCNTR0_EL0(10),
+	AMU_AMEVCNTR0_EL0(11),
+	AMU_AMEVCNTR0_EL0(12),
+	AMU_AMEVCNTR0_EL0(13),
+	AMU_AMEVCNTR0_EL0(14),
+	AMU_AMEVCNTR0_EL0(15),
+	AMU_AMEVTYPE0_EL0(0),
+	AMU_AMEVTYPE0_EL0(1),
+	AMU_AMEVTYPE0_EL0(2),
+	AMU_AMEVTYPE0_EL0(3),
+	AMU_AMEVTYPE0_EL0(4),
+	AMU_AMEVTYPE0_EL0(5),
+	AMU_AMEVTYPE0_EL0(6),
+	AMU_AMEVTYPE0_EL0(7),
+	AMU_AMEVTYPE0_EL0(8),
+	AMU_AMEVTYPE0_EL0(9),
+	AMU_AMEVTYPE0_EL0(10),
+	AMU_AMEVTYPE0_EL0(11),
+	AMU_AMEVTYPE0_EL0(12),
+	AMU_AMEVTYPE0_EL0(13),
+	AMU_AMEVTYPE0_EL0(14),
+	AMU_AMEVTYPE0_EL0(15),
+	AMU_AMEVCNTR1_EL0(0),
+	AMU_AMEVCNTR1_EL0(1),
+	AMU_AMEVCNTR1_EL0(2),
+	AMU_AMEVCNTR1_EL0(3),
+	AMU_AMEVCNTR1_EL0(4),
+	AMU_AMEVCNTR1_EL0(5),
+	AMU_AMEVCNTR1_EL0(6),
+	AMU_AMEVCNTR1_EL0(7),
+	AMU_AMEVCNTR1_EL0(8),
+	AMU_AMEVCNTR1_EL0(9),
+	AMU_AMEVCNTR1_EL0(10),
+	AMU_AMEVCNTR1_EL0(11),
+	AMU_AMEVCNTR1_EL0(12),
+	AMU_AMEVCNTR1_EL0(13),
+	AMU_AMEVCNTR1_EL0(14),
+	AMU_AMEVCNTR1_EL0(15),
+	AMU_AMEVTYPE1_EL0(0),
+	AMU_AMEVTYPE1_EL0(1),
+	AMU_AMEVTYPE1_EL0(2),
+	AMU_AMEVTYPE1_EL0(3),
+	AMU_AMEVTYPE1_EL0(4),
+	AMU_AMEVTYPE1_EL0(5),
+	AMU_AMEVTYPE1_EL0(6),
+	AMU_AMEVTYPE1_EL0(7),
+	AMU_AMEVTYPE1_EL0(8),
+	AMU_AMEVTYPE1_EL0(9),
+	AMU_AMEVTYPE1_EL0(10),
+	AMU_AMEVTYPE1_EL0(11),
+	AMU_AMEVTYPE1_EL0(12),
+	AMU_AMEVTYPE1_EL0(13),
+	AMU_AMEVTYPE1_EL0(14),
+	AMU_AMEVTYPE1_EL0(15),
+
 	{ SYS_DESC(SYS_CNTP_TVAL_EL0), access_arch_timer },
 	{ SYS_DESC(SYS_CNTP_CTL_EL0), access_arch_timer },
 	{ SYS_DESC(SYS_CNTP_CVAL_EL0), access_arch_timer },
-- 
2.17.1

