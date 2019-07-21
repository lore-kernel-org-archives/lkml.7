Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18887C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 13:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA3720828
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 13:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfGUNQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 09:16:28 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:34455 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfGUNQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 09:16:28 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d34 with ME
        id fRGR2000D4n7eLC03RGSsT; Sun, 21 Jul 2019 15:16:26 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jul 2019 15:16:26 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] chelsio: Fix a typo in a function name
Date:   Sun, 21 Jul 2019 15:16:05 +0200
Message-Id: <20190721131605.16603-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is likely that 'my3216_poll()' should be 'my3126_poll()'. (1 and 2
switched in 3126.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/chelsio/cxgb/my3126.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb/my3126.c b/drivers/net/ethernet/chelsio/cxgb/my3126.c
index 20c09cc4b323..60aa45b375b6 100644
--- a/drivers/net/ethernet/chelsio/cxgb/my3126.c
+++ b/drivers/net/ethernet/chelsio/cxgb/my3126.c
@@ -94,7 +94,7 @@ static int my3126_interrupt_handler(struct cphy *cphy)
 	return cphy_cause_link_change;
 }
 
-static void my3216_poll(struct work_struct *work)
+static void my3126_poll(struct work_struct *work)
 {
 	struct cphy *cphy = container_of(work, struct cphy, phy_update.work);
 
@@ -177,7 +177,7 @@ static struct cphy *my3126_phy_create(struct net_device *dev,
 		return NULL;
 
 	cphy_init(cphy, dev, phy_addr, &my3126_ops, mdio_ops);
-	INIT_DELAYED_WORK(&cphy->phy_update, my3216_poll);
+	INIT_DELAYED_WORK(&cphy->phy_update, my3126_poll);
 	cphy->bmsr = 0;
 
 	return cphy;
-- 
2.20.1

