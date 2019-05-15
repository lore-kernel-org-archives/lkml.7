Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D268AC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22692082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfEOU7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:59:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfEOU7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:59:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 035C630001E2;
        Wed, 15 May 2019 20:59:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B4AD1001E61;
        Wed, 15 May 2019 20:59:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/12] afs: Fix unlink to handle YFS.RemoveFile2 better
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 21:59:34 +0100
Message-ID: <155795397444.28355.990810609110357836.stgit@warthog.procyon.org.uk>
In-Reply-To: <155795389933.28355.4028912870853910492.stgit@warthog.procyon.org.uk>
References: <155795389933.28355.4028912870853910492.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 15 May 2019 20:59:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the status update for the target file that the YFS.RemoveFile2
RPC op returns to correctly update the vnode as to whether the file was
actually deleted or just had nlink reduced.

Fixes: 30062bd13e36 ("afs: Implement YFS support in the fs client")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/afs.h       |    2 ++
 fs/afs/dir.c       |   36 +++++++++++++-----------------------
 fs/afs/fsclient.c  |    2 ++
 fs/afs/inode.c     |   18 ++++++++++++++----
 fs/afs/internal.h  |    1 -
 fs/afs/yfsclient.c |    2 ++
 6 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index ed9569fccb76..4d41c8966c59 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -147,7 +147,9 @@ struct afs_file_status {
 struct afs_status_cb {
 	struct afs_file_status	status;
 	struct afs_callback	callback;
+	bool			have_status;	/* True if status record was retrieved */
 	bool			have_cb;	/* True if cb record was retrieved */
+	bool			have_error;	/* True if status.abort_code indicates an error */
 };
 
 /*
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 338c2260b0a0..d1b3736a3bbd 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1299,32 +1299,27 @@ static int afs_rmdir(struct inode *dir, struct dentry *dentry)
  * However, if we didn't have a callback promise outstanding, or it was
  * outstanding on a different server, then it won't break it either...
  */
-int afs_dir_remove_link(struct dentry *dentry, struct key *key,
-			unsigned long d_version_before,
-			unsigned long d_version_after)
+static int afs_dir_remove_link(struct afs_vnode *dvnode, struct dentry *dentry,
+			       struct key *key)
 {
-	bool dir_valid;
 	int ret = 0;
 
-	/* There were no intervening changes on the server if the version
-	 * number we got back was incremented by exactly 1.
-	 */
-	dir_valid = (d_version_after == d_version_before + 1);
-
 	if (d_really_is_positive(dentry)) {
 		struct afs_vnode *vnode = AFS_FS_I(d_inode(dentry));
 
 		if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
 			/* Already done */
-		} else if (dir_valid) {
+		} else if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags)) {
+			write_seqlock(&vnode->cb_lock);
 			drop_nlink(&vnode->vfs_inode);
 			if (vnode->vfs_inode.i_nlink == 0) {
 				set_bit(AFS_VNODE_DELETED, &vnode->flags);
-				clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
+				__afs_break_callback(vnode);
 			}
+			write_sequnlock(&vnode->cb_lock);
 			ret = 0;
 		} else {
-			clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
+			afs_break_callback(vnode);
 
 			if (test_bit(AFS_VNODE_DELETED, &vnode->flags))
 				kdebug("AFS_VNODE_DELETED");
@@ -1348,7 +1343,6 @@ static int afs_unlink(struct inode *dir, struct dentry *dentry)
 	struct afs_status_cb *scb;
 	struct afs_vnode *dvnode = AFS_FS_I(dir), *vnode = NULL;
 	struct key *key;
-	unsigned long d_version = (unsigned long)dentry->d_fsdata;
 	bool need_rehash = false;
 	int ret;
 
@@ -1395,20 +1389,16 @@ static int afs_unlink(struct inode *dir, struct dentry *dentry)
 	ret = -ERESTARTSYS;
 	if (afs_begin_vnode_operation(&fc, dvnode, key, true)) {
 		afs_dataversion_t data_version = dvnode->status.data_version + 1;
+		afs_dataversion_t data_version_2 = vnode->status.data_version;
 
 		while (afs_select_fileserver(&fc)) {
 			fc.cb_break = afs_calc_vnode_cb_break(dvnode);
+			fc.cb_break_2 = afs_calc_vnode_cb_break(vnode);
 
 			if (test_bit(AFS_SERVER_FL_IS_YFS, &fc.cbi->server->flags) &&
 			    !test_bit(AFS_SERVER_FL_NO_RM2, &fc.cbi->server->flags)) {
 				yfs_fs_remove_file2(&fc, vnode, dentry->d_name.name,
 						    &scb[0], &scb[1]);
-				if (fc.ac.error == 0 &&
-				    scb[1].status.abort_code == VNOVNODE) {
-					set_bit(AFS_VNODE_DELETED, &vnode->flags);
-					afs_break_callback(vnode);
-				}
-
 				if (fc.ac.error != -ECONNABORTED ||
 				    fc.ac.abort_code != RXGEN_OPCODE)
 					continue;
@@ -1420,11 +1410,11 @@ static int afs_unlink(struct inode *dir, struct dentry *dentry)
 
 		afs_vnode_commit_status(&fc, dvnode, fc.cb_break,
 					&data_version, &scb[0]);
+		afs_vnode_commit_status(&fc, vnode, fc.cb_break_2,
+					&data_version_2, &scb[1]);
 		ret = afs_end_vnode_operation(&fc);
-		if (ret == 0)
-			ret = afs_dir_remove_link(
-				dentry, key, d_version,
-				(unsigned long)dvnode->status.data_version);
+		if (ret == 0 && !(scb[1].have_status || scb[1].have_error))
+			ret = afs_dir_remove_link(dvnode, dentry, key);
 		if (ret == 0 &&
 		    test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
 			afs_edit_dir_remove(dvnode, &dentry->d_name,
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 86c88babe0fe..3d9af8de7059 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -83,6 +83,7 @@ static int xdr_decode_AFSFetchStatus(const __be32 **_bp,
 			 * case.
 			 */
 			status->abort_code = abort_code;
+			scb->have_error = true;
 			return 0;
 		}
 
@@ -127,6 +128,7 @@ static int xdr_decode_AFSFetchStatus(const __be32 **_bp,
 	data_version  = (u64)ntohl(xdr->data_version_lo);
 	data_version |= (u64)ntohl(xdr->data_version_hi) << 32;
 	status->data_version = data_version;
+	scb->have_status = true;
 
 	*_bp = (const void *)*_bp + sizeof(*xdr);
 	return 0;
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 866d3575c5de..031fe9cb5ccb 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -23,6 +23,7 @@
 #include <linux/namei.h>
 #include <linux/iversion.h>
 #include "internal.h"
+#include "afs_fs.h"
 
 static const struct inode_operations afs_symlink_inode_operations = {
 	.get_link	= page_get_link,
@@ -271,13 +272,22 @@ void afs_vnode_commit_status(struct afs_fs_cursor *fc,
 
 	write_seqlock(&vnode->cb_lock);
 
-	afs_apply_status(fc, vnode, scb, expected_version);
-	if (scb->have_cb)
-		afs_apply_callback(fc, vnode, scb, cb_break);
+	if (scb->have_error) {
+		if (scb->status.abort_code == VNOVNODE) {
+			set_bit(AFS_VNODE_DELETED, &vnode->flags);
+			clear_nlink(&vnode->vfs_inode);
+			__afs_break_callback(vnode);
+		}
+	} else {
+		if (scb->have_status)
+			afs_apply_status(fc, vnode, scb, expected_version);
+		if (scb->have_cb)
+			afs_apply_callback(fc, vnode, scb, cb_break);
+	}
 
 	write_sequnlock(&vnode->cb_lock);
 
-	if (fc->ac.error == 0)
+	if (fc->ac.error == 0 && scb->have_status)
 		afs_cache_permit(vnode, fc->key, cb_break, scb);
 }
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 0a5a3a77ed9d..1ce3dd9f81e3 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -903,7 +903,6 @@ extern const struct address_space_operations afs_dir_aops;
 extern const struct dentry_operations afs_fs_dentry_operations;
 
 extern void afs_d_release(struct dentry *);
-extern int afs_dir_remove_link(struct dentry *, struct key *, unsigned long, unsigned long);
 
 /*
  * dir_edit.c
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index ffbec5acbd76..184d901e34b4 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -195,6 +195,7 @@ static int xdr_decode_YFSFetchStatus(const __be32 **_bp,
 	if (status->abort_code != 0) {
 		if (status->abort_code == VNOVNODE)
 			status->nlink = 0;
+		scb->have_error = true;
 		return 0;
 	}
 
@@ -222,6 +223,7 @@ static int xdr_decode_YFSFetchStatus(const __be32 **_bp,
 	status->mtime_server	= xdr_to_time(xdr->mtime_server);
 	status->size		= xdr_to_u64(xdr->size);
 	status->data_version	= xdr_to_u64(xdr->data_version);
+	scb->have_status	= true;
 
 	*_bp += xdr_size(xdr);
 	return 0;

