Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D5BC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6ABA2088F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W65KgC+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfDYPlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:41:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47103 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfDYPla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:41:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so15630wrw.13;
        Thu, 25 Apr 2019 08:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=250fLcY/evR70OHayKkPYcOMEdJJgWyZp0RwJO5ApRU=;
        b=W65KgC+cJRVDzsuEYr8Vyq/oMvCnzpl5Y4Y2c4f3AZE3/xYIxNkUEpBrHFPpI5gvMb
         gOyfzIV4VHyiyK+HosJ5FTkBczPOt9Ab21W6EZV0PcmTv4O8VAzuUi4TG36RhYzqgtCb
         Ihb1tmYWZNRr3Sb4TWe4yHt62m+YxMXtP+CmuenFQpe6UqFzsEd3/bO6M9Xka5ez7ZIr
         LR576/1R1FcRkAZkHY5eI2iuHzWktqUJpBhci+JZzpABnbGozX8LjGPtg8xk6Sm5tciA
         5eyxG3bSh9lN5g6cs6iI8yyGfvtNAq9YUZwEjxLIpW4Tdb+wWqbuZIReW+MgIY3SIULn
         VMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=250fLcY/evR70OHayKkPYcOMEdJJgWyZp0RwJO5ApRU=;
        b=WAURDl0GOuUvGklaSOivp8Q6BcVdhge680tZoKQsLZC0d52hDtnWjGfLhl6XMjnlTS
         dOE4mUemmh6XX8DwXNCN2BXe2O67yXw+b3K6l6V3Pmuoqshipy2KUJMamuGwZjinc4AT
         g2NxjeSuPBD5/JbdyB6h2if4beL/Cgya5hIF/7s+lAl9MOIKHzzO3RpPTp9Qxp4ktQLx
         VRC+Z49tqI4NKTdLBvKDiBIHMeSG13hqIkcgDVaxMBFb/huFZKYnMD58n7qc3QuyWQJt
         L4Vzig0eR0xSxD1C73taKqTD9qe2gqJEWGaXxlVrLI1IlLj17ziKlUzMICSyIiv+vwgg
         g2cA==
X-Gm-Message-State: APjAAAXdlIMq5FUA2jpVzfudG0d8pLOJc1bJl/c82ssaEIcFfNcK7e5f
        jDeGguIEfOxJcFRJ98Quuio=
X-Google-Smtp-Source: APXvYqx//i/JamUSOsWMswaeHQAsABSeqKQs9cBQzXKdwXZfSb2H9dLNdETM8o/zuWUPwlPgYBVuJQ==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr17579501wrn.175.1556206887610;
        Thu, 25 Apr 2019 08:41:27 -0700 (PDT)
Received: from localhost.localdomain (216.red-79-159-55.dynamicip.rima-tde.net. [79.159.55.216])
        by smtp.gmail.com with ESMTPSA id r9sm21793674wmh.38.2019.04.25.08.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Apr 2019 08:41:27 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, devicetree@vger.kernel.org,
        john@phrozen.org, linux-mips@vger.kernel.org, robh+dt@kernel.org,
        neil@brown.name
Subject: [PATCH v3 2/2] phy: ralink: Add PHY driver for MT7621 PCIe PHY
Date:   Thu, 25 Apr 2019 17:41:22 +0200
Message-Id: <20190425154122.24122-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190425154122.24122-1-sergio.paracuellos@gmail.com>
References: <20190425154122.24122-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a driver for the PCIe PHY of MT7621 SoC.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/phy/ralink/Kconfig          |   8 +
 drivers/phy/ralink/Makefile         |   1 +
 drivers/phy/ralink/phy-mt7621-pci.c | 423 ++++++++++++++++++++++++++++
 3 files changed, 432 insertions(+)
 create mode 100644 drivers/phy/ralink/phy-mt7621-pci.c

diff --git a/drivers/phy/ralink/Kconfig b/drivers/phy/ralink/Kconfig
index 14fd219535ef..429187ff02e2 100644
--- a/drivers/phy/ralink/Kconfig
+++ b/drivers/phy/ralink/Kconfig
@@ -1,6 +1,14 @@
 #
 # PHY drivers for Ralink platforms.
 #
+config PHY_MT7621_PCI
+	tristate "MediaTek MT7621 PCI PHY Driver"
+	depends on (RALINK || COMPILE_TEST) && OF
+	select GENERIC_PHY
+	select REGMAP_MMIO
+	help
+	  Say 'Y' here to add support for MediaTek MT7621 PCI PHY driver,
+
 config PHY_RALINK_USB
 	tristate "Ralink USB PHY driver"
 	depends on RALINK || COMPILE_TEST
diff --git a/drivers/phy/ralink/Makefile b/drivers/phy/ralink/Makefile
index 5c9e326e8757..2052d5649863 100644
--- a/drivers/phy/ralink/Makefile
+++ b/drivers/phy/ralink/Makefile
@@ -1 +1,2 @@
+obj-$(CONFIG_PHY_MT7621_PCI)	+= phy-mt7621-pci.o
 obj-$(CONFIG_PHY_RALINK_USB)	+= phy-ralink-usb.o
diff --git a/drivers/phy/ralink/phy-mt7621-pci.c b/drivers/phy/ralink/phy-mt7621-pci.c
new file mode 100644
index 000000000000..2576f179e30a
--- /dev/null
+++ b/drivers/phy/ralink/phy-mt7621-pci.c
@@ -0,0 +1,423 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Mediatek MT7621 PCI PHY Driver
+ * Author: Sergio Paracuellos <sergio.paracuellos@gmail.com>
+ */
+
+#include <dt-bindings/phy/phy.h>
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/sys_soc.h>
+#include <mt7621.h>
+#include <ralink_regs.h>
+
+#define RALINK_CLKCFG1				0x30
+
+#define PCIE_PORT_CLK_EN(x)			BIT(24 + (x))
+
+#define RG_PE1_PIPE_REG				0x02c
+#define RG_PE1_PIPE_RST				BIT(12)
+#define RG_PE1_PIPE_CMD_FRC			BIT(4)
+
+#define RG_P0_TO_P1_WIDTH			0x100
+#define RG_PE1_H_LCDDS_REG			0x49c
+#define RG_PE1_H_LCDDS_PCW			GENMASK(30, 0)
+#define RG_PE1_H_LCDDS_PCW_VAL(x)		((0x7fffffff & (x)) << 0)
+
+#define RG_PE1_FRC_H_XTAL_REG			0x400
+#define RG_PE1_FRC_H_XTAL_TYPE			BIT(8)
+#define RG_PE1_H_XTAL_TYPE			GENMASK(10, 9)
+#define RG_PE1_H_XTAL_TYPE_VAL(x)		((0x3 & (x)) << 9)
+
+#define RG_PE1_FRC_PHY_REG			0x000
+#define RG_PE1_FRC_PHY_EN			BIT(4)
+#define RG_PE1_PHY_EN				BIT(5)
+
+#define RG_PE1_H_PLL_REG			0x490
+#define RG_PE1_H_PLL_BC				GENMASK(23, 22)
+#define RG_PE1_H_PLL_BC_VAL(x)			((0x3 & (x)) << 22)
+#define RG_PE1_H_PLL_BP				GENMASK(21, 18)
+#define RG_PE1_H_PLL_BP_VAL(x)			((0xf & (x)) << 18)
+#define RG_PE1_H_PLL_IR				GENMASK(15, 12)
+#define RG_PE1_H_PLL_IR_VAL(x)			((0xf & (x)) << 12)
+#define RG_PE1_H_PLL_IC				GENMASK(11, 8)
+#define RG_PE1_H_PLL_IC_VAL(x)			((0xf & (x)) << 8)
+#define RG_PE1_H_PLL_PREDIV			GENMASK(7, 6)
+#define RG_PE1_H_PLL_PREDIV_VAL(x)		((0x3 & (x)) << 6)
+#define RG_PE1_PLL_DIVEN			GENMASK(3, 1)
+#define RG_PE1_PLL_DIVEN_VAL(x)			((0x7 & (x)) << 1)
+
+#define RG_PE1_H_PLL_FBKSEL_REG			0x4bc
+#define RG_PE1_H_PLL_FBKSEL			GENMASK(5, 4)
+#define RG_PE1_H_PLL_FBKSEL_VAL(x)		((0x3 & (x)) << 4)
+
+#define	RG_PE1_H_LCDDS_SSC_PRD_REG		0x4a4
+#define RG_PE1_H_LCDDS_SSC_PRD			GENMASK(15, 0)
+#define RG_PE1_H_LCDDS_SSC_PRD_VAL(x)		((0xffff & (x)) << 0)
+
+#define RG_PE1_H_LCDDS_SSC_DELTA_REG		0x4a8
+#define RG_PE1_H_LCDDS_SSC_DELTA		GENMASK(11, 0)
+#define RG_PE1_H_LCDDS_SSC_DELTA_VAL(x)		((0xfff & (x)) << 0)
+#define RG_PE1_H_LCDDS_SSC_DELTA1		GENMASK(27, 16)
+#define RG_PE1_H_LCDDS_SSC_DELTA1_VAL(x)	((0xff & (x)) << 16)
+
+#define RG_PE1_LCDDS_CLK_PH_INV_REG		0x4a0
+#define RG_PE1_LCDDS_CLK_PH_INV			BIT(5)
+
+#define RG_PE1_H_PLL_BR_REG			0x4ac
+#define RG_PE1_H_PLL_BR				GENMASK(18, 16)
+#define RG_PE1_H_PLL_BR_VAL(x)			((0x7 & (x)) << 16)
+
+#define	RG_PE1_MSTCKDIV_REG			0x414
+#define RG_PE1_MSTCKDIV				GENMASK(7, 6)
+#define RG_PE1_MSTCKDIV_VAL(x)			((0x3 & (x)) << 6)
+
+#define RG_PE1_FRC_MSTCKDIV			BIT(5)
+
+#define MAX_PHYS	2
+
+/**
+ * struct mt7621_pci_phy_instance - Mt7621 Pcie PHY device
+ * @phy: pointer to the kernel PHY device
+ * @port_base: base register
+ * @index: internal ID to identify the Mt7621 PCIe PHY
+ */
+struct mt7621_pci_phy_instance {
+	struct phy *phy;
+	void __iomem *port_base;
+	u32 index;
+};
+
+/**
+ * struct mt7621_pci_phy - Mt7621 Pcie PHY core
+ * @dev: pointer to device
+ * @regmap: kernel regmap pointer
+ * @phys: pointer to Mt7621 PHY device
+ * @nphys: number of PHY devices for this core
+ * @bypass_pipe_rst: mark if 'mt7621_bypass_pipe_rst'
+ * needs to be executed. Depends on chip revision.
+ */
+struct mt7621_pci_phy {
+	struct device *dev;
+	struct regmap *regmap;
+	struct mt7621_pci_phy_instance **phys;
+	int nphys;
+	bool bypass_pipe_rst;
+};
+
+static inline u32 phy_read(struct mt7621_pci_phy *phy, u32 reg)
+{
+	u32 val;
+
+	regmap_read(phy->regmap, reg, &val);
+
+	return val;
+}
+
+static inline void phy_write(struct mt7621_pci_phy *phy, u32 val, u32 reg)
+{
+	regmap_write(phy->regmap, reg, val);
+}
+
+static void mt7621_bypass_pipe_rst(struct mt7621_pci_phy *phy,
+				   struct mt7621_pci_phy_instance *instance)
+{
+	u32 offset = (instance->index != 1) ?
+		RG_PE1_PIPE_REG : RG_PE1_PIPE_REG + RG_P0_TO_P1_WIDTH;
+	u32 reg;
+
+	reg = phy_read(phy, offset);
+	reg &= ~(RG_PE1_PIPE_RST | RG_PE1_PIPE_CMD_FRC);
+	reg |= (RG_PE1_PIPE_RST | RG_PE1_PIPE_CMD_FRC);
+	phy_write(phy, reg, offset);
+}
+
+static void mt7621_set_phy_for_ssc(struct mt7621_pci_phy *phy,
+				   struct mt7621_pci_phy_instance *instance)
+{
+	struct device *dev = phy->dev;
+	u32 reg = rt_sysc_r32(SYSC_REG_SYSTEM_CONFIG0);
+	u32 offset;
+	u32 val;
+
+	reg = (reg >> 6) & 0x7;
+	/* Set PCIe Port PHY to disable SSC */
+	/* Debug Xtal Type */
+	val = phy_read(phy, RG_PE1_FRC_H_XTAL_REG);
+	val &= ~(RG_PE1_FRC_H_XTAL_TYPE | RG_PE1_H_XTAL_TYPE);
+	val |= RG_PE1_FRC_H_XTAL_TYPE;
+	val |= RG_PE1_H_XTAL_TYPE_VAL(0x00);
+	phy_write(phy, val, RG_PE1_FRC_H_XTAL_REG);
+
+	/* disable port */
+	offset = (instance->index != 1) ?
+		RG_PE1_FRC_PHY_REG : RG_PE1_FRC_PHY_REG + RG_P0_TO_P1_WIDTH;
+	val = phy_read(phy, offset);
+	val &= ~(RG_PE1_FRC_PHY_EN | RG_PE1_PHY_EN);
+	val |= RG_PE1_FRC_PHY_EN;
+	phy_write(phy, val, offset);
+
+	/* Set Pre-divider ratio (for host mode) */
+	val = phy_read(phy, RG_PE1_H_PLL_REG);
+	val &= ~(RG_PE1_H_PLL_PREDIV);
+
+	if (reg <= 5 && reg >= 3) { /* 40MHz Xtal */
+		val |= RG_PE1_H_PLL_PREDIV_VAL(0x01);
+		phy_write(phy, val, RG_PE1_H_PLL_REG);
+		dev_info(dev, "Xtal is 40MHz\n");
+	} else { /* 25MHz | 20MHz Xtal */
+		val |= RG_PE1_H_PLL_PREDIV_VAL(0x00);
+		phy_write(phy, val, RG_PE1_H_PLL_REG);
+		if (reg >= 6) {
+			dev_info(dev, "Xtal is 25MHz\n");
+
+			/* Select feedback clock */
+			val = phy_read(phy, RG_PE1_H_PLL_FBKSEL_REG);
+			val &= ~(RG_PE1_H_PLL_FBKSEL);
+			val |= RG_PE1_H_PLL_FBKSEL_VAL(0x01);
+			phy_write(phy, val, RG_PE1_H_PLL_FBKSEL_REG);
+
+			/* DDS NCPO PCW (for host mode) */
+			val = phy_read(phy, RG_PE1_H_LCDDS_SSC_PRD_REG);
+			val &= ~(RG_PE1_H_LCDDS_SSC_PRD);
+			val |= RG_PE1_H_LCDDS_SSC_PRD_VAL(0x18000000);
+			phy_write(phy, val, RG_PE1_H_LCDDS_SSC_PRD_REG);
+
+			/* DDS SSC dither period control */
+			val = phy_read(phy, RG_PE1_H_LCDDS_SSC_PRD_REG);
+			val &= ~(RG_PE1_H_LCDDS_SSC_PRD);
+			val |= RG_PE1_H_LCDDS_SSC_PRD_VAL(0x18d);
+			phy_write(phy, val, RG_PE1_H_LCDDS_SSC_PRD_REG);
+
+			/* DDS SSC dither amplitude control */
+			val = phy_read(phy, RG_PE1_H_LCDDS_SSC_DELTA_REG);
+			val &= ~(RG_PE1_H_LCDDS_SSC_DELTA |
+				 RG_PE1_H_LCDDS_SSC_DELTA1);
+			val |= RG_PE1_H_LCDDS_SSC_DELTA_VAL(0x4a);
+			val |= RG_PE1_H_LCDDS_SSC_DELTA1_VAL(0x4a);
+			phy_write(phy, val, RG_PE1_H_LCDDS_SSC_DELTA_REG);
+		} else {
+			dev_info(dev, "Xtal is 20MHz\n");
+		}
+	}
+
+	/* DDS clock inversion */
+	val = phy_read(phy, RG_PE1_LCDDS_CLK_PH_INV_REG);
+	val &= ~(RG_PE1_LCDDS_CLK_PH_INV);
+	val |= RG_PE1_LCDDS_CLK_PH_INV;
+	phy_write(phy, val, RG_PE1_LCDDS_CLK_PH_INV_REG);
+
+	/* Set PLL bits */
+	val = phy_read(phy, RG_PE1_H_PLL_REG);
+	val &= ~(RG_PE1_H_PLL_BC | RG_PE1_H_PLL_BP | RG_PE1_H_PLL_IR |
+		 RG_PE1_H_PLL_IC | RG_PE1_PLL_DIVEN);
+	val |= RG_PE1_H_PLL_BC_VAL(0x02);
+	val |= RG_PE1_H_PLL_BP_VAL(0x06);
+	val |= RG_PE1_H_PLL_IR_VAL(0x02);
+	val |= RG_PE1_H_PLL_IC_VAL(0x01);
+	val |= RG_PE1_PLL_DIVEN_VAL(0x02);
+	phy_write(phy, val, RG_PE1_H_PLL_REG);
+
+	val = phy_read(phy, RG_PE1_H_PLL_BR_REG);
+	val &= ~(RG_PE1_H_PLL_BR);
+	val |= RG_PE1_H_PLL_BR_VAL(0x00);
+	phy_write(phy, val, RG_PE1_H_PLL_BR_REG);
+
+	if (reg <= 5 && reg >= 3) { /* 40MHz Xtal */
+		/* set force mode enable of da_pe1_mstckdiv */
+		val = phy_read(phy, RG_PE1_MSTCKDIV_REG);
+		val &= ~(RG_PE1_MSTCKDIV | RG_PE1_FRC_MSTCKDIV);
+		val |= (RG_PE1_MSTCKDIV_VAL(0x01) | RG_PE1_FRC_MSTCKDIV);
+		phy_write(phy, val, RG_PE1_MSTCKDIV_REG);
+	}
+}
+
+static int mt7621_pci_phy_init(struct phy *phy)
+{
+	struct mt7621_pci_phy_instance *instance = phy_get_drvdata(phy);
+	struct mt7621_pci_phy *mphy = dev_get_drvdata(phy->dev.parent);
+
+	if (mphy->bypass_pipe_rst)
+		mt7621_bypass_pipe_rst(mphy, instance);
+
+	mt7621_set_phy_for_ssc(mphy, instance);
+
+	return 0;
+}
+
+static int mt7621_pci_phy_power_on(struct phy *phy)
+{
+	struct mt7621_pci_phy_instance *instance = phy_get_drvdata(phy);
+	struct mt7621_pci_phy *mphy = dev_get_drvdata(phy->dev.parent);
+	u32 offset = (instance->index != 1) ?
+		RG_PE1_FRC_PHY_REG : RG_PE1_FRC_PHY_REG + RG_P0_TO_P1_WIDTH;
+	u32 val;
+
+	/* Enable PHY and disable force mode */
+	val = phy_read(mphy, offset);
+	val &= ~(RG_PE1_FRC_PHY_EN | RG_PE1_PHY_EN);
+	val |= (RG_PE1_FRC_PHY_EN | RG_PE1_PHY_EN);
+	phy_write(mphy, val, offset);
+
+	return 0;
+}
+
+static int mt7621_pci_phy_power_off(struct phy *phy)
+{
+	struct mt7621_pci_phy_instance *instance = phy_get_drvdata(phy);
+	struct mt7621_pci_phy *mphy = dev_get_drvdata(phy->dev.parent);
+	u32 offset = (instance->index != 1) ?
+		RG_PE1_FRC_PHY_REG : RG_PE1_FRC_PHY_REG + RG_P0_TO_P1_WIDTH;
+	u32 val;
+
+	/* Disable PHY */
+	val = phy_read(mphy, offset);
+	val &= ~(RG_PE1_FRC_PHY_EN | RG_PE1_PHY_EN);
+	val |= RG_PE1_FRC_PHY_EN;
+	phy_write(mphy, val, offset);
+
+	return 0;
+}
+
+static int mt7621_pci_phy_exit(struct phy *phy)
+{
+	struct mt7621_pci_phy_instance *instance = phy_get_drvdata(phy);
+
+	rt_sysc_m32(PCIE_PORT_CLK_EN(instance->index), 0, RALINK_CLKCFG1);
+
+	return 0;
+}
+
+static const struct phy_ops mt7621_pci_phy_ops = {
+	.init		= mt7621_pci_phy_init,
+	.exit		= mt7621_pci_phy_exit,
+	.power_on	= mt7621_pci_phy_power_on,
+	.power_off	= mt7621_pci_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static struct phy *mt7621_pcie_phy_of_xlate(struct device *dev,
+					    struct of_phandle_args *args)
+{
+	struct mt7621_pci_phy *mt7621_phy = dev_get_drvdata(dev);
+
+	if (args->args_count == 0)
+		return mt7621_phy->phys[0]->phy;
+
+	if (WARN_ON(args->args[0] >= MAX_PHYS))
+		return ERR_PTR(-ENODEV);
+
+	return mt7621_phy->phys[args->args[0]]->phy;
+}
+
+static const struct soc_device_attribute mt7621_pci_quirks_match[] = {
+	{ .soc_id = "mt7621", .revision = "E2" }
+};
+
+static const struct regmap_config mt7621_pci_phy_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0x700,
+};
+
+static int mt7621_pci_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct soc_device_attribute *attr;
+	struct phy_provider *provider;
+	struct mt7621_pci_phy *phy;
+	struct resource *res;
+	int port;
+	void __iomem *port_base;
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->nphys = MAX_PHYS;
+	phy->phys = devm_kcalloc(dev, phy->nphys,
+				 sizeof(*phy->phys), GFP_KERNEL);
+	if (!phy->phys)
+		return -ENOMEM;
+
+	attr = soc_device_match(mt7621_pci_quirks_match);
+	if (attr)
+		phy->bypass_pipe_rst = true;
+
+	phy->dev = dev;
+	platform_set_drvdata(pdev, phy);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "failed to get address resource\n");
+		return -ENXIO;
+	}
+
+	port_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(port_base)) {
+		dev_err(dev, "failed to remap phy regs\n");
+		return PTR_ERR(port_base);
+	}
+
+	phy->regmap = devm_regmap_init_mmio(phy->dev, port_base,
+					    &mt7621_pci_phy_regmap_config);
+	if (IS_ERR(phy->regmap))
+		return PTR_ERR(phy->regmap);
+
+	for (port = 0; port < MAX_PHYS; port++) {
+		struct mt7621_pci_phy_instance *instance;
+		struct phy *pphy;
+
+		instance = devm_kzalloc(dev, sizeof(*instance), GFP_KERNEL);
+		if (!instance)
+			return -ENOMEM;
+
+		phy->phys[port] = instance;
+
+		pphy = devm_phy_create(dev, dev->of_node, &mt7621_pci_phy_ops);
+		if (IS_ERR(phy)) {
+			dev_err(dev, "failed to create phy\n");
+			return PTR_ERR(phy);
+		}
+
+		instance->port_base = port_base;
+		instance->phy = pphy;
+		instance->index = port;
+		phy_set_drvdata(pphy, instance);
+	}
+
+	provider = devm_of_phy_provider_register(dev, mt7621_pcie_phy_of_xlate);
+
+	return PTR_ERR_OR_ZERO(provider);
+}
+
+static const struct of_device_id mt7621_pci_phy_ids[] = {
+	{ .compatible = "mediatek,mt7621-pci-phy" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mt7621_pci_ids);
+
+static struct platform_driver mt7621_pci_phy_driver = {
+	.probe = mt7621_pci_phy_probe,
+	.driver = {
+		.name = "mt7621-pci-phy",
+		.of_match_table = of_match_ptr(mt7621_pci_phy_ids),
+	},
+};
+
+static int __init mt7621_pci_phy_drv_init(void)
+{
+	return platform_driver_register(&mt7621_pci_phy_driver);
+}
+
+module_init(mt7621_pci_phy_drv_init);
+
+MODULE_AUTHOR("Sergio Paracuellos <sergio.paracuellos@gmail.com>");
+MODULE_DESCRIPTION("MediaTek MT7621 PCIe PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.19.1

