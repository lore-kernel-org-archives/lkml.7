Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F9BC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA2C2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733233AbfC0IqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:46:01 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:48891 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732988AbfC0IpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:45:09 -0400
X-Originating-IP: 90.88.32.136
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 05E0F40017;
        Wed, 27 Mar 2019 08:45:04 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 13/18] net: mvpp2: cls: Rename classifer per-port functions
Date:   Wed, 27 Mar 2019 09:44:17 +0100
Message-Id: <20190327084422.4209-14-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
References: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit renames some of the classifier functions to follow the
naming 'mvpp2_port_*' that's used for function that act on a given port.

This commit is purely cosmetic.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c  | 6 +++---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h  | 7 +++----
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 6 +++---
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 52dc6693cf31..533919982735 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -912,12 +912,12 @@ static void mvpp2_rss_port_c2_disable(struct mvpp2_port *port)
 	mvpp2_cls_c2_write(port->priv, &c2);
 }
 
-void mvpp22_rss_enable(struct mvpp2_port *port)
+void mvpp22_port_rss_enable(struct mvpp2_port *port)
 {
 	mvpp2_rss_port_c2_enable(port);
 }
 
-void mvpp22_rss_disable(struct mvpp2_port *port)
+void mvpp22_port_rss_disable(struct mvpp2_port *port)
 {
 	mvpp2_rss_port_c2_disable(port);
 }
@@ -1047,7 +1047,7 @@ int mvpp2_ethtool_rxfh_get(struct mvpp2_port *port, struct ethtool_rxnfc *info)
 	return 0;
 }
 
-void mvpp22_rss_port_init(struct mvpp2_port *port)
+void mvpp22_port_rss_init(struct mvpp2_port *port)
 {
 	struct mvpp2 *priv = port->priv;
 	int i;
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
index fd38d80eaff1..fa588b07d182 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
@@ -227,11 +227,10 @@ struct mvpp2_cls_lookup_entry {
 };
 
 void mvpp22_rss_fill_table(struct mvpp2_port *port, u32 table);
+void mvpp22_port_rss_init(struct mvpp2_port *port);
 
-void mvpp22_rss_port_init(struct mvpp2_port *port);
-
-void mvpp22_rss_enable(struct mvpp2_port *port);
-void mvpp22_rss_disable(struct mvpp2_port *port);
+void mvpp22_port_rss_enable(struct mvpp2_port *port);
+void mvpp22_port_rss_disable(struct mvpp2_port *port);
 
 int mvpp2_ethtool_rxfh_get(struct mvpp2_port *port, struct ethtool_rxnfc *info);
 int mvpp2_ethtool_rxfh_set(struct mvpp2_port *port, struct ethtool_rxnfc *info);
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index d0644cfc5346..f128ea22b339 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3741,9 +3741,9 @@ static int mvpp2_set_features(struct net_device *dev,
 
 	if (changed & NETIF_F_RXHASH) {
 		if (features & NETIF_F_RXHASH)
-			mvpp22_rss_enable(port);
+			mvpp22_port_rss_enable(port);
 		else
-			mvpp22_rss_disable(port);
+			mvpp22_port_rss_disable(port);
 	}
 
 	return 0;
@@ -4301,7 +4301,7 @@ static int mvpp2_port_init(struct mvpp2_port *port)
 	mvpp2_cls_port_config(port);
 
 	if (mvpp22_rss_is_supported())
-		mvpp22_rss_port_init(port);
+		mvpp22_port_rss_init(port);
 
 	/* Provide an initial Rx packet size */
 	port->pkt_size = MVPP2_RX_PKT_SIZE(port->dev->mtu);
-- 
2.20.1

