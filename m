Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98902C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D6724673
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Yw/y2P6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfLFKvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:51:54 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6276 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfLFKvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:51:52 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dea32c20000>; Fri, 06 Dec 2019 02:51:46 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 06 Dec 2019 02:51:51 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 06 Dec 2019 02:51:51 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec
 2019 10:51:51 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Dec 2019 10:51:50 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dea32c30001>; Fri, 06 Dec 2019 02:51:50 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH 07/18] phy: tegra: xusb: Add set_mode support for utmi phy on Tegra186
Date:   Fri, 6 Dec 2019 16:20:10 +0530
Message-ID: <1575629421-7039-8-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575629421-7039-1-git-send-email-nkristam@nvidia.com>
References: <1575629421-7039-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575629507; bh=P44R/17zH9u7ehxiyjxixtV9BvysLx+hrKbha83OhtU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Yw/y2P6xcNTRZVsRyvNqKL4C6cac8qBC2/9fmLztK/imthvIBUjDtJK/JK13GtoCD
         aLJIqGZ3hcFqDw1sY1qzAg8zdZ+QMU9vpJTvsan58umMJThHC1plHTsvJUL2+PWTNd
         gIiYjE6cwdON1aI8kVIX+idt0S8N6gz+DKxSGHwmq4558pzJitxAT+eTvFKcA6fODo
         YjEh7Qsm+aQnkIuWTYWnwQKneJ+/aMcop2U9dFtCaZFlr8SHM/AnWxSRonXRqyEGmV
         czpeai8Q+f7hlGPEKBPFIaZdid/kT2dY2sAFniljaMSVSXg1yv8NBf/4/izlIBA/xg
         YYlUvUaBforXw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for set_mode on utmi phy. This allow XUSB host/device mode
drivers to configure the hardware to corresponding modes.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
 drivers/phy/tegra/xusb-tegra186.c | 109 ++++++++++++++++++++++++++++++--------
 1 file changed, 87 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index 84c2739..9a45160 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -301,6 +301,92 @@ static void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy)
 	tegra186_utmi_bias_pad_power_off(padctl);
 }
 
+static int tegra186_xusb_padctl_vbus_override(struct tegra_xusb_padctl *padctl,
+					       bool status)
+{
+	u32 value;
+
+	dev_dbg(padctl->dev, "%s vbus override\n", status ? "set" : "clear");
+
+	value = padctl_readl(padctl, USB2_VBUS_ID);
+
+	if (status) {
+		value |= VBUS_OVERRIDE;
+		value &= ~ID_OVERRIDE(~0);
+		value |= ID_OVERRIDE_FLOATING;
+	} else {
+		value &= ~VBUS_OVERRIDE;
+	}
+
+	padctl_writel(padctl, value, USB2_VBUS_ID);
+
+	return 0;
+}
+
+static int tegra186_xusb_padctl_id_override(struct tegra_xusb_padctl *padctl,
+					    bool status)
+{
+	u32 value;
+
+	dev_dbg(padctl->dev, "%s id override\n", status ? "set" : "clear");
+
+	value = padctl_readl(padctl, USB2_VBUS_ID);
+
+	if (status) {
+		if (value & VBUS_OVERRIDE) {
+			value &= ~VBUS_OVERRIDE;
+			padctl_writel(padctl, value, USB2_VBUS_ID);
+			usleep_range(1000, 2000);
+
+			value = padctl_readl(padctl, USB2_VBUS_ID);
+		}
+
+		value &= ~ID_OVERRIDE(~0);
+		value |= ID_OVERRIDE_GROUNDED;
+	} else {
+		value &= ~ID_OVERRIDE(~0);
+		value |= ID_OVERRIDE_FLOATING;
+	}
+
+	padctl_writel(padctl, value, USB2_VBUS_ID);
+
+	return 0;
+}
+
+static int tegra186_utmi_phy_set_mode(struct phy *phy, enum phy_mode mode,
+				      int submode)
+{
+	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
+	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
+	struct tegra_xusb_usb2_port *port = tegra_xusb_find_usb2_port(padctl,
+								lane->index);
+	int err = 0;
+
+	mutex_lock(&padctl->lock);
+
+	dev_dbg(&port->base.dev, "%s: mode %d", __func__, mode);
+
+	if (mode == PHY_MODE_USB_OTG) {
+		if (submode == USB_ROLE_HOST) {
+			tegra186_xusb_padctl_id_override(padctl, true);
+
+			err = regulator_enable(port->supply);
+		} else if (submode == USB_ROLE_DEVICE) {
+			tegra186_xusb_padctl_vbus_override(padctl, true);
+		} else if (submode == USB_ROLE_NONE) {
+			if (regulator_is_enabled(port->supply))
+				regulator_disable(port->supply);
+
+			tegra186_xusb_padctl_id_override(padctl, false);
+			tegra186_xusb_padctl_vbus_override(padctl, false);
+		}
+	}
+
+	mutex_unlock(&padctl->lock);
+
+	return err;
+}
+
 static int tegra186_utmi_phy_power_on(struct phy *phy)
 {
 	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
@@ -439,6 +525,7 @@ static const struct phy_ops utmi_phy_ops = {
 	.exit = tegra186_utmi_phy_exit,
 	.power_on = tegra186_utmi_phy_power_on,
 	.power_off = tegra186_utmi_phy_power_off,
+	.set_mode = tegra186_utmi_phy_set_mode,
 	.owner = THIS_MODULE,
 };
 
@@ -857,28 +944,6 @@ static void tegra186_xusb_padctl_remove(struct tegra_xusb_padctl *padctl)
 {
 }
 
-static int tegra186_xusb_padctl_vbus_override(struct tegra_xusb_padctl *padctl,
-					       bool status)
-{
-	u32 value;
-
-	dev_dbg(padctl->dev, "%s vbus override\n", status ? "set" : "clear");
-
-	value = padctl_readl(padctl, USB2_VBUS_ID);
-
-	if (status) {
-		value |= VBUS_OVERRIDE;
-		value &= ~ID_OVERRIDE(~0);
-		value |= ID_OVERRIDE_FLOATING;
-	} else {
-		value &= ~VBUS_OVERRIDE;
-	}
-
-	padctl_writel(padctl, value, USB2_VBUS_ID);
-
-	return 0;
-}
-
 static const struct tegra_xusb_padctl_ops tegra186_xusb_padctl_ops = {
 	.probe = tegra186_xusb_padctl_probe,
 	.remove = tegra186_xusb_padctl_remove,
-- 
2.7.4

