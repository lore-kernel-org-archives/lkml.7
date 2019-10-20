Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12688CA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 10:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC4E2190F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 10:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfJTKO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 06:14:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60170 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfJTKO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 06:14:57 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iM8Eh-0007VG-1v; Sun, 20 Oct 2019 12:14:55 +0200
Date:   Sun, 20 Oct 2019 10:13:56 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for 5.4-rc4
References: <157156643658.8795.8700195163364281095.tglx@nanos.tec.linutronix.de>
Message-ID: <157156643658.8795.10312616020081094685.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

up to:  c9b59181c2b0: Merge tag 'irqchip-fixes-5.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

A small set of irq chip driver fixes and updates:

 - Update the SIFIVE PLIC interrupt driver to use the fasteoi handler to
   address the shortcomings of the existing flow handling which was prone
   to lose interrupts

 - Use the proper limit for GIC interrupt line numbers

 - Add retrigger support for the recently merged Anapurna Labs Fabric
   interrupt controller to make it complete

 - Enable the ATMEL AIC5 interrupt controller driver on the new SAM9X60 SoC

Thanks,

	tglx

------------------>
Marc Zyngier (1):
      irqchip/sifive-plic: Switch to fasteoi flow

Sandeep Sheriker Mallikarjun (1):
      irqchip/atmel-aic5: Add support for sam9x60 irqchip

Talel Shenhar (1):
      irqchip/al-fic: Add support for irq retrigger

Zenghui Yu (1):
      irqchip/gic-v3: Fix GIC_LINE_NR accessor


 .../bindings/interrupt-controller/atmel,aic.txt    |  7 ++++--
 drivers/irqchip/irq-al-fic.c                       | 12 +++++++++
 drivers/irqchip/irq-atmel-aic5.c                   | 10 ++++++++
 drivers/irqchip/irq-gic-v3.c                       |  2 +-
 drivers/irqchip/irq-sifive-plic.c                  | 29 +++++++++++-----------
 5 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
index f4c5d34c4111..7079d44bf3ba 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
@@ -1,8 +1,11 @@
 * Advanced Interrupt Controller (AIC)
 
 Required properties:
-- compatible: Should be "atmel,<chip>-aic"
-  <chip> can be "at91rm9200", "sama5d2", "sama5d3" or "sama5d4"
+- compatible: Should be:
+    - "atmel,<chip>-aic" where  <chip> can be "at91rm9200", "sama5d2",
+      "sama5d3" or "sama5d4"
+    - "microchip,<chip>-aic" where <chip> can be "sam9x60"
+
 - interrupt-controller: Identifies the node as an interrupt controller.
 - #interrupt-cells: The number of cells to define the interrupts. It should be 3.
   The first cell is the IRQ number (aka "Peripheral IDentifier" on datasheet).
diff --git a/drivers/irqchip/irq-al-fic.c b/drivers/irqchip/irq-al-fic.c
index 1a57cee3efab..0b0a73739756 100644
--- a/drivers/irqchip/irq-al-fic.c
+++ b/drivers/irqchip/irq-al-fic.c
@@ -15,6 +15,7 @@
 
 /* FIC Registers */
 #define AL_FIC_CAUSE		0x00
+#define AL_FIC_SET_CAUSE	0x08
 #define AL_FIC_MASK		0x10
 #define AL_FIC_CONTROL		0x28
 
@@ -126,6 +127,16 @@ static void al_fic_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(irqchip, desc);
 }
 
+static int al_fic_irq_retrigger(struct irq_data *data)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
+	struct al_fic *fic = gc->private;
+
+	writel_relaxed(BIT(data->hwirq), fic->base + AL_FIC_SET_CAUSE);
+
+	return 1;
+}
+
 static int al_fic_register(struct device_node *node,
 			   struct al_fic *fic)
 {
@@ -159,6 +170,7 @@ static int al_fic_register(struct device_node *node,
 	gc->chip_types->chip.irq_unmask = irq_gc_mask_clr_bit;
 	gc->chip_types->chip.irq_ack = irq_gc_ack_clr_bit;
 	gc->chip_types->chip.irq_set_type = al_fic_irq_set_type;
+	gc->chip_types->chip.irq_retrigger = al_fic_irq_retrigger;
 	gc->chip_types->chip.flags = IRQCHIP_SKIP_SET_WAKE;
 	gc->private = fic;
 
diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index 6acad2ea0fb3..29333497ba10 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -313,6 +313,7 @@ static void __init sama5d3_aic_irq_fixup(void)
 static const struct of_device_id aic5_irq_fixups[] __initconst = {
 	{ .compatible = "atmel,sama5d3", .data = sama5d3_aic_irq_fixup },
 	{ .compatible = "atmel,sama5d4", .data = sama5d3_aic_irq_fixup },
+	{ .compatible = "microchip,sam9x60", .data = sama5d3_aic_irq_fixup },
 	{ /* sentinel */ },
 };
 
@@ -390,3 +391,12 @@ static int __init sama5d4_aic5_of_init(struct device_node *node,
 	return aic5_of_init(node, parent, NR_SAMA5D4_IRQS);
 }
 IRQCHIP_DECLARE(sama5d4_aic5, "atmel,sama5d4-aic", sama5d4_aic5_of_init);
+
+#define NR_SAM9X60_IRQS		50
+
+static int __init sam9x60_aic5_of_init(struct device_node *node,
+				       struct device_node *parent)
+{
+	return aic5_of_init(node, parent, NR_SAM9X60_IRQS);
+}
+IRQCHIP_DECLARE(sam9x60_aic5, "microchip,sam9x60-aic", sam9x60_aic5_of_init);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 422664ac5f53..1edc99335a94 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -59,7 +59,7 @@ static struct gic_chip_data gic_data __read_mostly;
 static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 
 #define GIC_ID_NR	(1U << GICD_TYPER_ID_BITS(gic_data.rdists.gicd_typer))
-#define GIC_LINE_NR	max(GICD_TYPER_SPIS(gic_data.rdists.gicd_typer), 1020U)
+#define GIC_LINE_NR	min(GICD_TYPER_SPIS(gic_data.rdists.gicd_typer), 1020U)
 #define GIC_ESPI_NR	GICD_TYPER_ESPIS(gic_data.rdists.gicd_typer)
 
 /*
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index c72c036aea76..daefc52b0ec5 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -97,7 +97,7 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
 	}
 }
 
-static void plic_irq_enable(struct irq_data *d)
+static void plic_irq_unmask(struct irq_data *d)
 {
 	unsigned int cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
 					   cpu_online_mask);
@@ -106,7 +106,7 @@ static void plic_irq_enable(struct irq_data *d)
 	plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
 }
 
-static void plic_irq_disable(struct irq_data *d)
+static void plic_irq_mask(struct irq_data *d)
 {
 	plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
 }
@@ -125,10 +125,8 @@ static int plic_set_affinity(struct irq_data *d,
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
 
-	if (!irqd_irq_disabled(d)) {
-		plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
-		plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
-	}
+	plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
+	plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
@@ -136,14 +134,18 @@ static int plic_set_affinity(struct irq_data *d,
 }
 #endif
 
+static void plic_irq_eoi(struct irq_data *d)
+{
+	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+
+	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+}
+
 static struct irq_chip plic_chip = {
 	.name		= "SiFive PLIC",
-	/*
-	 * There is no need to mask/unmask PLIC interrupts.  They are "masked"
-	 * by reading claim and "unmasked" when writing it back.
-	 */
-	.irq_enable	= plic_irq_enable,
-	.irq_disable	= plic_irq_disable,
+	.irq_mask	= plic_irq_mask,
+	.irq_unmask	= plic_irq_unmask,
+	.irq_eoi	= plic_irq_eoi,
 #ifdef CONFIG_SMP
 	.irq_set_affinity = plic_set_affinity,
 #endif
@@ -152,7 +154,7 @@ static struct irq_chip plic_chip = {
 static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hwirq)
 {
-	irq_set_chip_and_handler(irq, &plic_chip, handle_simple_irq);
+	irq_set_chip_and_handler(irq, &plic_chip, handle_fasteoi_irq);
 	irq_set_chip_data(irq, NULL);
 	irq_set_noprobe(irq);
 	return 0;
@@ -188,7 +190,6 @@ static void plic_handle_irq(struct pt_regs *regs)
 					hwirq);
 		else
 			generic_handle_irq(irq);
-		writel(hwirq, claim);
 	}
 	csr_set(sie, SIE_SEIE);
 }


