Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6650DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E09C214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbfB1N0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:26:21 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:52491 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730825AbfB1NZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:25:36 -0500
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 7A77D10001F;
        Thu, 28 Feb 2019 13:25:31 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 12/15] net: mvpp2: rework the XLG MAC reset handling
Date:   Thu, 28 Feb 2019 14:21:25 +0100
Message-Id: <20190228132128.30154-13-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228132128.30154-1-antoine.tenart@bootlin.com>
References: <20190228132128.30154-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reworks the way the XLG MAC is set in reset: the XLG MAC is
set in reset at probe time and taken out of this state only when used.
The idea is to move forward a situation where only the blocks used are
taken out of reset. This also has the effect to handle the GMAC and the
XLG MAC in a similar way (the GMAC already is set in reset at boot
time).

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 27 ++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 9138baa392d8..13c4fcbc4269 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -1189,8 +1189,7 @@ static void mvpp2_port_enable(struct mvpp2_port *port)
 	/* Only GOP port 0 has an XLG MAC */
 	if (port->gop_id == 0 && mvpp2_is_xlg(port->phy_interface)) {
 		val = readl(port->base + MVPP22_XLG_CTRL0_REG);
-		val |= MVPP22_XLG_CTRL0_PORT_EN |
-		       MVPP22_XLG_CTRL0_MAC_RESET_DIS;
+		val |= MVPP22_XLG_CTRL0_PORT_EN;
 		val &= ~MVPP22_XLG_CTRL0_MIB_CNT_DIS;
 		writel(val, port->base + MVPP22_XLG_CTRL0_REG);
 	} else {
@@ -1210,10 +1209,6 @@ static void mvpp2_port_disable(struct mvpp2_port *port)
 		val = readl(port->base + MVPP22_XLG_CTRL0_REG);
 		val &= ~MVPP22_XLG_CTRL0_PORT_EN;
 		writel(val, port->base + MVPP22_XLG_CTRL0_REG);
-
-		/* Disable & reset should be done separately */
-		val &= ~MVPP22_XLG_CTRL0_MAC_RESET_DIS;
-		writel(val, port->base + MVPP22_XLG_CTRL0_REG);
 	}
 
 	val = readl(port->base + MVPP2_GMAC_CTRL_0_REG);
@@ -1370,10 +1365,10 @@ static int mvpp2_ethtool_get_sset_count(struct net_device *dev, int sset)
 	return -EOPNOTSUPP;
 }
 
-static void mvpp2_port_reset(struct mvpp2_port *port)
+static void mvpp2_mac_reset(struct mvpp2_port *port)
 {
-	u32 val;
 	unsigned int i;
+	u32 val;
 
 	/* Read the GOP statistics to reset the hardware counters */
 	for (i = 0; i < ARRAY_SIZE(mvpp2_ethtool_regs); i++)
@@ -1382,6 +1377,12 @@ static void mvpp2_port_reset(struct mvpp2_port *port)
 	val = readl(port->base + MVPP2_GMAC_CTRL_2_REG) |
 	      MVPP2_GMAC_PORT_RESET_MASK;
 	writel(val, port->base + MVPP2_GMAC_CTRL_2_REG);
+
+	if (port->priv->hw_version == MVPP22 && port->gop_id == 0) {
+		val = readl(port->base + MVPP22_XLG_CTRL0_REG) &
+		      ~MVPP22_XLG_CTRL0_MAC_RESET_DIS;
+		writel(val, port->base + MVPP22_XLG_CTRL0_REG);
+	}
 }
 
 /* Change maximum receive size of the port */
@@ -4512,6 +4513,8 @@ static void mvpp2_xlg_config(struct mvpp2_port *port, unsigned int mode,
 	old_ctrl0 = ctrl0 = readl(port->base + MVPP22_XLG_CTRL0_REG);
 	old_ctrl4 = ctrl4 = readl(port->base + MVPP22_XLG_CTRL4_REG);
 
+	ctrl0 |= MVPP22_XLG_CTRL0_MAC_RESET_DIS;
+
 	if (state->pause & MLO_PAUSE_TX)
 		ctrl0 |= MVPP22_XLG_CTRL0_TX_FLOW_CTRL_EN;
 	else
@@ -4530,6 +4533,12 @@ static void mvpp2_xlg_config(struct mvpp2_port *port, unsigned int mode,
 		writel(ctrl0, port->base + MVPP22_XLG_CTRL0_REG);
 	if (old_ctrl4 != ctrl4)
 		writel(ctrl4, port->base + MVPP22_XLG_CTRL4_REG);
+
+	if (!(old_ctrl0 & MVPP22_XLG_CTRL0_MAC_RESET_DIS)) {
+		while (!(readl(port->base + MVPP22_XLG_CTRL0_REG) &
+			 MVPP22_XLG_CTRL0_MAC_RESET_DIS))
+			continue;
+	}
 }
 
 static void mvpp2_gmac_config(struct mvpp2_port *port, unsigned int mode,
@@ -4947,7 +4956,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 
 	mvpp2_port_periodic_xon_disable(port);
 
-	mvpp2_port_reset(port);
+	mvpp2_mac_reset(port);
 
 	port->pcpu = alloc_percpu(struct mvpp2_port_pcpu);
 	if (!port->pcpu) {
-- 
2.20.1

