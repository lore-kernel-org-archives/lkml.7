Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F6DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF9D2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387872AbfCAKz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:55:27 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:41765 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387836AbfCAKzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:55:23 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id A3B95C0012;
        Fri,  1 Mar 2019 10:55:20 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com,
        linux@armlinux.org.uk
Subject: [PATCH net-next v2 09/15] net: mvpp2: always disable both MACs when disabling a port
Date:   Fri,  1 Mar 2019 11:52:11 +0100
Message-Id: <20190301105217.15764-10-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190301105217.15764-1-antoine.tenart@bootlin.com>
References: <20190301105217.15764-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the port_disable() helper to always disable both the
GMAC and the XLG MAC when called. At boot time we do not know of a port
was enabled in the firmware/bootloader, and if so what mode was used
(hence which of the two MACs was used).

This also help in implementing a logic where all blocks are disabled
when not used, and only enabled regarding the current mode used on a
given port.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 11284918d907..b27966355df9 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -1214,11 +1214,11 @@ static void mvpp2_port_disable(struct mvpp2_port *port)
 		/* Disable & reset should be done separately */
 		val &= ~MVPP22_XLG_CTRL0_MAC_RESET_DIS;
 		writel(val, port->base + MVPP22_XLG_CTRL0_REG);
-	} else {
-		val = readl(port->base + MVPP2_GMAC_CTRL_0_REG);
-		val &= ~(MVPP2_GMAC_PORT_EN_MASK);
-		writel(val, port->base + MVPP2_GMAC_CTRL_0_REG);
 	}
+
+	val = readl(port->base + MVPP2_GMAC_CTRL_0_REG);
+	val &= ~(MVPP2_GMAC_PORT_EN_MASK);
+	writel(val, port->base + MVPP2_GMAC_CTRL_0_REG);
 }
 
 /* Set IEEE 802.3x Flow Control Xon Packet Transmission Mode */
-- 
2.20.1

