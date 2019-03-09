Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B779C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 00:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C5820851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 00:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfCIAaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 19:30:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfCIAaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 19:30:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C63C33082128;
        Sat,  9 Mar 2019 00:30:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C2C20600C1;
        Sat,  9 Mar 2019 00:29:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net] rxrpc: Fix client call queueing, waiting for channel
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Marc Dionne <marc.dionne@auristor.com>, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Sat, 09 Mar 2019 00:29:58 +0000
Message-ID: <155209139894.21860.5649266453556857318.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sat, 09 Mar 2019 00:30:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rxrpc_get_client_conn() adds a new call to the front of the waiting_calls
queue if the connection it's going to use already exists.  This is bad as
it allows calls to get starved out.

Fix this by adding to the tail instead.

Also change the other enqueue point in the same function to put it on the
front (ie. when we have a new connection).  This makes the point that in
the case of a new connection the new call goes at the front (though it
doesn't actually matter since the queue should be unoccupied).

Fixes: 45025bceef17 ("rxrpc: Improve management and caching of client connection objects")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
---

 net/rxrpc/conn_client.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 505690dbd0be..04e62afea063 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -354,7 +354,7 @@ static int rxrpc_get_client_conn(struct rxrpc_sock *rx,
 	 * normally have to take channel_lock but we do this before anyone else
 	 * can see the connection.
 	 */
-	list_add_tail(&call->chan_wait_link, &candidate->waiting_calls);
+	list_add(&call->chan_wait_link, &candidate->waiting_calls);
 
 	if (cp->exclusive) {
 		call->conn = candidate;
@@ -433,7 +433,7 @@ static int rxrpc_get_client_conn(struct rxrpc_sock *rx,
 	call->conn = conn;
 	call->security_ix = conn->security_ix;
 	call->service_id = conn->service_id;
-	list_add(&call->chan_wait_link, &conn->waiting_calls);
+	list_add_tail(&call->chan_wait_link, &conn->waiting_calls);
 	spin_unlock(&conn->channel_lock);
 	_leave(" = 0 [extant %d]", conn->debug_id);
 	return 0;

