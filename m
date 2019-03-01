Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126EEC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4C32087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 10:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388102AbfCAK4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:56:07 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:45155 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387909AbfCAKzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 05:55:33 -0500
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 41CFB200009;
        Fri,  1 Mar 2019 10:55:30 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com,
        linux@armlinux.org.uk
Subject: [PATCH net-next v2 04/15] net: mvpp2: a port can be disabled even if we use the link IRQ
Date:   Fri,  1 Mar 2019 11:52:06 +0100
Message-Id: <20190301105217.15764-5-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190301105217.15764-1-antoine.tenart@bootlin.com>
References: <20190301105217.15764-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We had a check in the mvpp2_mac_link_down() function (called by phylink)
to avoid disabling the port when link interrupts are used. It turned out
the interrupt can still be used with the port disabled. We can thus
remove this check.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 37d3c97c0b9b..71a3fdb76b12 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4739,13 +4739,6 @@ static void mvpp2_mac_link_down(struct net_device *dev, unsigned int mode,
 	mvpp2_egress_disable(port);
 	mvpp2_ingress_disable(port);
 
-	/* When using link interrupts to notify phylink of a MAC state change,
-	 * we do not want the port to be disabled (we want to receive further
-	 * interrupts, to be notified when the port will have a link later).
-	 */
-	if (!port->has_phy)
-		return;
-
 	mvpp2_port_disable(port);
 }
 
-- 
2.20.1

