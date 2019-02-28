Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4DCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D332083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbfB1NuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:50:07 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54129 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfB1NuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:50:07 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 1CE54C0004;
        Thu, 28 Feb 2019 13:50:01 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 1/3] net: phy: marvell10g: implement suspend/resume callbacks
Date:   Thu, 28 Feb 2019 14:48:35 +0100
Message-Id: <20190228134837.32740-2-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228134837.32740-1-antoine.tenart@bootlin.com>
References: <20190228134837.32740-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the suspend/resume callbacks for Marvell 10G PHYs. The
three PCS (base-t, base-r and 1000base-x) are set in low power (the PCS
are powered down) when the PHY isn't used.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/phy/marvell10g.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 79106e70010f..95aeeda0eb16 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -201,6 +201,30 @@ static int mv3310_hwmon_probe(struct phy_device *phydev)
 }
 #endif
 
+static int mv3310_suspend(struct phy_device *phydev)
+{
+	phy_modify_mmd(phydev, MDIO_MMD_PCS, MV_PCS_BASE_T + MDIO_CTRL1,
+		       MDIO_CTRL1_LPOWER, MDIO_CTRL1_LPOWER);
+	phy_modify_mmd(phydev, MDIO_MMD_PCS, MV_PCS_BASE_R + MDIO_CTRL1,
+		       MDIO_CTRL1_LPOWER, MDIO_CTRL1_LPOWER);
+	phy_modify_mmd(phydev, MDIO_MMD_PCS, MV_PCS_1000BASEX + MDIO_CTRL1,
+		       MDIO_CTRL1_LPOWER, MDIO_CTRL1_LPOWER);
+
+	return 0;
+}
+
+static int mv3310_resume(struct phy_device *phydev)
+{
+	phy_modify_mmd(phydev, MDIO_MMD_PCS, MV_PCS_BASE_T + MDIO_CTRL1,
+		       MDIO_CTRL1_LPOWER, 0);
+	phy_modify_mmd(phydev, MDIO_MMD_PCS, MV_PCS_BASE_R + MDIO_CTRL1,
+		       MDIO_CTRL1_LPOWER, 0);
+	phy_modify_mmd(phydev, MDIO_MMD_PCS, MV_PCS_1000BASEX + MDIO_CTRL1,
+		       MDIO_CTRL1_LPOWER, 0);
+
+	return mv3310_hwmon_config(phydev, true);
+}
+
 static int mv3310_probe(struct phy_device *phydev)
 {
 	struct mv3310_priv *priv;
-- 
2.20.1

