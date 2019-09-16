Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29EEC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D12214DE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbfIPNiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:38:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39246 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfIPNiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:38:09 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i9rCU-0006vJ-St; Mon, 16 Sep 2019 15:37:55 +0200
Date:   Mon, 16 Sep 2019 13:30:20 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for 5.4-rc1
Message-ID: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-for-linus

up to:  9cc5b7fba579: Merge tag 'irqchip-5.4' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

Updates from the irq departement:

  - Update the interrupt spreading code so it handles numa node with
    different CPU counts properly.

  - A large overhaul of the ARM GiCv3 driver to support new PPI and SPI
    ranges.

  - Conversion of all alloc_fwnode() users to use physical addresses
    instead of virtual addresses so the virtual addresses are not
    leaked. The physical address is sufficient to identify the associated
    interrupt chip.

  - Add support for Marvel MMP3, Amlogic Meson SM1 interrupt chips.

  - Enforce interrupt threading at compile time if RT is enabled.

  - Small updates and improvements all over the place.

Thanks,

	tglx

------------------>
Andres Salomon (1):
      irqchip/mmp: Mask off interrupts from other cores

Dexuan Cui (1):
      irqdomain: Add the missing assignment of domain->fwnode for named fwnode

Jerome Brunet (2):
      dt-bindings: interrupt-controller: New binding for the meson sm1 SoCs
      irqchip/meson-gpio: Add support for meson sm1 SoCs

Lubomir Rintel (4):
      irqchip/mmp: Do not call irq_set_default_host() on DT platforms
      irqchip/mmp: Do not use of_address_to_resource() to get mux regs
      irqchip/mmp: Add missing chained_irq_{enter,exit}()
      irqchip/mmp: Coexist with GIC root IRQ controller

Marc Zyngier (21):
      irqchip/gic-v3: Register the distributor's PA instead of its VA in fwnode
      irqchip/gic-v3-its: Register the ITS' PA instead of its VA in fwnode
      irqchip/gic: Register the distributor's PA instead of its VA in fwnode
      irqchip/gic-v2m: Register the frame's PA instead of its VA in fwnode
      irqchip/ixp4xx: Register the base PA instead of its VA in fwnode
      gpio/ixp4xx: Register the base PA instead of its VA in fwnode
      PCI: hv: Allocate a named fwnode instead of an address-based one
      irqdomain/debugfs: Use PAs to generate fwnode names
      irqchip/gic: Rework gic_configure_irq to take the full ICFGR base
      irqchip/gic-v3: Add INTID range and convertion primitives
      dt-bindings: interrupt-controller: arm,gic-v3: Describe ESPI range support
      irqchip/gic-v3: Add ESPI range support
      irqchip/gic: Prepare for more than 16 PPIs
      irqchip/gic-v3: Dynamically allocate PPI NMI refcounts
      irqchip/gic-v3: Dynamically allocate PPI partition descriptors
      dt-bindings: interrupt-controller: arm,gic-v3: Describe EPPI range support
      irqchip/gic-v3: Add EPPI range support
      irqchip/gic-v3: Warn about inconsistent implementations of extended ranges
      irqchip/gic: Skip DT quirks when evaluating IIDR-based quirks
      irqchip/gic-v3: Add quirks for HIP06/07 invalid GICD_TYPER erratum 161010803
      irqchip/gic-v3-its: Fix LPI release for Multi-MSI devices

Masahiro Yamada (2):
      irqchip: Add include guard to irq-partition-percpu.h
      irqchip/uniphier-aidet: Use devm_platform_ioremap_resource()

Ming Lei (3):
      genirq/affinity: Improve __irq_build_affinity_masks()
      genirq/affinity: Spread vectors on node according to nr_cpu ratio
      genirq/affinity: Remove const qualifier from node_to_cpumask argument

Stephen Boyd (1):
      irqchip: Remove dev_err() usage after platform_get_irq()

Thomas Gleixner (1):
      genirq: Force interrupt threading on RT

Zenghui Yu (1):
      irqchip/gic-v3-its: Remove the redundant set_bit for lpi_map


 Documentation/arm64/silicon-errata.rst             |   2 +
 .../amlogic,meson-gpio-intc.txt                    |   1 +
 .../bindings/interrupt-controller/arm,gic-v3.yaml  |   6 +-
 arch/arm/mach-mmp/regs-icu.h                       |   3 +
 drivers/gpio/gpio-ixp4xx.c                         |   2 +-
 drivers/irqchip/irq-gic-common.c                   |  35 +-
 drivers/irqchip/irq-gic-common.h                   |   2 +-
 drivers/irqchip/irq-gic-v2m.c                      |   2 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  13 +-
 drivers/irqchip/irq-gic-v3.c                       | 384 ++++++++++++++++-----
 drivers/irqchip/irq-gic.c                          |  14 +-
 drivers/irqchip/irq-hip04.c                        |   9 +-
 drivers/irqchip/irq-imgpdc.c                       |   8 +-
 drivers/irqchip/irq-ixp4xx.c                       |   2 +-
 drivers/irqchip/irq-keystone.c                     |   4 +-
 drivers/irqchip/irq-meson-gpio.c                   |  52 ++-
 drivers/irqchip/irq-mmp.c                          |  86 ++++-
 drivers/irqchip/irq-uniphier-aidet.c               |   4 +-
 drivers/irqchip/qcom-irq-combiner.c                |   4 +-
 drivers/pci/controller/pci-hyperv.c                |  10 +-
 include/linux/interrupt.h                          |   4 +
 include/linux/irqchip/arm-gic-v3.h                 |  30 +-
 include/linux/irqchip/irq-partition-percpu.h       |   5 +
 include/linux/irqdomain.h                          |   6 +-
 kernel/irq/affinity.c                              | 231 +++++++++++--
 kernel/irq/irqdomain.c                             |  10 +-
 kernel/irq/manage.c                                |   2 +-
 27 files changed, 735 insertions(+), 196 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 3e57d09246e6..17ea3fecddaa 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -115,6 +115,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Hisilicon      | Hip0{6,7}       | #161010701      | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
+| Hisilicon      | Hip0{6,7}       | #161010803      | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 | Hisilicon      | Hip07           | #161600802      | HISILICON_ERRATUM_161600802 |
 +----------------+-----------------+-----------------+-----------------------------+
 | Hisilicon      | Hip08 SMMU PMCG | #162001800      | N/A                         |
diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
index 7d531d5fff29..684bb1cd75ec 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
@@ -16,6 +16,7 @@ Required properties:
     "amlogic,meson-gxl-gpio-intc" for GXL SoCs (S905X, S912)
     "amlogic,meson-axg-gpio-intc" for AXG SoCs (A113D, A113X)
     "amlogic,meson-g12a-gpio-intc" for G12A SoCs (S905D2, S905X2, S905Y2)
+    "amlogic,meson-sm1-gpio-intc" for SM1 SoCs (S905D3, S905X3, S905Y3)
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller.
 - #interrupt-cells : Specifies the number of cells needed to encode an
diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index c34df35a25fc..1fe147daca4c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -44,11 +44,13 @@ properties:
       be at least 4.
 
       The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
-      interrupts. Other values are reserved for future use.
+      interrupts, 2 for interrupts in the Extended SPI range, 3 for the
+      Extended PPI range. Other values are reserved for future use.
 
       The 2nd cell contains the interrupt number for the interrupt type.
       SPI interrupts are in the range [0-987]. PPI interrupts are in the
-      range [0-15].
+      range [0-15]. Extented SPI interrupts are in the range [0-1023].
+      Extended PPI interrupts are in the range [0-127].
 
       The 3rd cell is the flags, encoded as follows:
       bits[3:0] trigger type and level flags.
diff --git a/arch/arm/mach-mmp/regs-icu.h b/arch/arm/mach-mmp/regs-icu.h
index 0375d5a7fcb2..410743d2b402 100644
--- a/arch/arm/mach-mmp/regs-icu.h
+++ b/arch/arm/mach-mmp/regs-icu.h
@@ -11,6 +11,9 @@
 #define ICU_VIRT_BASE	(AXI_VIRT_BASE + 0x82000)
 #define ICU_REG(x)	(ICU_VIRT_BASE + (x))
 
+#define ICU2_VIRT_BASE	(AXI_VIRT_BASE + 0x84000)
+#define ICU2_REG(x)	(ICU2_VIRT_BASE + (x))
+
 #define ICU_INT_CONF(n)		ICU_REG((n) << 2)
 #define ICU_INT_CONF_MASK	(0xf)
 
diff --git a/drivers/gpio/gpio-ixp4xx.c b/drivers/gpio/gpio-ixp4xx.c
index 670c2a85a35b..cc72c9aca5a1 100644
--- a/drivers/gpio/gpio-ixp4xx.c
+++ b/drivers/gpio/gpio-ixp4xx.c
@@ -400,7 +400,7 @@ static int ixp4xx_gpio_probe(struct platform_device *pdev)
 		g->fwnode = of_node_to_fwnode(np);
 	} else {
 		parent = ixp4xx_get_irq_domain();
-		g->fwnode = irq_domain_alloc_fwnode(g->base);
+		g->fwnode = irq_domain_alloc_fwnode(&res->start);
 		if (!g->fwnode) {
 			dev_err(dev, "no domain base\n");
 			return -ENODEV;
diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index b0a8215a13fc..82520006195d 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -41,6 +41,8 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 		void *data)
 {
 	for (; quirks->desc; quirks++) {
+		if (quirks->compatible)
+			continue;
 		if (quirks->iidr != (quirks->mask & iidr))
 			continue;
 		if (quirks->init(data))
@@ -63,7 +65,7 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 	 * for "irq", depending on "type".
 	 */
 	raw_spin_lock_irqsave(&irq_controller_lock, flags);
-	val = oldval = readl_relaxed(base + GIC_DIST_CONFIG + confoff);
+	val = oldval = readl_relaxed(base + confoff);
 	if (type & IRQ_TYPE_LEVEL_MASK)
 		val &= ~confmask;
 	else if (type & IRQ_TYPE_EDGE_BOTH)
@@ -83,14 +85,10 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 	 * does not allow us to set the configuration or we are in a
 	 * non-secure mode, and hence it may not be catastrophic.
 	 */
-	writel_relaxed(val, base + GIC_DIST_CONFIG + confoff);
-	if (readl_relaxed(base + GIC_DIST_CONFIG + confoff) != val) {
-		if (WARN_ON(irq >= 32))
-			ret = -EINVAL;
-		else
-			pr_warn("GIC: PPI%d is secure or misconfigured\n",
-				irq - 16);
-	}
+	writel_relaxed(val, base + confoff);
+	if (readl_relaxed(base + confoff) != val)
+		ret = -EINVAL;
+
 	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 
 	if (sync_access)
@@ -132,26 +130,31 @@ void gic_dist_config(void __iomem *base, int gic_irqs,
 		sync_access();
 }
 
-void gic_cpu_config(void __iomem *base, void (*sync_access)(void))
+void gic_cpu_config(void __iomem *base, int nr, void (*sync_access)(void))
 {
 	int i;
 
 	/*
 	 * Deal with the banked PPI and SGI interrupts - disable all
-	 * PPI interrupts, ensure all SGI interrupts are enabled.
-	 * Make sure everything is deactivated.
+	 * private interrupts. Make sure everything is deactivated.
 	 */
-	writel_relaxed(GICD_INT_EN_CLR_X32, base + GIC_DIST_ACTIVE_CLEAR);
-	writel_relaxed(GICD_INT_EN_CLR_PPI, base + GIC_DIST_ENABLE_CLEAR);
-	writel_relaxed(GICD_INT_EN_SET_SGI, base + GIC_DIST_ENABLE_SET);
+	for (i = 0; i < nr; i += 32) {
+		writel_relaxed(GICD_INT_EN_CLR_X32,
+			       base + GIC_DIST_ACTIVE_CLEAR + i / 8);
+		writel_relaxed(GICD_INT_EN_CLR_X32,
+			       base + GIC_DIST_ENABLE_CLEAR + i / 8);
+	}
 
 	/*
 	 * Set priority on PPI and SGI interrupts
 	 */
-	for (i = 0; i < 32; i += 4)
+	for (i = 0; i < nr; i += 4)
 		writel_relaxed(GICD_INT_DEF_PRI_X4,
 					base + GIC_DIST_PRI + i * 4 / 4);
 
+	/* Ensure all SGI interrupts are now enabled */
+	writel_relaxed(GICD_INT_EN_SET_SGI, base + GIC_DIST_ENABLE_SET);
+
 	if (sync_access)
 		sync_access();
 }
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index 5a46b6b57750..ccba8b0fe0f5 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -22,7 +22,7 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
                        void __iomem *base, void (*sync_access)(void));
 void gic_dist_config(void __iomem *base, int gic_irqs,
 		     void (*sync_access)(void));
-void gic_cpu_config(void __iomem *base, void (*sync_access)(void));
+void gic_cpu_config(void __iomem *base, int nr, void (*sync_access)(void));
 void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 		void *data);
 void gic_enable_of_quirks(const struct device_node *np,
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 7338f90b2f9e..e88e75c22b6a 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -525,7 +525,7 @@ acpi_parse_madt_msi(union acpi_subtable_headers *header,
 			spi_start, nr_spis);
 	}
 
-	fwnode = irq_domain_alloc_fwnode((void *)m->base_address);
+	fwnode = irq_domain_alloc_fwnode(&res.start);
 	if (!fwnode) {
 		pr_err("Unable to allocate GICv2m domain token\n");
 		return -EINVAL;
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1b5c3672aea2..62e54f1a248b 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2464,6 +2464,7 @@ static int its_alloc_device_irq(struct its_device *dev, int nvecs, irq_hw_number
 {
 	int idx;
 
+	/* Find a free LPI region in lpi_map and allocate them. */
 	idx = bitmap_find_free_region(dev->event_map.lpi_map,
 				      dev->event_map.nr_lpis,
 				      get_count_order(nvecs));
@@ -2471,7 +2472,6 @@ static int its_alloc_device_irq(struct its_device *dev, int nvecs, irq_hw_number
 		return -ENOSPC;
 
 	*hwirq = dev->event_map.lpi_base + idx;
-	set_bit(idx, dev->event_map.lpi_map);
 
 	return 0;
 }
@@ -2641,14 +2641,13 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 	struct its_node *its = its_dev->its;
 	int i;
 
+	bitmap_release_region(its_dev->event_map.lpi_map,
+			      its_get_event_id(irq_domain_get_irq_data(domain, virq)),
+			      get_count_order(nr_irqs));
+
 	for (i = 0; i < nr_irqs; i++) {
 		struct irq_data *data = irq_domain_get_irq_data(domain,
 								virq + i);
-		u32 event = its_get_event_id(data);
-
-		/* Mark interrupt index as unused */
-		clear_bit(event, its_dev->event_map.lpi_map);
-
 		/* Nuke the entry in the domain */
 		irq_domain_reset_irq_data(data);
 	}
@@ -3921,7 +3920,7 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
 	res.end = its_entry->base_address + ACPI_GICV3_ITS_MEM_SIZE - 1;
 	res.flags = IORESOURCE_MEM;
 
-	dom_handle = irq_domain_alloc_fwnode((void *)its_entry->base_address);
+	dom_handle = irq_domain_alloc_fwnode(&res.start);
 	if (!dom_handle) {
 		pr_err("ITS@%pa: Unable to allocate GICv3 ITS domain token\n",
 		       &res.start);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 96d927f0f91a..422664ac5f53 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -51,13 +51,17 @@ struct gic_chip_data {
 	u32			nr_redist_regions;
 	u64			flags;
 	bool			has_rss;
-	unsigned int		irq_nr;
-	struct partition_desc	*ppi_descs[16];
+	unsigned int		ppi_nr;
+	struct partition_desc	**ppi_descs;
 };
 
 static struct gic_chip_data gic_data __read_mostly;
 static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 
+#define GIC_ID_NR	(1U << GICD_TYPER_ID_BITS(gic_data.rdists.gicd_typer))
+#define GIC_LINE_NR	max(GICD_TYPER_SPIS(gic_data.rdists.gicd_typer), 1020U)
+#define GIC_ESPI_NR	GICD_TYPER_ESPIS(gic_data.rdists.gicd_typer)
+
 /*
  * The behaviours of RPR and PMR registers differ depending on the value of
  * SCR_EL3.FIQ, and the behaviour of non-secure priority registers of the
@@ -84,7 +88,7 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 static DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
 
 /* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
-static refcount_t ppi_nmi_refs[16];
+static refcount_t *ppi_nmi_refs;
 
 static struct gic_kvm_info gic_v3_kvm_info;
 static DEFINE_PER_CPU(bool, has_rss);
@@ -97,6 +101,38 @@ static DEFINE_PER_CPU(bool, has_rss);
 /* Our default, arbitrary priority value. Linux only uses one anyway. */
 #define DEFAULT_PMR_VALUE	0xf0
 
+enum gic_intid_range {
+	PPI_RANGE,
+	SPI_RANGE,
+	EPPI_RANGE,
+	ESPI_RANGE,
+	LPI_RANGE,
+	__INVALID_RANGE__
+};
+
+static enum gic_intid_range __get_intid_range(irq_hw_number_t hwirq)
+{
+	switch (hwirq) {
+	case 16 ... 31:
+		return PPI_RANGE;
+	case 32 ... 1019:
+		return SPI_RANGE;
+	case EPPI_BASE_INTID ... (EPPI_BASE_INTID + 63):
+		return EPPI_RANGE;
+	case ESPI_BASE_INTID ... (ESPI_BASE_INTID + 1023):
+		return ESPI_RANGE;
+	case 8192 ... GENMASK(23, 0):
+		return LPI_RANGE;
+	default:
+		return __INVALID_RANGE__;
+	}
+}
+
+static enum gic_intid_range get_intid_range(struct irq_data *d)
+{
+	return __get_intid_range(d->hwirq);
+}
+
 static inline unsigned int gic_irq(struct irq_data *d)
 {
 	return d->hwirq;
@@ -104,18 +140,26 @@ static inline unsigned int gic_irq(struct irq_data *d)
 
 static inline int gic_irq_in_rdist(struct irq_data *d)
 {
-	return gic_irq(d) < 32;
+	enum gic_intid_range range = get_intid_range(d);
+	return range == PPI_RANGE || range == EPPI_RANGE;
 }
 
 static inline void __iomem *gic_dist_base(struct irq_data *d)
 {
-	if (gic_irq_in_rdist(d))	/* SGI+PPI -> SGI_base for this CPU */
+	switch (get_intid_range(d)) {
+	case PPI_RANGE:
+	case EPPI_RANGE:
+		/* SGI+PPI -> SGI_base for this CPU */
 		return gic_data_rdist_sgi_base();
 
-	if (d->hwirq <= 1023)		/* SPI -> dist_base */
+	case SPI_RANGE:
+	case ESPI_RANGE:
+		/* SPI -> dist_base */
 		return gic_data.dist_base;
 
-	return NULL;
+	default:
+		return NULL;
+	}
 }
 
 static void gic_do_wait_for_rwp(void __iomem *base)
@@ -196,24 +240,79 @@ static void gic_enable_redist(bool enable)
 /*
  * Routines to disable, enable, EOI and route interrupts
  */
+static u32 convert_offset_index(struct irq_data *d, u32 offset, u32 *index)
+{
+	switch (get_intid_range(d)) {
+	case PPI_RANGE:
+	case SPI_RANGE:
+		*index = d->hwirq;
+		return offset;
+	case EPPI_RANGE:
+		/*
+		 * Contrary to the ESPI range, the EPPI range is contiguous
+		 * to the PPI range in the registers, so let's adjust the
+		 * displacement accordingly. Consistency is overrated.
+		 */
+		*index = d->hwirq - EPPI_BASE_INTID + 32;
+		return offset;
+	case ESPI_RANGE:
+		*index = d->hwirq - ESPI_BASE_INTID;
+		switch (offset) {
+		case GICD_ISENABLER:
+			return GICD_ISENABLERnE;
+		case GICD_ICENABLER:
+			return GICD_ICENABLERnE;
+		case GICD_ISPENDR:
+			return GICD_ISPENDRnE;
+		case GICD_ICPENDR:
+			return GICD_ICPENDRnE;
+		case GICD_ISACTIVER:
+			return GICD_ISACTIVERnE;
+		case GICD_ICACTIVER:
+			return GICD_ICACTIVERnE;
+		case GICD_IPRIORITYR:
+			return GICD_IPRIORITYRnE;
+		case GICD_ICFGR:
+			return GICD_ICFGRnE;
+		case GICD_IROUTER:
+			return GICD_IROUTERnE;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	WARN_ON(1);
+	*index = d->hwirq;
+	return offset;
+}
+
 static int gic_peek_irq(struct irq_data *d, u32 offset)
 {
-	u32 mask = 1 << (gic_irq(d) % 32);
 	void __iomem *base;
+	u32 index, mask;
+
+	offset = convert_offset_index(d, offset, &index);
+	mask = 1 << (index % 32);
 
 	if (gic_irq_in_rdist(d))
 		base = gic_data_rdist_sgi_base();
 	else
 		base = gic_data.dist_base;
 
-	return !!(readl_relaxed(base + offset + (gic_irq(d) / 32) * 4) & mask);
+	return !!(readl_relaxed(base + offset + (index / 32) * 4) & mask);
 }
 
 static void gic_poke_irq(struct irq_data *d, u32 offset)
 {
-	u32 mask = 1 << (gic_irq(d) % 32);
 	void (*rwp_wait)(void);
 	void __iomem *base;
+	u32 index, mask;
+
+	offset = convert_offset_index(d, offset, &index);
+	mask = 1 << (index % 32);
 
 	if (gic_irq_in_rdist(d)) {
 		base = gic_data_rdist_sgi_base();
@@ -223,7 +322,7 @@ static void gic_poke_irq(struct irq_data *d, u32 offset)
 		rwp_wait = gic_dist_wait_for_rwp;
 	}
 
-	writel_relaxed(mask, base + offset + (gic_irq(d) / 32) * 4);
+	writel_relaxed(mask, base + offset + (index / 32) * 4);
 	rwp_wait();
 }
 
@@ -263,7 +362,7 @@ static int gic_irq_set_irqchip_state(struct irq_data *d,
 {
 	u32 reg;
 
-	if (d->hwirq >= gic_data.irq_nr) /* PPI/SPI only */
+	if (d->hwirq >= 8192) /* PPI/SPI only */
 		return -EINVAL;
 
 	switch (which) {
@@ -290,7 +389,7 @@ static int gic_irq_set_irqchip_state(struct irq_data *d,
 static int gic_irq_get_irqchip_state(struct irq_data *d,
 				     enum irqchip_irq_state which, bool *val)
 {
-	if (d->hwirq >= gic_data.irq_nr) /* PPI/SPI only */
+	if (d->hwirq >= 8192) /* PPI/SPI only */
 		return -EINVAL;
 
 	switch (which) {
@@ -316,8 +415,23 @@ static int gic_irq_get_irqchip_state(struct irq_data *d,
 static void gic_irq_set_prio(struct irq_data *d, u8 prio)
 {
 	void __iomem *base = gic_dist_base(d);
+	u32 offset, index;
+
+	offset = convert_offset_index(d, GICD_IPRIORITYR, &index);
 
-	writeb_relaxed(prio, base + GICD_IPRIORITYR + gic_irq(d));
+	writeb_relaxed(prio, base + offset + index);
+}
+
+static u32 gic_get_ppi_index(struct irq_data *d)
+{
+	switch (get_intid_range(d)) {
+	case PPI_RANGE:
+		return d->hwirq - 16;
+	case EPPI_RANGE:
+		return d->hwirq - EPPI_BASE_INTID + 16;
+	default:
+		unreachable();
+	}
 }
 
 static int gic_irq_nmi_setup(struct irq_data *d)
@@ -340,10 +454,12 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 		return -EINVAL;
 
 	/* desc lock should already be held */
-	if (gic_irq(d) < 32) {
+	if (gic_irq_in_rdist(d)) {
+		u32 idx = gic_get_ppi_index(d);
+
 		/* Setting up PPI as NMI, only switch handler for first NMI */
-		if (!refcount_inc_not_zero(&ppi_nmi_refs[gic_irq(d) - 16])) {
-			refcount_set(&ppi_nmi_refs[gic_irq(d) - 16], 1);
+		if (!refcount_inc_not_zero(&ppi_nmi_refs[idx])) {
+			refcount_set(&ppi_nmi_refs[idx], 1);
 			desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
 		}
 	} else {
@@ -375,9 +491,11 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 		return;
 
 	/* desc lock should already be held */
-	if (gic_irq(d) < 32) {
+	if (gic_irq_in_rdist(d)) {
+		u32 idx = gic_get_ppi_index(d);
+
 		/* Tearing down NMI, only switch handler for last NMI */
-		if (refcount_dec_and_test(&ppi_nmi_refs[gic_irq(d) - 16]))
+		if (refcount_dec_and_test(&ppi_nmi_refs[idx]))
 			desc->handle_irq = handle_percpu_devid_irq;
 	} else {
 		desc->handle_irq = handle_fasteoi_irq;
@@ -404,17 +522,22 @@ static void gic_eoimode1_eoi_irq(struct irq_data *d)
 
 static int gic_set_type(struct irq_data *d, unsigned int type)
 {
+	enum gic_intid_range range;
 	unsigned int irq = gic_irq(d);
 	void (*rwp_wait)(void);
 	void __iomem *base;
+	u32 offset, index;
+	int ret;
 
 	/* Interrupt configuration for SGIs can't be changed */
 	if (irq < 16)
 		return -EINVAL;
 
+	range = get_intid_range(d);
+
 	/* SPIs have restrictions on the supported types */
-	if (irq >= 32 && type != IRQ_TYPE_LEVEL_HIGH &&
-			 type != IRQ_TYPE_EDGE_RISING)
+	if ((range == SPI_RANGE || range == ESPI_RANGE) &&
+	    type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
 
 	if (gic_irq_in_rdist(d)) {
@@ -425,7 +548,16 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 		rwp_wait = gic_dist_wait_for_rwp;
 	}
 
-	return gic_configure_irq(irq, type, base, rwp_wait);
+	offset = convert_offset_index(d, GICD_ICFGR, &index);
+
+	ret = gic_configure_irq(index, type, base + offset, rwp_wait);
+	if (ret && (range == PPI_RANGE || range == EPPI_RANGE)) {
+		/* Misconfigured PPIs are usually not fatal */
+		pr_warn("GIC: PPI INTID%d is secure or misconfigured\n", irq);
+		ret = 0;
+	}
+
+	return ret;
 }
 
 static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
@@ -500,7 +632,12 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 		gic_arch_enable_irqs();
 	}
 
-	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
+	/* Check for special IDs first */
+	if ((irqnr >= 1020 && irqnr <= 1023))
+		return;
+
+	/* Treat anything but SGIs in a uniform way */
+	if (likely(irqnr > 15)) {
 		int err;
 
 		if (static_branch_likely(&supports_deactivate_key))
@@ -588,10 +725,26 @@ static void __init gic_dist_init(void)
 	 * do the right thing if the kernel is running in secure mode,
 	 * but that's not the intended use case anyway.
 	 */
-	for (i = 32; i < gic_data.irq_nr; i += 32)
+	for (i = 32; i < GIC_LINE_NR; i += 32)
 		writel_relaxed(~0, base + GICD_IGROUPR + i / 8);
 
-	gic_dist_config(base, gic_data.irq_nr, gic_dist_wait_for_rwp);
+	/* Extended SPI range, not handled by the GICv2/GICv3 common code */
+	for (i = 0; i < GIC_ESPI_NR; i += 32) {
+		writel_relaxed(~0U, base + GICD_ICENABLERnE + i / 8);
+		writel_relaxed(~0U, base + GICD_ICACTIVERnE + i / 8);
+	}
+
+	for (i = 0; i < GIC_ESPI_NR; i += 32)
+		writel_relaxed(~0U, base + GICD_IGROUPRnE + i / 8);
+
+	for (i = 0; i < GIC_ESPI_NR; i += 16)
+		writel_relaxed(0, base + GICD_ICFGRnE + i / 4);
+
+	for (i = 0; i < GIC_ESPI_NR; i += 4)
+		writel_relaxed(GICD_INT_DEF_PRI_X4, base + GICD_IPRIORITYRnE + i);
+
+	/* Now do the common stuff, and wait for the distributor to drain */
+	gic_dist_config(base, GIC_LINE_NR, gic_dist_wait_for_rwp);
 
 	/* Enable distributor with ARE, Group1 */
 	writel_relaxed(GICD_CTLR_ARE_NS | GICD_CTLR_ENABLE_G1A | GICD_CTLR_ENABLE_G1,
@@ -602,8 +755,11 @@ static void __init gic_dist_init(void)
 	 * enabled.
 	 */
 	affinity = gic_mpidr_to_affinity(cpu_logical_map(smp_processor_id()));
-	for (i = 32; i < gic_data.irq_nr; i++)
+	for (i = 32; i < GIC_LINE_NR; i++)
 		gic_write_irouter(affinity, base + GICD_IROUTER + i * 8);
+
+	for (i = 0; i < GIC_ESPI_NR; i++)
+		gic_write_irouter(affinity, base + GICD_IROUTERnE + i * 8);
 }
 
 static int gic_iterate_rdists(int (*fn)(struct redist_region *, void __iomem *))
@@ -689,19 +845,24 @@ static int gic_populate_rdist(void)
 	return -ENODEV;
 }
 
-static int __gic_update_vlpi_properties(struct redist_region *region,
-					void __iomem *ptr)
+static int __gic_update_rdist_properties(struct redist_region *region,
+					 void __iomem *ptr)
 {
 	u64 typer = gic_read_typer(ptr + GICR_TYPER);
 	gic_data.rdists.has_vlpis &= !!(typer & GICR_TYPER_VLPIS);
 	gic_data.rdists.has_direct_lpi &= !!(typer & GICR_TYPER_DirectLPIS);
+	gic_data.ppi_nr = min(GICR_TYPER_NR_PPIS(typer), gic_data.ppi_nr);
 
 	return 1;
 }
 
-static void gic_update_vlpi_properties(void)
+static void gic_update_rdist_properties(void)
 {
-	gic_iterate_rdists(__gic_update_vlpi_properties);
+	gic_data.ppi_nr = UINT_MAX;
+	gic_iterate_rdists(__gic_update_rdist_properties);
+	if (WARN_ON(gic_data.ppi_nr == UINT_MAX))
+		gic_data.ppi_nr = 0;
+	pr_info("%d PPIs implemented\n", gic_data.ppi_nr);
 	pr_info("%sVLPI support, %sdirect LPI support\n",
 		!gic_data.rdists.has_vlpis ? "no " : "",
 		!gic_data.rdists.has_direct_lpi ? "no " : "");
@@ -845,6 +1006,7 @@ static int gic_dist_supports_lpis(void)
 static void gic_cpu_init(void)
 {
 	void __iomem *rbase;
+	int i;
 
 	/* Register ourselves with the rest of the world */
 	if (gic_populate_rdist())
@@ -852,12 +1014,18 @@ static void gic_cpu_init(void)
 
 	gic_enable_redist(true);
 
+	WARN((gic_data.ppi_nr > 16 || GIC_ESPI_NR != 0) &&
+	     !(gic_read_ctlr() & ICC_CTLR_EL1_ExtRange),
+	     "Distributor has extended ranges, but CPU%d doesn't\n",
+	     smp_processor_id());
+
 	rbase = gic_data_rdist_sgi_base();
 
 	/* Configure SGIs/PPIs as non-secure Group-1 */
-	writel_relaxed(~0, rbase + GICR_IGROUPR0);
+	for (i = 0; i < gic_data.ppi_nr + 16; i += 32)
+		writel_relaxed(~0, rbase + GICR_IGROUPR0 + i / 8);
 
-	gic_cpu_config(rbase, gic_redist_wait_for_rwp);
+	gic_cpu_config(rbase, gic_data.ppi_nr + 16, gic_redist_wait_for_rwp);
 
 	/* initialise system registers */
 	gic_cpu_sys_reg_init();
@@ -961,6 +1129,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 			    bool force)
 {
 	unsigned int cpu;
+	u32 offset, index;
 	void __iomem *reg;
 	int enabled;
 	u64 val;
@@ -981,7 +1150,8 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	if (enabled)
 		gic_mask_irq(d);
 
-	reg = gic_dist_base(d) + GICD_IROUTER + (gic_irq(d) * 8);
+	offset = convert_offset_index(d, GICD_IROUTER, &index);
+	reg = gic_dist_base(d) + offset + (index * 8);
 	val = gic_mpidr_to_affinity(cpu_logical_map(cpu));
 
 	gic_write_irouter(val, reg);
@@ -1065,8 +1235,6 @@ static struct irq_chip gic_eoimode1_chip = {
 				  IRQCHIP_MASK_ON_SUSPEND,
 };
 
-#define GIC_ID_NR	(1U << GICD_TYPER_ID_BITS(gic_data.rdists.gicd_typer))
-
 static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hw)
 {
@@ -1075,36 +1243,32 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	if (static_branch_likely(&supports_deactivate_key))
 		chip = &gic_eoimode1_chip;
 
-	/* SGIs are private to the core kernel */
-	if (hw < 16)
-		return -EPERM;
-	/* Nothing here */
-	if (hw >= gic_data.irq_nr && hw < 8192)
-		return -EPERM;
-	/* Off limits */
-	if (hw >= GIC_ID_NR)
-		return -EPERM;
-
-	/* PPIs */
-	if (hw < 32) {
+	switch (__get_intid_range(hw)) {
+	case PPI_RANGE:
+	case EPPI_RANGE:
 		irq_set_percpu_devid(irq);
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
-	}
-	/* SPIs */
-	if (hw >= 32 && hw < gic_data.irq_nr) {
+		break;
+
+	case SPI_RANGE:
+	case ESPI_RANGE:
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irq_set_probe(irq);
 		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
-	}
-	/* LPIs */
-	if (hw >= 8192 && hw < GIC_ID_NR) {
+		break;
+
+	case LPI_RANGE:
 		if (!gic_dist_supports_lpis())
 			return -EPERM;
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
+		break;
+
+	default:
+		return -EPERM;
 	}
 
 	return 0;
@@ -1126,12 +1290,24 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 			*hwirq = fwspec->param[1] + 32;
 			break;
 		case 1:			/* PPI */
-		case GIC_IRQ_TYPE_PARTITION:
 			*hwirq = fwspec->param[1] + 16;
 			break;
+		case 2:			/* ESPI */
+			*hwirq = fwspec->param[1] + ESPI_BASE_INTID;
+			break;
+		case 3:			/* EPPI */
+			*hwirq = fwspec->param[1] + EPPI_BASE_INTID;
+			break;
 		case GIC_IRQ_TYPE_LPI:	/* LPI */
 			*hwirq = fwspec->param[1];
 			break;
+		case GIC_IRQ_TYPE_PARTITION:
+			*hwirq = fwspec->param[1];
+			if (fwspec->param[1] >= 16)
+				*hwirq += EPPI_BASE_INTID - 16;
+			else
+				*hwirq += 16;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1211,7 +1387,8 @@ static int gic_irq_domain_select(struct irq_domain *d,
 	 * then we need to match the partition domain.
 	 */
 	if (fwspec->param_count >= 4 &&
-	    fwspec->param[0] == 1 && fwspec->param[3] != 0)
+	    fwspec->param[0] == 1 && fwspec->param[3] != 0 &&
+	    gic_data.ppi_descs)
 		return d == partition_get_domain(gic_data.ppi_descs[fwspec->param[1]]);
 
 	return d == gic_data.domain;
@@ -1232,6 +1409,9 @@ static int partition_domain_translate(struct irq_domain *d,
 	struct device_node *np;
 	int ret;
 
+	if (!gic_data.ppi_descs)
+		return -ENOMEM;
+
 	np = of_find_node_by_phandle(fwspec->param[3]);
 	if (WARN_ON(!np))
 		return -EINVAL;
@@ -1261,11 +1441,65 @@ static bool gic_enable_quirk_msm8996(void *data)
 	return true;
 }
 
+static bool gic_enable_quirk_hip06_07(void *data)
+{
+	struct gic_chip_data *d = data;
+
+	/*
+	 * HIP06 GICD_IIDR clashes with GIC-600 product number (despite
+	 * not being an actual ARM implementation). The saving grace is
+	 * that GIC-600 doesn't have ESPI, so nothing to do in that case.
+	 * HIP07 doesn't even have a proper IIDR, and still pretends to
+	 * have ESPI. In both cases, put them right.
+	 */
+	if (d->rdists.gicd_typer & GICD_TYPER_ESPI) {
+		/* Zero both ESPI and the RES0 field next to it... */
+		d->rdists.gicd_typer &= ~GENMASK(9, 8);
+		return true;
+	}
+
+	return false;
+}
+
+static const struct gic_quirk gic_quirks[] = {
+	{
+		.desc	= "GICv3: Qualcomm MSM8996 broken firmware",
+		.compatible = "qcom,msm8996-gic-v3",
+		.init	= gic_enable_quirk_msm8996,
+	},
+	{
+		.desc	= "GICv3: HIP06 erratum 161010803",
+		.iidr	= 0x0204043b,
+		.mask	= 0xffffffff,
+		.init	= gic_enable_quirk_hip06_07,
+	},
+	{
+		.desc	= "GICv3: HIP07 erratum 161010803",
+		.iidr	= 0x00000000,
+		.mask	= 0xffffffff,
+		.init	= gic_enable_quirk_hip06_07,
+	},
+	{
+	}
+};
+
 static void gic_enable_nmi_support(void)
 {
 	int i;
 
-	for (i = 0; i < 16; i++)
+	if (!gic_prio_masking_enabled())
+		return;
+
+	if (gic_has_group0() && !gic_dist_security_disabled()) {
+		pr_warn("SCR_EL3.FIQ is cleared, cannot enable use of pseudo-NMIs\n");
+		return;
+	}
+
+	ppi_nmi_refs = kcalloc(gic_data.ppi_nr, sizeof(*ppi_nmi_refs), GFP_KERNEL);
+	if (!ppi_nmi_refs)
+		return;
+
+	for (i = 0; i < gic_data.ppi_nr; i++)
 		refcount_set(&ppi_nmi_refs[i], 0);
 
 	static_branch_enable(&supports_pseudo_nmis);
@@ -1283,7 +1517,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
 				 struct fwnode_handle *handle)
 {
 	u32 typer;
-	int gic_irqs;
 	int err;
 
 	if (!is_hyp_mode_available())
@@ -1300,15 +1533,15 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	/*
 	 * Find out how many interrupts are supported.
-	 * The GIC only supports up to 1020 interrupt sources (SGI+PPI+SPI)
 	 */
 	typer = readl_relaxed(gic_data.dist_base + GICD_TYPER);
 	gic_data.rdists.gicd_typer = typer;
-	gic_irqs = GICD_TYPER_IRQS(typer);
-	if (gic_irqs > 1020)
-		gic_irqs = 1020;
-	gic_data.irq_nr = gic_irqs;
 
+	gic_enable_quirks(readl_relaxed(gic_data.dist_base + GICD_IIDR),
+			  gic_quirks, &gic_data);
+
+	pr_info("%d SPIs implemented\n", GIC_LINE_NR - 32);
+	pr_info("%d Extended SPIs implemented\n", GIC_ESPI_NR);
 	gic_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
 						 &gic_data);
 	irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
@@ -1333,7 +1566,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	set_handle_irq(gic_handle_irq);
 
-	gic_update_vlpi_properties();
+	gic_update_rdist_properties();
 
 	gic_smp_init();
 	gic_dist_init();
@@ -1348,12 +1581,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 			gicv2m_init(handle, gic_data.domain);
 	}
 
-	if (gic_prio_masking_enabled()) {
-		if (!gic_has_group0() || gic_dist_security_disabled())
-			gic_enable_nmi_support();
-		else
-			pr_warn("SCR_EL3.FIQ is cleared, cannot enable use of pseudo-NMIs\n");
-	}
+	gic_enable_nmi_support();
 
 	return 0;
 
@@ -1386,6 +1614,10 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 	if (!parts_node)
 		return;
 
+	gic_data.ppi_descs = kcalloc(gic_data.ppi_nr, sizeof(*gic_data.ppi_descs), GFP_KERNEL);
+	if (!gic_data.ppi_descs)
+		return;
+
 	nr_parts = of_get_child_count(parts_node);
 
 	if (!nr_parts)
@@ -1437,7 +1669,7 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 		part_idx++;
 	}
 
-	for (i = 0; i < 16; i++) {
+	for (i = 0; i < gic_data.ppi_nr; i++) {
 		unsigned int irq;
 		struct partition_desc *desc;
 		struct irq_fwspec ppi_fwspec = {
@@ -1490,16 +1722,6 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
 	gic_set_kvm_info(&gic_v3_kvm_info);
 }
 
-static const struct gic_quirk gic_quirks[] = {
-	{
-		.desc	= "GICv3: Qualcomm MSM8996 broken firmware",
-		.compatible = "qcom,msm8996-gic-v3",
-		.init	= gic_enable_quirk_msm8996,
-	},
-	{
-	}
-};
-
 static int __init gic_of_init(struct device_node *node, struct device_node *parent)
 {
 	void __iomem *dist_base;
@@ -1845,7 +2067,7 @@ gic_acpi_init(struct acpi_subtable_header *header, const unsigned long end)
 	if (err)
 		goto out_redist_unmap;
 
-	domain_handle = irq_domain_alloc_fwnode(acpi_data.dist_base);
+	domain_handle = irq_domain_alloc_fwnode(&dist->base_address);
 	if (!domain_handle) {
 		err = -ENOMEM;
 		goto out_redist_unmap;
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index e45f45e68720..30ab623343d3 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -291,6 +291,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 {
 	void __iomem *base = gic_dist_base(d);
 	unsigned int gicirq = gic_irq(d);
+	int ret;
 
 	/* Interrupt configuration for SGIs can't be changed */
 	if (gicirq < 16)
@@ -301,7 +302,14 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 			    type != IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
 
-	return gic_configure_irq(gicirq, type, base, NULL);
+	ret = gic_configure_irq(gicirq, type, base + GIC_DIST_CONFIG, NULL);
+	if (ret && gicirq < 32) {
+		/* Misconfigured PPIs are usually not fatal */
+		pr_warn("GIC: PPI%d is secure or misconfigured\n", gicirq - 16);
+		ret = 0;
+	}
+
+	return ret;
 }
 
 static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
@@ -535,7 +543,7 @@ static int gic_cpu_init(struct gic_chip_data *gic)
 				gic_cpu_map[i] &= ~cpu_mask;
 	}
 
-	gic_cpu_config(dist_base, NULL);
+	gic_cpu_config(dist_base, 32, NULL);
 
 	writel_relaxed(GICC_INT_PRI_THRESHOLD, base + GIC_CPU_PRIMASK);
 	gic_cpu_if_up(gic);
@@ -1627,7 +1635,7 @@ static int __init gic_v2_acpi_init(struct acpi_subtable_header *header,
 	/*
 	 * Initialize GIC instance zero (no multi-GIC support).
 	 */
-	domain_handle = irq_domain_alloc_fwnode(gic->raw_dist_base);
+	domain_handle = irq_domain_alloc_fwnode(&dist->base_address);
 	if (!domain_handle) {
 		pr_err("Unable to allocate domain handle\n");
 		gic_teardown(gic);
diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index cf705827599c..130caa1c9d93 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -130,7 +130,12 @@ static int hip04_irq_set_type(struct irq_data *d, unsigned int type)
 
 	raw_spin_lock(&irq_controller_lock);
 
-	ret = gic_configure_irq(irq, type, base, NULL);
+	ret = gic_configure_irq(irq, type, base + GIC_DIST_CONFIG, NULL);
+	if (ret && irq < 32) {
+		/* Misconfigured PPIs are usually not fatal */
+		pr_warn("GIC: PPI%d is secure or misconfigured\n", irq - 16);
+		ret = 0;
+	}
 
 	raw_spin_unlock(&irq_controller_lock);
 
@@ -268,7 +273,7 @@ static void hip04_irq_cpu_init(struct hip04_irq_data *intc)
 		if (i != cpu)
 			hip04_cpu_map[i] &= ~cpu_mask;
 
-	gic_cpu_config(dist_base, NULL);
+	gic_cpu_config(dist_base, 32, NULL);
 
 	writel_relaxed(0xf0, base + GIC_CPU_PRIMASK);
 	writel_relaxed(1, base + GIC_CPU_CTRL);
diff --git a/drivers/irqchip/irq-imgpdc.c b/drivers/irqchip/irq-imgpdc.c
index d00489a4b54f..698d07f48fed 100644
--- a/drivers/irqchip/irq-imgpdc.c
+++ b/drivers/irqchip/irq-imgpdc.c
@@ -362,10 +362,8 @@ static int pdc_intc_probe(struct platform_device *pdev)
 	}
 	for (i = 0; i < priv->nr_perips; ++i) {
 		irq = platform_get_irq(pdev, 1 + i);
-		if (irq < 0) {
-			dev_err(&pdev->dev, "cannot find perip IRQ #%u\n", i);
+		if (irq < 0)
 			return irq;
-		}
 		priv->perip_irqs[i] = irq;
 	}
 	/* check if too many were provided */
@@ -376,10 +374,8 @@ static int pdc_intc_probe(struct platform_device *pdev)
 
 	/* Get syswake IRQ number */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "cannot find syswake IRQ\n");
+	if (irq < 0)
 		return irq;
-	}
 	priv->syswake_irq = irq;
 
 	/* Set up an IRQ domain */
diff --git a/drivers/irqchip/irq-ixp4xx.c b/drivers/irqchip/irq-ixp4xx.c
index 6751c35b7e1d..37e0749215c7 100644
--- a/drivers/irqchip/irq-ixp4xx.c
+++ b/drivers/irqchip/irq-ixp4xx.c
@@ -319,7 +319,7 @@ void __init ixp4xx_irq_init(resource_size_t irqbase,
 		pr_crit("IXP4XX: could not ioremap interrupt controller\n");
 		return;
 	}
-	fwnode = irq_domain_alloc_fwnode(base);
+	fwnode = irq_domain_alloc_fwnode(&irqbase);
 	if (!fwnode) {
 		pr_crit("IXP4XX: no domain handle\n");
 		return;
diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index efbcf8435185..8118ebe80b09 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -164,10 +164,8 @@ static int keystone_irq_probe(struct platform_device *pdev)
 	}
 
 	kirq->irq = platform_get_irq(pdev, 0);
-	if (kirq->irq < 0) {
-		dev_err(dev, "no irq resource %d\n", kirq->irq);
+	if (kirq->irq < 0)
 		return kirq->irq;
-	}
 
 	kirq->dev = dev;
 	kirq->mask = ~0x0;
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index dcdc23b9dce6..829084b568fa 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -24,14 +24,25 @@
 #define REG_PIN_47_SEL	0x08
 #define REG_FILTER_SEL	0x0c
 
-#define REG_EDGE_POL_MASK(x)	(BIT(x) | BIT(16 + (x)))
+/*
+ * Note: The S905X3 datasheet reports that BOTH_EDGE is controlled by
+ * bits 24 to 31. Tests on the actual HW show that these bits are
+ * stuck at 0. Bits 8 to 15 are responsive and have the expected
+ * effect.
+ */
 #define REG_EDGE_POL_EDGE(x)	BIT(x)
 #define REG_EDGE_POL_LOW(x)	BIT(16 + (x))
+#define REG_BOTH_EDGE(x)	BIT(8 + (x))
+#define REG_EDGE_POL_MASK(x)    (	\
+		REG_EDGE_POL_EDGE(x) |	\
+		REG_EDGE_POL_LOW(x)  |	\
+		REG_BOTH_EDGE(x))
 #define REG_PIN_SEL_SHIFT(x)	(((x) % 4) * 8)
 #define REG_FILTER_SEL_SHIFT(x)	((x) * 4)
 
 struct meson_gpio_irq_params {
 	unsigned int nr_hwirq;
+	bool support_edge_both;
 };
 
 static const struct meson_gpio_irq_params meson8_params = {
@@ -54,6 +65,11 @@ static const struct meson_gpio_irq_params axg_params = {
 	.nr_hwirq = 100,
 };
 
+static const struct meson_gpio_irq_params sm1_params = {
+	.nr_hwirq = 100,
+	.support_edge_both = true,
+};
+
 static const struct of_device_id meson_irq_gpio_matches[] = {
 	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
 	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params },
@@ -61,11 +77,12 @@ static const struct of_device_id meson_irq_gpio_matches[] = {
 	{ .compatible = "amlogic,meson-gxl-gpio-intc", .data = &gxl_params },
 	{ .compatible = "amlogic,meson-axg-gpio-intc", .data = &axg_params },
 	{ .compatible = "amlogic,meson-g12a-gpio-intc", .data = &axg_params },
+	{ .compatible = "amlogic,meson-sm1-gpio-intc", .data = &sm1_params },
 	{ }
 };
 
 struct meson_gpio_irq_controller {
-	unsigned int nr_hwirq;
+	const struct meson_gpio_irq_params *params;
 	void __iomem *base;
 	u32 channel_irqs[NUM_CHANNEL];
 	DECLARE_BITMAP(channel_map, NUM_CHANNEL);
@@ -168,14 +185,22 @@ static int meson_gpio_irq_type_setup(struct meson_gpio_irq_controller *ctl,
 	 */
 	type &= IRQ_TYPE_SENSE_MASK;
 
-	if (type == IRQ_TYPE_EDGE_BOTH)
-		return -EINVAL;
+	/*
+	 * New controller support EDGE_BOTH trigger. This setting takes
+	 * precedence over the other edge/polarity settings
+	 */
+	if (type == IRQ_TYPE_EDGE_BOTH) {
+		if (!ctl->params->support_edge_both)
+			return -EINVAL;
 
-	if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
-		val |= REG_EDGE_POL_EDGE(idx);
+		val |= REG_BOTH_EDGE(idx);
+	} else {
+		if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
+			val |= REG_EDGE_POL_EDGE(idx);
 
-	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING))
-		val |= REG_EDGE_POL_LOW(idx);
+		if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING))
+			val |= REG_EDGE_POL_LOW(idx);
+	}
 
 	spin_lock(&ctl->lock);
 
@@ -199,7 +224,7 @@ static unsigned int meson_gpio_irq_type_output(unsigned int type)
 	 */
 	if (sense & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
 		type |= IRQ_TYPE_LEVEL_HIGH;
-	else if (sense & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
+	else
 		type |= IRQ_TYPE_EDGE_RISING;
 
 	return type;
@@ -328,15 +353,13 @@ static int __init meson_gpio_irq_parse_dt(struct device_node *node,
 					  struct meson_gpio_irq_controller *ctl)
 {
 	const struct of_device_id *match;
-	const struct meson_gpio_irq_params *params;
 	int ret;
 
 	match = of_match_node(meson_irq_gpio_matches, node);
 	if (!match)
 		return -ENODEV;
 
-	params = match->data;
-	ctl->nr_hwirq = params->nr_hwirq;
+	ctl->params = match->data;
 
 	ret = of_property_read_variable_u32_array(node,
 						  "amlogic,channel-interrupts",
@@ -385,7 +408,8 @@ static int __init meson_gpio_irq_of_init(struct device_node *node,
 	if (ret)
 		goto free_channel_irqs;
 
-	domain = irq_domain_create_hierarchy(parent_domain, 0, ctl->nr_hwirq,
+	domain = irq_domain_create_hierarchy(parent_domain, 0,
+					     ctl->params->nr_hwirq,
 					     of_node_to_fwnode(node),
 					     &meson_gpio_irq_domain_ops,
 					     ctl);
@@ -396,7 +420,7 @@ static int __init meson_gpio_irq_of_init(struct device_node *node,
 	}
 
 	pr_info("%d to %d gpio interrupt mux initialized\n",
-		ctl->nr_hwirq, NUM_CHANNEL);
+		ctl->params->nr_hwirq, NUM_CHANNEL);
 
 	return 0;
 
diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 14618dc0bd39..4a74ac7b7c42 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
@@ -43,6 +44,7 @@ struct icu_chip_data {
 	unsigned int		conf_enable;
 	unsigned int		conf_disable;
 	unsigned int		conf_mask;
+	unsigned int		conf2_mask;
 	unsigned int		clr_mfp_irq_base;
 	unsigned int		clr_mfp_hwirq;
 	struct irq_domain	*domain;
@@ -52,9 +54,11 @@ struct mmp_intc_conf {
 	unsigned int	conf_enable;
 	unsigned int	conf_disable;
 	unsigned int	conf_mask;
+	unsigned int	conf2_mask;
 };
 
 static void __iomem *mmp_icu_base;
+static void __iomem *mmp_icu2_base;
 static struct icu_chip_data icu_data[MAX_ICU_NR];
 static int max_icu_nr;
 
@@ -97,6 +101,16 @@ static void icu_mask_irq(struct irq_data *d)
 		r &= ~data->conf_mask;
 		r |= data->conf_disable;
 		writel_relaxed(r, mmp_icu_base + (hwirq << 2));
+
+		if (data->conf2_mask) {
+			/*
+			 * ICU1 (above) only controls PJ4 MP1; if using SMP,
+			 * we need to also mask the MP2 and MM cores via ICU2.
+			 */
+			r = readl_relaxed(mmp_icu2_base + (hwirq << 2));
+			r &= ~data->conf2_mask;
+			writel_relaxed(r, mmp_icu2_base + (hwirq << 2));
+		}
 	} else {
 		r = readl_relaxed(data->reg_mask) | (1 << hwirq);
 		writel_relaxed(r, data->reg_mask);
@@ -132,11 +146,14 @@ struct irq_chip icu_irq_chip = {
 static void icu_mux_irq_demux(struct irq_desc *desc)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irq_domain *domain;
 	struct icu_chip_data *data;
 	int i;
 	unsigned long mask, status, n;
 
+	chained_irq_enter(chip, desc);
+
 	for (i = 1; i < max_icu_nr; i++) {
 		if (irq == icu_data[i].cascade_irq) {
 			domain = icu_data[i].domain;
@@ -146,7 +163,7 @@ static void icu_mux_irq_demux(struct irq_desc *desc)
 	}
 	if (i >= max_icu_nr) {
 		pr_err("Spurious irq %d in MMP INTC\n", irq);
-		return;
+		goto out;
 	}
 
 	mask = readl_relaxed(data->reg_mask);
@@ -158,6 +175,9 @@ static void icu_mux_irq_demux(struct irq_desc *desc)
 			generic_handle_irq(icu_data[i].virq_base + n);
 		}
 	}
+
+out:
+	chained_irq_exit(chip, desc);
 }
 
 static int mmp_irq_domain_map(struct irq_domain *d, unsigned int irq,
@@ -194,6 +214,14 @@ static const struct mmp_intc_conf mmp2_conf = {
 			  MMP2_ICU_INT_ROUTE_PJ4_FIQ,
 };
 
+static struct mmp_intc_conf mmp3_conf = {
+	.conf_enable	= 0x20,
+	.conf_disable	= 0x0,
+	.conf_mask	= MMP2_ICU_INT_ROUTE_PJ4_IRQ |
+			  MMP2_ICU_INT_ROUTE_PJ4_FIQ,
+	.conf2_mask	= 0xf0,
+};
+
 static void __exception_irq_entry mmp_handle_irq(struct pt_regs *regs)
 {
 	int hwirq;
@@ -395,7 +423,6 @@ static int __init mmp_of_init(struct device_node *node,
 	icu_data[0].conf_enable = mmp_conf.conf_enable;
 	icu_data[0].conf_disable = mmp_conf.conf_disable;
 	icu_data[0].conf_mask = mmp_conf.conf_mask;
-	irq_set_default_host(icu_data[0].domain);
 	set_handle_irq(mmp_handle_irq);
 	max_icu_nr = 1;
 	return 0;
@@ -414,19 +441,50 @@ static int __init mmp2_of_init(struct device_node *node,
 	icu_data[0].conf_enable = mmp2_conf.conf_enable;
 	icu_data[0].conf_disable = mmp2_conf.conf_disable;
 	icu_data[0].conf_mask = mmp2_conf.conf_mask;
-	irq_set_default_host(icu_data[0].domain);
 	set_handle_irq(mmp2_handle_irq);
 	max_icu_nr = 1;
 	return 0;
 }
 IRQCHIP_DECLARE(mmp2_intc, "mrvl,mmp2-intc", mmp2_of_init);
 
+static int __init mmp3_of_init(struct device_node *node,
+			       struct device_node *parent)
+{
+	int ret;
+
+	mmp_icu2_base = of_iomap(node, 1);
+	if (!mmp_icu2_base) {
+		pr_err("Failed to get interrupt controller register #2\n");
+		return -ENODEV;
+	}
+
+	ret = mmp_init_bases(node);
+	if (ret < 0) {
+		iounmap(mmp_icu2_base);
+		return ret;
+	}
+
+	icu_data[0].conf_enable = mmp3_conf.conf_enable;
+	icu_data[0].conf_disable = mmp3_conf.conf_disable;
+	icu_data[0].conf_mask = mmp3_conf.conf_mask;
+	icu_data[0].conf2_mask = mmp3_conf.conf2_mask;
+
+	if (!parent) {
+		/* This is the main interrupt controller. */
+		set_handle_irq(mmp2_handle_irq);
+	}
+
+	max_icu_nr = 1;
+	return 0;
+}
+IRQCHIP_DECLARE(mmp3_intc, "marvell,mmp3-intc", mmp3_of_init);
+
 static int __init mmp2_mux_of_init(struct device_node *node,
 				   struct device_node *parent)
 {
-	struct resource res;
 	int i, ret, irq, j = 0;
 	u32 nr_irqs, mfp_irq;
+	u32 reg[4];
 
 	if (!parent)
 		return -ENODEV;
@@ -438,18 +496,22 @@ static int __init mmp2_mux_of_init(struct device_node *node,
 		pr_err("Not found mrvl,intc-nr-irqs property\n");
 		return -EINVAL;
 	}
-	ret = of_address_to_resource(node, 0, &res);
-	if (ret < 0) {
-		pr_err("Not found reg property\n");
-		return -EINVAL;
-	}
-	icu_data[i].reg_status = mmp_icu_base + res.start;
-	ret = of_address_to_resource(node, 1, &res);
+
+	/*
+	 * For historical reasons, the "regs" property of the
+	 * mrvl,mmp2-mux-intc is not a regular "regs" property containing
+	 * addresses on the parent bus, but offsets from the intc's base.
+	 * That is why we can't use of_address_to_resource() here.
+	 */
+	ret = of_property_read_variable_u32_array(node, "reg", reg,
+						  ARRAY_SIZE(reg),
+						  ARRAY_SIZE(reg));
 	if (ret < 0) {
 		pr_err("Not found reg property\n");
 		return -EINVAL;
 	}
-	icu_data[i].reg_mask = mmp_icu_base + res.start;
+	icu_data[i].reg_status = mmp_icu_base + reg[0];
+	icu_data[i].reg_mask = mmp_icu_base + reg[2];
 	icu_data[i].cascade_irq = irq_of_parse_and_map(node, 0);
 	if (!icu_data[i].cascade_irq)
 		return -EINVAL;
diff --git a/drivers/irqchip/irq-uniphier-aidet.c b/drivers/irqchip/irq-uniphier-aidet.c
index ed7b4f47ff3f..89121b39be26 100644
--- a/drivers/irqchip/irq-uniphier-aidet.c
+++ b/drivers/irqchip/irq-uniphier-aidet.c
@@ -166,7 +166,6 @@ static int uniphier_aidet_probe(struct platform_device *pdev)
 	struct device_node *parent_np;
 	struct irq_domain *parent_domain;
 	struct uniphier_aidet_priv *priv;
-	struct resource *res;
 
 	parent_np = of_irq_find_parent(dev->of_node);
 	if (!parent_np)
@@ -181,8 +180,7 @@ static int uniphier_aidet_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->reg_base = devm_ioremap_resource(dev, res);
+	priv->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->reg_base))
 		return PTR_ERR(priv->reg_base);
 
diff --git a/drivers/irqchip/qcom-irq-combiner.c b/drivers/irqchip/qcom-irq-combiner.c
index d88e993aa66d..abfe59284ff2 100644
--- a/drivers/irqchip/qcom-irq-combiner.c
+++ b/drivers/irqchip/qcom-irq-combiner.c
@@ -248,10 +248,8 @@ static int __init combiner_probe(struct platform_device *pdev)
 		return err;
 
 	combiner->parent_irq = platform_get_irq(pdev, 0);
-	if (combiner->parent_irq <= 0) {
-		dev_err(&pdev->dev, "Error getting IRQ resource\n");
+	if (combiner->parent_irq <= 0)
 		return -EPROBE_DEFER;
-	}
 
 	combiner->domain = irq_domain_create_linear(pdev->dev.fwnode, combiner->nirqs,
 						    &domain_ops, combiner);
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 40b625458afa..97056f3dd317 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2521,6 +2521,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 			const struct hv_vmbus_device_id *dev_id)
 {
 	struct hv_pcibus_device *hbus;
+	char *name;
 	int ret;
 
 	/*
@@ -2589,7 +2590,14 @@ static int hv_pci_probe(struct hv_device *hdev,
 		goto free_config;
 	}
 
-	hbus->sysdata.fwnode = irq_domain_alloc_fwnode(hbus);
+	name = kasprintf(GFP_KERNEL, "%pUL", &hdev->dev_instance);
+	if (!name) {
+		ret = -ENOMEM;
+		goto unmap;
+	}
+
+	hbus->sysdata.fwnode = irq_domain_alloc_named_fwnode(name);
+	kfree(name);
 	if (!hbus->sysdata.fwnode) {
 		ret = -ENOMEM;
 		goto unmap;
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5b8328a99b2a..07b527dca996 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -472,7 +472,11 @@ extern int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
 				 bool state);
 
 #ifdef CONFIG_IRQ_FORCED_THREADING
+# ifdef CONFIG_PREEMPT_RT
+#  define force_irqthreads	(true)
+# else
 extern bool force_irqthreads;
+# endif
 #else
 #define force_irqthreads	(0)
 #endif
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 67c4b9806d43..5cc10cf7cb3e 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -30,10 +30,22 @@
 #define GICD_ICFGR			0x0C00
 #define GICD_IGRPMODR			0x0D00
 #define GICD_NSACR			0x0E00
+#define GICD_IGROUPRnE			0x1000
+#define GICD_ISENABLERnE		0x1200
+#define GICD_ICENABLERnE		0x1400
+#define GICD_ISPENDRnE			0x1600
+#define GICD_ICPENDRnE			0x1800
+#define GICD_ISACTIVERnE		0x1A00
+#define GICD_ICACTIVERnE		0x1C00
+#define GICD_IPRIORITYRnE		0x2000
+#define GICD_ICFGRnE			0x3000
 #define GICD_IROUTER			0x6000
+#define GICD_IROUTERnE			0x8000
 #define GICD_IDREGS			0xFFD0
 #define GICD_PIDR2			0xFFE8
 
+#define ESPI_BASE_INTID			4096
+
 /*
  * Those registers are actually from GICv2, but the spec demands that they
  * are implemented as RES0 if ARE is 1 (which we do in KVM's emulated GICv3).
@@ -69,10 +81,13 @@
 #define GICD_TYPER_RSS			(1U << 26)
 #define GICD_TYPER_LPIS			(1U << 17)
 #define GICD_TYPER_MBIS			(1U << 16)
+#define GICD_TYPER_ESPI			(1U << 8)
 
 #define GICD_TYPER_ID_BITS(typer)	((((typer) >> 19) & 0x1f) + 1)
 #define GICD_TYPER_NUM_LPIS(typer)	((((typer) >> 11) & 0x1f) + 1)
-#define GICD_TYPER_IRQS(typer)		((((typer) & 0x1f) + 1) * 32)
+#define GICD_TYPER_SPIS(typer)		((((typer) & 0x1f) + 1) * 32)
+#define GICD_TYPER_ESPIS(typer)						\
+	(((typer) & GICD_TYPER_ESPI) ? GICD_TYPER_SPIS((typer) >> 27) : 0)
 
 #define GICD_IROUTER_SPI_MODE_ONE	(0U << 31)
 #define GICD_IROUTER_SPI_MODE_ANY	(1U << 31)
@@ -109,6 +124,18 @@
 
 #define GICR_TYPER_CPU_NUMBER(r)	(((r) >> 8) & 0xffff)
 
+#define EPPI_BASE_INTID			1056
+
+#define GICR_TYPER_NR_PPIS(r)						\
+	({								\
+		unsigned int __ppinum = ((r) >> 27) & 0x1f;		\
+		unsigned int __nr_ppis = 16;				\
+		if (__ppinum == 1 || __ppinum == 2)			\
+			__nr_ppis +=  __ppinum * 32;			\
+									\
+		__nr_ppis;						\
+	 })
+
 #define GICR_WAKER_ProcessorSleep	(1U << 1)
 #define GICR_WAKER_ChildrenAsleep	(1U << 2)
 
@@ -469,6 +496,7 @@
 #define ICC_CTLR_EL1_A3V_SHIFT		15
 #define ICC_CTLR_EL1_A3V_MASK		(0x1 << ICC_CTLR_EL1_A3V_SHIFT)
 #define ICC_CTLR_EL1_RSS		(0x1 << 18)
+#define ICC_CTLR_EL1_ExtRange		(0x1 << 19)
 #define ICC_PMR_EL1_SHIFT		0
 #define ICC_PMR_EL1_MASK		(0xff << ICC_PMR_EL1_SHIFT)
 #define ICC_BPR0_EL1_SHIFT		0
diff --git a/include/linux/irqchip/irq-partition-percpu.h b/include/linux/irqchip/irq-partition-percpu.h
index a783ddb58444..2f6ae7551748 100644
--- a/include/linux/irqchip/irq-partition-percpu.h
+++ b/include/linux/irqchip/irq-partition-percpu.h
@@ -4,6 +4,9 @@
  * Author: Marc Zyngier <marc.zyngier@arm.com>
  */
 
+#ifndef __LINUX_IRQCHIP_IRQ_PARTITION_PERCPU_H
+#define __LINUX_IRQCHIP_IRQ_PARTITION_PERCPU_H
+
 #include <linux/fwnode.h>
 #include <linux/cpumask.h>
 #include <linux/irqdomain.h>
@@ -46,3 +49,5 @@ struct irq_domain *partition_get_domain(struct partition_desc *dsc)
 	return NULL;
 }
 #endif
+
+#endif /* __LINUX_IRQCHIP_IRQ_PARTITION_PERCPU_H */
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 07ec8b390161..583e7abd07f9 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -220,7 +220,7 @@ static inline struct device_node *irq_domain_get_of_node(struct irq_domain *d)
 
 #ifdef CONFIG_IRQ_DOMAIN
 struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
-						const char *name, void *data);
+						const char *name, phys_addr_t *pa);
 
 enum {
 	IRQCHIP_FWNODE_REAL,
@@ -241,9 +241,9 @@ struct fwnode_handle *irq_domain_alloc_named_id_fwnode(const char *name, int id)
 					 NULL);
 }
 
-static inline struct fwnode_handle *irq_domain_alloc_fwnode(void *data)
+static inline struct fwnode_handle *irq_domain_alloc_fwnode(phys_addr_t *pa)
 {
-	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_REAL, 0, NULL, data);
+	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_REAL, 0, NULL, pa);
 }
 
 void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 6fef48033f96..4d89ad4fae3b 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
+#include <linux/sort.h>
 
 static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 				unsigned int cpus_per_vec)
@@ -94,6 +95,155 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
 	return nodes;
 }
 
+struct node_vectors {
+	unsigned id;
+
+	union {
+		unsigned nvectors;
+		unsigned ncpus;
+	};
+};
+
+static int ncpus_cmp_func(const void *l, const void *r)
+{
+	const struct node_vectors *ln = l;
+	const struct node_vectors *rn = r;
+
+	return ln->ncpus - rn->ncpus;
+}
+
+/*
+ * Allocate vector number for each node, so that for each node:
+ *
+ * 1) the allocated number is >= 1
+ *
+ * 2) the allocated numbver is <= active CPU number of this node
+ *
+ * The actual allocated total vectors may be less than @numvecs when
+ * active total CPU number is less than @numvecs.
+ *
+ * Active CPUs means the CPUs in '@cpu_mask AND @node_to_cpumask[]'
+ * for each node.
+ */
+static void alloc_nodes_vectors(unsigned int numvecs,
+				cpumask_var_t *node_to_cpumask,
+				const struct cpumask *cpu_mask,
+				const nodemask_t nodemsk,
+				struct cpumask *nmsk,
+				struct node_vectors *node_vectors)
+{
+	unsigned n, remaining_ncpus = 0;
+
+	for (n = 0; n < nr_node_ids; n++) {
+		node_vectors[n].id = n;
+		node_vectors[n].ncpus = UINT_MAX;
+	}
+
+	for_each_node_mask(n, nodemsk) {
+		unsigned ncpus;
+
+		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
+		ncpus = cpumask_weight(nmsk);
+
+		if (!ncpus)
+			continue;
+		remaining_ncpus += ncpus;
+		node_vectors[n].ncpus = ncpus;
+	}
+
+	numvecs = min_t(unsigned, remaining_ncpus, numvecs);
+
+	sort(node_vectors, nr_node_ids, sizeof(node_vectors[0]),
+	     ncpus_cmp_func, NULL);
+
+	/*
+	 * Allocate vectors for each node according to the ratio of this
+	 * node's nr_cpus to remaining un-assigned ncpus. 'numvecs' is
+	 * bigger than number of active numa nodes. Always start the
+	 * allocation from the node with minimized nr_cpus.
+	 *
+	 * This way guarantees that each active node gets allocated at
+	 * least one vector, and the theory is simple: over-allocation
+	 * is only done when this node is assigned by one vector, so
+	 * other nodes will be allocated >= 1 vector, since 'numvecs' is
+	 * bigger than number of numa nodes.
+	 *
+	 * One perfect invariant is that number of allocated vectors for
+	 * each node is <= CPU count of this node:
+	 *
+	 * 1) suppose there are two nodes: A and B
+	 * 	ncpu(X) is CPU count of node X
+	 * 	vecs(X) is the vector count allocated to node X via this
+	 * 	algorithm
+	 *
+	 * 	ncpu(A) <= ncpu(B)
+	 * 	ncpu(A) + ncpu(B) = N
+	 * 	vecs(A) + vecs(B) = V
+	 *
+	 * 	vecs(A) = max(1, round_down(V * ncpu(A) / N))
+	 * 	vecs(B) = V - vecs(A)
+	 *
+	 * 	both N and V are integer, and 2 <= V <= N, suppose
+	 * 	V = N - delta, and 0 <= delta <= N - 2
+	 *
+	 * 2) obviously vecs(A) <= ncpu(A) because:
+	 *
+	 * 	if vecs(A) is 1, then vecs(A) <= ncpu(A) given
+	 * 	ncpu(A) >= 1
+	 *
+	 * 	otherwise,
+	 * 		vecs(A) <= V * ncpu(A) / N <= ncpu(A), given V <= N
+	 *
+	 * 3) prove how vecs(B) <= ncpu(B):
+	 *
+	 * 	if round_down(V * ncpu(A) / N) == 0, vecs(B) won't be
+	 * 	over-allocated, so vecs(B) <= ncpu(B),
+	 *
+	 * 	otherwise:
+	 *
+	 * 	vecs(A) =
+	 * 		round_down(V * ncpu(A) / N) =
+	 * 		round_down((N - delta) * ncpu(A) / N) =
+	 * 		round_down((N * ncpu(A) - delta * ncpu(A)) / N)	 >=
+	 * 		round_down((N * ncpu(A) - delta * N) / N)	 =
+	 * 		cpu(A) - delta
+	 *
+	 * 	then:
+	 *
+	 * 	vecs(A) - V >= ncpu(A) - delta - V
+	 * 	=>
+	 * 	V - vecs(A) <= V + delta - ncpu(A)
+	 * 	=>
+	 * 	vecs(B) <= N - ncpu(A)
+	 * 	=>
+	 * 	vecs(B) <= cpu(B)
+	 *
+	 * For nodes >= 3, it can be thought as one node and another big
+	 * node given that is exactly what this algorithm is implemented,
+	 * and we always re-calculate 'remaining_ncpus' & 'numvecs', and
+	 * finally for each node X: vecs(X) <= ncpu(X).
+	 *
+	 */
+	for (n = 0; n < nr_node_ids; n++) {
+		unsigned nvectors, ncpus;
+
+		if (node_vectors[n].ncpus == UINT_MAX)
+			continue;
+
+		WARN_ON_ONCE(numvecs == 0);
+
+		ncpus = node_vectors[n].ncpus;
+		nvectors = max_t(unsigned, 1,
+				 numvecs * ncpus / remaining_ncpus);
+		WARN_ON_ONCE(nvectors > ncpus);
+
+		node_vectors[n].nvectors = nvectors;
+
+		remaining_ncpus -= ncpus;
+		numvecs -= nvectors;
+	}
+}
+
 static int __irq_build_affinity_masks(unsigned int startvec,
 				      unsigned int numvecs,
 				      unsigned int firstvec,
@@ -102,10 +252,11 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 				      struct cpumask *nmsk,
 				      struct irq_affinity_desc *masks)
 {
-	unsigned int n, nodes, cpus_per_vec, extra_vecs, done = 0;
+	unsigned int i, n, nodes, cpus_per_vec, extra_vecs, done = 0;
 	unsigned int last_affv = firstvec + numvecs;
 	unsigned int curvec = startvec;
 	nodemask_t nodemsk = NODE_MASK_NONE;
+	struct node_vectors *node_vectors;
 
 	if (!cpumask_weight(cpu_mask))
 		return 0;
@@ -126,42 +277,56 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 		return numvecs;
 	}
 
-	for_each_node_mask(n, nodemsk) {
-		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
+	node_vectors = kcalloc(nr_node_ids,
+			       sizeof(struct node_vectors),
+			       GFP_KERNEL);
+	if (!node_vectors)
+		return -ENOMEM;
 
-		/* Spread the vectors per node */
-		vecs_per_node = (numvecs - (curvec - firstvec)) / nodes;
+	/* allocate vector number for each node */
+	alloc_nodes_vectors(numvecs, node_to_cpumask, cpu_mask,
+			    nodemsk, nmsk, node_vectors);
 
-		/* Get the cpus on this node which are in the mask */
-		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
+	for (i = 0; i < nr_node_ids; i++) {
+		unsigned int ncpus, v;
+		struct node_vectors *nv = &node_vectors[i];
+
+		if (nv->nvectors == UINT_MAX)
+			continue;
 
-		/* Calculate the number of cpus per vector */
+		/* Get the cpus on this node which are in the mask */
+		cpumask_and(nmsk, cpu_mask, node_to_cpumask[nv->id]);
 		ncpus = cpumask_weight(nmsk);
-		vecs_to_assign = min(vecs_per_node, ncpus);
+		if (!ncpus)
+			continue;
+
+		WARN_ON_ONCE(nv->nvectors > ncpus);
 
 		/* Account for rounding errors */
-		extra_vecs = ncpus - vecs_to_assign * (ncpus / vecs_to_assign);
+		extra_vecs = ncpus - nv->nvectors * (ncpus / nv->nvectors);
 
-		for (v = 0; curvec < last_affv && v < vecs_to_assign;
-		     curvec++, v++) {
-			cpus_per_vec = ncpus / vecs_to_assign;
+		/* Spread allocated vectors on CPUs of the current node */
+		for (v = 0; v < nv->nvectors; v++, curvec++) {
+			cpus_per_vec = ncpus / nv->nvectors;
 
 			/* Account for extra vectors to compensate rounding errors */
 			if (extra_vecs) {
 				cpus_per_vec++;
 				--extra_vecs;
 			}
+
+			/*
+			 * wrapping has to be considered given 'startvec'
+			 * may start anywhere
+			 */
+			if (curvec >= last_affv)
+				curvec = firstvec;
 			irq_spread_init_one(&masks[curvec].mask, nmsk,
 						cpus_per_vec);
 		}
-
-		done += v;
-		if (done >= numvecs)
-			break;
-		if (curvec >= last_affv)
-			curvec = firstvec;
-		--nodes;
+		done += nv->nvectors;
 	}
+	kfree(node_vectors);
 	return done;
 }
 
@@ -174,7 +339,7 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 				    unsigned int firstvec,
 				    struct irq_affinity_desc *masks)
 {
-	unsigned int curvec = startvec, nr_present, nr_others;
+	unsigned int curvec = startvec, nr_present = 0, nr_others = 0;
 	cpumask_var_t *node_to_cpumask;
 	cpumask_var_t nmsk, npresmsk;
 	int ret = -ENOMEM;
@@ -189,15 +354,17 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 	if (!node_to_cpumask)
 		goto fail_npresmsk;
 
-	ret = 0;
 	/* Stabilize the cpumasks */
 	get_online_cpus();
 	build_node_to_cpumask(node_to_cpumask);
 
 	/* Spread on present CPUs starting from affd->pre_vectors */
-	nr_present = __irq_build_affinity_masks(curvec, numvecs,
-						firstvec, node_to_cpumask,
-						cpu_present_mask, nmsk, masks);
+	ret = __irq_build_affinity_masks(curvec, numvecs, firstvec,
+					 node_to_cpumask, cpu_present_mask,
+					 nmsk, masks);
+	if (ret < 0)
+		goto fail_build_affinity;
+	nr_present = ret;
 
 	/*
 	 * Spread on non present CPUs starting from the next vector to be
@@ -210,12 +377,16 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 	else
 		curvec = firstvec + nr_present;
 	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
-	nr_others = __irq_build_affinity_masks(curvec, numvecs,
-					       firstvec, node_to_cpumask,
-					       npresmsk, nmsk, masks);
+	ret = __irq_build_affinity_masks(curvec, numvecs, firstvec,
+					 node_to_cpumask, npresmsk, nmsk,
+					 masks);
+	if (ret >= 0)
+		nr_others = ret;
+
+ fail_build_affinity:
 	put_online_cpus();
 
-	if (nr_present < numvecs)
+	if (ret >= 0)
 		WARN_ON(nr_present + nr_others < numvecs);
 
 	free_node_to_cpumask(node_to_cpumask);
@@ -225,7 +396,7 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 
  fail_nmsk:
 	free_cpumask_var(nmsk);
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3078d0e48bba..132672b74e4b 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -31,7 +31,7 @@ struct irqchip_fwid {
 	struct fwnode_handle	fwnode;
 	unsigned int		type;
 	char			*name;
-	void *data;
+	phys_addr_t		*pa;
 };
 
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
@@ -62,7 +62,8 @@ EXPORT_SYMBOL_GPL(irqchip_fwnode_ops);
  * domain struct.
  */
 struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
-						const char *name, void *data)
+						const char *name,
+						phys_addr_t *pa)
 {
 	struct irqchip_fwid *fwid;
 	char *n;
@@ -77,7 +78,7 @@ struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
 		n = kasprintf(GFP_KERNEL, "%s-%d", name, id);
 		break;
 	default:
-		n = kasprintf(GFP_KERNEL, "irqchip@%p", data);
+		n = kasprintf(GFP_KERNEL, "irqchip@%pa", pa);
 		break;
 	}
 
@@ -89,7 +90,7 @@ struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
 
 	fwid->type = type;
 	fwid->name = n;
-	fwid->data = data;
+	fwid->pa = pa;
 	fwid->fwnode.ops = &irqchip_fwnode_ops;
 	return &fwid->fwnode;
 }
@@ -148,6 +149,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 		switch (fwid->type) {
 		case IRQCHIP_FWNODE_NAMED:
 		case IRQCHIP_FWNODE_NAMED_ID:
+			domain->fwnode = fwnode;
 			domain->name = kstrdup(fwid->name, GFP_KERNEL);
 			if (!domain->name) {
 				kfree(domain);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e8f7f179bf77..97de1b7d43af 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -23,7 +23,7 @@
 
 #include "internals.h"
 
-#ifdef CONFIG_IRQ_FORCED_THREADING
+#if defined(CONFIG_IRQ_FORCED_THREADING) && !defined(CONFIG_PREEMPT_RT)
 __read_mostly bool force_irqthreads;
 EXPORT_SYMBOL_GPL(force_irqthreads);
 


