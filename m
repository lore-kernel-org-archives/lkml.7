Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BB7C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 11:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6970206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 11:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LgI5EOub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfL3LN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 06:13:56 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19407 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbfL3LNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 06:13:53 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e09dbe20001>; Mon, 30 Dec 2019 03:13:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 30 Dec 2019 03:13:52 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 30 Dec 2019 03:13:52 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 30 Dec
 2019 11:13:52 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 30 Dec 2019 11:13:52 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e09dbec0000>; Mon, 30 Dec 2019 03:13:51 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V3 04/18] phy: tegra: xusb: Add usb-phy support
Date:   Mon, 30 Dec 2019 16:39:41 +0530
Message-ID: <1577704195-2535-5-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577704419; bh=3MhRd+w8lQGRFFrJCEC3ztegf9VwdtGbQrvzb1f4y/Q=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=LgI5EOubGwIM6xnUK/VHk4Cdzzo9bHuuGGkmwLiXeerxPv9rrk/2l1sE5MJjOxGKv
         pzXLQdzyJOKJ6G/ZUicldnFFNN/MhCaAt3aT4FUbbuD5G/tx/5UgWzPaDpPp+GZF0N
         +tmXVnWuqfA0yA/5NpJj67cZs9fBP0wq0NlH/tnxxuDBqftz/aWY/VkRGZu2Uag5N8
         BhePuMTAtMMNPe5Qj5jk5TVtMPyPZ5bAV1kZwY9XrqyjmhZW1+cOUYgNmllHI5Eyxb
         InXTZ3j1JDjRzWAYPutQav1KPqjMBmsG50fUKmFkIhopN4uoIKjh2VGxW1SXUV3SEq
         80M/s0z0qO8UA==
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
V3:
 - Updated arguments and variable allignments as per Thierry inputs.
---
V2:
 - Added dev_set_drvdata for port->dev.
---
 drivers/phy/tegra/xusb.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/tegra/xusb.h |  2 ++
 2 files changed, 76 insertions(+)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 11ea9b5..536b2fc 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -533,6 +533,8 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
 	if (err < 0)
 		goto unregister;
 
+	dev_set_drvdata(&port->dev, port);
+
 	return 0;
 
 unregister:
@@ -545,6 +547,8 @@ static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
 	if (!IS_ERR_OR_NULL(port->usb_role_sw)) {
 		of_platform_depopulate(&port->dev);
 		usb_role_switch_unregister(port->usb_role_sw);
+		cancel_work_sync(&port->usb_phy_work);
+		usb_remove_phy(&port->usb_phy);
 	}
 
 	device_unregister(&port->dev);
@@ -563,15 +567,62 @@ static const char * const usb_roles[] = {
 	[USB_ROLE_DEVICE]	= "device",
 };
 
+static void tegra_xusb_usb_phy_work(struct work_struct *work)
+{
+	struct tegra_xusb_port *port = container_of(work,
+						    struct tegra_xusb_port,
+						    usb_phy_work);
+	enum usb_role role = usb_role_switch_get_role(port->usb_role_sw);
+
+	dev_dbg(&port->dev, "%s: calling notifier for role %s\n", __func__,
+		usb_roles[role]);
+
+	atomic_notifier_call_chain(&port->usb_phy.notifier, role,
+				   &port->usb_phy);
+}
+
 static int tegra_xusb_role_sw_set(struct device *dev, enum usb_role role)
 {
+	struct tegra_xusb_port *port = dev_get_drvdata(dev);
+
 	dev_dbg(dev, "%s: role %s\n", __func__, usb_roles[role]);
 
+	schedule_work(&port->usb_phy_work);
+
 	return 0;
 }
 
+static int tegra_xusb_set_peripheral(struct usb_otg *otg,
+				     struct usb_gadget *gadget)
+{
+	struct tegra_xusb_port *port = container_of(otg->usb_phy,
+						    struct tegra_xusb_port,
+						    usb_phy);
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
+						    struct tegra_xusb_port,
+						    usb_phy);
+
+	if (host != NULL)
+		schedule_work(&port->usb_phy_work);
+
+	return 0;
+}
+
+
 static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
 {
+	struct tegra_xusb_lane *lane = tegra_xusb_find_lane(port->padctl,
+							    "usb2",
+							    port->index);
 	struct usb_role_switch_desc role_sx_desc = {
 		.fwnode = dev_fwnode(&port->dev),
 		.set = tegra_xusb_role_sw_set,
@@ -587,6 +638,29 @@ static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
 		return err;
 	}
 
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
+	}
+
 	/* populate connector entry */
 	of_platform_populate(port->dev.of_node, NULL, NULL, &port->dev);
 
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

