Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B9AC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9690B22CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TVE7FWHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfIDIY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:24:27 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1162 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfIDIYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:24:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6f74bb0000>; Wed, 04 Sep 2019 01:24:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 04 Sep 2019 01:24:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 04 Sep 2019 01:24:24 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 08:24:24 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Sep 2019 08:24:24 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.65.118]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6f74b50001>; Wed, 04 Sep 2019 01:24:23 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V8 2/8] phy: tegra: xusb: Add usb3 port fake support on Tegra210
Date:   Wed, 4 Sep 2019 13:53:54 +0530
Message-ID: <1567585440-13751-3-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567585440-13751-1-git-send-email-nkristam@nvidia.com>
References: <1567585440-13751-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567585467; bh=QsSZEDq8PkVrsmOxkPx4EBlDxs1Mat8fn0AnI2zDt38=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=TVE7FWHptA3klhqTiOrqTVlMLFCDduEPB/wOkU/3LFcoFDAKWyLWD4T0f+lRjjWKc
         ue4X2nT149SnUYsP1OgZwTkkVuY6pRoC+GsUDjgOwhlnACab9in6BP7FnXMhi8mC6I
         QvAVn4Jrl3/mPTQ2qHKrnGUi2LMf6/LOegC5aFfsRR+mycUwwVpxwk8KBT/qTWyNHT
         uZwyoNbAjdX3APRIH34JLQS3d36ERvDjdF2pV1mvv6ZOU5H5OdEOjwlsRt3uXB8s0b
         gfkC33vGU0o8U3hLeJ/Bibb4XRRBA4eB+iK63Ju33yEnz3hYMW6kn5yFWu6W2gFHnx
         yhsxPFXhoad/g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tegra210, usb2 only otg/peripheral ports dont work in device mode.
They need an assosciated usb3 port to work in device mode. Identify
an unused usb3 port and assign it as a fake USB3 port to USB2 only
port whose mode is otg/peripheral.

Based on work by BH Hsieh <bhsieh@nvidia.com>.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/phy/tegra/xusb-tegra210.c | 56 +++++++++++++++++++++++++++++++++
 drivers/phy/tegra/xusb.c          | 65 +++++++++++++++++++++++++++++++++++++++
 drivers/phy/tegra/xusb.h          |  2 ++
 3 files changed, 123 insertions(+)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
index 0351c4a..8c31f03 100644
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -50,6 +50,7 @@
 #define XUSB_PADCTL_SS_PORT_MAP_PORTX_MAP_SHIFT(x) ((x) * 5)
 #define XUSB_PADCTL_SS_PORT_MAP_PORTX_MAP_MASK(x) (0x7 << ((x) * 5))
 #define XUSB_PADCTL_SS_PORT_MAP_PORTX_MAP(x, v) (((v) & 0x7) << ((x) * 5))
+#define XUSB_PADCTL_SS_PORT_MAP_PORT_DISABLED 0x7
 
 #define XUSB_PADCTL_ELPG_PROGRAM1 0x024
 #define XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_VCORE_DOWN (1 << 31)
@@ -944,6 +945,34 @@ static int tegra210_usb2_phy_power_on(struct phy *phy)
 
 	priv = to_tegra210_xusb_padctl(padctl);
 
+	if (port->usb3_port_fake != -1) {
+		value = padctl_readl(padctl, XUSB_PADCTL_SS_PORT_MAP);
+		value &= ~XUSB_PADCTL_SS_PORT_MAP_PORTX_MAP_MASK(
+					port->usb3_port_fake);
+		value |= XUSB_PADCTL_SS_PORT_MAP_PORTX_MAP(
+					port->usb3_port_fake, index);
+		padctl_writel(padctl, value, XUSB_PADCTL_SS_PORT_MAP);
+
+		value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
+		value &= ~XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_VCORE_DOWN(
+					port->usb3_port_fake);
+		padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
+
+		usleep_range(100, 200);
+
+		value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
+		value &= ~XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN_EARLY(
+					port->usb3_port_fake);
+		padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
+
+		usleep_range(100, 200);
+
+		value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
+		value &= ~XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN(
+					port->usb3_port_fake);
+		padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
+	}
+
 	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
 	value &= ~((XUSB_PADCTL_USB2_BIAS_PAD_CTL0_HS_SQUELCH_LEVEL_MASK <<
 		    XUSB_PADCTL_USB2_BIAS_PAD_CTL0_HS_SQUELCH_LEVEL_SHIFT) |
@@ -1078,6 +1107,32 @@ static int tegra210_usb2_phy_power_off(struct phy *phy)
 
 	mutex_lock(&padctl->lock);
 
+	if (port->usb3_port_fake != -1) {
+		value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
+		value |= XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN_EARLY(
+					port->usb3_port_fake);
+		padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
+
+		usleep_range(100, 200);
+
+		value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
+		value |= XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN(
+					port->usb3_port_fake);
+		padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
+
+		usleep_range(250, 350);
+
+		value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
+		value |= XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_VCORE_DOWN(
+					port->usb3_port_fake);
+		padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
+
+		value = padctl_readl(padctl, XUSB_PADCTL_SS_PORT_MAP);
+		value |= XUSB_PADCTL_SS_PORT_MAP_PORTX_MAP(port->usb3_port_fake,
+					XUSB_PADCTL_SS_PORT_MAP_PORT_DISABLED);
+		padctl_writel(padctl, value, XUSB_PADCTL_SS_PORT_MAP);
+	}
+
 	if (WARN_ON(pad->enable == 0))
 		goto out;
 
@@ -2052,6 +2107,7 @@ const struct tegra_xusb_padctl_soc tegra210_xusb_padctl_soc = {
 	.ops = &tegra210_xusb_padctl_ops,
 	.supply_names = tegra210_xusb_padctl_supply_names,
 	.num_supplies = ARRAY_SIZE(tegra210_xusb_padctl_supply_names),
+	.need_fake_usb3_port = true,
 };
 EXPORT_SYMBOL_GPL(tegra210_xusb_padctl_soc);
 
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 2ea8497..b4b217e 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -800,9 +800,62 @@ static void __tegra_xusb_remove_ports(struct tegra_xusb_padctl *padctl)
 	}
 }
 
+static int tegra_xusb_find_unused_usb3_port(struct tegra_xusb_padctl *padctl)
+{
+	struct device_node *np;
+	unsigned int i;
+
+	for (i = 0; i < padctl->soc->ports.usb3.count; i++) {
+		np = tegra_xusb_find_port_node(padctl, "usb3", i);
+		if (!np || !of_device_is_available(np))
+			return i;
+	}
+
+	return -ENODEV;
+}
+
+static bool tegra_xusb_port_is_companion(struct tegra_xusb_usb2_port *usb2)
+{
+	unsigned int i;
+	struct tegra_xusb_usb3_port *usb3;
+	struct tegra_xusb_padctl *padctl = usb2->base.padctl;
+
+	for (i = 0; i < padctl->soc->ports.usb3.count; i++) {
+		usb3 = tegra_xusb_find_usb3_port(padctl, i);
+		if (usb3 && usb3->port == usb2->base.index)
+			return true;
+	}
+
+	return false;
+}
+
+static int tegra_xusb_update_usb3_fake_port(struct tegra_xusb_usb2_port *usb2)
+{
+	int fake;
+
+	/* Disable usb3_port_fake usage by default and assign if needed */
+	usb2->usb3_port_fake = -1;
+
+	if ((usb2->mode == USB_DR_MODE_OTG ||
+	     usb2->mode == USB_DR_MODE_PERIPHERAL) &&
+		!tegra_xusb_port_is_companion(usb2)) {
+		fake = tegra_xusb_find_unused_usb3_port(usb2->base.padctl);
+		if (fake < 0) {
+			dev_err(&usb2->base.dev, "no unused USB3 ports available\n");
+			return -ENODEV;
+		}
+
+		dev_dbg(&usb2->base.dev, "Found unused usb3 port: %d\n", fake);
+		usb2->usb3_port_fake = fake;
+	}
+
+	return 0;
+}
+
 static int tegra_xusb_setup_ports(struct tegra_xusb_padctl *padctl)
 {
 	struct tegra_xusb_port *port;
+	struct tegra_xusb_usb2_port *usb2;
 	unsigned int i;
 	int err = 0;
 
@@ -832,6 +885,18 @@ static int tegra_xusb_setup_ports(struct tegra_xusb_padctl *padctl)
 			goto remove_ports;
 	}
 
+	if (padctl->soc->need_fake_usb3_port) {
+		for (i = 0; i < padctl->soc->ports.usb2.count; i++) {
+			usb2 = tegra_xusb_find_usb2_port(padctl, i);
+			if (!usb2)
+				continue;
+
+			err = tegra_xusb_update_usb3_fake_port(usb2);
+			if (err < 0)
+				goto remove_ports;
+		}
+	}
+
 	list_for_each_entry(port, &padctl->ports, list) {
 		err = port->ops->enable(port);
 		if (err < 0)
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index 093076c..bd91832 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -291,6 +291,7 @@ struct tegra_xusb_usb2_port {
 	struct regulator *supply;
 	enum usb_dr_mode mode;
 	bool internal;
+	int usb3_port_fake;
 };
 
 static inline struct tegra_xusb_usb2_port *
@@ -389,6 +390,7 @@ struct tegra_xusb_padctl_soc {
 
 	const char * const *supply_names;
 	unsigned int num_supplies;
+	bool need_fake_usb3_port;
 };
 
 struct tegra_xusb_padctl {
-- 
2.7.4

