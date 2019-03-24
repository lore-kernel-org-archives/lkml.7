Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F81C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FD2222E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 14:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfCXOOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 10:14:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43614 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfCXOOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 10:14:04 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h83ss-0001yr-Vl; Sun, 24 Mar 2019 15:13:59 +0100
Date:   Sun, 24 Mar 2019 14:12:21 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq updates for 5.1
References: <155343674151.28403.7455818401538063350.tglx@nanos.tec.linutronix.de>
Message-ID: <155343674151.28403.15105698349850612949.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

A set of fixes for the interrupt subsystem:

 - Remove secondary GIC support on systems w/o device-tree support

 - A set of small fixlets in various irqchip drivers

 - static and fall-through annotations
 
 - Kernel doc and typo fixes

Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      irqchip/imx-irqsteer: Fix of_property_read_u32() error handling

Fabien Dessenne (2):
      irqchip/stm32: Don't clear rising/falling config registers at init
      irqchip/stm32: Don't set rising configuration registers at init

Fabrizio Castro (1):
      dt-bindings: irqchip: renesas-irqc: Document r8a774c0 support

Gustavo A. R. Silva (1):
      genirq: Mark expected switch case fall-through

Jianguo Chen (1):
      irqchip/mbigen: Don't clear eventid when freeing an MSI

Marc Zyngier (1):
      irqchip/gic: Drop support for secondary GIC in non-DT systems

Peter Xu (1):
      genirq: Fix typo in comment of IRQD_MOVE_PCNTXT

Rasmus Villemoes (1):
      irqchip/gic-v3-its: Fix comparison logic in lpi_range_cmp

Valdis Kletnieks (1):
      genirq/devres: Remove excess parameter from kernel doc

YueHaibing (3):
      irqchip/brcmstb-l2: Make two init functions static
      irqchip/mmp: Make mmp_irq_domain_ops static
      irqchip/irq-mvebu-sei: Make mvebu_sei_ap806_caps static


 .../bindings/interrupt-controller/renesas,irqc.txt |  1 +
 arch/arm/mach-cns3xxx/core.c                       |  2 +-
 drivers/irqchip/irq-brcmstb-l2.c                   |  4 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  2 +-
 drivers/irqchip/irq-gic.c                          | 45 ++++++++--------------
 drivers/irqchip/irq-imx-irqsteer.c                 |  8 +++-
 drivers/irqchip/irq-mbigen.c                       |  3 ++
 drivers/irqchip/irq-mmp.c                          |  2 +-
 drivers/irqchip/irq-mvebu-sei.c                    |  2 +-
 drivers/irqchip/irq-stm32-exti.c                   | 10 -----
 include/linux/irq.h                                |  2 +-
 include/linux/irqchip/arm-gic.h                    |  3 +-
 kernel/irq/devres.c                                |  2 -
 kernel/irq/manage.c                                |  1 +
 14 files changed, 35 insertions(+), 52 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
index 8de96a4fb2d5..f977ea7617f6 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
@@ -16,6 +16,7 @@ Required properties:
     - "renesas,irqc-r8a7793" (R-Car M2-N)
     - "renesas,irqc-r8a7794" (R-Car E2)
     - "renesas,intc-ex-r8a774a1" (RZ/G2M)
+    - "renesas,intc-ex-r8a774c0" (RZ/G2E)
     - "renesas,intc-ex-r8a7795" (R-Car H3)
     - "renesas,intc-ex-r8a7796" (R-Car M3-W)
     - "renesas,intc-ex-r8a77965" (R-Car M3-N)
diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
index 7d5a44a06648..f676592d8402 100644
--- a/arch/arm/mach-cns3xxx/core.c
+++ b/arch/arm/mach-cns3xxx/core.c
@@ -90,7 +90,7 @@ void __init cns3xxx_map_io(void)
 /* used by entry-macro.S */
 void __init cns3xxx_init_irq(void)
 {
-	gic_init(0, 29, IOMEM(CNS3XXX_TC11MP_GIC_DIST_BASE_VIRT),
+	gic_init(IOMEM(CNS3XXX_TC11MP_GIC_DIST_BASE_VIRT),
 		 IOMEM(CNS3XXX_TC11MP_GIC_CPU_BASE_VIRT));
 }
 
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 83364fedbf0a..5e4ca139e4ea 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -275,14 +275,14 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	return ret;
 }
 
-int __init brcmstb_l2_edge_intc_of_init(struct device_node *np,
+static int __init brcmstb_l2_edge_intc_of_init(struct device_node *np,
 	struct device_node *parent)
 {
 	return brcmstb_l2_intc_of_init(np, parent, &l2_edge_intc_init);
 }
 IRQCHIP_DECLARE(brcmstb_l2_intc, "brcm,l2-intc", brcmstb_l2_edge_intc_of_init);
 
-int __init brcmstb_l2_lvl_intc_of_init(struct device_node *np,
+static int __init brcmstb_l2_lvl_intc_of_init(struct device_node *np,
 	struct device_node *parent)
 {
 	return brcmstb_l2_intc_of_init(np, parent, &l2_lvl_intc_init);
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2dd1ff0cf558..7577755bdcf4 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1482,7 +1482,7 @@ static int lpi_range_cmp(void *priv, struct list_head *a, struct list_head *b)
 	ra = container_of(a, struct lpi_range, entry);
 	rb = container_of(b, struct lpi_range, entry);
 
-	return rb->base_id - ra->base_id;
+	return ra->base_id - rb->base_id;
 }
 
 static void merge_lpi_ranges(void)
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index ba2a37a27a54..fd3110c171ba 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1089,11 +1089,10 @@ static void gic_init_chip(struct gic_chip_data *gic, struct device *dev,
 #endif
 }
 
-static int gic_init_bases(struct gic_chip_data *gic, int irq_start,
+static int gic_init_bases(struct gic_chip_data *gic,
 			  struct fwnode_handle *handle)
 {
-	irq_hw_number_t hwirq_base;
-	int gic_irqs, irq_base, ret;
+	int gic_irqs, ret;
 
 	if (IS_ENABLED(CONFIG_GIC_NON_BANKED) && gic->percpu_offset) {
 		/* Frankein-GIC without banked registers... */
@@ -1145,28 +1144,21 @@ static int gic_init_bases(struct gic_chip_data *gic, int irq_start,
 	} else {		/* Legacy support */
 		/*
 		 * For primary GICs, skip over SGIs.
-		 * For secondary GICs, skip over PPIs, too.
+		 * No secondary GIC support whatsoever.
 		 */
-		if (gic == &gic_data[0] && (irq_start & 31) > 0) {
-			hwirq_base = 16;
-			if (irq_start != -1)
-				irq_start = (irq_start & ~31) + 16;
-		} else {
-			hwirq_base = 32;
-		}
+		int irq_base;
 
-		gic_irqs -= hwirq_base; /* calculate # of irqs to allocate */
+		gic_irqs -= 16; /* calculate # of irqs to allocate */
 
-		irq_base = irq_alloc_descs(irq_start, 16, gic_irqs,
+		irq_base = irq_alloc_descs(16, 16, gic_irqs,
 					   numa_node_id());
 		if (irq_base < 0) {
-			WARN(1, "Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
-			     irq_start);
-			irq_base = irq_start;
+			WARN(1, "Cannot allocate irq_descs @ IRQ16, assuming pre-allocated\n");
+			irq_base = 16;
 		}
 
 		gic->domain = irq_domain_add_legacy(NULL, gic_irqs, irq_base,
-					hwirq_base, &gic_irq_domain_ops, gic);
+						    16, &gic_irq_domain_ops, gic);
 	}
 
 	if (WARN_ON(!gic->domain)) {
@@ -1195,7 +1187,6 @@ static int gic_init_bases(struct gic_chip_data *gic, int irq_start,
 }
 
 static int __init __gic_init_bases(struct gic_chip_data *gic,
-				   int irq_start,
 				   struct fwnode_handle *handle)
 {
 	char *name;
@@ -1231,32 +1222,28 @@ static int __init __gic_init_bases(struct gic_chip_data *gic,
 		gic_init_chip(gic, NULL, name, false);
 	}
 
-	ret = gic_init_bases(gic, irq_start, handle);
+	ret = gic_init_bases(gic, handle);
 	if (ret)
 		kfree(name);
 
 	return ret;
 }
 
-void __init gic_init(unsigned int gic_nr, int irq_start,
-		     void __iomem *dist_base, void __iomem *cpu_base)
+void __init gic_init(void __iomem *dist_base, void __iomem *cpu_base)
 {
 	struct gic_chip_data *gic;
 
-	if (WARN_ON(gic_nr >= CONFIG_ARM_GIC_MAX_NR))
-		return;
-
 	/*
 	 * Non-DT/ACPI systems won't run a hypervisor, so let's not
 	 * bother with these...
 	 */
 	static_branch_disable(&supports_deactivate_key);
 
-	gic = &gic_data[gic_nr];
+	gic = &gic_data[0];
 	gic->raw_dist_base = dist_base;
 	gic->raw_cpu_base = cpu_base;
 
-	__gic_init_bases(gic, irq_start, NULL);
+	__gic_init_bases(gic, NULL);
 }
 
 static void gic_teardown(struct gic_chip_data *gic)
@@ -1399,7 +1386,7 @@ int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int irq)
 	if (ret)
 		return ret;
 
-	ret = gic_init_bases(*gic, -1, &dev->of_node->fwnode);
+	ret = gic_init_bases(*gic, &dev->of_node->fwnode);
 	if (ret) {
 		gic_teardown(*gic);
 		return ret;
@@ -1459,7 +1446,7 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	if (gic_cnt == 0 && !gic_check_eoimode(node, &gic->raw_cpu_base))
 		static_branch_disable(&supports_deactivate_key);
 
-	ret = __gic_init_bases(gic, -1, &node->fwnode);
+	ret = __gic_init_bases(gic, &node->fwnode);
 	if (ret) {
 		gic_teardown(gic);
 		return ret;
@@ -1650,7 +1637,7 @@ static int __init gic_v2_acpi_init(struct acpi_subtable_header *header,
 		return -ENOMEM;
 	}
 
-	ret = __gic_init_bases(gic, -1, domain_handle);
+	ret = __gic_init_bases(gic, domain_handle);
 	if (ret) {
 		pr_err("Failed to initialise GIC\n");
 		irq_domain_free_fwnode(domain_handle);
diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index d1098f4da6a4..88df3d00052c 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -169,8 +169,12 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 
 	raw_spin_lock_init(&data->lock);
 
-	of_property_read_u32(np, "fsl,num-irqs", &irqs_num);
-	of_property_read_u32(np, "fsl,channel", &data->channel);
+	ret = of_property_read_u32(np, "fsl,num-irqs", &irqs_num);
+	if (ret)
+		return ret;
+	ret = of_property_read_u32(np, "fsl,channel", &data->channel);
+	if (ret)
+		return ret;
 
 	/*
 	 * There is one output irq for each group of 64 inputs.
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 567b29c47608..98b6e1d4b1a6 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -161,6 +161,9 @@ static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 	void __iomem *base = d->chip_data;
 	u32 val;
 
+	if (!msg->address_lo && !msg->address_hi)
+		return;
+ 
 	base += get_mbigen_vec_reg(d->hwirq);
 	val = readl_relaxed(base);
 
diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 3496b61a312a..8eed478f3b7e 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -179,7 +179,7 @@ static int mmp_irq_domain_xlate(struct irq_domain *d, struct device_node *node,
 	return 0;
 }
 
-const struct irq_domain_ops mmp_irq_domain_ops = {
+static const struct irq_domain_ops mmp_irq_domain_ops = {
 	.map		= mmp_irq_domain_map,
 	.xlate		= mmp_irq_domain_xlate,
 };
diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index add4c9c934c8..18832ccc8ff8 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -478,7 +478,7 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 	return ret;
 }
 
-struct mvebu_sei_caps mvebu_sei_ap806_caps = {
+static struct mvebu_sei_caps mvebu_sei_ap806_caps = {
 	.ap_range = {
 		.first = 0,
 		.size = 21,
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index a93296b9b45d..7bd1d4cb2e19 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -716,7 +716,6 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 	const struct stm32_exti_bank *stm32_bank;
 	struct stm32_exti_chip_data *chip_data;
 	void __iomem *base = h_data->base;
-	u32 irqs_mask;
 
 	stm32_bank = h_data->drv_data->exti_banks[bank_idx];
 	chip_data = &h_data->chips_data[bank_idx];
@@ -725,21 +724,12 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 
 	raw_spin_lock_init(&chip_data->rlock);
 
-	/* Determine number of irqs supported */
-	writel_relaxed(~0UL, base + stm32_bank->rtsr_ofst);
-	irqs_mask = readl_relaxed(base + stm32_bank->rtsr_ofst);
-
 	/*
 	 * This IP has no reset, so after hot reboot we should
 	 * clear registers to avoid residue
 	 */
 	writel_relaxed(0, base + stm32_bank->imr_ofst);
 	writel_relaxed(0, base + stm32_bank->emr_ofst);
-	writel_relaxed(0, base + stm32_bank->rtsr_ofst);
-	writel_relaxed(0, base + stm32_bank->ftsr_ofst);
-	writel_relaxed(~0UL, base + stm32_bank->rpr_ofst);
-	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		writel_relaxed(~0UL, base + stm32_bank->fpr_ofst);
 
 	pr_info("%pOF: bank%d\n", h_data->node, bank_idx);
 
diff --git a/include/linux/irq.h b/include/linux/irq.h
index d6160d479b14..7ae8de5ad0f2 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -195,7 +195,7 @@ struct irq_data {
  * IRQD_LEVEL			- Interrupt is level triggered
  * IRQD_WAKEUP_STATE		- Interrupt is configured for wakeup
  *				  from suspend
- * IRDQ_MOVE_PCNTXT		- Interrupt can be moved in process
+ * IRQD_MOVE_PCNTXT		- Interrupt can be moved in process
  *				  context
  * IRQD_IRQ_DISABLED		- Disabled state of the interrupt
  * IRQD_IRQ_MASKED		- Masked state of the interrupt
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 626179077bb0..0f049b384ccd 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -158,8 +158,7 @@ int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int irq);
  * Legacy platforms not converted to DT yet must use this to init
  * their GIC
  */
-void gic_init(unsigned int nr, int start,
-	      void __iomem *dist , void __iomem *cpu);
+void gic_init(void __iomem *dist , void __iomem *cpu);
 
 int gicv2m_init(struct fwnode_handle *parent_handle,
 		struct irq_domain *parent);
diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index 5d5378ea0afe..f808c6a97dcc 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -84,8 +84,6 @@ EXPORT_SYMBOL(devm_request_threaded_irq);
  *	@dev: device to request interrupt for
  *	@irq: Interrupt line to allocate
  *	@handler: Function to be called when the IRQ occurs
- *	@thread_fn: function to be called in a threaded interrupt context. NULL
- *		    for devices which handle everything in @handler
  *	@irqflags: Interrupt type flags
  *	@devname: An ascii name for the claiming device, dev_name(dev) if NULL
  *	@dev_id: A cookie passed back to the handler function
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 9ec34a2a6638..1401afa0d58a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -196,6 +196,7 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	case IRQ_SET_MASK_OK:
 	case IRQ_SET_MASK_OK_DONE:
 		cpumask_copy(desc->irq_common_data.affinity, mask);
+		/* fall through */
 	case IRQ_SET_MASK_OK_NOCOPY:
 		irq_validate_effective_affinity(data);
 		irq_set_thread_affinity(desc);

