Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9C7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D64920883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfDAMF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:05:29 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:7732 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727027AbfDAMFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:05:21 -0400
X-IronPort-AV: E=Sophos;i="5.60,296,1549897200"; 
   d="scan'208";a="11926553"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Apr 2019 21:05:17 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id C6D82401EA6A;
        Mon,  1 Apr 2019 21:05:17 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 3/3] phy: renesas: rcar-gen3-usb2: enable/disable independent irqs
Date:   Mon,  1 Apr 2019 21:01:23 +0900
Message-Id: <1554120083-29990-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554120083-29990-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1554120083-29990-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the previous code enabled/disabled the irqs both OHCI and EHCI,
it is possible to cause unexpected interruptions. To avoid this,
this patch creates multiple phy instances from phandle and
enables/disables independent irqs by the instances.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 181 ++++++++++++++++++++++++++-----
 1 file changed, 156 insertions(+), 25 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 4bdb2ed..bbe0fe5 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -37,11 +37,8 @@
 
 /* INT_ENABLE */
 #define USB2_INT_ENABLE_UCOM_INTEN	BIT(3)
-#define USB2_INT_ENABLE_USBH_INTB_EN	BIT(2)
-#define USB2_INT_ENABLE_USBH_INTA_EN	BIT(1)
-#define USB2_INT_ENABLE_INIT		(USB2_INT_ENABLE_UCOM_INTEN | \
-					 USB2_INT_ENABLE_USBH_INTB_EN | \
-					 USB2_INT_ENABLE_USBH_INTA_EN)
+#define USB2_INT_ENABLE_USBH_INTB_EN	BIT(2)	/* For EHCI */
+#define USB2_INT_ENABLE_USBH_INTA_EN	BIT(1)	/* For OHCI */
 
 /* USBCTR */
 #define USB2_USBCTR_DIRPD	BIT(2)
@@ -78,11 +75,33 @@
 #define USB2_ADPCTRL_IDPULLUP		BIT(5)	/* 1 = ID sampling is enabled */
 #define USB2_ADPCTRL_DRVVBUS		BIT(4)
 
+#define NUM_OF_PHYS			4
+#define PHY_INDEX_BOTH_HC		0
+#define PHY_INDEX_OHCI			1
+#define PHY_INDEX_EHCI			2
+#define PHY_INDEX_HSUSB			3
+
+static const u32 rcar_gen3_int_enable[NUM_OF_PHYS] = {
+	USB2_INT_ENABLE_USBH_INTB_EN | USB2_INT_ENABLE_USBH_INTA_EN,
+	USB2_INT_ENABLE_USBH_INTA_EN,
+	USB2_INT_ENABLE_USBH_INTB_EN,
+	0
+};
+
+struct rcar_gen3_phy {
+	struct phy *phy;
+	struct rcar_gen3_chan *ch;
+	u32 int_enable_bits;
+	bool initialized;
+	bool otg_initialized;
+	bool powered;
+};
+
 struct rcar_gen3_chan {
 	void __iomem *base;
 	struct device *dev;	/* platform_device's device */
 	struct extcon_dev *extcon;
-	struct phy *phy;
+	struct rcar_gen3_phy rphys[NUM_OF_PHYS];
 	struct regulator *vbus;
 	struct work_struct work;
 	enum usb_dr_mode dr_mode;
@@ -250,6 +269,42 @@ static enum phy_mode rcar_gen3_get_phy_mode(struct rcar_gen3_chan *ch)
 	return PHY_MODE_USB_DEVICE;
 }
 
+static bool rcar_gen3_is_any_rphy_initialized(struct rcar_gen3_chan *ch)
+{
+	int i;
+
+	for (i = 0; i < NUM_OF_PHYS; i++) {
+		if (ch->rphys[i].initialized)
+			return true;
+	}
+
+	return false;
+}
+
+static bool rcar_gen3_needs_init_otg(struct rcar_gen3_chan *ch)
+{
+	int i;
+
+	for (i = 0; i < NUM_OF_PHYS; i++) {
+		if (ch->rphys[i].otg_initialized)
+			return false;
+	}
+
+	return true;
+}
+
+static bool rcar_gen3_are_all_rphys_power_off(struct rcar_gen3_chan *ch)
+{
+	int i;
+
+	for (i = 0; i < NUM_OF_PHYS; i++) {
+		if (ch->rphys[i].powered)
+			return false;
+	}
+
+	return true;
+}
+
 static ssize_t role_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
@@ -257,7 +312,7 @@ static ssize_t role_store(struct device *dev, struct device_attribute *attr,
 	bool is_b_device;
 	enum phy_mode cur_mode, new_mode;
 
-	if (!ch->is_otg_channel || !ch->phy->init_count)
+	if (!ch->is_otg_channel || !rcar_gen3_is_any_rphy_initialized(ch))
 		return -EIO;
 
 	if (!strncmp(buf, "host", strlen("host")))
@@ -295,7 +350,7 @@ static ssize_t role_show(struct device *dev, struct device_attribute *attr,
 {
 	struct rcar_gen3_chan *ch = dev_get_drvdata(dev);
 
-	if (!ch->is_otg_channel || !ch->phy->init_count)
+	if (!ch->is_otg_channel || !rcar_gen3_is_any_rphy_initialized(ch))
 		return -EIO;
 
 	return sprintf(buf, "%s\n", rcar_gen3_is_host(ch) ? "host" :
@@ -329,37 +384,62 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 
 static int rcar_gen3_phy_usb2_init(struct phy *p)
 {
-	struct rcar_gen3_chan *channel = phy_get_drvdata(p);
+	struct rcar_gen3_phy *rphy = phy_get_drvdata(p);
+	struct rcar_gen3_chan *channel = rphy->ch;
 	void __iomem *usb2_base = channel->base;
+	u32 val;
 
 	/* Initialize USB2 part */
-	writel(USB2_INT_ENABLE_INIT, usb2_base + USB2_INT_ENABLE);
+	val = readl(usb2_base + USB2_INT_ENABLE);
+	val |= USB2_INT_ENABLE_UCOM_INTEN | rphy->int_enable_bits;
+	writel(val, usb2_base + USB2_INT_ENABLE);
 	writel(USB2_SPD_RSM_TIMSET_INIT, usb2_base + USB2_SPD_RSM_TIMSET);
 	writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
 
 	/* Initialize otg part */
-	if (channel->is_otg_channel)
-		rcar_gen3_init_otg(channel);
+	if (channel->is_otg_channel) {
+		if (rcar_gen3_needs_init_otg(channel))
+			rcar_gen3_init_otg(channel);
+		rphy->otg_initialized = true;
+	}
+
+	rphy->initialized = true;
 
 	return 0;
 }
 
 static int rcar_gen3_phy_usb2_exit(struct phy *p)
 {
-	struct rcar_gen3_chan *channel = phy_get_drvdata(p);
+	struct rcar_gen3_phy *rphy = phy_get_drvdata(p);
+	struct rcar_gen3_chan *channel = rphy->ch;
+	void __iomem *usb2_base = channel->base;
+	u32 val;
 
-	writel(0, channel->base + USB2_INT_ENABLE);
+	rphy->initialized = false;
+
+	if (channel->is_otg_channel)
+		rphy->otg_initialized = false;
+
+	val = readl(usb2_base + USB2_INT_ENABLE);
+	val &= ~rphy->int_enable_bits;
+	if (!rcar_gen3_is_any_rphy_initialized(channel))
+		val &= ~USB2_INT_ENABLE_UCOM_INTEN;
+	writel(val, usb2_base + USB2_INT_ENABLE);
 
 	return 0;
 }
 
 static int rcar_gen3_phy_usb2_power_on(struct phy *p)
 {
-	struct rcar_gen3_chan *channel = phy_get_drvdata(p);
+	struct rcar_gen3_phy *rphy = phy_get_drvdata(p);
+	struct rcar_gen3_chan *channel = rphy->ch;
 	void __iomem *usb2_base = channel->base;
 	u32 val;
 	int ret;
 
+	if (!rcar_gen3_are_all_rphys_power_off(channel))
+		return 0;
+
 	if (channel->vbus) {
 		ret = regulator_enable(channel->vbus);
 		if (ret)
@@ -372,14 +452,22 @@ static int rcar_gen3_phy_usb2_power_on(struct phy *p)
 	val &= ~USB2_USBCTR_PLL_RST;
 	writel(val, usb2_base + USB2_USBCTR);
 
+	rphy->powered = true;
+
 	return 0;
 }
 
 static int rcar_gen3_phy_usb2_power_off(struct phy *p)
 {
-	struct rcar_gen3_chan *channel = phy_get_drvdata(p);
+	struct rcar_gen3_phy *rphy = phy_get_drvdata(p);
+	struct rcar_gen3_chan *channel = rphy->ch;
 	int ret = 0;
 
+	rphy->powered = false;
+
+	if (!rcar_gen3_are_all_rphys_power_off(channel))
+		return 0;
+
 	if (channel->vbus)
 		ret = regulator_disable(channel->vbus);
 
@@ -426,13 +514,51 @@ static const unsigned int rcar_gen3_phy_cable[] = {
 	EXTCON_NONE,
 };
 
+static struct phy *rcar_gen3_phy_usb2_xlate(struct device *dev,
+					    struct of_phandle_args *args)
+{
+	struct rcar_gen3_chan *ch = dev_get_drvdata(dev);
+
+	if (args->args_count == 0)	/* For old version dts */
+		return ch->rphys[PHY_INDEX_BOTH_HC].phy;
+	else if (args->args_count > 1)	/* Prevent invalid args count */
+		return ERR_PTR(-ENODEV);
+
+	if (args->args[0] >= NUM_OF_PHYS)
+		return ERR_PTR(-ENODEV);
+
+	return ch->rphys[args->args[0]].phy;
+}
+
+static enum usb_dr_mode rcar_gen3_get_dr_mode(struct device_node *np)
+{
+	enum usb_dr_mode candidate = USB_DR_MODE_UNKNOWN, tmp;
+	int i;
+
+	/*
+	 * If one of device nodes has other dr_mode except UNKNOWN,
+	 * this function returns UNKNOWN.
+	 */
+	for (i = 0; i < NUM_OF_PHYS; i++) {
+		tmp = of_usb_get_dr_mode_by_phy(np, i);
+		if (tmp != USB_DR_MODE_UNKNOWN) {
+			if (candidate == USB_DR_MODE_UNKNOWN)
+				candidate = tmp;
+			else if (candidate != tmp)
+				return USB_DR_MODE_UNKNOWN;
+		}
+	}
+
+	return candidate;
+}
+
 static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rcar_gen3_chan *channel;
 	struct phy_provider *provider;
 	struct resource *res;
-	int irq, ret = 0;
+	int irq, ret = 0, i;
 
 	if (!dev->of_node) {
 		dev_err(dev, "This driver needs device tree\n");
@@ -458,7 +584,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 			dev_err(dev, "No irq handler (%d)\n", irq);
 	}
 
-	channel->dr_mode = of_usb_get_dr_mode_by_phy(dev->of_node, 0);
+	channel->dr_mode = rcar_gen3_get_dr_mode(dev->of_node);
 	if (channel->dr_mode != USB_DR_MODE_UNKNOWN) {
 		int ret;
 
@@ -482,11 +608,17 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	 * And then, phy-core will manage runtime pm for this device.
 	 */
 	pm_runtime_enable(dev);
-	channel->phy = devm_phy_create(dev, NULL, &rcar_gen3_phy_usb2_ops);
-	if (IS_ERR(channel->phy)) {
-		dev_err(dev, "Failed to create USB2 PHY\n");
-		ret = PTR_ERR(channel->phy);
-		goto error;
+	for (i = 0; i < NUM_OF_PHYS; i++) {
+		channel->rphys[i].phy = devm_phy_create(dev, NULL,
+						  &rcar_gen3_phy_usb2_ops);
+		if (IS_ERR(channel->rphys[i].phy)) {
+			dev_err(dev, "Failed to create USB2 PHY\n");
+			ret = PTR_ERR(channel->rphys[i].phy);
+			goto error;
+		}
+		channel->rphys[i].ch = channel;
+		channel->rphys[i].int_enable_bits = rcar_gen3_int_enable[i];
+		phy_set_drvdata(channel->rphys[i].phy, &channel->rphys[i]);
 	}
 
 	channel->vbus = devm_regulator_get_optional(dev, "vbus");
@@ -499,10 +631,9 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, channel);
-	phy_set_drvdata(channel->phy, channel);
 	channel->dev = dev;
 
-	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	provider = devm_of_phy_provider_register(dev, rcar_gen3_phy_usb2_xlate);
 	if (IS_ERR(provider)) {
 		dev_err(dev, "Failed to register PHY provider\n");
 		ret = PTR_ERR(provider);
-- 
2.7.4

