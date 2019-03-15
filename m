Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305F6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9F5218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfCOXHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:07:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfCOXHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:07:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D257781F13;
        Fri, 15 Mar 2019 22:59:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 976241001DC9;
        Fri, 15 Mar 2019 22:59:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/10] afs: Split wait from afs_make_call()
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 15 Mar 2019 22:59:27 +0000
Message-ID: <155269076781.8537.1145723268122170784.stgit@warthog.procyon.org.uk>
In-Reply-To: <155269076033.8537.10785090349210421514.stgit@warthog.procyon.org.uk>
References: <155269076033.8537.10785090349210421514.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 15 Mar 2019 22:59:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the call to afs_wait_for_call_to_complete() from afs_make_call() to
make it easier to handle asynchronous calls and to make it easier to
convert a synchronous call to an asynchronous one in future, for instance
when someone tries to interrupt an operation by pressing Ctrl-C.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/fs_probe.c  |   13 +++++----
 fs/afs/fsclient.c  |   78 +++++++++++++++++++++++++++++++++-------------------
 fs/afs/internal.h  |   12 +++++---
 fs/afs/rxrpc.c     |   33 +++++++++++-----------
 fs/afs/vl_probe.c  |   14 +++++----
 fs/afs/vlclient.c  |   26 ++++++++++-------
 fs/afs/yfsclient.c |   54 ++++++++++++++++++++++++------------
 7 files changed, 139 insertions(+), 91 deletions(-)

diff --git a/fs/afs/fs_probe.c b/fs/afs/fs_probe.c
index 3a9eaec06756..5d3abde52a0f 100644
--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -141,8 +141,8 @@ static int afs_do_probe_fileserver(struct afs_net *net,
 	struct afs_addr_cursor ac = {
 		.index = 0,
 	};
+	struct afs_call *call;
 	bool in_progress = false;
-	int err;
 
 	_enter("%pU", &server->uuid);
 
@@ -156,12 +156,13 @@ static int afs_do_probe_fileserver(struct afs_net *net,
 	server->probe.rtt = UINT_MAX;
 
 	for (ac.index = 0; ac.index < ac.alist->nr_addrs; ac.index++) {
-		err = afs_fs_get_capabilities(net, server, &ac, key, server_index,
-					      true);
-		if (err == -EINPROGRESS)
+		call = afs_fs_get_capabilities(net, server, &ac, key, server_index);
+		if (!IS_ERR(call)) {
+			afs_put_call(call);
 			in_progress = true;
-		else
-			afs_prioritise_error(_e, err, ac.abort_code);
+		} else {
+			afs_prioritise_error(_e, PTR_ERR(call), ac.abort_code);
+		}
 	}
 
 	if (!in_progress)
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index ca08c83168f5..2ff19ebda666 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -468,7 +468,9 @@ int afs_fs_fetch_file_status(struct afs_fs_cursor *fc, struct afs_volsync *volsy
 	call->cb_break = fc->cb_break;
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -660,7 +662,8 @@ static int afs_fs_fetch_data64(struct afs_fs_cursor *fc, struct afs_read *req)
 	call->cb_break = fc->cb_break;
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -707,7 +710,8 @@ int afs_fs_fetch_data(struct afs_fs_cursor *fc, struct afs_read *req)
 	call->cb_break = fc->cb_break;
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -827,7 +831,8 @@ int afs_fs_create(struct afs_fs_cursor *fc,
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -922,7 +927,8 @@ int afs_fs_remove(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &dvnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1014,7 +1020,8 @@ int afs_fs_link(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1128,7 +1135,8 @@ int afs_fs_symlink(struct afs_fs_cursor *fc,
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1246,7 +1254,8 @@ int afs_fs_rename(struct afs_fs_cursor *fc,
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &orig_dvnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1350,7 +1359,8 @@ static int afs_fs_store_data64(struct afs_fs_cursor *fc,
 	*bp++ = htonl((u32) i_size);
 
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1426,7 +1436,8 @@ int afs_fs_store_data(struct afs_fs_cursor *fc, struct address_space *mapping,
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1524,7 +1535,8 @@ static int afs_fs_setattr_size64(struct afs_fs_cursor *fc, struct iattr *attr)
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1570,7 +1582,8 @@ static int afs_fs_setattr_size(struct afs_fs_cursor *fc, struct iattr *attr)
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1614,7 +1627,8 @@ int afs_fs_setattr(struct afs_fs_cursor *fc, struct iattr *attr)
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1798,7 +1812,8 @@ int afs_fs_get_volume_status(struct afs_fs_cursor *fc,
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1885,7 +1900,8 @@ int afs_fs_set_lock(struct afs_fs_cursor *fc, afs_lock_type_t type)
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1919,7 +1935,8 @@ int afs_fs_extend_lock(struct afs_fs_cursor *fc)
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1953,7 +1970,8 @@ int afs_fs_release_lock(struct afs_fs_cursor *fc)
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1998,7 +2016,8 @@ int afs_fs_give_up_all_callbacks(struct afs_net *net,
 	*bp++ = htonl(FSGIVEUPALLCALLBACKS);
 
 	/* Can't take a ref on server */
-	return afs_make_call(ac, call, GFP_NOFS, false);
+	afs_make_call(ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, ac);
 }
 
 /*
@@ -2068,12 +2087,11 @@ static const struct afs_call_type afs_RXFSGetCapabilities = {
  * Probe a fileserver for the capabilities that it supports.  This can
  * return up to 196 words.
  */
-int afs_fs_get_capabilities(struct afs_net *net,
-			    struct afs_server *server,
-			    struct afs_addr_cursor *ac,
-			    struct key *key,
-			    unsigned int server_index,
-			    bool async)
+struct afs_call *afs_fs_get_capabilities(struct afs_net *net,
+					 struct afs_server *server,
+					 struct afs_addr_cursor *ac,
+					 struct key *key,
+					 unsigned int server_index)
 {
 	struct afs_call *call;
 	__be32 *bp;
@@ -2082,13 +2100,14 @@ int afs_fs_get_capabilities(struct afs_net *net,
 
 	call = afs_alloc_flat_call(net, &afs_RXFSGetCapabilities, 1 * 4, 16 * 4);
 	if (!call)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	call->key = key;
 	call->reply[0] = afs_get_server(server);
 	call->reply[1] = (void *)(long)server_index;
 	call->upgrade = true;
 	call->want_reply_time = true;
+	call->async = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -2096,7 +2115,8 @@ int afs_fs_get_capabilities(struct afs_net *net,
 
 	/* Can't take a ref on server */
 	trace_afs_make_fs_call(call, NULL);
-	return afs_make_call(ac, call, GFP_NOFS, async);
+	afs_make_call(ac, call, GFP_NOFS);
+	return call;
 }
 
 /*
@@ -2183,7 +2203,8 @@ int afs_fs_fetch_status(struct afs_fs_cursor *fc,
 	call->cb_break = fc->cb_break;
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -2363,5 +2384,6 @@ int afs_fs_inline_bulk_status(struct afs_fs_cursor *fc,
 	call->cb_break = fc->cb_break;
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &fids[0]);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index bb1f244b2b3a..1530d7e9e7a9 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -941,8 +941,9 @@ extern int afs_fs_extend_lock(struct afs_fs_cursor *);
 extern int afs_fs_release_lock(struct afs_fs_cursor *);
 extern int afs_fs_give_up_all_callbacks(struct afs_net *, struct afs_server *,
 					struct afs_addr_cursor *, struct key *);
-extern int afs_fs_get_capabilities(struct afs_net *, struct afs_server *,
-				   struct afs_addr_cursor *, struct key *, unsigned int, bool);
+extern struct afs_call *afs_fs_get_capabilities(struct afs_net *, struct afs_server *,
+						struct afs_addr_cursor *, struct key *,
+						unsigned int);
 extern int afs_fs_inline_bulk_status(struct afs_fs_cursor *, struct afs_net *,
 				     struct afs_fid *, struct afs_file_status *,
 				     struct afs_callback *, unsigned int,
@@ -1075,7 +1076,8 @@ extern int __net_init afs_open_socket(struct afs_net *);
 extern void __net_exit afs_close_socket(struct afs_net *);
 extern void afs_charge_preallocation(struct work_struct *);
 extern void afs_put_call(struct afs_call *);
-extern long afs_make_call(struct afs_addr_cursor *, struct afs_call *, gfp_t, bool);
+extern void afs_make_call(struct afs_addr_cursor *, struct afs_call *, gfp_t);
+extern long afs_wait_for_call_to_complete(struct afs_call *, struct afs_addr_cursor *);
 extern struct afs_call *afs_alloc_flat_call(struct afs_net *,
 					    const struct afs_call_type *,
 					    size_t, size_t);
@@ -1220,8 +1222,8 @@ extern void afs_fs_exit(void);
 extern struct afs_vldb_entry *afs_vl_get_entry_by_name_u(struct afs_vl_cursor *,
 							 const char *, int);
 extern struct afs_addr_list *afs_vl_get_addrs_u(struct afs_vl_cursor *, const uuid_t *);
-extern int afs_vl_get_capabilities(struct afs_net *, struct afs_addr_cursor *, struct key *,
-				   struct afs_vlserver *, unsigned int, bool);
+extern struct afs_call *afs_vl_get_capabilities(struct afs_net *, struct afs_addr_cursor *,
+						struct key *, struct afs_vlserver *, unsigned int);
 extern struct afs_addr_list *afs_yfsvl_get_endpoints(struct afs_vl_cursor *, const uuid_t *);
 
 /*
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 2c588f9bbbda..416e875f7fbf 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -21,7 +21,6 @@
 struct workqueue_struct *afs_async_calls;
 
 static void afs_wake_up_call_waiter(struct sock *, struct rxrpc_call *, unsigned long);
-static long afs_wait_for_call_to_complete(struct afs_call *, struct afs_addr_cursor *);
 static void afs_wake_up_async_call(struct sock *, struct rxrpc_call *, unsigned long);
 static void afs_delete_async_call(struct work_struct *);
 static void afs_process_async_call(struct work_struct *);
@@ -361,10 +360,10 @@ static int afs_send_pages(struct afs_call *call, struct msghdr *msg)
 }
 
 /*
- * initiate a call
+ * Initiate a call and synchronously queue up the parameters for dispatch.  Any
+ * error is stored into the call struct, which the caller must check for.
  */
-long afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call,
-		   gfp_t gfp, bool async)
+void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 {
 	struct sockaddr_rxrpc *srx = &ac->alist->addrs[ac->index];
 	struct rxrpc_call *rxcall;
@@ -382,7 +381,6 @@ long afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call,
 	       call, call->type->name, key_serial(call->key),
 	       atomic_read(&call->net->nr_outstanding_calls));
 
-	call->async = async;
 	call->addr_ix = ac->index;
 	call->alist = afs_get_addrlist(ac->alist);
 
@@ -415,7 +413,7 @@ long afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call,
 	rxcall = rxrpc_kernel_begin_call(call->net->socket, srx, call->key,
 					 (unsigned long)call,
 					 tx_total_len, gfp,
-					 (async ?
+					 (call->async ?
 					  afs_wake_up_async_call :
 					  afs_wake_up_call_waiter),
 					 call->upgrade,
@@ -453,13 +451,11 @@ long afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call,
 
 	/* Note that at this point, we may have received the reply or an abort
 	 * - and an asynchronous call may already have completed.
+	 *
+	 * afs_wait_for_call_to_complete(call, ac)
+	 * must be called to synchronously clean up.
 	 */
-	if (call->async) {
-		afs_put_call(call);
-		return -EINPROGRESS;
-	}
-
-	return afs_wait_for_call_to_complete(call, ac);
+	return;
 
 error_do_abort:
 	if (ret != -ECONNABORTED) {
@@ -495,9 +491,7 @@ long afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call,
 
 	ac->error = ret;
 	call->state = AFS_CALL_COMPLETE;
-	afs_put_call(call);
 	_leave(" = %d", ret);
-	return ret;
 }
 
 /*
@@ -600,10 +594,10 @@ static void afs_deliver_to_call(struct afs_call *call)
 }
 
 /*
- * wait synchronously for a call to complete
+ * Wait synchronously for a call to complete and clean up the call struct.
  */
-static long afs_wait_for_call_to_complete(struct afs_call *call,
-					  struct afs_addr_cursor *ac)
+long afs_wait_for_call_to_complete(struct afs_call *call,
+				   struct afs_addr_cursor *ac)
 {
 	signed long rtt2, timeout;
 	long ret;
@@ -615,6 +609,10 @@ static long afs_wait_for_call_to_complete(struct afs_call *call,
 
 	_enter("");
 
+	ret = call->error;
+	if (ret < 0)
+		goto out;
+
 	rtt = rxrpc_kernel_get_rtt(call->net->socket, call->rxcall);
 	rtt2 = nsecs_to_jiffies64(rtt) * 2;
 	if (rtt2 < 2)
@@ -689,6 +687,7 @@ static long afs_wait_for_call_to_complete(struct afs_call *call,
 		break;
 	}
 
+out:
 	_debug("call complete");
 	afs_put_call(call);
 	_leave(" = %p", (void *)ret);
diff --git a/fs/afs/vl_probe.c b/fs/afs/vl_probe.c
index f402ee8171a1..b05e0de04f42 100644
--- a/fs/afs/vl_probe.c
+++ b/fs/afs/vl_probe.c
@@ -141,8 +141,8 @@ static bool afs_do_probe_vlserver(struct afs_net *net,
 	struct afs_addr_cursor ac = {
 		.index = 0,
 	};
+	struct afs_call *call;
 	bool in_progress = false;
-	int err;
 
 	_enter("%s", server->name);
 
@@ -156,12 +156,14 @@ static bool afs_do_probe_vlserver(struct afs_net *net,
 	server->probe.rtt = UINT_MAX;
 
 	for (ac.index = 0; ac.index < ac.alist->nr_addrs; ac.index++) {
-		err = afs_vl_get_capabilities(net, &ac, key, server,
-					      server_index, true);
-		if (err == -EINPROGRESS)
+		call = afs_vl_get_capabilities(net, &ac, key, server,
+					       server_index);
+		if (!IS_ERR(call)) {
+			afs_put_call(call);
 			in_progress = true;
-		else
-			afs_prioritise_error(_e, err, ac.abort_code);
+		} else {
+			afs_prioritise_error(_e, PTR_ERR(call), ac.abort_code);
+		}
 	}
 
 	if (!in_progress)
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index c3d9e5a5f67e..e98ffe6df1c1 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -167,7 +167,8 @@ struct afs_vldb_entry *afs_vl_get_entry_by_name_u(struct afs_vl_cursor *vc,
 		memset((void *)bp + volnamesz, 0, padsz);
 
 	trace_afs_make_vl_call(call);
-	return (struct afs_vldb_entry *)afs_make_call(&vc->ac, call, GFP_KERNEL, false);
+	afs_make_call(&vc->ac, call, GFP_KERNEL);
+	return (struct afs_vldb_entry *)afs_wait_for_call_to_complete(call, &vc->ac);
 }
 
 /*
@@ -304,7 +305,8 @@ struct afs_addr_list *afs_vl_get_addrs_u(struct afs_vl_cursor *vc,
 		r->uuid.node[i] = htonl(u->node[i]);
 
 	trace_afs_make_vl_call(call);
-	return (struct afs_addr_list *)afs_make_call(&vc->ac, call, GFP_KERNEL, false);
+	afs_make_call(&vc->ac, call, GFP_KERNEL);
+	return (struct afs_addr_list *)afs_wait_for_call_to_complete(call, &vc->ac);
 }
 
 /*
@@ -378,12 +380,11 @@ static const struct afs_call_type afs_RXVLGetCapabilities = {
  * We use this to probe for service upgrade to determine what the server at the
  * other end supports.
  */
-int afs_vl_get_capabilities(struct afs_net *net,
-			    struct afs_addr_cursor *ac,
-			    struct key *key,
-			    struct afs_vlserver *server,
-			    unsigned int server_index,
-			    bool async)
+struct afs_call *afs_vl_get_capabilities(struct afs_net *net,
+					 struct afs_addr_cursor *ac,
+					 struct key *key,
+					 struct afs_vlserver *server,
+					 unsigned int server_index)
 {
 	struct afs_call *call;
 	__be32 *bp;
@@ -392,13 +393,14 @@ int afs_vl_get_capabilities(struct afs_net *net,
 
 	call = afs_alloc_flat_call(net, &afs_RXVLGetCapabilities, 1 * 4, 16 * 4);
 	if (!call)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	call->key = key;
 	call->reply[0] = afs_get_vlserver(server);
 	call->reply[1] = (void *)(long)server_index;
 	call->upgrade = true;
 	call->want_reply_time = true;
+	call->async = true;
 
 	/* marshall the parameters */
 	bp = call->request;
@@ -406,7 +408,8 @@ int afs_vl_get_capabilities(struct afs_net *net,
 
 	/* Can't take a ref on server */
 	trace_afs_make_vl_call(call);
-	return afs_make_call(ac, call, GFP_KERNEL, async);
+	afs_make_call(ac, call, GFP_KERNEL);
+	return call;
 }
 
 /*
@@ -647,5 +650,6 @@ struct afs_addr_list *afs_yfsvl_get_endpoints(struct afs_vl_cursor *vc,
 	memcpy(bp, uuid, sizeof(*uuid)); /* Type opr_uuid */
 
 	trace_afs_make_vl_call(call);
-	return (struct afs_addr_list *)afs_make_call(&vc->ac, call, GFP_KERNEL, false);
+	afs_make_call(&vc->ac, call, GFP_KERNEL);
+	return (struct afs_addr_list *)afs_wait_for_call_to_complete(call, &vc->ac);
 }
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 5aa57929e8c2..40b1f19d1018 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -519,7 +519,8 @@ int yfs_fs_fetch_file_status(struct afs_fs_cursor *fc, struct afs_volsync *volsy
 	call->cb_break = fc->cb_break;
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -708,7 +709,8 @@ int yfs_fs_fetch_data(struct afs_fs_cursor *fc, struct afs_read *req)
 	call->cb_break = fc->cb_break;
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -808,7 +810,8 @@ int yfs_fs_create_file(struct afs_fs_cursor *fc,
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 static const struct afs_call_type yfs_RXFSMakeDir = {
@@ -871,7 +874,8 @@ int yfs_fs_make_dir(struct afs_fs_cursor *fc,
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -961,7 +965,8 @@ int yfs_fs_remove_file2(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &dvnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1048,7 +1053,8 @@ int yfs_fs_remove(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &dvnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1133,7 +1139,8 @@ int yfs_fs_link(struct afs_fs_cursor *fc, struct afs_vnode *vnode,
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1229,7 +1236,8 @@ int yfs_fs_symlink(struct afs_fs_cursor *fc,
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &dvnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1327,7 +1335,8 @@ int yfs_fs_rename(struct afs_fs_cursor *fc,
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &orig_dvnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1433,7 +1442,8 @@ int yfs_fs_store_data(struct afs_fs_cursor *fc, struct address_space *mapping,
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1521,7 +1531,8 @@ static int yfs_fs_setattr_size(struct afs_fs_cursor *fc, struct iattr *attr)
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1564,7 +1575,8 @@ int yfs_fs_setattr(struct afs_fs_cursor *fc, struct iattr *attr)
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1751,7 +1763,8 @@ int yfs_fs_get_volume_status(struct afs_fs_cursor *fc,
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1845,7 +1858,8 @@ int yfs_fs_set_lock(struct afs_fs_cursor *fc, afs_lock_type_t type)
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1880,7 +1894,8 @@ int yfs_fs_extend_lock(struct afs_fs_cursor *fc)
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -1915,7 +1930,8 @@ int yfs_fs_release_lock(struct afs_fs_cursor *fc)
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -2003,7 +2019,8 @@ int yfs_fs_fetch_status(struct afs_fs_cursor *fc,
 	call->cb_break = fc->cb_break;
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, fid);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }
 
 /*
@@ -2180,5 +2197,6 @@ int yfs_fs_inline_bulk_status(struct afs_fs_cursor *fc,
 	call->cb_break = fc->cb_break;
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &fids[0]);
-	return afs_make_call(&fc->ac, call, GFP_NOFS, false);
+	afs_make_call(&fc->ac, call, GFP_NOFS);
+	return afs_wait_for_call_to_complete(call, &fc->ac);
 }

