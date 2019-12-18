Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F809C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7A724676
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfLRHXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:23:24 -0500
Received: from inva021.nxp.com ([92.121.34.21]:36176 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfLRHXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:23:22 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DB3F7200027;
        Wed, 18 Dec 2019 08:23:20 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7283A20032E;
        Wed, 18 Dec 2019 08:23:13 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6AE1640307;
        Wed, 18 Dec 2019 15:23:04 +0800 (SGT)
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, shengjiu.wang@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, fugang.duan@nxp.com,
        aisheng.dong@nxp.com, Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 2/3] drivers/irqchip: add NXP INTMUX interrupt multiplexer support
Date:   Wed, 18 Dec 2019 15:20:14 +0800
Message-Id: <1576653615-27954-3-git-send-email-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576653615-27954-1-git-send-email-qiangqing.zhang@nxp.com>
References: <1576653615-27954-1-git-send-email-qiangqing.zhang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The intmux module is used to output internal interrupt in subsystem
to system with 32-to-8 configuration. It has several multiplex
channels depends on system.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/irqchip/irq-imx-intmux.c | 220 +++++++++++++++++++++++++++++++
 1 file changed, 220 insertions(+)
 create mode 100644 drivers/irqchip/irq-imx-intmux.c

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
new file mode 100644
index 000000000000..fa24b968f30b
--- /dev/null
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2017 NXP
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/spinlock.h>
+
+#define CHANCSR(n)	(0x0 + 0x40 * n)
+#define CHANVEC(n)	(0x4 + 0x40 * n)
+#define CHANIER(n)	(0x10 + (0x40 * n))
+#define CHANIPR(n)	(0x20 + (0x40 * n))
+
+struct intmux_irqchip_data {
+	int chanidx;
+	int irq;
+	struct irq_domain *domain;
+	unsigned int irqstat;
+};
+
+struct intmux_data {
+	spinlock_t lock;
+	struct platform_device *pdev;
+	void __iomem *regs;
+	struct clk *ipg_clk;
+	int channum;
+	struct intmux_irqchip_data irqchip_data[];
+};
+
+static void imx_intmux_irq_mask(struct irq_data *d)
+{
+	struct intmux_irqchip_data *irqchip_data = d->chip_data;
+	u32 idx = irqchip_data->chanidx;
+	struct intmux_data *intmux_data = container_of(irqchip_data,
+				struct intmux_data, irqchip_data[idx]);
+	void __iomem *reg;
+	u32 val;
+
+	spin_lock(&intmux_data->lock);
+	reg = intmux_data->regs + CHANIER(idx);
+	val = readl_relaxed(reg);
+	/* disable the interrupt source of this channel */
+	val &= ~(1 << d->hwirq);
+	writel_relaxed(val, reg);
+	spin_unlock(&intmux_data->lock);
+}
+
+static void imx_intmux_irq_unmask(struct irq_data *d)
+{
+	struct intmux_irqchip_data *irqchip_data = d->chip_data;
+	u32 idx = irqchip_data->chanidx;
+	struct intmux_data *intmux_data = container_of(irqchip_data,
+				struct intmux_data, irqchip_data[idx]);
+	void __iomem *reg;
+	u32 val;
+
+	spin_lock(&intmux_data->lock);
+	reg = intmux_data->regs + CHANIER(idx);
+	val = readl_relaxed(reg);
+	/* enable the interrupt source of this channel */
+	val |= 1 << d->hwirq;
+	writel_relaxed(val, reg);
+	spin_unlock(&intmux_data->lock);
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
+static const struct irq_domain_ops imx_intmux_domain_ops = {
+	.map		= imx_intmux_irq_map,
+	.xlate		= irq_domain_xlate_onecell,
+};
+
+static void imx_intmux_update_irqstat(struct intmux_irqchip_data *irqchip_data)
+{
+	int i = irqchip_data->chanidx;
+	struct intmux_data *intmux_data = container_of(irqchip_data,
+				struct intmux_data, irqchip_data[i]);
+
+	/* read the interrupt source pending status of this channel */
+	irqchip_data->irqstat = readl_relaxed(intmux_data->regs + CHANIPR(i));
+}
+
+static void imx_intmux_irq_handler(struct irq_desc *desc)
+{
+	struct intmux_irqchip_data *irqchip_data = irq_desc_get_handler_data(desc);
+	int pos, virq;
+
+	chained_irq_enter(irq_desc_get_chip(desc), desc);
+
+	imx_intmux_update_irqstat(irqchip_data);
+
+	for_each_set_bit(pos, (unsigned long *)&irqchip_data->irqstat, 32) {
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
+	struct intmux_data *intmux_data;
+	int channum;
+	int i, ret;
+
+	ret = of_property_read_u32(np, "fsl,intmux_chans", &channum);
+	if (ret)
+		channum = 1;
+
+	intmux_data = devm_kzalloc(&pdev->dev, sizeof(*intmux_data) +
+				   channum * sizeof(intmux_data->irqchip_data[0]),
+				   GFP_KERNEL);
+	if (!intmux_data)
+		return -ENOMEM;
+
+	intmux_data->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(intmux_data->regs)) {
+		dev_err(&pdev->dev, "failed to initialize reg\n");
+		return PTR_ERR(intmux_data->regs);
+	}
+
+	intmux_data->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(intmux_data->ipg_clk)) {
+		ret = PTR_ERR(intmux_data->ipg_clk);
+		dev_err(&pdev->dev, "failed to get ipg clk: %d\n", ret);
+		return ret;
+	}
+
+	intmux_data->channum = channum;
+	intmux_data->pdev = pdev;
+	spin_lock_init(&intmux_data->lock);
+
+	ret = clk_prepare_enable(intmux_data->ipg_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < channum; i++) {
+		intmux_data->irqchip_data[i].chanidx = i;
+		intmux_data->irqchip_data[i].irq = platform_get_irq(pdev, i);
+		if (intmux_data->irqchip_data[i].irq <= 0) {
+			dev_err(&pdev->dev, "failed to get irq\n");
+			return -ENODEV;
+		}
+
+		intmux_data->irqchip_data[i].domain = irq_domain_add_linear(
+						np,
+						32,
+						&imx_intmux_domain_ops,
+						&intmux_data->irqchip_data[i]);
+		if (!intmux_data->irqchip_data[i].domain) {
+			dev_err(&intmux_data->pdev->dev,
+				"failed to create IRQ domain\n");
+			return -ENOMEM;
+		}
+
+		irq_set_chained_handler_and_data(intmux_data->irqchip_data[i].irq,
+						 imx_intmux_irq_handler,
+						 &intmux_data->irqchip_data[i]);
+	}
+
+	platform_set_drvdata(pdev, intmux_data);
+
+	return 0;
+}
+
+static int imx_intmux_remove(struct platform_device *pdev)
+{
+	struct intmux_data *intmux_data = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < intmux_data->channum; i++) {
+		irq_set_chained_handler_and_data(intmux_data->irqchip_data[i].irq,
+						 NULL, NULL);
+
+		irq_domain_remove(intmux_data->irqchip_data[i].domain);
+	}
+
+	platform_set_drvdata(pdev, NULL);
+	clk_disable_unprepare(intmux_data->ipg_clk);
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

