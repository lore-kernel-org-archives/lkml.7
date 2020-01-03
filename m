Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E15C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018622253D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjOmGqBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgACSTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 13:19:41 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34458 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgACSTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:19:38 -0500
Received: by mail-pj1-f66.google.com with SMTP id s94so3025667pjc.1;
        Fri, 03 Jan 2020 10:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yKXEPNcw1X4y6DDRrntoTodf3gJaBmd+hIZJK0z8Umc=;
        b=FjOmGqBEjYpKFelF2tXHE0VsRpS65NZHSyy/kqBxJ4yPiL7HTABTtC9sUmRwMfGCfj
         28qun+nLhWPEA5pXTppYp7AaebsmP9M2XVMTPugtE98ytNOVQMFSeoEpikh9yorDFuNY
         Gi+GsS+ONlUfvEzBD7yEo22KBlk8i5xKY5mn9sfLNdCEl1YRbKfd6ZOo5yTSLalTgFBl
         fvXh8TowTiCchD+n9An2+FxttdbJqj2HJ5N48wGgtm8qPUmFKH63ISvD2HLVkdmLGaQk
         VGJ/VWo+PJh0V9/0VdXxskydzj5SKDW5k6WXzFlPNBWrj6TWEx889feD2is7/rlUlC2+
         MCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yKXEPNcw1X4y6DDRrntoTodf3gJaBmd+hIZJK0z8Umc=;
        b=JUhRKHkFIK2HPCIybwvjK59kWIXqnUuP+SENV9o+qJtaf5j08Y/7rhjbDPB9iAvwJ+
         5AVskzHcCKPbvbI0Z1ZrYQszzobxcFDFatTgIreiGlztIO1CbVTh/Txox8KoMWU0e62Q
         CmRQRPc8frQzvn/FTK5uq6W8n8OrXozSjAHU0KIzy7VI5hcy/SGAf9omPHwp8YLw2jtv
         tpPdjO8BRXacwSORXxawQMHAwjCeDLyeceLSLrgfeCF2WlkRXSl4UYXYEr7xKVOaMhH9
         qnpj1lRkmw/RhT9kLVfqdhz5w4k8yzfDauEkJG22+TdYDHbkpW/qqi3O2qBIf2RIvT4O
         vujA==
X-Gm-Message-State: APjAAAXMkT+WwCUGO1vUC2SQh2RPlNlSzqyGg5XFBX/WdnYPUTp5Tj80
        IrpvO77SEDsWKJEsjg1hHCPlZuf1
X-Google-Smtp-Source: APXvYqx8UyaX7tEmjm78+JEXf3iEbdyGuFlyB/732XwwgMvHTdQDDEXDnJB4VadqnlmRM0PyMq32yA==
X-Received: by 2002:a17:902:44f:: with SMTP id 73mr37252541ple.81.1578075576692;
        Fri, 03 Jan 2020 10:19:36 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j8sm41783602pfe.182.2020.01.03.10.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 10:19:36 -0800 (PST)
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
Subject: [PATCH v4 08/13] phy: usb: Add support for new Synopsys USB controller on the 7211b0
Date:   Fri,  3 Jan 2020 13:18:06 -0500
Message-Id: <20200103181811.22939-9-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103181811.22939-1-alcooperx@gmail.com>
References: <20200103181811.22939-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 7211b0 has added the STB XHCI Synopsys controller and it
will be used instead of the RPi based DWC USB controller. The new
Synopsys XHCI controller core is the same one that is used on the
7216, but because of the way the STB USB PHY is used on both the A0
and B0, some of the PHY control is different.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 .../phy/broadcom/phy-brcm-usb-init-synopsys.c | 163 +++++++++++++++++-
 drivers/phy/broadcom/phy-brcm-usb-init.c      |  31 ++--
 drivers/phy/broadcom/phy-brcm-usb-init.h      |  17 +-
 drivers/phy/broadcom/phy-brcm-usb.c           | 162 +++++++++++------
 4 files changed, 295 insertions(+), 78 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
index 0bd9ccc43323..ee49cbdb55bb 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
@@ -12,10 +12,33 @@
 #include <linux/soc/brcmstb/brcmstb.h>
 #include "phy-brcm-usb-init.h"
 
+#define PHY_LOCK_TIMEOUT_MS 200
+
+/* Register definitions for syscon piarbctl registers */
+#define PIARBCTL_CAM			0x00
+#define PIARBCTL_SPLITTER		0x04
+#define PIARBCTL_MISC			0x08
+#define   PIARBCTL_MISC_SECURE_MASK			0x80000000
+#define   PIARBCTL_MISC_USB_SELECT_MASK			0x40000000
+#define   PIARBCTL_MISC_USB_4G_SDRAM_MASK		0x20000000
+#define   PIARBCTL_MISC_USB_PRIORITY_MASK		0x000f0000
+#define   PIARBCTL_MISC_USB_MEM_PAGE_MASK		0x0000f000
+#define   PIARBCTL_MISC_CAM1_MEM_PAGE_MASK		0x00000f00
+#define   PIARBCTL_MISC_CAM0_MEM_PAGE_MASK		0x000000f0
+#define   PIARBCTL_MISC_SATA_PRIORITY_MASK		0x0000000f
+#define PIARBCTL_USB_M_ASB_CTRL		0x10
+
+#define PIARBCTL_MISC_USB_ONLY_MASK		\
+	(PIARBCTL_MISC_USB_SELECT_MASK |	\
+	 PIARBCTL_MISC_USB_4G_SDRAM_MASK |	\
+	 PIARBCTL_MISC_USB_PRIORITY_MASK |	\
+	 PIARBCTL_MISC_USB_MEM_PAGE_MASK)
+
 /* Register definitions for the USB CTRL block */
 #define USB_CTRL_SETUP			0x00
 #define   USB_CTRL_SETUP_STRAP_IPP_SEL_MASK		0x02000000
 #define   USB_CTRL_SETUP_SCB2_EN_MASK			0x00008000
+#define   USB_CTRL_SETUP_tca_drv_sel_MASK		0x01000000
 #define   USB_CTRL_SETUP_SCB1_EN_MASK			0x00004000
 #define   USB_CTRL_SETUP_SOFT_SHUTDOWN_MASK		0x00000200
 #define   USB_CTRL_SETUP_IPP_MASK			0x00000020
@@ -29,11 +52,73 @@
 #define USB_CTRL_USB_DEVICE_CTL1	0x10
 #define   USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK	0x00000003
 
+/* Register definitions for the USB_PHY block in 7211b0 */
+#define USB_PHY_PLL_LDO_CTL		0x08
+#define   USB_PHY_PLL_LDO_CTL_AFE_CORERDY_MASK		0x00000004
+#define USB_PHY_UTMI_CTL_1		0x04
+#define   USB_PHY_UTMI_CTL_1_PHY_MODE_MASK		0x0000000c
+#define   USB_PHY_UTMI_CTL_1_PHY_MODE_SHIFT		2
+#define USB_PHY_STATUS			0x20
+#define   USB_PHY_STATUS_pll_lock_MASK			0x00000001
+
+/* Register definitions for the MDIO registers in the DWC2 block of
+ * the 7211b0.
+ * NOTE: The PHY's MDIO registers are only accessible through the
+ * legacy DesignWare USB controller even though it's not being used.
+ */
+#define USB_GMDIOCSR	0
+#define USB_GMDIOGEN	4
+
+
+static void usb_mdio_write_7211b0(struct brcm_usb_init_params *params,
+				  uint8_t addr, uint16_t data)
+{
+	void __iomem *usb_mdio = params->regs[BRCM_REGS_USB_MDIO];
+
+	addr &= 0x1f; /* 5-bit address */
+	brcm_usb_writel(0xffffffff, usb_mdio + USB_GMDIOGEN);
+	while (brcm_usb_readl(usb_mdio + USB_GMDIOCSR) & (1<<31))
+		;
+	brcm_usb_writel(0x59020000 | (addr << 18) | data,
+			usb_mdio + USB_GMDIOGEN);
+	while (brcm_usb_readl(usb_mdio + USB_GMDIOCSR) & (1<<31))
+		;
+	brcm_usb_writel(0x00000000, usb_mdio + USB_GMDIOGEN);
+	while (brcm_usb_readl(usb_mdio + USB_GMDIOCSR) & (1<<31))
+		;
+}
+
+static uint16_t __maybe_unused usb_mdio_read_7211b0(
+	struct brcm_usb_init_params *params, uint8_t addr)
+{
+	void __iomem *usb_mdio = params->regs[BRCM_REGS_USB_MDIO];
+
+	addr &= 0x1f; /* 5-bit address */
+	brcm_usb_writel(0xffffffff, usb_mdio + USB_GMDIOGEN);
+	while (brcm_usb_readl(usb_mdio + USB_GMDIOCSR) & (1<<31))
+		;
+	brcm_usb_writel(0x69020000 | (addr << 18), usb_mdio + USB_GMDIOGEN);
+	while (brcm_usb_readl(usb_mdio + USB_GMDIOCSR) & (1<<31))
+		;
+	brcm_usb_writel(0x00000000, usb_mdio + USB_GMDIOGEN);
+	while (brcm_usb_readl(usb_mdio + USB_GMDIOCSR) & (1<<31))
+		;
+	return brcm_usb_readl(usb_mdio + USB_GMDIOCSR) & 0xffff;
+}
+
+static void usb2_eye_fix_7211b0(struct brcm_usb_init_params *params)
+{
+	/* select bank */
+	usb_mdio_write_7211b0(params, 0x1f, 0x80a0);
+
+	/* Set the eye */
+	usb_mdio_write_7211b0(params, 0x0a, 0xc6a0);
+}
 
 static void xhci_soft_reset(struct brcm_usb_init_params *params,
 			int on_off)
 {
-	void __iomem *ctrl = params->ctrl_regs;
+	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
 
 	/* Assert reset */
 	if (on_off)
@@ -45,7 +130,7 @@ static void xhci_soft_reset(struct brcm_usb_init_params *params,
 
 static void usb_init_ipp(struct brcm_usb_init_params *params)
 {
-	void __iomem *ctrl = params->ctrl_regs;
+	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
 	u32 reg;
 	u32 orig_reg;
 
@@ -72,10 +157,18 @@ static void usb_init_ipp(struct brcm_usb_init_params *params)
 		msleep(50);
 }
 
+static void syscon_piarbctl_init(struct regmap *rmap)
+{
+	/* Switch from legacy USB OTG controller to new STB USB controller */
+	regmap_update_bits(rmap, PIARBCTL_MISC, PIARBCTL_MISC_USB_ONLY_MASK,
+			   PIARBCTL_MISC_USB_SELECT_MASK |
+			   PIARBCTL_MISC_USB_4G_SDRAM_MASK);
+}
+
 static void usb_init_common(struct brcm_usb_init_params *params)
 {
 	u32 reg;
-	void __iomem *ctrl = params->ctrl_regs;
+	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
 
 	pr_debug("%s\n", __func__);
 
@@ -100,6 +193,45 @@ static void usb_init_common(struct brcm_usb_init_params *params)
 	}
 }
 
+static void usb_init_common_7211b0(struct brcm_usb_init_params *params)
+{
+	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
+	void __iomem *usb_phy = params->regs[BRCM_REGS_USB_PHY];
+	int timeout_ms = PHY_LOCK_TIMEOUT_MS;
+	u32 reg;
+
+	if (params->syscon_piarbctl)
+		syscon_piarbctl_init(params->syscon_piarbctl);
+
+	/* Init the PHY */
+	reg = brcm_usb_readl(usb_phy + USB_PHY_PLL_LDO_CTL);
+	reg |= USB_PHY_PLL_LDO_CTL_AFE_CORERDY_MASK;
+	brcm_usb_writel(reg, usb_phy + USB_PHY_PLL_LDO_CTL);
+
+	/* wait for lock */
+	while (timeout_ms-- > 0) {
+		reg = brcm_usb_readl(usb_phy + USB_PHY_STATUS);
+		if (reg & USB_PHY_STATUS_pll_lock_MASK)
+			break;
+		usleep_range(1000, 2000);
+	}
+
+	/* Set the PHY_MODE */
+	reg = brcm_usb_readl(usb_phy + USB_PHY_UTMI_CTL_1);
+	reg &= ~USB_PHY_UTMI_CTL_1_PHY_MODE_MASK;
+	reg |= params->mode << USB_PHY_UTMI_CTL_1_PHY_MODE_SHIFT;
+	brcm_usb_writel(reg, usb_phy + USB_PHY_UTMI_CTL_1);
+
+	/* Fix the incorrect default */
+	reg = brcm_usb_readl(ctrl + USB_CTRL_SETUP);
+	reg &= ~USB_CTRL_SETUP_tca_drv_sel_MASK;
+	brcm_usb_writel(reg, ctrl + USB_CTRL_SETUP);
+
+	usb_init_common(params);
+
+	usb2_eye_fix_7211b0(params);
+}
+
 static void usb_init_xhci(struct brcm_usb_init_params *params)
 {
 	pr_debug("%s\n", __func__);
@@ -109,7 +241,7 @@ static void usb_init_xhci(struct brcm_usb_init_params *params)
 
 static void usb_uninit_common(struct brcm_usb_init_params *params)
 {
-	void __iomem *ctrl = params->ctrl_regs;
+	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
 
 	pr_debug("%s\n", __func__);
 
@@ -127,7 +259,7 @@ static void usb_uninit_xhci(struct brcm_usb_init_params *params)
 
 static int usb_get_dual_select(struct brcm_usb_init_params *params)
 {
-	void __iomem *ctrl = params->ctrl_regs;
+	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
 	u32 reg = 0;
 
 	pr_debug("%s\n", __func__);
@@ -139,7 +271,7 @@ static int usb_get_dual_select(struct brcm_usb_init_params *params)
 
 static void usb_set_dual_select(struct brcm_usb_init_params *params, int mode)
 {
-	void __iomem *ctrl = params->ctrl_regs;
+	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
 	u32 reg;
 
 	pr_debug("%s\n", __func__);
@@ -161,6 +293,16 @@ static const struct brcm_usb_init_ops bcm7216_ops = {
 	.set_dual_select = usb_set_dual_select,
 };
 
+static const struct brcm_usb_init_ops bcm7211b0_ops = {
+	.init_ipp = usb_init_ipp,
+	.init_common = usb_init_common_7211b0,
+	.init_xhci = usb_init_xhci,
+	.uninit_common = usb_uninit_common,
+	.uninit_xhci = usb_uninit_xhci,
+	.get_dual_select = usb_get_dual_select,
+	.set_dual_select = usb_set_dual_select,
+};
+
 void brcm_usb_dvr_init_7216(struct brcm_usb_init_params *params)
 {
 
@@ -169,3 +311,12 @@ void brcm_usb_dvr_init_7216(struct brcm_usb_init_params *params)
 	params->family_name = "7216";
 	params->ops = &bcm7216_ops;
 }
+
+void brcm_usb_dvr_init_7211b0(struct brcm_usb_init_params *params)
+{
+
+	pr_debug("%s\n", __func__);
+
+	params->family_name = "7211";
+	params->ops = &bcm7211b0_ops;
+}
diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.c b/drivers/phy/broadcom/phy-brcm-usb-init.c
index 80d6f54d276e..17acc3c1051b 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
@@ -401,7 +401,7 @@ void usb_ctrl_unset_family(struct brcm_usb_init_params *params,
 	u32 mask;
 
 	mask = params->usb_reg_bits_map[field];
-	brcm_usb_ctrl_unset(params->ctrl_regs + reg_offset, mask);
+	brcm_usb_ctrl_unset(params->regs[BRCM_REGS_CTRL] + reg_offset, mask);
 };
 
 static inline
@@ -411,7 +411,7 @@ void usb_ctrl_set_family(struct brcm_usb_init_params *params,
 	u32 mask;
 
 	mask = params->usb_reg_bits_map[field];
-	brcm_usb_ctrl_set(params->ctrl_regs + reg_offset, mask);
+	brcm_usb_ctrl_set(params->regs[BRCM_REGS_CTRL] + reg_offset, mask);
 };
 
 static u32 brcmusb_usb_mdio_read(void __iomem *ctrl_base, u32 reg, int mode)
@@ -544,7 +544,7 @@ static void brcmusb_usb3_pll_54mhz(struct brcm_usb_init_params *params)
 {
 	u32 ofs;
 	int ii;
-	void __iomem *ctrl_base = params->ctrl_regs;
+	void __iomem *ctrl_base = params->regs[BRCM_REGS_CTRL];
 
 	/*
 	 * On newer B53 based SoC's, the reference clock for the
@@ -625,7 +625,7 @@ static void brcmusb_usb3_ssc_enable(void __iomem *ctrl_base)
 
 static void brcmusb_usb3_phy_workarounds(struct brcm_usb_init_params *params)
 {
-	void __iomem *ctrl_base = params->ctrl_regs;
+	void __iomem *ctrl_base = params->regs[BRCM_REGS_CTRL];
 
 	brcmusb_usb3_pll_fix(ctrl_base);
 	brcmusb_usb3_pll_54mhz(params);
@@ -667,7 +667,7 @@ static void brcmusb_memc_fix(struct brcm_usb_init_params *params)
 
 static void brcmusb_usb3_otp_fix(struct brcm_usb_init_params *params)
 {
-	void __iomem *xhci_ec_base = params->xhci_ec_regs;
+	void __iomem *xhci_ec_base = params->regs[BRCM_REGS_XHCI_EC];
 	u32 val;
 
 	if (params->family_id != 0x74371000 || !xhci_ec_base)
@@ -680,8 +680,8 @@ static void brcmusb_usb3_otp_fix(struct brcm_usb_init_params *params)
 	brcm_usb_writel(val, USB_XHCI_EC_REG(xhci_ec_base, IRADAT));
 
 	/* Reset USB 3.0 PHY for workaround to take effect */
-	USB_CTRL_UNSET(params->ctrl_regs, USB30_CTL1, PHY3_RESETB);
-	USB_CTRL_SET(params->ctrl_regs,	USB30_CTL1, PHY3_RESETB);
+	USB_CTRL_UNSET(params->regs[BRCM_REGS_CTRL], USB30_CTL1, PHY3_RESETB);
+	USB_CTRL_SET(params->regs[BRCM_REGS_CTRL], USB30_CTL1, PHY3_RESETB);
 }
 
 static void brcmusb_xhci_soft_reset(struct brcm_usb_init_params *params,
@@ -740,7 +740,7 @@ static enum brcm_family_type get_family_type(
 
 static void usb_init_ipp(struct brcm_usb_init_params *params)
 {
-	void __iomem *ctrl = params->ctrl_regs;
+	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
 	u32 reg;
 	u32 orig_reg;
 
@@ -786,7 +786,7 @@ static void usb_init_ipp(struct brcm_usb_init_params *params)
 static void usb_init_common(struct brcm_usb_init_params *params)
 {
 	u32 reg;
-	void __iomem *ctrl = params->ctrl_regs;
+	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
 
 	/* Clear any pending wake conditions */
 	reg = brcm_usb_readl(USB_CTRL_REG(ctrl, USB_PM_STATUS));
@@ -866,7 +866,7 @@ static void usb_init_common(struct brcm_usb_init_params *params)
 static void usb_init_eohci(struct brcm_usb_init_params *params)
 {
 	u32 reg;
-	void __iomem *ctrl = params->ctrl_regs;
+	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
 
 	if (USB_CTRL_MASK_FAMILY(params, USB_PM, USB20_HC_RESETB))
 		USB_CTRL_SET_FAMILY(params, USB_PM, USB20_HC_RESETB);
@@ -902,7 +902,7 @@ static void usb_init_eohci(struct brcm_usb_init_params *params)
 
 static void usb_init_xhci(struct brcm_usb_init_params *params)
 {
-	void __iomem *ctrl = params->ctrl_regs;
+	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
 
 	USB_CTRL_UNSET(ctrl, USB30_PCTL, PHY3_IDDQ_OVERRIDE);
 	/* 1 millisecond - for USB clocks to settle down */
@@ -944,12 +944,13 @@ static void usb_uninit_eohci(struct brcm_usb_init_params *params)
 static void usb_uninit_xhci(struct brcm_usb_init_params *params)
 {
 	brcmusb_xhci_soft_reset(params, 1);
-	USB_CTRL_SET(params->ctrl_regs, USB30_PCTL, PHY3_IDDQ_OVERRIDE);
+	USB_CTRL_SET(params->regs[BRCM_REGS_CTRL], USB30_PCTL,
+		     PHY3_IDDQ_OVERRIDE);
 }
 
 static int usb_get_dual_select(struct brcm_usb_init_params *params)
 {
-	void __iomem *ctrl = params->ctrl_regs;
+	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
 	u32 reg = 0;
 
 	pr_debug("%s\n", __func__);
@@ -963,7 +964,7 @@ static int usb_get_dual_select(struct brcm_usb_init_params *params)
 
 static void usb_set_dual_select(struct brcm_usb_init_params *params, int mode)
 {
-	void __iomem *ctrl = params->ctrl_regs;
+	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
 	u32 reg;
 
 	pr_debug("%s\n", __func__);
@@ -980,7 +981,7 @@ static void usb_set_dual_select(struct brcm_usb_init_params *params, int mode)
 static void usb_wake_enable(struct brcm_usb_init_params *params,
 			  int enable)
 {
-	void __iomem *ctrl = params->ctrl_regs;
+	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
 
 	if (enable)
 		USB_CTRL_SET(ctrl, USB_PM, RMTWKUP_EN);
diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.h b/drivers/phy/broadcom/phy-brcm-usb-init.h
index db6851c55335..2ea81daf295e 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.h
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.h
@@ -6,12 +6,21 @@
 #ifndef _USB_BRCM_COMMON_INIT_H
 #define _USB_BRCM_COMMON_INIT_H
 
+#include <linux/regmap.h>
+
 #define USB_CTLR_MODE_HOST 0
 #define USB_CTLR_MODE_DEVICE 1
 #define USB_CTLR_MODE_DRD 2
 #define USB_CTLR_MODE_TYPEC_PD 3
 
-struct  brcm_usb_init_params;
+enum brcmusb_reg_sel {
+	BRCM_REGS_CTRL = 0,
+	BRCM_REGS_XHCI_EC,
+	BRCM_REGS_XHCI_GBL,
+	BRCM_REGS_USB_PHY,
+	BRCM_REGS_USB_MDIO,
+	BRCM_REGS_MAX
+};
 
 #define USB_CTRL_REG(base, reg)	((void __iomem *)base + USB_CTRL_##reg)
 #define USB_XHCI_EC_REG(base, reg) ((void __iomem *)base + USB_XHCI_EC_##reg)
@@ -41,9 +50,7 @@ struct brcm_usb_init_ops {
 };
 
 struct  brcm_usb_init_params {
-	void __iomem *ctrl_regs;
-	void __iomem *xhci_ec_regs;
-	void __iomem *xhci_gbl_regs;
+	void __iomem *regs[BRCM_REGS_MAX];
 	int ioc;
 	int ipp;
 	int mode;
@@ -53,10 +60,12 @@ struct  brcm_usb_init_params {
 	const char *family_name;
 	const u32 *usb_reg_bits_map;
 	const struct brcm_usb_init_ops *ops;
+	struct regmap *syscon_piarbctl;
 };
 
 void brcm_usb_dvr_init_7445(struct brcm_usb_init_params *params);
 void brcm_usb_dvr_init_7216(struct brcm_usb_init_params *params);
+void brcm_usb_dvr_init_7211b0(struct brcm_usb_init_params *params);
 
 static inline u32 brcm_usb_readl(void __iomem *addr)
 {
diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index 64379ede480e..5f7bfa09494d 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/soc/brcmstb/brcmstb.h>
 #include <dt-bindings/phy/phy.h>
+#include <linux/mfd/syscon.h>
 
 #include "phy-brcm-usb-init.h"
 
@@ -32,6 +33,11 @@ struct value_to_name_map {
 	const char *name;
 };
 
+struct match_chip_info {
+	void *init_func;
+	u8 required_regs[BRCM_REGS_MAX + 1];
+};
+
 static struct value_to_name_map brcm_dr_mode_to_name[] = {
 	{ USB_CTLR_MODE_HOST, "host" },
 	{ USB_CTLR_MODE_DEVICE, "peripheral" },
@@ -64,6 +70,10 @@ struct brcm_usb_phy_data {
 	struct brcm_usb_phy	phys[BRCM_USB_PHY_ID_MAX];
 };
 
+static s8 *node_reg_names[BRCM_REGS_MAX] = {
+	"crtl", "xhci_ec", "xhci_gbl", "usb_phy", "usb_mdio"
+};
+
 static irqreturn_t brcm_usb_phy_wake_isr(int irq, void *dev_id)
 {
 	struct phy *gphy = dev_id;
@@ -241,15 +251,86 @@ static const struct attribute_group brcm_usb_phy_group = {
 	.attrs = brcm_usb_phy_attrs,
 };
 
+static struct match_chip_info chip_info_7216 = {
+	.init_func = &brcm_usb_dvr_init_7216,
+	.required_regs = {
+		BRCM_REGS_CTRL,
+		BRCM_REGS_XHCI_EC,
+		BRCM_REGS_XHCI_GBL,
+		-1,
+	},
+};
+
+static struct match_chip_info chip_info_7211b0 = {
+	.init_func = &brcm_usb_dvr_init_7211b0,
+	.required_regs = {
+		BRCM_REGS_CTRL,
+		BRCM_REGS_XHCI_EC,
+		BRCM_REGS_XHCI_GBL,
+		BRCM_REGS_USB_PHY,
+		BRCM_REGS_USB_MDIO,
+		-1,
+	},
+};
+
+static struct match_chip_info chip_info_7445 = {
+	.init_func = &brcm_usb_dvr_init_7445,
+	.required_regs = {
+		BRCM_REGS_CTRL,
+		BRCM_REGS_XHCI_EC,
+		-1,
+	},
+};
+
 static const struct of_device_id brcm_usb_dt_ids[] = {
 	{
 		.compatible = "brcm,bcm7216-usb-phy",
-		.data = &brcm_usb_dvr_init_7216,
+		.data = &chip_info_7216,
+	},
+	{
+		.compatible = "brcm,bcm7211-usb-phy",
+		.data = &chip_info_7211b0,
+	},
+	{
+		.compatible = "brcm,brcmstb-usb-phy",
+		.data = &chip_info_7445,
 	},
-	{ .compatible = "brcm,brcmstb-usb-phy" },
 	{ /* sentinel */ }
 };
 
+static int brcm_usb_get_regs(struct platform_device *pdev,
+			     enum brcmusb_reg_sel regs,
+			     struct  brcm_usb_init_params *ini)
+{
+	struct resource *res;
+
+	/* Older DT nodes have ctrl and optional xhci_ec by index only */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						node_reg_names[regs]);
+	if (res == NULL) {
+		if (regs == BRCM_REGS_CTRL) {
+			res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		} else if (regs == BRCM_REGS_XHCI_EC) {
+			res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+			/* XHCI_EC registers are optional */
+			if (res == NULL)
+				return 0;
+		}
+		if (res == NULL) {
+			dev_err(&pdev->dev, "can't get %s base address\n",
+				node_reg_names[regs]);
+			return 1;
+		}
+	}
+	ini->regs[regs] = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ini->regs[regs])) {
+		dev_err(&pdev->dev, "can't map %s register space\n",
+			node_reg_names[regs]);
+		return 1;
+	}
+	return 0;
+}
+
 static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 				 struct brcm_usb_phy_data *priv,
 				 struct device_node *dn)
@@ -325,9 +406,6 @@ static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 
 static int brcm_usb_phy_probe(struct platform_device *pdev)
 {
-	struct resource *res_ctrl;
-	struct resource *res_xhciec = NULL;
-	struct resource *res_xhcigbl = NULL;
 	struct device *dev = &pdev->dev;
 	struct brcm_usb_phy_data *priv;
 	struct phy_provider *phy_provider;
@@ -335,6 +413,10 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
 	int err;
 	const char *mode;
 	const struct of_device_id *match;
+	void (*dvr_init)(struct brcm_usb_init_params *params);
+	const struct match_chip_info *info;
+	struct regmap *rmap;
+	int x;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -345,58 +427,13 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
 	priv->ini.product_id = brcmstb_get_product_id();
 
 	match = of_match_node(brcm_usb_dt_ids, dev->of_node);
-	if (match && match->data) {
-		void (*dvr_init)(struct brcm_usb_init_params *params);
-
-		dvr_init = match->data;
-		(*dvr_init)(&priv->ini);
-	} else {
-		brcm_usb_dvr_init_7445(&priv->ini);
-	}
+	info = match->data;
+	dvr_init = info->init_func;
+	(*dvr_init)(&priv->ini);
 
 	dev_dbg(dev, "Best mapping table is for %s\n",
 		priv->ini.family_name);
 
-	/* Newer DT node has reg-names. xhci_ec and xhci_gbl are optional. */
-	res_ctrl = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
-	if (res_ctrl != NULL) {
-		res_xhciec = platform_get_resource_byname(pdev,
-							  IORESOURCE_MEM,
-							  "xhci_ec");
-		res_xhcigbl = platform_get_resource_byname(pdev,
-							   IORESOURCE_MEM,
-							   "xhci_gbl");
-	} else {
-		/* Older DT node without reg-names, use index */
-		res_ctrl = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (res_ctrl == NULL) {
-			dev_err(dev, "can't get CTRL base address\n");
-			return -EINVAL;
-		}
-		res_xhciec = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	}
-	priv->ini.ctrl_regs = devm_ioremap_resource(dev, res_ctrl);
-	if (IS_ERR(priv->ini.ctrl_regs)) {
-		dev_err(dev, "can't map CTRL register space\n");
-		return -EINVAL;
-	}
-	if (res_xhciec) {
-		priv->ini.xhci_ec_regs =
-			devm_ioremap_resource(dev, res_xhciec);
-		if (IS_ERR(priv->ini.xhci_ec_regs)) {
-			dev_err(dev, "can't map XHCI EC register space\n");
-			return -EINVAL;
-		}
-	}
-	if (res_xhcigbl) {
-		priv->ini.xhci_gbl_regs =
-			devm_ioremap_resource(dev, res_xhcigbl);
-		if (IS_ERR(priv->ini.xhci_gbl_regs)) {
-			dev_err(dev, "can't map XHCI Global register space\n");
-			return -EINVAL;
-		}
-	}
-
 	of_property_read_u32(dn, "brcm,ipp", &priv->ini.ipp);
 	of_property_read_u32(dn, "brcm,ioc", &priv->ini.ioc);
 
@@ -412,6 +449,16 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
 	if (of_property_read_bool(dn, "brcm,has-eohci"))
 		priv->has_eohci = true;
 
+	for (x = 0; x < BRCM_REGS_MAX; x++) {
+		if (info->required_regs[x] >= BRCM_REGS_MAX)
+			break;
+
+		err = brcm_usb_get_regs(pdev, info->required_regs[x],
+					&priv->ini);
+		if (err)
+			return -EINVAL;
+	}
+
 	err = brcm_usb_phy_dvr_init(pdev, priv, dn);
 	if (err)
 		return err;
@@ -431,6 +478,15 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
 	if (err)
 		dev_warn(dev, "Error creating sysfs attributes\n");
 
+	/* Get piarbctl syscon if it exists */
+	rmap = syscon_regmap_lookup_by_phandle(dev->of_node,
+						 "syscon-piarbctl");
+	if (IS_ERR(rmap))
+		rmap = syscon_regmap_lookup_by_phandle(dev->of_node,
+						       "brcm,syscon-piarbctl");
+	if (!IS_ERR(rmap))
+		priv->ini.syscon_piarbctl = rmap;
+
 	/* start with everything off */
 	if (priv->has_xhci)
 		brcm_usb_uninit_xhci(&priv->ini);
-- 
2.17.1

