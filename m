Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCD9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC30A20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732880AbfB1NZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:25:32 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43495 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfB1NZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:25:29 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 43975E000B;
        Thu, 28 Feb 2019 13:25:26 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 10/15] net: mvpp2: only update the XLG configuration when needed
Date:   Thu, 28 Feb 2019 14:21:23 +0100
Message-Id: <20190228132128.30154-11-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228132128.30154-1-antoine.tenart@bootlin.com>
References: <20190228132128.30154-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves the XLG configuration function, to only update the
XLG configuration register when a change is needed. This helps not
writing over and over the same XLG configuration each time phylink
request the MAC to be configured. This mimics the GMAC configuration
function.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index b27966355df9..59ee9e7545b0 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4506,10 +4506,11 @@ static void mvpp2_mac_an_restart(struct net_device *dev)
 static void mvpp2_xlg_config(struct mvpp2_port *port, unsigned int mode,
 			     const struct phylink_link_state *state)
 {
-	u32 ctrl0, ctrl4;
+	u32 old_ctrl0, ctrl0;
+	u32 old_ctrl4, ctrl4;
 
-	ctrl0 = readl(port->base + MVPP22_XLG_CTRL0_REG);
-	ctrl4 = readl(port->base + MVPP22_XLG_CTRL4_REG);
+	old_ctrl0 = ctrl0 = readl(port->base + MVPP22_XLG_CTRL0_REG);
+	old_ctrl4 = ctrl4 = readl(port->base + MVPP22_XLG_CTRL4_REG);
 
 	if (state->pause & MLO_PAUSE_TX)
 		ctrl0 |= MVPP22_XLG_CTRL0_TX_FLOW_CTRL_EN;
@@ -4525,8 +4526,10 @@ static void mvpp2_xlg_config(struct mvpp2_port *port, unsigned int mode,
 	ctrl4 |= MVPP22_XLG_CTRL4_FWD_FC | MVPP22_XLG_CTRL4_FWD_PFC |
 		 MVPP22_XLG_CTRL4_EN_IDLE_CHECK;
 
-	writel(ctrl0, port->base + MVPP22_XLG_CTRL0_REG);
-	writel(ctrl4, port->base + MVPP22_XLG_CTRL4_REG);
+	if (old_ctrl0 != ctrl0)
+		writel(ctrl0, port->base + MVPP22_XLG_CTRL0_REG);
+	if (old_ctrl4 != ctrl4)
+		writel(ctrl4, port->base + MVPP22_XLG_CTRL4_REG);
 }
 
 static void mvpp2_gmac_config(struct mvpp2_port *port, unsigned int mode,
-- 
2.20.1

