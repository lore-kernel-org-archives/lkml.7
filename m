Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B058C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4FB20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732856AbfB1NZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:25:27 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:46781 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732669AbfB1NZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:25:26 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 0CCC724000E;
        Thu, 28 Feb 2019 13:25:20 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, linux@armlinux.org.uk
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 08/15] net: mvpp2: some AN fields require the link to be down when updated
Date:   Thu, 28 Feb 2019 14:21:21 +0100
Message-Id: <20190228132128.30154-9-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228132128.30154-1-antoine.tenart@bootlin.com>
References: <20190228132128.30154-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GMAC configuration helper modifies values in the auto-negotiation
register. Some of its values require the port to be forced down when
modifying their values. This patches fixes the check made on the bit to
be updated in this register, so that the port is forced down when
needed. This fix cases where some of those parameters were updated, but
not taken into account, such as when using RGMII interfaces.

Fixes: d14e078f23cc ("net: marvell: mvpp2: only reprogram what is necessary on mac_config")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 9c6200a59910..11284918d907 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4627,9 +4627,19 @@ static void mvpp2_gmac_config(struct mvpp2_port *port, unsigned int mode,
 		}
 	}
 
+/* Some fields of the auto-negotiation register require the port to be down when
+ * their value is updated.
+ */
+#define MVPP2_GMAC_AN_PORT_DOWN_MASK	\
+		(MVPP2_GMAC_IN_BAND_AUTONEG | \
+		 MVPP2_GMAC_IN_BAND_AUTONEG_BYPASS | \
+		 MVPP2_GMAC_CONFIG_MII_SPEED | MVPP2_GMAC_CONFIG_GMII_SPEED | \
+		 MVPP2_GMAC_AN_SPEED_EN | MVPP2_GMAC_CONFIG_FULL_DUPLEX | \
+		 MVPP2_GMAC_AN_DUPLEX_EN)
+
 	if ((old_ctrl0 ^ ctrl0) & MVPP2_GMAC_PORT_TYPE_MASK ||
 	    (old_ctrl2 ^ ctrl2) & MVPP2_GMAC_INBAND_AN_MASK ||
-	    (old_an ^ an) & MVPP2_GMAC_IN_BAND_AUTONEG) {
+	    (old_an ^ an) & MVPP2_GMAC_AN_PORT_DOWN_MASK) {
 		/* Force link down */
 		old_an &= ~MVPP2_GMAC_FORCE_LINK_PASS;
 		old_an |= MVPP2_GMAC_FORCE_LINK_DOWN;
-- 
2.20.1

