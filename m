Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F3DC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2979922B48
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgABT2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 14:28:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728278AbgABT2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 14:28:17 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 002JGutX013350;
        Thu, 2 Jan 2020 14:28:00 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2x88jk7wr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jan 2020 14:28:00 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 002JQeu8025009;
        Thu, 2 Jan 2020 19:28:00 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04wdc.us.ibm.com with ESMTP id 2x5xp6txgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jan 2020 19:28:00 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 002JRxwh60096868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Jan 2020 19:27:59 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8DAFBE04F;
        Thu,  2 Jan 2020 19:27:58 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5614BBE053;
        Thu,  2 Jan 2020 19:27:58 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.103.158])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  2 Jan 2020 19:27:58 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, jason@lakedaemon.net, maz@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de, joel@jms.id.au,
        andrew@aj.id.au, eajames@linux.ibm.com
Subject: [PATCH v4 02/12] irqchip: Add Aspeed SCU interrupt controller
Date:   Thu,  2 Jan 2020 13:27:46 -0600
Message-Id: <1577993276-2184-3-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1577993276-2184-1-git-send-email-eajames@linux.ibm.com>
References: <1577993276-2184-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-02_06:2020-01-02,2020-01-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001020156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Aspeed SOCs provide some interrupts through the System Control
Unit registers. Add an interrupt controller that provides these
interrupts to the system.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 MAINTAINERS                         |   1 +
 drivers/irqchip/Makefile            |   2 +-
 drivers/irqchip/irq-aspeed-scu-ic.c | 239 ++++++++++++++++++++++++++++
 3 files changed, 241 insertions(+), 1 deletion(-)
 create mode 100644 drivers/irqchip/irq-aspeed-scu-ic.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e54a602857e7..5b1048799508 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2698,6 +2698,7 @@ M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
+F:	drivers/irqchip/irq-aspeed-scu-ic.c
 F:	include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
 
 ASPEED VIDEO ENGINE DRIVER
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e806dda690ea..6c9262c673bf 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -87,7 +87,7 @@ obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
 obj-$(CONFIG_LS_EXTIRQ)			+= irq-ls-extirq.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
-obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
+obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-aspeed-scu-ic.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
 obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
new file mode 100644
index 000000000000..c90a3346b985
--- /dev/null
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Aspeed AST24XX, AST25XX, and AST26XX SCU Interrupt Controller
+ * Copyright 2019 IBM Corporation
+ *
+ * Eddie James <eajames@linux.ibm.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_irq.h>
+#include <linux/regmap.h>
+
+#define ASPEED_SCU_IC_REG		0x018
+#define ASPEED_SCU_IC_SHIFT		0
+#define ASPEED_SCU_IC_ENABLE		GENMASK(6, ASPEED_SCU_IC_SHIFT)
+#define ASPEED_SCU_IC_NUM_IRQS		7
+#define ASPEED_SCU_IC_STATUS_SHIFT	16
+
+#define ASPEED_AST2600_SCU_IC0_REG	0x560
+#define ASPEED_AST2600_SCU_IC0_SHIFT	0
+#define ASPEED_AST2600_SCU_IC0_ENABLE	\
+	GENMASK(5, ASPEED_AST2600_SCU_IC0_SHIFT)
+#define ASPEED_AST2600_SCU_IC0_NUM_IRQS	6
+
+#define ASPEED_AST2600_SCU_IC1_REG	0x570
+#define ASPEED_AST2600_SCU_IC1_SHIFT	4
+#define ASPEED_AST2600_SCU_IC1_ENABLE	\
+	GENMASK(5, ASPEED_AST2600_SCU_IC1_SHIFT)
+#define ASPEED_AST2600_SCU_IC1_NUM_IRQS	2
+
+struct aspeed_scu_ic {
+	unsigned long irq_enable;
+	unsigned long irq_shift;
+	unsigned int num_irqs;
+	unsigned int reg;
+	struct regmap *scu;
+	struct irq_domain *irq_domain;
+};
+
+static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
+{
+	unsigned int irq;
+	unsigned int sts;
+	unsigned long bit;
+	unsigned long enabled;
+	unsigned long max;
+	unsigned long status;
+	struct aspeed_scu_ic *scu_ic = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned int mask = scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT;
+
+	chained_irq_enter(chip, desc);
+
+	/*
+	 * The SCU IC has just one register to control its operation and read
+	 * status. The interrupt enable bits occupy the lower 16 bits of the
+	 * register, while the interrupt status bits occupy the upper 16 bits.
+	 * The status bit for a given interrupt is always 16 bits shifted from
+	 * the enable bit for the same interrupt.
+	 * Therefore, perform the IRQ operations in the enable bit space by
+	 * shifting the status down to get the mapping and then back up to
+	 * clear the bit.
+	 */
+	regmap_read(scu_ic->scu, scu_ic->reg, &sts);
+	enabled = sts & scu_ic->irq_enable;
+	status = (sts >> ASPEED_SCU_IC_STATUS_SHIFT) & enabled;
+
+	bit = scu_ic->irq_shift;
+	max = scu_ic->num_irqs + bit;
+
+	for_each_set_bit_from(bit, &status, max) {
+		irq = irq_find_mapping(scu_ic->irq_domain,
+				       bit - scu_ic->irq_shift);
+		generic_handle_irq(irq);
+
+		regmap_update_bits(scu_ic->scu, scu_ic->reg, mask,
+				   BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void aspeed_scu_ic_irq_mask(struct irq_data *data)
+{
+	struct aspeed_scu_ic *scu_ic = irq_data_get_irq_chip_data(data);
+	unsigned int mask = BIT(data->hwirq + scu_ic->irq_shift) |
+		(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
+
+	/*
+	 * Status bits are cleared by writing 1. In order to prevent the mask
+	 * operation from clearing the status bits, they should be under the
+	 * mask and written with 0.
+	 */
+	regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, 0);
+}
+
+static void aspeed_scu_ic_irq_unmask(struct irq_data *data)
+{
+	struct aspeed_scu_ic *scu_ic = irq_data_get_irq_chip_data(data);
+	unsigned int bit = BIT(data->hwirq + scu_ic->irq_shift);
+	unsigned int mask = bit |
+		(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
+
+	/*
+	 * Status bits are cleared by writing 1. In order to prevent the unmask
+	 * operation from clearing the status bits, they should be under the
+	 * mask and written with 0.
+	 */
+	regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, bit);
+}
+
+static int aspeed_scu_ic_irq_set_affinity(struct irq_data *data,
+					  const struct cpumask *dest,
+					  bool force)
+{
+	return -EINVAL;
+}
+
+static struct irq_chip aspeed_scu_ic_chip = {
+	.name			= "aspeed-scu-ic",
+	.irq_mask		= aspeed_scu_ic_irq_mask,
+	.irq_unmask		= aspeed_scu_ic_irq_unmask,
+	.irq_set_affinity	= aspeed_scu_ic_irq_set_affinity,
+};
+
+static int aspeed_scu_ic_map(struct irq_domain *domain, unsigned int irq,
+			     irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &aspeed_scu_ic_chip, handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops aspeed_scu_ic_domain_ops = {
+	.map = aspeed_scu_ic_map,
+};
+
+static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
+					struct device_node *node)
+{
+	int irq;
+	int rc = 0;
+
+	if (!node->parent) {
+		rc = -ENODEV;
+		goto err;
+	}
+
+	scu_ic->scu = syscon_node_to_regmap(node->parent);
+	if (IS_ERR(scu_ic->scu)) {
+		rc = PTR_ERR(scu_ic->scu);
+		goto err;
+	}
+
+	irq = irq_of_parse_and_map(node, 0);
+	if (irq < 0) {
+		rc = irq;
+		goto err;
+	}
+
+	scu_ic->irq_domain = irq_domain_add_linear(node, scu_ic->num_irqs,
+						   &aspeed_scu_ic_domain_ops,
+						   scu_ic);
+	if (!scu_ic->irq_domain) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	irq_set_chained_handler_and_data(irq, aspeed_scu_ic_irq_handler,
+					 scu_ic);
+
+	return 0;
+
+err:
+	kfree(scu_ic);
+
+	return rc;
+}
+
+static int __init aspeed_scu_ic_of_init(struct device_node *node,
+					struct device_node *parent)
+{
+	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
+
+	if (!scu_ic)
+		return -ENOMEM;
+
+	scu_ic->irq_enable = ASPEED_SCU_IC_ENABLE;
+	scu_ic->irq_shift = ASPEED_SCU_IC_SHIFT;
+	scu_ic->num_irqs = ASPEED_SCU_IC_NUM_IRQS;
+	scu_ic->reg = ASPEED_SCU_IC_REG;
+
+	return aspeed_scu_ic_of_init_common(scu_ic, node);
+}
+
+static int __init aspeed_ast2600_scu_ic0_of_init(struct device_node *node,
+						 struct device_node *parent)
+{
+	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
+
+	if (!scu_ic)
+		return -ENOMEM;
+
+	scu_ic->irq_enable = ASPEED_AST2600_SCU_IC0_ENABLE;
+	scu_ic->irq_shift = ASPEED_AST2600_SCU_IC0_SHIFT;
+	scu_ic->num_irqs = ASPEED_AST2600_SCU_IC0_NUM_IRQS;
+	scu_ic->reg = ASPEED_AST2600_SCU_IC0_REG;
+
+	return aspeed_scu_ic_of_init_common(scu_ic, node);
+}
+
+static int __init aspeed_ast2600_scu_ic1_of_init(struct device_node *node,
+						 struct device_node *parent)
+{
+	struct aspeed_scu_ic *scu_ic = kzalloc(sizeof(*scu_ic), GFP_KERNEL);
+
+	if (!scu_ic)
+		return -ENOMEM;
+
+	scu_ic->irq_enable = ASPEED_AST2600_SCU_IC1_ENABLE;
+	scu_ic->irq_shift = ASPEED_AST2600_SCU_IC1_SHIFT;
+	scu_ic->num_irqs = ASPEED_AST2600_SCU_IC1_NUM_IRQS;
+	scu_ic->reg = ASPEED_AST2600_SCU_IC1_REG;
+
+	return aspeed_scu_ic_of_init_common(scu_ic, node);
+}
+
+IRQCHIP_DECLARE(ast2400_scu_ic, "aspeed,ast2400-scu-ic", aspeed_scu_ic_of_init);
+IRQCHIP_DECLARE(ast2500_scu_ic, "aspeed,ast2500-scu-ic", aspeed_scu_ic_of_init);
+IRQCHIP_DECLARE(ast2600_scu_ic0, "aspeed,ast2600-scu-ic0",
+		aspeed_ast2600_scu_ic0_of_init);
+IRQCHIP_DECLARE(ast2600_scu_ic1, "aspeed,ast2600-scu-ic1",
+		aspeed_ast2600_scu_ic1_of_init);
-- 
2.24.0

