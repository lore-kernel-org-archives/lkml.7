Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E6CC4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D594421721
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbfI3J1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 05:27:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45765 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbfI3J1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:27:17 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1iErxZ-00017O-3F; Mon, 30 Sep 2019 11:27:13 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1iErxX-00005V-PC; Mon, 30 Sep 2019 11:27:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] net: phy: at803x: add ar9331 support
Date:   Mon, 30 Sep 2019 11:27:10 +0200
Message-Id: <20190930092710.32739-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly this hardware can work with generic PHY driver, but this change
is needed to provided interrupt handling support.
Tested with dsa ar9331-switch driver.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/at803x.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 6ad8b1c63c34..d62a77adb8e7 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -53,6 +53,7 @@
 #define AT803X_DEBUG_REG_5			0x05
 #define AT803X_DEBUG_TX_CLK_DLY_EN		BIT(8)
 
+#define AR9331_PHY_ID 0x004dd041
 #define ATH8030_PHY_ID 0x004dd076
 #define ATH8031_PHY_ID 0x004dd074
 #define ATH8035_PHY_ID 0x004dd072
@@ -406,11 +407,24 @@ static struct phy_driver at803x_driver[] = {
 	.aneg_done		= at803x_aneg_done,
 	.ack_interrupt		= &at803x_ack_interrupt,
 	.config_intr		= &at803x_config_intr,
+}, {
+	/* ATHEROS AR9331 */
+	.phy_id			= AR9331_PHY_ID,
+	.name			= "Atheros AR9331 built-in PHY",
+	.phy_id_mask		= AT803X_PHY_ID_MASK,
+	.probe			= at803x_probe,
+	.config_init		= at803x_config_init,
+	.suspend		= at803x_suspend,
+	.resume			= at803x_resume,
+	/* PHY_BASIC_FEATURES */
+	.ack_interrupt		= &at803x_ack_interrupt,
+	.config_intr		= &at803x_config_intr,
 } };
 
 module_phy_driver(at803x_driver);
 
 static struct mdio_device_id __maybe_unused atheros_tbl[] = {
+	{ AR9331_PHY_ID, AT803X_PHY_ID_MASK },
 	{ ATH8030_PHY_ID, AT803X_PHY_ID_MASK },
 	{ ATH8031_PHY_ID, AT803X_PHY_ID_MASK },
 	{ ATH8035_PHY_ID, AT803X_PHY_ID_MASK },
-- 
2.23.0

