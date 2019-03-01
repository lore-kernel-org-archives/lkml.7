Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27C5C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9045B2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbfCAKzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:55:32 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:56527 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387836AbfCAKz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:55:28 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 22364E001F;
        Fri,  1 Mar 2019 10:55:24 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com,
        linux@armlinux.org.uk
Subject: [PATCH net-next v2 11/15] net: mvpp2: force the XLG MAC link up or down when not using in-band
Date:   Fri,  1 Mar 2019 11:52:13 +0100
Message-Id: <20190301105217.15764-12-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190301105217.15764-1-antoine.tenart@bootlin.com>
References: <20190301105217.15764-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch force the XLG MAC link state in the phylink link_up() and
link_down() helpers when not using in-band auto-negotiation. This mimics
what's already done for the GMAC and follows what's advised in the
phylink documentation.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  2 ++
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 35 +++++++++++++------
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 687e011de5ef..c9edeac9ec01 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -430,6 +430,8 @@
 #define MVPP22_XLG_CTRL0_REG			0x100
 #define     MVPP22_XLG_CTRL0_PORT_EN		BIT(0)
 #define     MVPP22_XLG_CTRL0_MAC_RESET_DIS	BIT(1)
+#define     MVPP22_XLG_CTRL0_FORCE_LINK_DOWN	BIT(2)
+#define     MVPP22_XLG_CTRL0_FORCE_LINK_PASS	BIT(3)
 #define     MVPP22_XLG_CTRL0_RX_FLOW_CTRL_EN	BIT(7)
 #define     MVPP22_XLG_CTRL0_TX_FLOW_CTRL_EN	BIT(8)
 #define     MVPP22_XLG_CTRL0_MIB_CNT_DIS	BIT(14)
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 59ee9e7545b0..9138baa392d8 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4685,6 +4685,7 @@ static void mvpp2_mac_config(struct net_device *dev, unsigned int mode,
 
 	/* Make sure the port is disabled when reconfiguring the mode */
 	mvpp2_port_disable(port);
+
 	if (port->priv->hw_version == MVPP22 && change_interface) {
 		mvpp22_gop_mask_irq(port);
 
@@ -4718,11 +4719,18 @@ static void mvpp2_mac_link_up(struct net_device *dev, unsigned int mode,
 	struct mvpp2_port *port = netdev_priv(dev);
 	u32 val;
 
-	if (!phylink_autoneg_inband(mode) && !mvpp2_is_xlg(interface)) {
-		val = readl(port->base + MVPP2_GMAC_AUTONEG_CONFIG);
-		val &= ~MVPP2_GMAC_FORCE_LINK_DOWN;
-		val |= MVPP2_GMAC_FORCE_LINK_PASS;
-		writel(val, port->base + MVPP2_GMAC_AUTONEG_CONFIG);
+	if (!phylink_autoneg_inband(mode)) {
+		if (mvpp2_is_xlg(interface)) {
+			val = readl(port->base + MVPP22_XLG_CTRL0_REG);
+			val &= ~MVPP22_XLG_CTRL0_FORCE_LINK_DOWN;
+			val |= MVPP22_XLG_CTRL0_FORCE_LINK_PASS;
+			writel(val, port->base + MVPP22_XLG_CTRL0_REG);
+		} else {
+			val = readl(port->base + MVPP2_GMAC_AUTONEG_CONFIG);
+			val &= ~MVPP2_GMAC_FORCE_LINK_DOWN;
+			val |= MVPP2_GMAC_FORCE_LINK_PASS;
+			writel(val, port->base + MVPP2_GMAC_AUTONEG_CONFIG);
+		}
 	}
 
 	mvpp2_port_enable(port);
@@ -4738,11 +4746,18 @@ static void mvpp2_mac_link_down(struct net_device *dev, unsigned int mode,
 	struct mvpp2_port *port = netdev_priv(dev);
 	u32 val;
 
-	if (!phylink_autoneg_inband(mode) && !mvpp2_is_xlg(interface)) {
-		val = readl(port->base + MVPP2_GMAC_AUTONEG_CONFIG);
-		val &= ~MVPP2_GMAC_FORCE_LINK_PASS;
-		val |= MVPP2_GMAC_FORCE_LINK_DOWN;
-		writel(val, port->base + MVPP2_GMAC_AUTONEG_CONFIG);
+	if (!phylink_autoneg_inband(mode)) {
+		if (mvpp2_is_xlg(interface)) {
+			val = readl(port->base + MVPP22_XLG_CTRL0_REG);
+			val &= ~MVPP22_XLG_CTRL0_FORCE_LINK_PASS;
+			val |= MVPP22_XLG_CTRL0_FORCE_LINK_DOWN;
+			writel(val, port->base + MVPP22_XLG_CTRL0_REG);
+		} else {
+			val = readl(port->base + MVPP2_GMAC_AUTONEG_CONFIG);
+			val &= ~MVPP2_GMAC_FORCE_LINK_PASS;
+			val |= MVPP2_GMAC_FORCE_LINK_DOWN;
+			writel(val, port->base + MVPP2_GMAC_AUTONEG_CONFIG);
+		}
 	}
 
 	netif_tx_stop_all_queues(dev);
-- 
2.20.1

