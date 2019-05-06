Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43576C04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FDA2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfEFIVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:21:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7169 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726651AbfEFIUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:46 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B907F132402CA729FF3E;
        Mon,  6 May 2019 16:20:43 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 6 May 2019 16:20:41 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <marc.zyngier@arm.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>
CC:     <julien.thierry@arm.com>, <Suzuki.Poulose@arm.com>,
        <sudeep.holla@arm.com>, <steve.capper@arm.com>,
        <lorenzo.pieralisi@arm.com>, <daniel.thompson@linaro.org>,
        <james.morse@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] arm64: Add pseudo NMI support of GICv3 SGIs
Date:   Mon, 6 May 2019 16:25:40 +0800
Message-ID: <20190506082542.11357-2-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506082542.11357-1-liwei391@huawei.com>
References: <20190506082542.11357-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only PPIs and SPIs can be set as NMIs. IPIs being currently
hardcoded IRQ numbers, there isn't a generic interface to set SGIs as NMI
for now.

In this patch, we do:
1. Add an interface for setting priority of SGIs.
2. Export GICD_INT_NMI_PRI for setting priority of SGIs as NMI.
3. Move the gic_enable_nmi_support() earlier to make the gic_supports_nmi()
check works in gic_cpu_init().

Signed-off-by: Wei Li <liwei391@huawei.com>
Cc: Julien Thierry <julien.thierry@arm.com>
---
 arch/arm64/include/asm/smp.h           |  2 ++
 arch/arm64/kernel/smp.c                |  4 +++
 drivers/irqchip/irq-gic-v3.c           | 46 +++++++++++++++++++++-----
 include/linux/irqchip/arm-gic-common.h |  1 +
 include/linux/irqchip/arm-gic-v3.h     |  1 +
 5 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 18553f399e08..84d7ea073d84 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -158,6 +158,8 @@ bool cpus_are_stuck_in_kernel(void);
 extern void crash_smp_send_stop(void);
 extern bool smp_crash_stop_failed(void);
 
+extern void ipi_gic_nmi_setup(void __iomem *base);
+
 #endif /* ifndef __ASSEMBLY__ */
 
 #endif /* ifndef __ASM_SMP_H */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 824de7038967..bd8fdf6fcd8e 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1067,3 +1067,7 @@ bool cpus_are_stuck_in_kernel(void)
 
 	return !!cpus_stuck_in_kernel || smp_spin_tables;
 }
+
+void ipi_gic_nmi_setup(void __iomem *base)
+{
+}
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 15e55d327505..394aa5668dd6 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -42,8 +42,6 @@
 
 #include "irq-gic-common.h"
 
-#define GICD_INT_NMI_PRI	(GICD_INT_DEF_PRI & ~0x80)
-
 #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
 
 struct redist_region {
@@ -324,6 +322,23 @@ static int gic_irq_get_irqchip_state(struct irq_data *d,
 	return 0;
 }
 
+void gic_sgi_set_prio(void __iomem *base, u32 irqnr, u8 prio)
+{
+	u32 val, offset;
+
+	offset = GICR_IPRIORITYR0 + ((irqnr / 4) * 4);
+
+	/*
+	 * Using writeb here may cause hardware error on some CPUs,
+	 * aovid this quirk by using writel.
+	 */
+	val = readl_relaxed(base + offset);
+	val &= ~(0xff << ((irqnr % 4) * 8));
+	val |= prio << ((irqnr % 4) * 8);
+
+	writel_relaxed(val, base + offset);
+}
+
 static void gic_irq_set_prio(struct irq_data *d, u8 prio)
 {
 	void __iomem *base = gic_dist_base(d);
@@ -474,6 +489,16 @@ static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
 {
 	int err;
 
+	if (unlikely(irqnr < 16)) {
+		gic_write_eoir(irqnr);
+		if (static_branch_likely(&supports_deactivate_key))
+			gic_write_dir(irqnr);
+#ifdef CONFIG_SMP
+		handle_IPI(irqnr, regs);
+#endif
+		return;
+	}
+
 	if (static_branch_likely(&supports_deactivate_key))
 		gic_write_eoir(irqnr);
 	/*
@@ -859,6 +884,9 @@ static void gic_cpu_init(void)
 
 	gic_cpu_config(rbase, gic_redist_wait_for_rwp);
 
+	if (gic_supports_nmi())
+		ipi_gic_nmi_setup(rbase);
+
 	/* initialise system registers */
 	gic_cpu_sys_reg_init();
 }
@@ -1335,6 +1363,13 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_update_vlpi_properties();
 
+	if (gic_prio_masking_enabled()) {
+		if (!gic_has_group0() || gic_dist_security_disabled())
+			gic_enable_nmi_support();
+		else
+			pr_warn("SCR_EL3.FIQ is cleared, cannot enable use of pseudo-NMIs\n");
+	}
+
 	gic_smp_init();
 	gic_dist_init();
 	gic_cpu_init();
@@ -1345,13 +1380,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
 		its_cpu_init();
 	}
 
-	if (gic_prio_masking_enabled()) {
-		if (!gic_has_group0() || gic_dist_security_disabled())
-			gic_enable_nmi_support();
-		else
-			pr_warn("SCR_EL3.FIQ is cleared, cannot enable use of pseudo-NMIs\n");
-	}
-
 	return 0;
 
 out_free:
diff --git a/include/linux/irqchip/arm-gic-common.h b/include/linux/irqchip/arm-gic-common.h
index 9a1a479a2bf4..d8c973295179 100644
--- a/include/linux/irqchip/arm-gic-common.h
+++ b/include/linux/irqchip/arm-gic-common.h
@@ -18,6 +18,7 @@
 					(GICD_INT_DEF_PRI << 16) |\
 					(GICD_INT_DEF_PRI << 8) |\
 					GICD_INT_DEF_PRI)
+#define GICD_INT_NMI_PRI	(GICD_INT_DEF_PRI & ~0x80)
 
 enum gic_type {
 	GIC_V2,
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index c848a7cc502e..dc1c418229e7 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -606,6 +606,7 @@ int its_cpu_init(void);
 int its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	     struct irq_domain *domain);
 int mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent);
+void gic_sgi_set_prio(void __iomem *base, u32 irqnr, u8 prio);
 
 static inline bool gic_enable_sre(void)
 {
-- 
2.17.1

