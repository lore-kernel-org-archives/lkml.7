Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50B6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B607D20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732938AbfB1NZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:25:43 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:53699 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732911AbfB1NZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:25:40 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 838E040003;
        Thu, 28 Feb 2019 13:25:36 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 14/15] net: mvpp2: set the XPCS and MPCS in reset when not used
Date:   Thu, 28 Feb 2019 14:21:27 +0100
Message-Id: <20190228132128.30154-15-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228132128.30154-1-antoine.tenart@bootlin.com>
References: <20190228132128.30154-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sets both the XPCS and MPCS blocks in reset when they aren't
used. This is done both at boot time and when reconfiguring a port mode.
The advantage now is that only the PCS used is set out of reset when the
port is configured (10GKR uses the MCPS while RXAUI uses the XPCS).

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  1 +
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 62 ++++++++++++++++---
 2 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index c9edeac9ec01..ff0f4c503f53 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -483,6 +483,7 @@
 /* XPCS registers. PPv2.2 only */
 #define MVPP22_XPCS_BASE(port)			(0x7400 + (port) * 0x1000)
 #define MVPP22_XPCS_CFG0			0x0
+#define     MVPP22_XPCS_CFG0_RESET_DIS		BIT(0)
 #define     MVPP22_XPCS_CFG0_PCS_MODE(n)	((n) << 3)
 #define     MVPP22_XPCS_CFG0_ACTIVE_LANE(n)	((n) << 5)
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 36e709a4e7d9..29d32cb3d52b 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -1016,27 +1016,20 @@ static void mvpp22_gop_init_10gkr(struct mvpp2_port *port)
 	void __iomem *xpcs = priv->iface_base + MVPP22_XPCS_BASE(port->gop_id);
 	u32 val;
 
-	/* XPCS */
 	val = readl(xpcs + MVPP22_XPCS_CFG0);
 	val &= ~(MVPP22_XPCS_CFG0_PCS_MODE(0x3) |
 		 MVPP22_XPCS_CFG0_ACTIVE_LANE(0x3));
 	val |= MVPP22_XPCS_CFG0_ACTIVE_LANE(2);
 	writel(val, xpcs + MVPP22_XPCS_CFG0);
 
-	/* MPCS */
 	val = readl(mpcs + MVPP22_MPCS_CTRL);
 	val &= ~MVPP22_MPCS_CTRL_FWD_ERR_CONN;
 	writel(val, mpcs + MVPP22_MPCS_CTRL);
 
 	val = readl(mpcs + MVPP22_MPCS_CLK_RESET);
-	val &= ~(MVPP22_MPCS_CLK_RESET_DIV_RATIO(0x7) | MAC_CLK_RESET_MAC |
-		 MAC_CLK_RESET_SD_RX | MAC_CLK_RESET_SD_TX);
+	val &= ~MVPP22_MPCS_CLK_RESET_DIV_RATIO(0x7);
 	val |= MVPP22_MPCS_CLK_RESET_DIV_RATIO(1);
 	writel(val, mpcs + MVPP22_MPCS_CLK_RESET);
-
-	val &= ~MVPP22_MPCS_CLK_RESET_DIV_SET;
-	val |= MAC_CLK_RESET_MAC | MAC_CLK_RESET_SD_RX | MAC_CLK_RESET_SD_TX;
-	writel(val, mpcs + MVPP22_MPCS_CLK_RESET);
 }
 
 static int mvpp22_gop_init(struct mvpp2_port *port)
@@ -1385,6 +1378,53 @@ static void mvpp2_mac_reset(struct mvpp2_port *port)
 	}
 }
 
+static void mvpp22_pcs_reset(struct mvpp2_port *port)
+{
+	struct mvpp2 *priv = port->priv;
+	void __iomem *mpcs = priv->iface_base + MVPP22_MPCS_BASE(port->gop_id);
+	void __iomem *xpcs = priv->iface_base + MVPP22_XPCS_BASE(port->gop_id);
+	u32 val;
+
+	if (port->priv->hw_version != MVPP22 || port->gop_id != 0)
+		return;
+
+	val = readl(mpcs + MVPP22_MPCS_CLK_RESET);
+	val &= ~(MAC_CLK_RESET_MAC | MAC_CLK_RESET_SD_RX | MAC_CLK_RESET_SD_TX);
+	val |= MVPP22_MPCS_CLK_RESET_DIV_SET;
+	writel(val, mpcs + MVPP22_MPCS_CLK_RESET);
+
+	val = readl(xpcs + MVPP22_XPCS_CFG0);
+	writel(val & ~MVPP22_XPCS_CFG0_RESET_DIS, xpcs + MVPP22_XPCS_CFG0);
+}
+
+static void mvpp22_pcs_unreset(struct mvpp2_port *port)
+{
+	struct mvpp2 *priv = port->priv;
+	void __iomem *mpcs = priv->iface_base + MVPP22_MPCS_BASE(port->gop_id);
+	void __iomem *xpcs = priv->iface_base + MVPP22_XPCS_BASE(port->gop_id);
+	u32 val;
+
+	if (port->priv->hw_version != MVPP22 || port->gop_id != 0)
+		return;
+
+	switch (port->phy_interface) {
+	case PHY_INTERFACE_MODE_10GKR:
+		val = readl(mpcs + MVPP22_MPCS_CLK_RESET);
+		val |= MAC_CLK_RESET_MAC | MAC_CLK_RESET_SD_RX |
+		       MAC_CLK_RESET_SD_TX;
+		val &= ~MVPP22_MPCS_CLK_RESET_DIV_SET;
+		writel(val, mpcs + MVPP22_MPCS_CLK_RESET);
+		break;
+	case PHY_INTERFACE_MODE_XAUI:
+	case PHY_INTERFACE_MODE_RXAUI:
+		val = readl(xpcs + MVPP22_XPCS_CFG0);
+		writel(val | MVPP22_XPCS_CFG0_RESET_DIS, xpcs + MVPP22_XPCS_CFG0);
+		break;
+	default:
+		break;
+	}
+}
+
 /* Change maximum receive size of the port */
 static inline void mvpp2_gmac_max_rx_size_set(struct mvpp2_port *port)
 {
@@ -3140,12 +3180,17 @@ static void mvpp22_mode_reconfigure(struct mvpp2_port *port)
 	/* Set the GMAC & XLG MAC in reset */
 	mvpp2_mac_reset(port);
 
+	/* Set the MPCS and XPCS in reset */
+	mvpp22_pcs_reset(port);
+
 	/* comphy reconfiguration */
 	mvpp22_comphy_init(port);
 
 	/* gop reconfiguration */
 	mvpp22_gop_init(port);
 
+	mvpp22_pcs_unreset(port);
+
 	/* Only GOP port 0 has an XLG MAC */
 	if (port->gop_id == 0) {
 		ctrl3 = readl(port->base + MVPP22_XLG_CTRL3_REG);
@@ -4960,6 +5005,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	mvpp2_port_periodic_xon_disable(port);
 
 	mvpp2_mac_reset(port);
+	mvpp22_pcs_reset(port);
 
 	port->pcpu = alloc_percpu(struct mvpp2_port_pcpu);
 	if (!port->pcpu) {
-- 
2.20.1

