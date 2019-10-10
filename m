Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C4EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE992208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkLd84++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfJJN5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:57:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34693 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfJJN5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:57:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id j11so8054712wrp.1;
        Thu, 10 Oct 2019 06:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kKpm7XM1AgpSN1jrhyWVldr2l3miF1XGBH1EW5loxxI=;
        b=hkLd84++mfI8DFZArVwjpGXEap9gVCEvxtrIk2GCAec5fJlbZnrJ+fF/5b5qtRAxBN
         7zu8N3Hq7k8saPoZ4+41pnq1iymTz58A9wVpJnOr3Y/VCaIBlvYrkiP6iod1wtgWphGj
         8qisHK3qM0yiViWyXPI/tsulamhgLzVovb7CjWPxjkeRw1ySUyPAHqUSMVI3uszMbRGS
         OjfZEfFPffXnbZUYgYGiyCgBj+1igbTyVHWVLqmj4JNND6Dv525BL0Y1CgB6+2Nm/wqX
         0lND4FVUjZ1UfiTpwa/MrT+MUE5UsVx5qIAwSO4UzaG9jSlgAHCAgDF4VkkUn1frOTkM
         GHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kKpm7XM1AgpSN1jrhyWVldr2l3miF1XGBH1EW5loxxI=;
        b=RyM8G3/z93S+sFkizwS0DnOGo+3xj3WJmWMShYWNLtLFT2U/mnxnYOe/JJt/TrrGrW
         ycV69jQrzmBbbFrZmcM6qeVmowNUw0Ckz3Vktg3yGJUueg9k8AZkB6hIjy4bwevObBI4
         3ZHfVP3ld7DN1XTZYCprqWcpN80hZbiMPvJvf3eOCDkgXfDMRG+lsHm8/FuXvX/S+QtR
         9YzoElfg6MZy+JsaaVt+S+NZoIZwmB0EjGsq0zGxLhCSi8vKcfPRaSWk/tA/CABHK3zn
         WA/tTIGGDKTLRETqhmjvRFL+AFA2uePhlfeQPGkDMcac5itZt6nTKLU8+GL+qIs+/CY7
         ykoA==
X-Gm-Message-State: APjAAAXJyMR1YZnD4wopAMRzNOhAg86ejKeZAux3N5sfkvJyvY/4V5p0
        quQZPBeUTJzzbpxQgWmoEGz8n6hQngQ=
X-Google-Smtp-Source: APXvYqxnSQAklQr786Hn4Cib+9+4j5ERR7EwmEMJDisBGjMLS8ap04iHd53VBJcDXdLnQjFxNU2sTw==
X-Received: by 2002:a5d:540e:: with SMTP id g14mr8988389wrv.177.1570715830595;
        Thu, 10 Oct 2019 06:57:10 -0700 (PDT)
Received: from localhost ([194.105.145.90])
        by smtp.gmail.com with ESMTPSA id u4sm9088089wmg.41.2019.10.10.06.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Oct 2019 06:57:10 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Li Jun <jun.li@nxp.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] usb: phy: mxs: optimize disconnect line condition
Date:   Thu, 10 Oct 2019 16:56:56 +0300
Message-Id: <20191010135656.3264-3-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010135656.3264-1-igor.opaniuk@gmail.com>
References: <20191010135656.3264-1-igor.opaniuk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Jun <jun.li@nxp.com>

We only have below cases to disconnect line when suspend:
1. Device mode without connection to any host/charger(no vbus).
2. Device mode connect to a charger, usb suspend when
system is entering suspend.

This patch can fix cases, when usb phy wrongly does disconnect
line in case usb host enters suspend but vbus is off.

Fixes: 7b09e67639("usb: phy: mxs: refine mxs_phy_disconnect_line")
Signed-off-by: Li Jun <jun.li@nxp.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---

v2:
- restored original commit author
- fixed build for multi_v7

 drivers/usb/phy/phy-mxs-usb.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 70b8c8248caf..f58ea923c7eb 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -204,6 +204,7 @@ struct mxs_phy {
 	int port_id;
 	u32 tx_reg_set;
 	u32 tx_reg_mask;
+	enum usb_current_mode mode;
 };
 
 static inline bool is_imx6q_phy(struct mxs_phy *mxs_phy)
@@ -386,17 +387,6 @@ static void __mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool disconnect)
 		usleep_range(500, 1000);
 }
 
-static bool mxs_phy_is_otg_host(struct mxs_phy *mxs_phy)
-{
-	void __iomem *base = mxs_phy->phy.io_priv;
-	u32 phyctrl = readl(base + HW_USBPHY_CTRL);
-
-	if (IS_ENABLED(CONFIG_USB_OTG) &&
-			!(phyctrl & BM_USBPHY_CTRL_OTG_ID_VALUE))
-		return true;
-
-	return false;
-}
 
 static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
 {
@@ -412,13 +402,26 @@ static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
 
 	vbus_is_on = mxs_phy_get_vbus_status(mxs_phy);
 
-	if (on && !vbus_is_on && !mxs_phy_is_otg_host(mxs_phy))
+	if (on && ((!vbus_is_on && mxs_phy->mode != USB_CURRENT_MODE_HOST)))
 		__mxs_phy_disconnect_line(mxs_phy, true);
 	else
 		__mxs_phy_disconnect_line(mxs_phy, false);
 
 }
 
+/*
+ * Set the usb current role for phy.
+ */
+static int mxs_phy_set_mode(struct usb_phy *phy,
+		enum usb_current_mode mode)
+{
+	struct mxs_phy *mxs_phy = to_mxs_phy(phy);
+
+	mxs_phy->mode = mode;
+
+	return 0;
+}
+
 static int mxs_phy_init(struct usb_phy *phy)
 {
 	int ret;
@@ -796,6 +799,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
 	mxs_phy->phy.notify_disconnect	= mxs_phy_on_disconnect;
 	mxs_phy->phy.type		= USB_PHY_TYPE_USB2;
 	mxs_phy->phy.set_wakeup		= mxs_phy_set_wakeup;
+	mxs_phy->phy.set_mode		= mxs_phy_set_mode;
 	mxs_phy->phy.charger_detect	= mxs_phy_charger_detect;
 
 	mxs_phy->clk = clk;
-- 
2.17.1

