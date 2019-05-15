Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440F3C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0914220873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfEOU6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:58:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfEOU6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:58:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B872B8110A;
        Wed, 15 May 2019 20:58:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9B9B5D728;
        Wed, 15 May 2019 20:58:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/12] afs: Fix order-1 allocation in afs_do_lookup()
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 21:58:42 +0100
Message-ID: <155795392210.28355.2523574584163298314.stgit@warthog.procyon.org.uk>
In-Reply-To: <155795389933.28355.4028912870853910492.stgit@warthog.procyon.org.uk>
References: <155795389933.28355.4028912870853910492.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 15 May 2019 20:58:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

afs_do_lookup() will do an order-1 allocation to allocate status records if
there are more than 39 vnodes to stat.

Fix this by allocating an array of {status,callback} records for each vnode
we want to examine using vmalloc() if larger than a page.

This not only gets rid of the order-1 allocation, but makes it easier to
grow beyond 50 records for YFS servers.  It also allows us to move to
{status,callback} tuples for other calls too and makes it easier to lock
across the application of the status and the callback to the vnode.

Fixes: 5cf9dd55a0ec ("afs: Prospectively look up extra files when doing a single lookup")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/afs.h       |    6 ++++++
 fs/afs/dir.c       |   37 ++++++++++++++++---------------------
 fs/afs/fsclient.c  |   21 +++++++++------------
 fs/afs/internal.h  |   11 +++++------
 fs/afs/yfsclient.c |   20 +++++++++-----------
 5 files changed, 45 insertions(+), 50 deletions(-)

diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index d12ffb457e47..bcdab0a7fb01 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -144,6 +144,12 @@ struct afs_file_status {
 	u32			abort_code;	/* Abort if bulk-fetching this failed */
 };
 
+struct afs_status_cb {
+	struct afs_file_status	status;
+	struct afs_callback	callback;
+	bool			have_cb;	/* True if cb record was retrieved */
+};
+
 /*
  * AFS file status change request
  */
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index c15550310f62..0f14bcfe233d 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -102,8 +102,7 @@ struct afs_lookup_cookie {
 	bool			found;
 	bool			one_only;
 	unsigned short		nr_fids;
-	struct afs_file_status	*statuses;
-	struct afs_callback	*callbacks;
+	struct afs_status_cb	*statuses;
 	struct afs_fid		fids[50];
 };
 
@@ -640,6 +639,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 	struct afs_lookup_cookie *cookie;
 	struct afs_cb_interest *cbi = NULL;
 	struct afs_super_info *as = dir->i_sb->s_fs_info;
+	struct afs_status_cb *scb;
 	struct afs_iget_data data;
 	struct afs_fs_cursor fc;
 	struct afs_vnode *dvnode = AFS_FS_I(dir);
@@ -686,16 +686,11 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 
 	/* Need space for examining all the selected files */
 	inode = ERR_PTR(-ENOMEM);
-	cookie->statuses = kcalloc(cookie->nr_fids, sizeof(struct afs_file_status),
-				   GFP_KERNEL);
+	cookie->statuses = kvcalloc(cookie->nr_fids, sizeof(struct afs_status_cb),
+				    GFP_KERNEL);
 	if (!cookie->statuses)
 		goto out;
 
-	cookie->callbacks = kcalloc(cookie->nr_fids, sizeof(struct afs_callback),
-				    GFP_KERNEL);
-	if (!cookie->callbacks)
-		goto out_s;
-
 	/* Try FS.InlineBulkStatus first.  Abort codes for the individual
 	 * lookups contained therein are stored in the reply without aborting
 	 * the whole operation.
@@ -716,7 +711,6 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 						  afs_v2net(dvnode),
 						  cookie->fids,
 						  cookie->statuses,
-						  cookie->callbacks,
 						  cookie->nr_fids, NULL);
 		}
 
@@ -741,11 +735,12 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 	inode = ERR_PTR(-ERESTARTSYS);
 	if (afs_begin_vnode_operation(&fc, dvnode, key, true)) {
 		while (afs_select_fileserver(&fc)) {
+			scb = &cookie->statuses[0];
 			afs_fs_fetch_status(&fc,
 					    afs_v2net(dvnode),
 					    cookie->fids,
-					    cookie->statuses,
-					    cookie->callbacks,
+					    &scb->status,
+					    &scb->callback,
 					    NULL);
 		}
 
@@ -758,24 +753,26 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 		goto out_c;
 
 	for (i = 0; i < cookie->nr_fids; i++)
-		cookie->statuses[i].abort_code = 0;
+		cookie->statuses[i].status.abort_code = 0;
 
 success:
 	/* Turn all the files into inodes and save the first one - which is the
 	 * one we actually want.
 	 */
-	if (cookie->statuses[0].abort_code != 0)
-		inode = ERR_PTR(afs_abort_to_error(cookie->statuses[0].abort_code));
+	scb = &cookie->statuses[0];
+	if (scb->status.abort_code != 0)
+		inode = ERR_PTR(afs_abort_to_error(scb->status.abort_code));
 
 	for (i = 0; i < cookie->nr_fids; i++) {
+		struct afs_status_cb *scb = &cookie->statuses[i];
 		struct inode *ti;
 
-		if (cookie->statuses[i].abort_code != 0)
+		if (scb->status.abort_code != 0)
 			continue;
 
 		ti = afs_iget(dir->i_sb, key, &cookie->fids[i],
-			      &cookie->statuses[i],
-			      &cookie->callbacks[i],
+			      &scb->status,
+			      &scb->callback,
 			      cbi, dvnode);
 		if (i == 0) {
 			inode = ti;
@@ -787,9 +784,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 
 out_c:
 	afs_put_cb_interest(afs_v2net(dvnode), cbi);
-	kfree(cookie->callbacks);
-out_s:
-	kfree(cookie->statuses);
+	kvfree(cookie->statuses);
 out:
 	kfree(cookie);
 	return inode;
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index d1ea674a5c2a..f211cc53c1f0 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -2208,8 +2208,7 @@ int afs_fs_fetch_status(struct afs_fs_cursor *fc,
  */
 static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 {
-	struct afs_file_status *statuses;
-	struct afs_callback *callbacks;
+	struct afs_status_cb *scb;
 	const __be32 *bp;
 	u32 tmp;
 	int ret;
@@ -2248,8 +2247,8 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 			return ret;
 
 		bp = call->buffer;
-		statuses = call->out_extra_status;
-		ret = afs_decode_status(call, &bp, &statuses[call->count],
+		scb = &call->out_scb[call->count];
+		ret = afs_decode_status(call, &bp, &scb->status,
 					NULL, NULL, NULL);
 		if (ret < 0)
 			return ret;
@@ -2289,9 +2288,9 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 
 		_debug("unmarshall CB array");
 		bp = call->buffer;
-		callbacks = call->out_cb;
-		xdr_decode_AFSCallBack_raw(call, &callbacks[call->count], &bp);
-		statuses = call->out_extra_status;
+		scb = &call->out_scb[call->count];
+		xdr_decode_AFSCallBack_raw(call, &scb->callback, &bp);
+		scb->have_cb = true;
 		call->count++;
 		if (call->count < call->count2)
 			goto more_cbs;
@@ -2334,8 +2333,7 @@ static const struct afs_call_type afs_RXFSInlineBulkStatus = {
 int afs_fs_inline_bulk_status(struct afs_fs_cursor *fc,
 			      struct afs_net *net,
 			      struct afs_fid *fids,
-			      struct afs_file_status *statuses,
-			      struct afs_callback *callbacks,
+			      struct afs_status_cb *statuses,
 			      unsigned int nr_fids,
 			      struct afs_volsync *volsync)
 {
@@ -2344,7 +2342,7 @@ int afs_fs_inline_bulk_status(struct afs_fs_cursor *fc,
 	int i;
 
 	if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags))
-		return yfs_fs_inline_bulk_status(fc, net, fids, statuses, callbacks,
+		return yfs_fs_inline_bulk_status(fc, net, fids, statuses,
 						 nr_fids, volsync);
 
 	_enter(",%x,{%llx:%llu},%u",
@@ -2359,8 +2357,7 @@ int afs_fs_inline_bulk_status(struct afs_fs_cursor *fc,
 	}
 
 	call->key = fc->key;
-	call->out_extra_status = statuses;
-	call->out_cb = callbacks;
+	call->out_scb = statuses;
 	call->out_volsync = volsync;
 	call->count2 = nr_fids;
 	call->want_reply_time = true;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index e5ee6017e01c..18d7eaf34f31 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -137,6 +137,7 @@ struct afs_call {
 	struct afs_file_status	*out_vnode_status;
 	struct afs_file_status	*out_extra_status;
 	struct afs_callback	*out_cb;
+	struct afs_status_cb	*out_scb;
 	struct yfs_acl		*out_yacl;
 	struct afs_volsync	*out_volsync;
 	struct afs_volume_status *out_volstatus;
@@ -990,9 +991,8 @@ extern struct afs_call *afs_fs_get_capabilities(struct afs_net *, struct afs_ser
 						struct afs_addr_cursor *, struct key *,
 						unsigned int);
 extern int afs_fs_inline_bulk_status(struct afs_fs_cursor *, struct afs_net *,
-				     struct afs_fid *, struct afs_file_status *,
-				     struct afs_callback *, unsigned int,
-				     struct afs_volsync *);
+				     struct afs_fid *, struct afs_status_cb *,
+				     unsigned int, struct afs_volsync *);
 extern int afs_fs_fetch_status(struct afs_fs_cursor *, struct afs_net *,
 			       struct afs_fid *, struct afs_file_status *,
 			       struct afs_callback *, struct afs_volsync *);
@@ -1392,9 +1392,8 @@ extern int yfs_fs_fetch_status(struct afs_fs_cursor *, struct afs_net *,
 			       struct afs_fid *, struct afs_file_status *,
 			       struct afs_callback *, struct afs_volsync *);
 extern int yfs_fs_inline_bulk_status(struct afs_fs_cursor *, struct afs_net *,
-				     struct afs_fid *, struct afs_file_status *,
-				     struct afs_callback *, unsigned int,
-				     struct afs_volsync *);
+				     struct afs_fid *, struct afs_status_cb *,
+				     unsigned int, struct afs_volsync *);
 
 struct yfs_acl {
 	struct afs_acl	*acl;		/* Dir/file/symlink ACL */
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index a815d22f62f1..1f1ccf7b7822 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -338,7 +338,7 @@ static void xdr_decode_YFSCallBack(struct afs_call *call,
 	struct afs_callback cb;
 
 	xdr_decode_YFSCallBack_raw(call, &cb, _bp);
-
+	
 	write_seqlock(&vnode->cb_lock);
 
 	if (!afs_cb_is_broken(call->cb_break, vnode, cbi)) {
@@ -2032,8 +2032,7 @@ int yfs_fs_fetch_status(struct afs_fs_cursor *fc,
  */
 static int yfs_deliver_fs_inline_bulk_status(struct afs_call *call)
 {
-	struct afs_file_status *statuses;
-	struct afs_callback *callbacks;
+	struct afs_status_cb *scb;
 	const __be32 *bp;
 	u32 tmp;
 	int ret;
@@ -2072,8 +2071,8 @@ static int yfs_deliver_fs_inline_bulk_status(struct afs_call *call)
 			return ret;
 
 		bp = call->buffer;
-		statuses = call->out_extra_status;
-		ret = yfs_decode_status(call, &bp, &statuses[call->count],
+		scb = &call->out_scb[call->count];
+		ret = yfs_decode_status(call, &bp, &scb->status,
 					NULL, NULL, NULL);
 		if (ret < 0)
 			return ret;
@@ -2113,8 +2112,9 @@ static int yfs_deliver_fs_inline_bulk_status(struct afs_call *call)
 
 		_debug("unmarshall CB array");
 		bp = call->buffer;
-		callbacks = call->out_cb;
-		xdr_decode_YFSCallBack_raw(call, &callbacks[call->count], &bp);
+		scb = &call->out_scb[call->count];
+		xdr_decode_YFSCallBack_raw(call, &scb->callback, &bp);
+		scb->have_cb = true;
 		call->count++;
 		if (call->count < call->count2)
 			goto more_cbs;
@@ -2158,8 +2158,7 @@ static const struct afs_call_type yfs_RXYFSInlineBulkStatus = {
 int yfs_fs_inline_bulk_status(struct afs_fs_cursor *fc,
 			      struct afs_net *net,
 			      struct afs_fid *fids,
-			      struct afs_file_status *statuses,
-			      struct afs_callback *callbacks,
+			      struct afs_status_cb *statuses,
 			      unsigned int nr_fids,
 			      struct afs_volsync *volsync)
 {
@@ -2182,8 +2181,7 @@ int yfs_fs_inline_bulk_status(struct afs_fs_cursor *fc,
 	}
 
 	call->key = fc->key;
-	call->out_extra_status = statuses;
-	call->out_cb = callbacks;
+	call->out_scb = statuses;
 	call->out_volsync = volsync;
 	call->count2 = nr_fids;
 

