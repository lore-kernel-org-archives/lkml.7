Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DADC2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 11:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFE5206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 11:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Cw9vVjIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfL3LOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 06:14:15 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1288 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfL3LON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 06:14:13 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e09dbf40000>; Mon, 30 Dec 2019 03:13:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 30 Dec 2019 03:14:11 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 30 Dec 2019 03:14:11 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 30 Dec
 2019 11:14:10 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 30 Dec 2019 11:14:10 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e09dbff0001>; Mon, 30 Dec 2019 03:14:10 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V3 09/18] usb: gadget: tegra-xudc: Remove usb-role-switch support
Date:   Mon, 30 Dec 2019 16:39:46 +0530
Message-ID: <1577704195-2535-10-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577704437; bh=Tb+6QcGT4TIuAHuh3Np227I+0UMJddTrYEy2C2dAEZY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Cw9vVjIJ2y+XeTpRkQ1AgclIxQfENQCvGX6ZNJ08cIgr2rRkUnldafqnJQZj91f+e
         GfJA03hyaaOsaIMmTyr0DQaTSvvQK6Mx5i1pXN/hy0muFoAoBScrAaZESnPPCeGzEo
         oY42U6HTpVtzVF/lKxeU9OYT17a09RJTOLnRiQiKYFRKQdfjvaqZw62+wX1VpU2QmC
         FP0LZmuj6vtCIe1H0+pLpHbgBxMBKCOxrpOlzrsK5DXQ8KhA/wEcrRRXiLlC6/LBNM
         3OdIkQH8K2LwwQUCyqOnUnAGAiRunBakqC3Y001n3wvKyI69dihogQlawhq9w//Pvz
         4YY3YOPux01Qw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Padctl driver will act as a central driver to receive USB role changes via
usb-role-switch. This is updated to corresponding host, device drivers.
Hence remove usb-role-switch from XUDC driver.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V2-V3:
 - No changes in this version
---
 drivers/usb/gadget/udc/tegra-xudc.c | 65 ++++++++++---------------------------
 1 file changed, 17 insertions(+), 48 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 634c2c1..6ddb974 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -477,8 +477,8 @@ struct tegra_xudc {
 
 	struct clk_bulk_data *clks;
 
-	enum usb_role device_mode;
-	struct usb_role_switch *usb_role_sw;
+	enum usb_role role;
+	bool device_mode;
 	struct work_struct usb_role_sw_work;
 
 	struct phy *usb3_phy;
@@ -596,6 +596,8 @@ static void tegra_xudc_device_mode_on(struct tegra_xudc *xudc)
 {
 	int err;
 
+	if (xudc->device_mode)
+		return;
 	pm_runtime_get_sync(xudc->dev);
 
 	err = phy_power_on(xudc->utmi_phy);
@@ -610,7 +612,8 @@ static void tegra_xudc_device_mode_on(struct tegra_xudc *xudc)
 
 	tegra_xusb_padctl_set_vbus_override(xudc->padctl, true);
 
-	xudc->device_mode = USB_ROLE_DEVICE;
+	xudc->device_mode = true;
+
 }
 
 static void tegra_xudc_device_mode_off(struct tegra_xudc *xudc)
@@ -619,6 +622,9 @@ static void tegra_xudc_device_mode_off(struct tegra_xudc *xudc)
 	u32 pls, val;
 	int err;
 
+	if (!xudc->device_mode)
+		return;
+
 	dev_dbg(xudc->dev, "device mode off\n");
 
 	connected = !!(xudc_readl(xudc, PORTSC) & PORTSC_CCS);
@@ -643,7 +649,7 @@ static void tegra_xudc_device_mode_off(struct tegra_xudc *xudc)
 		xudc_writel(xudc, val, PORTSC);
 	}
 
-	xudc->device_mode = USB_ROLE_NONE;
+	xudc->device_mode = false;
 
 	/* Wait for disconnect event. */
 	if (connected)
@@ -668,31 +674,13 @@ static void tegra_xudc_usb_role_sw_work(struct work_struct *work)
 	struct tegra_xudc *xudc = container_of(work, struct tegra_xudc,
 					       usb_role_sw_work);
 
-	if (!xudc->usb_role_sw ||
-		usb_role_switch_get_role(xudc->usb_role_sw) == USB_ROLE_DEVICE)
+	if (xudc->role == USB_ROLE_DEVICE)
 		tegra_xudc_device_mode_on(xudc);
 	else
 		tegra_xudc_device_mode_off(xudc);
 
 }
 
-static int tegra_xudc_usb_role_sw_set(struct device *dev, enum usb_role role)
-{
-	struct tegra_xudc *xudc = dev_get_drvdata(dev);
-	unsigned long flags;
-
-	dev_dbg(dev, "%s role is %d\n", __func__, role);
-
-	spin_lock_irqsave(&xudc->lock, flags);
-
-	if (!xudc->suspended)
-		schedule_work(&xudc->usb_role_sw_work);
-
-	spin_unlock_irqrestore(&xudc->lock, flags);
-
-	return 0;
-}
-
 static void tegra_xudc_plc_reset_work(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
@@ -729,8 +717,7 @@ static void tegra_xudc_port_reset_war_work(struct work_struct *work)
 
 	spin_lock_irqsave(&xudc->lock, flags);
 
-	if ((xudc->device_mode == USB_ROLE_DEVICE)
-			      && xudc->wait_for_sec_prc) {
+	if (xudc->device_mode && xudc->wait_for_sec_prc) {
 		pls = (xudc_readl(xudc, PORTSC) & PORTSC_PLS_MASK) >>
 			PORTSC_PLS_SHIFT;
 		dev_dbg(xudc->dev, "pls = %x\n", pls);
@@ -3457,7 +3444,6 @@ static int tegra_xudc_probe(struct platform_device *pdev)
 {
 	struct tegra_xudc *xudc;
 	struct resource *res;
-	struct usb_role_switch_desc role_sx_desc = { 0 };
 	unsigned int i;
 	int err;
 
@@ -3587,23 +3573,10 @@ static int tegra_xudc_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&xudc->port_reset_war_work,
 				tegra_xudc_port_reset_war_work);
 
-	if (of_property_read_bool(xudc->dev->of_node, "usb-role-switch")) {
-		role_sx_desc.set = tegra_xudc_usb_role_sw_set;
-		role_sx_desc.fwnode = dev_fwnode(xudc->dev);
-
-		xudc->usb_role_sw = usb_role_switch_register(xudc->dev,
-							&role_sx_desc);
-		if (IS_ERR(xudc->usb_role_sw)) {
-			err = PTR_ERR(xudc->usb_role_sw);
-			dev_err(xudc->dev, "Failed to register USB role SW: %d",
-					   err);
-			goto free_eps;
-		}
-	} else {
-		/* Set the mode as device mode and this keeps phy always ON */
-		dev_info(xudc->dev, "Set usb role to device mode always");
-		schedule_work(&xudc->usb_role_sw_work);
-	}
+	/* Set the mode as device mode and this keeps phy always ON */
+	dev_info(xudc->dev, "Set usb role to device mode always");
+	xudc->role = USB_ROLE_DEVICE;
+	schedule_work(&xudc->usb_role_sw_work);
 
 	pm_runtime_enable(&pdev->dev);
 
@@ -3643,11 +3616,7 @@ static int tegra_xudc_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(xudc->dev);
 
 	cancel_delayed_work(&xudc->plc_reset_work);
-
-	if (xudc->usb_role_sw) {
-		usb_role_switch_unregister(xudc->usb_role_sw);
-		cancel_work_sync(&xudc->usb_role_sw_work);
-	}
+	cancel_work_sync(&xudc->usb_role_sw_work);
 
 	usb_del_gadget_udc(&xudc->gadget);
 
-- 
2.7.4

