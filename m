Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634F3C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C319227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfLTHkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 02:40:46 -0500
Received: from inva020.nxp.com ([92.121.34.13]:45374 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727190AbfLTHko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:40:44 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CA00B1A02E7;
        Fri, 20 Dec 2019 08:40:41 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 04DC91A0A2B;
        Fri, 20 Dec 2019 08:40:35 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C40AA402D5;
        Fri, 20 Dec 2019 15:40:26 +0800 (SGT)
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, jason@lakedaemon.net,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, fugang.duan@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: [PATCH V3 2/2] drivers/irqchip: add NXP INTMUX interrupt multiplexer support
Date:   Fri, 20 Dec 2019 15:37:11 +0800
Message-Id: <1576827431-31942-3-git-send-email-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576827431-31942-1-git-send-email-qiangqing.zhang@nxp.com>
References: <1576827431-31942-1-git-send-email-qiangqing.zhang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Interrupt Multiplexer (INTMUX) expands the number of peripherals
that can interrupt the core:
* The INTMUX has 8 channels that are assigned to 8 NVIC interrupt slots.
* Each INTMUX channel can receive up to 32 interrupt sources and has 1
  interrupt output.
* The INTMUX routes the interrupt sources to the interrupt outputs.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/irqchip/Kconfig          |   6 +
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-imx-intmux.c | 311 +++++++++++++++++++++++++++++++
 3 files changed, 318 insertions(+)
 create mode 100644 drivers/irqchip/irq-imx-intmux.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index ba152954324b..7e2b1e9d0b45 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -457,6 +457,12 @@ config IMX_IRQSTEER
 	help
 	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
 
+config IMX_INTMUX
+	def_bool y if ARCH_MXC
+	select IRQ_DOMAIN
+	help
+	  Support for the i.MX INTMUX interrupt multiplexer.
+
 config LS1X_IRQ
 	bool "Loongson-1 Interrupt Controller"
 	depends on MACH_LOONGSON32
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e806dda690ea..af976a79d1fb 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
+obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
 obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
 obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
new file mode 100644
index 000000000000..94c67fdd7163
--- /dev/null
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2017 NXP
+
+/*                     INTMUX Block Diagram
+ *
+ *                               ________________
+ * interrupt source #  0  +---->|                |
+ *                        |     |                |
+ * interrupt source #  1  +++-->|                |
+ *            ...         | |   |   channel # 0  |--------->interrupt out # 0
+ *            ...         | |   |                |
+ *            ...         | |   |                |
+ * interrupt source # X-1 +++-->|________________|
+ *                        | | |
+ *                        | | |
+ *                        | | |  ________________
+ *                        +---->|                |
+ *                        | | | |                |
+ *                        | +-->|                |
+ *                        | | | |   channel # 1  |--------->interrupt out # 1
+ *                        | | +>|                |
+ *                        | | | |                |
+ *                        | | | |________________|
+ *                        | | |
+ *                        | | |
+ *                        | | |       ...
+ *                        | | |       ...
+ *                        | | |
+ *                        | | |  ________________
+ *                        +---->|                |
+ *                          | | |                |
+ *                          +-->|                |
+ *                            | |   channel # N  |--------->interrupt out # N
+ *                            +>|                |
+ *                              |                |
+ *                              |________________|
+ *
+ *
+ * N: Interrupt Channel Instance Number (N=7)
+ * X: Interrupt Source Number for each channel (X=32)
+ *
+ * The INTMUX interrupt multiplexer has 8 channels, each channel receives 32
+ * interrupt sources and generates 1 interrupt output.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/spinlock.h>
+
+#define CHANIER(n)	(0x10 + (0x40 * n))
+#define CHANIPR(n)	(0x20 + (0x40 * n))
+
+#define CHAN_MAX_NUM		0x8
+
+struct intmux_irqchip_data {
+	int			chanidx;
+	int			irq;
+	struct irq_domain	*domain;
+};
+
+struct intmux_data {
+	raw_spinlock_t			lock;
+	void __iomem			*regs;
+	struct clk			*ipg_clk;
+	int				channum;
+	struct intmux_irqchip_data	irqchip_data[];
+};
+
+static void imx_intmux_irq_mask(struct irq_data *d)
+{
+	struct intmux_irqchip_data *irqchip_data = d->chip_data;
+	int idx = irqchip_data->chanidx;
+	struct intmux_data *data = container_of(irqchip_data, struct intmux_data,
+						irqchip_data[idx]);
+	unsigned long flags;
+	void __iomem *reg;
+	u32 val;
+
+	raw_spin_lock_irqsave(&data->lock, flags);
+	reg = data->regs + CHANIER(idx);
+	val = readl_relaxed(reg);
+	/* disable the interrupt source of this channel */
+	val &= ~BIT(d->hwirq);
+	writel_relaxed(val, reg);
+	raw_spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static void imx_intmux_irq_unmask(struct irq_data *d)
+{
+	struct intmux_irqchip_data *irqchip_data = d->chip_data;
+	int idx = irqchip_data->chanidx;
+	struct intmux_data *data = container_of(irqchip_data, struct intmux_data,
+						irqchip_data[idx]);
+	unsigned long flags;
+	void __iomem *reg;
+	u32 val;
+
+	raw_spin_lock_irqsave(&data->lock, flags);
+	reg = data->regs + CHANIER(idx);
+	val = readl_relaxed(reg);
+	/* enable the interrupt source of this channel */
+	val |= BIT(d->hwirq);
+	writel_relaxed(val, reg);
+	raw_spin_unlock_irqrestore(&data->lock, flags);
+}
+
+static struct irq_chip imx_intmux_irq_chip = {
+	.name		= "intmux",
+	.irq_mask	= imx_intmux_irq_mask,
+	.irq_unmask	= imx_intmux_irq_unmask,
+};
+
+static int imx_intmux_irq_map(struct irq_domain *h, unsigned int irq,
+			      irq_hw_number_t hwirq)
+{
+	irq_set_status_flags(irq, IRQ_LEVEL);
+	irq_set_chip_data(irq, h->host_data);
+	irq_set_chip_and_handler(irq, &imx_intmux_irq_chip, handle_level_irq);
+
+	return 0;
+}
+
+static int imx_intmux_irq_xlate(struct irq_domain *d, struct device_node *node,
+				const u32 *intspec, unsigned int intsize,
+				unsigned long *out_hwirq, unsigned int *out_type)
+{
+	struct intmux_irqchip_data *irqchip_data = d->host_data;
+	int idx = irqchip_data->chanidx;
+	struct intmux_data *data = container_of(irqchip_data, struct intmux_data,
+						irqchip_data[idx]);
+
+	/* two cells needed in interrupt specifier:
+	 * the 1st cell: hw interrupt number
+	 * the 2nd cell: channel index
+	 */
+	if (WARN_ON(intsize != 2))
+		return -EINVAL;
+
+	if (WARN_ON(intspec[1] >= data->channum))
+		return -EINVAL;
+
+	*out_hwirq = intspec[0];
+	*out_type = IRQ_TYPE_NONE;
+
+	return 0;
+}
+
+static int imx_intmux_irq_select(struct irq_domain *d, struct irq_fwspec *fwspec,
+				 enum irq_domain_bus_token bus_token)
+{
+	struct intmux_irqchip_data *irqchip_data = d->host_data;
+
+	/* Not for us */
+	if (fwspec->fwnode != d->fwnode)
+		return false;
+
+	if (irqchip_data->chanidx == fwspec->param[1])
+		return true;
+	else
+		return false;
+}
+
+static const struct irq_domain_ops imx_intmux_domain_ops = {
+	.map		= imx_intmux_irq_map,
+	.xlate		= imx_intmux_irq_xlate,
+	.select		= imx_intmux_irq_select,
+};
+
+static void imx_intmux_irq_handler(struct irq_desc *desc)
+{
+	struct intmux_irqchip_data *irqchip_data = irq_desc_get_handler_data(desc);
+	int idx = irqchip_data->chanidx;
+	struct intmux_data *data = container_of(irqchip_data, struct intmux_data,
+						irqchip_data[idx]);
+	unsigned long irqstat;
+	int pos, virq;
+
+	chained_irq_enter(irq_desc_get_chip(desc), desc);
+
+	/* read the interrupt source pending status of this channel */
+	irqstat = readl_relaxed(data->regs + CHANIPR(idx));
+
+	for_each_set_bit(pos, &irqstat, 32) {
+		virq = irq_find_mapping(irqchip_data->domain, pos);
+		if (virq)
+			generic_handle_irq(virq);
+	}
+
+	chained_irq_exit(irq_desc_get_chip(desc), desc);
+}
+
+static int imx_intmux_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct intmux_data *data;
+	int channum;
+	int i, ret;
+
+	ret = of_property_read_u32(np, "fsl,intmux_chans", &channum);
+	if (ret) {
+		channum = 1;
+	} else if (channum > CHAN_MAX_NUM) {
+		dev_err(&pdev->dev, "supports up to %d multiplex channels\n",
+			CHAN_MAX_NUM);
+		return -EINVAL;
+	}
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data) +
+			    channum * sizeof(data->irqchip_data[0]), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(data->regs)) {
+		dev_err(&pdev->dev, "failed to initialize reg\n");
+		return PTR_ERR(data->regs);
+	}
+
+	data->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(data->ipg_clk)) {
+		ret = PTR_ERR(data->ipg_clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get ipg clk: %d\n", ret);
+		return ret;
+	}
+
+	data->channum = channum;
+	raw_spin_lock_init(&data->lock);
+
+	ret = clk_prepare_enable(data->ipg_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < channum; i++) {
+		data->irqchip_data[i].chanidx = i;
+
+		data->irqchip_data[i].irq = irq_of_parse_and_map(np, i);
+		if (data->irqchip_data[i].irq <= 0) {
+			ret = -EINVAL;
+			dev_err(&pdev->dev, "failed to get irq\n");
+			goto out;
+		}
+
+		data->irqchip_data[i].domain =
+			irq_domain_add_linear(np, 32, &imx_intmux_domain_ops,
+					      &data->irqchip_data[i]);
+		if (!data->irqchip_data[i].domain) {
+			ret = -ENOMEM;
+			dev_err(&pdev->dev, "failed to create IRQ domain\n");
+			goto out;
+		}
+
+		irq_set_chained_handler_and_data(data->irqchip_data[i].irq,
+						 imx_intmux_irq_handler,
+						 &data->irqchip_data[i]);
+
+		/* disable interrupt sources of this channel firstly */
+		writel_relaxed(0, data->regs + CHANIER(i));
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+out:
+	clk_disable_unprepare(data->ipg_clk);
+	return ret;
+}
+
+static int imx_intmux_remove(struct platform_device *pdev)
+{
+	struct intmux_data *data = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < data->channum; i++) {
+		/* clear interrupt sources pending status of this channel */
+		writel_relaxed(0, data->regs + CHANIPR(i));
+
+		irq_set_chained_handler_and_data(data->irqchip_data[i].irq,
+						 NULL, NULL);
+
+		irq_domain_remove(data->irqchip_data[i].domain);
+	}
+
+	clk_disable_unprepare(data->ipg_clk);
+
+	return 0;
+}
+
+static const struct of_device_id imx_intmux_id[] = {
+	{ .compatible = "fsl,imx-intmux", },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver imx_intmux_driver = {
+	.driver = {
+		.name = "imx-intmux",
+		.of_match_table = imx_intmux_id,
+	},
+	.probe = imx_intmux_probe,
+	.remove = imx_intmux_remove,
+};
+builtin_platform_driver(imx_intmux_driver);
-- 
2.17.1

