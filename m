Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76ECC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3309218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387707AbfCALBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:01:08 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:35305 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387586AbfCALBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 06:01:05 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 84415C001C;
        Fri,  1 Mar 2019 11:01:01 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com
Subject: [PATCH net-next v2 3/3] net: phy: marvell10g: set the PHY in low power by default
Date:   Fri,  1 Mar 2019 12:00:47 +0100
Message-Id: <20190301110047.20257-4-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190301110047.20257-1-antoine.tenart@bootlin.com>
References: <20190301110047.20257-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the Marvell 10G PHYs are set out of reset, the LPOWER bit is set
depending on an hardware configuration choice. We also do not know what
is the PHY state at boot time. Hence, set the PHY in low power by
default when this driver probes.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/phy/marvell10g.c | 47 ++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 4f6f96080182..765edd34a7dd 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -201,29 +201,6 @@ static int mv3310_hwmon_probe(struct phy_device *phydev)
 }
 #endif
 
-static int mv3310_probe(struct phy_device *phydev)
-{
-	struct mv3310_priv *priv;
-	u32 mmd_mask = MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
-	int ret;
-
-	if (!phydev->is_c45 ||
-	    (phydev->c45_ids.devices_in_package & mmd_mask) != mmd_mask)
-		return -ENODEV;
-
-	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	dev_set_drvdata(&phydev->mdio.dev, priv);
-
-	ret = mv3310_hwmon_probe(phydev);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static int mv3310_suspend(struct phy_device *phydev)
 {
 	phy_modify_mmd(phydev, MDIO_MMD_PCS, MV_PCS_BASE_T + MDIO_CTRL1,
@@ -248,6 +225,30 @@ static int mv3310_resume(struct phy_device *phydev)
 	return mv3310_hwmon_config(phydev, true);
 }
 
+static int mv3310_probe(struct phy_device *phydev)
+{
+	struct mv3310_priv *priv;
+	u32 mmd_mask = MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
+	int ret;
+
+	if (!phydev->is_c45 ||
+	    (phydev->c45_ids.devices_in_package & mmd_mask) != mmd_mask)
+		return -ENODEV;
+
+	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(&phydev->mdio.dev, priv);
+
+	ret = mv3310_hwmon_probe(phydev);
+	if (ret)
+		return ret;
+
+	/* Set the PHY in low power mode by default */
+	return mv3310_suspend(phydev);
+}
+
 /* Some PHYs in the Alaska family such as the 88X3310 and the 88E2010
  * don't set bit 14 in PMA Extended Abilities (1.11), although they do
  * support 2.5GBASET and 5GBASET. For these models, we can still read their
-- 
2.20.1

