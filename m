Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD933C32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7582253D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 18:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwaPXA8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgACSTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 13:19:35 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38596 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgACSTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 13:19:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so23872556pfc.5;
        Fri, 03 Jan 2020 10:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1dTOzVRNiurnChNy+Ai5qce135Oq+vulQrNRDSy+X7Q=;
        b=gwaPXA8Vucd4igKAt2QFUiID80dMAgW8QtV2neYZH5xgnYOYRoOYas1fxlFQJh8Wrv
         TN6DpS15lcmzPk7ADCxCnQSd6pL/NTq9mbN7+PP0U0dseC/Bi9EsDMTW+iuGOxb6pmdu
         kBTaFZTQsrMgcYr7Zb2S8JJBX0oB3CMUsRInddKfZGKn2UIqVBeHqLKXYu0LZVml/06L
         YdAiS+ubRuav7raKUPyXoUAjOx17OSmfsw19y3SVISYHzuqqUH+O2YL2KbzImy9OsNhG
         wmA+DZfVCcZPqrrMgFpLbxjwf1LvKrRCfNn5fQgx0hHL76XpUUSve8Q41lBL5SFHOft4
         ZGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1dTOzVRNiurnChNy+Ai5qce135Oq+vulQrNRDSy+X7Q=;
        b=ridxlYbmyavKn2t7R6aLZOlc4LE/pxPQbhJG0VLY605gsi0yJUb6f+25cKFIZcrfph
         De+gujClSu/DYpRxWc19Nk+uLNzFVbyA/PU0LzZw/x8x2CtJ7tY2ZdimIQvWmcCw+BRY
         T/Yn26tSN65BWJY9maTEKMTRVajDpgl2yV/FGoYMu4JbgGj2tZ+7uGAUhEQTY6AFcPhA
         0KBH60o5VWVtCJCBecKyFc4MTIbQLDwnXkQVdpBV7gB2lLE0elE/HT8mkemLmNklRfwZ
         uhr1J+0NKFjSc1cvyOVK61MJhMoaJDI/Mp9oUwB2kJsDiG7r5dTsJRlikkmSKROsunsn
         thbA==
X-Gm-Message-State: APjAAAWif9Mb8sftw7PqmhO5yolE14pcK8OSD3HnPEnLkuc/4XP3qyYZ
        SeC7bsJeuysa8ZWvAgmQnyyI5Vn7UuI=
X-Google-Smtp-Source: APXvYqw7AU7NTra2eJE6WEUwuq2AJJLTbHqU4w6WyJ/m8TAVEEver8PHbdeFEEh1Y4b0zx2lrlSrKQ==
X-Received: by 2002:aa7:9aeb:: with SMTP id y11mr98213412pfp.63.1578075569340;
        Fri, 03 Jan 2020 10:19:29 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j8sm41783602pfe.182.2020.01.03.10.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 10:19:29 -0800 (PST)
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
Subject: [PATCH v4 04/13] phy: usb: Add "wake on" functionality
Date:   Fri,  3 Jan 2020 13:18:02 -0500
Message-Id: <20200103181811.22939-5-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103181811.22939-1-alcooperx@gmail.com>
References: <20200103181811.22939-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to handle USB wake events from USB devices when
in S2 mode. Typically there is some additional configuration
needed to tell the USB device to generate the wake event when
suspended but this varies with the different USB device classes.
For example, on USB Ethernet dongles, ethtool should be used to
enable the magic packet wake functionality in the dongle.
NOTE:  This requires that the "power/wakeup" sysfs entry for
the USB device generating the wakeup be set to "enabled".

This functionality requires a special hardware sideband path that
will trigger the AON_PM_L2 interrupt needed to wake the system from
S2 even though the USB host controllers are in IDDQ (low power state)
and most USB related clocks are shut off. For the sideband signaling
to work we need to leave the usbx_freerun clock running, but this
clock consumes very little power by design. There's a bug in the
XHCI wake hardware so only EHCI/OHCI wake is currently supported.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb-init.c | 17 +++++++++
 drivers/phy/broadcom/phy-brcm-usb-init.h |  1 +
 drivers/phy/broadcom/phy-brcm-usb.c      | 48 ++++++++++++++++++++++--
 3 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.c b/drivers/phy/broadcom/phy-brcm-usb-init.c
index ac7f7995c11f..58882c10396a 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.c
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
@@ -58,6 +58,8 @@
 #define   USB_CTRL_USB_PM_SOFT_RESET_MASK		0x40000000 /* option */
 #define   USB_CTRL_USB_PM_USB20_HC_RESETB_MASK		0x30000000 /* option */
 #define   USB_CTRL_USB_PM_USB20_HC_RESETB_VAR_MASK	0x00300000 /* option */
+#define   USB_CTRL_USB_PM_RMTWKUP_EN_MASK		0x00000001
+#define USB_CTRL_USB_PM_STATUS		0x38
 #define USB_CTRL_USB30_CTL1		0x60
 #define   USB_CTRL_USB30_CTL1_PHY3_PLL_SEQ_START_MASK	0x00000010
 #define   USB_CTRL_USB30_CTL1_PHY3_RESETB_MASK		0x00010000
@@ -855,6 +857,10 @@ void brcm_usb_init_common(struct brcm_usb_init_params *params)
 	u32 reg;
 	void __iomem *ctrl = params->ctrl_regs;
 
+	/* Clear any pending wake conditions */
+	reg = brcmusb_readl(USB_CTRL_REG(ctrl, USB_PM_STATUS));
+	brcmusb_writel(reg, USB_CTRL_REG(ctrl, USB_PM_STATUS));
+
 	/* Take USB out of power down */
 	if (USB_CTRL_MASK_FAMILY(params, PLL_CTL, PLL_IDDQ_PWRDN)) {
 		USB_CTRL_UNSET_FAMILY(params, PLL_CTL, PLL_IDDQ_PWRDN);
@@ -1010,6 +1016,17 @@ void brcm_usb_uninit_xhci(struct brcm_usb_init_params *params)
 	USB_CTRL_SET(params->ctrl_regs, USB30_PCTL, PHY3_IDDQ_OVERRIDE);
 }
 
+void brcm_usb_wake_enable(struct brcm_usb_init_params *params,
+			  int enable)
+{
+	void __iomem *ctrl = params->ctrl_regs;
+
+	if (enable)
+		USB_CTRL_SET(ctrl, USB_PM, RMTWKUP_EN);
+	else
+		USB_CTRL_UNSET(ctrl, USB_PM, RMTWKUP_EN);
+}
+
 void brcm_usb_set_family_map(struct brcm_usb_init_params *params)
 {
 	int fam;
diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.h b/drivers/phy/broadcom/phy-brcm-usb-init.h
index f4f4f6d5d258..f473e0c51f0b 100644
--- a/drivers/phy/broadcom/phy-brcm-usb-init.h
+++ b/drivers/phy/broadcom/phy-brcm-usb-init.h
@@ -38,5 +38,6 @@ void brcm_usb_init_xhci(struct brcm_usb_init_params *ini);
 void brcm_usb_uninit_common(struct brcm_usb_init_params *ini);
 void brcm_usb_uninit_eohci(struct brcm_usb_init_params *ini);
 void brcm_usb_uninit_xhci(struct brcm_usb_init_params *ini);
+void brcm_usb_wake_enable(struct brcm_usb_init_params *params, int enable);
 
 #endif /* _USB_BRCM_COMMON_INIT_H */
diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index 634afc803778..cca04d60f2d2 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -57,11 +57,22 @@ struct brcm_usb_phy_data {
 	bool			has_xhci;
 	struct clk		*usb_20_clk;
 	struct clk		*usb_30_clk;
+	struct clk		*suspend_clk;
 	struct mutex		mutex;	/* serialize phy init */
 	int			init_count;
+	int			wake_irq;
 	struct brcm_usb_phy	phys[BRCM_USB_PHY_ID_MAX];
 };
 
+static irqreturn_t brcm_usb_phy_wake_isr(int irq, void *dev_id)
+{
+	struct phy *gphy = dev_id;
+
+	pm_wakeup_event(&gphy->dev, 0);
+
+	return IRQ_HANDLED;
+}
+
 static int brcm_usb_phy_init(struct phy *gphy)
 {
 	struct brcm_usb_phy *phy = phy_get_drvdata(gphy);
@@ -76,6 +87,7 @@ static int brcm_usb_phy_init(struct phy *gphy)
 	if (priv->init_count++ == 0) {
 		clk_prepare_enable(priv->usb_20_clk);
 		clk_prepare_enable(priv->usb_30_clk);
+		clk_prepare_enable(priv->suspend_clk);
 		brcm_usb_init_common(&priv->ini);
 	}
 	mutex_unlock(&priv->mutex);
@@ -108,6 +120,7 @@ static int brcm_usb_phy_exit(struct phy *gphy)
 		brcm_usb_uninit_common(&priv->ini);
 		clk_disable_unprepare(priv->usb_20_clk);
 		clk_disable_unprepare(priv->usb_30_clk);
+		clk_disable_unprepare(priv->suspend_clk);
 	}
 	mutex_unlock(&priv->mutex);
 	phy->inited = false;
@@ -228,11 +241,12 @@ static const struct attribute_group brcm_usb_phy_group = {
 	.attrs = brcm_usb_phy_attrs,
 };
 
-static int brcm_usb_phy_dvr_init(struct device *dev,
+static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 				 struct brcm_usb_phy_data *priv,
 				 struct device_node *dn)
 {
-	struct phy *gphy;
+	struct device *dev = &pdev->dev;
+	struct phy *gphy = NULL;
 	int err;
 
 	priv->usb_20_clk = of_clk_get_by_name(dn, "sw_usb");
@@ -275,6 +289,28 @@ static int brcm_usb_phy_dvr_init(struct device *dev,
 		if (err)
 			return err;
 	}
+
+	priv->suspend_clk = clk_get(dev, "usb0_freerun");
+	if (IS_ERR(priv->suspend_clk)) {
+		dev_err(dev, "Suspend Clock not found in Device Tree\n");
+		priv->suspend_clk = NULL;
+	}
+
+	priv->wake_irq = platform_get_irq_byname(pdev, "wake");
+	if (priv->wake_irq < 0)
+		priv->wake_irq = platform_get_irq_byname(pdev, "wakeup");
+	if (priv->wake_irq >= 0) {
+		err = devm_request_irq(dev, priv->wake_irq,
+				       brcm_usb_phy_wake_isr, 0,
+				       dev_name(dev), gphy);
+		if (err < 0)
+			return err;
+		device_set_wakeup_capable(dev, 1);
+	} else {
+		dev_info(dev,
+			 "Wake interrupt missing, system wake not supported\n");
+	}
+
 	return 0;
 }
 
@@ -335,7 +371,7 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
 	if (of_property_read_bool(dn, "brcm,has-eohci"))
 		priv->has_eohci = true;
 
-	err = brcm_usb_phy_dvr_init(dev, priv, dn);
+	err = brcm_usb_phy_dvr_init(pdev, priv, dn);
 	if (err)
 		return err;
 
@@ -386,10 +422,13 @@ static int brcm_usb_phy_suspend(struct device *dev)
 		if (priv->phys[BRCM_USB_PHY_2_0].inited)
 			brcm_usb_uninit_eohci(&priv->ini);
 		brcm_usb_uninit_common(&priv->ini);
+		brcm_usb_wake_enable(&priv->ini, true);
 		if (priv->phys[BRCM_USB_PHY_3_0].inited)
 			clk_disable_unprepare(priv->usb_30_clk);
 		if (priv->phys[BRCM_USB_PHY_2_0].inited)
 			clk_disable_unprepare(priv->usb_20_clk);
+		if (priv->wake_irq >= 0)
+			enable_irq_wake(priv->wake_irq);
 	}
 	return 0;
 }
@@ -400,6 +439,7 @@ static int brcm_usb_phy_resume(struct device *dev)
 
 	clk_prepare_enable(priv->usb_20_clk);
 	clk_prepare_enable(priv->usb_30_clk);
+	brcm_usb_wake_enable(&priv->ini, false);
 	brcm_usb_init_ipp(&priv->ini);
 
 	/*
@@ -407,6 +447,8 @@ static int brcm_usb_phy_resume(struct device *dev)
 	 * Uninitialize anything that wasn't previously initialized.
 	 */
 	if (priv->init_count) {
+		if (priv->wake_irq >= 0)
+			disable_irq_wake(priv->wake_irq);
 		brcm_usb_init_common(&priv->ini);
 		if (priv->phys[BRCM_USB_PHY_2_0].inited) {
 			brcm_usb_init_eohci(&priv->ini);
-- 
2.17.1

