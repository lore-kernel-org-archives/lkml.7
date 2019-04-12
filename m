Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8803AC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7C721872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfDLPdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:33:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbfDLPdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:33:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A1CC309E9A7;
        Fri, 12 Apr 2019 15:33:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 508B760BEC;
        Fri, 12 Apr 2019 15:33:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 2/6] rxrpc: Make rxrpc_kernel_check_life() indicate if
 call completed
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 12 Apr 2019 16:33:47 +0100
Message-ID: <155508322751.11035.4424014648042273965.stgit@warthog.procyon.org.uk>
In-Reply-To: <155508321298.11035.7196100250886302901.stgit@warthog.procyon.org.uk>
References: <155508321298.11035.7196100250886302901.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 12 Apr 2019 15:33:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Dionne <marc.dionne@auristor.com>

Make rxrpc_kernel_check_life() pass back the life counter through the
argument list and return true if the call has not yet completed.

Suggested-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/networking/rxrpc.txt |   16 +++++++++-------
 fs/afs/rxrpc.c                     |    4 ++--
 include/net/af_rxrpc.h             |    4 +++-
 net/rxrpc/af_rxrpc.c               |   14 +++++++++-----
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/Documentation/networking/rxrpc.txt b/Documentation/networking/rxrpc.txt
index 2df5894353d6..cd7303d7fa25 100644
--- a/Documentation/networking/rxrpc.txt
+++ b/Documentation/networking/rxrpc.txt
@@ -1009,16 +1009,18 @@ The kernel interface functions are as follows:
 
  (*) Check call still alive.
 
-	u32 rxrpc_kernel_check_life(struct socket *sock,
-				    struct rxrpc_call *call);
+	bool rxrpc_kernel_check_life(struct socket *sock,
+				     struct rxrpc_call *call,
+				     u32 *_life);
 	void rxrpc_kernel_probe_life(struct socket *sock,
 				     struct rxrpc_call *call);
 
-     The first function returns a number that is updated when ACKs are received
-     from the peer (notably including PING RESPONSE ACKs which we can elicit by
-     sending PING ACKs to see if the call still exists on the server).  The
-     caller should compare the numbers of two calls to see if the call is still
-     alive after waiting for a suitable interval.
+     The first function passes back in *_life a number that is updated when
+     ACKs are received from the peer (notably including PING RESPONSE ACKs
+     which we can elicit by sending PING ACKs to see if the call still exists
+     on the server).  The caller should compare the numbers of two calls to see
+     if the call is still alive after waiting for a suitable interval.  It also
+     returns true as long as the call hasn't yet reached the completed state.
 
      This allows the caller to work out if the server is still contactable and
      if the call is still alive on the server while waiting for the server to
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 2c588f9bbbda..5cb11aff9298 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -621,7 +621,7 @@ static long afs_wait_for_call_to_complete(struct afs_call *call,
 		rtt2 = 2;
 
 	timeout = rtt2;
-	last_life = rxrpc_kernel_check_life(call->net->socket, call->rxcall);
+	rxrpc_kernel_check_life(call->net->socket, call->rxcall, &last_life);
 
 	add_wait_queue(&call->waitq, &myself);
 	for (;;) {
@@ -639,7 +639,7 @@ static long afs_wait_for_call_to_complete(struct afs_call *call,
 		if (afs_check_call_state(call, AFS_CALL_COMPLETE))
 			break;
 
-		life = rxrpc_kernel_check_life(call->net->socket, call->rxcall);
+		rxrpc_kernel_check_life(call->net->socket, call->rxcall, &life);
 		if (timeout == 0 &&
 		    life == last_life && signal_pending(current)) {
 			if (stalled)
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index 2bfb87eb98ce..78c856cba4f5 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -61,10 +61,12 @@ int rxrpc_kernel_charge_accept(struct socket *, rxrpc_notify_rx_t,
 			       rxrpc_user_attach_call_t, unsigned long, gfp_t,
 			       unsigned int);
 void rxrpc_kernel_set_tx_length(struct socket *, struct rxrpc_call *, s64);
-u32 rxrpc_kernel_check_life(const struct socket *, const struct rxrpc_call *);
+bool rxrpc_kernel_check_life(const struct socket *, const struct rxrpc_call *,
+			     u32 *);
 void rxrpc_kernel_probe_life(struct socket *, struct rxrpc_call *);
 u32 rxrpc_kernel_get_epoch(struct socket *, struct rxrpc_call *);
 bool rxrpc_kernel_get_reply_time(struct socket *, struct rxrpc_call *,
 				 ktime_t *);
+bool rxrpc_kernel_call_is_complete(struct rxrpc_call *);
 
 #endif /* _NET_RXRPC_H */
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 96f2952bbdfd..54165722d6d0 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -370,18 +370,22 @@ EXPORT_SYMBOL(rxrpc_kernel_end_call);
  * rxrpc_kernel_check_life - Check to see whether a call is still alive
  * @sock: The socket the call is on
  * @call: The call to check
+ * @_life: Where to store the life value
  *
  * Allow a kernel service to find out whether a call is still alive - ie. we're
- * getting ACKs from the server.  Returns a number representing the life state
- * which can be compared to that returned by a previous call.
+ * getting ACKs from the server.  Passes back in *_life a number representing
+ * the life state which can be compared to that returned by a previous call and
+ * return true if the call is still alive.
  *
  * If the life state stalls, rxrpc_kernel_probe_life() should be called and
  * then 2RTT waited.
  */
-u32 rxrpc_kernel_check_life(const struct socket *sock,
-			    const struct rxrpc_call *call)
+bool rxrpc_kernel_check_life(const struct socket *sock,
+			     const struct rxrpc_call *call,
+			     u32 *_life)
 {
-	return call->acks_latest;
+	*_life = call->acks_latest;
+	return call->state != RXRPC_CALL_COMPLETE;
 }
 EXPORT_SYMBOL(rxrpc_kernel_check_life);
 

