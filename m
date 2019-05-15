Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5324C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795782082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfEOU6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:58:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfEOU6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:58:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84FAB307D945;
        Wed, 15 May 2019 20:58:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B00981820E;
        Wed, 15 May 2019 20:58:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/12] afs: Always get the reply time
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 21:58:48 +0100
Message-ID: <155795392895.28355.7423333828005842733.stgit@warthog.procyon.org.uk>
In-Reply-To: <155795389933.28355.4028912870853910492.stgit@warthog.procyon.org.uk>
References: <155795389933.28355.4028912870853910492.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 15 May 2019 20:58:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always ask for the reply time from AF_RXRPC as it's used to calculate the
callback expiry time and lock expiry times, so it's needed by most FS
operations.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/fsclient.c  |    9 ---------
 fs/afs/internal.h  |    2 +-
 fs/afs/rxrpc.c     |    4 ++--
 fs/afs/vlclient.c  |    1 -
 fs/afs/yfsclient.c |    3 ---
 5 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index f211cc53c1f0..8f06ab42442a 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -453,7 +453,6 @@ int afs_fs_fetch_file_status(struct afs_fs_cursor *fc, struct afs_volsync *volsy
 	call->xvnode = vnode;
 	call->out_volsync = volsync;
 	call->expected_version = new_inode ? 1 : vnode->status.data_version;
-	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -645,7 +644,6 @@ static int afs_fs_fetch_data64(struct afs_fs_cursor *fc, struct afs_read *req)
 	call->out_volsync = NULL;
 	call->read_request = req;
 	call->expected_version = vnode->status.data_version;
-	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -696,7 +694,6 @@ int afs_fs_fetch_data(struct afs_fs_cursor *fc, struct afs_read *req)
 	call->out_volsync = NULL;
 	call->read_request = req;
 	call->expected_version = vnode->status.data_version;
-	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -809,7 +806,6 @@ int afs_fs_create(struct afs_fs_cursor *fc,
 	call->out_extra_status = newstatus;
 	call->out_cb = newcb;
 	call->expected_version = current_data_version + 1;
-	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -1887,7 +1883,6 @@ int afs_fs_set_lock(struct afs_fs_cursor *fc, afs_lock_type_t type)
 
 	call->key = fc->key;
 	call->xvnode = vnode;
-	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -1925,7 +1920,6 @@ int afs_fs_extend_lock(struct afs_fs_cursor *fc)
 
 	call->key = fc->key;
 	call->xvnode = vnode;
-	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -2101,7 +2095,6 @@ struct afs_call *afs_fs_get_capabilities(struct afs_net *net,
 	call->server = afs_get_server(server);
 	call->server_index = server_index;
 	call->upgrade = true;
-	call->want_reply_time = true;
 	call->async = true;
 
 	/* marshall the parameters */
@@ -2186,7 +2179,6 @@ int afs_fs_fetch_status(struct afs_fs_cursor *fc,
 	call->out_cb = callback;
 	call->out_volsync = volsync;
 	call->expected_version = 1; /* vnode->status.data_version */
-	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -2360,7 +2352,6 @@ int afs_fs_inline_bulk_status(struct afs_fs_cursor *fc,
 	call->out_scb = statuses;
 	call->out_volsync = volsync;
 	call->count2 = nr_fids;
-	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 18d7eaf34f31..69582e746a9f 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -166,7 +166,7 @@ struct afs_call {
 	bool			need_attention;	/* T if RxRPC poked us */
 	bool			async;		/* T if asynchronous */
 	bool			upgrade;	/* T to request service upgrade */
-	bool			want_reply_time; /* T if want reply_time */
+	bool			have_reply_time; /* T if have got reply_time */
 	bool			intr;		/* T if interruptible */
 	u16			service_id;	/* Actual service ID (after upgrade) */
 	unsigned int		debug_id;	/* Trace ID */
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 5537d7fdcebd..cb93ae18ffa9 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -530,11 +530,11 @@ static void afs_deliver_to_call(struct afs_call *call)
 			return;
 		}
 
-		if (call->want_reply_time &&
+		if (!call->have_reply_time &&
 		    rxrpc_kernel_get_reply_time(call->net->socket,
 						call->rxcall,
 						&call->reply_time))
-			call->want_reply_time = false;
+			call->have_reply_time = true;
 
 		ret = call->type->deliver(call);
 		state = READ_ONCE(call->state);
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index b895098e7901..24cb226ee82c 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -396,7 +396,6 @@ struct afs_call *afs_vl_get_capabilities(struct afs_net *net,
 	call->vlserver = afs_get_vlserver(server);
 	call->server_index = server_index;
 	call->upgrade = true;
-	call->want_reply_time = true;
 	call->async = true;
 
 	/* marshall the parameters */
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 1f1ccf7b7822..b3ee99972d2f 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -695,7 +695,6 @@ int yfs_fs_fetch_data(struct afs_fs_cursor *fc, struct afs_read *req)
 	call->out_volsync = NULL;
 	call->read_request = req;
 	call->expected_version = vnode->status.data_version;
-	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -1847,7 +1846,6 @@ int yfs_fs_set_lock(struct afs_fs_cursor *fc, afs_lock_type_t type)
 
 	call->key = fc->key;
 	call->xvnode = vnode;
-	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -1886,7 +1884,6 @@ int yfs_fs_extend_lock(struct afs_fs_cursor *fc)
 
 	call->key = fc->key;
 	call->xvnode = vnode;
-	call->want_reply_time = true;
 
 	/* marshall the parameters */
 	bp = call->request;

