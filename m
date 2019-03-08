Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB030C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A2C2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfCHMsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:48:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfCHMsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:48:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20A39307B967;
        Fri,  8 Mar 2019 12:48:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE7E95C57C;
        Fri,  8 Mar 2019 12:48:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net] rxrpc: Fix client call connect/disconnect race
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Marc Dionne <marc.dionne@auristor.com>, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 08 Mar 2019 12:48:39 +0000
Message-ID: <155204931903.22787.5981080627556318769.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 08 Mar 2019 12:48:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rxrpc_disconnect_client_call() reads the call's connection ID protocol
value (call->cid) as part of that function's variable declarations.  This
is bad because it's not inside the locked section and so may race with
someone granting use of the channel to the call.

This manifests as an assertion failure (see below) where the call in the
presumed channel (0 because call->cid wasn't set when we read it) doesn't
match the call attached to the channel we were actually granted (if 1, 2 or
3).

Fix this by moving the read and dependent calculations inside of the
channel_lock section.  Also, only set the channel number and pointer
variables if cid is not zero (ie. unset).

This problem can be induced by injecting an occasional error in
rxrpc_wait_for_channel() before the call to schedule().

Make two further changes also:

 (1) Add a trace for wait failure in rxrpc_connect_call().

 (2) Drop channel_lock before BUG'ing in the case of the assertion failure.

The failure causes a trace akin to the following:

rxrpc: Assertion failed - 18446612685268945920(0xffff8880beab8c00) == 18446612685268621312(0xffff8880bea69800) is false
------------[ cut here ]------------
kernel BUG at net/rxrpc/conn_client.c:824!
...
RIP: 0010:rxrpc_disconnect_client_call+0x2bf/0x99d
...
Call Trace:
 rxrpc_connect_call+0x902/0x9b3
 ? wake_up_q+0x54/0x54
 rxrpc_new_client_call+0x3a0/0x751
 ? rxrpc_kernel_begin_call+0x141/0x1bc
 ? afs_alloc_call+0x1b5/0x1b5
 rxrpc_kernel_begin_call+0x141/0x1bc
 afs_make_call+0x20c/0x525
 ? afs_alloc_call+0x1b5/0x1b5
 ? __lock_is_held+0x40/0x71
 ? lockdep_init_map+0xaf/0x193
 ? lockdep_init_map+0xaf/0x193
 ? __lock_is_held+0x40/0x71
 ? yfs_fs_fetch_data+0x33b/0x34a
 yfs_fs_fetch_data+0x33b/0x34a
 afs_fetch_data+0xdc/0x3b7
 afs_read_dir+0x52d/0x97f
 afs_dir_iterate+0xa0/0x661
 ? iterate_dir+0x63/0x141
 iterate_dir+0xa2/0x141
 ksys_getdents64+0x9f/0x11b
 ? filldir+0x111/0x111
 ? do_syscall_64+0x3e/0x1a0
 __x64_sys_getdents64+0x16/0x19
 do_syscall_64+0x7d/0x1a0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: 45025bceef17 ("rxrpc: Improve management and caching of client connection objects")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
---

 include/trace/events/rxrpc.h |    2 ++
 net/rxrpc/conn_client.c      |   20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 5b50fe4906d2..7b60fd186cfe 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -76,6 +76,7 @@ enum rxrpc_client_trace {
 	rxrpc_client_chan_disconnect,
 	rxrpc_client_chan_pass,
 	rxrpc_client_chan_unstarted,
+	rxrpc_client_chan_wait_failed,
 	rxrpc_client_cleanup,
 	rxrpc_client_count,
 	rxrpc_client_discard,
@@ -276,6 +277,7 @@ enum rxrpc_tx_point {
 	EM(rxrpc_client_chan_disconnect,	"ChDisc") \
 	EM(rxrpc_client_chan_pass,		"ChPass") \
 	EM(rxrpc_client_chan_unstarted,		"ChUnst") \
+	EM(rxrpc_client_chan_wait_failed,	"ChWtFl") \
 	EM(rxrpc_client_cleanup,		"Clean ") \
 	EM(rxrpc_client_count,			"Count ") \
 	EM(rxrpc_client_discard,		"Discar") \
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index b2adfa825363..f307a05076e1 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -704,6 +704,7 @@ int rxrpc_connect_call(struct rxrpc_sock *rx,
 
 	ret = rxrpc_wait_for_channel(call, gfp);
 	if (ret < 0) {
+		trace_rxrpc_client(call->conn, ret, rxrpc_client_chan_wait_failed);
 		rxrpc_disconnect_client_call(call);
 		goto out;
 	}
@@ -774,16 +775,22 @@ static void rxrpc_set_client_reap_timer(struct rxrpc_net *rxnet)
  */
 void rxrpc_disconnect_client_call(struct rxrpc_call *call)
 {
-	unsigned int channel = call->cid & RXRPC_CHANNELMASK;
 	struct rxrpc_connection *conn = call->conn;
-	struct rxrpc_channel *chan = &conn->channels[channel];
+	struct rxrpc_channel *chan = NULL;
 	struct rxrpc_net *rxnet = conn->params.local->rxnet;
+	unsigned int channel = -1;
+	u32 cid;
 
+	spin_lock(&conn->channel_lock);
+
+	cid = call->cid;
+	if (cid) {
+		channel = cid & RXRPC_CHANNELMASK;
+		chan = &conn->channels[channel];
+	}
 	trace_rxrpc_client(conn, channel, rxrpc_client_chan_disconnect);
 	call->conn = NULL;
 
-	spin_lock(&conn->channel_lock);
-
 	/* Calls that have never actually been assigned a channel can simply be
 	 * discarded.  If the conn didn't get used either, it will follow
 	 * immediately unless someone else grabs it in the meantime.
@@ -807,7 +814,10 @@ void rxrpc_disconnect_client_call(struct rxrpc_call *call)
 		goto out;
 	}
 
-	ASSERTCMP(rcu_access_pointer(chan->call), ==, call);
+	if (rcu_access_pointer(chan->call) != call) {
+		spin_unlock(&conn->channel_lock);
+		BUG();
+	}
 
 	/* If a client call was exposed to the world, we save the result for
 	 * retransmission.

