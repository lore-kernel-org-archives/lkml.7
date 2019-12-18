Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003E2C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC1320717
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dNN3hJSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfLRJS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:18:28 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19120 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfLRJRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:17:11 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df9ee8d0000>; Wed, 18 Dec 2019 01:17:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 18 Dec 2019 01:17:10 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 18 Dec 2019 01:17:10 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Dec
 2019 09:17:10 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Dec
 2019 09:17:10 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Dec 2019 09:17:09 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5df9ee920000>; Wed, 18 Dec 2019 01:17:09 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Nagarjuna Kristam" <nkristam@nvidia.com>
Subject: [Patch V2 05/18] phy: tegra: xusb: Add support to get companion USB 3 port
Date:   Wed, 18 Dec 2019 14:46:18 +0530
Message-ID: <1576660591-10383-6-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576660621; bh=RXPO69Y2JGFUoofmuP9dolCBdU3ItrnS7wncxYo5Sks=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=dNN3hJSQ2mErR/a7etROcC/9D3PfkQHa+p4VgUOD54Z4krMxkaBidahQZ+9A0nrES
         rSksPcpzOKSb1b0gfewOecbt+tWAcd4XCU08iUazOzjCotRIfyGjutz/Jpy6LVPN23
         ANVQHK3NmpLHlfIDSstAWHGnr/A6YNSQE+9vY+LrGdMDVR1hmrYtMwWyf365AtGw0O
         yYxTqpUqMmr6LrH2nX7P+uoj4yQF2tuKmt1+4ckGiMa531hyprQqsDEBMscf0d4zIs
         vW8irLnSNM7qe+5i3Yv/mi56XGVoKEpLI86C378e3vBkuwL/vsbFpx2Ogl7rjXIcW7
         z0p99dreUGk8g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra XUSB host, device mode driver requires the USB 3 companion port
number for corresponding USB 2 port. Add API to retrieve the same.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V2:
 - Added -ENODEV as return instead of -1, to sync other errors.
---
 drivers/phy/tegra/xusb.c       | 21 +++++++++++++++++++++
 include/linux/phy/tegra/xusb.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 5bde8f1..e75cd71 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -1256,6 +1256,27 @@ int tegra_phy_xusb_utmi_port_reset(struct phy *phy)
 }
 EXPORT_SYMBOL_GPL(tegra_phy_xusb_utmi_port_reset);
 
+int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
+				    unsigned int port)
+{
+	struct tegra_xusb_usb2_port *usb2 = tegra_xusb_find_usb2_port(padctl,
+								      port);
+	struct tegra_xusb_usb3_port *usb3;
+	int i;
+
+	if (!usb2)
+		return -EINVAL;
+
+	for (i = 0; i < padctl->soc->ports.usb3.count; i++) {
+		usb3 = tegra_xusb_find_usb3_port(padctl, i);
+		if (usb3 && usb3->port == usb2->base.index)
+			return usb3->base.index;
+	}
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(tegra_xusb_padctl_get_usb3_companion);
+
 MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
 MODULE_DESCRIPTION("Tegra XUSB Pad Controller driver");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/phy/tegra/xusb.h b/include/linux/phy/tegra/xusb.h
index 1235865..71d9569 100644
--- a/include/linux/phy/tegra/xusb.h
+++ b/include/linux/phy/tegra/xusb.h
@@ -21,4 +21,6 @@ int tegra_xusb_padctl_usb3_set_lfps_detect(struct tegra_xusb_padctl *padctl,
 int tegra_xusb_padctl_set_vbus_override(struct tegra_xusb_padctl *padctl,
 					bool val);
 int tegra_phy_xusb_utmi_port_reset(struct phy *phy);
+int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
+					 unsigned int port);
 #endif /* PHY_TEGRA_XUSB_H */
-- 
2.7.4

