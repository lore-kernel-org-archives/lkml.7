Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E412C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F36120652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfDPKPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:15:07 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:36141 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfDPKPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:15:06 -0400
X-Originating-IP: 90.88.18.121
Received: from localhost (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 02A0A4001B;
        Tue, 16 Apr 2019 10:15:01 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, nicolas.ferre@microchip.com,
        ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com
Subject: [PATCH net-next] net: phy: micrel: add Asym Pause workaround
Date:   Tue, 16 Apr 2019 12:10:20 +0200
Message-Id: <20190416101020.22149-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Micrel KSZ9031 PHY may fail to establish a link when the Asymmetric
Pause capability is set. This issue is described in a Silicon Errata
(DS80000691D or DS80000692D), which advises to always disable the
capability. This patch implements the workaround by defining a KSZ9031
specific get_feature callback to force the Asymmetric Pause capability
bit to be cleared.

This fixes issues where the link would not come up at boot time, or when
the Asym Pause bit was set later on.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/phy/micrel.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index d6807b5bcd97..ddd6b6374d8c 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -738,6 +738,31 @@ static int ksz8873mll_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+static int ksz9031_get_features(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_read_abilities(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* Silicon Errata Sheet (DS80000691D or DS80000692D):
+	 * Whenever the device's Asymmetric Pause capability is set to 1,
+	 * link-up may fail after a link-up to link-down transition.
+	 *
+	 * Workaround:
+	 * Do not enable the Asymmetric Pause capability bit.
+	 */
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydev->supported);
+
+	/* We force setting the Pause capability as the core will force the
+	 * Asymmetric Pause capability to 1 otherwise.
+	 */
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydev->supported);
+
+	return 0;
+}
+
 static int ksz9031_read_status(struct phy_device *phydev)
 {
 	int err;
@@ -1052,9 +1077,9 @@ static struct phy_driver ksphy_driver[] = {
 	.phy_id		= PHY_ID_KSZ9031,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Micrel KSZ9031 Gigabit PHY",
-	/* PHY_GBIT_FEATURES */
 	.driver_data	= &ksz9021_type,
 	.probe		= kszphy_probe,
+	.get_features	= ksz9031_get_features,
 	.config_init	= ksz9031_config_init,
 	.soft_reset	= genphy_soft_reset,
 	.read_status	= ksz9031_read_status,
-- 
2.20.1

