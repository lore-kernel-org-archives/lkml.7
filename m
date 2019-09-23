Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C16C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC9620867
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439414AbfIWKPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:15:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57827 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439389AbfIWKPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:15:38 -0400
Received: from [5.158.153.52] (helo=kurt.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <kurt@linutronix.de>)
        id 1iCLNS-0001oR-LH; Mon, 23 Sep 2019 12:15:30 +0200
From:   Kurt Kanzenbach <kurt@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        devicetree@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH v6 1/2] irqchip: Add support for Layerscape external interrupt lines
Date:   Mon, 23 Sep 2019 12:15:12 +0200
Message-Id: <20190923101513.32719-2-kurt@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923101513.32719-1-kurt@linutronix.de>
References: <20190923101513.32719-1-kurt@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

The LS1021A allows inverting the polarity of six interrupt lines
IRQ[0:5] via the scfg_intpcr register, effectively allowing
IRQ_TYPE_LEVEL_LOW and IRQ_TYPE_EDGE_FALLING for those. We just need to
check the type, set the relevant bit in INTPCR accordingly, and fixup
the type argument before calling the GIC's irq_set_type.

In fact, the power-on-reset value of the INTPCR register on the LS1021A
is so that all six lines have their polarity inverted. Hence any
hardware connected to those lines is unusable without this: If the line
is indeed active low, the generic GIC code will reject an irq spec with
IRQ_TYPE_LEVEL_LOW, while if the line is active high, we must obviously
disable the polarity inversion (writing 0 to the relevant bit) before
unmasking the interrupt.

Some other Layerscape SOCs (LS1043A, LS1046A, LS2088A) reportedly have a
similar feature, just with a different number of external interrupt lines
(and a different POR value for the INTPCR register). This driver should be
prepared for supporting those by properly filling out the device tree
node, but I don't have the full reference manual, nor the hardware to be
able to test it. I do know, from a tiny clipout from one of the other
reference manuals I was shown, that 1U<<n is the right formula to
use for setting/clearing the bit corresponding to the external IRQn, but
I don't know which interrupts on the GIC those lines represent.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---

Changes since v5:

 - Adjust order of local variables
 - Cleanup of irq headers
 - Use irq_chip_set_type_parent()
 - Compile with ARCH_LAYERSCAPE
 - Removed last paragraph of changelog, as ARCH_LAYERSCAPE should be used
 - Also mention the LS2088A SoC in changelog

drivers/irqchip/Makefile        |   1 +
 drivers/irqchip/irq-ls-extirq.c | 174 ++++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+)
 create mode 100644 drivers/irqchip/irq-ls-extirq.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 8d0fcec6ab23..ce6db511124a 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_MVEBU_ODMI)		+= irq-mvebu-odmi.o
 obj-$(CONFIG_MVEBU_PIC)			+= irq-mvebu-pic.o
 obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
+obj-$(CONFIG_ARCH_LAYERSCAPE)		+= irq-ls-extirq.o
 obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
new file mode 100644
index 000000000000..c1d1bfee585c
--- /dev/null
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "irq-ls-extirq: " fmt
+
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#define MAXIRQ 12
+
+struct extirq_chip_data {
+	struct regmap *syscon;
+	u32           intpcr;
+	bool          bit_reverse;
+	u32           nirq;
+	u32           parent_irq[MAXIRQ];
+};
+
+static int
+ls_extirq_set_type(struct irq_data *data, unsigned int type)
+{
+	struct extirq_chip_data *chip_data = data->chip_data;
+	irq_hw_number_t hwirq = data->hwirq;
+	u32 value, mask;
+
+	if (chip_data->bit_reverse)
+		mask = 1U << (31 - hwirq);
+	else
+		mask = 1U << hwirq;
+
+	switch (type) {
+	case IRQ_TYPE_LEVEL_LOW:
+		type = IRQ_TYPE_LEVEL_HIGH;
+		value = mask;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		type = IRQ_TYPE_EDGE_RISING;
+		value = mask;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+	case IRQ_TYPE_EDGE_RISING:
+		value = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(chip_data->syscon, chip_data->intpcr, mask, value);
+
+	return irq_chip_set_type_parent(data, type);
+}
+
+static struct irq_chip extirq_chip = {
+	.name			= "extirq",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_type		= ls_extirq_set_type,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.flags                  = IRQCHIP_SET_TYPE_MASKED,
+};
+
+static int
+ls_extirq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
+			   unsigned long *hwirq, unsigned int *type)
+{
+	if (!is_of_node(fwspec->fwnode))
+		return -EINVAL;
+
+	if (fwspec->param_count != 2)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0];
+	*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+	return 0;
+}
+
+static int
+ls_extirq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+		       unsigned int nr_irqs, void *arg)
+{
+	irq_hw_number_t hwirq;
+	struct irq_fwspec *fwspec = arg;
+	struct irq_fwspec gic_fwspec;
+	struct extirq_chip_data *chip_data = domain->host_data;
+
+	if (fwspec->param_count != 2)
+		return -EINVAL;
+
+	hwirq = fwspec->param[0];
+	if (hwirq >= chip_data->nirq)
+		return -EINVAL;
+
+	irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &extirq_chip,
+				      chip_data);
+
+	gic_fwspec.fwnode = domain->parent->fwnode;
+	gic_fwspec.param_count = 3;
+	gic_fwspec.param[0] = GIC_SPI;
+	gic_fwspec.param[1] = chip_data->parent_irq[hwirq];
+	gic_fwspec.param[2] = fwspec->param[1];
+
+	return irq_domain_alloc_irqs_parent(domain, virq, 1, &gic_fwspec);
+}
+
+static const struct irq_domain_ops extirq_domain_ops = {
+	.translate	= ls_extirq_domain_translate,
+	.alloc		= ls_extirq_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
+static int __init
+ls_extirq_of_init(struct device_node *node, struct device_node *parent)
+{
+
+	struct irq_domain *domain, *domain_parent;
+	struct extirq_chip_data *chip;
+	const __be32 *intpcr;
+	int ret;
+
+	domain_parent = irq_find_host(parent);
+	if (!domain_parent) {
+		pr_err("interrupt-parent not found\n");
+		return -EINVAL;
+	}
+
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->syscon = syscon_node_to_regmap(node->parent);
+	if (IS_ERR(chip->syscon)) {
+		ret = PTR_ERR(chip->syscon);
+		pr_err("Failed to lookup parent regmap\n");
+		goto err;
+	}
+	intpcr = of_get_address(node, 0, NULL, NULL);
+	if (!intpcr) {
+		ret = -ENOENT;
+		pr_err("Missing INTPCR offset value\n");
+		goto err;
+	}
+	chip->intpcr = __be32_to_cpu(*intpcr);
+
+	ret = of_property_read_variable_u32_array(node, "fsl,extirq-map",
+						  chip->parent_irq,
+						  1, ARRAY_SIZE(chip->parent_irq));
+	if (ret < 0)
+		goto err;
+	chip->nirq = ret;
+	chip->bit_reverse = of_property_read_bool(node, "fsl,bit-reverse");
+
+	domain = irq_domain_add_hierarchy(domain_parent, 0, chip->nirq, node,
+					  &extirq_domain_ops, chip);
+	if (!domain) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	return 0;
+
+err:
+	kfree(chip);
+	return ret;
+}
+
+IRQCHIP_DECLARE(ls1021a_extirq, "fsl,ls1021a-extirq", ls_extirq_of_init);
-- 
2.20.1

