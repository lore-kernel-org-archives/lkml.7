Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3E9C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBF32084F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfCELtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:49:31 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44403 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCELtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:49:31 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h18ZL-0004Ua-N4; Tue, 05 Mar 2019 12:49:12 +0100
Subject: [GIT pull] irq core updates for 5.1
Message-ID: <155178637782.3906.3253567963332039739.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Date:   Tue, 05 Mar 2019 12:49:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-for-linus

The interrupt departement delivers this time:

 - New infrastructure to manage NMIs on platforms which have a sane NMI
   delivery, i.e. identifiable NMI vectors instead of a single lump.

 - Simplification of the interrupt affinity management so drivers don't
   have to implement ugly loops around the PCI/MSI enablement.

 - Speedup for interrupt statistics in /proc/stat

 - Provide a function to retrieve the default irq domain
 
 - A new interrupt controller for the Loongson LS1X platform

 - Affinity support for the SiFive PLIC

 - Better support for the iMX irqsteer driver

  - NUMA aware memory allocations for GICv3

  - The usual small fixes, improvements and cleanups all over the place

Thanks,

	tglx

------------------>
Aaro Koskinen (1):
      irqchip/i8259: Fix shutdown order by moving syscore_ops registration

Aisheng Dong (4):
      dt-binding: irq: imx-irqsteer: Use irq number instead of group number
      dt-bindings: irq: imx-irqsteer: Add multi output interrupts support
      irqchip/imx-irqsteer: Change to use reg_num instead of irq_group
      irqchip/imx-irqsteer: Add multi output interrupts support

Anup Patel (4):
      irqchip/sifive-plic: Pre-compute context hart base and enable base
      irqchip/sifive-plic: Add warning in plic_init() if handler already present
      irqchip/sifive-plic: Differentiate between PLIC handler and context
      irqchip/sifive-plic: Implement irq_set_affinity() for SMP host

Atish Patra (1):
      irqchip/irq-sifive-plic: Check and continue in case of an invalid cpuid.

Doug Berger (1):
      irqchip/brcmstb-l2: Use _irqsave locking variants in non-interrupt code

Greg Kroah-Hartman (1):
      genirq/debugfs: No need to check return value of debugfs_create functions

Jiaxun Yang (2):
      irqchip: Add driver for Loongson-1 interrupt controller
      dt-bindings: interrupt-controller: loongson ls1x intc

Julien Thierry (5):
      genirq: Provide basic NMI management for interrupt lines
      genirq: Provide NMI management for percpu_devid interrupts
      genirq: Provide NMI handlers
      irqdesc: Add domain handler for NMIs
      genirq: Fix wrong name in request_percpu_nmi() description

Marc Zyngier (1):
      irqdomain: Allow the default irq domain to be retrieved

Mathieu Malaterre (2):
      genirq: Annotate implicit fall through
      genirq: Correctly annotate implicit fall through

Matthias Kaehlcke (2):
      kthread: Add __kthread_should_park()
      softirq: Don't skip softirq execution when softirq thread is parking

Ming Lei (4):
      genirq/affinity: Move allocation of 'node_to_cpumask' to irq_build_affinity_masks()
      genirq/affinity: Store interrupt sets size in struct irq_affinity
      genirq/affinity: Add new callback for (re)calculating interrupt sets
      nvme-pci: Simplify interrupt allocation

Shanker Donthineni (1):
      irqchip/gicv3-its: Use NUMA aware memory allocation for ITS tables

Thomas Gleixner (5):
      genirq: Avoid summation loops for /proc/stat
      proc/stat: Make the interrupt statistics more efficient
      genirq/affinity: Code consolidation
      genirq/affinity: Remove the leftovers of the original set support
      PCI/MSI: Remove obsolete sanity checks for multiple interrupt sets

Waiman Long (1):
      genirq: Add missing documentation for tot_count

Zenghui Yu (1):
      irqchip/gic-v3-its: Avoid parsing _indirect_ twice for Device table


 .../bindings/interrupt-controller/fsl,irqsteer.txt |  11 +-
 .../interrupt-controller/loongson,ls1x-intc.txt    |  24 ++
 drivers/irqchip/Kconfig                            |   9 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-brcmstb-l2.c                   |  10 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  28 +-
 drivers/irqchip/irq-i8259.c                        |   9 +-
 drivers/irqchip/irq-imx-irqsteer.c                 | 115 ++++--
 drivers/irqchip/irq-ls1x.c                         | 192 ++++++++++
 drivers/irqchip/irq-sifive-plic.c                  | 116 ++++--
 drivers/nvme/host/pci.c                            | 117 ++----
 drivers/pci/msi.c                                  |  39 +-
 drivers/scsi/be2iscsi/be_main.c                    |   2 +-
 fs/proc/stat.c                                     |  29 +-
 include/linux/interrupt.h                          |  51 ++-
 include/linux/irq.h                                |  10 +
 include/linux/irqdesc.h                            |   7 +
 include/linux/irqdomain.h                          |   1 +
 include/linux/kthread.h                            |   1 +
 include/linux/pci.h                                |   4 +-
 kernel/irq/affinity.c                              | 121 +++---
 kernel/irq/chip.c                                  |  66 +++-
 kernel/irq/debugfs.c                               |   8 +-
 kernel/irq/handle.c                                |   2 +-
 kernel/irq/internals.h                             |  10 +-
 kernel/irq/irqdesc.c                               |  42 ++-
 kernel/irq/irqdomain.c                             |  16 +-
 kernel/irq/manage.c                                | 406 ++++++++++++++++++++-
 kernel/kthread.c                                   |   8 +-
 kernel/softirq.c                                   |   3 +-
 30 files changed, 1177 insertions(+), 281 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
 create mode 100644 drivers/irqchip/irq-ls1x.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
index 45790ce6f5b9..582991c426ee 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
@@ -6,8 +6,9 @@ Required properties:
 	- "fsl,imx8m-irqsteer"
 	- "fsl,imx-irqsteer"
 - reg: Physical base address and size of registers.
-- interrupts: Should contain the parent interrupt line used to multiplex the
-  input interrupts.
+- interrupts: Should contain the up to 8 parent interrupt lines used to
+  multiplex the input interrupts. They should be specified sequentially
+  from output 0 to 7.
 - clocks: Should contain one clock for entry in clock-names
   see Documentation/devicetree/bindings/clock/clock-bindings.txt
 - clock-names:
@@ -16,8 +17,8 @@ Required properties:
 - #interrupt-cells: Specifies the number of cells needed to encode an
   interrupt source. The value must be 1.
 - fsl,channel: The output channel that all input IRQs should be steered into.
-- fsl,irq-groups: Number of IRQ groups managed by this controller instance.
-  Each group manages 64 input interrupts.
+- fsl,num-irqs: Number of input interrupts of this channel.
+  Should be multiple of 32 input interrupts and up to 512 interrupts.
 
 Example:
 
@@ -28,7 +29,7 @@ Example:
 		clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
 		clock-names = "ipg";
 		fsl,channel = <0>;
-		fsl,irq-groups = <1>;
+		fsl,num-irqs = <64>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
new file mode 100644
index 000000000000..a63ed9fcb535
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
@@ -0,0 +1,24 @@
+Loongson ls1x Interrupt Controller
+
+Required properties:
+
+- compatible : should be "loongson,ls1x-intc". Valid strings are:
+
+- reg : Specifies base physical address and size of the registers.
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 2.
+- interrupts : Specifies the CPU interrupt the controller is connected to.
+
+Example:
+
+intc: interrupt-controller@1fd01040 {
+	compatible = "loongson,ls1x-intc";
+	reg = <0x1fd01040 0x18>;
+
+	interrupt-controller;
+	#interrupt-cells = <2>;
+
+	interrupt-parent = <&cpu_intc>;
+	interrupts = <2>;
+};
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 3d1e60779078..5dcb5456cd14 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -406,6 +406,15 @@ config IMX_IRQSTEER
 	help
 	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
 
+config LS1X_IRQ
+	bool "Loongson-1 Interrupt Controller"
+	depends on MACH_LOONGSON32
+	default y
+	select IRQ_DOMAIN
+	select GENERIC_IRQ_CHIP
+	help
+	  Support for the Loongson-1 platform Interrupt Controller.
+
 endmenu
 
 config SIFIVE_PLIC
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c93713d24b86..7acd0e36d0b4 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -94,3 +94,4 @@ obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
 obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
+obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 0e65f609352e..83364fedbf0a 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -129,8 +129,9 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct brcmstb_l2_intc_data *b = gc->private;
+	unsigned long flags;
 
-	irq_gc_lock(gc);
+	irq_gc_lock_irqsave(gc, flags);
 	/* Save the current mask */
 	b->saved_mask = irq_reg_readl(gc, ct->regs.mask);
 
@@ -139,7 +140,7 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
 		irq_reg_writel(gc, ~gc->wake_active, ct->regs.disable);
 		irq_reg_writel(gc, gc->wake_active, ct->regs.enable);
 	}
-	irq_gc_unlock(gc);
+	irq_gc_unlock_irqrestore(gc, flags);
 }
 
 static void brcmstb_l2_intc_resume(struct irq_data *d)
@@ -147,8 +148,9 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct brcmstb_l2_intc_data *b = gc->private;
+	unsigned long flags;
 
-	irq_gc_lock(gc);
+	irq_gc_lock_irqsave(gc, flags);
 	if (ct->chip.irq_ack) {
 		/* Clear unmasked non-wakeup interrupts */
 		irq_reg_writel(gc, ~b->saved_mask & ~gc->wake_active,
@@ -158,7 +160,7 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 	/* Restore the saved mask */
 	irq_reg_writel(gc, b->saved_mask, ct->regs.disable);
 	irq_reg_writel(gc, ~b->saved_mask, ct->regs.enable);
-	irq_gc_unlock(gc);
+	irq_gc_unlock_irqrestore(gc, flags);
 }
 
 static int __init brcmstb_l2_intc_of_init(struct device_node *np,
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 7f2a45445b00..666f5986b0ce 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1737,6 +1737,7 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 	u64 type = GITS_BASER_TYPE(val);
 	u64 baser_phys, tmp;
 	u32 alloc_pages;
+	struct page *page;
 	void *base;
 
 retry_alloc_baser:
@@ -1749,10 +1750,11 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 		order = get_order(GITS_BASER_PAGES_MAX * psz);
 	}
 
-	base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
-	if (!base)
+	page = alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO, order);
+	if (!page)
 		return -ENOMEM;
 
+	base = (void *)page_address(page);
 	baser_phys = virt_to_phys(base);
 
 	/* Check if the physical address of the memory is above 48bits */
@@ -1946,6 +1948,8 @@ static int its_alloc_tables(struct its_node *its)
 			indirect = its_parse_indirect_baser(its, baser,
 							    psz, &order,
 							    its->device_ids);
+			break;
+
 		case GITS_BASER_TYPE_VCPU:
 			indirect = its_parse_indirect_baser(its, baser,
 							    psz, &order,
@@ -2236,7 +2240,8 @@ static struct its_baser *its_get_baser(struct its_node *its, u32 type)
 	return NULL;
 }
 
-static bool its_alloc_table_entry(struct its_baser *baser, u32 id)
+static bool its_alloc_table_entry(struct its_node *its,
+				  struct its_baser *baser, u32 id)
 {
 	struct page *page;
 	u32 esz, idx;
@@ -2256,7 +2261,8 @@ static bool its_alloc_table_entry(struct its_baser *baser, u32 id)
 
 	/* Allocate memory for 2nd level table */
 	if (!table[idx]) {
-		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, get_order(baser->psz));
+		page = alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO,
+					get_order(baser->psz));
 		if (!page)
 			return false;
 
@@ -2287,7 +2293,7 @@ static bool its_alloc_device_table(struct its_node *its, u32 dev_id)
 	if (!baser)
 		return (ilog2(dev_id) < its->device_ids);
 
-	return its_alloc_table_entry(baser, dev_id);
+	return its_alloc_table_entry(its, baser, dev_id);
 }
 
 static bool its_alloc_vpe_table(u32 vpe_id)
@@ -2311,7 +2317,7 @@ static bool its_alloc_vpe_table(u32 vpe_id)
 		if (!baser)
 			return false;
 
-		if (!its_alloc_table_entry(baser, vpe_id))
+		if (!its_alloc_table_entry(its, baser, vpe_id))
 			return false;
 	}
 
@@ -2345,7 +2351,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	nr_ites = max(2, nvecs);
 	sz = nr_ites * its->ite_size;
 	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
-	itt = kzalloc(sz, GFP_KERNEL);
+	itt = kzalloc_node(sz, GFP_KERNEL, its->numa_node);
 	if (alloc_lpis) {
 		lpi_map = its_lpi_alloc(nvecs, &lpi_base, &nr_lpis);
 		if (lpi_map)
@@ -3487,6 +3493,7 @@ static int __init its_probe_one(struct resource *res,
 	void __iomem *its_base;
 	u32 val, ctlr;
 	u64 baser, tmp, typer;
+	struct page *page;
 	int err;
 
 	its_base = ioremap(res->start, resource_size(res));
@@ -3542,12 +3549,13 @@ static int __init its_probe_one(struct resource *res,
 
 	its->numa_node = numa_node;
 
-	its->cmd_base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-						get_order(ITS_CMD_QUEUE_SZ));
-	if (!its->cmd_base) {
+	page = alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO,
+				get_order(ITS_CMD_QUEUE_SZ));
+	if (!page) {
 		err = -ENOMEM;
 		goto out_free_its;
 	}
+	its->cmd_base = (void *)page_address(page);
 	its->cmd_write = its->cmd_base;
 	its->fwnode_handle = handle;
 	its->get_msi_base = its_irq_get_msi_base;
diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
index b0d4aab1a58c..d000870d9b6b 100644
--- a/drivers/irqchip/irq-i8259.c
+++ b/drivers/irqchip/irq-i8259.c
@@ -225,14 +225,6 @@ static struct syscore_ops i8259_syscore_ops = {
 	.shutdown = i8259A_shutdown,
 };
 
-static int __init i8259A_init_sysfs(void)
-{
-	register_syscore_ops(&i8259_syscore_ops);
-	return 0;
-}
-
-device_initcall(i8259A_init_sysfs);
-
 static void init_8259A(int auto_eoi)
 {
 	unsigned long flags;
@@ -332,6 +324,7 @@ struct irq_domain * __init __init_i8259_irqs(struct device_node *node)
 		panic("Failed to add i8259 IRQ domain");
 
 	setup_irq(I8259A_IRQ_BASE + PIC_CASCADE_IR, &irq2);
+	register_syscore_ops(&i8259_syscore_ops);
 	return domain;
 }
 
diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 5b3f1d735685..d1098f4da6a4 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -10,10 +10,11 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/spinlock.h>
 
-#define CTRL_STRIDE_OFF(_t, _r)	(_t * 8 * _r)
+#define CTRL_STRIDE_OFF(_t, _r)	(_t * 4 * _r)
 #define CHANCTRL		0x0
 #define CHANMASK(n, t)		(CTRL_STRIDE_OFF(t, 0) + 0x4 * (n) + 0x4)
 #define CHANSET(n, t)		(CTRL_STRIDE_OFF(t, 1) + 0x4 * (n) + 0x4)
@@ -21,12 +22,15 @@
 #define CHAN_MINTDIS(t)		(CTRL_STRIDE_OFF(t, 3) + 0x4)
 #define CHAN_MASTRSTAT(t)	(CTRL_STRIDE_OFF(t, 3) + 0x8)
 
+#define CHAN_MAX_OUTPUT_INT	0x8
+
 struct irqsteer_data {
 	void __iomem		*regs;
 	struct clk		*ipg_clk;
-	int			irq;
+	int			irq[CHAN_MAX_OUTPUT_INT];
+	int			irq_count;
 	raw_spinlock_t		lock;
-	int			irq_groups;
+	int			reg_num;
 	int			channel;
 	struct irq_domain	*domain;
 	u32			*saved_reg;
@@ -35,7 +39,7 @@ struct irqsteer_data {
 static int imx_irqsteer_get_reg_index(struct irqsteer_data *data,
 				      unsigned long irqnum)
 {
-	return (data->irq_groups * 2 - irqnum / 32 - 1);
+	return (data->reg_num - irqnum / 32 - 1);
 }
 
 static void imx_irqsteer_irq_unmask(struct irq_data *d)
@@ -46,9 +50,9 @@ static void imx_irqsteer_irq_unmask(struct irq_data *d)
 	u32 val;
 
 	raw_spin_lock_irqsave(&data->lock, flags);
-	val = readl_relaxed(data->regs + CHANMASK(idx, data->irq_groups));
+	val = readl_relaxed(data->regs + CHANMASK(idx, data->reg_num));
 	val |= BIT(d->hwirq % 32);
-	writel_relaxed(val, data->regs + CHANMASK(idx, data->irq_groups));
+	writel_relaxed(val, data->regs + CHANMASK(idx, data->reg_num));
 	raw_spin_unlock_irqrestore(&data->lock, flags);
 }
 
@@ -60,9 +64,9 @@ static void imx_irqsteer_irq_mask(struct irq_data *d)
 	u32 val;
 
 	raw_spin_lock_irqsave(&data->lock, flags);
-	val = readl_relaxed(data->regs + CHANMASK(idx, data->irq_groups));
+	val = readl_relaxed(data->regs + CHANMASK(idx, data->reg_num));
 	val &= ~BIT(d->hwirq % 32);
-	writel_relaxed(val, data->regs + CHANMASK(idx, data->irq_groups));
+	writel_relaxed(val, data->regs + CHANMASK(idx, data->reg_num));
 	raw_spin_unlock_irqrestore(&data->lock, flags);
 }
 
@@ -87,23 +91,47 @@ static const struct irq_domain_ops imx_irqsteer_domain_ops = {
 	.xlate		= irq_domain_xlate_onecell,
 };
 
+static int imx_irqsteer_get_hwirq_base(struct irqsteer_data *data, u32 irq)
+{
+	int i;
+
+	for (i = 0; i < data->irq_count; i++) {
+		if (data->irq[i] == irq)
+			return i * 64;
+	}
+
+	return -EINVAL;
+}
+
 static void imx_irqsteer_irq_handler(struct irq_desc *desc)
 {
 	struct irqsteer_data *data = irq_desc_get_handler_data(desc);
-	int i;
+	int hwirq;
+	int irq, i;
 
 	chained_irq_enter(irq_desc_get_chip(desc), desc);
 
-	for (i = 0; i < data->irq_groups * 64; i += 32) {
-		int idx = imx_irqsteer_get_reg_index(data, i);
+	irq = irq_desc_get_irq(desc);
+	hwirq = imx_irqsteer_get_hwirq_base(data, irq);
+	if (hwirq < 0) {
+		pr_warn("%s: unable to get hwirq base for irq %d\n",
+			__func__, irq);
+		return;
+	}
+
+	for (i = 0; i < 2; i++, hwirq += 32) {
+		int idx = imx_irqsteer_get_reg_index(data, hwirq);
 		unsigned long irqmap;
 		int pos, virq;
 
+		if (hwirq >= data->reg_num * 32)
+			break;
+
 		irqmap = readl_relaxed(data->regs +
-				       CHANSTATUS(idx, data->irq_groups));
+				       CHANSTATUS(idx, data->reg_num));
 
 		for_each_set_bit(pos, &irqmap, 32) {
-			virq = irq_find_mapping(data->domain, pos + i);
+			virq = irq_find_mapping(data->domain, pos + hwirq);
 			if (virq)
 				generic_handle_irq(virq);
 		}
@@ -117,7 +145,8 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct irqsteer_data *data;
 	struct resource *res;
-	int ret;
+	u32 irqs_num;
+	int i, ret;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -130,12 +159,6 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 		return PTR_ERR(data->regs);
 	}
 
-	data->irq = platform_get_irq(pdev, 0);
-	if (data->irq <= 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
-		return -ENODEV;
-	}
-
 	data->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(data->ipg_clk)) {
 		ret = PTR_ERR(data->ipg_clk);
@@ -146,12 +169,19 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 
 	raw_spin_lock_init(&data->lock);
 
-	of_property_read_u32(np, "fsl,irq-groups", &data->irq_groups);
+	of_property_read_u32(np, "fsl,num-irqs", &irqs_num);
 	of_property_read_u32(np, "fsl,channel", &data->channel);
 
+	/*
+	 * There is one output irq for each group of 64 inputs.
+	 * One register bit map can represent 32 input interrupts.
+	 */
+	data->irq_count = DIV_ROUND_UP(irqs_num, 64);
+	data->reg_num = irqs_num / 32;
+
 	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
 		data->saved_reg = devm_kzalloc(&pdev->dev,
-					sizeof(u32) * data->irq_groups * 2,
+					sizeof(u32) * data->reg_num,
 					GFP_KERNEL);
 		if (!data->saved_reg)
 			return -ENOMEM;
@@ -166,27 +196,48 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 	/* steer all IRQs into configured channel */
 	writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
 
-	data->domain = irq_domain_add_linear(np, data->irq_groups * 64,
+	data->domain = irq_domain_add_linear(np, data->reg_num * 32,
 					     &imx_irqsteer_domain_ops, data);
 	if (!data->domain) {
 		dev_err(&pdev->dev, "failed to create IRQ domain\n");
-		clk_disable_unprepare(data->ipg_clk);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (!data->irq_count || data->irq_count > CHAN_MAX_OUTPUT_INT) {
+		ret = -EINVAL;
+		goto out;
 	}
 
-	irq_set_chained_handler_and_data(data->irq, imx_irqsteer_irq_handler,
-					 data);
+	for (i = 0; i < data->irq_count; i++) {
+		data->irq[i] = irq_of_parse_and_map(np, i);
+		if (!data->irq[i]) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		irq_set_chained_handler_and_data(data->irq[i],
+						 imx_irqsteer_irq_handler,
+						 data);
+	}
 
 	platform_set_drvdata(pdev, data);
 
 	return 0;
+out:
+	clk_disable_unprepare(data->ipg_clk);
+	return ret;
 }
 
 static int imx_irqsteer_remove(struct platform_device *pdev)
 {
 	struct irqsteer_data *irqsteer_data = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < irqsteer_data->irq_count; i++)
+		irq_set_chained_handler_and_data(irqsteer_data->irq[i],
+						 NULL, NULL);
 
-	irq_set_chained_handler_and_data(irqsteer_data->irq, NULL, NULL);
 	irq_domain_remove(irqsteer_data->domain);
 
 	clk_disable_unprepare(irqsteer_data->ipg_clk);
@@ -199,9 +250,9 @@ static void imx_irqsteer_save_regs(struct irqsteer_data *data)
 {
 	int i;
 
-	for (i = 0; i < data->irq_groups * 2; i++)
+	for (i = 0; i < data->reg_num; i++)
 		data->saved_reg[i] = readl_relaxed(data->regs +
-						CHANMASK(i, data->irq_groups));
+						CHANMASK(i, data->reg_num));
 }
 
 static void imx_irqsteer_restore_regs(struct irqsteer_data *data)
@@ -209,9 +260,9 @@ static void imx_irqsteer_restore_regs(struct irqsteer_data *data)
 	int i;
 
 	writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
-	for (i = 0; i < data->irq_groups * 2; i++)
+	for (i = 0; i < data->reg_num; i++)
 		writel_relaxed(data->saved_reg[i],
-			       data->regs + CHANMASK(i, data->irq_groups));
+			       data->regs + CHANMASK(i, data->reg_num));
 }
 
 static int imx_irqsteer_suspend(struct device *dev)
diff --git a/drivers/irqchip/irq-ls1x.c b/drivers/irqchip/irq-ls1x.c
new file mode 100644
index 000000000000..86b72fbd3b45
--- /dev/null
+++ b/drivers/irqchip/irq-ls1x.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2019, Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *  Loongson-1 platform IRQ support
+ */
+
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <linux/irqchip.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/io.h>
+#include <linux/irqchip/chained_irq.h>
+
+#define LS_REG_INTC_STATUS	0x00
+#define LS_REG_INTC_EN	0x04
+#define LS_REG_INTC_SET	0x08
+#define LS_REG_INTC_CLR	0x0c
+#define LS_REG_INTC_POL	0x10
+#define LS_REG_INTC_EDGE	0x14
+
+/**
+ * struct ls1x_intc_priv - private ls1x-intc data.
+ * @domain:		IRQ domain.
+ * @intc_base:	IO Base of intc registers.
+ */
+
+struct ls1x_intc_priv {
+	struct irq_domain	*domain;
+	void __iomem		*intc_base;
+};
+
+
+static void ls1x_chained_handle_irq(struct irq_desc *desc)
+{
+	struct ls1x_intc_priv *priv = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 pending;
+
+	chained_irq_enter(chip, desc);
+	pending = readl(priv->intc_base + LS_REG_INTC_STATUS) &
+			readl(priv->intc_base + LS_REG_INTC_EN);
+
+	if (!pending)
+		spurious_interrupt();
+
+	while (pending) {
+		int bit = __ffs(pending);
+
+		generic_handle_irq(irq_find_mapping(priv->domain, bit));
+		pending &= ~BIT(bit);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void ls_intc_set_bit(struct irq_chip_generic *gc,
+							unsigned int offset,
+							u32 mask, bool set)
+{
+	if (set)
+		writel(readl(gc->reg_base + offset) | mask,
+		gc->reg_base + offset);
+	else
+		writel(readl(gc->reg_base + offset) & ~mask,
+		gc->reg_base + offset);
+}
+
+static int ls_intc_set_type(struct irq_data *data, unsigned int type)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
+	u32 mask = data->mask;
+
+	switch (type) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		ls_intc_set_bit(gc, LS_REG_INTC_EDGE, mask, false);
+		ls_intc_set_bit(gc, LS_REG_INTC_POL, mask, true);
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		ls_intc_set_bit(gc, LS_REG_INTC_EDGE, mask, false);
+		ls_intc_set_bit(gc, LS_REG_INTC_POL, mask, false);
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		ls_intc_set_bit(gc, LS_REG_INTC_EDGE, mask, true);
+		ls_intc_set_bit(gc, LS_REG_INTC_POL, mask, true);
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		ls_intc_set_bit(gc, LS_REG_INTC_EDGE, mask, true);
+		ls_intc_set_bit(gc, LS_REG_INTC_POL, mask, false);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	irqd_set_trigger_type(data, type);
+	return irq_setup_alt_chip(data, type);
+}
+
+
+static int __init ls1x_intc_of_init(struct device_node *node,
+				       struct device_node *parent)
+{
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+	struct ls1x_intc_priv *priv;
+	int parent_irq, err = 0;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->intc_base = of_iomap(node, 0);
+	if (!priv->intc_base) {
+		err = -ENODEV;
+		goto out_free_priv;
+	}
+
+	parent_irq = irq_of_parse_and_map(node, 0);
+	if (!parent_irq) {
+		pr_err("ls1x-irq: unable to get parent irq\n");
+		err =  -ENODEV;
+		goto out_iounmap;
+	}
+
+	/* Set up an IRQ domain */
+	priv->domain = irq_domain_add_linear(node, 32, &irq_generic_chip_ops,
+					     NULL);
+	if (!priv->domain) {
+		pr_err("ls1x-irq: cannot add IRQ domain\n");
+		goto out_iounmap;
+	}
+
+	err = irq_alloc_domain_generic_chips(priv->domain, 32, 2,
+		node->full_name, handle_level_irq,
+		IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN, 0,
+		IRQ_GC_INIT_MASK_CACHE);
+	if (err) {
+		pr_err("ls1x-irq: unable to register IRQ domain\n");
+		goto out_free_domain;
+	}
+
+	/* Mask all irqs */
+	writel(0x0, priv->intc_base + LS_REG_INTC_EN);
+
+	/* Ack all irqs */
+	writel(0xffffffff, priv->intc_base + LS_REG_INTC_CLR);
+
+	/* Set all irqs to high level triggered */
+	writel(0xffffffff, priv->intc_base + LS_REG_INTC_POL);
+
+	gc = irq_get_domain_generic_chip(priv->domain, 0);
+
+	gc->reg_base = priv->intc_base;
+
+	ct = gc->chip_types;
+	ct[0].type = IRQ_TYPE_LEVEL_MASK;
+	ct[0].regs.mask = LS_REG_INTC_EN;
+	ct[0].regs.ack = LS_REG_INTC_CLR;
+	ct[0].chip.irq_unmask = irq_gc_mask_set_bit;
+	ct[0].chip.irq_mask = irq_gc_mask_clr_bit;
+	ct[0].chip.irq_ack = irq_gc_ack_set_bit;
+	ct[0].chip.irq_set_type = ls_intc_set_type;
+	ct[0].handler = handle_level_irq;
+
+	ct[1].type = IRQ_TYPE_EDGE_BOTH;
+	ct[1].regs.mask = LS_REG_INTC_EN;
+	ct[1].regs.ack = LS_REG_INTC_CLR;
+	ct[1].chip.irq_unmask = irq_gc_mask_set_bit;
+	ct[1].chip.irq_mask = irq_gc_mask_clr_bit;
+	ct[1].chip.irq_ack = irq_gc_ack_set_bit;
+	ct[1].chip.irq_set_type = ls_intc_set_type;
+	ct[1].handler = handle_edge_irq;
+
+	irq_set_chained_handler_and_data(parent_irq,
+		ls1x_chained_handle_irq, priv);
+
+	return 0;
+
+out_free_domain:
+	irq_domain_remove(priv->domain);
+out_iounmap:
+	iounmap(priv->intc_base);
+out_free_priv:
+	kfree(priv);
+
+	return err;
+}
+
+IRQCHIP_DECLARE(ls1x_intc, "loongson,ls1x-intc", ls1x_intc_of_init);
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 357e9daf94ae..cf755964f2f8 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -59,62 +59,83 @@ static void __iomem *plic_regs;
 
 struct plic_handler {
 	bool			present;
-	int			ctxid;
+	void __iomem		*hart_base;
+	/*
+	 * Protect mask operations on the registers given that we can't
+	 * assume atomic memory operations work on them.
+	 */
+	raw_spinlock_t		enable_lock;
+	void __iomem		*enable_base;
 };
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
-static inline void __iomem *plic_hart_offset(int ctxid)
-{
-	return plic_regs + CONTEXT_BASE + ctxid * CONTEXT_PER_HART;
-}
-
-static inline u32 __iomem *plic_enable_base(int ctxid)
-{
-	return plic_regs + ENABLE_BASE + ctxid * ENABLE_PER_HART;
-}
-
-/*
- * Protect mask operations on the registers given that we can't assume that
- * atomic memory operations work on them.
- */
-static DEFINE_RAW_SPINLOCK(plic_toggle_lock);
-
-static inline void plic_toggle(int ctxid, int hwirq, int enable)
+static inline void plic_toggle(struct plic_handler *handler,
+				int hwirq, int enable)
 {
-	u32 __iomem *reg = plic_enable_base(ctxid) + (hwirq / 32);
+	u32 __iomem *reg = handler->enable_base + (hwirq / 32) * sizeof(u32);
 	u32 hwirq_mask = 1 << (hwirq % 32);
 
-	raw_spin_lock(&plic_toggle_lock);
+	raw_spin_lock(&handler->enable_lock);
 	if (enable)
 		writel(readl(reg) | hwirq_mask, reg);
 	else
 		writel(readl(reg) & ~hwirq_mask, reg);
-	raw_spin_unlock(&plic_toggle_lock);
+	raw_spin_unlock(&handler->enable_lock);
 }
 
-static inline void plic_irq_toggle(struct irq_data *d, int enable)
+static inline void plic_irq_toggle(const struct cpumask *mask,
+				   int hwirq, int enable)
 {
 	int cpu;
 
-	writel(enable, plic_regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
-	for_each_cpu(cpu, irq_data_get_affinity_mask(d)) {
+	writel(enable, plic_regs + PRIORITY_BASE + hwirq * PRIORITY_PER_ID);
+	for_each_cpu(cpu, mask) {
 		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
 
 		if (handler->present)
-			plic_toggle(handler->ctxid, d->hwirq, enable);
+			plic_toggle(handler, hwirq, enable);
 	}
 }
 
 static void plic_irq_enable(struct irq_data *d)
 {
-	plic_irq_toggle(d, 1);
+	unsigned int cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
+					   cpu_online_mask);
+	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
+		return;
+	plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
 }
 
 static void plic_irq_disable(struct irq_data *d)
 {
-	plic_irq_toggle(d, 0);
+	plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
 }
 
+#ifdef CONFIG_SMP
+static int plic_set_affinity(struct irq_data *d,
+			     const struct cpumask *mask_val, bool force)
+{
+	unsigned int cpu;
+
+	if (force)
+		cpu = cpumask_first(mask_val);
+	else
+		cpu = cpumask_any_and(mask_val, cpu_online_mask);
+
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	if (!irqd_irq_disabled(d)) {
+		plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
+		plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
+	}
+
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+#endif
+
 static struct irq_chip plic_chip = {
 	.name		= "SiFive PLIC",
 	/*
@@ -123,6 +144,9 @@ static struct irq_chip plic_chip = {
 	 */
 	.irq_enable	= plic_irq_enable,
 	.irq_disable	= plic_irq_disable,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = plic_set_affinity,
+#endif
 };
 
 static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
@@ -150,7 +174,7 @@ static struct irq_domain *plic_irqdomain;
 static void plic_handle_irq(struct pt_regs *regs)
 {
 	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
-	void __iomem *claim = plic_hart_offset(handler->ctxid) + CONTEXT_CLAIM;
+	void __iomem *claim = handler->hart_base + CONTEXT_CLAIM;
 	irq_hw_number_t hwirq;
 
 	WARN_ON_ONCE(!handler->present);
@@ -186,7 +210,7 @@ static int plic_find_hart_id(struct device_node *node)
 static int __init plic_init(struct device_node *node,
 		struct device_node *parent)
 {
-	int error = 0, nr_handlers, nr_mapped = 0, i;
+	int error = 0, nr_contexts, nr_handlers = 0, i;
 	u32 nr_irqs;
 
 	if (plic_regs) {
@@ -203,10 +227,10 @@ static int __init plic_init(struct device_node *node,
 	if (WARN_ON(!nr_irqs))
 		goto out_iounmap;
 
-	nr_handlers = of_irq_count(node);
-	if (WARN_ON(!nr_handlers))
+	nr_contexts = of_irq_count(node);
+	if (WARN_ON(!nr_contexts))
 		goto out_iounmap;
-	if (WARN_ON(nr_handlers < num_possible_cpus()))
+	if (WARN_ON(nr_contexts < num_possible_cpus()))
 		goto out_iounmap;
 
 	error = -ENOMEM;
@@ -215,7 +239,7 @@ static int __init plic_init(struct device_node *node,
 	if (WARN_ON(!plic_irqdomain))
 		goto out_iounmap;
 
-	for (i = 0; i < nr_handlers; i++) {
+	for (i = 0; i < nr_contexts; i++) {
 		struct of_phandle_args parent;
 		struct plic_handler *handler;
 		irq_hw_number_t hwirq;
@@ -237,19 +261,33 @@ static int __init plic_init(struct device_node *node,
 		}
 
 		cpu = riscv_hartid_to_cpuid(hartid);
+		if (cpu < 0) {
+			pr_warn("Invalid cpuid for context %d\n", i);
+			continue;
+		}
+
 		handler = per_cpu_ptr(&plic_handlers, cpu);
+		if (handler->present) {
+			pr_warn("handler already present for context %d.\n", i);
+			continue;
+		}
+
 		handler->present = true;
-		handler->ctxid = i;
+		handler->hart_base =
+			plic_regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
+		raw_spin_lock_init(&handler->enable_lock);
+		handler->enable_base =
+			plic_regs + ENABLE_BASE + i * ENABLE_PER_HART;
 
 		/* priority must be > threshold to trigger an interrupt */
-		writel(0, plic_hart_offset(i) + CONTEXT_THRESHOLD);
+		writel(0, handler->hart_base + CONTEXT_THRESHOLD);
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
-			plic_toggle(i, hwirq, 0);
-		nr_mapped++;
+			plic_toggle(handler, hwirq, 0);
+		nr_handlers++;
 	}
 
-	pr_info("mapped %d interrupts to %d (out of %d) handlers.\n",
-		nr_irqs, nr_mapped, nr_handlers);
+	pr_info("mapped %d interrupts with %d handlers for %d contexts.\n",
+		nr_irqs, nr_handlers, nr_contexts);
 	set_handle_irq(plic_handle_irq);
 	return 0;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9bc585415d9b..a0fdd5fb4e7a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2041,53 +2041,52 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 	return ret;
 }
 
-/* irq_queues covers admin queue */
-static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
+/*
+ * nirqs is the number of interrupts available for write and read
+ * queues. The core already reserved an interrupt for the admin queue.
+ */
+static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
 {
-	unsigned int this_w_queues = write_queues;
-
-	WARN_ON(!irq_queues);
-
-	/*
-	 * Setup read/write queue split, assign admin queue one independent
-	 * irq vector if irq_queues is > 1.
-	 */
-	if (irq_queues <= 2) {
-		dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
-		dev->io_queues[HCTX_TYPE_READ] = 0;
-		return;
-	}
-
-	/*
-	 * If 'write_queues' is set, ensure it leaves room for at least
-	 * one read queue and one admin queue
-	 */
-	if (this_w_queues >= irq_queues)
-		this_w_queues = irq_queues - 2;
+	struct nvme_dev *dev = affd->priv;
+	unsigned int nr_read_queues;
 
 	/*
-	 * If 'write_queues' is set to zero, reads and writes will share
-	 * a queue set.
+	 * If there is no interupt available for queues, ensure that
+	 * the default queue is set to 1. The affinity set size is
+	 * also set to one, but the irq core ignores it for this case.
+	 *
+	 * If only one interrupt is available or 'write_queue' == 0, combine
+	 * write and read queues.
+	 *
+	 * If 'write_queues' > 0, ensure it leaves room for at least one read
+	 * queue.
 	 */
-	if (!this_w_queues) {
-		dev->io_queues[HCTX_TYPE_DEFAULT] = irq_queues - 1;
-		dev->io_queues[HCTX_TYPE_READ] = 0;
+	if (!nrirqs) {
+		nrirqs = 1;
+		nr_read_queues = 0;
+	} else if (nrirqs == 1 || !write_queues) {
+		nr_read_queues = 0;
+	} else if (write_queues >= nrirqs) {
+		nr_read_queues = 1;
 	} else {
-		dev->io_queues[HCTX_TYPE_DEFAULT] = this_w_queues;
-		dev->io_queues[HCTX_TYPE_READ] = irq_queues - this_w_queues - 1;
+		nr_read_queues = nrirqs - write_queues;
 	}
+
+	dev->io_queues[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
+	affd->set_size[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
+	dev->io_queues[HCTX_TYPE_READ] = nr_read_queues;
+	affd->set_size[HCTX_TYPE_READ] = nr_read_queues;
+	affd->nr_sets = nr_read_queues ? 2 : 1;
 }
 
 static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	int irq_sets[2];
 	struct irq_affinity affd = {
-		.pre_vectors = 1,
-		.nr_sets = ARRAY_SIZE(irq_sets),
-		.sets = irq_sets,
+		.pre_vectors	= 1,
+		.calc_sets	= nvme_calc_irq_sets,
+		.priv		= dev,
 	};
-	int result = 0;
 	unsigned int irq_queues, this_p_queues;
 
 	/*
@@ -2103,51 +2102,12 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 	}
 	dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
 
-	/*
-	 * For irq sets, we have to ask for minvec == maxvec. This passes
-	 * any reduction back to us, so we can adjust our queue counts and
-	 * IRQ vector needs.
-	 */
-	do {
-		nvme_calc_io_queues(dev, irq_queues);
-		irq_sets[0] = dev->io_queues[HCTX_TYPE_DEFAULT];
-		irq_sets[1] = dev->io_queues[HCTX_TYPE_READ];
-		if (!irq_sets[1])
-			affd.nr_sets = 1;
-
-		/*
-		 * If we got a failure and we're down to asking for just
-		 * 1 + 1 queues, just ask for a single vector. We'll share
-		 * that between the single IO queue and the admin queue.
-		 * Otherwise, we assign one independent vector to admin queue.
-		 */
-		if (irq_queues > 1)
-			irq_queues = irq_sets[0] + irq_sets[1] + 1;
+	/* Initialize for the single interrupt case */
+	dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
+	dev->io_queues[HCTX_TYPE_READ] = 0;
 
-		result = pci_alloc_irq_vectors_affinity(pdev, irq_queues,
-				irq_queues,
-				PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
-
-		/*
-		 * Need to reduce our vec counts. If we get ENOSPC, the
-		 * platform should support mulitple vecs, we just need
-		 * to decrease our ask. If we get EINVAL, the platform
-		 * likely does not. Back down to ask for just one vector.
-		 */
-		if (result == -ENOSPC) {
-			irq_queues--;
-			if (!irq_queues)
-				return result;
-			continue;
-		} else if (result == -EINVAL) {
-			irq_queues = 1;
-			continue;
-		} else if (result <= 0)
-			return -EIO;
-		break;
-	} while (1);
-
-	return result;
+	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
+			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
 }
 
 static void nvme_disable_io_queues(struct nvme_dev *dev)
@@ -3020,6 +2980,7 @@ static struct pci_driver nvme_driver = {
 
 static int __init nvme_init(void)
 {
+	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS < 2);
 	return pci_register_driver(&nvme_driver);
 }
 
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 4c0b47867258..73986825d221 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -532,7 +532,7 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 }
 
 static struct msi_desc *
-msi_setup_entry(struct pci_dev *dev, int nvec, const struct irq_affinity *affd)
+msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
 {
 	struct irq_affinity_desc *masks = NULL;
 	struct msi_desc *entry;
@@ -597,7 +597,7 @@ static int msi_verify_entries(struct pci_dev *dev)
  * which could have been allocated.
  */
 static int msi_capability_init(struct pci_dev *dev, int nvec,
-			       const struct irq_affinity *affd)
+			       struct irq_affinity *affd)
 {
 	struct msi_desc *entry;
 	int ret;
@@ -669,7 +669,7 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
 
 static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 			      struct msix_entry *entries, int nvec,
-			      const struct irq_affinity *affd)
+			      struct irq_affinity *affd)
 {
 	struct irq_affinity_desc *curmsk, *masks = NULL;
 	struct msi_desc *entry;
@@ -736,7 +736,7 @@ static void msix_program_entries(struct pci_dev *dev,
  * requested MSI-X entries with allocated irqs or non-zero for otherwise.
  **/
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
-				int nvec, const struct irq_affinity *affd)
+				int nvec, struct irq_affinity *affd)
 {
 	int ret;
 	u16 control;
@@ -932,7 +932,7 @@ int pci_msix_vec_count(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_msix_vec_count);
 
 static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
-			     int nvec, const struct irq_affinity *affd)
+			     int nvec, struct irq_affinity *affd)
 {
 	int nr_entries;
 	int i, j;
@@ -1018,7 +1018,7 @@ int pci_msi_enabled(void)
 EXPORT_SYMBOL(pci_msi_enabled);
 
 static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
-				  const struct irq_affinity *affd)
+				  struct irq_affinity *affd)
 {
 	int nvec;
 	int rc;
@@ -1035,13 +1035,6 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	if (maxvec < minvec)
 		return -ERANGE;
 
-	/*
-	 * If the caller is passing in sets, we can't support a range of
-	 * vectors. The caller needs to handle that.
-	 */
-	if (affd && affd->nr_sets && minvec != maxvec)
-		return -EINVAL;
-
 	if (WARN_ON_ONCE(dev->msi_enabled))
 		return -EINVAL;
 
@@ -1086,20 +1079,13 @@ EXPORT_SYMBOL(pci_enable_msi);
 
 static int __pci_enable_msix_range(struct pci_dev *dev,
 				   struct msix_entry *entries, int minvec,
-				   int maxvec, const struct irq_affinity *affd)
+				   int maxvec, struct irq_affinity *affd)
 {
 	int rc, nvec = maxvec;
 
 	if (maxvec < minvec)
 		return -ERANGE;
 
-	/*
-	 * If the caller is passing in sets, we can't support a range of
-	 * supported vectors. The caller needs to handle that.
-	 */
-	if (affd && affd->nr_sets && minvec != maxvec)
-		return -EINVAL;
-
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 
@@ -1165,9 +1151,9 @@ EXPORT_SYMBOL(pci_enable_msix_range);
  */
 int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   unsigned int max_vecs, unsigned int flags,
-				   const struct irq_affinity *affd)
+				   struct irq_affinity *affd)
 {
-	static const struct irq_affinity msi_default_affd;
+	struct irq_affinity msi_default_affd = {0};
 	int msix_vecs = -ENOSPC;
 	int msi_vecs = -ENOSPC;
 
@@ -1196,6 +1182,13 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 	/* use legacy irq if allowed */
 	if (flags & PCI_IRQ_LEGACY) {
 		if (min_vecs == 1 && dev->irq) {
+			/*
+			 * Invoke the affinity spreading logic to ensure that
+			 * the device driver can adjust queue configuration
+			 * for the single interrupt case.
+			 */
+			if (affd)
+				irq_create_affinity_masks(1, affd);
 			pci_intx(dev, 1);
 			return 1;
 		}
diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index 74e260027c7d..76e49d902609 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -3566,7 +3566,7 @@ static void be2iscsi_enable_msix(struct beiscsi_hba *phba)
 
 	/* if eqid_count == 1 fall back to INTX */
 	if (enable_msix && nvec > 1) {
-		const struct irq_affinity desc = { .post_vectors = 1 };
+		struct irq_affinity desc = { .post_vectors = 1 };
 
 		if (pci_alloc_irq_vectors_affinity(phba->pcidev, 2, nvec,
 				PCI_IRQ_MSIX | PCI_IRQ_AFFINITY, &desc) < 0) {
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 535eda7857cf..76175211b304 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -79,6 +79,31 @@ static u64 get_iowait_time(int cpu)
 
 #endif
 
+static void show_irq_gap(struct seq_file *p, unsigned int gap)
+{
+	static const char zeros[] = " 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0";
+
+	while (gap > 0) {
+		unsigned int inc;
+
+		inc = min_t(unsigned int, gap, ARRAY_SIZE(zeros) / 2);
+		seq_write(p, zeros, 2 * inc);
+		gap -= inc;
+	}
+}
+
+static void show_all_irqs(struct seq_file *p)
+{
+	unsigned int i, next = 0;
+
+	for_each_active_irq(i) {
+		show_irq_gap(p, i - next);
+		seq_put_decimal_ull(p, " ", kstat_irqs_usr(i));
+		next = i + 1;
+	}
+	show_irq_gap(p, nr_irqs - next);
+}
+
 static int show_stat(struct seq_file *p, void *v)
 {
 	int i, j;
@@ -156,9 +181,7 @@ static int show_stat(struct seq_file *p, void *v)
 	}
 	seq_put_decimal_ull(p, "intr ", (unsigned long long)sum);
 
-	/* sum again ? it could be updated? */
-	for_each_irq_nr(j)
-		seq_put_decimal_ull(p, " ", kstat_irqs_usr(j));
+	show_all_irqs(p);
 
 	seq_printf(p,
 		"\nctxt %llu\n"
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 4a728dba02e2..690b238a44d5 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -156,6 +156,10 @@ __request_percpu_irq(unsigned int irq, irq_handler_t handler,
 		     unsigned long flags, const char *devname,
 		     void __percpu *percpu_dev_id);
 
+extern int __must_check
+request_nmi(unsigned int irq, irq_handler_t handler, unsigned long flags,
+	    const char *name, void *dev);
+
 static inline int __must_check
 request_percpu_irq(unsigned int irq, irq_handler_t handler,
 		   const char *devname, void __percpu *percpu_dev_id)
@@ -164,9 +168,16 @@ request_percpu_irq(unsigned int irq, irq_handler_t handler,
 				    devname, percpu_dev_id);
 }
 
+extern int __must_check
+request_percpu_nmi(unsigned int irq, irq_handler_t handler,
+		   const char *devname, void __percpu *dev);
+
 extern const void *free_irq(unsigned int, void *);
 extern void free_percpu_irq(unsigned int, void __percpu *);
 
+extern const void *free_nmi(unsigned int irq, void *dev_id);
+extern void free_percpu_nmi(unsigned int irq, void __percpu *percpu_dev_id);
+
 struct device;
 
 extern int __must_check
@@ -217,6 +228,13 @@ extern void enable_percpu_irq(unsigned int irq, unsigned int type);
 extern bool irq_percpu_is_enabled(unsigned int irq);
 extern void irq_wake_thread(unsigned int irq, void *dev_id);
 
+extern void disable_nmi_nosync(unsigned int irq);
+extern void disable_percpu_nmi(unsigned int irq);
+extern void enable_nmi(unsigned int irq);
+extern void enable_percpu_nmi(unsigned int irq, unsigned int type);
+extern int prepare_percpu_nmi(unsigned int irq);
+extern void teardown_percpu_nmi(unsigned int irq);
+
 /* The following three functions are for the core kernel use only. */
 extern void suspend_device_irqs(void);
 extern void resume_device_irqs(void);
@@ -241,20 +259,29 @@ struct irq_affinity_notify {
 	void (*release)(struct kref *ref);
 };
 
+#define	IRQ_AFFINITY_MAX_SETS  4
+
 /**
  * struct irq_affinity - Description for automatic irq affinity assignements
  * @pre_vectors:	Don't apply affinity to @pre_vectors at beginning of
  *			the MSI(-X) vector space
  * @post_vectors:	Don't apply affinity to @post_vectors at end of
  *			the MSI(-X) vector space
- * @nr_sets:		Length of passed in *sets array
- * @sets:		Number of affinitized sets
+ * @nr_sets:		The number of interrupt sets for which affinity
+ *			spreading is required
+ * @set_size:		Array holding the size of each interrupt set
+ * @calc_sets:		Callback for calculating the number and size
+ *			of interrupt sets
+ * @priv:		Private data for usage by @calc_sets, usually a
+ *			pointer to driver/device specific data.
  */
 struct irq_affinity {
-	int	pre_vectors;
-	int	post_vectors;
-	int	nr_sets;
-	int	*sets;
+	unsigned int	pre_vectors;
+	unsigned int	post_vectors;
+	unsigned int	nr_sets;
+	unsigned int	set_size[IRQ_AFFINITY_MAX_SETS];
+	void		(*calc_sets)(struct irq_affinity *, unsigned int nvecs);
+	void		*priv;
 };
 
 /**
@@ -314,9 +341,10 @@ extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
 
 struct irq_affinity_desc *
-irq_create_affinity_masks(int nvec, const struct irq_affinity *affd);
+irq_create_affinity_masks(unsigned int nvec, struct irq_affinity *affd);
 
-int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd);
+unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
+				       const struct irq_affinity *affd);
 
 #else /* CONFIG_SMP */
 
@@ -350,13 +378,14 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 }
 
 static inline struct irq_affinity_desc *
-irq_create_affinity_masks(int nvec, const struct irq_affinity *affd)
+irq_create_affinity_masks(unsigned int nvec, struct irq_affinity *affd)
 {
 	return NULL;
 }
 
-static inline int
-irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd)
+static inline unsigned int
+irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
+			  const struct irq_affinity *affd)
 {
 	return maxvec;
 }
diff --git a/include/linux/irq.h b/include/linux/irq.h
index def2b2aac8b1..5e91f6bcaacd 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -442,6 +442,8 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  * @irq_set_vcpu_affinity:	optional to target a vCPU in a virtual machine
  * @ipi_send_single:	send a single IPI to destination cpus
  * @ipi_send_mask:	send an IPI to destination cpus in cpumask
+ * @irq_nmi_setup:	function called from core code before enabling an NMI
+ * @irq_nmi_teardown:	function called from core code after disabling an NMI
  * @flags:		chip specific flags
  */
 struct irq_chip {
@@ -490,6 +492,9 @@ struct irq_chip {
 	void		(*ipi_send_single)(struct irq_data *data, unsigned int cpu);
 	void		(*ipi_send_mask)(struct irq_data *data, const struct cpumask *dest);
 
+	int		(*irq_nmi_setup)(struct irq_data *data);
+	void		(*irq_nmi_teardown)(struct irq_data *data);
+
 	unsigned long	flags;
 };
 
@@ -505,6 +510,7 @@ struct irq_chip {
  * IRQCHIP_ONESHOT_SAFE:	One shot does not require mask/unmask
  * IRQCHIP_EOI_THREADED:	Chip requires eoi() on unmask in threaded mode
  * IRQCHIP_SUPPORTS_LEVEL_MSI	Chip can provide two doorbells for Level MSIs
+ * IRQCHIP_SUPPORTS_NMI:	Chip can deliver NMIs, only for root irqchips
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED		= (1 <<  0),
@@ -515,6 +521,7 @@ enum {
 	IRQCHIP_ONESHOT_SAFE		= (1 <<  5),
 	IRQCHIP_EOI_THREADED		= (1 <<  6),
 	IRQCHIP_SUPPORTS_LEVEL_MSI	= (1 <<  7),
+	IRQCHIP_SUPPORTS_NMI		= (1 <<  8),
 };
 
 #include <linux/irqdesc.h>
@@ -594,6 +601,9 @@ extern void handle_percpu_devid_irq(struct irq_desc *desc);
 extern void handle_bad_irq(struct irq_desc *desc);
 extern void handle_nested_irq(unsigned int irq);
 
+extern void handle_fasteoi_nmi(struct irq_desc *desc);
+extern void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc);
+
 extern int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg);
 extern int irq_chip_pm_get(struct irq_data *data);
 extern int irq_chip_pm_put(struct irq_data *data);
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index dd1e40ddac7d..d6e2ab538ef2 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -28,6 +28,7 @@ struct pt_regs;
  * @core_internal_state__do_not_mess_with_it: core internal status information
  * @depth:		disable-depth, for nested irq_disable() calls
  * @wake_depth:		enable depth, for multiple irq_set_irq_wake() callers
+ * @tot_count:		stats field for non-percpu irqs
  * @irq_count:		stats field to detect stalled irqs
  * @last_unhandled:	aging timer for unhandled count
  * @irqs_unhandled:	stats field for spurious unhandled interrupts
@@ -65,6 +66,7 @@ struct irq_desc {
 	unsigned int		core_internal_state__do_not_mess_with_it;
 	unsigned int		depth;		/* nested irq disables */
 	unsigned int		wake_depth;	/* nested wake enables */
+	unsigned int		tot_count;
 	unsigned int		irq_count;	/* For detecting broken IRQs */
 	unsigned long		last_unhandled;	/* Aging timer for unhandled count */
 	unsigned int		irqs_unhandled;
@@ -171,6 +173,11 @@ static inline int handle_domain_irq(struct irq_domain *domain,
 {
 	return __handle_domain_irq(domain, hwirq, true, regs);
 }
+
+#ifdef CONFIG_IRQ_DOMAIN
+int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
+		      struct pt_regs *regs);
+#endif
 #endif
 
 /* Test to see if a driver has successfully requested an irq */
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 35965f41d7be..d2130dc7c0e6 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -265,6 +265,7 @@ extern struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 						   enum irq_domain_bus_token bus_token);
 extern bool irq_domain_check_msi_remap(void);
 extern void irq_set_default_host(struct irq_domain *host);
+extern struct irq_domain *irq_get_default_host(void);
 extern int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
 				  irq_hw_number_t hwirq, int node,
 				  const struct irq_affinity_desc *affinity);
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index c1961761311d..1577a2d56e9d 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -56,6 +56,7 @@ void kthread_bind_mask(struct task_struct *k, const struct cpumask *mask);
 int kthread_stop(struct task_struct *k);
 bool kthread_should_stop(void);
 bool kthread_should_park(void);
+bool __kthread_should_park(struct task_struct *k);
 bool kthread_freezable_should_stop(bool *was_frozen);
 void *kthread_data(struct task_struct *k);
 void *kthread_probe_data(struct task_struct *k);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 65f1d8c2f082..e7c51b00cdfe 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1393,7 +1393,7 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
 }
 int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   unsigned int max_vecs, unsigned int flags,
-				   const struct irq_affinity *affd);
+				   struct irq_affinity *affd);
 
 void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
@@ -1419,7 +1419,7 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
 static inline int
 pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 			       unsigned int max_vecs, unsigned int flags,
-			       const struct irq_affinity *aff_desc)
+			       struct irq_affinity *aff_desc)
 {
 	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1 && dev->irq)
 		return 1;
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 45b68b4ea48b..f18cd5aa33e8 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -9,7 +9,7 @@
 #include <linux/cpu.h>
 
 static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
-				int cpus_per_vec)
+				unsigned int cpus_per_vec)
 {
 	const struct cpumask *siblmsk;
 	int cpu, sibl;
@@ -95,15 +95,17 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
 }
 
 static int __irq_build_affinity_masks(const struct irq_affinity *affd,
-				      int startvec, int numvecs, int firstvec,
+				      unsigned int startvec,
+				      unsigned int numvecs,
+				      unsigned int firstvec,
 				      cpumask_var_t *node_to_cpumask,
 				      const struct cpumask *cpu_mask,
 				      struct cpumask *nmsk,
 				      struct irq_affinity_desc *masks)
 {
-	int n, nodes, cpus_per_vec, extra_vecs, done = 0;
-	int last_affv = firstvec + numvecs;
-	int curvec = startvec;
+	unsigned int n, nodes, cpus_per_vec, extra_vecs, done = 0;
+	unsigned int last_affv = firstvec + numvecs;
+	unsigned int curvec = startvec;
 	nodemask_t nodemsk = NODE_MASK_NONE;
 
 	if (!cpumask_weight(cpu_mask))
@@ -117,18 +119,16 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
 	 */
 	if (numvecs <= nodes) {
 		for_each_node_mask(n, nodemsk) {
-			cpumask_or(&masks[curvec].mask,
-					&masks[curvec].mask,
-					node_to_cpumask[n]);
+			cpumask_or(&masks[curvec].mask, &masks[curvec].mask,
+				   node_to_cpumask[n]);
 			if (++curvec == last_affv)
 				curvec = firstvec;
 		}
-		done = numvecs;
-		goto out;
+		return numvecs;
 	}
 
 	for_each_node_mask(n, nodemsk) {
-		int ncpus, v, vecs_to_assign, vecs_per_node;
+		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
 
 		/* Spread the vectors per node */
 		vecs_per_node = (numvecs - (curvec - firstvec)) / nodes;
@@ -163,8 +163,6 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
 			curvec = firstvec;
 		--nodes;
 	}
-
-out:
 	return done;
 }
 
@@ -174,19 +172,24 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
  *	2) spread other possible CPUs on these vectors
  */
 static int irq_build_affinity_masks(const struct irq_affinity *affd,
-				    int startvec, int numvecs, int firstvec,
-				    cpumask_var_t *node_to_cpumask,
+				    unsigned int startvec, unsigned int numvecs,
+				    unsigned int firstvec,
 				    struct irq_affinity_desc *masks)
 {
-	int curvec = startvec, nr_present, nr_others;
-	int ret = -ENOMEM;
+	unsigned int curvec = startvec, nr_present, nr_others;
+	cpumask_var_t *node_to_cpumask;
 	cpumask_var_t nmsk, npresmsk;
+	int ret = -ENOMEM;
 
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return ret;
 
 	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
-		goto fail;
+		goto fail_nmsk;
+
+	node_to_cpumask = alloc_node_to_cpumask();
+	if (!node_to_cpumask)
+		goto fail_npresmsk;
 
 	ret = 0;
 	/* Stabilize the cpumasks */
@@ -217,13 +220,22 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 	if (nr_present < numvecs)
 		WARN_ON(nr_present + nr_others < numvecs);
 
+	free_node_to_cpumask(node_to_cpumask);
+
+ fail_npresmsk:
 	free_cpumask_var(npresmsk);
 
- fail:
+ fail_nmsk:
 	free_cpumask_var(nmsk);
 	return ret;
 }
 
+static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
+{
+	affd->nr_sets = 1;
+	affd->set_size[0] = affvecs;
+}
+
 /**
  * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
  * @nvecs:	The total number of vectors
@@ -232,50 +244,62 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
  * Returns the irq_affinity_desc pointer or NULL if allocation failed.
  */
 struct irq_affinity_desc *
-irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
+irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 {
-	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
-	int curvec, usedvecs;
-	cpumask_var_t *node_to_cpumask;
+	unsigned int affvecs, curvec, usedvecs, i;
 	struct irq_affinity_desc *masks = NULL;
-	int i, nr_sets;
 
 	/*
-	 * If there aren't any vectors left after applying the pre/post
-	 * vectors don't bother with assigning affinity.
+	 * Determine the number of vectors which need interrupt affinities
+	 * assigned. If the pre/post request exhausts the available vectors
+	 * then nothing to do here except for invoking the calc_sets()
+	 * callback so the device driver can adjust to the situation. If there
+	 * is only a single vector, then managing the queue is pointless as
+	 * well.
 	 */
-	if (nvecs == affd->pre_vectors + affd->post_vectors)
+	if (nvecs > 1 && nvecs > affd->pre_vectors + affd->post_vectors)
+		affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
+	else
+		affvecs = 0;
+
+	/*
+	 * Simple invocations do not provide a calc_sets() callback. Install
+	 * the generic one.
+	 */
+	if (!affd->calc_sets)
+		affd->calc_sets = default_calc_sets;
+
+	/* Recalculate the sets */
+	affd->calc_sets(affd, affvecs);
+
+	if (WARN_ON_ONCE(affd->nr_sets > IRQ_AFFINITY_MAX_SETS))
 		return NULL;
 
-	node_to_cpumask = alloc_node_to_cpumask();
-	if (!node_to_cpumask)
+	/* Nothing to assign? */
+	if (!affvecs)
 		return NULL;
 
 	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
 	if (!masks)
-		goto outnodemsk;
+		return NULL;
 
 	/* Fill out vectors at the beginning that don't need affinity */
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
 		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
+
 	/*
 	 * Spread on present CPUs starting from affd->pre_vectors. If we
 	 * have multiple sets, build each sets affinity mask separately.
 	 */
-	nr_sets = affd->nr_sets;
-	if (!nr_sets)
-		nr_sets = 1;
-
-	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
-		int this_vecs = affd->sets ? affd->sets[i] : affvecs;
+	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
+		unsigned int this_vecs = affd->set_size[i];
 		int ret;
 
 		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
-						curvec, node_to_cpumask, masks);
+					       curvec, masks);
 		if (ret) {
 			kfree(masks);
-			masks = NULL;
-			goto outnodemsk;
+			return NULL;
 		}
 		curvec += this_vecs;
 		usedvecs += this_vecs;
@@ -293,8 +317,6 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	for (i = affd->pre_vectors; i < nvecs - affd->post_vectors; i++)
 		masks[i].is_managed = 1;
 
-outnodemsk:
-	free_node_to_cpumask(node_to_cpumask);
 	return masks;
 }
 
@@ -304,25 +326,22 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
  * @maxvec:	The maximum number of vectors available
  * @affd:	Description of the affinity requirements
  */
-int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd)
+unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
+				       const struct irq_affinity *affd)
 {
-	int resv = affd->pre_vectors + affd->post_vectors;
-	int vecs = maxvec - resv;
-	int set_vecs;
+	unsigned int resv = affd->pre_vectors + affd->post_vectors;
+	unsigned int set_vecs;
 
 	if (resv > minvec)
 		return 0;
 
-	if (affd->nr_sets) {
-		int i;
-
-		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
-			set_vecs += affd->sets[i];
+	if (affd->calc_sets) {
+		set_vecs = maxvec - resv;
 	} else {
 		get_online_cpus();
 		set_vecs = cpumask_weight(cpu_possible_mask);
 		put_online_cpus();
 	}
 
-	return resv + min(set_vecs, vecs);
+	return resv + min(set_vecs, maxvec - resv);
 }
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 34e969069488..99b7dd6982a4 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -729,6 +729,37 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 }
 EXPORT_SYMBOL_GPL(handle_fasteoi_irq);
 
+/**
+ *	handle_fasteoi_nmi - irq handler for NMI interrupt lines
+ *	@desc:	the interrupt description structure for this irq
+ *
+ *	A simple NMI-safe handler, considering the restrictions
+ *	from request_nmi.
+ *
+ *	Only a single callback will be issued to the chip: an ->eoi()
+ *	call when the interrupt has been serviced. This enables support
+ *	for modern forms of interrupt handlers, which handle the flow
+ *	details in hardware, transparently.
+ */
+void handle_fasteoi_nmi(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irqaction *action = desc->action;
+	unsigned int irq = irq_desc_get_irq(desc);
+	irqreturn_t res;
+
+	trace_irq_handler_entry(irq, action);
+	/*
+	 * NMIs cannot be shared, there is only one action.
+	 */
+	res = action->handler(irq, action->dev_id);
+	trace_irq_handler_exit(irq, action, res);
+
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
+}
+EXPORT_SYMBOL_GPL(handle_fasteoi_nmi);
+
 /**
  *	handle_edge_irq - edge type IRQ handler
  *	@desc:	the interrupt description structure for this irq
@@ -855,7 +886,11 @@ void handle_percpu_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
-	kstat_incr_irqs_this_cpu(desc);
+	/*
+	 * PER CPU interrupts are not serialized. Do not touch
+	 * desc->tot_count.
+	 */
+	__kstat_incr_irqs_this_cpu(desc);
 
 	if (chip->irq_ack)
 		chip->irq_ack(&desc->irq_data);
@@ -884,7 +919,11 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 	unsigned int irq = irq_desc_get_irq(desc);
 	irqreturn_t res;
 
-	kstat_incr_irqs_this_cpu(desc);
+	/*
+	 * PER CPU interrupts are not serialized. Do not touch
+	 * desc->tot_count.
+	 */
+	__kstat_incr_irqs_this_cpu(desc);
 
 	if (chip->irq_ack)
 		chip->irq_ack(&desc->irq_data);
@@ -908,6 +947,29 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 		chip->irq_eoi(&desc->irq_data);
 }
 
+/**
+ * handle_percpu_devid_fasteoi_nmi - Per CPU local NMI handler with per cpu
+ *				     dev ids
+ * @desc:	the interrupt description structure for this irq
+ *
+ * Similar to handle_fasteoi_nmi, but handling the dev_id cookie
+ * as a percpu pointer.
+ */
+void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irqaction *action = desc->action;
+	unsigned int irq = irq_desc_get_irq(desc);
+	irqreturn_t res;
+
+	trace_irq_handler_entry(irq, action);
+	res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
+	trace_irq_handler_exit(irq, action, res);
+
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
+}
+
 static void
 __irq_do_set_handler(struct irq_desc *desc, irq_flow_handler_t handle,
 		     int is_chained, const char *name)
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 6f636136cccc..516c00a5e867 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -56,6 +56,7 @@ static const struct irq_bit_descr irqchip_flags[] = {
 	BIT_MASK_DESCR(IRQCHIP_ONESHOT_SAFE),
 	BIT_MASK_DESCR(IRQCHIP_EOI_THREADED),
 	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_LEVEL_MSI),
+	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_NMI),
 };
 
 static void
@@ -140,6 +141,7 @@ static const struct irq_bit_descr irqdesc_istates[] = {
 	BIT_MASK_DESCR(IRQS_WAITING),
 	BIT_MASK_DESCR(IRQS_PENDING),
 	BIT_MASK_DESCR(IRQS_SUSPENDED),
+	BIT_MASK_DESCR(IRQS_NMI),
 };
 
 
@@ -203,8 +205,8 @@ static ssize_t irq_debug_write(struct file *file, const char __user *user_buf,
 		chip_bus_lock(desc);
 		raw_spin_lock_irqsave(&desc->lock, flags);
 
-		if (irq_settings_is_level(desc)) {
-			/* Can't do level, sorry */
+		if (irq_settings_is_level(desc) || desc->istate & IRQS_NMI) {
+			/* Can't do level nor NMIs, sorry */
 			err = -EINVAL;
 		} else {
 			desc->istate |= IRQS_PENDING;
@@ -256,8 +258,6 @@ static int __init irq_debugfs_init(void)
 	int irq;
 
 	root_dir = debugfs_create_dir("irq", NULL);
-	if (!root_dir)
-		return -ENOMEM;
 
 	irq_domain_debugfs_init(root_dir);
 
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 38554bc35375..6df5ddfdb0f8 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -166,7 +166,7 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags
 
 			__irq_wake_thread(desc, action);
 
-			/* Fall through to add to randomness */
+			/* Fall through - to add to randomness */
 		case IRQ_HANDLED:
 			*flags |= action->flags;
 			break;
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index ca6afa267070..70c3053bc1f6 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -49,6 +49,7 @@ enum {
  * IRQS_WAITING			- irq is waiting
  * IRQS_PENDING			- irq is pending and replayed later
  * IRQS_SUSPENDED		- irq is suspended
+ * IRQS_NMI			- irq line is used to deliver NMIs
  */
 enum {
 	IRQS_AUTODETECT		= 0x00000001,
@@ -60,6 +61,7 @@ enum {
 	IRQS_PENDING		= 0x00000200,
 	IRQS_SUSPENDED		= 0x00000800,
 	IRQS_TIMINGS		= 0x00001000,
+	IRQS_NMI		= 0x00002000,
 };
 
 #include "debug.h"
@@ -242,12 +244,18 @@ static inline void irq_state_set_masked(struct irq_desc *desc)
 
 #undef __irqd_to_state
 
-static inline void kstat_incr_irqs_this_cpu(struct irq_desc *desc)
+static inline void __kstat_incr_irqs_this_cpu(struct irq_desc *desc)
 {
 	__this_cpu_inc(*desc->kstat_irqs);
 	__this_cpu_inc(kstat.irqs_sum);
 }
 
+static inline void kstat_incr_irqs_this_cpu(struct irq_desc *desc)
+{
+	__kstat_incr_irqs_this_cpu(desc);
+	desc->tot_count++;
+}
+
 static inline int irq_desc_get_node(struct irq_desc *desc)
 {
 	return irq_common_data_get_node(&desc->irq_common_data);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index ef8ad36cadcf..13539e12cd80 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -119,6 +119,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 	desc->depth = 1;
 	desc->irq_count = 0;
 	desc->irqs_unhandled = 0;
+	desc->tot_count = 0;
 	desc->name = NULL;
 	desc->owner = owner;
 	for_each_possible_cpu(cpu)
@@ -669,6 +670,41 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
 	set_irq_regs(old_regs);
 	return ret;
 }
+
+#ifdef CONFIG_IRQ_DOMAIN
+/**
+ * handle_domain_nmi - Invoke the handler for a HW irq belonging to a domain
+ * @domain:	The domain where to perform the lookup
+ * @hwirq:	The HW irq number to convert to a logical one
+ * @regs:	Register file coming from the low-level handling code
+ *
+ * Returns:	0 on success, or -EINVAL if conversion has failed
+ */
+int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
+		      struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+	unsigned int irq;
+	int ret = 0;
+
+	nmi_enter();
+
+	irq = irq_find_mapping(domain, hwirq);
+
+	/*
+	 * ack_bad_irq is not NMI-safe, just report
+	 * an invalid interrupt.
+	 */
+	if (likely(irq))
+		generic_handle_irq(irq);
+	else
+		ret = -EINVAL;
+
+	nmi_exit();
+	set_irq_regs(old_regs);
+	return ret;
+}
+#endif
 #endif
 
 /* Dynamic interrupt handling */
@@ -919,11 +955,15 @@ unsigned int kstat_irqs_cpu(unsigned int irq, int cpu)
 unsigned int kstat_irqs(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
-	int cpu;
 	unsigned int sum = 0;
+	int cpu;
 
 	if (!desc || !desc->kstat_irqs)
 		return 0;
+	if (!irq_settings_is_per_cpu_devid(desc) &&
+	    !irq_settings_is_per_cpu(desc))
+	    return desc->tot_count;
+
 	for_each_possible_cpu(cpu)
 		sum += *per_cpu_ptr(desc->kstat_irqs, cpu);
 	return sum;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8b0be4bd6565..3bf9793d8825 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -458,6 +458,20 @@ void irq_set_default_host(struct irq_domain *domain)
 }
 EXPORT_SYMBOL_GPL(irq_set_default_host);
 
+/**
+ * irq_get_default_host() - Retrieve the "default" irq domain
+ *
+ * Returns: the default domain, if any.
+ *
+ * Modern code should never use this. This should only be used on
+ * systems that cannot implement a firmware->fwnode mapping (which
+ * both DT and ACPI provide).
+ */
+struct irq_domain *irq_get_default_host(void)
+{
+	return irq_default_domain;
+}
+
 static void irq_domain_clear_mapping(struct irq_domain *domain,
 				     irq_hw_number_t hwirq)
 {
@@ -1749,8 +1763,6 @@ void __init irq_domain_debugfs_init(struct dentry *root)
 	struct irq_domain *d;
 
 	domain_dir = debugfs_create_dir("domains", root);
-	if (!domain_dir)
-		return;
 
 	debugfs_create_file("default", 0444, domain_dir, NULL,
 			    &irq_domain_debug_fops);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 84b54a17b95d..9ec34a2a6638 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -341,7 +341,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 	/* The release function is promised process context */
 	might_sleep();
 
-	if (!desc)
+	if (!desc || desc->istate & IRQS_NMI)
 		return -EINVAL;
 
 	/* Complete initialisation of *notify */
@@ -553,6 +553,21 @@ bool disable_hardirq(unsigned int irq)
 }
 EXPORT_SYMBOL_GPL(disable_hardirq);
 
+/**
+ *	disable_nmi_nosync - disable an nmi without waiting
+ *	@irq: Interrupt to disable
+ *
+ *	Disable the selected interrupt line. Disables and enables are
+ *	nested.
+ *	The interrupt to disable must have been requested through request_nmi.
+ *	Unlike disable_nmi(), this function does not ensure existing
+ *	instances of the IRQ handler have completed before returning.
+ */
+void disable_nmi_nosync(unsigned int irq)
+{
+	disable_irq_nosync(irq);
+}
+
 void __enable_irq(struct irq_desc *desc)
 {
 	switch (desc->depth) {
@@ -609,6 +624,20 @@ void enable_irq(unsigned int irq)
 }
 EXPORT_SYMBOL(enable_irq);
 
+/**
+ *	enable_nmi - enable handling of an nmi
+ *	@irq: Interrupt to enable
+ *
+ *	The interrupt to enable must have been requested through request_nmi.
+ *	Undoes the effect of one call to disable_nmi(). If this
+ *	matches the last disable, processing of interrupts on this
+ *	IRQ line is re-enabled.
+ */
+void enable_nmi(unsigned int irq)
+{
+	enable_irq(irq);
+}
+
 static int set_irq_wake_real(unsigned int irq, unsigned int on)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
@@ -644,6 +673,12 @@ int irq_set_irq_wake(unsigned int irq, unsigned int on)
 	if (!desc)
 		return -EINVAL;
 
+	/* Don't use NMIs as wake up interrupts please */
+	if (desc->istate & IRQS_NMI) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	/* wakeup-capable irqs can be shared between drivers that
 	 * don't need to have the same sleep mode behaviors.
 	 */
@@ -666,6 +701,8 @@ int irq_set_irq_wake(unsigned int irq, unsigned int on)
 				irqd_clear(&desc->irq_data, IRQD_WAKEUP_STATE);
 		}
 	}
+
+out_unlock:
 	irq_put_desc_busunlock(desc, flags);
 	return ret;
 }
@@ -726,6 +763,7 @@ int __irq_set_trigger(struct irq_desc *desc, unsigned long flags)
 	case IRQ_SET_MASK_OK_DONE:
 		irqd_clear(&desc->irq_data, IRQD_TRIGGER_MASK);
 		irqd_set(&desc->irq_data, flags);
+		/* fall through */
 
 	case IRQ_SET_MASK_OK_NOCOPY:
 		flags = irqd_get_trigger_type(&desc->irq_data);
@@ -1128,6 +1166,39 @@ static void irq_release_resources(struct irq_desc *desc)
 		c->irq_release_resources(d);
 }
 
+static bool irq_supports_nmi(struct irq_desc *desc)
+{
+	struct irq_data *d = irq_desc_get_irq_data(desc);
+
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+	/* Only IRQs directly managed by the root irqchip can be set as NMI */
+	if (d->parent_data)
+		return false;
+#endif
+	/* Don't support NMIs for chips behind a slow bus */
+	if (d->chip->irq_bus_lock || d->chip->irq_bus_sync_unlock)
+		return false;
+
+	return d->chip->flags & IRQCHIP_SUPPORTS_NMI;
+}
+
+static int irq_nmi_setup(struct irq_desc *desc)
+{
+	struct irq_data *d = irq_desc_get_irq_data(desc);
+	struct irq_chip *c = d->chip;
+
+	return c->irq_nmi_setup ? c->irq_nmi_setup(d) : -EINVAL;
+}
+
+static void irq_nmi_teardown(struct irq_desc *desc)
+{
+	struct irq_data *d = irq_desc_get_irq_data(desc);
+	struct irq_chip *c = d->chip;
+
+	if (c->irq_nmi_teardown)
+		c->irq_nmi_teardown(d);
+}
+
 static int
 setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
 {
@@ -1302,9 +1373,17 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		 * fields must have IRQF_SHARED set and the bits which
 		 * set the trigger type must match. Also all must
 		 * agree on ONESHOT.
+		 * Interrupt lines used for NMIs cannot be shared.
 		 */
 		unsigned int oldtype;
 
+		if (desc->istate & IRQS_NMI) {
+			pr_err("Invalid attempt to share NMI for %s (irq %d) on irqchip %s.\n",
+				new->name, irq, desc->irq_data.chip->name);
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
 		/*
 		 * If nobody did set the configuration before, inherit
 		 * the one provided by the requester.
@@ -1756,6 +1835,59 @@ const void *free_irq(unsigned int irq, void *dev_id)
 }
 EXPORT_SYMBOL(free_irq);
 
+/* This function must be called with desc->lock held */
+static const void *__cleanup_nmi(unsigned int irq, struct irq_desc *desc)
+{
+	const char *devname = NULL;
+
+	desc->istate &= ~IRQS_NMI;
+
+	if (!WARN_ON(desc->action == NULL)) {
+		irq_pm_remove_action(desc, desc->action);
+		devname = desc->action->name;
+		unregister_handler_proc(irq, desc->action);
+
+		kfree(desc->action);
+		desc->action = NULL;
+	}
+
+	irq_settings_clr_disable_unlazy(desc);
+	irq_shutdown(desc);
+
+	irq_release_resources(desc);
+
+	irq_chip_pm_put(&desc->irq_data);
+	module_put(desc->owner);
+
+	return devname;
+}
+
+const void *free_nmi(unsigned int irq, void *dev_id)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+	unsigned long flags;
+	const void *devname;
+
+	if (!desc || WARN_ON(!(desc->istate & IRQS_NMI)))
+		return NULL;
+
+	if (WARN_ON(irq_settings_is_per_cpu_devid(desc)))
+		return NULL;
+
+	/* NMI still enabled */
+	if (WARN_ON(desc->depth == 0))
+		disable_nmi_nosync(irq);
+
+	raw_spin_lock_irqsave(&desc->lock, flags);
+
+	irq_nmi_teardown(desc);
+	devname = __cleanup_nmi(irq, desc);
+
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+
+	return devname;
+}
+
 /**
  *	request_threaded_irq - allocate an interrupt line
  *	@irq: Interrupt line to allocate
@@ -1925,6 +2057,101 @@ int request_any_context_irq(unsigned int irq, irq_handler_t handler,
 }
 EXPORT_SYMBOL_GPL(request_any_context_irq);
 
+/**
+ *	request_nmi - allocate an interrupt line for NMI delivery
+ *	@irq: Interrupt line to allocate
+ *	@handler: Function to be called when the IRQ occurs.
+ *		  Threaded handler for threaded interrupts.
+ *	@irqflags: Interrupt type flags
+ *	@name: An ascii name for the claiming device
+ *	@dev_id: A cookie passed back to the handler function
+ *
+ *	This call allocates interrupt resources and enables the
+ *	interrupt line and IRQ handling. It sets up the IRQ line
+ *	to be handled as an NMI.
+ *
+ *	An interrupt line delivering NMIs cannot be shared and IRQ handling
+ *	cannot be threaded.
+ *
+ *	Interrupt lines requested for NMI delivering must produce per cpu
+ *	interrupts and have auto enabling setting disabled.
+ *
+ *	Dev_id must be globally unique. Normally the address of the
+ *	device data structure is used as the cookie. Since the handler
+ *	receives this value it makes sense to use it.
+ *
+ *	If the interrupt line cannot be used to deliver NMIs, function
+ *	will fail and return a negative value.
+ */
+int request_nmi(unsigned int irq, irq_handler_t handler,
+		unsigned long irqflags, const char *name, void *dev_id)
+{
+	struct irqaction *action;
+	struct irq_desc *desc;
+	unsigned long flags;
+	int retval;
+
+	if (irq == IRQ_NOTCONNECTED)
+		return -ENOTCONN;
+
+	/* NMI cannot be shared, used for Polling */
+	if (irqflags & (IRQF_SHARED | IRQF_COND_SUSPEND | IRQF_IRQPOLL))
+		return -EINVAL;
+
+	if (!(irqflags & IRQF_PERCPU))
+		return -EINVAL;
+
+	if (!handler)
+		return -EINVAL;
+
+	desc = irq_to_desc(irq);
+
+	if (!desc || irq_settings_can_autoenable(desc) ||
+	    !irq_settings_can_request(desc) ||
+	    WARN_ON(irq_settings_is_per_cpu_devid(desc)) ||
+	    !irq_supports_nmi(desc))
+		return -EINVAL;
+
+	action = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
+	if (!action)
+		return -ENOMEM;
+
+	action->handler = handler;
+	action->flags = irqflags | IRQF_NO_THREAD | IRQF_NOBALANCING;
+	action->name = name;
+	action->dev_id = dev_id;
+
+	retval = irq_chip_pm_get(&desc->irq_data);
+	if (retval < 0)
+		goto err_out;
+
+	retval = __setup_irq(irq, desc, action);
+	if (retval)
+		goto err_irq_setup;
+
+	raw_spin_lock_irqsave(&desc->lock, flags);
+
+	/* Setup NMI state */
+	desc->istate |= IRQS_NMI;
+	retval = irq_nmi_setup(desc);
+	if (retval) {
+		__cleanup_nmi(irq, desc);
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+		return -EINVAL;
+	}
+
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+
+	return 0;
+
+err_irq_setup:
+	irq_chip_pm_put(&desc->irq_data);
+err_out:
+	kfree(action);
+
+	return retval;
+}
+
 void enable_percpu_irq(unsigned int irq, unsigned int type)
 {
 	unsigned int cpu = smp_processor_id();
@@ -1959,6 +2186,11 @@ void enable_percpu_irq(unsigned int irq, unsigned int type)
 }
 EXPORT_SYMBOL_GPL(enable_percpu_irq);
 
+void enable_percpu_nmi(unsigned int irq, unsigned int type)
+{
+	enable_percpu_irq(irq, type);
+}
+
 /**
  * irq_percpu_is_enabled - Check whether the per cpu irq is enabled
  * @irq:	Linux irq number to check for
@@ -1998,6 +2230,11 @@ void disable_percpu_irq(unsigned int irq)
 }
 EXPORT_SYMBOL_GPL(disable_percpu_irq);
 
+void disable_percpu_nmi(unsigned int irq)
+{
+	disable_percpu_irq(irq);
+}
+
 /*
  * Internal function to unregister a percpu irqaction.
  */
@@ -2029,6 +2266,8 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
 	/* Found it - now remove it from the list of entries: */
 	desc->action = NULL;
 
+	desc->istate &= ~IRQS_NMI;
+
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
 	unregister_handler_proc(irq, action);
@@ -2082,6 +2321,19 @@ void free_percpu_irq(unsigned int irq, void __percpu *dev_id)
 }
 EXPORT_SYMBOL_GPL(free_percpu_irq);
 
+void free_percpu_nmi(unsigned int irq, void __percpu *dev_id)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+
+	if (!desc || !irq_settings_is_per_cpu_devid(desc))
+		return;
+
+	if (WARN_ON(!(desc->istate & IRQS_NMI)))
+		return;
+
+	kfree(__free_percpu_irq(irq, dev_id));
+}
+
 /**
  *	setup_percpu_irq - setup a per-cpu interrupt
  *	@irq: Interrupt line to setup
@@ -2171,6 +2423,158 @@ int __request_percpu_irq(unsigned int irq, irq_handler_t handler,
 }
 EXPORT_SYMBOL_GPL(__request_percpu_irq);
 
+/**
+ *	request_percpu_nmi - allocate a percpu interrupt line for NMI delivery
+ *	@irq: Interrupt line to allocate
+ *	@handler: Function to be called when the IRQ occurs.
+ *	@name: An ascii name for the claiming device
+ *	@dev_id: A percpu cookie passed back to the handler function
+ *
+ *	This call allocates interrupt resources for a per CPU NMI. Per CPU NMIs
+ *	have to be setup on each CPU by calling prepare_percpu_nmi() before
+ *	being enabled on the same CPU by using enable_percpu_nmi().
+ *
+ *	Dev_id must be globally unique. It is a per-cpu variable, and
+ *	the handler gets called with the interrupted CPU's instance of
+ *	that variable.
+ *
+ *	Interrupt lines requested for NMI delivering should have auto enabling
+ *	setting disabled.
+ *
+ *	If the interrupt line cannot be used to deliver NMIs, function
+ *	will fail returning a negative value.
+ */
+int request_percpu_nmi(unsigned int irq, irq_handler_t handler,
+		       const char *name, void __percpu *dev_id)
+{
+	struct irqaction *action;
+	struct irq_desc *desc;
+	unsigned long flags;
+	int retval;
+
+	if (!handler)
+		return -EINVAL;
+
+	desc = irq_to_desc(irq);
+
+	if (!desc || !irq_settings_can_request(desc) ||
+	    !irq_settings_is_per_cpu_devid(desc) ||
+	    irq_settings_can_autoenable(desc) ||
+	    !irq_supports_nmi(desc))
+		return -EINVAL;
+
+	/* The line cannot already be NMI */
+	if (desc->istate & IRQS_NMI)
+		return -EINVAL;
+
+	action = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
+	if (!action)
+		return -ENOMEM;
+
+	action->handler = handler;
+	action->flags = IRQF_PERCPU | IRQF_NO_SUSPEND | IRQF_NO_THREAD
+		| IRQF_NOBALANCING;
+	action->name = name;
+	action->percpu_dev_id = dev_id;
+
+	retval = irq_chip_pm_get(&desc->irq_data);
+	if (retval < 0)
+		goto err_out;
+
+	retval = __setup_irq(irq, desc, action);
+	if (retval)
+		goto err_irq_setup;
+
+	raw_spin_lock_irqsave(&desc->lock, flags);
+	desc->istate |= IRQS_NMI;
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+
+	return 0;
+
+err_irq_setup:
+	irq_chip_pm_put(&desc->irq_data);
+err_out:
+	kfree(action);
+
+	return retval;
+}
+
+/**
+ *	prepare_percpu_nmi - performs CPU local setup for NMI delivery
+ *	@irq: Interrupt line to prepare for NMI delivery
+ *
+ *	This call prepares an interrupt line to deliver NMI on the current CPU,
+ *	before that interrupt line gets enabled with enable_percpu_nmi().
+ *
+ *	As a CPU local operation, this should be called from non-preemptible
+ *	context.
+ *
+ *	If the interrupt line cannot be used to deliver NMIs, function
+ *	will fail returning a negative value.
+ */
+int prepare_percpu_nmi(unsigned int irq)
+{
+	unsigned long flags;
+	struct irq_desc *desc;
+	int ret = 0;
+
+	WARN_ON(preemptible());
+
+	desc = irq_get_desc_lock(irq, &flags,
+				 IRQ_GET_DESC_CHECK_PERCPU);
+	if (!desc)
+		return -EINVAL;
+
+	if (WARN(!(desc->istate & IRQS_NMI),
+		 KERN_ERR "prepare_percpu_nmi called for a non-NMI interrupt: irq %u\n",
+		 irq)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = irq_nmi_setup(desc);
+	if (ret) {
+		pr_err("Failed to setup NMI delivery: irq %u\n", irq);
+		goto out;
+	}
+
+out:
+	irq_put_desc_unlock(desc, flags);
+	return ret;
+}
+
+/**
+ *	teardown_percpu_nmi - undoes NMI setup of IRQ line
+ *	@irq: Interrupt line from which CPU local NMI configuration should be
+ *	      removed
+ *
+ *	This call undoes the setup done by prepare_percpu_nmi().
+ *
+ *	IRQ line should not be enabled for the current CPU.
+ *
+ *	As a CPU local operation, this should be called from non-preemptible
+ *	context.
+ */
+void teardown_percpu_nmi(unsigned int irq)
+{
+	unsigned long flags;
+	struct irq_desc *desc;
+
+	WARN_ON(preemptible());
+
+	desc = irq_get_desc_lock(irq, &flags,
+				 IRQ_GET_DESC_CHECK_PERCPU);
+	if (!desc)
+		return;
+
+	if (WARN_ON(!(desc->istate & IRQS_NMI)))
+		goto out;
+
+	irq_nmi_teardown(desc);
+out:
+	irq_put_desc_unlock(desc, flags);
+}
+
 /**
  *	irq_get_irqchip_state - returns the irqchip state of a interrupt.
  *	@irq: Interrupt line that is forwarded to a VM
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 087d18d771b5..65234c89d85b 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -101,6 +101,12 @@ bool kthread_should_stop(void)
 }
 EXPORT_SYMBOL(kthread_should_stop);
 
+bool __kthread_should_park(struct task_struct *k)
+{
+	return test_bit(KTHREAD_SHOULD_PARK, &to_kthread(k)->flags);
+}
+EXPORT_SYMBOL_GPL(__kthread_should_park);
+
 /**
  * kthread_should_park - should this kthread park now?
  *
@@ -114,7 +120,7 @@ EXPORT_SYMBOL(kthread_should_stop);
  */
 bool kthread_should_park(void)
 {
-	return test_bit(KTHREAD_SHOULD_PARK, &to_kthread(current)->flags);
+	return __kthread_should_park(current);
 }
 EXPORT_SYMBOL_GPL(kthread_should_park);
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index d28813306b2c..10277429ed84 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -89,7 +89,8 @@ static bool ksoftirqd_running(unsigned long pending)
 
 	if (pending & SOFTIRQ_NOW_MASK)
 		return false;
-	return tsk && (tsk->state == TASK_RUNNING);
+	return tsk && (tsk->state == TASK_RUNNING) &&
+		!__kthread_should_park(tsk);
 }
 
 /*

