Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26B9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FFC2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbfB1NuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:50:16 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:34745 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731727AbfB1NuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:50:15 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 0850CC000B;
        Thu, 28 Feb 2019 13:50:07 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 3/3] net: phy: marvell10g: set the PHY in low power by default
Date:   Thu, 28 Feb 2019 14:48:37 +0100
Message-Id: <20190228134837.32740-4-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228134837.32740-1-antoine.tenart@bootlin.com>
References: <20190228134837.32740-1-antoine.tenart@bootlin.com>
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
 drivers/net/phy/marvell10g.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index e5d098bd33a6..765edd34a7dd 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -245,17 +245,8 @@ static int mv3310_probe(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	return 0;
-}
-
-static int mv3310_suspend(struct phy_device *phydev)
-{
-	return 0;
-}
-
-static int mv3310_resume(struct phy_device *phydev)
-{
-	return mv3310_hwmon_config(phydev, true);
+	/* Set the PHY in low power mode by default */
+	return mv3310_suspend(phydev);
 }
 
 /* Some PHYs in the Alaska family such as the 88X3310 and the 88E2010
-- 
2.20.1

