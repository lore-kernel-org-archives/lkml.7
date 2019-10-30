Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5B1CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 06:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5378320659
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 06:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfJ3GhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 02:37:02 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:21693 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbfJ3GhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 02:37:02 -0400
Received: from localhost.localdomain ([93.22.133.151])
        by mwinf5d79 with ME
        id Kicw210073G8tn903icwwo; Wed, 30 Oct 2019 07:36:59 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 30 Oct 2019 07:36:59 +0100
X-ME-IP: 93.22.133.151
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     davem@davemloft.net, navid.emamdoost@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] net: qrtr: Simplify 'qrtr_tun_release()'
Date:   Wed, 30 Oct 2019 07:36:40 +0100
Message-Id: <20191030063640.25794-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'skb_queue_purge()' instead of re-implementing it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 net/qrtr/tun.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/qrtr/tun.c b/net/qrtr/tun.c
index e35869e81766..15ce9b642b25 100644
--- a/net/qrtr/tun.c
+++ b/net/qrtr/tun.c
@@ -111,15 +111,11 @@ static __poll_t qrtr_tun_poll(struct file *filp, poll_table *wait)
 static int qrtr_tun_release(struct inode *inode, struct file *filp)
 {
 	struct qrtr_tun *tun = filp->private_data;
-	struct sk_buff *skb;
 
 	qrtr_endpoint_unregister(&tun->ep);
 
 	/* Discard all SKBs */
-	while (!skb_queue_empty(&tun->queue)) {
-		skb = skb_dequeue(&tun->queue);
-		kfree_skb(skb);
-	}
+	skb_queue_purge(&tun->queue);
 
 	kfree(tun);
 
-- 
2.20.1

