Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43861C04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171B820818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfEOU7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:59:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbfEOU7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:59:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AAF5307CB5E;
        Wed, 15 May 2019 20:59:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5AAA600C4;
        Wed, 15 May 2019 20:59:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/12] afs: Don't save callback version and type fields
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 21:59:04 +0100
Message-ID: <155795394490.28355.6322009407676698775.stgit@warthog.procyon.org.uk>
In-Reply-To: <155795389933.28355.4028912870853910492.stgit@warthog.procyon.org.uk>
References: <155795389933.28355.4028912870853910492.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 15 May 2019 20:59:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't save callback version and type fields as the version is about the
format of the callback information and the type is relative to the
particular RPC call.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/afs.h       |    4 ++--
 fs/afs/fsclient.c  |    4 ++--
 fs/afs/inode.c     |    8 +-------
 fs/afs/internal.h  |    2 --
 fs/afs/super.c     |    1 -
 fs/afs/yfsclient.c |    2 --
 6 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index bcdab0a7fb01..ed9569fccb76 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -69,8 +69,8 @@ typedef enum {
 
 struct afs_callback {
 	time64_t		expires_at;	/* Time at which expires */
-	unsigned		version;	/* Callback version */
-	afs_callback_type_t	type;		/* Type of callback */
+	//unsigned		version;	/* Callback version */
+	//afs_callback_type_t	type;		/* Type of callback */
 };
 
 struct afs_callback_break {
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 24ed4049ff67..86c88babe0fe 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -148,9 +148,9 @@ static void xdr_decode_AFSCallBack(const __be32 **_bp,
 	struct afs_callback *cb = &scb->callback;
 	const __be32 *bp = *_bp;
 
-	cb->version	= ntohl(*bp++);
+	bp++; /* version */
 	cb->expires_at	= xdr_decode_expiry(call, ntohl(*bp++));
-	cb->type	= ntohl(*bp++);
+	bp++; /* type */
 	scb->have_cb	= true;
 	*_bp = bp;
 }
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index f54b6d7ebab8..b644f3d5e4e9 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -136,12 +136,8 @@ static int afs_inode_init_from_status(struct afs_vnode *vnode, struct key *key,
 	if (!scb->have_cb) {
 		/* it's a symlink we just created (the fileserver
 		 * didn't give us a callback) */
-		vnode->cb_version = 0;
-		vnode->cb_type = 0;
 		vnode->cb_expires_at = ktime_get_real_seconds();
 	} else {
-		vnode->cb_version = scb->callback.version;
-		vnode->cb_type = scb->callback.type;
 		vnode->cb_expires_at = scb->callback.expires_at;
 		old_cbi = vnode->cb_interest;
 		if (cbi != old_cbi)
@@ -248,8 +244,6 @@ static void afs_apply_callback(struct afs_fs_cursor *fc,
 	struct afs_callback *cb = &scb->callback;
 
 	if (!afs_cb_is_broken(cb_break, vnode, fc->cbi)) {
-		vnode->cb_version	= cb->version;
-		vnode->cb_type		= cb->type;
 		vnode->cb_expires_at	= cb->expires_at;
 		old = vnode->cb_interest;
 		if (old != fc->cbi) {
@@ -534,7 +528,7 @@ struct inode *afs_iget(struct super_block *sb, struct key *key,
 	clear_bit(AFS_VNODE_UNSET, &vnode->flags);
 	inode->i_flags |= S_NOATIME;
 	unlock_new_inode(inode);
-	_leave(" = %p [CB { v=%u t=%u }]", inode, vnode->cb_version, vnode->cb_type);
+	_leave(" = %p", inode);
 	return inode;
 
 	/* failure */
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index ed2f92f9d705..175501a7cf8b 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -682,8 +682,6 @@ struct afs_vnode {
 	seqlock_t		cb_lock;	/* Lock for ->cb_interest, ->status, ->cb_*break */
 
 	time64_t		cb_expires_at;	/* time at which callback expires */
-	unsigned		cb_version;	/* callback version */
-	afs_callback_type_t	cb_type;	/* type of callback */
 };
 
 static inline struct fscache_cookie *afs_vnode_cache(struct afs_vnode *vnode)
diff --git a/fs/afs/super.c b/fs/afs/super.c
index f45a95eea237..a81c235f8c57 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -683,7 +683,6 @@ static struct inode *afs_alloc_inode(struct super_block *sb)
 #endif
 
 	vnode->flags		= 1 << AFS_VNODE_UNSET;
-	vnode->cb_type		= 0;
 	vnode->lock_state	= AFS_VNODE_LOCK_NONE;
 
 	init_rwsem(&vnode->rmdir_lock);
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 701b6ee4ce10..ffbec5acbd76 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -245,8 +245,6 @@ static void xdr_decode_YFSCallBack(const __be32 **_bp,
 	cb_expiry = call->reply_time;
 	cb_expiry = ktime_add(cb_expiry, xdr_to_u64(x->expiration_time) * 100);
 	cb->expires_at	= ktime_divns(cb_expiry, NSEC_PER_SEC);
-	cb->version	= ntohl(x->version);
-	cb->type	= ntohl(x->type);
 	scb->have_cb	= true;
 	*_bp += xdr_size(x);
 }

