Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9808C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32312085B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6HutluT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgACSTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 13:19:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40120 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgACSTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:19:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so23749313pgt.7;
        Fri, 03 Jan 2020 10:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g4SJzDeAiKHJzJxuff7StrkFP6od95d34F4PhfMvlu8=;
        b=i6HutluTc3Rt4qVFCwWYjeCp59D6lDpDCFXg+40pCrbikWivvdovTYc5CL7kCi3mgb
         oJoVrH4DTR0trFwyr/ghqp+8Y99xifbHXBwdhNKZ2ohoYnq4ZwIEz+XN6IFKsyp73qu7
         8WEHZ7awId4dx2On37d2KvrkP0IWoHD5mZ+t6dSwNEkJagWsZODiuT8PZ5I9BNrdyOYX
         O1rhh4hVq0x5w4dAsd6BkfYqRFXdNruDwNo4iODOCS2NYlg40jM9m8EnwcZtkOndGy+x
         w7CpII/lQwUCh37jLEc6sngxUuCS9HzezWutfFjzLKdIoB7JChU2n46kC93yqMET9njK
         qPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g4SJzDeAiKHJzJxuff7StrkFP6od95d34F4PhfMvlu8=;
        b=pB3t5l7mdFK5RQK++YEJqYmL21AHdxQSF9PNTvorB7pqqZk7gmEe+pJGSKCP0WlFsL
         wFnHPta+KC4tEH1lZbHxZdLrQ7Rz9BLd62RvgQzxDR1R5Tmmr0Kx4EO85KyIAPKJO07s
         EAC391uUAhVBowVonertG4Bw7/j8AoFkf5NeQeaj3LokuMWpiVtOJKP3CeDLB8+3wJVV
         h8uu5HIU+iqmf7ByHSAtwpmJKnoeKOrw+6sy+MByC9haLygIgUWB9BbZjQ9dKfrICAox
         FR/bMt7TR9Y6ry6YgOc3Mj7FD2qI5txd1OoNg6FtcHCfUFqCYzVA6F2GgsCTD/f88Q4p
         8xZw==
X-Gm-Message-State: APjAAAU8pyV11unBqH1ZDQ3Q17NIr17PHqwLWO6jOQqxAkLqKbuvRBGt
        n7RN/anar10KtyaeqjBypMZMn8Vq
X-Google-Smtp-Source: APXvYqx6F1vyUT+igNQ82HueookGHvS/6z4jF6kHWSOlu9E7GrfFoOXZVtfWqrRkWUL0SXY1lhWX3A==
X-Received: by 2002:a63:6b8a:: with SMTP id g132mr96479080pgc.127.1578075574918;
        Fri, 03 Jan 2020 10:19:34 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j8sm41783602pfe.182.2020.01.03.10.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 10:19:34 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Srinath Mannam <srinath.mannam@broadcom.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH v4 07/13] phy: usb: Add support for new Synopsys USB controller on the 7216
Date:   Fri,  3 Jan 2020 13:18:05 -0500
Message-Id: <20200103181811.22939-8-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103181811.22939-1-alcooperx@gmail.com>
References: <20200103181811.22939-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 7216 has the new USB XHCI controller from Synopsys. While
this new controller and the PHY are similar to the STB versions,
the major differences are:

- Many of the registers and fields in the CTRL block have been
  removed or changed.
- A new set of Synopsys control registers, BCHP_USB_XHCI_GBL, were
  added.
- MDIO functionality has been replaced with direct access registers
  in the BCHP_USB_XHCI_GBL block.
- Power up PHY defaults that had to be changed by MDIO in previous
  chips will now power up with the correct defaults.

A new init module was created for this new Synopsys USB controller.
A new compatible string was added and the driver will dispatch
into one of two init modules based on it. A "reg-names" field was
added so the driver can more easily get optional registers.
A DT bindings document was also added for this driver.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/phy/broadcom/Makefile                 |   2 +-
 .../phy/broadcom/phy-brcm-usb-init-synopsys.c | 171 ++++++++++++++++++
 drivers/phy/broadcom/phy-brcm-usb-init.h      |   2 +
 drivers/phy/broadcom/phy-brcm-usb.c           |  70 +++++--
 4 files changed, 227 insertions(+), 18 deletions(-)
 create mode 100644 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c

diff --git a/drivers/phy/broadcom/Makefile b/drivers/phy/broadcom/Makefile
index f453c7d3ffff..c78de546135c 100644
--- a/drivers/phy/broadcom/Makefile
+++ b/drivers/phy/broadcom/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_PHY_NS2_USB_DRD)		+= phy-bcm-ns2-usbdrd.o
 obj-$(CONFIG_PHY_BRCM_SATA)		+= phy-brcm-sata.o
 obj-$(CONFIG_PHY_BRCM_USB)		+= phy-brcm-usb-dvr.o
 
-phy-brcm-usb-dvr-objs := phy-brcm-usb.o phy-brcm-usb-init.o
+phy-brcm-usb-dvr-objs := phy-brcm-usb.o phy-brcm-usb-init.o phy-brcm-usb-init-synopsys.o
 
 obj-$(CONFIG_PHY_BCM_SR_PCIE)		+= phy-bcm-sr-pcie.o
 obj-$(CONFIG_PHY_BCM_SR_USB)		+= phy-bcm-sr-usb.o
diff --git a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
new file mode 100644
index 000000000000..0bd9ccc43323
--- /dev/null
+++ b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, Broadcom */
+
+/*
+ * This module contains USB PHY initialization for power up and S3 resume
+ * for newer Synopsys based USB hardware first used on the bcm7216.
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+
+#include <linux/soc/brcmstb/brcmstb.h>
+#include "phy-brcm-usb-init.h"
+
+/* Register definitions for the USB CTRL block */
+#define USB_CTRL_SETUP			0x00
+#define   USB_CTRL_SETUP_STRAP_IPP_SEL_MASK		0x02000000
+#define   USB_CTRL_SETUP_SCB2_EN_MASK			0x00008000
+#define   USB_CTRL_SETUP_SCB1_EN_MASK			0x00004000
+#define   USB_CTRL_SETUP_SOFT_SHUTDOWN_MASK		0x00000200
+#define   USB_CTRL_SETUP_IPP_MASK			0x00000020
+#define   USB_CTRL_SETUP_IOC_MASK			0x00000010
+#define USB_CTRL_USB_PM			0x04
+#define   USB_CTRL_USB_PM_USB_PWRDN_MASK		0x80000000
+#define   USB_CTRL_USB_PM_SOFT_RESET_MASK		0x40000000
+#define   USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK		0x00800000
+#define   USB_CTRL_USB_PM_XHC_SOFT_RESETB_MASK		0x00400000
+#define USB_CTRL_USB_PM_STATUS		0x08
+#define USB_CTRL_USB_DEVICE_CTL1	0x10
+#define   USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK	0x00000003
+
+
+static void xhci_soft_reset(struct brcm_usb_init_params *params,
+			int on_off)
+{
+	void __iomem *ctrl = params->ctrl_regs;
+
+	/* Assert reset */
+	if (on_off)
+		USB_CTRL_UNSET(ctrl, USB_PM, XHC_SOFT_RESETB);
+	/* De-assert reset */
+	else
+		USB_CTRL_SET(ctrl, USB_PM, XHC_SOFT_RESETB);
+}
+
+static void usb_init_ipp(struct brcm_usb_init_params *params)
+{
+	void __iomem *ctrl = params->ctrl_regs;
+	u32 reg;
+	u32 orig_reg;
+
+	pr_debug("%s\n", __func__);
+
+	orig_reg = reg = brcm_usb_readl(USB_CTRL_REG(ctrl, SETUP));
+	if (params->ipp != 2)
+		/* override ipp strap pin (if it exits) */
+		reg &= ~(USB_CTRL_MASK(SETUP, STRAP_IPP_SEL));
+
+	/* Override the default OC and PP polarity */
+	reg &= ~(USB_CTRL_MASK(SETUP, IPP) | USB_CTRL_MASK(SETUP, IOC));
+	if (params->ioc)
+		reg |= USB_CTRL_MASK(SETUP, IOC);
+	if (params->ipp == 1)
+		reg |= USB_CTRL_MASK(SETUP, IPP);
+	brcm_usb_writel(reg, USB_CTRL_REG(ctrl, SETUP));
+
+	/*
+	 * If we're changing IPP, make sure power is off long enough
+	 * to turn off any connected devices.
+	 */
+	if ((reg ^ orig_reg) & USB_CTRL_MASK(SETUP, IPP))
+		msleep(50);
+}
+
+static void usb_init_common(struct brcm_usb_init_params *params)
+{
+	u32 reg;
+	void __iomem *ctrl = params->ctrl_regs;
+
+	pr_debug("%s\n", __func__);
+
+	USB_CTRL_UNSET(ctrl, USB_PM, USB_PWRDN);
+	/* 1 millisecond - for USB clocks to settle down */
+	usleep_range(1000, 2000);
+
+	if (USB_CTRL_MASK(USB_DEVICE_CTL1, PORT_MODE)) {
+		reg = brcm_usb_readl(USB_CTRL_REG(ctrl, USB_DEVICE_CTL1));
+		reg &= ~USB_CTRL_MASK(USB_DEVICE_CTL1, PORT_MODE);
+		reg |= params->mode;
+		brcm_usb_writel(reg, USB_CTRL_REG(ctrl, USB_DEVICE_CTL1));
+	}
+	switch (params->mode) {
+	case USB_CTLR_MODE_HOST:
+		USB_CTRL_UNSET(ctrl, USB_PM, BDC_SOFT_RESETB);
+		break;
+	default:
+		USB_CTRL_UNSET(ctrl, USB_PM, BDC_SOFT_RESETB);
+		USB_CTRL_SET(ctrl, USB_PM, BDC_SOFT_RESETB);
+		break;
+	}
+}
+
+static void usb_init_xhci(struct brcm_usb_init_params *params)
+{
+	pr_debug("%s\n", __func__);
+
+	xhci_soft_reset(params, 0);
+}
+
+static void usb_uninit_common(struct brcm_usb_init_params *params)
+{
+	void __iomem *ctrl = params->ctrl_regs;
+
+	pr_debug("%s\n", __func__);
+
+	USB_CTRL_SET(ctrl, USB_PM, USB_PWRDN);
+
+}
+
+static void usb_uninit_xhci(struct brcm_usb_init_params *params)
+{
+
+	pr_debug("%s\n", __func__);
+
+	xhci_soft_reset(params, 1);
+}
+
+static int usb_get_dual_select(struct brcm_usb_init_params *params)
+{
+	void __iomem *ctrl = params->ctrl_regs;
+	u32 reg = 0;
+
+	pr_debug("%s\n", __func__);
+
+	reg = brcm_usb_readl(USB_CTRL_REG(ctrl, USB_DEVICE_CTL1));
+	reg &= USB_CTRL_MASK(USB_DEVICE_CTL1, PORT_MODE);
+	return reg;
+}
+
+static void usb_set_dual_select(struct brcm_usb_init_params *params, int mode)
+{
+	void __iomem *ctrl = params->ctrl_regs;
+	u32 reg;
+
+	pr_debug("%s\n", __func__);
+
+	reg = brcm_usb_readl(USB_CTRL_REG(ctrl, USB_DEVICE_CTL1));
+	reg &= ~USB_CTRL_MASK(USB_DEVICE_CTL1, PORT_MODE);
+	reg |= mode;
+	brcm_usb_writel(reg, USB_CTRL_REG(ctrl, USB_DEVICE_CTL1));
+}
+
+
+static const struct brcm_usb_init_ops bcm7216_ops = {
+	.init_ipp = usb_init_ipp,
+	.init_common = usb_init_common,
+	.init_xhci = usb_init_xhci,
+	.uninit_common = usb_uninit_common,
+	.uninit_xhci = usb_uninit_xhci,
+	.get_dual_select = usb_get_dual_select,
+	.set_dual_select = usb_set_dual_select,
+};
+
+void brcm_usb_dvr_init_7216(struct brcm_usb_init_params *params)
+{
+
+	pr_debug("%s\n", __func__);
+
+	params->family_name = "7216";
+	params->ops = &bcm7216_ops;
+}
diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.h b/drivers/phy/broadcom/phy-brcm-usb-init.h
index 7701872d1136..db6851c55335 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.h
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.h
@@ -43,6 +43,7 @@ struct brcm_usb_init_ops {
 struct  brcm_usb_init_params {
 	void __iomem *ctrl_regs;
 	void __iomem *xhci_ec_regs;
+	void __iomem *xhci_gbl_regs;
 	int ioc;
 	int ipp;
 	int mode;
@@ -55,6 +56,7 @@ struct  brcm_usb_init_params {
 };
 
 void brcm_usb_dvr_init_7445(struct brcm_usb_init_params *params);
+void brcm_usb_dvr_init_7216(struct brcm_usb_init_params *params);
 
 static inline u32 brcm_usb_readl(void __iomem *addr)
 {
diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index 9d93c5599511..64379ede480e 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -241,6 +241,15 @@ static const struct attribute_group brcm_usb_phy_group = {
 	.attrs = brcm_usb_phy_attrs,
 };
 
+static const struct of_device_id brcm_usb_dt_ids[] = {
+	{
+		.compatible = "brcm,bcm7216-usb-phy",
+		.data = &brcm_usb_dvr_init_7216,
+	},
+	{ .compatible = "brcm,brcmstb-usb-phy" },
+	{ /* sentinel */ }
+};
+
 static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 				 struct brcm_usb_phy_data *priv,
 				 struct device_node *dn)
@@ -316,13 +325,16 @@ static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 
 static int brcm_usb_phy_probe(struct platform_device *pdev)
 {
-	struct resource *res;
+	struct resource *res_ctrl;
+	struct resource *res_xhciec = NULL;
+	struct resource *res_xhcigbl = NULL;
 	struct device *dev = &pdev->dev;
 	struct brcm_usb_phy_data *priv;
 	struct phy_provider *phy_provider;
 	struct device_node *dn = pdev->dev.of_node;
 	int err;
 	const char *mode;
+	const struct of_device_id *match;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -331,30 +343,59 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
 
 	priv->ini.family_id = brcmstb_get_family_id();
 	priv->ini.product_id = brcmstb_get_product_id();
-	brcm_usb_dvr_init_7445(&priv->ini);
+
+	match = of_match_node(brcm_usb_dt_ids, dev->of_node);
+	if (match && match->data) {
+		void (*dvr_init)(struct brcm_usb_init_params *params);
+
+		dvr_init = match->data;
+		(*dvr_init)(&priv->ini);
+	} else {
+		brcm_usb_dvr_init_7445(&priv->ini);
+	}
+
 	dev_dbg(dev, "Best mapping table is for %s\n",
 		priv->ini.family_name);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "can't get USB_CTRL base address\n");
-		return -EINVAL;
+
+	/* Newer DT node has reg-names. xhci_ec and xhci_gbl are optional. */
+	res_ctrl = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
+	if (res_ctrl != NULL) {
+		res_xhciec = platform_get_resource_byname(pdev,
+							  IORESOURCE_MEM,
+							  "xhci_ec");
+		res_xhcigbl = platform_get_resource_byname(pdev,
+							   IORESOURCE_MEM,
+							   "xhci_gbl");
+	} else {
+		/* Older DT node without reg-names, use index */
+		res_ctrl = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (res_ctrl == NULL) {
+			dev_err(dev, "can't get CTRL base address\n");
+			return -EINVAL;
+		}
+		res_xhciec = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	}
-	priv->ini.ctrl_regs = devm_ioremap_resource(dev, res);
+	priv->ini.ctrl_regs = devm_ioremap_resource(dev, res_ctrl);
 	if (IS_ERR(priv->ini.ctrl_regs)) {
 		dev_err(dev, "can't map CTRL register space\n");
 		return -EINVAL;
 	}
-
-	/* The XHCI EC registers are optional */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (res) {
+	if (res_xhciec) {
 		priv->ini.xhci_ec_regs =
-			devm_ioremap_resource(dev, res);
+			devm_ioremap_resource(dev, res_xhciec);
 		if (IS_ERR(priv->ini.xhci_ec_regs)) {
 			dev_err(dev, "can't map XHCI EC register space\n");
 			return -EINVAL;
 		}
 	}
+	if (res_xhcigbl) {
+		priv->ini.xhci_gbl_regs =
+			devm_ioremap_resource(dev, res_xhcigbl);
+		if (IS_ERR(priv->ini.xhci_gbl_regs)) {
+			dev_err(dev, "can't map XHCI Global register space\n");
+			return -EINVAL;
+		}
+	}
 
 	of_property_read_u32(dn, "brcm,ipp", &priv->ini.ipp);
 	of_property_read_u32(dn, "brcm,ioc", &priv->ini.ioc);
@@ -480,11 +521,6 @@ static const struct dev_pm_ops brcm_usb_phy_pm_ops = {
 	SET_LATE_SYSTEM_SLEEP_PM_OPS(brcm_usb_phy_suspend, brcm_usb_phy_resume)
 };
 
-static const struct of_device_id brcm_usb_dt_ids[] = {
-	{ .compatible = "brcm,brcmstb-usb-phy" },
-	{ /* sentinel */ }
-};
-
 MODULE_DEVICE_TABLE(of, brcm_usb_dt_ids);
 
 static struct platform_driver brcm_usb_driver = {
-- 
2.17.1

