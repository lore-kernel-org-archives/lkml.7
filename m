Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A71CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9B420856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 10:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="T0qVjW/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393338AbfJXKzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 06:55:12 -0400
Received: from vps.xff.cz ([195.181.215.36]:33858 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393301AbfJXKzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 06:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1571914507; bh=uGTdAoYyNuqCp07zW5PJZ5ee6k1Wnq8ZFKa2bRRaOpA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=T0qVjW/ty7mxlrj4Dxl6YXSCbPyo71CQZVFE2+UggknpKw0YhCuDJOwIZ3MtHwcOs
         Ryqukf3BHVerp1aLCAQY2JGwRQ0s8ZvLRSIJmyRpslHzozRF9nxiDlag1VMkn05vLr
         Rg2Z774kIgmCccLfsVmt67akSQDypoDfEunujSsw=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ondrej Jirman <megous@megous.com>
Subject: [PATCH v2 2/4] phy: allwinner: add phy driver for USB3 PHY on Allwinner H6 SoC
Date:   Thu, 24 Oct 2019 12:54:58 +0200
Message-Id: <20191024105500.2252707-3-megous@megous.com>
In-Reply-To: <20191024105500.2252707-1-megous@megous.com>
References: <20191024105500.2252707-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Allwinner H6 SoC contains a USB3 PHY (with USB2 DP/DM lines also
controlled).

Add a driver for it.

The register operations in this driver is mainly extracted from the BSP
USB3 driver.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/phy/allwinner/Kconfig           |  12 ++
 drivers/phy/allwinner/Makefile          |   1 +
 drivers/phy/allwinner/phy-sun50i-usb3.c | 195 ++++++++++++++++++++++++
 3 files changed, 208 insertions(+)
 create mode 100644 drivers/phy/allwinner/phy-sun50i-usb3.c

diff --git a/drivers/phy/allwinner/Kconfig b/drivers/phy/allwinner/Kconfig
index 215425296c77..fcae35ddd430 100644
--- a/drivers/phy/allwinner/Kconfig
+++ b/drivers/phy/allwinner/Kconfig
@@ -45,3 +45,15 @@ config PHY_SUN9I_USB
 	  sun9i SoCs.
 
 	  This driver controls each individual USB 2 host PHY.
+
+config PHY_SUN50I_USB3
+	tristate "Allwinner sun50i SoC USB3 PHY driver"
+	depends on ARCH_SUNXI && HAS_IOMEM && OF
+	depends on RESET_CONTROLLER
+	select USB_COMMON
+	select GENERIC_PHY
+	help
+	  Enable this to support the USB3.0-capable transceiver that is
+	  part of some Allwinner sun50i SoCs.
+
+	  This driver controls each individual USB 2+3 host PHY combo.
diff --git a/drivers/phy/allwinner/Makefile b/drivers/phy/allwinner/Makefile
index 799a65c0b58d..bd74901a1255 100644
--- a/drivers/phy/allwinner/Makefile
+++ b/drivers/phy/allwinner/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
 obj-$(CONFIG_PHY_SUN6I_MIPI_DPHY)	+= phy-sun6i-mipi-dphy.o
 obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
+obj-$(CONFIG_PHY_SUN50I_USB3)		+= phy-sun50i-usb3.o
diff --git a/drivers/phy/allwinner/phy-sun50i-usb3.c b/drivers/phy/allwinner/phy-sun50i-usb3.c
new file mode 100644
index 000000000000..8e170a4d0a11
--- /dev/null
+++ b/drivers/phy/allwinner/phy-sun50i-usb3.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Allwinner sun50i(H6) USB 3.0 phy driver
+ *
+ * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
+ *
+ * Based on phy-sun9i-usb.c, which is:
+ *
+ * Copyright (C) 2014-2015 Chen-Yu Tsai <wens@csie.org>
+ *
+ * Based on code from Allwinner BSP, which is:
+ *
+ * Copyright (c) 2010-2015 Allwinner Technology Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/usb/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+/* Interface Status and Control Registers */
+#define SUNXI_ISCR			0x00
+#define SUNXI_PIPE_CLOCK_CONTROL	0x14
+#define SUNXI_PHY_TUNE_LOW		0x18
+#define SUNXI_PHY_TUNE_HIGH		0x1c
+#define SUNXI_PHY_EXTERNAL_CONTROL	0x20
+
+/* USB2.0 Interface Status and Control Register */
+#define SUNXI_ISCR_FORCE_VBUS		(3 << 12)
+
+/* PIPE Clock Control Register */
+#define SUNXI_PCC_PIPE_CLK_OPEN		(1 << 6)
+
+/* PHY External Control Register */
+#define SUNXI_PEC_EXTERN_VBUS		(3 << 1)
+#define SUNXI_PEC_SSC_EN		(1 << 24)
+#define SUNXI_PEC_REF_SSP_EN		(1 << 26)
+
+/* PHY Tune High Register */
+#define SUNXI_TX_DEEMPH_3P5DB(n)	((n) << 19)
+#define SUNXI_TX_DEEMPH_3P5DB_MASK	GENMASK(24, 19)
+#define SUNXI_TX_DEEMPH_6DB(n)		((n) << 13)
+#define SUNXI_TX_DEEMPH_6GB_MASK	GENMASK(18, 13)
+#define SUNXI_TX_SWING_FULL(n)		((n) << 6)
+#define SUNXI_TX_SWING_FULL_MASK	GENMASK(12, 6)
+#define SUNXI_LOS_BIAS(n)		((n) << 3)
+#define SUNXI_LOS_BIAS_MASK		GENMASK(5, 3)
+#define SUNXI_TXVBOOSTLVL(n)		((n) << 0)
+#define SUNXI_TXVBOOSTLVL_MASK		GENMASK(0, 2)
+
+struct sun50i_usb3_phy {
+	struct phy *phy;
+	void __iomem *regs;
+	struct reset_control *reset;
+	struct clk *clk;
+};
+
+static void sun50i_usb3_phy_open(struct sun50i_usb3_phy *phy)
+{
+	u32 val;
+
+	val = readl(phy->regs + SUNXI_PHY_EXTERNAL_CONTROL);
+	val |= SUNXI_PEC_EXTERN_VBUS;
+	val |= SUNXI_PEC_SSC_EN | SUNXI_PEC_REF_SSP_EN;
+	writel(val, phy->regs + SUNXI_PHY_EXTERNAL_CONTROL);
+
+	val = readl(phy->regs + SUNXI_PIPE_CLOCK_CONTROL);
+	val |= SUNXI_PCC_PIPE_CLK_OPEN;
+	writel(val, phy->regs + SUNXI_PIPE_CLOCK_CONTROL);
+
+	val = readl(phy->regs + SUNXI_ISCR);
+	val |= SUNXI_ISCR_FORCE_VBUS;
+	writel(val, phy->regs + SUNXI_ISCR);
+
+	/*
+	 * All the magic numbers written to the PHY_TUNE_{LOW_HIGH}
+	 * registers are directly taken from the BSP USB3 driver from
+	 * Allwiner.
+	 */
+	writel(0x0047fc87, phy->regs + SUNXI_PHY_TUNE_LOW);
+
+	val = readl(phy->regs + SUNXI_PHY_TUNE_HIGH);
+	val &= ~(SUNXI_TXVBOOSTLVL_MASK | SUNXI_LOS_BIAS_MASK |
+		 SUNXI_TX_SWING_FULL_MASK | SUNXI_TX_DEEMPH_6GB_MASK |
+		 SUNXI_TX_DEEMPH_3P5DB_MASK);
+	val |= SUNXI_TXVBOOSTLVL(0x7);
+	val |= SUNXI_LOS_BIAS(0x7);
+	val |= SUNXI_TX_SWING_FULL(0x55);
+	val |= SUNXI_TX_DEEMPH_6DB(0x20);
+	val |= SUNXI_TX_DEEMPH_3P5DB(0x15);
+	writel(val, phy->regs + SUNXI_PHY_TUNE_HIGH);
+}
+
+static int sun50i_usb3_phy_init(struct phy *_phy)
+{
+	struct sun50i_usb3_phy *phy = phy_get_drvdata(_phy);
+	int ret;
+
+	ret = clk_prepare_enable(phy->clk);
+	if (ret)
+		goto err_clk;
+
+	ret = reset_control_deassert(phy->reset);
+	if (ret)
+		goto err_reset;
+
+	sun50i_usb3_phy_open(phy);
+	return 0;
+
+err_reset:
+	clk_disable_unprepare(phy->clk);
+
+err_clk:
+	return ret;
+}
+
+static int sun50i_usb3_phy_exit(struct phy *_phy)
+{
+	struct sun50i_usb3_phy *phy = phy_get_drvdata(_phy);
+
+	reset_control_assert(phy->reset);
+	clk_disable_unprepare(phy->clk);
+
+	return 0;
+}
+
+static const struct phy_ops sun50i_usb3_phy_ops = {
+	.init		= sun50i_usb3_phy_init,
+	.exit		= sun50i_usb3_phy_exit,
+	.owner		= THIS_MODULE,
+};
+
+static int sun50i_usb3_phy_probe(struct platform_device *pdev)
+{
+	struct sun50i_usb3_phy *phy;
+	struct device *dev = &pdev->dev;
+	struct phy_provider *phy_provider;
+	struct resource *res;
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(phy->clk)) {
+		if (PTR_ERR(phy->clk) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get phy clock\n");
+		return PTR_ERR(phy->clk);
+	}
+
+	phy->reset = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(phy->reset)) {
+		dev_err(dev, "failed to get reset control\n");
+		return PTR_ERR(phy->reset);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	phy->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(phy->regs))
+		return PTR_ERR(phy->regs);
+
+	phy->phy = devm_phy_create(dev, NULL, &sun50i_usb3_phy_ops);
+	if (IS_ERR(phy->phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(phy->phy);
+	}
+
+	phy_set_drvdata(phy->phy, phy);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id sun50i_usb3_phy_of_match[] = {
+	{ .compatible = "allwinner,sun50i-h6-usb3-phy" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sun50i_usb3_phy_of_match);
+
+static struct platform_driver sun50i_usb3_phy_driver = {
+	.probe	= sun50i_usb3_phy_probe,
+	.driver = {
+		.of_match_table	= sun50i_usb3_phy_of_match,
+		.name  = "sun50i-usb3-phy",
+	}
+};
+module_platform_driver(sun50i_usb3_phy_driver);
+
+MODULE_DESCRIPTION("Allwinner sun50i USB 3.0 phy driver");
+MODULE_AUTHOR("Icenowy Zheng <icenowy@aosc.io>");
+MODULE_LICENSE("GPL");
-- 
2.23.0

