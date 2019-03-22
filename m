Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86149C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C5620850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255344;
	bh=ccU9d+BVL6rQI3/dwIfkfmnMH8wsIwP2AyeaMmVhhkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jKq/ubpeB9XXRXT+/l7Yuk9WnDyjVg80AfAdwQaTXVKOn7FDoFAJ5rpFTtf4pRnij
	 WMGC2F+3odu2PsWgxtwQHaGtYtGkqiU+AQkoXShGW6+42zQJ6q6V8zLu6MRlWnOduU
	 mWVqwt6EWiMXx+o226dI9a+lUbKeSu90jjexWUDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732390AbfCVLtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:49:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732034AbfCVLs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:48:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8FF3218B0;
        Fri, 22 Mar 2019 11:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255338;
        bh=ccU9d+BVL6rQI3/dwIfkfmnMH8wsIwP2AyeaMmVhhkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q1JHqIYEi3/NfYCdC1cV94fxdLWmQ6bPkirKYdzZkT5j6d3tNrUbSIN8jy9LddajB
         OafYbIyugblke1/bIAaWwN/ZC+4MKT94XEAMSMGfRutyuH44w8G7KBedSucmPZSYj9
         qc+p3tLMc4kg78Z7gWwJp8rjSOPC44oXahEIQTmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        Sean Tranchetti <stranche@codeaurora.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 041/183] af_key: unconditionally clone on broadcast
Date:   Fri, 22 Mar 2019 12:14:29 +0100
Message-Id: <20190322111244.708760499@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit fc2d5cfdcfe2ab76b263d91429caa22451123085 ]

Attempting to avoid cloning the skb when broadcasting by inflating
the refcount with sock_hold/sock_put while under RCU lock is dangerous
and violates RCU principles. It leads to subtle race conditions when
attempting to free the SKB, as we may reference sockets that have
already been freed by the stack.

Unable to handle kernel paging request at virtual address 6b6b6b6b6b6c4b
[006b6b6b6b6b6c4b] address between user and kernel address ranges
Internal error: Oops: 96000004 [#1] PREEMPT SMP
task: fffffff78f65b380 task.stack: ffffff8049a88000
pc : sock_rfree+0x38/0x6c
lr : skb_release_head_state+0x6c/0xcc
Process repro (pid: 7117, stack limit = 0xffffff8049a88000)
Call trace:
	sock_rfree+0x38/0x6c
	skb_release_head_state+0x6c/0xcc
	skb_release_all+0x1c/0x38
	__kfree_skb+0x1c/0x30
	kfree_skb+0xd0/0xf4
	pfkey_broadcast+0x14c/0x18c
	pfkey_sendmsg+0x1d8/0x408
	sock_sendmsg+0x44/0x60
	___sys_sendmsg+0x1d0/0x2a8
	__sys_sendmsg+0x64/0xb4
	SyS_sendmsg+0x34/0x4c
	el0_svc_naked+0x34/0x38
Kernel panic - not syncing: Fatal exception

Suggested-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Sean Tranchetti <stranche@codeaurora.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/key/af_key.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 3b209cbfe1df..b095551a5773 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -196,30 +196,22 @@ static int pfkey_release(struct socket *sock)
 	return 0;
 }
 
-static int pfkey_broadcast_one(struct sk_buff *skb, struct sk_buff **skb2,
-			       gfp_t allocation, struct sock *sk)
+static int pfkey_broadcast_one(struct sk_buff *skb, gfp_t allocation,
+			       struct sock *sk)
 {
 	int err = -ENOBUFS;
 
-	sock_hold(sk);
-	if (*skb2 == NULL) {
-		if (refcount_read(&skb->users) != 1) {
-			*skb2 = skb_clone(skb, allocation);
-		} else {
-			*skb2 = skb;
-			refcount_inc(&skb->users);
-		}
-	}
-	if (*skb2 != NULL) {
-		if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf) {
-			skb_set_owner_r(*skb2, sk);
-			skb_queue_tail(&sk->sk_receive_queue, *skb2);
-			sk->sk_data_ready(sk);
-			*skb2 = NULL;
-			err = 0;
-		}
+	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
+		return err;
+
+	skb = skb_clone(skb, allocation);
+
+	if (skb) {
+		skb_set_owner_r(skb, sk);
+		skb_queue_tail(&sk->sk_receive_queue, skb);
+		sk->sk_data_ready(sk);
+		err = 0;
 	}
-	sock_put(sk);
 	return err;
 }
 
@@ -234,7 +226,6 @@ static int pfkey_broadcast(struct sk_buff *skb, gfp_t allocation,
 {
 	struct netns_pfkey *net_pfkey = net_generic(net, pfkey_net_id);
 	struct sock *sk;
-	struct sk_buff *skb2 = NULL;
 	int err = -ESRCH;
 
 	/* XXX Do we need something like netlink_overrun?  I think
@@ -253,7 +244,7 @@ static int pfkey_broadcast(struct sk_buff *skb, gfp_t allocation,
 		 * socket.
 		 */
 		if (pfk->promisc)
-			pfkey_broadcast_one(skb, &skb2, GFP_ATOMIC, sk);
+			pfkey_broadcast_one(skb, GFP_ATOMIC, sk);
 
 		/* the exact target will be processed later */
 		if (sk == one_sk)
@@ -268,7 +259,7 @@ static int pfkey_broadcast(struct sk_buff *skb, gfp_t allocation,
 				continue;
 		}
 
-		err2 = pfkey_broadcast_one(skb, &skb2, GFP_ATOMIC, sk);
+		err2 = pfkey_broadcast_one(skb, GFP_ATOMIC, sk);
 
 		/* Error is cleared after successful sending to at least one
 		 * registered KM */
@@ -278,9 +269,8 @@ static int pfkey_broadcast(struct sk_buff *skb, gfp_t allocation,
 	rcu_read_unlock();
 
 	if (one_sk != NULL)
-		err = pfkey_broadcast_one(skb, &skb2, allocation, one_sk);
+		err = pfkey_broadcast_one(skb, allocation, one_sk);
 
-	kfree_skb(skb2);
 	kfree_skb(skb);
 	return err;
 }
-- 
2.19.1



