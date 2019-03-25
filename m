Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6A8C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D167120879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 04:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfCYEPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 00:15:38 -0400
Received: from mx.socionext.com ([202.248.49.38]:53579 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfCYEPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 00:15:38 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 25 Mar 2019 13:15:36 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 70CD0180085;
        Mon, 25 Mar 2019 13:15:36 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 25 Mar 2019 13:15:36 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 2BBAC1A15B7;
        Mon, 25 Mar 2019 13:15:36 +0900 (JST)
Received: from M20VSDK.e01.socionext.com (unknown [10.213.118.34])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 0A64A120487;
        Mon, 25 Mar 2019 13:15:36 +0900 (JST)
From:   Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        orito.takao@socionext.com, sugaya.taichi@socionext.com,
        kanematsu.shinji@socionext.com, jaswinder.singh@linaro.org,
        masami.hiramatsu@linaro.org, linux-kernel@vger.kernel.org,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
Subject: [PATCH 2/2] dmaengine: milbeaut: Add Milbeaut AXI DMA controller
Date:   Mon, 25 Mar 2019 13:15:14 +0900
Message-Id: <1553487314-9185-3-git-send-email-kasai.kazuhiro@socionext.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1553487314-9185-1-git-send-email-kasai.kazuhiro@socionext.com>
References: <1553487314-9185-1-git-send-email-kasai.kazuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Milbeaut AXI DMA controller. This DMA controller has
only capable of memory to memory transfer.

Signed-off-by: Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
---
 drivers/dma/Kconfig          |   8 +
 drivers/dma/Makefile         |   1 +
 drivers/dma/xdmac-milbeaut.c | 353 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 362 insertions(+)
 create mode 100644 drivers/dma/xdmac-milbeaut.c

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 0b1dfb5..733fe5f 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -612,6 +612,14 @@ config UNIPHIER_MDMAC
 	  UniPhier platform.  This DMA controller is used as the external
 	  DMA engine of the SD/eMMC controllers of the LD4, Pro4, sLD8 SoCs.
 
+config XDMAC_MILBEAUT
+       tristate "Milbeaut AXI DMA support"
+       depends on ARCH_MILBEAUT || COMPILE_TEST
+       select DMA_ENGINE
+       help
+         Support for Milbeaut AXI DMA controller driver. The DMA controller
+         has only memory to memory capability.
+
 config XGENE_DMA
 	tristate "APM X-Gene DMA support"
 	depends on ARCH_XGENE || COMPILE_TEST
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 6126e1c..4aab810 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_TEGRA20_APB_DMA) += tegra20-apb-dma.o
 obj-$(CONFIG_TEGRA210_ADMA) += tegra210-adma.o
 obj-$(CONFIG_TIMB_DMA) += timb_dma.o
 obj-$(CONFIG_UNIPHIER_MDMAC) += uniphier-mdmac.o
+obj-$(CONFIG_XDMAC_MILBEAUT) += xdmac-milbeaut.o
 obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
 obj-$(CONFIG_ZX_DMA) += zx_dma.o
 obj-$(CONFIG_ST_FDMA) += st_fdma.o
diff --git a/drivers/dma/xdmac-milbeaut.c b/drivers/dma/xdmac-milbeaut.c
new file mode 100644
index 0000000..7035c61
--- /dev/null
+++ b/drivers/dma/xdmac-milbeaut.c
@@ -0,0 +1,353 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Socionext Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_dma.h>
+#include <linux/platform_device.h>
+
+#include "dmaengine.h"
+
+/* global register */
+#define M10V_XDACS 0x00
+
+/* channel local register */
+#define M10V_XDTBC 0x10
+#define M10V_XDSSA 0x14
+#define M10V_XDDSA 0x18
+#define M10V_XDSAC 0x1C
+#define M10V_XDDAC 0x20
+#define M10V_XDDCC 0x24
+#define M10V_XDDES 0x28
+#define M10V_XDDPC 0x2C
+#define M10V_XDDSD 0x30
+
+#define M10V_XDACS_XE BIT(28)
+
+#define M10V_XDSAC_SBS	GENMASK(17, 16)
+#define M10V_XDSAC_SBL	GENMASK(11, 8)
+
+#define M10V_XDDAC_DBS	GENMASK(17, 16)
+#define M10V_XDDAC_DBL	GENMASK(11, 8)
+
+#define M10V_XDDES_CE	BIT(28)
+#define M10V_XDDES_SE	BIT(24)
+#define M10V_XDDES_SA	BIT(15)
+#define M10V_XDDES_TF	GENMASK(23, 20)
+#define M10V_XDDES_EI	BIT(1)
+#define M10V_XDDES_TI	BIT(0)
+
+#define M10V_XDDSD_IS_MASK	GENMASK(3, 0)
+#define M10V_XDDSD_IS_NORMAL	0x8
+
+#define M10V_XDMAC_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_8_BYTES))
+
+#define M10V_XDMAC_CHAN_BASE(base, i)	((base) + (i) * 0x30)
+
+#define to_m10v_dma_chan(c)	container_of((c), struct m10v_dma_chan, chan)
+
+struct m10v_dma_desc {
+	struct dma_async_tx_descriptor txd;
+	size_t len;
+	dma_addr_t src;
+	dma_addr_t dst;
+};
+
+struct m10v_dma_chan {
+	struct dma_chan chan;
+	struct m10v_dma_device *mdmac;
+	void __iomem *regs;
+	int irq;
+	struct m10v_dma_desc mdesc;
+	spinlock_t lock;
+};
+
+struct m10v_dma_device {
+	struct dma_device dmac;
+	void __iomem *regs;
+	unsigned int channels;
+	struct m10v_dma_chan mchan[0];
+};
+
+static void m10v_xdmac_enable_dma(struct m10v_dma_device *mdmac)
+{
+	unsigned int val;
+
+	val = readl(mdmac->regs + M10V_XDACS);
+	val &= ~M10V_XDACS_XE;
+	val |= FIELD_PREP(M10V_XDACS_XE, 1);
+	writel(val, mdmac->regs + M10V_XDACS);
+}
+
+static void m10v_xdmac_disable_dma(struct m10v_dma_device *mdmac)
+{
+	unsigned int val;
+
+	val = readl(mdmac->regs + M10V_XDACS);
+	val &= ~M10V_XDACS_XE;
+	val |= FIELD_PREP(M10V_XDACS_XE, 0);
+	writel(val, mdmac->regs + M10V_XDACS);
+}
+
+static void m10v_xdmac_config_chan(struct m10v_dma_chan *mchan)
+{
+	u32 val;
+
+	val = mchan->mdesc.len - 1;
+	writel(val, mchan->regs + M10V_XDTBC);
+
+	val = mchan->mdesc.src;
+	writel(val, mchan->regs + M10V_XDSSA);
+
+	val = mchan->mdesc.dst;
+	writel(val, mchan->regs + M10V_XDDSA);
+
+	val = readl(mchan->regs + M10V_XDSAC);
+	val &= ~(M10V_XDSAC_SBS | M10V_XDSAC_SBL);
+	val |= FIELD_PREP(M10V_XDSAC_SBS, 0x3) |
+	       FIELD_PREP(M10V_XDSAC_SBL, 0xf);
+	writel(val, mchan->regs + M10V_XDSAC);
+
+	val = readl(mchan->regs + M10V_XDDAC);
+	val &= ~(M10V_XDDAC_DBS | M10V_XDDAC_DBL);
+	val |= FIELD_PREP(M10V_XDDAC_DBS, 0x3) |
+	       FIELD_PREP(M10V_XDDAC_DBL, 0xf);
+	writel(val, mchan->regs + M10V_XDDAC);
+}
+
+static void m10v_xdmac_enable_chan(struct m10v_dma_chan *mchan)
+{
+	u32 val;
+
+	val = readl(mchan->regs + M10V_XDDES);
+	val &= ~(M10V_XDDES_CE |
+	         M10V_XDDES_SE |
+	         M10V_XDDES_TF |
+	         M10V_XDDES_EI |
+	         M10V_XDDES_TI);
+	val |= FIELD_PREP(M10V_XDDES_CE, 1) |
+	       FIELD_PREP(M10V_XDDES_SE, 1) |
+	       FIELD_PREP(M10V_XDDES_TF, 1) |
+	       FIELD_PREP(M10V_XDDES_EI, 1) |
+	       FIELD_PREP(M10V_XDDES_TI, 1);
+	writel(val, mchan->regs + M10V_XDDES);
+}
+
+static void m10v_xdmac_disable_chan(struct m10v_dma_chan *mchan)
+{
+	u32 val;
+
+	val = readl(mchan->regs + M10V_XDDES);
+	val &= ~M10V_XDDES_CE;
+	val |= FIELD_PREP(M10V_XDDES_CE, 0);
+	writel(val, mchan->regs + M10V_XDDES);
+}
+
+static irqreturn_t m10v_xdmac_irq(int irq, void *data)
+{
+	struct m10v_dma_chan *mchan = data;
+	unsigned long flags;
+	u32 val;
+
+	val = readl(mchan->regs + M10V_XDDSD);
+	val = FIELD_GET(M10V_XDDSD_IS_MASK, val);
+
+	if (val != M10V_XDDSD_IS_NORMAL)
+		dev_err(mchan->chan.device->dev, "XDMAC error with status: %x", val);
+
+	val = FIELD_PREP(M10V_XDDSD_IS_MASK, 0x0);
+	writel(val, mchan->regs + M10V_XDDSD);
+
+	spin_lock_irqsave(&mchan->lock, flags);
+	dma_cookie_complete(&mchan->mdesc.txd);
+	spin_unlock_irqrestore(&mchan->lock, flags);
+
+	if (mchan->mdesc.txd.flags & DMA_PREP_INTERRUPT)
+		dmaengine_desc_get_callback_invoke(&mchan->mdesc.txd, NULL);
+
+	return IRQ_HANDLED;
+}
+
+static void m10v_xdmac_issue_pending(struct dma_chan *chan)
+{
+	struct m10v_dma_chan *mchan = to_m10v_dma_chan(chan);
+
+	m10v_xdmac_config_chan(mchan);
+
+	m10v_xdmac_enable_chan(mchan);
+}
+
+static dma_cookie_t m10v_xdmac_tx_submit(struct dma_async_tx_descriptor *txd)
+{
+	struct m10v_dma_chan *mchan = to_m10v_dma_chan(txd->chan);
+	dma_cookie_t cookie;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mchan->lock, flags);
+	cookie = dma_cookie_assign(txd);
+	spin_unlock_irqrestore(&mchan->lock, flags);
+
+	return cookie;
+}
+
+static struct dma_async_tx_descriptor *
+m10v_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
+			   dma_addr_t src, size_t len, unsigned long flags)
+{
+	struct m10v_dma_chan *mchan = to_m10v_dma_chan(chan);
+
+	dma_async_tx_descriptor_init(&mchan->mdesc.txd, chan);
+	mchan->mdesc.txd.tx_submit = m10v_xdmac_tx_submit;
+	mchan->mdesc.txd.callback = NULL;
+	mchan->mdesc.txd.flags = flags;
+	mchan->mdesc.txd.cookie = -EBUSY;
+
+	mchan->mdesc.len = len;
+	mchan->mdesc.src = src;
+	mchan->mdesc.dst = dst;
+
+	return &mchan->mdesc.txd;
+}
+
+static int m10v_xdmac_device_terminate_all(struct dma_chan *chan)
+{
+	struct m10v_dma_chan *mchan = to_m10v_dma_chan(chan);
+
+	m10v_xdmac_disable_chan(mchan);
+
+	return 0;
+}
+
+static int m10v_xdmac_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct m10v_dma_chan *mchan = to_m10v_dma_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mchan->lock, flags);
+	dma_cookie_init(chan);
+	spin_unlock_irqrestore(&mchan->lock, flags);
+
+	return 1;
+}
+
+static int m10v_xdmac_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct m10v_dma_chan *mchan;
+	struct m10v_dma_device *mdmac;
+	struct resource *res;
+	unsigned int channels;
+	int ret, i;
+
+	ret = device_property_read_u32(&pdev->dev, "dma-channels", &channels);
+	if (ret) {
+		dev_err(&pdev->dev, "get dma-channels failed\n");
+		return ret;
+	}
+
+	mdmac = devm_kzalloc(&pdev->dev,
+			     struct_size(mdmac, mchan, channels),
+			     GFP_KERNEL);
+	if (!mdmac)
+		return -ENOMEM;
+
+	mdmac->channels = channels;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mdmac->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mdmac->regs))
+		return PTR_ERR(mdmac->regs);
+
+	INIT_LIST_HEAD(&mdmac->dmac.channels);
+	for (i = 0; i < mdmac->channels; i++) {
+		mchan = &mdmac->mchan[i];
+		mchan->irq = platform_get_irq(pdev, i);
+		ret = devm_request_irq(&pdev->dev, mchan->irq, m10v_xdmac_irq,
+				       IRQF_SHARED, dev_name(&pdev->dev), mchan);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request IRQ\n");
+			return ret;
+		}
+		mchan->mdmac = mdmac;
+		mchan->chan.device = &mdmac->dmac;
+		list_add_tail(&mchan->chan.device_node,
+				&mdmac->dmac.channels);
+
+		mchan->regs = M10V_XDMAC_CHAN_BASE(mdmac->regs, i);
+		spin_lock_init(&mchan->lock);
+	}
+
+	dma_cap_set(DMA_MEMCPY, mdmac->dmac.cap_mask);
+
+	mdmac->dmac.device_alloc_chan_resources = m10v_xdmac_alloc_chan_resources;
+	mdmac->dmac.device_prep_dma_memcpy = m10v_xdmac_prep_dma_memcpy;
+	mdmac->dmac.device_issue_pending = m10v_xdmac_issue_pending;
+	mdmac->dmac.device_tx_status = dma_cookie_status;
+	mdmac->dmac.device_terminate_all = m10v_xdmac_device_terminate_all;
+	mdmac->dmac.src_addr_widths = M10V_XDMAC_BUSWIDTHS;
+	mdmac->dmac.dst_addr_widths = M10V_XDMAC_BUSWIDTHS;
+	mdmac->dmac.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+	mdmac->dmac.dev = &pdev->dev;
+
+	platform_set_drvdata(pdev, mdmac);
+
+	m10v_xdmac_enable_dma(mdmac);
+
+	ret = dmaenginem_async_device_register(&mdmac->dmac);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register dmaengine device\n");
+		return ret;
+	}
+
+	ret = of_dma_controller_register(np, of_dma_simple_xlate, mdmac);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register OF DMA controller\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int m10v_xdmac_remove(struct platform_device *pdev)
+{
+	struct m10v_dma_chan *mchan;
+	struct m10v_dma_device *mdmac = platform_get_drvdata(pdev);
+	int i;
+
+	m10v_xdmac_disable_dma(mdmac);
+
+	for (i = 0; i < mdmac->channels; i++) {
+		mchan = &mdmac->mchan[i];
+		devm_free_irq(&pdev->dev, mchan->irq, mchan);
+	}
+
+	of_dma_controller_free(pdev->dev.of_node);
+
+	return 0;
+}
+
+static const struct of_device_id m10v_xdmac_dt_ids[] = {
+	{.compatible = "socionext,milbeaut-m10v-xdmac",},
+	{},
+};
+MODULE_DEVICE_TABLE(of, m10v_xdmac_dt_ids);
+
+static struct platform_driver m10v_xdmac_driver = {
+	.driver = {
+		.name = "m10v-xdmac",
+		.of_match_table = of_match_ptr(m10v_xdmac_dt_ids),
+	},
+	.probe = m10v_xdmac_probe,
+	.remove = m10v_xdmac_remove,
+};
+module_platform_driver(m10v_xdmac_driver);
+
+MODULE_AUTHOR("Kazuhiro Kasai <kasai.kazuhiro@socionext.com>");
+MODULE_DESCRIPTION("Socionext Milbeaut XDMAC driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

