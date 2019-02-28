Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1296C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698B7214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732831AbfB1NZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:25:23 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:52035 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732669AbfB1NZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:25:17 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id E3D3520014;
        Thu, 28 Feb 2019 13:25:13 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 05/15] net: mvpp2: reconfiguring the port interface is PPv2.2 specific
Date:   Thu, 28 Feb 2019 14:21:18 +0100
Message-Id: <20190228132128.30154-6-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228132128.30154-1-antoine.tenart@bootlin.com>
References: <20190228132128.30154-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a check on the PPv2 version in-use not to reconfigure
the port mode when an interface is updated when using PPv2.1 as the
functions called are PPv2.2 specific.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 71a3fdb76b12..204cae75a05b 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4673,16 +4673,14 @@ static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
 
 	/* Make sure the port is disabled when reconfiguring the mode */
 	mvpp2_port_disable(port);
-	if (change_interface) {
+	if (port->priv->hw_version == MVPP22 && change_interface) {
 		mvpp22_gop_mask_irq(port);
 
-		if (port->priv->hw_version == MVPP22) {
-			port->phy_interface = state->interface;
+		port->phy_interface = state->interface;
 
-			/* Reconfigure the serdes lanes */
-			phy_power_off(port->comphy);
-			mvpp22_mode_reconfigure(port);
-		}
+		/* Reconfigure the serdes lanes */
+		phy_power_off(port->comphy);
+		mvpp22_mode_reconfigure(port);
 	}
 
 	/* mac (re)configuration */
@@ -4696,7 +4694,7 @@ static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
 	if (port->priv->hw_version == MVPP21 && port->flags & MVPP2_F_LOOPBACK)
 		mvpp2_port_loopback_set(port, state);
 
-	if (change_interface)
+	if (port->priv->hw_version == MVPP22 && change_interface)
 		mvpp22_gop_unmask_irq(port);
 
 	mvpp2_port_enable(port);
-- 
2.20.1

