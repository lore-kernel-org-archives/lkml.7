Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70B2C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7E12070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbfDBNPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:15:10 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:58135 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbfDBNPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:15:10 -0400
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 9171E100011;
        Tue,  2 Apr 2019 13:15:01 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com
Subject: [PATCH net-next v4 1/2] net: phy: marvell10g: implement suspend/resume callbacks
Date:   Tue,  2 Apr 2019 15:10:28 +0200
Message-Id: <20190402131029.26880-2-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402131029.26880-1-antoine.tenart@bootlin.com>
References: <20190402131029.26880-1-antoine.tenart@bootlin.com>
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
 drivers/net/phy/marvell10g.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 80678919641d..9ee033c8a12b 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -51,6 +51,8 @@ enum {
 	MV_AN_STAT1000		= 0x8001, /* 1000base-T status register */
 
 	/* Vendor2 MMD registers */
+	MV_V2_PORT_CTRL		= 0xf001,
+	MV_V2_PORT_CTRL_PWRDOWN = 0x0800,
 	MV_V2_TEMP_CTRL		= 0xf08a,
 	MV_V2_TEMP_CTRL_MASK	= 0xc000,
 	MV_V2_TEMP_CTRL_SAMPLE	= 0x0000,
@@ -229,11 +231,19 @@ static int mv3310_probe(struct phy_device *phydev)
 
 static int mv3310_suspend(struct phy_device *phydev)
 {
-	return 0;
+	return phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MV_V2_PORT_CTRL,
+				MV_V2_PORT_CTRL_PWRDOWN);
 }
 
 static int mv3310_resume(struct phy_device *phydev)
 {
+	int ret;
+
+	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2, MV_V2_PORT_CTRL,
+				 MV_V2_PORT_CTRL_PWRDOWN);
+	if (ret)
+		return ret;
+
 	return mv3310_hwmon_config(phydev, true);
 }
 
-- 
2.20.1

