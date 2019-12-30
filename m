Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AFBC2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 11:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28676206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 11:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XaNDs+ZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfL3LOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 06:14:00 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15540 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfL3LN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 06:13:57 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e09dbcc0000>; Mon, 30 Dec 2019 03:13:16 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 30 Dec 2019 03:13:56 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 30 Dec 2019 03:13:56 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 30 Dec
 2019 11:13:55 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 30 Dec 2019 11:13:55 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e09dbf00001>; Mon, 30 Dec 2019 03:13:55 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V3 05/18] phy: tegra: xusb: Add support to get companion USB 3 port
Date:   Mon, 30 Dec 2019 16:39:42 +0530
Message-ID: <1577704195-2535-6-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577704396; bh=z8Yeclp45av6JIcan0hG4QBuZhiucFPJPF7O9X3HewQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=XaNDs+ZL7+TXa4du44Ea8uBqLpKmtxZ7jmj6mhu5t1n0nfjYG7hpz48tzZnng/nwi
         4Hz3SjFa8lDq84/pMW2oFe56Q2jckRPaUAIUtZi1tB6tPQHD0CU+Z0JKcYtbSYQQNr
         VmcjY4mDO25LZGkDXLOhLRZGKQCz5OlR7FJ2FUbrpC2XCakjm1s6eSEdxKiHjxgbt0
         uhLLR1PhZ5LG75hvfPyPJLNVDnKpafayR5Fj3l01gxd8RJU4LHTVbCqVqAfgPxdD0t
         s8VFb/XdNXqzCBcgMnyejnCNV+q38sj2QN2O1uchZoVMEdD+yoGqQH4afhcV6V/f2m
         +ya/6JS1HKNCA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra XUSB host, device mode driver requires the USB 3 companion port
number for corresponding USB 2 port. Add API to retrieve the same.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
Reviewed-by: JC Kuo <jckuo@nvidia.com>
---
V3:
 - Added Reviewed-by updates to commit message.
---
V2:
 - Added -ENODEV as return instead of -1, to sync other errors.
---
 drivers/phy/tegra/xusb.c       | 21 +++++++++++++++++++++
 include/linux/phy/tegra/xusb.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 536b2fc..80dbc57 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -1274,6 +1274,27 @@ int tegra_phy_xusb_utmi_port_reset(struct phy *phy)
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

