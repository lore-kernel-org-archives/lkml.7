Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACE5C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86691208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfEMHai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:30:38 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:57399 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfEMHah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:30:37 -0400
X-Originating-IP: 90.88.28.253
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-86-253.w90-88.abo.wanadoo.fr [90.88.28.253])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 94B8F1BF208;
        Mon, 13 May 2019 07:30:33 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH net v2] net: mvpp2: cls: Add missing NETIF_F_NTUPLE flag
Date:   Mon, 13 May 2019 09:30:33 +0200
Message-Id: <20190513073033.15015-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the mvpp2 driver supports classification offloading, we must
add the NETIF_F_NTUPLE to the features list.

Since the current code doesn't allow disabling the feature, we don't set
the flag in dev->hw_features.

Fixes: 90b509b39ac9 ("net: mvpp2: cls: Add Classification offload support")
Reported-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2: Rebased on latest -net, added Jakub's Ack, gave more details in the
    commit log about not adding the flag in hw_features.

 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 56d43d9b43ef..d38952eb7aa9 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5058,8 +5058,10 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	dev->hw_features |= features | NETIF_F_RXCSUM | NETIF_F_GRO |
 			    NETIF_F_HW_VLAN_CTAG_FILTER;
 
-	if (mvpp22_rss_is_supported())
+	if (mvpp22_rss_is_supported()) {
 		dev->hw_features |= NETIF_F_RXHASH;
+		dev->features |= NETIF_F_NTUPLE;
+	}
 
 	if (port->pool_long->id == MVPP2_BM_JUMBO && port->id != 0) {
 		dev->features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
-- 
2.20.1

