Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F94C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14970207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfFFInT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:43:19 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:42945 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFFInS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:43:18 -0400
X-Originating-IP: 90.88.144.139
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-24-139.w90-88.abo.wanadoo.fr [90.88.144.139])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 7888E40008;
        Thu,  6 Jun 2019 08:43:13 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: [PATCH net] net: mvpp2: Use strscpy to handle stat strings
Date:   Thu,  6 Jun 2019 10:42:56 +0200
Message-Id: <20190606084256.3703-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a safe strscpy call to copy the ethtool stat strings into the
relevant buffers, instead of a memcpy that will be accessing
out-of-bound data.

Fixes: 118d6298f6f0 ("net: mvpp2: add ethtool GOP statistics")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 7a67e23a2c2b..d8e5241097a9 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -1304,8 +1304,8 @@ static void mvpp2_ethtool_get_strings(struct net_device *netdev, u32 sset,
 		int i;
 
 		for (i = 0; i < ARRAY_SIZE(mvpp2_ethtool_regs); i++)
-			memcpy(data + i * ETH_GSTRING_LEN,
-			       &mvpp2_ethtool_regs[i].string, ETH_GSTRING_LEN);
+			strscpy(data + i * ETH_GSTRING_LEN,
+			        mvpp2_ethtool_regs[i].string, ETH_GSTRING_LEN);
 	}
 }
 
-- 
2.20.1

