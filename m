Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549D4C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F102082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfEOU7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:59:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfEOU7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:59:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 019FC3E2B7;
        Wed, 15 May 2019 20:59:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E89860928;
        Wed, 15 May 2019 20:59:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/12] afs: Fix application of the results of a inline bulk
 status fetch
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 21:59:49 +0100
Message-ID: <155795398929.28355.11912045949014606560.stgit@warthog.procyon.org.uk>
In-Reply-To: <155795389933.28355.4028912870853910492.stgit@warthog.procyon.org.uk>
References: <155795389933.28355.4028912870853910492.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 15 May 2019 20:59:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix afs_do_lookup() such that when it does an inline bulk status fetch op,
it will update inodes that are already extant (something that afs_iget()
doesn't do) and to cache permits for each inode created (thereby avoiding a
follow up FS.FetchStatus call to determine this).

Extant inodes need looking up in advance so that their cb_break counters
before and after the operation can be compared.  To this end, the inode
pointers are cached so that they don't need looking up again after the op.

Fixes: 5cf9dd55a0ec ("afs: Prospectively look up extra files when doing a single lookup")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/afs.h |    1 +
 fs/afs/dir.c |   51 ++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/fs/afs/afs.h b/fs/afs/afs.h
index 4d41c8966c59..27911a57db4f 100644
--- a/fs/afs/afs.h
+++ b/fs/afs/afs.h
@@ -147,6 +147,7 @@ struct afs_file_status {
 struct afs_status_cb {
 	struct afs_file_status	status;
 	struct afs_callback	callback;
+	unsigned int		cb_break;	/* Pre-op callback break counter */
 	bool			have_status;	/* True if status record was retrieved */
 	bool			have_cb;	/* True if cb record was retrieved */
 	bool			have_error;	/* True if status.abort_code indicates an error */
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 9e42f6c75747..79d93a26759a 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -103,6 +103,7 @@ struct afs_lookup_cookie {
 	bool			found;
 	bool			one_only;
 	unsigned short		nr_fids;
+	struct inode		**inodes;
 	struct afs_status_cb	*statuses;
 	struct afs_fid		fids[50];
 };
@@ -644,8 +645,8 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 	struct afs_iget_data iget_data;
 	struct afs_fs_cursor fc;
 	struct afs_server *server;
-	struct afs_vnode *dvnode = AFS_FS_I(dir);
-	struct inode *inode = NULL;
+	struct afs_vnode *dvnode = AFS_FS_I(dir), *vnode;
+	struct inode *inode = NULL, *ti;
 	int ret, i;
 
 	_enter("{%lu},%p{%pd},", dir->i_ino, dentry, dentry);
@@ -700,6 +701,27 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 	if (!cookie->statuses)
 		goto out;
 
+	cookie->inodes = kcalloc(cookie->nr_fids, sizeof(struct inode *),
+				 GFP_KERNEL);
+	if (!cookie->inodes)
+		goto out_s;
+
+	for (i = 1; i < cookie->nr_fids; i++) {
+		scb = &cookie->statuses[i];
+
+		/* Find any inodes that already exist and get their
+		 * callback counters.
+		 */
+		iget_data.fid = cookie->fids[i];
+		ti = ilookup5_nowait(dir->i_sb, iget_data.fid.vnode,
+				     afs_iget5_test, &iget_data);
+		if (!IS_ERR_OR_NULL(ti)) {
+			vnode = AFS_FS_I(ti);
+			scb->cb_break = afs_calc_vnode_cb_break(vnode);
+			cookie->inodes[i] = ti;
+		}
+	}
+
 	/* Try FS.InlineBulkStatus first.  Abort codes for the individual
 	 * lookups contained therein are stored in the reply without aborting
 	 * the whole operation.
@@ -742,7 +764,6 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 	 * any of the lookups fails - so, for the moment, revert to
 	 * FS.FetchStatus for just the primary fid.
 	 */
-	cookie->nr_fids = 1;
 	inode = ERR_PTR(-ERESTARTSYS);
 	if (afs_begin_vnode_operation(&fc, dvnode, key, true)) {
 		while (afs_select_fileserver(&fc)) {
@@ -764,9 +785,6 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 	if (IS_ERR(inode))
 		goto out_c;
 
-	for (i = 0; i < cookie->nr_fids; i++)
-		cookie->statuses[i].status.abort_code = 0;
-
 success:
 	/* Turn all the files into inodes and save the first one - which is the
 	 * one we actually want.
@@ -777,13 +795,26 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 
 	for (i = 0; i < cookie->nr_fids; i++) {
 		struct afs_status_cb *scb = &cookie->statuses[i];
-		struct inode *ti;
+
+		if (!scb->have_status && !scb->have_error)
+			continue;
+
+		if (cookie->inodes[i]) {
+			afs_vnode_commit_status(&fc, AFS_FS_I(cookie->inodes[i]),
+						scb->cb_break, NULL, scb);
+			continue;
+		}
 
 		if (scb->status.abort_code != 0)
 			continue;
 
 		iget_data.fid = cookie->fids[i];
 		ti = afs_iget(dir->i_sb, key, &iget_data, scb, cbi, dvnode);
+		if (!IS_ERR(ti))
+			afs_cache_permit(AFS_FS_I(ti), key,
+					 0 /* Assume vnode->cb_break is 0 */ +
+					 iget_data.cb_v_break,
+					 scb);
 		if (i == 0) {
 			inode = ti;
 		} else {
@@ -794,6 +825,12 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry,
 
 out_c:
 	afs_put_cb_interest(afs_v2net(dvnode), cbi);
+	if (cookie->inodes) {
+		for (i = 0; i < cookie->nr_fids; i++)
+			iput(cookie->inodes[i]);
+		kfree(cookie->inodes);
+	}
+out_s:
 	kvfree(cookie->statuses);
 out:
 	kfree(cookie);

