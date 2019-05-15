Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EC7C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C7E217D8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfEOQ1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:27:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbfEOQ1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:27:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E0E2316D8E9;
        Wed, 15 May 2019 16:27:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7D9960F91;
        Wed, 15 May 2019 16:27:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/15] afs: Fix calculation of callback expiry time
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 17:27:04 +0100
Message-ID: <155793762485.31671.9601704687231766116.stgit@warthog.procyon.org.uk>
In-Reply-To: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
References: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 15 May 2019 16:27:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the calculation of the expiry time of a callback promise, as obtained
from operations like FS.FetchStatus and FS.FetchData.

The time should be based on the timestamp of the first DATA packet in the
reply and the calculation needs to turn the ktime_t timestamp into a
time64_t.

Fixes: c435ee34551e ("afs: Overhaul the callback handling")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/fsclient.c  |   57 ++++++++++++++++++++++++----------------------------
 fs/afs/yfsclient.c |   51 +++++++++++++++++++++++------------------------
 2 files changed, 51 insertions(+), 57 deletions(-)

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index c43301b5eea4..721ff8d04401 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -256,6 +256,23 @@ static int afs_decode_status(struct afs_call *call,
 	return ret;
 }
 
+static time64_t xdr_decode_expiry(struct afs_call *call, u32 expiry)
+{
+	return ktime_divns(call->reply_time, NSEC_PER_SEC) + expiry;
+}
+
+static void xdr_decode_AFSCallBack_raw(struct afs_call *call,
+				       struct afs_callback *cb,
+				       const __be32 **_bp)
+{
+	const __be32 *bp = *_bp;
+
+	cb->version	= ntohl(*bp++);
+	cb->expires_at	= xdr_decode_expiry(call, ntohl(*bp++));
+	cb->type	= ntohl(*bp++);
+	*_bp = bp;
+}
+
 /*
  * decode an AFSCallBack block
  */
@@ -264,46 +281,26 @@ static void xdr_decode_AFSCallBack(struct afs_call *call,
 				   const __be32 **_bp)
 {
 	struct afs_cb_interest *old, *cbi = call->cbi;
-	const __be32 *bp = *_bp;
-	u32 cb_expiry;
+	struct afs_callback cb;
+
+	xdr_decode_AFSCallBack_raw(call, &cb, _bp);
 
 	write_seqlock(&vnode->cb_lock);
 
 	if (!afs_cb_is_broken(call->cb_break, vnode, cbi)) {
-		vnode->cb_version	= ntohl(*bp++);
-		cb_expiry		= ntohl(*bp++);
-		vnode->cb_type		= ntohl(*bp++);
-		vnode->cb_expires_at	= cb_expiry + ktime_get_real_seconds();
+		vnode->cb_version	= cb.version;
+		vnode->cb_type		= cb.type;
+		vnode->cb_expires_at	= cb.expires_at;
 		old = vnode->cb_interest;
 		if (old != call->cbi) {
 			vnode->cb_interest = cbi;
 			cbi = old;
 		}
 		set_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
-	} else {
-		bp += 3;
 	}
 
 	write_sequnlock(&vnode->cb_lock);
 	call->cbi = cbi;
-	*_bp = bp;
-}
-
-static ktime_t xdr_decode_expiry(struct afs_call *call, u32 expiry)
-{
-	return ktime_add_ns(call->reply_time, expiry * NSEC_PER_SEC);
-}
-
-static void xdr_decode_AFSCallBack_raw(struct afs_call *call,
-				       const __be32 **_bp,
-				       struct afs_callback *cb)
-{
-	const __be32 *bp = *_bp;
-
-	cb->version	= ntohl(*bp++);
-	cb->expires_at	= xdr_decode_expiry(call, ntohl(*bp++));
-	cb->type	= ntohl(*bp++);
-	*_bp = bp;
 }
 
 /*
@@ -744,7 +741,7 @@ static int afs_deliver_fs_create_vnode(struct afs_call *call)
 				&call->expected_version, NULL);
 	if (ret < 0)
 		return ret;
-	xdr_decode_AFSCallBack_raw(call, &bp, call->reply[3]);
+	xdr_decode_AFSCallBack_raw(call, call->reply[3], &bp);
 	/* xdr_decode_AFSVolSync(&bp, call->reply[X]); */
 
 	_leave(" = 0 [done]");
@@ -2167,7 +2164,7 @@ static int afs_deliver_fs_fetch_status(struct afs_call *call)
 				&call->expected_version, NULL);
 	if (ret < 0)
 		return ret;
-	xdr_decode_AFSCallBack_raw(call, &bp, callback);
+	xdr_decode_AFSCallBack_raw(call, callback, &bp);
 	xdr_decode_AFSVolSync(&bp, volsync);
 
 	_leave(" = 0 [done]");
@@ -2321,9 +2318,7 @@ static int afs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		_debug("unmarshall CB array");
 		bp = call->buffer;
 		callbacks = call->reply[2];
-		callbacks[call->count].version	= ntohl(bp[0]);
-		callbacks[call->count].expires_at = xdr_decode_expiry(call, ntohl(bp[1]));
-		callbacks[call->count].type	= ntohl(bp[2]);
+		xdr_decode_AFSCallBack_raw(call, &callbacks[call->count], &bp);
 		statuses = call->reply[1];
 		if (call->count == 0 && vnode && statuses[0].abort_code == 0)
 			xdr_decode_AFSCallBack(call, vnode, &bp);
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 3ba33d415a74..b42bd412dba1 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -311,6 +311,22 @@ static int yfs_decode_status(struct afs_call *call,
 	return ret;
 }
 
+static void xdr_decode_YFSCallBack_raw(struct afs_call *call,
+				       struct afs_callback *cb,
+				       const __be32 **_bp)
+{
+	struct yfs_xdr_YFSCallBack *x = (void *)*_bp;
+	ktime_t cb_expiry;
+
+	cb_expiry = call->reply_time;
+	cb_expiry = ktime_add(cb_expiry, xdr_to_u64(x->expiration_time) * 100);
+	cb->expires_at	= ktime_divns(cb_expiry, NSEC_PER_SEC);
+	cb->version	= ntohl(x->version);
+	cb->type	= ntohl(x->type);
+
+	*_bp += xdr_size(x);
+}
+
 /*
  * Decode a YFSCallBack block
  */
@@ -318,18 +334,17 @@ static void xdr_decode_YFSCallBack(struct afs_call *call,
 				   struct afs_vnode *vnode,
 				   const __be32 **_bp)
 {
-	struct yfs_xdr_YFSCallBack *xdr = (void *)*_bp;
 	struct afs_cb_interest *old, *cbi = call->cbi;
-	u64 cb_expiry;
+	struct afs_callback cb;
+
+	xdr_decode_YFSCallBack_raw(call, &cb, _bp);
 
 	write_seqlock(&vnode->cb_lock);
 
 	if (!afs_cb_is_broken(call->cb_break, vnode, cbi)) {
-		cb_expiry = xdr_to_u64(xdr->expiration_time);
-		do_div(cb_expiry, 10 * 1000 * 1000);
-		vnode->cb_version	= ntohl(xdr->version);
-		vnode->cb_type		= ntohl(xdr->type);
-		vnode->cb_expires_at	= cb_expiry + ktime_get_real_seconds();
+		vnode->cb_version	= cb.version;
+		vnode->cb_type		= cb.type;
+		vnode->cb_expires_at	= cb.expires_at;
 		old = vnode->cb_interest;
 		if (old != call->cbi) {
 			vnode->cb_interest = cbi;
@@ -340,22 +355,6 @@ static void xdr_decode_YFSCallBack(struct afs_call *call,
 
 	write_sequnlock(&vnode->cb_lock);
 	call->cbi = cbi;
-	*_bp += xdr_size(xdr);
-}
-
-static void xdr_decode_YFSCallBack_raw(const __be32 **_bp,
-				       struct afs_callback *cb)
-{
-	struct yfs_xdr_YFSCallBack *x = (void *)*_bp;
-	u64 cb_expiry;
-
-	cb_expiry = xdr_to_u64(x->expiration_time);
-	do_div(cb_expiry, 10 * 1000 * 1000);
-	cb->version	= ntohl(x->version);
-	cb->type	= ntohl(x->type);
-	cb->expires_at	= cb_expiry + ktime_get_real_seconds();
-
-	*_bp += xdr_size(x);
 }
 
 /*
@@ -743,7 +742,7 @@ static int yfs_deliver_fs_create_vnode(struct afs_call *call)
 				&call->expected_version, NULL);
 	if (ret < 0)
 		return ret;
-	xdr_decode_YFSCallBack_raw(&bp, call->reply[3]);
+	xdr_decode_YFSCallBack_raw(call, call->reply[3], &bp);
 	xdr_decode_YFSVolSync(&bp, NULL);
 
 	_leave(" = 0 [done]");
@@ -1983,7 +1982,7 @@ static int yfs_deliver_fs_fetch_status(struct afs_call *call)
 				&call->expected_version, NULL);
 	if (ret < 0)
 		return ret;
-	xdr_decode_YFSCallBack_raw(&bp, callback);
+	xdr_decode_YFSCallBack_raw(call, callback, &bp);
 	xdr_decode_YFSVolSync(&bp, volsync);
 
 	_leave(" = 0 [done]");
@@ -2138,7 +2137,7 @@ static int yfs_deliver_fs_inline_bulk_status(struct afs_call *call)
 		_debug("unmarshall CB array");
 		bp = call->buffer;
 		callbacks = call->reply[2];
-		xdr_decode_YFSCallBack_raw(&bp, &callbacks[call->count]);
+		xdr_decode_YFSCallBack_raw(call, &callbacks[call->count], &bp);
 		statuses = call->reply[1];
 		if (call->count == 0 && vnode && statuses[0].abort_code == 0) {
 			bp = call->buffer;

