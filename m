Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B497C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0F320818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfDLPeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:34:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfDLPeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:34:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 453F730821F8;
        Fri, 12 Apr 2019 15:34:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6267C19738;
        Fri, 12 Apr 2019 15:34:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net 5/6] rxrpc: Trace received connection aborts
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 12 Apr 2019 16:34:09 +0100
Message-ID: <155508324962.11035.10422478357244941506.stgit@warthog.procyon.org.uk>
In-Reply-To: <155508321298.11035.7196100250886302901.stgit@warthog.procyon.org.uk>
References: <155508321298.11035.7196100250886302901.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 12 Apr 2019 15:34:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trace received calls that are aborted due to a connection abort, typically
because of authentication failure.  Without this, connection aborts don't
show up in the trace log.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 net/rxrpc/conn_event.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index b6fca8ebb117..8d31fb4c51e1 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -153,7 +153,8 @@ static void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
  * pass a connection-level abort onto all calls on that connection
  */
 static void rxrpc_abort_calls(struct rxrpc_connection *conn,
-			      enum rxrpc_call_completion compl)
+			      enum rxrpc_call_completion compl,
+			      rxrpc_serial_t serial)
 {
 	struct rxrpc_call *call;
 	int i;
@@ -173,6 +174,9 @@ static void rxrpc_abort_calls(struct rxrpc_connection *conn,
 						  call->call_id, 0,
 						  conn->abort_code,
 						  conn->error);
+			else
+				trace_rxrpc_rx_abort(call, serial,
+						     conn->abort_code);
 			if (rxrpc_set_call_completion(call, compl,
 						      conn->abort_code,
 						      conn->error))
@@ -213,8 +217,6 @@ static int rxrpc_abort_connection(struct rxrpc_connection *conn,
 	conn->state = RXRPC_CONN_LOCALLY_ABORTED;
 	spin_unlock_bh(&conn->state_lock);
 
-	rxrpc_abort_calls(conn, RXRPC_CALL_LOCALLY_ABORTED);
-
 	msg.msg_name	= &conn->params.peer->srx.transport;
 	msg.msg_namelen	= conn->params.peer->srx.transport_len;
 	msg.msg_control	= NULL;
@@ -242,6 +244,7 @@ static int rxrpc_abort_connection(struct rxrpc_connection *conn,
 	len = iov[0].iov_len + iov[1].iov_len;
 
 	serial = atomic_inc_return(&conn->serial);
+	rxrpc_abort_calls(conn, RXRPC_CALL_LOCALLY_ABORTED, serial);
 	whdr.serial = htonl(serial);
 	_proto("Tx CONN ABORT %%%u { %d }", serial, conn->abort_code);
 
@@ -321,7 +324,7 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 		conn->error = -ECONNABORTED;
 		conn->abort_code = abort_code;
 		conn->state = RXRPC_CONN_REMOTELY_ABORTED;
-		rxrpc_abort_calls(conn, RXRPC_CALL_REMOTELY_ABORTED);
+		rxrpc_abort_calls(conn, RXRPC_CALL_REMOTELY_ABORTED, sp->hdr.serial);
 		return -ECONNABORTED;
 
 	case RXRPC_PACKET_TYPE_CHALLENGE:

