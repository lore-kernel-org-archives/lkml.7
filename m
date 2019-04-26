Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EF4C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B85C20B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfDZQld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:41:33 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:49855 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDZQld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:41:33 -0400
Received: from localhost (lfbn-1-2078-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 3092B240017;
        Fri, 26 Apr 2019 16:41:29 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, nicolas.ferre@microchip.com,
        ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com
Subject: [PATCH net-next] net: phy: micrel: make sure the factory test bit is cleared
Date:   Fri, 26 Apr 2019 18:41:23 +0200
Message-Id: <20190426164123.26735-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KSZ8081 PHY has a factory test mode which is set at the de-assertion
of the reset line based on the RXER (KSZ8081RNA/RND) or TXC
(KSZ8081MNX/RNB) pin. If a pull-down is missing, or if the pin has a
pull-up, the factory test mode should be cleared by manually writing a 0
(according to the datasheet). This patch makes sure this factory test
bit is cleared in config_init().

Tested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/phy/micrel.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index ddd6b6374d8c..3c8186f269f9 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -28,6 +28,7 @@
 
 /* Operation Mode Strap Override */
 #define MII_KSZPHY_OMSO				0x16
+#define KSZPHY_OMSO_FACTORY_TEST		BIT(15)
 #define KSZPHY_OMSO_B_CAST_OFF			BIT(9)
 #define KSZPHY_OMSO_NAND_TREE_ON		BIT(5)
 #define KSZPHY_OMSO_RMII_OVERRIDE		BIT(1)
@@ -340,6 +341,18 @@ static int ksz8041_config_aneg(struct phy_device *phydev)
 	return genphy_config_aneg(phydev);
 }
 
+static int ksz8081_config_init(struct phy_device *phydev)
+{
+	/* KSZPHY_OMSO_FACTORY_TEST is set at de-assertion of the reset line
+	 * based on the RXER (KSZ8081RNA/RND) or TXC (KSZ8081MNX/RNB) pin. If a
+	 * pull-down is missing, the factory test mode should be cleared by
+	 * manually writing a 0.
+	 */
+	phy_clear_bits(phydev, MII_KSZPHY_OMSO, KSZPHY_OMSO_FACTORY_TEST);
+
+	return kszphy_config_init(phydev);
+}
+
 static int ksz8061_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -1038,7 +1051,7 @@ static struct phy_driver ksphy_driver[] = {
 	/* PHY_BASIC_FEATURES */
 	.driver_data	= &ksz8081_type,
 	.probe		= kszphy_probe,
-	.config_init	= kszphy_config_init,
+	.config_init	= ksz8081_config_init,
 	.ack_interrupt	= kszphy_ack_interrupt,
 	.config_intr	= kszphy_config_intr,
 	.get_sset_count = kszphy_get_sset_count,
-- 
2.21.0

