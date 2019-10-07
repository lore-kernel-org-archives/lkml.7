Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606DEECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3875221871
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2EIKM8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfJGMro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:47:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42346 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbfJGMrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:47:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id n14so15094963wrw.9;
        Mon, 07 Oct 2019 05:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dE5Pbudcp01GEPyoenTGG4iUJBJux2YKczE2k0btNjU=;
        b=Q2EIKM8DVJ7tDyl/BTGuEB31qH1AKFvkrYNn7nqDv77Leoyx0+82lXBEeKr++L5H9O
         BrRGB7DvSg9xr7Zkruf+e6ALndQBwT9Huktp75hqfxfqvUsxsRxpUZUOWTaiLgZhil5u
         TYpDIGXMBR5qkj9qfk8yxCIpmJ3LckZKklSAq2vicS+toGUwlhg09SUc1tNq9WMXVQlg
         Pxj8cwD795QdSHN3lJlW4CUNOFB8FyUVc/TY0EWwFRfti5oEyvmyJmTDbLlYJYqTEFO/
         v5nBdBVFd7I6MhWVPD7W6V0RBrSZPZ3gJ9CeZrh3sHFUcZmUSlFT+rOG7JpJHRQbeZzh
         NKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dE5Pbudcp01GEPyoenTGG4iUJBJux2YKczE2k0btNjU=;
        b=WACUAwejTEfbv8AYqYHZWUeWae+jkXzEvxJzhmteaypkgEWY1auCjuzZiAYNRevg4p
         eWnGrd54tFEVikk/kZNhmP9kpSsBmlIC2YIa5wcIhfsiAC8SNc3wOdDOgv5vREyyxk9h
         G3DV7ZR0HzxQ1rHgHI5B3elHSgN/kjoiPx86mLJ+tNZwbbZ8Ik6NzT7A5tGnHKrLcNIH
         MkzRQqWKlbapKbgMmpXGWchsU2JBl1zdllyo1dzhPicFkiuPQ50PxS6gRPEjHPJM68Zp
         aiP85MQEoe78RcI7fDOgArPyko/VfAvoJpyOCzS/fBo3amdgOZRVL2xnVTFMMTyOmInQ
         dLoA==
X-Gm-Message-State: APjAAAVHBJdThL5X0GkvX871zkShmKlHnFh3BYqNLjDTpIfqeOdW3e3x
        fzy/4gKm0ClK/TanW/spwImXU6wHxXE=
X-Google-Smtp-Source: APXvYqxfcm+mguSSud/mija7CYkDcradVYcTrMnb8M+RUUOM79viuKI65prWYSiQClaVRyLyQozQTw==
X-Received: by 2002:adf:fe8b:: with SMTP id l11mr17986939wrr.23.1570452459382;
        Mon, 07 Oct 2019 05:47:39 -0700 (PDT)
Received: from localhost ([194.105.145.90])
        by smtp.gmail.com with ESMTPSA id c6sm15985051wrm.71.2019.10.07.05.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Oct 2019 05:47:38 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Li Jun <jun.li@nxp.com>, Fabio Estevam <festevam@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 3/3] usb: phy: mxs: optimize disconnect line condition
Date:   Mon,  7 Oct 2019 15:46:07 +0300
Message-Id: <20191007124607.20618-3-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007124607.20618-1-igor.opaniuk@gmail.com>
References: <20191007124607.20618-1-igor.opaniuk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Opaniuk <igor.opaniuk@toradex.com>

We only have below cases to disconnect line when suspend:
1. Device mode without connection to any host/charger(no vbus).
2. Device mode connect to a charger, usb suspend when
system is entering suspend.

This patch can fix cases, when usb phy wrongly does disconnect
line in case usb host enters suspend but vbus is off.

Signed-off-by: Li Jun <jun.li@nxp.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---

 drivers/usb/phy/phy-mxs-usb.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 70b8c8248caf..d996666e09e6 100644
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
+	if (on && ((!vbus_is_on && mxs_phy->mode != USB_MODE_HOST)))
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

