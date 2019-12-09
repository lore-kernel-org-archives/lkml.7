Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1B7C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A905F205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cm+hdVmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfLIVo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:44:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44212 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfLIVoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:44:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so17824738wrm.11;
        Mon, 09 Dec 2019 13:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jnU8lpfvsI3p3uFx40QLgxidbuLZorgCLXQH1JXWdS8=;
        b=Cm+hdVmVRs9uZI3iMe/6Usjj7j4qUVMn68imO8f6sMUjx25lM3e55fcBOMSkOi/Vb8
         AfIg9U/Li2wScM+xZhRuVbfp6nrHrWxo5GX5it+kORap8dhm12B6Gjke20QMbeZ+dIlB
         JjarAKAZ5RgdNts6te2vmiXIOGn1QK4tSayRryVtQn65ykdTzF85NiYH4k6ji6UDX1fs
         shYOElGPUFgWA2b3MT3jZj/1cfoc29xfHFj95rUjrYdiDyozZYMLXW1zAIm4Mt8nfzXE
         WLAiLsEoO9pLt9bJbF5/PRfa4cfa1N/57oQDimxDiXQJCkadxR1n3KwWJLawqRwDxVub
         0VUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jnU8lpfvsI3p3uFx40QLgxidbuLZorgCLXQH1JXWdS8=;
        b=kIs5hsBy8EIU8Mw7kKIWuIe1TWC1TnLpN1PGJ6CyhwElzAxk8z6qilQm07iIgFvEq0
         uuOLMxb0WNe9DTx2X0EWwLCs8yc8YvzAiaB8PSQBI8ZPIfONKi5/k4GDqSMDHFicqPEI
         7XNVuNzTgnS3NRa5v6fIo/Fmdng6N0AVBqVw5SO/L1BI2eeU8JJ6woE0F+1QJR73rBqz
         DYkdOG2p3kebPTxfOHVBrpzsrG+5If/u0CXc8OplYg6mr1YmFq27opZjioro6dqMDlv4
         jUFjY071CFDm3rgg5N0UdzQ0pBwZf5DjnCbpZw1C7Ei5A0ajIfAXGodeHfXISojFsBmR
         1H/A==
X-Gm-Message-State: APjAAAXCf5DDA2Uwp/HLvJnLmP+vTeKUJo3sZ/yeKaIGsm/Xnvmvjy1N
        EgY0ADz0uah3rlaHGoAHBz3tGl2FYlE=
X-Google-Smtp-Source: APXvYqy3y4SR6QYslcI+GfsXu+EFVI8zWOFkbbUYhQ20uh7Kh+H6NKz9/z9l2aAvY1udcpshI0V2VQ==
X-Received: by 2002:adf:e812:: with SMTP id o18mr4212401wrm.127.1575927860228;
        Mon, 09 Dec 2019 13:44:20 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id z6sm757714wmz.12.2019.12.09.13.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 13:44:19 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 resend 13/13] phy: usb: Add support for wake and USB low power mode for 7211 S2/S5
Date:   Mon,  9 Dec 2019 16:42:49 -0500
Message-Id: <20191209214249.41137-14-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191209214249.41137-1-alcooperx@gmail.com>
References: <20191209214249.41137-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for 7211 USB wake. Disable all possible 7211 USB logic
for S2/S5 if USB wake is not enabled.

On the 7211, the XHCI wake signal was not connected properly and
only goes to the USB1_USB1_CTRL_TP_DIAG1 diagonstic register.
The workaround is to have VPU code running that polls for the
proper bit in the DIAG register and to wake the system when
the bit is asserted.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 .../phy/broadcom/phy-brcm-usb-init-synopsis.c | 77 +++++++++++++++++--
 drivers/phy/broadcom/phy-brcm-usb-init.c      | 26 ++++---
 drivers/phy/broadcom/phy-brcm-usb-init.h      | 11 +--
 drivers/phy/broadcom/phy-brcm-usb.c           | 25 ++++--
 4 files changed, 105 insertions(+), 34 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init-synopsis.c b/drivers/phy/broadcom/phy-brcm-usb-init-synopsis.c
index c6504649d307..a2f96fce8c2f 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init-synopsis.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init-synopsis.c
@@ -26,7 +26,6 @@
 #define   PIARBCTL_MISC_CAM1_MEM_PAGE_MASK		0x00000f00
 #define   PIARBCTL_MISC_CAM0_MEM_PAGE_MASK		0x000000f0
 #define   PIARBCTL_MISC_SATA_PRIORITY_MASK		0x0000000f
-#define PIARBCTL_USB_M_ASB_CTRL		0x10
 
 #define PIARBCTL_MISC_USB_ONLY_MASK		\
 	(PIARBCTL_MISC_USB_SELECT_MASK |	\
@@ -51,14 +50,27 @@
 #define USB_CTRL_USB_PM_STATUS		0x08
 #define USB_CTRL_USB_DEVICE_CTL1	0x10
 #define   USB_CTRL_USB_DEVICE_CTL1_PORT_MODE_MASK	0x00000003
+#define USB_CTRL_TEST_PORT_CTL		0x30
+#define   USB_CTRL_TEST_PORT_CTL_TPOUT_SEL_MASK	0x000000ff
+#define   USB_CTRL_TEST_PORT_CTL_TPOUT_SEL_PME_GEN_MASK	0x0000002e
+#define USB_CTRL_TP_DIAG1		0x34
+#define   USB_CTLR_TP_DIAG1_wake_MASK	0x00000002
+#define USB_CTRL_CTLR_CSHCR		0x50
+#define   USB_CTRL_CTLR_CSHCR_ctl_pme_en_MASK	0x00040000
 
 /* Register definitions for the USB_PHY block in 7211b0 */
+#define USB_PHY_PLL_CTL			0x00
+#define   USB_PHY_PLL_CTL_PLL_RESETB_MASK		0x40000000
 #define USB_PHY_PLL_LDO_CTL		0x08
 #define   USB_PHY_PLL_LDO_CTL_AFE_CORERDY_MASK		0x00000004
+#define   USB_PHY_PLL_LDO_CTL_AFE_LDO_PWRDWNB_MASK	0x00000002
+#define   USB_PHY_PLL_LDO_CTL_AFE_BG_PWRDWNB_MASK	0x00000001
 #define USB_PHY_UTMI_CTL_1		0x04
 #define   USB_PHY_UTMI_CTL_1_POWER_UP_FSM_EN_MASK	0x00000800
 #define   USB_PHY_UTMI_CTL_1_PHY_MODE_MASK		0x0000000c
 #define   USB_PHY_UTMI_CTL_1_PHY_MODE_SHIFT		2
+#define USB_PHY_IDDQ			0x1c
+#define   USB_PHY_IDDQ_phy_iddq_MASK			0x00000001
 #define USB_PHY_STATUS			0x20
 #define   USB_PHY_STATUS_pll_lock_MASK			0x00000001
 
@@ -199,6 +211,17 @@ static void usb_init_common(struct brcm_usb_init_params *params)
 	}
 }
 
+static void usb_wake_enable_7211b0(struct brcm_usb_init_params *params,
+				   bool enable)
+{
+	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
+
+	if (enable)
+		USB_CTRL_SET(ctrl, CTLR_CSHCR, ctl_pme_en);
+	else
+		USB_CTRL_UNSET(ctrl, CTLR_CSHCR, ctl_pme_en);
+}
+
 static void usb_init_common_7211b0(struct brcm_usb_init_params *params)
 {
 	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
@@ -210,9 +233,27 @@ static void usb_init_common_7211b0(struct brcm_usb_init_params *params)
 	if (params->syscon_piarbctl)
 		syscon_piarbctl_init(params->syscon_piarbctl);
 
+	USB_CTRL_UNSET(ctrl, USB_PM, USB_PWRDN);
+
+	usb_wake_enable_7211b0(params, false);
+	if (!params->wake_enabled) {
+
+		/* undo possible suspend settings */
+		brcm_usb_writel(0, usb_phy + USB_PHY_IDDQ);
+		reg = brcm_usb_readl(usb_phy + USB_PHY_PLL_CTL);
+		reg |= USB_PHY_PLL_CTL_PLL_RESETB_MASK;
+		brcm_usb_writel(reg, usb_phy + USB_PHY_PLL_CTL);
+
+		/* temporarily enable FSM so PHY comes up properly */
+		reg = brcm_usb_readl(usb_phy + USB_PHY_UTMI_CTL_1);
+		reg |= USB_PHY_UTMI_CTL_1_POWER_UP_FSM_EN_MASK;
+		brcm_usb_writel(reg, usb_phy + USB_PHY_UTMI_CTL_1);
+	}
+
 	/* Init the PHY */
-	reg = brcm_usb_readl(usb_phy + USB_PHY_PLL_LDO_CTL);
-	reg |= USB_PHY_PLL_LDO_CTL_AFE_CORERDY_MASK;
+	reg = USB_PHY_PLL_LDO_CTL_AFE_CORERDY_MASK |
+		USB_PHY_PLL_LDO_CTL_AFE_LDO_PWRDWNB_MASK |
+		USB_PHY_PLL_LDO_CTL_AFE_BG_PWRDWNB_MASK;
 	brcm_usb_writel(reg, usb_phy + USB_PHY_PLL_LDO_CTL);
 
 	/* wait for lock */
@@ -276,12 +317,36 @@ static void usb_uninit_common(struct brcm_usb_init_params *params)
 
 }
 
+static void usb_uninit_common_7211b0(struct brcm_usb_init_params *params)
+{
+	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
+	void __iomem *usb_phy = params->regs[BRCM_REGS_USB_PHY];
+	u32 reg;
+
+	pr_debug("%s\n", __func__);
+
+	if (params->wake_enabled) {
+		USB_CTRL_SET(ctrl, TEST_PORT_CTL, TPOUT_SEL_PME_GEN);
+		usb_wake_enable_7211b0(params, true);
+	} else {
+		USB_CTRL_SET(ctrl, USB_PM, USB_PWRDN);
+		brcm_usb_writel(0, usb_phy + USB_PHY_PLL_LDO_CTL);
+		reg = brcm_usb_readl(usb_phy + USB_PHY_PLL_CTL);
+		reg &= ~USB_PHY_PLL_CTL_PLL_RESETB_MASK;
+		brcm_usb_writel(reg, usb_phy + USB_PHY_PLL_CTL);
+		brcm_usb_writel(USB_PHY_IDDQ_phy_iddq_MASK,
+				usb_phy + USB_PHY_IDDQ);
+	}
+
+}
+
 static void usb_uninit_xhci(struct brcm_usb_init_params *params)
 {
 
 	pr_debug("%s\n", __func__);
 
-	xhci_soft_reset(params, 1);
+	if (!params->wake_enabled)
+		xhci_soft_reset(params, 1);
 }
 
 static int usb_get_dual_select(struct brcm_usb_init_params *params)
@@ -309,7 +374,6 @@ static void usb_set_dual_select(struct brcm_usb_init_params *params, int mode)
 	brcm_usb_writel(reg, USB_CTRL_REG(ctrl, USB_DEVICE_CTL1));
 }
 
-
 static const struct brcm_usb_init_ops bcm7216_ops = {
 	.init_ipp = usb_init_ipp,
 	.init_common = usb_init_common,
@@ -324,7 +388,7 @@ static const struct brcm_usb_init_ops bcm7211b0_ops = {
 	.init_ipp = usb_init_ipp,
 	.init_common = usb_init_common_7211b0,
 	.init_xhci = usb_init_xhci,
-	.uninit_common = usb_uninit_common,
+	.uninit_common = usb_uninit_common_7211b0,
 	.uninit_xhci = usb_uninit_xhci,
 	.get_dual_select = usb_get_dual_select,
 	.set_dual_select = usb_set_dual_select,
@@ -346,4 +410,5 @@ void brcm_usb_dvr_init_7211b0(struct brcm_usb_init_params *params)
 
 	params->family_name = "7211";
 	params->ops = &bcm7211b0_ops;
+	params->suspend_with_clocks = true;
 }
diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.c b/drivers/phy/broadcom/phy-brcm-usb-init.c
index e28e4b1a3f21..b477c1684825 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
@@ -783,12 +783,24 @@ static void usb_init_ipp(struct brcm_usb_init_params *params)
 		msleep(50);
 }
 
+static void usb_wake_enable(struct brcm_usb_init_params *params,
+			  bool enable)
+{
+	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
+
+	if (enable)
+		USB_CTRL_SET(ctrl, USB_PM, RMTWKUP_EN);
+	else
+		USB_CTRL_UNSET(ctrl, USB_PM, RMTWKUP_EN);
+}
+
 static void usb_init_common(struct brcm_usb_init_params *params)
 {
 	u32 reg;
 	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
 
 	/* Clear any pending wake conditions */
+	usb_wake_enable(params, false);
 	reg = brcm_usb_readl(USB_CTRL_REG(ctrl, USB_PM_STATUS));
 	brcm_usb_writel(reg, USB_CTRL_REG(ctrl, USB_PM_STATUS));
 
@@ -935,6 +947,8 @@ static void usb_uninit_common(struct brcm_usb_init_params *params)
 
 	if (USB_CTRL_MASK_FAMILY(params, PLL_CTL, PLL_IDDQ_PWRDN))
 		USB_CTRL_SET_FAMILY(params, PLL_CTL, PLL_IDDQ_PWRDN);
+	if (params->wake_enabled)
+		usb_wake_enable(params, true);
 }
 
 static void usb_uninit_eohci(struct brcm_usb_init_params *params)
@@ -978,17 +992,6 @@ static void usb_set_dual_select(struct brcm_usb_init_params *params, int mode)
 	}
 }
 
-static void usb_wake_enable(struct brcm_usb_init_params *params,
-			  int enable)
-{
-	void __iomem *ctrl = params->regs[BRCM_REGS_CTRL];
-
-	if (enable)
-		USB_CTRL_SET(ctrl, USB_PM, RMTWKUP_EN);
-	else
-		USB_CTRL_UNSET(ctrl, USB_PM, RMTWKUP_EN);
-}
-
 static const struct brcm_usb_init_ops bcm7445_ops = {
 	.init_ipp = usb_init_ipp,
 	.init_common = usb_init_common,
@@ -999,7 +1002,6 @@ static const struct brcm_usb_init_ops bcm7445_ops = {
 	.uninit_xhci = usb_uninit_xhci,
 	.get_dual_select = usb_get_dual_select,
 	.set_dual_select = usb_set_dual_select,
-	.wake_enable = usb_wake_enable,
 };
 
 void brcm_usb_dvr_init_7445(struct brcm_usb_init_params *params)
diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.h b/drivers/phy/broadcom/phy-brcm-usb-init.h
index 570bd9d8c9ec..2955fdc8479b 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.h
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.h
@@ -46,8 +46,6 @@ struct brcm_usb_init_ops {
 	void (*uninit_xhci)(struct brcm_usb_init_params *params);
 	int  (*get_dual_select)(struct brcm_usb_init_params *params);
 	void (*set_dual_select)(struct brcm_usb_init_params *params, int mode);
-	void (*wake_enable)(struct brcm_usb_init_params *params,
-			    int enable);
 };
 
 struct  brcm_usb_init_params {
@@ -62,6 +60,8 @@ struct  brcm_usb_init_params {
 	const u32 *usb_reg_bits_map;
 	const struct brcm_usb_init_ops *ops;
 	struct regmap *syscon_piarbctl;
+	bool wake_enabled;
+	bool suspend_with_clocks;
 };
 
 void brcm_usb_dvr_init_7445(struct brcm_usb_init_params *params);
@@ -145,13 +145,6 @@ static inline void brcm_usb_uninit_xhci(struct brcm_usb_init_params *ini)
 		ini->ops->uninit_xhci(ini);
 }
 
-static inline void brcm_usb_wake_enable(struct brcm_usb_init_params *ini,
-	int enable)
-{
-	if (ini->ops->wake_enable)
-		ini->ops->wake_enable(ini, enable);
-}
-
 static inline int brcm_usb_get_dual_select(struct brcm_usb_init_params *ini)
 {
 	if (ini->ops->get_dual_select)
diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index 1ab44f54244b..491bbd46c5b3 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -535,16 +535,26 @@ static int brcm_usb_phy_suspend(struct device *dev)
 	struct brcm_usb_phy_data *priv = dev_get_drvdata(dev);
 
 	if (priv->init_count) {
+		priv->ini.wake_enabled = device_may_wakeup(dev);
 		if (priv->phys[BRCM_USB_PHY_3_0].inited)
 			brcm_usb_uninit_xhci(&priv->ini);
 		if (priv->phys[BRCM_USB_PHY_2_0].inited)
 			brcm_usb_uninit_eohci(&priv->ini);
 		brcm_usb_uninit_common(&priv->ini);
-		brcm_usb_wake_enable(&priv->ini, true);
-		if (priv->phys[BRCM_USB_PHY_3_0].inited)
-			clk_disable_unprepare(priv->usb_30_clk);
-		if (priv->phys[BRCM_USB_PHY_2_0].inited || !priv->has_eohci)
-			clk_disable_unprepare(priv->usb_20_clk);
+
+		/*
+		 * Handle the clocks unless needed for wake. This has
+		 * to work for both older XHCI->3.0-clks, EOHCI->2.0-clks
+		 * and newer XHCI->2.0-clks/3.0-clks.
+		 */
+
+		if (!priv->ini.suspend_with_clocks) {
+			if (priv->phys[BRCM_USB_PHY_3_0].inited)
+				clk_disable_unprepare(priv->usb_30_clk);
+			if (priv->phys[BRCM_USB_PHY_2_0].inited ||
+			    !priv->has_eohci)
+				clk_disable_unprepare(priv->usb_20_clk);
+		}
 		if (priv->wake_irq >= 0)
 			enable_irq_wake(priv->wake_irq);
 	}
@@ -557,7 +567,6 @@ static int brcm_usb_phy_resume(struct device *dev)
 
 	clk_prepare_enable(priv->usb_20_clk);
 	clk_prepare_enable(priv->usb_30_clk);
-	brcm_usb_wake_enable(&priv->ini, false);
 	brcm_usb_init_ipp(&priv->ini);
 
 	/*
@@ -579,6 +588,8 @@ static int brcm_usb_phy_resume(struct device *dev)
 		} else if (priv->has_xhci) {
 			brcm_usb_uninit_xhci(&priv->ini);
 			clk_disable_unprepare(priv->usb_30_clk);
+			if (!priv->has_eohci)
+				clk_disable_unprepare(priv->usb_20_clk);
 		}
 	} else {
 		if (priv->has_xhci)
@@ -589,7 +600,7 @@ static int brcm_usb_phy_resume(struct device *dev)
 		clk_disable_unprepare(priv->usb_20_clk);
 		clk_disable_unprepare(priv->usb_30_clk);
 	}
-
+	priv->ini.wake_enabled = false;
 	return 0;
 }
 #endif /* CONFIG_PM_SLEEP */
-- 
2.17.1

