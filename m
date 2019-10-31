Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFD9CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E2E2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfJaGrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 02:47:52 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:27139 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfJaGrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 02:47:52 -0400
Received: from localhost.localdomain ([93.23.12.90])
        by mwinf5d87 with ME
        id L6nn210011waAWt036nnoq; Thu, 31 Oct 2019 07:47:49 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 31 Oct 2019 07:47:49 +0100
X-ME-IP: 93.23.12.90
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     davem@davemloft.net, sunilmut@microsoft.com, willemb@google.com,
        sgarzare@redhat.com, stefanha@redhat.com, ytht.net@gmail.com,
        arnd@arndb.de, tglx@linutronix.de, decui@microsoft.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] vsock: Simplify '__vsock_release()'
Date:   Thu, 31 Oct 2019 07:47:41 +0100
Message-Id: <20191031064741.4567-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use '__skb_queue_purge()' instead of re-implementing it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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

