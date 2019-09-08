Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D55C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8195D21924
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946982;
	bh=W1koJkvkMYnVS+GM1B7GyDGkTgqgk2lOuB3FVKbM4qY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xr8dOehpCl+nn5bHpKxizXU/W/OkDxskeo02k5VoQUEHnMFS+QCJSp0h5pPs+OUyp
	 SsPvxtBFgFSZcg4ew8b/hJBFnz/Ew+hwmVjwZ3pQwYgqm+y0gKOgSKuH20Ohs+oOya
	 aqyzchanx6Nriy7NNPypra+y3p6YIH38ELWQn5K4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbfIHMtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731594AbfIHMti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:49:38 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2350B21924;
        Sun,  8 Sep 2019 12:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946977;
        bh=W1koJkvkMYnVS+GM1B7GyDGkTgqgk2lOuB3FVKbM4qY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P4LzuvUkoZiaBcsek8gTNhAEcc1H6X4lwHh+R2p6xCfHMnzzbZPSGgchH7/LvCk4V
         hr7OYMgO9I46bRTSQmVyFeYAPsASVrLSwNfQGpQbggNieVuvdFYHIJuDcfGSd12p3C
         fSy9vV/vJID3ZhKA2C1uJ9Z/34TZzSHdcEwucSZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jason Baron <jbaron@akamai.com>,
        Vladimir Rutsky <rutsky@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 07/94] tcp: remove empty skb from write queue in error cases
Date:   Sun,  8 Sep 2019 13:41:03 +0100
Message-Id: <20190908121150.642000321@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit fdfc5c8594c24c5df883583ebd286321a80e0a67 ]

Vladimir Rutsky reported stuck TCP sessions after memory pressure
events. Edge Trigger epoll() user would never receive an EPOLLOUT
notification allowing them to retry a sendmsg().

Jason tested the case of sk_stream_alloc_skb() returning NULL,
but there are other paths that could lead both sendmsg() and sendpage()
to return -1 (EAGAIN), with an empty skb queued on the write queue.

This patch makes sure we remove this empty skb so that
Jason code can detect that the queue is empty, and
call sk->sk_write_space(sk) accordingly.

Fixes: ce5ec440994b ("tcp: ensure epoll edge trigger wakeup when write queue is empty")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jason Baron <jbaron@akamai.com>
Reported-by: Vladimir Rutsky <rutsky@google.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |   30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -935,6 +935,22 @@ static int tcp_send_mss(struct sock *sk,
 	return mss_now;
 }
 
+/* In some cases, both sendpage() and sendmsg() could have added
+ * an skb to the write queue, but failed adding payload on it.
+ * We need to remove it to consume less memory, but more
+ * importantly be able to generate EPOLLOUT for Edge Trigger epoll()
+ * users.
+ */
+static void tcp_remove_empty_skb(struct sock *sk, struct sk_buff *skb)
+{
+	if (skb && !skb->len) {
+		tcp_unlink_write_queue(skb, sk);
+		if (tcp_write_queue_empty(sk))
+			tcp_chrono_stop(sk, TCP_CHRONO_BUSY);
+		sk_wmem_free_skb(sk, skb);
+	}
+}
+
 ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
 			 size_t size, int flags)
 {
@@ -1064,6 +1080,7 @@ out:
 	return copied;
 
 do_error:
+	tcp_remove_empty_skb(sk, tcp_write_queue_tail(sk));
 	if (copied)
 		goto out;
 out_err:
@@ -1388,18 +1405,11 @@ out_nopush:
 	sock_zerocopy_put(uarg);
 	return copied + copied_syn;
 
+do_error:
+	skb = tcp_write_queue_tail(sk);
 do_fault:
-	if (!skb->len) {
-		tcp_unlink_write_queue(skb, sk);
-		/* It is the one place in all of TCP, except connection
-		 * reset, where we can be unlinking the send_head.
-		 */
-		if (tcp_write_queue_empty(sk))
-			tcp_chrono_stop(sk, TCP_CHRONO_BUSY);
-		sk_wmem_free_skb(sk, skb);
-	}
+	tcp_remove_empty_skb(sk, skb);
 
-do_error:
 	if (copied + copied_syn)
 		goto out;
 out_err:


