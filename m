Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B275DC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A63721783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570007221;
	bh=AwvkE77N5PeRqPGFVXSIG2HfhQSQMKPK/QKpGRY1fUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o61qOgjE82Qw/JUsalIIQe6T0cE5yupbUd3wHorbrioN9FRZL2meDbqMPxrxna2tL
	 3qiWeCV1myt2jVSRIlqPZZoumlRLWRQgvfE8bLrfF9LimeRTsju3fNMYUMf8Ksr5dE
	 GIobHaAiPCNea4xJvToGLWC5JhgShcStKGt6gBiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfJBJG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 05:06:57 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:47207 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbfJBJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:06:56 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iFaas-00057p-Uu; Wed, 02 Oct 2019 11:06:47 +0200
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        huawei.libin@huawei.com, uohanjun@huawei.com, liwei391@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] arm64: Relax ICC_PMR_EL1 accesses when ICC_CTLR_EL1.PMHE is clear
Date:   Wed,  2 Oct 2019 10:06:12 +0100
Message-Id: <20191002090613.14236-2-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191002090613.14236-1-maz@kernel.org>
References: <20191002090613.14236-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, catalin.marinas@arm.com, suzuki.poulose@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, huawei.libin@huawei.com, uohanjun@huawei.com, liwei391@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GICv3 architecture specification is incredibly misleading when it
comes to PMR and the requirement for a DSB. It turns out that this DSB
is only required if the CPU interface sends an Upstream Control
message to the redistributor in order to update the RD's view of PMR.

This message is only sent when ICC_CTLR_EL1.PMHE is set, which isn't
the case in Linux. It can still be set from EL3, so some special care
is required. But the upshot is that in the (hopefuly large) majority
of the cases, we can drop the DSB altogether.

This relies on a new static key being set if the boot CPU has PMHE
set. The drawback is that this static key has to be exported to
modules.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/barrier.h   | 12 ++++++++++++
 arch/arm64/include/asm/daifflags.h |  3 ++-
 arch/arm64/include/asm/irqflags.h  | 19 ++++++++++---------
 arch/arm64/include/asm/kvm_host.h  |  3 +--
 arch/arm64/kernel/entry.S          |  6 ++++--
 arch/arm64/kvm/hyp/switch.c        |  4 ++--
 drivers/irqchip/irq-gic-v3.c       | 20 ++++++++++++++++++++
 include/linux/irqchip/arm-gic-v3.h |  2 ++
 8 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index e0e2b1946f42..7d9cc5ec4971 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -29,6 +29,18 @@
 						 SB_BARRIER_INSN"nop\n",	\
 						 ARM64_HAS_SB))
 
+#ifdef CONFIG_ARM64_PSEUDO_NMI
+#define pmr_sync()						\
+	do {							\
+		extern struct static_key_false gic_pmr_sync;	\
+								\
+		if (static_branch_unlikely(&gic_pmr_sync))	\
+			dsb(sy);				\
+	} while(0)
+#else
+#define pmr_sync()	do {} while (0)
+#endif
+
 #define mb()		dsb(sy)
 #define rmb()		dsb(ld)
 #define wmb()		dsb(st)
diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index 063c964af705..53cd5fab79a8 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -8,6 +8,7 @@
 #include <linux/irqflags.h>
 
 #include <asm/arch_gicv3.h>
+#include <asm/barrier.h>
 #include <asm/cpufeature.h>
 
 #define DAIF_PROCCTX		0
@@ -65,7 +66,7 @@ static inline void local_daif_restore(unsigned long flags)
 
 		if (system_uses_irq_prio_masking()) {
 			gic_write_pmr(GIC_PRIO_IRQON);
-			dsb(sy);
+			pmr_sync();
 		}
 	} else if (system_uses_irq_prio_masking()) {
 		u64 pmr;
diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 1a59f0ed1ae3..aa4b6521ef14 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -6,6 +6,7 @@
 #define __ASM_IRQFLAGS_H
 
 #include <asm/alternative.h>
+#include <asm/barrier.h>
 #include <asm/ptrace.h>
 #include <asm/sysreg.h>
 
@@ -34,14 +35,14 @@ static inline void arch_local_irq_enable(void)
 	}
 
 	asm volatile(ALTERNATIVE(
-		"msr	daifclr, #2		// arch_local_irq_enable\n"
-		"nop",
-		__msr_s(SYS_ICC_PMR_EL1, "%0")
-		"dsb	sy",
+		"msr	daifclr, #2		// arch_local_irq_enable",
+		__msr_s(SYS_ICC_PMR_EL1, "%0"),
 		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
 		: "r" ((unsigned long) GIC_PRIO_IRQON)
 		: "memory");
+
+	pmr_sync();
 }
 
 static inline void arch_local_irq_disable(void)
@@ -116,14 +117,14 @@ static inline unsigned long arch_local_irq_save(void)
 static inline void arch_local_irq_restore(unsigned long flags)
 {
 	asm volatile(ALTERNATIVE(
-			"msr	daif, %0\n"
-			"nop",
-			__msr_s(SYS_ICC_PMR_EL1, "%0")
-			"dsb	sy",
-			ARM64_HAS_IRQ_PRIO_MASKING)
+		"msr	daif, %0",
+		__msr_s(SYS_ICC_PMR_EL1, "%0"),
+		ARM64_HAS_IRQ_PRIO_MASKING)
 		:
 		: "r" (flags)
 		: "memory");
+
+	pmr_sync();
 }
 
 #endif /* __ASM_IRQFLAGS_H */
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f656169db8c3..5ecb091c8576 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -600,8 +600,7 @@ static inline void kvm_arm_vhe_guest_enter(void)
 	 * local_daif_mask() already sets GIC_PRIO_PSR_I_SET, we just need a
 	 * dsb to ensure the redistributor is forwards EL2 IRQs to the CPU.
 	 */
-	if (system_uses_irq_prio_masking())
-		dsb(sy);
+	pmr_sync();
 }
 
 static inline void kvm_arm_vhe_guest_exit(void)
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 84a822748c84..3e0eb4f5253b 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -269,8 +269,10 @@ alternative_else_nop_endif
 alternative_if ARM64_HAS_IRQ_PRIO_MASKING
 	ldr	x20, [sp, #S_PMR_SAVE]
 	msr_s	SYS_ICC_PMR_EL1, x20
-	/* Ensure priority change is seen by redistributor */
-	dsb	sy
+	mrs_s	x21, SYS_ICC_CTLR_EL1
+	tbz	x21, #6, .L__skip_pmr_sync\@	// Check for ICC_CTLR_EL1.PMHE
+	dsb	sy				// Ensure priority change is seen by redistributor
+.L__skip_pmr_sync\@:
 alternative_else_nop_endif
 
 	ldp	x21, x22, [sp, #S_PC]		// load ELR, SPSR
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index bd978ad71936..85832c5bf9f5 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -12,7 +12,7 @@
 
 #include <kvm/arm_psci.h>
 
-#include <asm/arch_gicv3.h>
+#include <asm/barrier.h>
 #include <asm/cpufeature.h>
 #include <asm/kprobes.h>
 #include <asm/kvm_asm.h>
@@ -605,7 +605,7 @@ int __hyp_text __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu)
 	 */
 	if (system_uses_irq_prio_masking()) {
 		gic_write_pmr(GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET);
-		dsb(sy);
+		pmr_sync();
 	}
 
 	vcpu = kern_hyp_va(vcpu);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 422664ac5f53..0abc5a13adaa 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -87,6 +87,15 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
  */
 static DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
 
+/*
+ * Global static key controlling whether an update to PMR allowing more
+ * interrupts requires to be propagated to the redistributor (DSB SY).
+ * And this needs to be exported for modules to be able to enable
+ * interrupts...
+ */
+DEFINE_STATIC_KEY_FALSE(gic_pmr_sync);
+EXPORT_SYMBOL(gic_pmr_sync);
+
 /* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
 static refcount_t *ppi_nmi_refs;
 
@@ -1502,6 +1511,17 @@ static void gic_enable_nmi_support(void)
 	for (i = 0; i < gic_data.ppi_nr; i++)
 		refcount_set(&ppi_nmi_refs[i], 0);
 
+	/*
+	 * Linux itself doesn't use 1:N distribution, so has no need to
+	 * set PMHE. The only reason to have it set is if EL3 requires it
+	 * (and we can't change it).
+	 */
+	if (gic_read_ctlr() & ICC_CTLR_EL1_PMHE_MASK)
+		static_branch_enable(&gic_pmr_sync);
+
+	pr_info("%s ICC_PMR_EL1 synchronisation\n",
+		static_branch_unlikely(&gic_pmr_sync) ? "Forcing" : "Relaxing");
+
 	static_branch_enable(&supports_pseudo_nmis);
 
 	if (static_branch_likely(&supports_deactivate_key))
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 5cc10cf7cb3e..a0bde9e12efa 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -487,6 +487,8 @@
 #define ICC_CTLR_EL1_EOImode_MASK	(1 << ICC_CTLR_EL1_EOImode_SHIFT)
 #define ICC_CTLR_EL1_CBPR_SHIFT		0
 #define ICC_CTLR_EL1_CBPR_MASK		(1 << ICC_CTLR_EL1_CBPR_SHIFT)
+#define ICC_CTLR_EL1_PMHE_SHIFT		6
+#define ICC_CTLR_EL1_PMHE_MASK		(1 << ICC_CTLR_EL1_PMHE_SHIFT)
 #define ICC_CTLR_EL1_PRI_BITS_SHIFT	8
 #define ICC_CTLR_EL1_PRI_BITS_MASK	(0x7 << ICC_CTLR_EL1_PRI_BITS_SHIFT)
 #define ICC_CTLR_EL1_ID_BITS_SHIFT	11
-- 
2.20.1

