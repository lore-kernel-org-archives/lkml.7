Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC4AC2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62279227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="odVNpqv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLRJRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:17:04 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7986 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfLRJRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:17:03 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df9ee850002>; Wed, 18 Dec 2019 01:16:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 18 Dec 2019 01:17:02 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 18 Dec 2019 01:17:02 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Dec
 2019 09:17:02 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Dec 2019 09:17:01 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5df9ee8a0000>; Wed, 18 Dec 2019 01:17:01 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V2 03/18] phy: tegra: xusb: Add usb-role-switch support
Date:   Wed, 18 Dec 2019 14:46:16 +0530
Message-ID: <1576660591-10383-4-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576660613; bh=x7DNJtx7K7j6aI4PqzcwFF/s4OUu0rht9JklLWm6FVM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=odVNpqv+ReJSwdgjfGtceHWPcHBmJarecpntGokC5cddy0Anruv0GlOsPfA3xirlV
         ZkNEuTVp7qY8g4ga6MBHZ628XFoBHLLtwqjFlX9vwFVlJtG7djTtrX1jZ9tqK+iD59
         hAtSmh5mUY8ssewp1dXj8x16HOGYonWH092MKKaTwUmVHPERIbusxSGHbFf02RY4Oc
         TAnICVE3aKRQRpTdRYl07QExy7jWfolOnPrNZFqQuCoUxEjyJgqyCa6L0JSliTSj34
         PH0BOOlAMfHCO0rN7srUEcy1t/DvrhebzsNdsX1qPzlvHNrV/jbCRuXzmCym/dUhJ9
         PI27Cq+M/CBQA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If usb-role-switch property is present in USB 2 port, register
usb-role-switch to receive usb role changes.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V2:
 - Removed dev_set_drvdata for port->dev.
 - Added of_platform_depopulate during error handling and driver removal.
---
 drivers/phy/tegra/Kconfig |  1 +
 drivers/phy/tegra/xusb.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/tegra/xusb.h  |  3 +++
 3 files changed, 46 insertions(+)

diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
index f9817c3..df07c4d 100644
--- a/drivers/phy/tegra/Kconfig
+++ b/drivers/phy/tegra/Kconfig
@@ -2,6 +2,7 @@
 config PHY_TEGRA_XUSB
 	tristate "NVIDIA Tegra XUSB pad controller driver"
 	depends on ARCH_TEGRA
+	select USB_CONN_GPIO
 	help
 	  Choose this option if you have an NVIDIA Tegra SoC.
 
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index f98ec39..dc00b42 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -523,6 +523,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
 	port->dev.type = &tegra_xusb_port_type;
 	port->dev.of_node = of_node_get(np);
 	port->dev.parent = padctl->dev;
+	port->dev.driver = padctl->dev->driver;
 
 	err = dev_set_name(&port->dev, "%s-%u", name, index);
 	if (err < 0)
@@ -541,6 +542,10 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
 
 static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
 {
+	if (!IS_ERR_OR_NULL(port->usb_role_sw)) {
+		of_platform_depopulate(&port->dev);
+		usb_role_switch_unregister(port->usb_role_sw);
+	}
 	device_unregister(&port->dev);
 }
 
@@ -551,11 +556,42 @@ static const char *const modes[] = {
 	[USB_DR_MODE_OTG] = "otg",
 };
 
+static int tegra_xusb_role_sw_set(struct device *dev, enum usb_role role)
+{
+	dev_dbg(dev, "%s calling notifier for role is %d\n", __func__, role);
+
+	return 0;
+}
+
+static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
+{
+	int err = 0;
+	struct usb_role_switch_desc role_sx_desc = {
+					.set = tegra_xusb_role_sw_set,
+					.fwnode = dev_fwnode(&port->dev),
+						   };
+
+	port->usb_role_sw = usb_role_switch_register(&port->dev,
+						&role_sx_desc);
+	if (IS_ERR(port->usb_role_sw)) {
+		err = PTR_ERR(port->usb_role_sw);
+		if (err != EPROBE_DEFER)
+			dev_err(&port->dev, "Failed to register USB role SW: %d",
+				err);
+	}
+
+	/* populate connector entry */
+	of_platform_populate(port->dev.of_node, NULL, NULL, &port->dev);
+
+	return err;
+}
+
 static int tegra_xusb_usb2_port_parse_dt(struct tegra_xusb_usb2_port *usb2)
 {
 	struct tegra_xusb_port *port = &usb2->base;
 	struct device_node *np = port->dev.of_node;
 	const char *mode;
+	int err;
 
 	usb2->internal = of_property_read_bool(np, "nvidia,internal");
 
@@ -572,6 +608,12 @@ static int tegra_xusb_usb2_port_parse_dt(struct tegra_xusb_usb2_port *usb2)
 		usb2->mode = USB_DR_MODE_HOST;
 	}
 
+	if (of_property_read_bool(np, "usb-role-switch")) {
+		err = tegra_xusb_setup_usb_role_switch(port);
+		if (err < 0)
+			return err;
+	}
+
 	usb2->supply = devm_regulator_get(&port->dev, "vbus");
 	return PTR_ERR_OR_ZERO(usb2->supply);
 }
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index da94fcc..9f27899 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -12,6 +12,7 @@
 #include <linux/workqueue.h>
 
 #include <linux/usb/otg.h>
+#include <linux/usb/role.h>
 
 /* legacy entry points for backwards-compatibility */
 int tegra_xusb_padctl_legacy_probe(struct platform_device *pdev);
@@ -266,6 +267,8 @@ struct tegra_xusb_port {
 	struct list_head list;
 	struct device dev;
 
+	struct usb_role_switch *usb_role_sw;
+
 	const struct tegra_xusb_port_ops *ops;
 };
 
-- 
2.7.4

