Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD4FC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C0B20C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406397AbfHIJdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:33:44 -0400
Received: from shell.v3.sk ([90.176.6.54]:52041 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406380AbfHIJdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:33:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7CA34D63D0;
        Fri,  9 Aug 2019 11:33:38 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id evecGG5r_WCy; Fri,  9 Aug 2019 11:33:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5379ED63C2;
        Fri,  9 Aug 2019 11:32:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vGIn_ZKDOKCK; Fri,  9 Aug 2019 11:32:30 +0200 (CEST)
Received: from furthur.local (ip-37-188-137-236.eurotel.cz [37.188.137.236])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 0CF0AD63B1;
        Fri,  9 Aug 2019 11:32:25 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 18/19] phy: phy-mmp3-usb: add a new driver
Date:   Fri,  9 Aug 2019 11:31:57 +0200
Message-Id: <20190809093158.7969-19-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190809093158.7969-1-lkundrak@v3.sk>
References: <20190809093158.7969-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the USB2 PHY as found on the Marvell MMP3 SoC. Based on Marvell G=
PL
release.

While at that, also add a MAINTAINERS entry including the other MMP PHY
driver.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 MAINTAINERS                        |   7 +
 drivers/phy/marvell/Kconfig        |  11 ++
 drivers/phy/marvell/Makefile       |   1 +
 drivers/phy/marvell/phy-mmp3-usb.c | 291 +++++++++++++++++++++++++++++
 4 files changed, 310 insertions(+)
 create mode 100644 drivers/phy/marvell/phy-mmp3-usb.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fb2ceb265a8c3..fb7e8edfc3d66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10790,6 +10790,13 @@ F:	arch/arm/boot/dts/mmp*
 F:	arch/arm/mach-mmp/
 F:	linux/soc/mmp/
=20
+MMP USB PHY DRIVERS
+R:	Lubomir Rintel <lkundrak@v3.sk>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/phy/marvell/phy-mmp3-usb.c
+F:	drivers/phy/marvell/phy-pxa-usb.c
+
 MMU GATHER AND TLB INVALIDATION
 M:	Will Deacon <will@kernel.org>
 M:	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
diff --git a/drivers/phy/marvell/Kconfig b/drivers/phy/marvell/Kconfig
index 0e1642419c0bf..d33ef35b3e51b 100644
--- a/drivers/phy/marvell/Kconfig
+++ b/drivers/phy/marvell/Kconfig
@@ -102,3 +102,14 @@ config PHY_PXA_USB
 	  The PHY driver will be used by Marvell udc/ehci/otg driver.
=20
 	  To compile this driver as a module, choose M here.
+
+config PHY_MMP3_USB
+	tristate "Marvell MMP3 USB PHY Driver"
+	depends on MACH_MMP3_DT || COMPILE_TEST
+	select GENERIC_PHY
+	help
+	  Enable this to support Marvell MMP3 USB PHY driver for Marvell
+	  SoC. This driver will do the PHY initialization and shutdown.
+	  The PHY driver will be used by Marvell udc/ehci/otg driver.
+
+	  To compile this driver as a module, choose M here.
diff --git a/drivers/phy/marvell/Makefile b/drivers/phy/marvell/Makefile
index 434eb9ca6cc3f..5a106b1549f41 100644
--- a/drivers/phy/marvell/Makefile
+++ b/drivers/phy/marvell/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+=3D phy-armada375-usb2.o
 obj-$(CONFIG_PHY_BERLIN_SATA)		+=3D phy-berlin-sata.o
 obj-$(CONFIG_PHY_BERLIN_USB)		+=3D phy-berlin-usb.o
+obj-$(CONFIG_PHY_MMP3_USB)		+=3D phy-mmp3-usb.o
 obj-$(CONFIG_PHY_MVEBU_A3700_COMPHY)	+=3D phy-mvebu-a3700-comphy.o
 obj-$(CONFIG_PHY_MVEBU_A3700_UTMI)	+=3D phy-mvebu-a3700-utmi.o
 obj-$(CONFIG_PHY_MVEBU_A38X_COMPHY)	+=3D phy-armada38x-comphy.o
diff --git a/drivers/phy/marvell/phy-mmp3-usb.c b/drivers/phy/marvell/phy=
-mmp3-usb.c
new file mode 100644
index 0000000000000..499869595a582
--- /dev/null
+++ b/drivers/phy/marvell/phy-mmp3-usb.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2011 Marvell International Ltd. All rights reserved.
+ * Copyright (C) 2018,2019 Lubomir Rintel <lkundrak@v3.sk>
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/soc/mmp/cputype.h>
+
+#define USB2_PLL_REG0		0x4
+#define USB2_PLL_REG1		0x8
+#define USB2_TX_REG0		0x10
+#define USB2_TX_REG1		0x14
+#define USB2_TX_REG2		0x18
+#define USB2_RX_REG0		0x20
+#define USB2_RX_REG1		0x24
+#define USB2_RX_REG2		0x28
+#define USB2_ANA_REG0		0x30
+#define USB2_ANA_REG1		0x34
+#define USB2_ANA_REG2		0x38
+#define USB2_DIG_REG0		0x3C
+#define USB2_DIG_REG1		0x40
+#define USB2_DIG_REG2		0x44
+#define USB2_DIG_REG3		0x48
+#define USB2_TEST_REG0		0x4C
+#define USB2_TEST_REG1		0x50
+#define USB2_TEST_REG2		0x54
+#define USB2_CHARGER_REG0	0x58
+#define USB2_OTG_REG0		0x5C
+#define USB2_PHY_MON0		0x60
+#define USB2_RESETVE_REG0	0x64
+#define USB2_ICID_REG0		0x78
+#define USB2_ICID_REG1		0x7C
+
+/* USB2_PLL_REG0 */
+
+/* This is for Ax stepping */
+#define USB2_PLL_FBDIV_SHIFT_MMP3		0
+#define USB2_PLL_FBDIV_MASK_MMP3		(0xFF << 0)
+
+#define USB2_PLL_REFDIV_SHIFT_MMP3		8
+#define USB2_PLL_REFDIV_MASK_MMP3		(0xF << 8)
+
+#define USB2_PLL_VDD12_SHIFT_MMP3		12
+#define USB2_PLL_VDD18_SHIFT_MMP3		14
+
+/* This is for B0 stepping */
+#define USB2_PLL_FBDIV_SHIFT_MMP3_B0		0
+#define USB2_PLL_REFDIV_SHIFT_MMP3_B0		9
+#define USB2_PLL_VDD18_SHIFT_MMP3_B0		14
+#define USB2_PLL_FBDIV_MASK_MMP3_B0		0x01FF
+#define USB2_PLL_REFDIV_MASK_MMP3_B0		0x3E00
+
+#define USB2_PLL_CAL12_SHIFT_MMP3		0
+#define USB2_PLL_CALI12_MASK_MMP3		(0x3 << 0)
+
+#define USB2_PLL_VCOCAL_START_SHIFT_MMP3	2
+
+#define USB2_PLL_KVCO_SHIFT_MMP3		4
+#define USB2_PLL_KVCO_MASK_MMP3			(0x7<<4)
+
+#define USB2_PLL_ICP_SHIFT_MMP3			8
+#define USB2_PLL_ICP_MASK_MMP3			(0x7<<8)
+
+#define USB2_PLL_LOCK_BYPASS_SHIFT_MMP3		12
+
+#define USB2_PLL_PU_PLL_SHIFT_MMP3		13
+#define USB2_PLL_PU_PLL_MASK			(0x1 << 13)
+
+#define USB2_PLL_READY_MASK_MMP3		(0x1 << 15)
+
+/* USB2_TX_REG0 */
+#define USB2_TX_IMPCAL_VTH_SHIFT_MMP3		8
+#define USB2_TX_IMPCAL_VTH_MASK_MMP3		(0x7 << 8)
+
+#define USB2_TX_RCAL_START_SHIFT_MMP3		13
+
+/* USB2_TX_REG1 */
+#define USB2_TX_CK60_PHSEL_SHIFT_MMP3		0
+#define USB2_TX_CK60_PHSEL_MASK_MMP3		(0xf << 0)
+
+#define USB2_TX_AMP_SHIFT_MMP3			4
+#define USB2_TX_AMP_MASK_MMP3			(0x7 << 4)
+
+#define USB2_TX_VDD12_SHIFT_MMP3		8
+#define USB2_TX_VDD12_MASK_MMP3			(0x3 << 8)
+
+/* USB2_TX_REG2 */
+#define USB2_TX_DRV_SLEWRATE_SHIFT		10
+
+/* USB2_RX_REG0 */
+#define USB2_RX_SQ_THRESH_SHIFT_MMP3		4
+#define USB2_RX_SQ_THRESH_MASK_MMP3		(0xf << 4)
+
+#define USB2_RX_SQ_LENGTH_SHIFT_MMP3		10
+#define USB2_RX_SQ_LENGTH_MASK_MMP3		(0x3 << 10)
+
+/* USB2_ANA_REG1*/
+#define USB2_ANA_PU_ANA_SHIFT_MMP3		14
+
+/* USB2_OTG_REG0 */
+#define USB2_OTG_PU_OTG_SHIFT_MMP3		3
+
+struct mmp3_usb_phy {
+	struct phy *phy;
+	void __iomem *base;
+};
+
+static unsigned int u2o_get(void __iomem *base, unsigned int offset)
+{
+	return readl_relaxed(base + offset);
+}
+
+static void u2o_set(void __iomem *base, unsigned int offset,
+		unsigned int value)
+{
+	u32 reg;
+
+	reg =3D readl_relaxed(base + offset);
+	reg |=3D value;
+	writel_relaxed(reg, base + offset);
+	readl_relaxed(base + offset);
+}
+
+static void u2o_clear(void __iomem *base, unsigned int offset,
+		unsigned int value)
+{
+	u32 reg;
+
+	reg =3D readl_relaxed(base + offset);
+	reg &=3D ~value;
+	writel_relaxed(reg, base + offset);
+	readl_relaxed(base + offset);
+}
+
+static int mmp3_usb_phy_init(struct phy *phy)
+{
+	struct mmp3_usb_phy *mmp3_usb_phy =3D phy_get_drvdata(phy);
+	void __iomem *base =3D mmp3_usb_phy->base;
+
+	if (cpu_is_mmp3_a0()) {
+		u2o_clear(base, USB2_PLL_REG0, (USB2_PLL_FBDIV_MASK_MMP3
+			| USB2_PLL_REFDIV_MASK_MMP3));
+		u2o_set(base, USB2_PLL_REG0,
+			0xd << USB2_PLL_REFDIV_SHIFT_MMP3
+			| 0xf0 << USB2_PLL_FBDIV_SHIFT_MMP3);
+	} else if (cpu_is_mmp3_b0()) {
+		u2o_clear(base, USB2_PLL_REG0, USB2_PLL_REFDIV_MASK_MMP3_B0
+			| USB2_PLL_FBDIV_MASK_MMP3_B0);
+		u2o_set(base, USB2_PLL_REG0,
+			0xd << USB2_PLL_REFDIV_SHIFT_MMP3_B0
+			| 0xf0 << USB2_PLL_FBDIV_SHIFT_MMP3_B0);
+	} else {
+		dev_err(&phy->dev, "unsupported silicon revision\n");
+		return -ENODEV;
+	}
+
+	u2o_clear(base, USB2_PLL_REG1, USB2_PLL_PU_PLL_MASK
+		| USB2_PLL_ICP_MASK_MMP3
+		| USB2_PLL_KVCO_MASK_MMP3
+		| USB2_PLL_CALI12_MASK_MMP3);
+	u2o_set(base, USB2_PLL_REG1, 1 << USB2_PLL_PU_PLL_SHIFT_MMP3
+		| 1 << USB2_PLL_LOCK_BYPASS_SHIFT_MMP3
+		| 3 << USB2_PLL_ICP_SHIFT_MMP3
+		| 3 << USB2_PLL_KVCO_SHIFT_MMP3
+		| 3 << USB2_PLL_CAL12_SHIFT_MMP3);
+
+	u2o_clear(base, USB2_TX_REG0, USB2_TX_IMPCAL_VTH_MASK_MMP3);
+	u2o_set(base, USB2_TX_REG0, 2 << USB2_TX_IMPCAL_VTH_SHIFT_MMP3);
+
+	u2o_clear(base, USB2_TX_REG1, USB2_TX_VDD12_MASK_MMP3
+		| USB2_TX_AMP_MASK_MMP3
+		| USB2_TX_CK60_PHSEL_MASK_MMP3);
+	u2o_set(base, USB2_TX_REG1, 3 << USB2_TX_VDD12_SHIFT_MMP3
+		| 4 << USB2_TX_AMP_SHIFT_MMP3
+		| 4 << USB2_TX_CK60_PHSEL_SHIFT_MMP3);
+
+	u2o_clear(base, USB2_TX_REG2, 3 << USB2_TX_DRV_SLEWRATE_SHIFT);
+	u2o_set(base, USB2_TX_REG2, 2 << USB2_TX_DRV_SLEWRATE_SHIFT);
+
+	u2o_clear(base, USB2_RX_REG0, USB2_RX_SQ_THRESH_MASK_MMP3);
+	u2o_set(base, USB2_RX_REG0, 0xa << USB2_RX_SQ_THRESH_SHIFT_MMP3);
+
+	u2o_set(base, USB2_ANA_REG1, 0x1 << USB2_ANA_PU_ANA_SHIFT_MMP3);
+
+	u2o_set(base, USB2_OTG_REG0, 0x1 << USB2_OTG_PU_OTG_SHIFT_MMP3);
+
+	return 0;
+}
+
+static int mmp3_usb_phy_calibrate(struct phy *phy)
+{
+	struct mmp3_usb_phy *mmp3_usb_phy =3D phy_get_drvdata(phy);
+	void __iomem *base =3D mmp3_usb_phy->base;
+	int loops;
+
+	/*
+	 * PLL VCO and TX Impedance Calibration Timing:
+	 *
+	 *                _____________________________________
+	 * PU  __________|
+	 *                        _____________________________
+	 * VCOCAL START _________|
+	 *                                 ___
+	 * REG_RCAL_START ________________|   |________|_______
+	 *               | 200us | 400us  | 40| 400us  | USB PHY READY
+	 */
+
+	udelay(200);
+	u2o_set(base, USB2_PLL_REG1, 1 << USB2_PLL_VCOCAL_START_SHIFT_MMP3);
+	udelay(400);
+	u2o_set(base, USB2_TX_REG0, 1 << USB2_TX_RCAL_START_SHIFT_MMP3);
+	udelay(40);
+	u2o_clear(base, USB2_TX_REG0, 1 << USB2_TX_RCAL_START_SHIFT_MMP3);
+	udelay(400);
+
+	loops =3D 0;
+	while ((u2o_get(base, USB2_PLL_REG1) & USB2_PLL_READY_MASK_MMP3) =3D=3D=
 0) {
+		mdelay(1);
+		loops++;
+		if (loops > 100) {
+			dev_err(&phy->dev, "PLL_READY not set after 100mS.\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
+static const struct phy_ops mmp3_usb_phy_ops =3D {
+	.init		=3D mmp3_usb_phy_init,
+	.calibrate	=3D mmp3_usb_phy_calibrate,
+	.owner		=3D THIS_MODULE,
+};
+
+static const struct of_device_id mmp3_usb_phy_of_match[] =3D {
+	{ .compatible =3D "marvell,mmp3-usb-phy", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mmp3_usb_phy_of_match);
+
+static int mmp3_usb_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct resource *resource;
+	struct mmp3_usb_phy *mmp3_usb_phy;
+	struct phy_provider *provider;
+
+	mmp3_usb_phy =3D devm_kzalloc(dev, sizeof(*mmp3_usb_phy), GFP_KERNEL);
+	if (!mmp3_usb_phy)
+		return -ENOMEM;
+
+	resource =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mmp3_usb_phy->base =3D devm_ioremap_resource(dev, resource);
+	if (IS_ERR(mmp3_usb_phy->base)) {
+		dev_err(dev, "failed to remap PHY regs\n");
+		return PTR_ERR(mmp3_usb_phy->base);
+	}
+
+	mmp3_usb_phy->phy =3D devm_phy_create(dev, NULL, &mmp3_usb_phy_ops);
+	if (IS_ERR(mmp3_usb_phy->phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(mmp3_usb_phy->phy);
+	}
+
+	phy_set_drvdata(mmp3_usb_phy->phy, mmp3_usb_phy);
+	provider =3D devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(provider)) {
+		dev_err(dev, "failed to register PHY provider\n");
+		return PTR_ERR(provider);
+	}
+
+	return 0;
+}
+
+static struct platform_driver mmp3_usb_phy_driver =3D {
+	.probe		=3D mmp3_usb_phy_probe,
+	.driver		=3D {
+		.name	=3D "mmp3-usb-phy",
+		.of_match_table =3D mmp3_usb_phy_of_match,
+	},
+};
+module_platform_driver(mmp3_usb_phy_driver);
+
+MODULE_AUTHOR("Lubomir Rintel <lkundrak@v3.sk>");
+MODULE_DESCRIPTION("Marvell MMP3 USB PHY Driver");
+MODULE_LICENSE("GPL v2");
--=20
2.21.0

