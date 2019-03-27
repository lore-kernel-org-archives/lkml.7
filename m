Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45714C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B48E2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfC0QbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:31:19 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:46253 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfC0QbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:31:19 -0400
X-Originating-IP: 90.88.32.136
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id EE322FF809;
        Wed, 27 Mar 2019 16:31:14 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next] net: mvneta: Add 2500BaseT support
Date:   Wed, 27 Mar 2019 17:31:06 +0100
Message-Id: <20190327163107.11642-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some PHYs will use the 2500BaseX PHY_INTERFACE_MODE when being linked
with a partner using 2.5GBaseT.

Since we can't autonegotiate this speed between the MAC and the PHY, we
need to have the proper comphy support enabled, to make sure we can
safely advertise 2.5G and 1G in BaseT and be able to switch between both
corresponding PHY interface modes. This is now possible since comphy
support was added to this driver.

This commit adds the 2500BaseT mode to the list of supported modes when
using 2500BaseX, and was tested on a setup with an Armada385 and a
88E2010 PHY, both with and without the comphy node in the DT.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index c0a3718b2e2a..a944be3c57b1 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3385,6 +3385,7 @@ static void mvneta_validate(struct net_device *ndev, unsigned long *supported,
 		phylink_set(mask, 1000baseX_Full);
 	}
 	if (pp->comphy || state->interface == PHY_INTERFACE_MODE_2500BASEX) {
+		phylink_set(mask, 2500baseT_Full);
 		phylink_set(mask, 2500baseX_Full);
 	}
 
-- 
2.20.1

