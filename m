Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801B5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BAD2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYXIEAxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfCNNWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:22:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50539 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfCNNWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:22:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id x7so2982504wmj.0;
        Thu, 14 Mar 2019 06:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JuvjhY1kJCLXoe3YY0jpSrVA8HMsY3uDrYZVIOsQqPI=;
        b=bYXIEAxaBMWiMS4Mglo1or76HKhplfsuDCZEXEc46fc9mXI6gMAs+uEEqAO/XtFCe4
         nHSeIictH8yM6ikUdJNtqC4cqDrqpMMPo1dMXhksVcb0nd4PguJJw7cl+N8N2SN7T/Nc
         o9aPylRpqvWLvL+0hlTUvLXkc7AkzZiKi7uPjNg+KM2gIXPs/FocJms9fYw8RvA9IjzF
         mWBE7bszkAkjCNAjrY8UeJckIphG4KZtZu7ZXbp+cuZ2MZc+WewC/2RNsJH+7EOTI7AY
         pAlxSyuXyFN3LMcH05VyVyc6fpRyVYjO60MH3EBQKe7Qd6ugHokBWyHf5B+59jjF7HVp
         ak6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JuvjhY1kJCLXoe3YY0jpSrVA8HMsY3uDrYZVIOsQqPI=;
        b=EmxYfodKwpU5oVThwXKDUGNlYzXDmlQp8PmAVik5HW2T0Wv95hOzLy0yIIfK7jnfXL
         Butin6jT4U4kDWCfAoK5YX9/Vr+vKuRYMYKD8QPEqF/qCAooEhusJnv2DzlPMNqavxaF
         Xsd5pPZvrPFAnIE2vTCJuOEncadmHPpDLJ+X4jP4HOT+zDZC74aoCjnJaBQLBAp3wzea
         478DUYcukjY05y/ke+VqmD+oQ19WJt9kW+nRtRW56tRx1py9y8AkDR9BoQrQHk5aEVvb
         sZ9847SAwADjcZ9jp2CcrczrNJFt6XNQnyBJsv3emIC4G8sf7cKNpsKVecGLHnogbzVA
         54zQ==
X-Gm-Message-State: APjAAAViHITcA/h3lweLDO6knLhBy3jGTmZwZZnV+iIMA6jjeaf6RYqU
        SpLBKbexeyP7coN8rmy7TDk=
X-Google-Smtp-Source: APXvYqySOJcNviIDaX2i05v8KLw9imxrn4u5/6kbf4tF6l7AnmxsrADQSwt94GBKOOfaHH/CCmYgdA==
X-Received: by 2002:a7b:c08b:: with SMTP id r11mr2330067wmh.133.1552569734374;
        Thu, 14 Mar 2019 06:22:14 -0700 (PDT)
Received: from localhost.localdomain (79.red-83-47-240.dynamicip.rima-tde.net. [83.47.240.79])
        by smtp.gmail.com with ESMTPSA id y66sm2979820wmd.37.2019.03.14.06.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Mar 2019 06:22:13 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org, devicetree@vger.kernel.org,
        john@phrozen.org, linux-mips@vger.kernel.org, robh+dt@kernel.org,
        neil@brown.name
Subject: [PATCH 1/2] phy: ralink: Add PHY driver for MT7621 PCIe PHY
Date:   Thu, 14 Mar 2019 14:22:09 +0100
Message-Id: <20190314132210.654-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190314132210.654-1-sergio.paracuellos@gmail.com>
References: <20190314132210.654-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a driver for the PCIe PHY of MT7621 SoC.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/phy/ralink/Kconfig          |   7 +
 drivers/phy/ralink/Makefile         |   1 +
 drivers/phy/ralink/phy-mt7621-pci.c | 387 ++++++++++++++++++++++++++++
 3 files changed, 395 insertions(+)
 create mode 100644 drivers/phy/ralink/phy-mt7621-pci.c

diff --git a/drivers/phy/ralink/Kconfig b/drivers/phy/ralink/Kconfig
index 14fd219535ef..87943a10f210 100644
--- a/drivers/phy/ralink/Kconfig
+++ b/drivers/phy/ralink/Kconfig
@@ -1,6 +1,13 @@
 #
 # PHY drivers for Ralink platforms.
 #
+config PHY_MT7621_PCI
+	tristate "MediaTek MT7621 PCI PHY Driver"
+	depends on RALINK && OF
+	select GENERIC_PHY
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
index 000000000000..d3ca2f019112
--- /dev/null
+++ b/drivers/phy/ralink/phy-mt7621-pci.c
@@ -0,0 +1,387 @@
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
+#include <mt7621.h>
+#include <ralink_regs.h>
+
+#define RALINK_CLKCFG1			0x30
+#define CHIP_REV_MT7621_E2		0x0101
+
+#define PCIE_PORT_CLK_EN(x)		BIT(24 + (x))
+
+#define RG_PE1_PIPE_REG			0x02c
+#define RG_PE1_PIPE_RST			BIT(12)
+#define RG_PE1_PIPE_CMD_FRC		BIT(4)
+
+#define RG_P0_TO_P1_WIDTH		0x100
+#define RG_PE1_H_LCDDS_REG		0x49c
+#define RG_PE1_H_LCDDS_PCW		GENMASK(30, 0)
+#define RG_PE1_H_LCDDS_PCW_VAL(x)	((0x7fffffff & (x)) << 0)
+
+#define RG_PE1_FRC_H_XTAL_REG		0x400
+#define RG_PE1_FRC_H_XTAL_TYPE          BIT(8)
+#define RG_PE1_H_XTAL_TYPE              GENMASK(10, 9)
+#define RG_PE1_H_XTAL_TYPE_VAL(x)       ((0x3 & (x)) << 9)
+
+#define RG_PE1_FRC_PHY_REG		0x000
+#define RG_PE1_FRC_PHY_EN               BIT(4)
+#define RG_PE1_PHY_EN                   BIT(5)
+
+#define RG_PE1_H_PLL_REG		0x490
+#define RG_PE1_H_PLL_BC			GENMASK(23, 22)
+#define RG_PE1_H_PLL_BC_VAL(x)		((0x3 & (x)) << 22)
+#define RG_PE1_H_PLL_BP			GENMASK(21, 18)
+#define RG_PE1_H_PLL_BP_VAL(x)		((0xf & (x)) << 18)
+#define RG_PE1_H_PLL_IR			GENMASK(15, 12)
+#define RG_PE1_H_PLL_IR_VAL(x)		((0xf & (x)) << 12)
+#define RG_PE1_H_PLL_IC			GENMASK(11, 8)
+#define RG_PE1_H_PLL_IC_VAL(x)		((0xf & (x)) << 8)
+#define RG_PE1_H_PLL_PREDIV             GENMASK(7, 6)
+#define RG_PE1_H_PLL_PREDIV_VAL(x)      ((0x3 & (x)) << 6)
+#define RG_PE1_PLL_DIVEN		GENMASK(3, 1)
+#define RG_PE1_PLL_DIVEN_VAL(x)		((0x7 & (x)) << 1)
+
+#define RG_PE1_H_PLL_FBKSEL_REG		0x4bc
+#define RG_PE1_H_PLL_FBKSEL             GENMASK(5, 4)
+#define RG_PE1_H_PLL_FBKSEL_VAL(x)      ((0x3 & (x)) << 4)
+
+#define	RG_PE1_H_LCDDS_SSC_PRD_REG	0x4a4
+#define RG_PE1_H_LCDDS_SSC_PRD          GENMASK(15, 0)
+#define RG_PE1_H_LCDDS_SSC_PRD_VAL(x)   ((0xffff & (x)) << 0)
+
+#define RG_PE1_H_LCDDS_SSC_DELTA_REG	0x4a8
+#define RG_PE1_H_LCDDS_SSC_DELTA        GENMASK(11, 0)
+#define RG_PE1_H_LCDDS_SSC_DELTA_VAL(x) ((0xfff & (x)) << 0)
+#define RG_PE1_H_LCDDS_SSC_DELTA1       GENMASK(27, 16)
+#define RG_PE1_H_LCDDS_SSC_DELTA1_VAL(x) ((0xff & (x)) << 16)
+
+#define RG_PE1_LCDDS_CLK_PH_INV_REG	0x4a0
+#define RG_PE1_LCDDS_CLK_PH_INV		BIT(5)
+
+#define RG_PE1_H_PLL_BR_REG		0x4ac
+#define RG_PE1_H_PLL_BR			GENMASK(18, 16)
+#define RG_PE1_H_PLL_BR_VAL(x)		((0x7 & (x)) << 16)
+
+#define	RG_PE1_MSTCKDIV_REG		0x414
+#define RG_PE1_MSTCKDIV			GENMASK(7, 6)
+#define RG_PE1_MSTCKDIV_VAL(x)		((0x3 & (x)) << 6)
+
+#define RG_PE1_FRC_MSTCKDIV		BIT(5)
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
+ * @phys: pointer to Mt7621 PHY device
+ * @nphys: number of PHY devices for this core
+ */
+struct mt7621_pci_phy {
+	struct device *dev;
+	struct mt7621_pci_phy_instance **phys;
+	int nphys;
+};
+
+static inline u32 phy_read(struct mt7621_pci_phy_instance *instance, u32 reg)
+{
+	return readl(instance->port_base + reg);
+}
+
+static inline void phy_write(struct mt7621_pci_phy_instance *instance,
+			     u32 val, u32 reg)
+{
+	writel(val, instance->port_base + reg);
+}
+
+static void mt7621_bypass_pipe_rst(struct mt7621_pci_phy *phy,
+				   struct mt7621_pci_phy_instance *instance)
+{
+	u32 offset = (instance->index != 1) ?
+		RG_PE1_PIPE_REG : RG_PE1_PIPE_REG + RG_P0_TO_P1_WIDTH;
+	u32 reg;
+
+	reg = phy_read(instance, offset);
+	reg &= ~(RG_PE1_PIPE_RST | RG_PE1_PIPE_CMD_FRC);
+	reg |= (RG_PE1_PIPE_RST | RG_PE1_PIPE_CMD_FRC);
+	phy_write(instance, reg, offset);
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
+	val = phy_read(instance, RG_PE1_FRC_H_XTAL_REG);
+	val &= ~(RG_PE1_FRC_H_XTAL_TYPE | RG_PE1_H_XTAL_TYPE);
+	val |= RG_PE1_FRC_H_XTAL_TYPE;
+	val |= RG_PE1_H_XTAL_TYPE_VAL(0x00);
+	phy_write(instance, val, RG_PE1_FRC_H_XTAL_REG);
+
+	/* disable port */
+	offset = (instance->index != 1) ?
+		RG_PE1_FRC_PHY_REG : RG_PE1_FRC_PHY_REG + RG_P0_TO_P1_WIDTH;
+	val = phy_read(instance, offset);
+	val &= ~(RG_PE1_FRC_PHY_EN | RG_PE1_PHY_EN);
+	val |= RG_PE1_FRC_PHY_EN;
+	phy_write(instance, val, offset);
+
+	/* Set Pre-divider ratio (for host mode) */
+	val = phy_read(instance, RG_PE1_H_PLL_REG);
+	val &= ~(RG_PE1_H_PLL_PREDIV);
+
+	if (reg <= 5 && reg >= 3) { /* 40MHz Xtal */
+		val |= RG_PE1_H_PLL_PREDIV_VAL(0x01);
+		phy_write(instance, val, RG_PE1_H_PLL_REG);
+		dev_info(dev, "Xtal is 40MHz\n");
+	} else { /* 25MHz | 20MHz Xtal */
+		val |= RG_PE1_H_PLL_PREDIV_VAL(0x00);
+		phy_write(instance, val, RG_PE1_H_PLL_REG);
+		if (reg >= 6) {
+			dev_info(dev, "Xtal is 25MHz\n");
+
+			/* Select feedback clock */
+			val = phy_read(instance, RG_PE1_H_PLL_FBKSEL_REG);
+			val &= ~(RG_PE1_H_PLL_FBKSEL);
+			val |= RG_PE1_H_PLL_FBKSEL_VAL(0x01);
+			phy_write(instance, val, RG_PE1_H_PLL_FBKSEL_REG);
+
+			/* DDS NCPO PCW (for host mode) */
+			val = phy_read(instance, RG_PE1_H_LCDDS_SSC_PRD_REG);
+			val &= ~(RG_PE1_H_LCDDS_SSC_PRD);
+			val |= RG_PE1_H_LCDDS_SSC_PRD_VAL(0x18000000);
+			phy_write(instance, val, RG_PE1_H_LCDDS_SSC_PRD_REG);
+
+			/* DDS SSC dither period control */
+			val = phy_read(instance, RG_PE1_H_LCDDS_SSC_PRD_REG);
+			val &= ~(RG_PE1_H_LCDDS_SSC_PRD);
+			val |= RG_PE1_H_LCDDS_SSC_PRD_VAL(0x18d);
+			phy_write(instance, val, RG_PE1_H_LCDDS_SSC_PRD_REG);
+
+			/* DDS SSC dither amplitude control */
+			val = phy_read(instance, RG_PE1_H_LCDDS_SSC_DELTA_REG);
+			val &= ~(RG_PE1_H_LCDDS_SSC_DELTA |
+				 RG_PE1_H_LCDDS_SSC_DELTA1);
+			val |= RG_PE1_H_LCDDS_SSC_DELTA_VAL(0x4a);
+			val |= RG_PE1_H_LCDDS_SSC_DELTA1_VAL(0x4a);
+			phy_write(instance, val, RG_PE1_H_LCDDS_SSC_DELTA_REG);
+		} else {
+			dev_info(dev, "Xtal is 20MHz\n");
+		}
+	}
+
+	/* DDS clock inversion */
+	val = phy_read(instance, RG_PE1_LCDDS_CLK_PH_INV_REG);
+	val &= ~(RG_PE1_LCDDS_CLK_PH_INV);
+	val |= RG_PE1_LCDDS_CLK_PH_INV;
+	phy_write(instance, val, RG_PE1_LCDDS_CLK_PH_INV_REG);
+
+	/* Set PLL bits */
+	val = phy_read(instance, RG_PE1_H_PLL_REG);
+	val &= ~(RG_PE1_H_PLL_BC | RG_PE1_H_PLL_BP | RG_PE1_H_PLL_IR |
+		 RG_PE1_H_PLL_IC | RG_PE1_PLL_DIVEN);
+	val |= RG_PE1_H_PLL_BC_VAL(0x02);
+	val |= RG_PE1_H_PLL_BP_VAL(0x06);
+	val |= RG_PE1_H_PLL_IR_VAL(0x02);
+	val |= RG_PE1_H_PLL_IC_VAL(0x01);
+	val |= RG_PE1_PLL_DIVEN_VAL(0x02);
+	phy_write(instance, val, RG_PE1_H_PLL_REG);
+
+	val = phy_read(instance, RG_PE1_H_PLL_BR_REG);
+	val &= ~(RG_PE1_H_PLL_BR);
+	val |= RG_PE1_H_PLL_BR_VAL(0x00);
+	phy_write(instance, val, RG_PE1_H_PLL_BR_REG);
+
+	if (reg <= 5 && reg >= 3) { /* 40MHz Xtal */
+		/* set force mode enable of da_pe1_mstckdiv */
+		val = phy_read(instance, RG_PE1_MSTCKDIV_REG);
+		val &= ~(RG_PE1_MSTCKDIV | RG_PE1_FRC_MSTCKDIV);
+		val |= (RG_PE1_MSTCKDIV_VAL(0x01) | RG_PE1_FRC_MSTCKDIV);
+		phy_write(instance, val, RG_PE1_MSTCKDIV_REG);
+	}
+}
+
+static int mt7621_pci_phy_init(struct phy *phy)
+{
+	struct mt7621_pci_phy_instance *instance = phy_get_drvdata(phy);
+	struct mt7621_pci_phy *mphy = dev_get_drvdata(phy->dev.parent);
+	u32 chip_rev_id = rt_sysc_r32(SYSC_REG_CHIP_REV);
+
+	if ((chip_rev_id & 0xFFFF) == CHIP_REV_MT7621_E2)
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
+	u32 offset = (instance->index != 1) ?
+		RG_PE1_FRC_PHY_REG : RG_PE1_FRC_PHY_REG + RG_P0_TO_P1_WIDTH;
+	u32 val;
+
+	/* Enable PHY and disable force mode */
+	val = phy_read(instance, offset);
+	val &= ~(RG_PE1_FRC_PHY_EN | RG_PE1_PHY_EN);
+	val |= (RG_PE1_FRC_PHY_EN | RG_PE1_PHY_EN);
+	phy_write(instance, val, offset);
+
+	return 0;
+}
+
+static int mt7621_pci_phy_power_off(struct phy *phy)
+{
+	struct mt7621_pci_phy_instance *instance = phy_get_drvdata(phy);
+	u32 offset = (instance->index != 1) ?
+		RG_PE1_FRC_PHY_REG : RG_PE1_FRC_PHY_REG + RG_P0_TO_P1_WIDTH;
+	u32 val;
+
+	/* Disable PHY */
+	val = phy_read(instance, offset);
+	val &= ~(RG_PE1_FRC_PHY_EN | RG_PE1_PHY_EN);
+	val |= RG_PE1_FRC_PHY_EN;
+	phy_write(instance, val, offset);
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
+static int mt7621_pci_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *child_np;
+	struct phy_provider *provider;
+	struct mt7621_pci_phy *phy;
+	struct resource res;
+	int port, ret;
+	void __iomem *port_base;
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->nphys = of_get_child_count(np);
+	phy->phys = devm_kcalloc(dev, phy->nphys,
+				 sizeof(*phy->phys), GFP_KERNEL);
+	if (!phy->phys)
+		return -ENOMEM;
+
+	phy->dev = dev;
+	platform_set_drvdata(pdev, phy);
+
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret) {
+		dev_err(dev, "failed to get address resource(id-%d)\n", port);
+		return ret;
+	}
+
+	port_base = devm_ioremap_resource(dev, &res);
+	if (IS_ERR(port_base)) {
+		dev_err(dev, "failed to remap phy regs\n");
+		return PTR_ERR(port_base);
+	}
+
+	port = 0;
+	for_each_child_of_node(np, child_np) {
+		struct mt7621_pci_phy_instance *instance;
+		struct phy *pphy;
+
+		instance = devm_kzalloc(dev, sizeof(*instance), GFP_KERNEL);
+		if (!instance) {
+			ret = -ENOMEM;
+			goto put_child;
+		}
+
+		phy->phys[port] = instance;
+
+		pphy = devm_phy_create(dev, child_np, &mt7621_pci_phy_ops);
+		if (IS_ERR(phy)) {
+			dev_err(dev, "failed to create phy\n");
+			ret = PTR_ERR(phy);
+			goto put_child;
+		}
+
+		instance->port_base = port_base;
+		instance->phy = pphy;
+		instance->index = port;
+		phy_set_drvdata(pphy, instance);
+		port++;
+	}
+
+	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(provider);
+
+put_child:
+	of_node_put(child_np);
+	return ret;
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

