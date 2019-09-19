Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64885C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429722053B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 20:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392456AbfISUFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 16:05:04 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:28713 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389361AbfISUFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 16:05:04 -0400
Received: from localhost.localdomain ([93.22.37.255])
        by mwinf5d35 with ME
        id 3Y4t2100P5WHhHH03Y4tp2; Thu, 19 Sep 2019 22:05:02 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 19 Sep 2019 22:05:02 +0200
X-ME-IP: 93.22.37.255
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     atul.gupta@chelsio.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, akpm@linux-foundation.org,
        willy@infradead.org, kirill.shutemov@linux.intel.com,
        kstewart@linuxfoundation.org, yuehaibing@huawei.com,
        tglx@linutronix.de
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] crypto: chtls - simplify a bit 'create_flowc_wr_skb()'
Date:   Thu, 19 Sep 2019 22:04:28 +0200
Message-Id: <20190919200428.2664-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use '__skb_put_data()' instead of rewritting it.
This improves readability.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/crypto/chelsio/chtls/chtls_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/chelsio/chtls/chtls_io.c b/drivers/crypto/chelsio/chtls/chtls_io.c
index 0891ab829b1b..2512bfb24d71 100644
--- a/drivers/crypto/chelsio/chtls/chtls_io.c
+++ b/drivers/crypto/chelsio/chtls/chtls_io.c
@@ -97,7 +97,7 @@ static struct sk_buff *create_flowc_wr_skb(struct sock *sk,
 	if (!skb)
 		return NULL;
 
-	memcpy(__skb_put(skb, flowclen), flowc, flowclen);
+	__skb_put_data(skb, flowc, flowclen);
 	skb_set_queue_mapping(skb, (csk->txq_idx << 1) | CPL_PRIORITY_DATA);
 
 	return skb;
-- 
2.20.1

