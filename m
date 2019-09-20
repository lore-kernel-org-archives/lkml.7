Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C947C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 04:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635E820717
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 04:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437187AbfITE5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 00:57:03 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:47684 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfITE5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 00:57:02 -0400
Received: from localhost.localdomain ([90.126.97.183])
        by mwinf5d25 with ME
        id 3gwy210013xPcdm03gwyg7; Fri, 20 Sep 2019 06:57:00 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 20 Sep 2019 06:57:00 +0200
X-ME-IP: 90.126.97.183
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     aelior@marvell.com, GR-everest-linux-l2@marvell.com,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] qede: qede_fp: simplify a bit 'qede_rx_build_skb()'
Date:   Fri, 20 Sep 2019 06:56:56 +0200
Message-Id: <20190920045656.3725-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'skb_put_data()' instead of rewritting it.
This improves readability.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/qlogic/qede/qede_fp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
index 0ae28f0d2523..004c0bfec41d 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
@@ -779,8 +779,7 @@ qede_rx_build_skb(struct qede_dev *edev,
 			return NULL;
 
 		skb_reserve(skb, pad);
-		memcpy(skb_put(skb, len),
-		       page_address(bd->data) + offset, len);
+		skb_put_data(skb, page_address(bd->data) + offset, len);
 		qede_reuse_page(rxq, bd);
 		goto out;
 	}
-- 
2.20.1

