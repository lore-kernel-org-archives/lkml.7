Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08D5C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8227D21655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="dKqQyEjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388046AbfG2Sbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 14:31:47 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:50224 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbfG2Sbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 14:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1564425098; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zRgiwGElrD3GkNjgKUEcwA8NO9VsgpCuqJlhV/Snczk=;
        b=dKqQyEjtH4/ay0KueeT1jPQFVkFg2CRfJMJXXPvYLbbUakh2AIzO4Fr0RNUuuVH4llRawq
        c9/pzEDeLETSf+E1ZdgTpkDK5dBJQDsS6Tm85FkR++xM8Tv69AkeE3xFUUiwI9M7+nPjbn
        L7BgqcCEIVcE7oam08eD6dzWYV+s5yc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Paul Burton <paul.burton@mips.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/3] remoteproc: ingenic: Added remoteproc driver
Date:   Mon, 29 Jul 2019 14:31:09 -0400
Message-Id: <20190729183109.18283-3-paul@crapouillou.net>
In-Reply-To: <20190729183109.18283-1-paul@crapouillou.net>
References: <20190729183109.18283-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is used to boot, communicate with and load firmwares to the
MIPS co-processor found in the VPU hardware of the JZ47xx SoCs from
Ingenic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Remove exception for always-mapped memories

 drivers/remoteproc/Kconfig         |   8 +
 drivers/remoteproc/Makefile        |   1 +
 drivers/remoteproc/ingenic_rproc.c | 285 +++++++++++++++++++++++++++++
 3 files changed, 294 insertions(+)
 create mode 100644 drivers/remoteproc/ingenic_rproc.c

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 28ed306982f7..a0be40e2098d 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -214,6 +214,14 @@ config STM32_RPROC
 
 	  This can be either built-in or a loadable module.
 
+config INGENIC_RPROC
+	tristate "Ingenic JZ47xx VPU remoteproc support"
+	depends on MIPS || COMPILE_TEST
+	help
+	  Say y or m here to support the VPU in the JZ47xx SoCs from Ingenic.
+	  This can be either built-in or a loadable module.
+	  If unsure say N.
+
 endif # REMOTEPROC
 
 endmenu
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 00f09e658cb3..6eb0137abbc7 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -10,6 +10,7 @@ remoteproc-y				+= remoteproc_sysfs.o
 remoteproc-y				+= remoteproc_virtio.o
 remoteproc-y				+= remoteproc_elf_loader.o
 obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
+obj-$(CONFIG_INGENIC_RPROC)			+= ingenic_rproc.o
 obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
 obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
 obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
diff --git a/drivers/remoteproc/ingenic_rproc.c b/drivers/remoteproc/ingenic_rproc.c
new file mode 100644
index 000000000000..6fe0530c83a6
--- /dev/null
+++ b/drivers/remoteproc/ingenic_rproc.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Ingenic JZ47xx remoteproc driver
+ * Copyright 2019, Paul Cercueil <paul@crapouillou.net>
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/remoteproc.h>
+
+#include "remoteproc_internal.h"
+
+#define REG_AUX_CTRL		0x0
+#define REG_AUX_MSG_ACK		0x10
+#define REG_AUX_MSG		0x14
+#define REG_CORE_MSG_ACK	0x18
+#define REG_CORE_MSG		0x1C
+
+#define AUX_CTRL_SLEEP		BIT(31)
+#define AUX_CTRL_MSG_IRQ_EN	BIT(3)
+#define AUX_CTRL_NMI_RESETS	BIT(2)
+#define AUX_CTRL_NMI		BIT(1)
+#define AUX_CTRL_SW_RESET	BIT(0)
+
+struct vpu_mem_map {
+	const char *name;
+	unsigned int da;
+};
+
+struct vpu_mem_info {
+	const struct vpu_mem_map *map;
+	unsigned long len;
+	void __iomem *base;
+};
+
+static const struct vpu_mem_map vpu_mem_map[] = {
+	{ "tcsm0", 0x132b0000 },
+	{ "tcsm1", 0xf4000000 },
+	{ "sram",  0x132f0000 },
+};
+
+/* Device data */
+struct vpu {
+	int irq;
+	struct clk *vpu_clk;
+	struct clk *aux_clk;
+	void __iomem *aux_base;
+	struct vpu_mem_info mem_info[ARRAY_SIZE(vpu_mem_map)];
+	struct device *dev;
+};
+
+static int ingenic_rproc_prepare(struct rproc *rproc)
+{
+	struct vpu *vpu = rproc->priv;
+	int ret;
+
+	ret = clk_prepare_enable(vpu->vpu_clk);
+	if (ret) {
+		dev_err(vpu->dev, "Unable to start VPU clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(vpu->aux_clk);
+	if (ret) {
+		dev_err(vpu->dev, "Unable to start AUX clock: %d\n", ret);
+		goto err_disable_vpu_clk;
+	}
+
+	return 0;
+
+err_disable_vpu_clk:
+	clk_disable_unprepare(vpu->vpu_clk);
+	return ret;
+}
+
+static void ingenic_rproc_unprepare(struct rproc *rproc)
+{
+	struct vpu *vpu = rproc->priv;
+
+	clk_disable_unprepare(vpu->aux_clk);
+	clk_disable_unprepare(vpu->vpu_clk);
+}
+
+static int ingenic_rproc_start(struct rproc *rproc)
+{
+	struct vpu *vpu = rproc->priv;
+	u32 ctrl;
+
+	enable_irq(vpu->irq);
+
+	/* Reset the AUX and enable message IRQ */
+	ctrl = AUX_CTRL_NMI_RESETS | AUX_CTRL_NMI | AUX_CTRL_MSG_IRQ_EN;
+	writel(ctrl, vpu->aux_base + REG_AUX_CTRL);
+
+	return 0;
+}
+
+static int ingenic_rproc_stop(struct rproc *rproc)
+{
+	struct vpu *vpu = rproc->priv;
+
+	/* Keep AUX in reset mode */
+	writel(AUX_CTRL_SW_RESET, vpu->aux_base + REG_AUX_CTRL);
+
+	disable_irq_nosync(vpu->irq);
+
+	return 0;
+}
+
+static void ingenic_rproc_kick(struct rproc *rproc, int vqid)
+{
+	struct vpu *vpu = rproc->priv;
+
+	writel(vqid, vpu->aux_base + REG_CORE_MSG);
+}
+
+static void *ingenic_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
+{
+	struct vpu *vpu = rproc->priv;
+	void __iomem *va = NULL;
+	unsigned int i;
+
+	if (len <= 0)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(vpu_mem_map); i++) {
+		const struct vpu_mem_info *info = &vpu->mem_info[i];
+		const struct vpu_mem_map *map = info->map;
+
+		if (da >= map->da && (da + len) < (map->da + info->len)) {
+			va = info->base + (da - map->da);
+			break;
+		}
+	}
+
+	return (__force void *)va;
+}
+
+static struct rproc_ops ingenic_rproc_ops = {
+	.prepare = ingenic_rproc_prepare,
+	.unprepare = ingenic_rproc_unprepare,
+	.start = ingenic_rproc_start,
+	.stop = ingenic_rproc_stop,
+	.kick = ingenic_rproc_kick,
+	.da_to_va = ingenic_rproc_da_to_va,
+};
+
+static irqreturn_t vpu_interrupt(int irq, void *data)
+{
+	struct rproc *rproc = data;
+	struct vpu *vpu = rproc->priv;
+	u32 vring;
+
+	vring = readl(vpu->aux_base + REG_AUX_MSG);
+
+	/* Ack the interrupt */
+	writel(0, vpu->aux_base + REG_AUX_MSG_ACK);
+
+	return rproc_vq_interrupt(rproc, vring);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id ingenic_rproc_of_matches[] = {
+	{ .compatible = "ingenic,jz4770-vpu-rproc", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ingenic_rproc_of_matches);
+#endif
+
+static void ingenic_rproc_free(void *rproc)
+{
+	rproc_free(rproc);
+}
+
+static void ingenic_rproc_unregister(void *rproc)
+{
+	rproc_del(rproc);
+	rproc_shutdown(rproc);
+}
+
+static int ingenic_rproc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *mem;
+	struct rproc *rproc;
+	struct vpu *vpu;
+	unsigned int i;
+	int ret;
+
+	rproc = rproc_alloc(dev, "ingenic-vpu",
+			    &ingenic_rproc_ops, NULL, sizeof(*vpu));
+	if (!rproc)
+		return -ENOMEM;
+
+	ret = devm_add_action_or_reset(dev, ingenic_rproc_free, rproc);
+	if (ret) {
+		dev_err(dev, "Unable to add action");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, rproc);
+	vpu = rproc->priv;
+	vpu->dev = &pdev->dev;
+
+	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "aux");
+	vpu->aux_base = devm_ioremap_resource(dev, mem);
+	if (IS_ERR(vpu->aux_base)) {
+		dev_err(dev, "Failed to ioremap");
+		return PTR_ERR(vpu->aux_base);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(vpu_mem_map); i++) {
+		mem = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   vpu_mem_map[i].name);
+
+		vpu->mem_info[i].base = devm_ioremap_resource(dev, mem);
+		if (IS_ERR(vpu->mem_info[i].base)) {
+			ret = PTR_ERR(vpu->mem_info[i].base);
+			dev_err(dev, "Failed to ioremap");
+			return ret;
+		}
+
+		vpu->mem_info[i].len = resource_size(mem);
+		vpu->mem_info[i].map = &vpu_mem_map[i];
+	}
+
+	vpu->vpu_clk = devm_clk_get(dev, "vpu");
+	if (IS_ERR(vpu->vpu_clk)) {
+		dev_err(dev, "Failed to get VPU clock");
+		return PTR_ERR(vpu->vpu_clk);
+	}
+
+	vpu->aux_clk = devm_clk_get(dev, "aux");
+	if (IS_ERR(vpu->aux_clk)) {
+		dev_err(dev, "Failed to get AUX clock");
+		return PTR_ERR(vpu->aux_clk);
+	}
+
+	vpu->irq = platform_get_irq(pdev, 0);
+	if (vpu->irq < 0) {
+		dev_err(dev, "Failed to get platform IRQ");
+		return vpu->irq;
+	}
+
+	ret = devm_request_irq(dev, vpu->irq, vpu_interrupt, 0, "VPU", rproc);
+	if (ret < 0) {
+		dev_err(dev, "Failed to request IRQ");
+		return ret;
+	}
+
+	disable_irq_nosync(vpu->irq);
+
+	ret = rproc_add(rproc);
+	if (ret) {
+		dev_err(dev, "Failed to register remote processor");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, ingenic_rproc_unregister, rproc);
+	if (ret) {
+		dev_err(dev, "Unable to add action");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct platform_driver ingenic_rproc_driver = {
+	.probe = ingenic_rproc_probe,
+	.driver = {
+		.name = "ingenic-vpu",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(ingenic_rproc_of_matches),
+	},
+};
+module_platform_driver(ingenic_rproc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
+MODULE_DESCRIPTION("Ingenic JZ47xx Remote Processor control driver");
-- 
2.21.0.593.g511ec345e18

