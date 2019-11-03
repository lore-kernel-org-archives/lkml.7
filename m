Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5F5CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 06:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BE9214D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 06:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfKCGL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 01:11:26 -0500
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:29876 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfKCGLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 01:11:25 -0500
Received: from localhost.localdomain ([93.23.13.15])
        by mwinf5d36 with ME
        id MJBK2100J0KV3P903JBLU9; Sun, 03 Nov 2019 07:11:22 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 03 Nov 2019 07:11:22 +0100
X-ME-IP: 93.23.13.15
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     davem@davemloft.net, stefanha@redhat.com, ytht.net@gmail.com,
        sunilmut@microsoft.com, willemb@google.com, arnd@arndb.de,
        tglx@linutronix.de, decui@microsoft.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2] vsock: Simplify '__vsock_release()'
Date:   Sun,  3 Nov 2019 07:11:11 +0100
Message-Id: <20191103061111.22003-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'skb_queue_purge()' instead of re-implementing it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
V2: fix a typo in the commit message
    Add R-b tags
---
 net/vmw_vsock/af_vsock.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2ab43b2bba31..2983dc92ca63 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -641,7 +641,6 @@ EXPORT_SYMBOL_GPL(__vsock_create);
 static void __vsock_release(struct sock *sk, int level)
 {
 	if (sk) {
-		struct sk_buff *skb;
 		struct sock *pending;
 		struct vsock_sock *vsk;
 
@@ -662,8 +661,7 @@ static void __vsock_release(struct sock *sk, int level)
 		sock_orphan(sk);
 		sk->sk_shutdown = SHUTDOWN_MASK;
 
-		while ((skb = skb_dequeue(&sk->sk_receive_queue)))
-			kfree_skb(skb);
+		skb_queue_purge(&sk->sk_receive_queue);
 
 		/* Clean up any sockets that never were accepted. */
 		while ((pending = vsock_dequeue_accept(sk)) != NULL) {
-- 
2.20.1

