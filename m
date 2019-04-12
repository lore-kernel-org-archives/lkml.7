Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABEAC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B546E21872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfDLPd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:33:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfDLPd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:33:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76BEF30B8FB1;
        Fri, 12 Apr 2019 15:33:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93FF019CBD;
        Fri, 12 Apr 2019 15:33:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 3/6] rxrpc: Allow errors to be returned from
 rxrpc_queue_packet()
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 12 Apr 2019 16:33:54 +0100
Message-ID: <155508323460.11035.6817003533164928224.stgit@warthog.procyon.org.uk>
In-Reply-To: <155508321298.11035.7196100250886302901.stgit@warthog.procyon.org.uk>
References: <155508321298.11035.7196100250886302901.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 12 Apr 2019 15:33:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Dionne <marc.dionne@auristor.com>

Change rxrpc_queue_packet()'s signature so that it can return any error
code it may encounter when trying to send the packet.

This allows the caller to eventually do something in case of error - though
it should be noted that the packet has been queued and a resend is
scheduled.

Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/sendmsg.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 46c9312085b1..bec64deb7b0a 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -152,12 +152,13 @@ static void rxrpc_notify_end_tx(struct rxrpc_sock *rx, struct rxrpc_call *call,
 }
 
 /*
- * Queue a DATA packet for transmission, set the resend timeout and send the
- * packet immediately
+ * Queue a DATA packet for transmission, set the resend timeout and send
+ * the packet immediately.  Returns the error from rxrpc_send_data_packet()
+ * in case the caller wants to do something with it.
  */
-static void rxrpc_queue_packet(struct rxrpc_sock *rx, struct rxrpc_call *call,
-			       struct sk_buff *skb, bool last,
-			       rxrpc_notify_end_tx_t notify_end_tx)
+static int rxrpc_queue_packet(struct rxrpc_sock *rx, struct rxrpc_call *call,
+			      struct sk_buff *skb, bool last,
+			      rxrpc_notify_end_tx_t notify_end_tx)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	unsigned long now;
@@ -250,7 +251,8 @@ static void rxrpc_queue_packet(struct rxrpc_sock *rx, struct rxrpc_call *call,
 
 out:
 	rxrpc_free_skb(skb, rxrpc_skb_tx_freed);
-	_leave("");
+	_leave(" = %d", ret);
+	return ret;
 }
 
 /*
@@ -423,9 +425,10 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			if (ret < 0)
 				goto out;
 
-			rxrpc_queue_packet(rx, call, skb,
-					   !msg_data_left(msg) && !more,
-					   notify_end_tx);
+			ret = rxrpc_queue_packet(rx, call, skb,
+						 !msg_data_left(msg) && !more,
+						 notify_end_tx);
+			/* Should check for failure here */
 			skb = NULL;
 		}
 	} while (msg_data_left(msg) > 0);

