Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51589C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B57521823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GSl0nKF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfLFKvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:51:44 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6265 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfLFKvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:51:41 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dea32b80000>; Fri, 06 Dec 2019 02:51:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 06 Dec 2019 02:51:40 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 06 Dec 2019 02:51:40 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec
 2019 10:51:40 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec
 2019 10:51:40 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Dec 2019 10:51:39 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dea32b80002>; Fri, 06 Dec 2019 02:51:39 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Nagarjuna Kristam" <nkristam@nvidia.com>
Subject: [PATCH 04/18] phy: tegra: xusb: Add usb-phy support
Date:   Fri, 6 Dec 2019 16:20:07 +0530
Message-ID: <1575629421-7039-5-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575629421-7039-1-git-send-email-nkristam@nvidia.com>
References: <1575629421-7039-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575629496; bh=54B9sI0gNaLRwL3sP0cWRsNBstt3TZPF1FLqk0X5ugg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=GSl0nKF89jrCh2IZ4yAjWDlxzBMVTm6ltslYF2wPjetmf2bQU2DV8NlDz7uOr57uU
         ECrWYHsblxomPs1nxi3rnDsuEaO2/Tb93yhqiuK3S1KFicZ9FaGoMpydsrtODiLOw2
         mpht9DmnooPVtEXiy4gKncV8I/vu6mkwZKhBNmNAGtlLLmDLN0GsCy2N+twuN+N7Y7
         6SefchLlWFQvJOlMDB2Hjgha851gzDkBtV53lKD5IWanVfXswly298H9feRmDgdNnI
         OOzN99WckXSU9Bx9MJKj166SKB0d9bDB844V4cQocqkHup75/7mynaI5hI3OFKMBzu
         D8V5h02ywWLtw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For USB 2 ports that has usb-role-switch enabled, add usb-phy for
corresponding USB 2 phy. USB role changes from role switch are then
updated to corresponding host and device mode drivers via usb-phy notifier
block.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
 drivers/phy/tegra/xusb.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/phy/tegra/xusb.h |  2 ++
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index da60a63..4c86c99 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -543,7 +543,11 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
 
 static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
 {
-	usb_role_switch_unregister(port->usb_role_sw);
+	if (port->usb_role_sw) {
+		cancel_work_sync(&port->usb_phy_work);
+		usb_role_switch_unregister(port->usb_role_sw);
+		usb_remove_phy(&port->usb_phy);
+	}
 	device_unregister(&port->dev);
 }
 
@@ -554,16 +558,59 @@ static const char *const modes[] = {
 	[USB_DR_MODE_OTG] = "otg",
 };
 
+static void tegra_xusb_usb_phy_work(struct work_struct *work)
+{
+	struct tegra_xusb_port *port = container_of(work,
+				struct tegra_xusb_port, usb_phy_work);
+	enum usb_role role = usb_role_switch_get_role(port->usb_role_sw);
+
+	dev_dbg(&port->dev, "%s calling notifier for role %d\n", __func__,
+		role);
+
+	atomic_notifier_call_chain(&port->usb_phy.notifier, role,
+				   &port->usb_phy);
+}
+
 static int tegra_xusb_role_sw_set(struct device *dev, enum usb_role role)
 {
+	struct tegra_xusb_port *port = dev_get_drvdata(dev);
+
 	dev_dbg(dev, "%s calling notifier for role is %d\n", __func__, role);
 
+	schedule_work(&port->usb_phy_work);
+
+	return 0;
+}
+
+static int tegra_xusb_set_peripheral(struct usb_otg *otg,
+					struct usb_gadget *gadget)
+{
+	struct tegra_xusb_port *port = container_of(otg->usb_phy,
+					struct tegra_xusb_port, usb_phy);
+
+	if (gadget != NULL)
+		schedule_work(&port->usb_phy_work);
+
+	return 0;
+}
+
+static int tegra_xusb_set_host(struct usb_otg *otg, struct usb_bus *host)
+{
+	struct tegra_xusb_port *port = container_of(otg->usb_phy,
+					struct tegra_xusb_port, usb_phy);
+
+	if (host != NULL)
+		schedule_work(&port->usb_phy_work);
+
 	return 0;
 }
 
+
 static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
 {
 	int err = 0;
+	struct tegra_xusb_lane *lane = tegra_xusb_find_lane(port->padctl,
+							"usb2", port->index);
 	struct usb_role_switch_desc role_sx_desc = {
 					.set = tegra_xusb_role_sw_set,
 					.fwnode = dev_fwnode(&port->dev),
@@ -576,6 +623,30 @@ static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
 		if (err != EPROBE_DEFER)
 			dev_err(&port->dev, "Failed to register USB role SW: %d",
 				err);
+		return err;
+	}
+
+	INIT_WORK(&port->usb_phy_work, tegra_xusb_usb_phy_work);
+
+	port->usb_phy.otg = devm_kzalloc(&port->dev,
+					 sizeof(struct usb_otg), GFP_KERNEL);
+	if (!port->usb_phy.otg)
+		return -ENOMEM;
+
+	/*
+	 * Assign phy dev to usb-phy dev. Host/device drivers can use phy
+	 * reference to retrieve usb-phy details.
+	 */
+	port->usb_phy.dev = &lane->pad->lanes[port->index]->dev;
+	port->usb_phy.dev->driver = port->padctl->dev->driver;
+	port->usb_phy.otg->usb_phy = &port->usb_phy;
+	port->usb_phy.otg->set_peripheral = tegra_xusb_set_peripheral;
+	port->usb_phy.otg->set_host = tegra_xusb_set_host;
+
+	err = usb_add_phy_dev(&port->usb_phy);
+	if (err < 0) {
+		dev_err(&port->dev, "Failed to add usbphy: %d\n", err);
+		return err;
 	}
 
 	return err;
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index 9f27899..2345657 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -268,6 +268,8 @@ struct tegra_xusb_port {
 	struct device dev;
 
 	struct usb_role_switch *usb_role_sw;
+	struct work_struct usb_phy_work;
+	struct usb_phy usb_phy;
 
 	const struct tegra_xusb_port_ops *ops;
 };
-- 
2.7.4

