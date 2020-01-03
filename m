Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051C8C00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71B621835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="myhmmAFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgACIS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 03:18:29 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5964 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgACIS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:18:26 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0ef8c00001>; Fri, 03 Jan 2020 00:18:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 03 Jan 2020 00:18:24 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 03 Jan 2020 00:18:24 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jan
 2020 08:18:23 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 3 Jan 2020 08:18:23 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.108.118]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e0ef8cd0000>; Fri, 03 Jan 2020 00:18:23 -0800
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v5 2/5] phy: tegra: xusb: Add Tegra194 support
Date:   Fri, 3 Jan 2020 16:18:11 +0800
Message-ID: <20200103081814.9848-3-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103081814.9848-1-jckuo@nvidia.com>
References: <20200103081814.9848-1-jckuo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578039489; bh=Wed89M0um0gl+T6w+EXfV0IVn5tLZvtKGhYpmGXx9Ig=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=myhmmAFJudE8LNRCxfY1lSTUaM22103hOk5sW8AASS98Eu46//3J24ZmpgCBPT9bd
         O4VQkjwgUlEKZnUxRJCWsIYr/XhcP8mtwTwPLsTP9BkFE1D5IGTf0CNfvJEOBxHO4V
         qlC+q2DCEOKecT+5YFB8qnLjMn74B6O5acAaUf1hzWPXpdZqPHFVgbQmygDQy6UBsZ
         ymhV4zDAsVfMdApLeY0CDAYxDSqDAtTxrOVkjNOkz7S5IVOVwAY7C9M3QmZ8MvoCdE
         S5RGojIKHkR3pRetmad3EQpgHRWSB9qnIgRLTJ+RVsDLC9Shgg5alH0VGUbT3xLB6R
         TBixp7ycx5ABw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the XUSB pad controller found on Tegra194 SoCs. It is
mostly similar to the same IP found on Tegra186, but the number of
pads exposed differs, as do the programming sequences. Because most of
the Tegra194 XUSB PADCTL registers definition and programming sequence
are the same as Tegra186, Tegra194 XUSB PADCTL can share the same
driver, xusb-tegra186.c, with Tegra186 XUSB PADCTL.

Tegra194 XUSB PADCTL supports up to USB 3.1 Gen 2 speed, however, it
is possible for some platforms have long signal trace that could not
provide sufficient electrical environment for Gen 2 speed. This patch
adds a "maximum-speed" property to usb3 ports which can be used to
specify the maximum supported speed for any particular USB 3.1 port.
For a port that is not capable of SuperSpeedPlus, "maximum-speed"
property should carry "super-speed".

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
Changes in v5:
- re-use "maximum-speed" instead of adding "nvidia,disable-gen2"
Changes in v4: none
Changes in v3: none
Changes in v2:
- removed unnecessary #if/#endif pairs
- introduce new soc->supports_gen2 flag which indicate whether or not
  a soc supports USB 3.1 Gen 2 speed

 drivers/phy/tegra/Makefile        |  1 +
 drivers/phy/tegra/xusb-tegra186.c | 73 +++++++++++++++++++++++++++++++
 drivers/phy/tegra/xusb.c          | 17 +++++++
 drivers/phy/tegra/xusb.h          |  5 +++
 4 files changed, 96 insertions(+)

diff --git a/drivers/phy/tegra/Makefile b/drivers/phy/tegra/Makefile
index 320dd389f34d..89b84067cb4c 100644
--- a/drivers/phy/tegra/Makefile
+++ b/drivers/phy/tegra/Makefile
@@ -6,4 +6,5 @@ phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_124_SOC) += xusb-tegra124.o
 phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_132_SOC) += xusb-tegra124.o
 phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_210_SOC) += xusb-tegra210.o
 phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_186_SOC) += xusb-tegra186.o
+phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_194_SOC) += xusb-tegra186.o
 obj-$(CONFIG_PHY_TEGRA194_P2U) += phy-tegra194-p2u.o
diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index 01f7d979c9a8..f16016dcd260 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -63,6 +63,10 @@
 #define  SSPX_ELPG_CLAMP_EN(x)			BIT(0 + (x) * 3)
 #define  SSPX_ELPG_CLAMP_EN_EARLY(x)		BIT(1 + (x) * 3)
 #define  SSPX_ELPG_VCORE_DOWN(x)		BIT(2 + (x) * 3)
+#define XUSB_PADCTL_SS_PORT_CFG			0x2c
+#define   PORTX_SPEED_SUPPORT_SHIFT(x)		((x) * 4)
+#define   PORTX_SPEED_SUPPORT_MASK		(0x3)
+#define     PORT_SPEED_SUPPORT_GEN1		(0x0)
 
 #define XUSB_PADCTL_USB2_OTG_PADX_CTL0(x)	(0x88 + (x) * 0x40)
 #define  HS_CURR_LEVEL(x)			((x) & 0x3f)
@@ -622,6 +626,15 @@ static int tegra186_usb3_phy_power_on(struct phy *phy)
 
 	padctl_writel(padctl, value, XUSB_PADCTL_SS_PORT_CAP);
 
+	if (padctl->soc->supports_gen2 && port->disable_gen2) {
+		value = padctl_readl(padctl, XUSB_PADCTL_SS_PORT_CFG);
+		value &= ~(PORTX_SPEED_SUPPORT_MASK <<
+			PORTX_SPEED_SUPPORT_SHIFT(index));
+		value |= (PORT_SPEED_SUPPORT_GEN1 <<
+			PORTX_SPEED_SUPPORT_SHIFT(index));
+		padctl_writel(padctl, value, XUSB_PADCTL_SS_PORT_CFG);
+	}
+
 	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_1);
 	value &= ~SSPX_ELPG_VCORE_DOWN(index);
 	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_1);
@@ -919,6 +932,66 @@ const struct tegra_xusb_padctl_soc tegra186_xusb_padctl_soc = {
 EXPORT_SYMBOL_GPL(tegra186_xusb_padctl_soc);
 #endif
 
+#if IS_ENABLED(CONFIG_ARCH_TEGRA_194_SOC)
+static const char * const tegra194_xusb_padctl_supply_names[] = {
+	"avdd-usb",
+	"vclamp-usb",
+};
+
+static const struct tegra_xusb_lane_soc tegra194_usb2_lanes[] = {
+	TEGRA186_LANE("usb2-0", 0,  0, 0, usb2),
+	TEGRA186_LANE("usb2-1", 0,  0, 0, usb2),
+	TEGRA186_LANE("usb2-2", 0,  0, 0, usb2),
+	TEGRA186_LANE("usb2-3", 0,  0, 0, usb2),
+};
+
+static const struct tegra_xusb_pad_soc tegra194_usb2_pad = {
+	.name = "usb2",
+	.num_lanes = ARRAY_SIZE(tegra194_usb2_lanes),
+	.lanes = tegra194_usb2_lanes,
+	.ops = &tegra186_usb2_pad_ops,
+};
+
+static const struct tegra_xusb_lane_soc tegra194_usb3_lanes[] = {
+	TEGRA186_LANE("usb3-0", 0,  0, 0, usb3),
+	TEGRA186_LANE("usb3-1", 0,  0, 0, usb3),
+	TEGRA186_LANE("usb3-2", 0,  0, 0, usb3),
+	TEGRA186_LANE("usb3-3", 0,  0, 0, usb3),
+};
+
+static const struct tegra_xusb_pad_soc tegra194_usb3_pad = {
+	.name = "usb3",
+	.num_lanes = ARRAY_SIZE(tegra194_usb3_lanes),
+	.lanes = tegra194_usb3_lanes,
+	.ops = &tegra186_usb3_pad_ops,
+};
+
+static const struct tegra_xusb_pad_soc * const tegra194_pads[] = {
+	&tegra194_usb2_pad,
+	&tegra194_usb3_pad,
+};
+
+const struct tegra_xusb_padctl_soc tegra194_xusb_padctl_soc = {
+	.num_pads = ARRAY_SIZE(tegra194_pads),
+	.pads = tegra194_pads,
+	.ports = {
+		.usb2 = {
+			.ops = &tegra186_usb2_port_ops,
+			.count = 4,
+		},
+		.usb3 = {
+			.ops = &tegra186_usb3_port_ops,
+			.count = 4,
+		},
+	},
+	.ops = &tegra186_xusb_padctl_ops,
+	.supply_names = tegra194_xusb_padctl_supply_names,
+	.num_supplies = ARRAY_SIZE(tegra194_xusb_padctl_supply_names),
+	.supports_gen2 = true,
+};
+EXPORT_SYMBOL_GPL(tegra194_xusb_padctl_soc);
+#endif
+
 MODULE_AUTHOR("JC Kuo <jckuo@nvidia.com>");
 MODULE_DESCRIPTION("NVIDIA Tegra186 XUSB Pad Controller driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index f98ec3922c02..90b8fb187cf4 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -65,6 +65,12 @@ static const struct of_device_id tegra_xusb_padctl_of_match[] = {
 		.compatible = "nvidia,tegra186-xusb-padctl",
 		.data = &tegra186_xusb_padctl_soc,
 	},
+#endif
+#if defined(CONFIG_ARCH_TEGRA_194_SOC)
+	{
+		.compatible = "nvidia,tegra194-xusb-padctl",
+		.data = &tegra194_xusb_padctl_soc,
+	},
 #endif
 	{ }
 };
@@ -726,6 +732,7 @@ static int tegra_xusb_usb3_port_parse_dt(struct tegra_xusb_usb3_port *usb3)
 {
 	struct tegra_xusb_port *port = &usb3->base;
 	struct device_node *np = port->dev.of_node;
+	enum usb_device_speed maximum_speed;
 	u32 value;
 	int err;
 
@@ -739,6 +746,16 @@ static int tegra_xusb_usb3_port_parse_dt(struct tegra_xusb_usb3_port *usb3)
 
 	usb3->internal = of_property_read_bool(np, "nvidia,internal");
 
+	if (device_property_present(&port->dev, "maximum-speed")) {
+		maximum_speed =  usb_get_maximum_speed(&port->dev);
+		if (maximum_speed == USB_SPEED_SUPER)
+			usb3->disable_gen2 = true;
+		else if (maximum_speed == USB_SPEED_SUPER_PLUS)
+			usb3->disable_gen2 = false;
+		else
+			return -EINVAL;
+	}
+
 	usb3->supply = devm_regulator_get(&port->dev, "vbus");
 	return PTR_ERR_OR_ZERO(usb3->supply);
 }
diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
index da94fcce6307..e2152d4f1dbf 100644
--- a/drivers/phy/tegra/xusb.h
+++ b/drivers/phy/tegra/xusb.h
@@ -333,6 +333,7 @@ struct tegra_xusb_usb3_port {
 	bool context_saved;
 	unsigned int port;
 	bool internal;
+	bool disable_gen2;
 
 	u32 tap1;
 	u32 amp;
@@ -392,6 +393,7 @@ struct tegra_xusb_padctl_soc {
 
 	const char * const *supply_names;
 	unsigned int num_supplies;
+	bool supports_gen2;
 	bool need_fake_usb3_port;
 };
 
@@ -448,5 +450,8 @@ extern const struct tegra_xusb_padctl_soc tegra210_xusb_padctl_soc;
 #if defined(CONFIG_ARCH_TEGRA_186_SOC)
 extern const struct tegra_xusb_padctl_soc tegra186_xusb_padctl_soc;
 #endif
+#if defined(CONFIG_ARCH_TEGRA_194_SOC)
+extern const struct tegra_xusb_padctl_soc tegra194_xusb_padctl_soc;
+#endif
 
 #endif /* __PHY_TEGRA_XUSB_H */
-- 
2.17.1

