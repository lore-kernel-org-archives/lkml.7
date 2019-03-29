Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F887C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38D821773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfC2IMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:12:15 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:11887 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbfC2IMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:12:13 -0400
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id x2T80sQp092565;
        Fri, 29 Mar 2019 16:00:54 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id x2T804vh091366;
        Fri, 29 Mar 2019 16:00:05 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, lee.jones@linaro.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw, Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v9 1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD controller driver
Date:   Fri, 29 Mar 2019 16:20:04 +0800
Message-Id: <1553847606-18122-2-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com x2T804vh091366
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for Renesas R-Car Gen3 RPC-IF MFD controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mfd/Kconfig             |   9 +++
 drivers/mfd/Makefile            |   1 +
 drivers/mfd/renesas-rpc.c       | 140 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/renesas-rpc.h | 154 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 304 insertions(+)
 create mode 100644 drivers/mfd/renesas-rpc.c
 create mode 100644 include/linux/mfd/renesas-rpc.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 0ce2d8d..a870e12 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -978,6 +978,15 @@ config MFD_RDC321X
 	  southbridge which provides access to GPIOs and Watchdog using the
 	  southbridge PCI device configuration space.
 
+config MFD_RENESAS_RPC
+	tristate "Renesas R-Car Gen3 RPC-IF MFD driver"
+	select MFD_CORE
+	depends on ARCH_RENESAS
+	help
+	  This supports for Renesas R-Car Gen3 RPC-IF multifunction device
+	  controller which provides either SPI host controller or HyperFlash.
+	  You have to select individual components under the corresponding menu.
+
 config MFD_RT5033
 	tristate "Richtek RT5033 Power Management IC"
 	depends on I2C
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index b4569ed7..4a49699 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -183,6 +183,7 @@ obj-$(CONFIG_MFD_INTEL_QUARK_I2C_GPIO)	+= intel_quark_i2c_gpio.o
 obj-$(CONFIG_LPC_SCH)		+= lpc_sch.o
 obj-$(CONFIG_LPC_ICH)		+= lpc_ich.o
 obj-$(CONFIG_MFD_RDC321X)	+= rdc321x-southbridge.o
+obj-$(CONFIG_MFD_RENESAS_RPC)	+= renesas-rpc.o
 obj-$(CONFIG_MFD_JANZ_CMODIO)	+= janz-cmodio.o
 obj-$(CONFIG_MFD_JZ4740_ADC)	+= jz4740-adc.o
 obj-$(CONFIG_MFD_TPS6586X)	+= tps6586x.o
diff --git a/drivers/mfd/renesas-rpc.c b/drivers/mfd/renesas-rpc.c
new file mode 100644
index 0000000..c92bb74
--- /dev/null
+++ b/drivers/mfd/renesas-rpc.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
+// Copyright (C) 2019 Macronix International Co., Ltd.
+//
+// R-Car Gen3 RPC-IF MFD driver
+//
+// Author:
+//	Mason Yang <masonccyang@mxic.com.tw>
+//
+
+#include <linux/mfd/renesas-rpc.h>
+#include <linux/mfd/core.h>
+
+static const struct mfd_cell rpc_hf_ctlr = {
+	.name = "rpc-hf",
+	.of_compatible = "renesas,rcar-rpc-hf",
+};
+
+static const struct mfd_cell rpc_spi_ctlr = {
+	.name = "rpc-spi",
+	.of_compatible = "renesas,rcar-rpc-spi",
+};
+
+static const struct regmap_range rpc_mfd_volatile_ranges[] = {
+	regmap_reg_range(RPC_SMRDR0, RPC_SMRDR0),
+	regmap_reg_range(RPC_SMWDR0, RPC_SMWDR0),
+	regmap_reg_range(RPC_CMNSR, RPC_CMNSR),
+};
+
+static const struct regmap_access_table rpc_mfd_volatile_table = {
+	.yes_ranges	= rpc_mfd_volatile_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(rpc_mfd_volatile_ranges),
+};
+
+static const struct regmap_config rpc_mfd_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.fast_io = true,
+	.max_register = RPC_PHYOFFSET2,
+	.volatile_table = &rpc_mfd_volatile_table,
+};
+
+static int rpc_mfd_probe(struct platform_device *pdev)
+{
+	struct device_node *ctlr;
+	const struct mfd_cell *cell;
+	struct resource *res;
+	struct rpc_mfd *rpc;
+	int ret;
+
+	ctlr = of_get_next_child(pdev->dev.of_node, NULL);
+	if (!ctlr) {
+		dev_warn(&pdev->dev, "no spi/hf ctlr node found\n");
+		return -ENODEV;
+	}
+
+	ret = of_device_is_compatible(ctlr, "renesas,rcar-rpc-spi");
+	if (ret) {
+		cell = &rpc_spi_ctlr;
+	} else {
+		ret = of_device_is_compatible(ctlr,
+					      "renesas,rcar-rpc-hf");
+		if (ret) {
+			cell = &rpc_hf_ctlr;
+		} else {
+			dev_warn(&pdev->dev, "no spi/hf device found\n");
+			return -ENODEV;
+		}
+	}
+
+	rpc = devm_kzalloc(&pdev->dev, sizeof(*rpc), GFP_KERNEL);
+	if (!rpc)
+		return -ENOMEM;
+
+	rpc->clk_rpc = devm_clk_get(&pdev->dev, "rpc");
+	if (IS_ERR(rpc->clk_rpc))
+		return PTR_ERR(rpc->clk_rpc);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
+	rpc->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(rpc->base))
+		return PTR_ERR(rpc->base);
+
+	rpc->regmap = devm_regmap_init_mmio(&pdev->dev, rpc->base,
+					    &rpc_mfd_regmap_config);
+	if (IS_ERR(rpc->regmap)) {
+		dev_err(&pdev->dev,
+			"failed to init regmap for rpc-mfd, error %ld\n",
+			PTR_ERR(rpc->regmap));
+		return PTR_ERR(rpc->regmap);
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dirmap");
+	rpc->dirmap = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(rpc->dirmap))
+		rpc->dirmap = NULL;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "wbuf");
+	rpc->wbuf = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(rpc->wbuf))
+		rpc->wbuf = NULL;
+
+	rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(rpc->rstc))
+		return PTR_ERR(rpc->rstc);
+
+	platform_set_drvdata(pdev, rpc);
+
+	ret = devm_mfd_add_devices(&pdev->dev, -1, cell, 1, NULL, 0, NULL);
+
+	return ret;
+}
+
+static int rpc_mfd_remove(struct platform_device *pdev)
+{
+	mfd_remove_devices(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id rpc_mfd_of_match[] = {
+	{ .compatible = "renesas,rcar-gen3-rpc", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rpc_mfd_of_match);
+
+static struct platform_driver rpc_mfd_driver = {
+	.probe = rpc_mfd_probe,
+	.remove = rpc_mfd_remove,
+	.driver = {
+		.name =	"rpc-mfd",
+		.of_match_table = rpc_mfd_of_match,
+	},
+};
+module_platform_driver(rpc_mfd_driver);
+
+MODULE_AUTHOR("Mason Yang <masonccyang@mxic.com.tw>");
+MODULE_DESCRIPTION("Renesas R-Car Gen3 RPC MFD driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/renesas-rpc.h b/include/linux/mfd/renesas-rpc.h
new file mode 100644
index 0000000..209e64f1
--- /dev/null
+++ b/include/linux/mfd/renesas-rpc.h
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
+// Copyright (C) 2019 Macronix International Co., Ltd.
+//
+// R-Car Gen3 RPC-IF MFD driver
+//
+// Author:
+//	Mason Yang <masonccyang@mxic.com.tw>
+//
+
+#ifndef __MFD_RENESAS_RPC_H
+#define __MFD_RENESAS_RPC_H
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/log2.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mtd/mtd.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#define RPC_CMNCR		0x0000	// R/W
+#define RPC_CMNCR_MD		BIT(31)
+#define RPC_CMNCR_SFDE		BIT(24) // undocumented bit but must be set
+#define RPC_CMNCR_MOIIO3(val)	(((val) & 0x3) << 22)
+#define RPC_CMNCR_MOIIO2(val)	(((val) & 0x3) << 20)
+#define RPC_CMNCR_MOIIO1(val)	(((val) & 0x3) << 18)
+#define RPC_CMNCR_MOIIO0(val)	(((val) & 0x3) << 16)
+#define RPC_CMNCR_MOIIO_HIZ	(RPC_CMNCR_MOIIO0(3) | RPC_CMNCR_MOIIO1(3) | \
+				 RPC_CMNCR_MOIIO2(3) | RPC_CMNCR_MOIIO3(3))
+#define RPC_CMNCR_IO3FV(val)	(((val) & 0x3) << 14) // undocumented
+#define RPC_CMNCR_IO2FV(val)	(((val) & 0x3) << 12) // undocumented
+#define RPC_CMNCR_IO0FV(val)	(((val) & 0x3) << 8)
+#define RPC_CMNCR_IOFV_HIZ	(RPC_CMNCR_IO0FV(3) | RPC_CMNCR_IO2FV(3) | \
+				 RPC_CMNCR_IO3FV(3))
+#define RPC_CMNCR_BSZ(val)	(((val) & 0x3) << 0)
+
+#define RPC_SSLDR		0x0004	// R/W
+#define RPC_SSLDR_SPNDL(d)	(((d) & 0x7) << 16)
+#define RPC_SSLDR_SLNDL(d)	(((d) & 0x7) << 8)
+#define RPC_SSLDR_SCKDL(d)	(((d) & 0x7) << 0)
+
+#define RPC_DRCR		0x000C	// R/W
+#define RPC_DRCR_SSLN		BIT(24)
+#define RPC_DRCR_RBURST(v)	((((v) - 1) & 0x1F) << 16)
+#define RPC_DRCR_RCF		BIT(9)
+#define RPC_DRCR_RBE		BIT(8)
+#define RPC_DRCR_SSLE		BIT(0)
+
+#define RPC_DRCMR		0x0010	// R/W
+#define RPC_DRCMR_CMD(c)	(((c) & 0xFF) << 16)
+#define RPC_DRCMR_OCMD(c)	(((c) & 0xFF) << 0)
+
+#define RPC_DREAR		0x0014	// R/W
+#define RPC_DREAR_EAC(c)	(((c) & 0x7) << 0)
+
+#define RPC_DROPR		0x0018	// R/W
+
+#define RPC_DRENR		0x001C	// R/W
+#define RPC_DRENR_CDB(o)	(u32)((((o) & 0x3) << 30))
+#define RPC_DRENR_OCDB(o)	(((o) & 0x3) << 28)
+#define RPC_DRENR_ADB(o)	(((o) & 0x3) << 24)
+#define RPC_DRENR_OPDB(o)	(((o) & 0x3) << 20)
+#define RPC_DRENR_DRDB(o)	(((o) & 0x3) << 16)
+#define RPC_DRENR_DME		BIT(15)
+#define RPC_DRENR_CDE		BIT(14)
+#define RPC_DRENR_OCDE		BIT(12)
+#define RPC_DRENR_ADE(v)	(((v) & 0xF) << 8)
+#define RPC_DRENR_OPDE(v)	(((v) & 0xF) << 4)
+
+#define RPC_SMCR		0x0020	// R/W
+#define RPC_SMCR_SSLKP		BIT(8)
+#define RPC_SMCR_SPIRE		BIT(2)
+#define RPC_SMCR_SPIWE		BIT(1)
+#define RPC_SMCR_SPIE		BIT(0)
+
+#define RPC_SMCMR		0x0024	// R/W
+#define RPC_SMCMR_CMD(c)	(((c) & 0xFF) << 16)
+#define RPC_SMCMR_OCMD(c)	(((c) & 0xFF) << 0)
+
+#define RPC_SMADR		0x0028	// R/W
+#define RPC_SMOPR		0x002C	// R/W
+#define RPC_SMOPR_OPD3(o)	(((o) & 0xFF) << 24)
+#define RPC_SMOPR_OPD2(o)	(((o) & 0xFF) << 16)
+#define RPC_SMOPR_OPD1(o)	(((o) & 0xFF) << 8)
+#define RPC_SMOPR_OPD0(o)	(((o) & 0xFF) << 0)
+
+#define RPC_SMENR		0x0030	// R/W
+#define RPC_SMENR_CDB(o)	(((o) & 0x3) << 30)
+#define RPC_SMENR_OCDB(o)	(((o) & 0x3) << 28)
+#define RPC_SMENR_ADB(o)	(((o) & 0x3) << 24)
+#define RPC_SMENR_OPDB(o)	(((o) & 0x3) << 20)
+#define RPC_SMENR_SPIDB(o)	(((o) & 0x3) << 16)
+#define RPC_SMENR_DME		BIT(15)
+#define RPC_SMENR_CDE		BIT(14)
+#define RPC_SMENR_OCDE		BIT(12)
+#define RPC_SMENR_ADE(v)	(((v) & 0xF) << 8)
+#define RPC_SMENR_OPDE(v)	(((v) & 0xF) << 4)
+#define RPC_SMENR_SPIDE(v)	(((v) & 0xF) << 0)
+
+#define RPC_SMRDR0		0x0038	// R
+#define RPC_SMRDR1		0x003C	// R
+#define RPC_SMWDR0		0x0040	// W
+#define RPC_SMWDR1		0x0044	// W
+
+#define RPC_CMNSR		0x0048	// R
+#define RPC_CMNSR_SSLF		BIT(1)
+#define RPC_CMNSR_TEND		BIT(0)
+
+#define RPC_DRDMCR		0x0058	// R/W
+#define RPC_DRDRENR		0x005C	// R/W
+
+#define RPC_SMDMCR		0x0060	// R/W
+#define RPC_SMDMCR_DMCYC(v)	((((v) - 1) & 0x1F) << 0)
+
+#define RPC_SMDRENR		0x0064	// R/W
+#define RPC_SMDRENR_HYPE	(0x7 << 12)
+#define RPC_SMDRENR_ADDRE	BIT(8)
+#define RPC_SMDRENR_OPDRE	BIT(4)
+#define RPC_SMDRENR_SPIDRE	BIT(0)
+
+#define RPC_PHYCNT		0x007C	// R/W
+#define RPC_PHYCNT_CAL		BIT(31)
+#define PRC_PHYCNT_OCTA_AA	BIT(22)
+#define PRC_PHYCNT_OCTA_SA	BIT(23)
+#define PRC_PHYCNT_EXDS		BIT(21)
+#define RPC_PHYCNT_OCT		BIT(20)
+#define RPC_PHYCNT_STRTIM(v)	(((v) & 0x7) << 15)
+#define RPC_PHYCNT_WBUF2	BIT(4)
+#define RPC_PHYCNT_WBUF		BIT(2)
+#define RPC_PHYCNT_PHYMEM(v)	(((v) & 0x3) << 0)
+
+#define RPC_PHYOFFSET1		0x0080	// R/W
+#define RPC_PHYOFFSET1_DDRTMG(v) (((v) & 0x3) << 28)
+#define RPC_PHYOFFSET2		0x0084	// R/W
+#define RPC_PHYOFFSET2_OCTTMG(v) (((v) & 0x7) << 8)
+
+#define RPC_WBUF_SIZE		256	// Write Buffer size
+
+struct rpc_mfd {
+	struct clk *clk_rpc;
+	void __iomem *base;
+	void __iomem *dirmap;
+	void __iomem *wbuf;
+	struct regmap *regmap;
+	struct reset_control *rstc;
+};
+
+#endif // __MFD_RENESAS_RPC_H
-- 
1.9.1

