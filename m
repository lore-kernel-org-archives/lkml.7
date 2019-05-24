Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868EFC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EB821773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390445AbfEXKGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:06:08 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:43479 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389745AbfEXKGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:06:05 -0400
X-Originating-IP: 90.88.147.134
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id A84EA40019;
        Fri, 24 May 2019 10:06:01 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 1/5] net: mvpp2: cls: Use the correct number of rules in various places
Date:   Fri, 24 May 2019 12:05:50 +0200
Message-Id: <20190524100554.8606-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524100554.8606-1-maxime.chevallier@bootlin.com>
References: <20190524100554.8606-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today, the classification offload implementation only supports 4
different rules to be offloaded. This number has been hardcoded in the
rule insertion function, and the wrong define is being used elsewhere.

Use the correct #define everywhere to make sure we always check for the
correct number of rules.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h      | 2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c  | 4 ++--
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 6171270a016c..d5df813e08c4 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -923,7 +923,7 @@ struct mvpp2_port {
 	u32 indir[MVPP22_RSS_TABLE_ENTRIES];
 
 	/* List of steering rules active on that port */
-	struct mvpp2_ethtool_fs *rfs_rules[MVPP2_N_RFS_RULES];
+	struct mvpp2_ethtool_fs *rfs_rules[MVPP2_N_RFS_ENTRIES_PER_FLOW];
 	int n_rfs_rules;
 };
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index d046f7a1dcf5..9ce73297276e 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -1212,7 +1212,7 @@ int mvpp2_ethtool_cls_rule_get(struct mvpp2_port *port,
 {
 	struct mvpp2_ethtool_fs *efs;
 
-	if (rxnfc->fs.location >= MVPP2_N_RFS_RULES)
+	if (rxnfc->fs.location >= MVPP2_N_RFS_ENTRIES_PER_FLOW)
 		return -EINVAL;
 
 	efs = port->rfs_rules[rxnfc->fs.location];
@@ -1232,7 +1232,7 @@ int mvpp2_ethtool_cls_rule_ins(struct mvpp2_port *port,
 	struct mvpp2_ethtool_fs *efs, *old_efs;
 	int ret = 0;
 
-	if (info->fs.location >= 4 ||
+	if (info->fs.location >= MVPP2_N_RFS_ENTRIES_PER_FLOW ||
 	    info->fs.location < 0)
 		return -EINVAL;
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index d38952eb7aa9..8432315447dd 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3956,7 +3956,7 @@ static int mvpp2_ethtool_get_rxnfc(struct net_device *dev,
 		ret = mvpp2_ethtool_cls_rule_get(port, info);
 		break;
 	case ETHTOOL_GRXCLSRLALL:
-		for (i = 0; i < MVPP2_N_RFS_RULES; i++) {
+		for (i = 0; i < MVPP2_N_RFS_ENTRIES_PER_FLOW; i++) {
 			if (port->rfs_rules[i])
 				rules[loc++] = i;
 		}
-- 
2.20.1

