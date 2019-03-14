Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFABAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2492070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UE6Fs1bM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfCNOCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:02:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33923 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbfCNOCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:02:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id o10so6932271wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8hkwStb4arPJdoRuGRS4yit7i2bvsVJxinFa9oo8k4=;
        b=UE6Fs1bMujjiKWH/OsWrchpDUI5PVjkSqQ9EzCprdG+dP6l8W+qyRzYu2xbbymlKmT
         BSAed8ieNayIy8wOVss3wR6YYb211Dvbtp4Q7AnadVFqlc0qMGR4A6BATUoDlvzteSPE
         /kcP+I9z4CV/0+aVkHaKWPZgvuIhCpu9QQNHUIApUCPXdhklBY8TPKsHy+WlAVF1SvW0
         Scl8Y+rJtZv0ajs9IHrE4t10OzUsDr+sy/bi28jdm8R1slk7MpsFVfRBr4TAEgqRD6Lx
         EhRWrS+f8SToaXTkJcdAry1JK8RLXE6MAPRrzzTqI7q+xkoVrKaGupOkUc7IChgAVxfG
         cZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8hkwStb4arPJdoRuGRS4yit7i2bvsVJxinFa9oo8k4=;
        b=G/V9cKs36pN95z406qQince9dklwqQoo48K+ADtT1npZxqrTbDvi0SzBnRkl2HjBW6
         yM40SzDNCO16ctEgxWlU/IZsRRPAccF5XTLPoEguzZa6YyUhL5DEqsWO0EQhuFgazdQ3
         l2L0gskgiIYHrPFBNmquY1SoME/UYRMfZZ3bvRmRKBb8DBnqapufnGEInZrzTpkJFJnp
         5jz/rccFuWlz8X001uZkGuXkbkTsRTDQuTrTlK5gZ5xTl70lbbhSGLv6Fg7wH+cGI4yD
         XhD+NC9vACGx464LyEytDTGFQZ8JpriePN4tV7RS5s+WI2VUOF5dMs/86vstflRkXr2f
         rrjQ==
X-Gm-Message-State: APjAAAWqdRlD7dKFE5kyqHQo4IhphiRsOPmSUt3vaWYTNu/MYhzirr9b
        JYvuoNNaFmbHVMy9IOFPegP4HTwK6R0=
X-Google-Smtp-Source: APXvYqxLZv4CRlP9PraVeEcVMUrNCJxQTkbshoQBMnpSEasIqDoMiIhoqRNTOPvNB0Y0ZgiI8Md9zg==
X-Received: by 2002:a1c:c60e:: with SMTP id w14mr2670501wmf.146.1552572116925;
        Thu, 14 Mar 2019 07:01:56 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id y7sm2661051wmi.34.2019.03.14.07.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 07:01:56 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH net-next 2/3] net: phy: add amlogic g12a mdio mux support
Date:   Thu, 14 Mar 2019 15:01:34 +0100
Message-Id: <20190314140135.19184-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190314140135.19184-1-jbrunet@baylibre.com>
References: <20190314140135.19184-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the mdio mux and internal phy glue of the g12a SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/net/phy/Kconfig               |  10 +
 drivers/net/phy/Makefile              |   1 +
 drivers/net/phy/mdio-mux-meson-g12a.c | 371 ++++++++++++++++++++++++++
 3 files changed, 382 insertions(+)
 create mode 100644 drivers/net/phy/mdio-mux-meson-g12a.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 071869db44cf..831aa350b1cb 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -74,6 +74,16 @@ config MDIO_BUS_MUX_GPIO
 	  several child MDIO busses to a parent bus.  Child bus
 	  selection is under the control of GPIO lines.
 
+config MDIO_BUS_MUX_MESON_G12A
+	tristate "Amlogic G12a based MDIO bus multiplexer"
+	depends on ARCH_MESON || COMPILE_TEST
+	depends on OF_MDIO && HAS_IOMEM
+	select MDIO_BUS_MUX
+	help
+	  This module provides a driver for the MDIO multiplexer/glue of
+	  the amlogic g12a SoC. The multiplexers connects either the external
+	  or the internal MDIO bus to the parent bus.
+
 config MDIO_BUS_MUX_MMIOREG
 	tristate "MMIO device-controlled MDIO bus multiplexers"
 	depends on OF_MDIO && HAS_IOMEM
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index ece5dae67174..27d7f9f3b0de 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_MDIO_BITBANG)	+= mdio-bitbang.o
 obj-$(CONFIG_MDIO_BUS_MUX)	+= mdio-mux.o
 obj-$(CONFIG_MDIO_BUS_MUX_BCM_IPROC)	+= mdio-mux-bcm-iproc.o
 obj-$(CONFIG_MDIO_BUS_MUX_GPIO)	+= mdio-mux-gpio.o
+obj-$(CONFIG_MDIO_BUS_MUX_MESON_G12A)	+= mdio-mux-meson-g12a.o
 obj-$(CONFIG_MDIO_BUS_MUX_MMIOREG) += mdio-mux-mmioreg.o
 obj-$(CONFIG_MDIO_BUS_MUX_MULTIPLEXER) += mdio-mux-multiplexer.o
 obj-$(CONFIG_MDIO_CAVIUM)	+= mdio-cavium.o
diff --git a/drivers/net/phy/mdio-mux-meson-g12a.c b/drivers/net/phy/mdio-mux-meson-g12a.c
new file mode 100644
index 000000000000..9da681cce7cd
--- /dev/null
+++ b/drivers/net/phy/mdio-mux-meson-g12a.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 Baylibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/phy.h>
+#include <linux/mdio-mux.h>
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+#include <linux/bitfield.h>
+#include <linux/iopoll.h>
+
+#define ETH_PLL_STS		0x40
+#define ETH_PLL_CTL0		0x44
+#define  PLL_CTL0_LOCK_DIG	BIT(30)
+#define  PLL_CTL0_RST		BIT(29)
+#define  PLL_CTL0_EN		BIT(28)
+#define  PLL_CTL0_SEL		BIT(23)
+#define  PLL_CTL0_N		GENMASK(14, 10)
+#define  PLL_CTL0_M		GENMASK(8, 0)
+#define  PLL_LOCK_TIMEOUT	1000000
+#define  PLL_MUX_NUM_PARENT	2
+#define ETH_PLL_CTL1		0x48
+#define ETH_PLL_CTL2		0x4c
+#define ETH_PLL_CTL3		0x50
+#define ETH_PLL_CTL4		0x54
+#define ETH_PLL_CTL5		0x58
+#define ETH_PLL_CTL6		0x5c
+#define ETH_PLL_CTL7		0x60
+
+#define ETH_PHY_CNTL0		0x80
+#define   EPHY_G12A_ID		0x33000180
+#define ETH_PHY_CNTL1		0x84
+#define  PHY_CNTL1_ST_MODE	GENMASK(2, 0)
+#define  PHY_CNTL1_ST_PHYADD	GENMASK(7, 3)
+#define   EPHY_DFLT_ADD		8
+#define  PHY_CNTL1_MII_MODE	GENMASK(15, 14)
+#define   EPHY_MODE_RMII	0x1
+#define  PHY_CNTL1_CLK_EN	BIT(16)
+#define  PHY_CNTL1_CLKFREQ	BIT(17)
+#define  PHY_CNTL1_PHY_ENB	BIT(18)
+#define ETH_PHY_CNTL2		0x88
+#define  PHY_CNTL2_USE_INTERNAL	BIT(5)
+#define  PHY_CNTL2_SMI_SRC_MAC	BIT(6)
+#define  PHY_CNTL2_RX_CLK_EPHY	BIT(9)
+
+#define MESON_G12A_MDIO_EXTERNAL_ID 0
+#define MESON_G12A_MDIO_INTERNAL_ID 1
+
+struct g12a_mdio_mux {
+	void __iomem *regs;
+	struct clk *pclk;
+	struct clk *pll;
+	bool pll_is_enabled;
+	void *mux_handle;
+};
+
+struct g12a_ephy_pll {
+	struct clk_hw hw;
+	void __iomem *base;
+};
+
+#define g12a_ephy_pll_to_dev(_hw)			\
+	container_of(_hw, struct g12a_ephy_pll, hw)	\
+
+static unsigned long g12a_ephy_pll_recalc_rate(struct clk_hw *hw,
+					       unsigned long parent_rate)
+{
+	struct g12a_ephy_pll *pll = g12a_ephy_pll_to_dev(hw);
+	u32 val, m, n;
+
+	val = readl(pll->base + ETH_PLL_CTL0);
+	m = FIELD_GET(PLL_CTL0_M, val);
+	n = FIELD_GET(PLL_CTL0_N, val);
+
+	return parent_rate * m / n;
+}
+
+static int g12a_ephy_pll_enable(struct clk_hw *hw)
+{
+	struct g12a_ephy_pll *pll = g12a_ephy_pll_to_dev(hw);
+	u32 val = readl(pll->base + ETH_PLL_CTL0);
+
+	/* Apply both enable an reset */
+	val |= PLL_CTL0_RST | PLL_CTL0_EN;
+	writel(val, pll->base + ETH_PLL_CTL0);
+
+	/* Clear the reset to let PLL lock */
+	val &= ~PLL_CTL0_RST;
+	writel(val, pll->base + ETH_PLL_CTL0);
+
+	/* Poll on the digital lock instead of the usual analog lock
+	 * This is done because bit 31 is unreliable on some SoC. Bit
+	 * 31 may indicate that the PLL is not lock eventhough the clock
+	 * is actually running
+	 */
+	return readl_poll_timeout(pll->base + ETH_PLL_CTL0, val,
+				  val & PLL_CTL0_LOCK_DIG, 0, PLL_LOCK_TIMEOUT);
+}
+
+static void g12a_ephy_pll_disable(struct clk_hw *hw)
+{
+	struct g12a_ephy_pll *pll = g12a_ephy_pll_to_dev(hw);
+	u32 val;
+
+	val = readl(pll->base + ETH_PLL_CTL0);
+	val &= ~PLL_CTL0_EN;
+	val |= PLL_CTL0_RST;
+	writel(val, pll->base + ETH_PLL_CTL0);
+}
+
+static int g12a_ephy_pll_is_enabled(struct clk_hw *hw)
+{
+	struct g12a_ephy_pll *pll = g12a_ephy_pll_to_dev(hw);
+	unsigned int val;
+
+	val = readl(pll->base + ETH_PLL_CTL0);
+
+	return (val & PLL_CTL0_LOCK_DIG) ? 1 : 0;
+}
+
+static void g12a_ephy_pll_init(struct clk_hw *hw)
+{
+	struct g12a_ephy_pll *pll = g12a_ephy_pll_to_dev(hw);
+
+	/* Apply PLL HW settings */
+	writel(0x29c0040a, pll->base + ETH_PLL_CTL0);
+	writel(0x927e0000, pll->base + ETH_PLL_CTL1);
+	writel(0xac5f49e5, pll->base + ETH_PLL_CTL2);
+	writel(0x00000000, pll->base + ETH_PLL_CTL3);
+	writel(0x00000000, pll->base + ETH_PLL_CTL4);
+	writel(0x20200000, pll->base + ETH_PLL_CTL5);
+	writel(0x0000c002, pll->base + ETH_PLL_CTL6);
+	writel(0x00000023, pll->base + ETH_PLL_CTL7);
+}
+
+static const struct clk_ops g12a_ephy_pll_ops = {
+	.recalc_rate	= g12a_ephy_pll_recalc_rate,
+	.is_enabled	= g12a_ephy_pll_is_enabled,
+	.enable		= g12a_ephy_pll_enable,
+	.disable	= g12a_ephy_pll_disable,
+	.init		= g12a_ephy_pll_init,
+};
+
+static int _g12a_enable_internal_mdio(struct g12a_mdio_mux *priv)
+{
+	int ret;
+
+	/* Enable the phy clock */
+	if (!priv->pll_is_enabled) {
+		ret = clk_prepare_enable(priv->pll);
+		if (ret)
+			return ret;
+	}
+
+	priv->pll_is_enabled = true;
+
+	/* Initialize ephy control */
+	writel(EPHY_G12A_ID, priv->regs + ETH_PHY_CNTL0);
+	writel(FIELD_PREP(PHY_CNTL1_ST_MODE, 3) |
+	       FIELD_PREP(PHY_CNTL1_ST_PHYADD, EPHY_DFLT_ADD) |
+	       FIELD_PREP(PHY_CNTL1_MII_MODE, EPHY_MODE_RMII) |
+	       PHY_CNTL1_CLK_EN |
+	       PHY_CNTL1_CLKFREQ |
+	       PHY_CNTL1_PHY_ENB,
+	       priv->regs + ETH_PHY_CNTL1);
+	writel(PHY_CNTL2_USE_INTERNAL |
+	       PHY_CNTL2_SMI_SRC_MAC |
+	       PHY_CNTL2_RX_CLK_EPHY,
+	       priv->regs + ETH_PHY_CNTL2);
+
+	return 0;
+}
+
+static int _g12a_enable_external_mdio(struct g12a_mdio_mux *priv)
+{
+	/* Reset the mdio bus mux */
+	writel_relaxed(0x0, priv->regs + ETH_PHY_CNTL2);
+
+	/* Disable the phy clock if enabled */
+	if (priv->pll_is_enabled) {
+		clk_disable_unprepare(priv->pll);
+		priv->pll_is_enabled = false;
+	}
+
+	return 0;
+}
+
+static int g12a_mdio_switch_fn(int current_child, int desired_child,
+			       void *data)
+{
+	struct device *dev = data;
+	struct g12a_mdio_mux *priv = dev_get_drvdata(dev);
+
+	if (current_child == desired_child)
+		return 0;
+
+	switch (desired_child) {
+	case MESON_G12A_MDIO_EXTERNAL_ID:
+		return _g12a_enable_external_mdio(priv);
+	case MESON_G12A_MDIO_INTERNAL_ID:
+		return _g12a_enable_internal_mdio(priv);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct of_device_id g12a_mdio_mux_match[] = {
+	{ .compatible = "amlogic,g12a-mdio-mux", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, g12a_mdio_mux_match);
+
+static int g12a_ephy_glue_clk_register(struct device *dev)
+{
+	struct g12a_mdio_mux *priv = dev_get_drvdata(dev);
+	const char *parent_names[PLL_MUX_NUM_PARENT];
+	struct clk_init_data init;
+	struct clk_mux *mux;
+	struct g12a_ephy_pll *pll;
+	struct clk *clk;
+	char *name;
+	int i;
+
+	/* get the mux parents */
+	for (i = 0; i < PLL_MUX_NUM_PARENT; i++) {
+		char in_name[8];
+
+		snprintf(in_name, sizeof(in_name), "clkin%d", i);
+		clk = devm_clk_get(dev, in_name);
+		if (IS_ERR(clk)) {
+			if (PTR_ERR(clk) != -EPROBE_DEFER)
+				dev_err(dev, "Missing clock %s\n", in_name);
+			return PTR_ERR(clk);
+		}
+
+		parent_names[i] = __clk_get_name(clk);
+	}
+
+	/* create the input mux */
+	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return -ENOMEM;
+
+	name = kasprintf(GFP_KERNEL, "%s#mux", dev_name(dev));
+	if (!name)
+		return -ENOMEM;
+
+	init.name = name;
+	init.ops = &clk_mux_ro_ops;
+	init.flags = 0;
+	init.parent_names = parent_names;
+	init.num_parents = PLL_MUX_NUM_PARENT;
+
+	mux->reg = priv->regs + ETH_PLL_CTL0;
+	mux->shift = __ffs(PLL_CTL0_SEL);
+	mux->mask = PLL_CTL0_SEL >> mux->shift;
+	mux->hw.init = &init;
+
+	clk = devm_clk_register(dev, &mux->hw);
+	kfree(name);
+	if (IS_ERR(clk)) {
+		dev_err(dev, "failed to register input mux\n");
+		return PTR_ERR(clk);
+	}
+
+	/* create the pll */
+	pll = devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return -ENOMEM;
+
+	name = kasprintf(GFP_KERNEL, "%s#pll", dev_name(dev));
+	if (!name)
+		return -ENOMEM;
+
+	init.name = name;
+	init.ops = &g12a_ephy_pll_ops;
+	init.flags = 0;
+	parent_names[0] = __clk_get_name(clk);
+	init.parent_names = parent_names;
+	init.num_parents = 1;
+
+	pll->base = priv->regs;
+	pll->hw.init = &init;
+
+	clk = devm_clk_register(dev, &pll->hw);
+	kfree(name);
+	if (IS_ERR(clk)) {
+		dev_err(dev, "failed to register input mux\n");
+		return PTR_ERR(clk);
+	}
+
+	priv->pll = clk;
+
+	return 0;
+}
+
+static int g12a_mdio_mux_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct g12a_mdio_mux *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->regs))
+		return PTR_ERR(priv->regs);
+
+	priv->pclk = devm_clk_get(dev, "pclk");
+	if (IS_ERR(priv->pclk)) {
+		ret = PTR_ERR(priv->pclk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get peripheral clock\n");
+		return ret;
+	}
+
+	/* Make sure the device registers are clocked */
+	ret = clk_prepare_enable(priv->pclk);
+	if (ret) {
+		dev_err(dev, "failed to enable peripheral clock");
+		return ret;
+	}
+
+	/* Register PLL in CCF */
+	ret = g12a_ephy_glue_clk_register(dev);
+	if (ret)
+		return ret;
+
+	return mdio_mux_init(dev, dev->of_node, g12a_mdio_switch_fn,
+			     &priv->mux_handle, dev, NULL);
+}
+
+static int g12a_mdio_mux_remove(struct platform_device *pdev)
+{
+	struct g12a_mdio_mux *priv = platform_get_drvdata(pdev);
+
+	mdio_mux_uninit(priv->mux_handle);
+
+	if (priv->pll_is_enabled)
+		clk_disable_unprepare(priv->pll);
+
+	clk_disable_unprepare(priv->pclk);
+
+	return 0;
+}
+
+static struct platform_driver g12a_mdio_mux_driver = {
+	.probe		= g12a_mdio_mux_probe,
+	.remove		= g12a_mdio_mux_remove,
+	.driver		= {
+		.name	= "g12a-mdio_mux",
+		.of_match_table = g12a_mdio_mux_match,
+	},
+};
+module_platform_driver(g12a_mdio_mux_driver);
+
+MODULE_DESCRIPTION("Amlogic G12a MDIO multiplexer driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

