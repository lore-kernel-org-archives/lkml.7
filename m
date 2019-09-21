Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AB4C49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 06:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF8D21835
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 06:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407170AbfIUGRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 02:17:49 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:22809 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731003AbfIUGRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 02:17:49 -0400
Received: from localhost.localdomain ([93.22.38.188])
        by mwinf5d68 with ME
        id 46Hj2100d43Zwrh036HkQu; Sat, 21 Sep 2019 08:17:45 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Sep 2019 08:17:45 +0200
X-ME-IP: 93.22.38.188
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     khc@pm.waw.pl, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] hdlc: Simplify code in 'pvc_xmit()'
Date:   Sat, 21 Sep 2019 08:17:38 +0200
Message-Id: <20190921061738.25326-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __skb_pad instead of rewriting it, this saves some LoC.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/net/wan/hdlc_fr.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wan/hdlc_fr.c b/drivers/net/wan/hdlc_fr.c
index 9acad651ea1f..30f20b667c8b 100644
--- a/drivers/net/wan/hdlc_fr.c
+++ b/drivers/net/wan/hdlc_fr.c
@@ -414,16 +414,12 @@ static netdev_tx_t pvc_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (dev->type == ARPHRD_ETHER) {
 			int pad = ETH_ZLEN - skb->len;
 			if (pad > 0) { /* Pad the frame with zeros */
-				int len = skb->len;
-				if (skb_tailroom(skb) < pad)
-					if (pskb_expand_head(skb, 0, pad,
-							     GFP_ATOMIC)) {
-						dev->stats.tx_dropped++;
-						dev_kfree_skb(skb);
-						return NETDEV_TX_OK;
-					}
+				if (__skb_pad(skb, pad, false) < 0) {
+					dev->stats.tx_dropped++;
+					dev_kfree_skb(skb);
+					return NETDEV_TX_OK;
+				}
 				skb_put(skb, pad);
-				memset(skb->data + len, 0, pad);
 			}
 			skb->protocol = cpu_to_be16(ETH_P_802_3);
 		}
-- 
2.20.1

