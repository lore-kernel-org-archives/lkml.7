Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925CFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660C120C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732954AbfB1NZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:25:48 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:50299 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732911AbfB1NZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:25:45 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 0F31EFF80F;
        Thu, 28 Feb 2019 13:25:41 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 15/15] net: mvpp2: set the GMAC, XLG MAC, XPCS and MPCS in reset when a port is down
Date:   Thu, 28 Feb 2019 14:21:28 +0100
Message-Id: <20190228132128.30154-16-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228132128.30154-1-antoine.tenart@bootlin.com>
References: <20190228132128.30154-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds calls in the stop() helper to ensure both MACs and
both PCS blocks are set in reset when the user manually sets a port
down. This is done so that we have the exact same block reset states at
boot time and when a port is set down.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 29d32cb3d52b..c10fd894c86f 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3257,6 +3257,7 @@ static void mvpp2_stop_dev(struct mvpp2_port *port)
 
 	if (port->phylink)
 		phylink_stop(port->phylink);
+
 	phy_power_off(port->comphy);
 }
 
@@ -3520,6 +3521,9 @@ static int mvpp2_stop(struct net_device *dev)
 	mvpp2_cleanup_rxqs(port);
 	mvpp2_cleanup_txqs(port);
 
+	mvpp2_mac_reset(port);
+	mvpp22_pcs_reset(port);
+
 	cancel_delayed_work_sync(&port->stats_work);
 
 	return 0;
-- 
2.20.1

