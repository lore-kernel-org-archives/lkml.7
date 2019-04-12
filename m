Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FA7C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DE020818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfDLPeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:34:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbfDLPeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:34:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A63D307D854;
        Fri, 12 Apr 2019 15:34:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 535055D9C5;
        Fri, 12 Apr 2019 15:34:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 6/6] rxrpc: Fix detection of out of order acks
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 12 Apr 2019 16:34:16 +0100
Message-ID: <155508325650.11035.17166206446780206078.stgit@warthog.procyon.org.uk>
In-Reply-To: <155508321298.11035.7196100250886302901.stgit@warthog.procyon.org.uk>
References: <155508321298.11035.7196100250886302901.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 12 Apr 2019 15:34:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffrey Altman <jaltman@auristor.com>

The rxrpc packet serial number cannot be safely used to compute out of
order ack packets for several reasons:

 1. The allocation of serial numbers cannot be assumed to imply the order
    by which acks are populated and transmitted.  In some rxrpc
    implementations, delayed acks and ping acks are transmitted
    asynchronously to the receipt of data packets and so may be transmitted
    out of order.  As a result, they can race with idle acks.

 2. Serial numbers are allocated by the rxrpc connection and not the call
    and as such may wrap independently if multiple channels are in use.

In any case, what matters is whether the ack packet provides new
information relating to the bounds of the window (the firstPacket and
previousPacket in the ACK data).

Fix this by discarding packets that appear to wind back the window bounds
rather than on serial number procession.

Fixes: 298bc15b2079 ("rxrpc: Only take the rwind and mtu values from latest ACK")
Signed-off-by: Jeffrey Altman <jaltman@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
---

 net/rxrpc/ar-internal.h |    1 +
 net/rxrpc/input.c       |   18 ++++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 4b1a534d290a..062ca9dc29b8 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -654,6 +654,7 @@ struct rxrpc_call {
 	u8			ackr_reason;	/* reason to ACK */
 	u16			ackr_skew;	/* skew on packet being ACK'd */
 	rxrpc_serial_t		ackr_serial;	/* serial of packet being ACK'd */
+	rxrpc_serial_t		ackr_first_seq;	/* first sequence number received */
 	rxrpc_seq_t		ackr_prev_seq;	/* previous sequence number received */
 	rxrpc_seq_t		ackr_consumed;	/* Highest packet shown consumed */
 	rxrpc_seq_t		ackr_seen;	/* Highest packet shown seen */
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 9128aa0e40aa..4c6f9d0a00e7 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -837,7 +837,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb,
 		u8 acks[RXRPC_MAXACKS];
 	} buf;
 	rxrpc_serial_t acked_serial;
-	rxrpc_seq_t first_soft_ack, hard_ack;
+	rxrpc_seq_t first_soft_ack, hard_ack, prev_pkt;
 	int nr_acks, offset, ioffset;
 
 	_enter("");
@@ -851,13 +851,14 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb,
 
 	acked_serial = ntohl(buf.ack.serial);
 	first_soft_ack = ntohl(buf.ack.firstPacket);
+	prev_pkt = ntohl(buf.ack.previousPacket);
 	hard_ack = first_soft_ack - 1;
 	nr_acks = buf.ack.nAcks;
 	summary.ack_reason = (buf.ack.reason < RXRPC_ACK__INVALID ?
 			      buf.ack.reason : RXRPC_ACK__INVALID);
 
 	trace_rxrpc_rx_ack(call, sp->hdr.serial, acked_serial,
-			   first_soft_ack, ntohl(buf.ack.previousPacket),
+			   first_soft_ack, prev_pkt,
 			   summary.ack_reason, nr_acks);
 
 	if (buf.ack.reason == RXRPC_ACK_PING_RESPONSE)
@@ -878,8 +879,9 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb,
 				  rxrpc_propose_ack_respond_to_ack);
 	}
 
-	/* Discard any out-of-order or duplicate ACKs. */
-	if (before_eq(sp->hdr.serial, call->acks_latest))
+	/* Discard any out-of-order or duplicate ACKs (outside lock). */
+	if (before(first_soft_ack, call->ackr_first_seq) ||
+	    before(prev_pkt, call->ackr_prev_seq))
 		return;
 
 	buf.info.rxMTU = 0;
@@ -890,12 +892,16 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb,
 
 	spin_lock(&call->input_lock);
 
-	/* Discard any out-of-order or duplicate ACKs. */
-	if (before_eq(sp->hdr.serial, call->acks_latest))
+	/* Discard any out-of-order or duplicate ACKs (inside lock). */
+	if (before(first_soft_ack, call->ackr_first_seq) ||
+	    before(prev_pkt, call->ackr_prev_seq))
 		goto out;
 	call->acks_latest_ts = skb->tstamp;
 	call->acks_latest = sp->hdr.serial;
 
+	call->ackr_first_seq = first_soft_ack;
+	call->ackr_prev_seq = prev_pkt;
+
 	/* Parse rwind and mtu sizes if provided. */
 	if (buf.info.rxMTU)
 		rxrpc_input_ackinfo(call, skb, &buf.info);

