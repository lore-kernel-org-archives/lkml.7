Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA03C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE13218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfCOXIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:08:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfCOXIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:08:07 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 847CA8666B;
        Fri, 15 Mar 2019 23:00:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59EEC19C57;
        Fri, 15 Mar 2019 23:00:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/10] afs: Implement sillyrename for unlink and rename
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 15 Mar 2019 23:00:28 +0000
Message-ID: <155269082860.8537.16395531981499448108.stgit@warthog.procyon.org.uk>
In-Reply-To: <155269076033.8537.10785090349210421514.stgit@warthog.procyon.org.uk>
References: <155269076033.8537.10785090349210421514.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 15 Mar 2019 23:00:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement sillyrename for AFS unlink and rename, using the NFS variant
implementation as a basis.

Note that the asynchronous file locking extender/releaser has to be
notified with a state change to stop it complaining if there's a race
between that and the actual file deletion.

A tracepoint, afs_silly_rename, is also added to note the silly rename and
the cleanup.  The afs_edit_dir tracepoint is given some extra reason
indicators and the afs_flock_ev tracepoint is given a silly-delete file
lock cancellation indicator.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/Makefile            |    1 
 fs/afs/dir.c               |  116 ++++++++++++++++++++-
 fs/afs/dir_silly.c         |  239 ++++++++++++++++++++++++++++++++++++++++++++
 fs/afs/flock.c             |    2 
 fs/afs/inode.c             |    2 
 fs/afs/internal.h          |   10 ++
 fs/afs/super.c             |    4 +
 include/trace/events/afs.h |   34 ++++++
 8 files changed, 395 insertions(+), 13 deletions(-)
 create mode 100644 fs/afs/dir_silly.c

diff --git a/fs/afs/Makefile b/fs/afs/Makefile
index 0738e2bf5193..cbf31f6cd177 100644
--- a/fs/afs/Makefile
+++ b/fs/afs/Makefile
@@ -13,6 +13,7 @@ kafs-y := \
 	cmservice.o \
 	dir.o \
 	dir_edit.o \
+	dir_silly.o \
 	dynroot.o \
 	file.o \
 	flock.o \
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index be5d2f932b77..6c8523501639 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -26,6 +26,7 @@ static int afs_dir_open(struct inode *inode, struct file *file);
 static int afs_readdir(struct file *file, struct dir_context *ctx);
 static int afs_d_revalidate(struct dentry *dentry, unsigned int flags);
 static int afs_d_delete(const struct dentry *dentry);
+static void afs_d_iput(struct dentry *dentry, struct inode *inode);
 static int afs_lookup_one_filldir(struct dir_context *ctx, const char *name, int nlen,
 				  loff_t fpos, u64 ino, unsigned dtype);
 static int afs_lookup_filldir(struct dir_context *ctx, const char *name, int nlen,
@@ -85,6 +86,7 @@ const struct dentry_operations afs_fs_dentry_operations = {
 	.d_delete	= afs_d_delete,
 	.d_release	= afs_d_release,
 	.d_automount	= afs_d_automount,
+	.d_iput		= afs_d_iput,
 };
 
 struct afs_lookup_one_cookie {
@@ -1083,6 +1085,16 @@ static int afs_d_delete(const struct dentry *dentry)
 	return 1;
 }
 
+/*
+ * Clean up sillyrename files on dentry removal.
+ */
+static void afs_d_iput(struct dentry *dentry, struct inode *inode)
+{
+	if (dentry->d_flags & DCACHE_NFSFS_RENAMED)
+		afs_silly_iput(dentry, inode);
+	iput(inode);
+}
+
 /*
  * handle dentry release
  */
@@ -1225,6 +1237,12 @@ static int afs_rmdir(struct inode *dir, struct dentry *dentry)
 			goto error_key;
 	}
 
+	if (vnode) {
+		ret = down_write_killable(&vnode->rmdir_lock);
+		if (ret < 0)
+			goto error_key;
+	}
+
 	ret = -ERESTARTSYS;
 	if (afs_begin_vnode_operation(&fc, dvnode, key)) {
 		while (afs_select_fileserver(&fc)) {
@@ -1243,6 +1261,8 @@ static int afs_rmdir(struct inode *dir, struct dentry *dentry)
 		}
 	}
 
+	if (vnode)
+		up_write(&vnode->rmdir_lock);
 error_key:
 	key_put(key);
 error:
@@ -1259,9 +1279,9 @@ static int afs_rmdir(struct inode *dir, struct dentry *dentry)
  * However, if we didn't have a callback promise outstanding, or it was
  * outstanding on a different server, then it won't break it either...
  */
-static int afs_dir_remove_link(struct dentry *dentry, struct key *key,
-			       unsigned long d_version_before,
-			       unsigned long d_version_after)
+int afs_dir_remove_link(struct dentry *dentry, struct key *key,
+			unsigned long d_version_before,
+			unsigned long d_version_after)
 {
 	bool dir_valid;
 	int ret = 0;
@@ -1308,6 +1328,7 @@ static int afs_unlink(struct inode *dir, struct dentry *dentry)
 	struct afs_vnode *dvnode = AFS_FS_I(dir), *vnode = NULL;
 	struct key *key;
 	unsigned long d_version = (unsigned long)dentry->d_fsdata;
+	bool need_rehash = false;
 	u64 data_version = dvnode->status.data_version;
 	int ret;
 
@@ -1331,6 +1352,21 @@ static int afs_unlink(struct inode *dir, struct dentry *dentry)
 			goto error_key;
 	}
 
+	spin_lock(&dentry->d_lock);
+	if (vnode && d_count(dentry) > 1) {
+		spin_unlock(&dentry->d_lock);
+		/* Start asynchronous writeout of the inode */
+		write_inode_now(d_inode(dentry), 0);
+		ret = afs_sillyrename(dvnode, vnode, dentry, key);
+		goto error_key;
+	}
+	if (!d_unhashed(dentry)) {
+		/* Prevent a race with RCU lookup. */
+		__d_drop(dentry);
+		need_rehash = true;
+	}
+	spin_unlock(&dentry->d_lock);
+
 	ret = -ERESTARTSYS;
 	if (afs_begin_vnode_operation(&fc, dvnode, key)) {
 		while (afs_select_fileserver(&fc)) {
@@ -1362,6 +1398,9 @@ static int afs_unlink(struct inode *dir, struct dentry *dentry)
 					    afs_edit_dir_for_unlink);
 	}
 
+	if (need_rehash && ret < 0 && ret != -ENOENT)
+		d_rehash(dentry);
+
 error_key:
 	key_put(key);
 error:
@@ -1582,6 +1621,8 @@ static int afs_rename(struct inode *old_dir, struct dentry *old_dentry,
 {
 	struct afs_fs_cursor fc;
 	struct afs_vnode *orig_dvnode, *new_dvnode, *vnode;
+	struct dentry *tmp = NULL, *rehash = NULL;
+	struct inode *new_inode;
 	struct key *key;
 	u64 orig_data_version, new_data_version;
 	bool new_negative = d_is_negative(new_dentry);
@@ -1590,6 +1631,10 @@ static int afs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (flags)
 		return -EINVAL;
 
+	/* Don't allow silly-rename files be moved around. */
+	if (old_dentry->d_flags & DCACHE_NFSFS_RENAMED)
+		return -EINVAL;
+
 	vnode = AFS_FS_I(d_inode(old_dentry));
 	orig_dvnode = AFS_FS_I(old_dir);
 	new_dvnode = AFS_FS_I(new_dir);
@@ -1608,12 +1653,48 @@ static int afs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto error;
 	}
 
+	/* For non-directories, check whether the target is busy and if so,
+	 * make a copy of the dentry and then do a silly-rename.  If the
+	 * silly-rename succeeds, the copied dentry is hashed and becomes the
+	 * new target.
+	 */
+	if (d_is_positive(new_dentry) && !d_is_dir(new_dentry)) {
+		/* To prevent any new references to the target during the
+		 * rename, we unhash the dentry in advance.
+		 */
+		if (!d_unhashed(new_dentry)) {
+			d_drop(new_dentry);
+			rehash = new_dentry;
+		}
+
+		if (d_count(new_dentry) > 2) {
+			/* copy the target dentry's name */
+			ret = -ENOMEM;
+			tmp = d_alloc(new_dentry->d_parent,
+				      &new_dentry->d_name);
+			if (!tmp)
+				goto error_rehash;
+
+			ret = afs_sillyrename(new_dvnode,
+					      AFS_FS_I(d_inode(new_dentry)),
+					      new_dentry, key);
+			if (ret)
+				goto error_rehash;
+
+			new_dentry = tmp;
+			rehash = NULL;
+			new_negative = true;
+			orig_data_version = orig_dvnode->status.data_version;
+			new_data_version = new_dvnode->status.data_version;
+		}
+	}
+
 	ret = -ERESTARTSYS;
 	if (afs_begin_vnode_operation(&fc, orig_dvnode, key)) {
 		if (orig_dvnode != new_dvnode) {
 			if (mutex_lock_interruptible_nested(&new_dvnode->io_lock, 1) < 0) {
 				afs_end_vnode_operation(&fc);
-				goto error_key;
+				goto error_rehash;
 			}
 		}
 		while (afs_select_fileserver(&fc)) {
@@ -1630,25 +1711,42 @@ static int afs_rename(struct inode *old_dir, struct dentry *old_dentry,
 			mutex_unlock(&new_dvnode->io_lock);
 		ret = afs_end_vnode_operation(&fc);
 		if (ret < 0)
-			goto error_key;
+			goto error_rehash;
 	}
 
 	if (ret == 0) {
+		if (rehash)
+			d_rehash(rehash);
 		if (test_bit(AFS_VNODE_DIR_VALID, &orig_dvnode->flags))
 		    afs_edit_dir_remove(orig_dvnode, &old_dentry->d_name,
-					afs_edit_dir_for_rename);
+					afs_edit_dir_for_rename_0);
 
 		if (!new_negative &&
 		    test_bit(AFS_VNODE_DIR_VALID, &new_dvnode->flags))
 			afs_edit_dir_remove(new_dvnode, &new_dentry->d_name,
-					    afs_edit_dir_for_rename);
+					    afs_edit_dir_for_rename_1);
 
 		if (test_bit(AFS_VNODE_DIR_VALID, &new_dvnode->flags))
 			afs_edit_dir_add(new_dvnode, &new_dentry->d_name,
-					 &vnode->fid,  afs_edit_dir_for_rename);
+					 &vnode->fid, afs_edit_dir_for_rename_2);
+
+		new_inode = d_inode(new_dentry);
+		if (new_inode) {
+			spin_lock(&new_inode->i_lock);
+			if (new_inode->i_nlink > 0)
+				drop_nlink(new_inode);
+			spin_unlock(&new_inode->i_lock);
+		}
+		d_move(old_dentry, new_dentry);
+		goto error_tmp;
 	}
 
-error_key:
+error_rehash:
+	if (rehash)
+		d_rehash(rehash);
+error_tmp:
+	if (tmp)
+		dput(tmp);
 	key_put(key);
 error:
 	_leave(" = %d", ret);
diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
new file mode 100644
index 000000000000..aa4f72d24d91
--- /dev/null
+++ b/fs/afs/dir_silly.c
@@ -0,0 +1,239 @@
+/* AFS silly rename handling
+ *
+ * Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ * - Derived from NFS's sillyrename.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/fsnotify.h>
+#include "internal.h"
+
+/*
+ * Actually perform the silly rename step.
+ */
+static int afs_do_silly_rename(struct afs_vnode *dvnode, struct afs_vnode *vnode,
+			       struct dentry *old, struct dentry *new,
+			       struct key *key)
+{
+	struct afs_fs_cursor fc;
+	u64 dir_data_version = dvnode->status.data_version;
+	int ret = -ERESTARTSYS;
+
+	_enter("%pd,%pd", old, new);
+
+	trace_afs_silly_rename(vnode, false);
+	if (afs_begin_vnode_operation(&fc, dvnode, key)) {
+		while (afs_select_fileserver(&fc)) {
+			fc.cb_break = afs_calc_vnode_cb_break(dvnode);
+			afs_fs_rename(&fc, old->d_name.name,
+				      dvnode, new->d_name.name,
+				      dir_data_version, dir_data_version);
+		}
+
+		afs_vnode_commit_status(&fc, dvnode, fc.cb_break);
+		ret = afs_end_vnode_operation(&fc);
+	}
+
+	if (ret == 0) {
+		spin_lock(&old->d_lock);
+		old->d_flags |= DCACHE_NFSFS_RENAMED;
+		spin_unlock(&old->d_lock);
+		if (dvnode->silly_key != key) {
+			key_put(dvnode->silly_key);
+			dvnode->silly_key = key_get(key);
+		}
+
+		if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
+			afs_edit_dir_remove(dvnode, &old->d_name,
+					    afs_edit_dir_for_silly_0);
+		if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
+			afs_edit_dir_add(dvnode, &new->d_name,
+					 &vnode->fid, afs_edit_dir_for_silly_1);
+
+		/* vfs_unlink and the like do not issue this when a file is
+		 * sillyrenamed, so do it here.
+		 */
+		fsnotify_nameremove(old, 0);
+	}
+
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/**
+ * afs_sillyrename - Perform a silly-rename of a dentry
+ *
+ * AFS is stateless and the server doesn't know when the client is holding a
+ * file open.  To prevent application problems when a file is unlinked while
+ * it's still open, the client performs a "silly-rename".  That is, it renames
+ * the file to a hidden file in the same directory, and only performs the
+ * unlink once the last reference to it is put.
+ *
+ * The final cleanup is done during dentry_iput.
+ */
+int afs_sillyrename(struct afs_vnode *dvnode, struct afs_vnode *vnode,
+		    struct dentry *dentry, struct key *key)
+{
+	static unsigned int sillycounter;
+	struct dentry *sdentry = NULL;
+	unsigned char silly[16];
+	int ret = -EBUSY;
+
+	_enter("");
+
+	/* We don't allow a dentry to be silly-renamed twice. */
+	if (dentry->d_flags & DCACHE_NFSFS_RENAMED)
+		return -EBUSY;
+
+	sdentry = NULL;
+	do {
+		int slen;
+
+		dput(sdentry);
+		sillycounter++;
+
+		/* Create a silly name.  Note that the ".__afs" prefix is
+		 * understood by the salvager and must not be changed.
+		 */
+		slen = scnprintf(silly, sizeof(silly), ".__afs%04X", sillycounter);
+		sdentry = lookup_one_len(silly, dentry->d_parent, slen);
+
+		/* N.B. Better to return EBUSY here ... it could be dangerous
+		 * to delete the file while it's in use.
+		 */
+		if (IS_ERR(sdentry))
+			goto out;
+	} while (!d_is_negative(sdentry));
+
+	ihold(&vnode->vfs_inode);
+
+	ret = afs_do_silly_rename(dvnode, vnode, dentry, sdentry, key);
+	switch (ret) {
+	case 0:
+		/* The rename succeeded. */
+		d_move(dentry, sdentry);
+		break;
+	case -ERESTARTSYS:
+		/* The result of the rename is unknown. Play it safe by forcing
+		 * a new lookup.
+		 */
+		d_drop(dentry);
+		d_drop(sdentry);
+	}
+
+	iput(&vnode->vfs_inode);
+	dput(sdentry);
+out:
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * Tell the server to remove a sillyrename file.
+ */
+static int afs_do_silly_unlink(struct afs_vnode *dvnode, struct afs_vnode *vnode,
+			       struct dentry *dentry, struct key *key)
+{
+	struct afs_fs_cursor fc;
+	u64 dir_data_version = dvnode->status.data_version;
+	int ret;
+
+	_enter("");
+
+	trace_afs_silly_rename(vnode, true);
+	if (afs_begin_vnode_operation(&fc, dvnode, key)) {
+		while (afs_select_fileserver(&fc)) {
+			fc.cb_break = afs_calc_vnode_cb_break(dvnode);
+
+			if (test_bit(AFS_SERVER_FL_IS_YFS, &fc.cbi->server->flags) &&
+			    !test_bit(AFS_SERVER_FL_NO_RM2, &fc.cbi->server->flags)) {
+				yfs_fs_remove_file2(&fc, vnode, dentry->d_name.name,
+						    dir_data_version);
+				if (fc.ac.error != -ECONNABORTED ||
+				    fc.ac.abort_code != RXGEN_OPCODE)
+					continue;
+				set_bit(AFS_SERVER_FL_NO_RM2, &fc.cbi->server->flags);
+			}
+
+			afs_fs_remove(&fc, vnode, dentry->d_name.name, false,
+				      dir_data_version);
+		}
+
+		afs_vnode_commit_status(&fc, dvnode, fc.cb_break);
+		ret = afs_end_vnode_operation(&fc);
+		if (ret == 0) {
+			drop_nlink(&vnode->vfs_inode);
+			if (vnode->vfs_inode.i_nlink == 0) {
+				set_bit(AFS_VNODE_DELETED, &vnode->flags);
+				clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags);
+			}
+		}
+		if (ret == 0 &&
+		    test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
+			afs_edit_dir_remove(dvnode, &dentry->d_name,
+					    afs_edit_dir_for_unlink);
+	}
+
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * Remove sillyrename file on iput.
+ */
+int afs_silly_iput(struct dentry *dentry, struct inode *inode)
+{
+	struct afs_vnode *dvnode = AFS_FS_I(d_inode(dentry->d_parent));
+	struct afs_vnode *vnode = AFS_FS_I(inode);
+	struct dentry *alias;
+	int ret;
+
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
+
+	_enter("%p{%pd},%llx", dentry, dentry, vnode->fid.vnode);
+
+	down_read(&dvnode->rmdir_lock);
+
+	alias = d_alloc_parallel(dentry->d_parent, &dentry->d_name, &wq);
+	if (IS_ERR(alias)) {
+		up_read(&dvnode->rmdir_lock);
+		return 0;
+	}
+
+	if (!d_in_lookup(alias)) {
+		/* We raced with lookup...  See if we need to transfer the
+		 * sillyrename information to the aliased dentry.
+		 */
+		ret = 0;
+		spin_lock(&alias->d_lock);
+		if (d_really_is_positive(alias) &&
+		    !(alias->d_flags & DCACHE_NFSFS_RENAMED)) {
+			alias->d_flags |= DCACHE_NFSFS_RENAMED;
+			ret = 1;
+		}
+		spin_unlock(&alias->d_lock);
+		up_read(&dvnode->rmdir_lock);
+		dput(alias);
+		return ret;
+	}
+
+	/* Stop lock-release from complaining. */
+	spin_lock(&vnode->lock);
+	vnode->lock_state = AFS_VNODE_LOCK_DELETED;
+	trace_afs_flock_ev(vnode, NULL, afs_flock_silly_delete, 0);
+	spin_unlock(&vnode->lock);
+
+	afs_do_silly_unlink(dvnode, vnode, dentry, dvnode->silly_key);
+	up_read(&dvnode->rmdir_lock);
+	d_lookup_done(alias);
+	dput(alias);
+	return 1;
+}
diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index 08b06f53a375..2dbdedeaabcf 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -300,7 +300,7 @@ void afs_lock_work(struct work_struct *work)
 		/* attempt to release the server lock; if it fails, we just
 		 * wait 5 minutes and it'll expire anyway */
 		ret = afs_release_lock(vnode, vnode->lock_key);
-		if (ret < 0) {
+		if (ret < 0 && vnode->lock_state != AFS_VNODE_LOCK_DELETED) {
 			trace_afs_flock_ev(vnode, NULL, afs_flock_release_fail,
 					   ret);
 			printk(KERN_WARNING "AFS:"
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 1a4ce07fb406..bbd3d26c669e 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -545,6 +545,8 @@ void afs_evict_inode(struct inode *inode)
 #endif
 
 	afs_put_permits(rcu_access_pointer(vnode->permit_cache));
+	key_put(vnode->silly_key);
+	vnode->silly_key = NULL;
 	key_put(vnode->lock_key);
 	vnode->lock_key = NULL;
 	_leave("");
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index d6763e59952d..a6ce6f8c9521 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -622,6 +622,8 @@ struct afs_vnode {
 	struct afs_permits __rcu *permit_cache;	/* cache of permits so far obtained */
 	struct mutex		io_lock;	/* Lock for serialising I/O on this mutex */
 	struct rw_semaphore	validate_lock;	/* lock for validating this vnode */
+	struct rw_semaphore	rmdir_lock;	/* Lock for rmdir vs sillyrename */
+	struct key		*silly_key;	/* Silly rename key */
 	spinlock_t		wb_lock;	/* lock for wb_keys */
 	spinlock_t		lock;		/* waitqueue/flags lock */
 	unsigned long		flags;
@@ -868,6 +870,7 @@ extern const struct address_space_operations afs_dir_aops;
 extern const struct dentry_operations afs_fs_dentry_operations;
 
 extern void afs_d_release(struct dentry *);
+extern int afs_dir_remove_link(struct dentry *, struct key *, unsigned long, unsigned long);
 
 /*
  * dir_edit.c
@@ -876,6 +879,13 @@ extern void afs_edit_dir_add(struct afs_vnode *, struct qstr *, struct afs_fid *
 			     enum afs_edit_dir_reason);
 extern void afs_edit_dir_remove(struct afs_vnode *, struct qstr *, enum afs_edit_dir_reason);
 
+/*
+ * dir_silly.c
+ */
+extern int afs_sillyrename(struct afs_vnode *, struct afs_vnode *,
+			   struct dentry *, struct key *);
+extern int afs_silly_iput(struct dentry *, struct inode *);
+
 /*
  * dynroot.c
  */
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 5adf012b8e27..6438849a75c4 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -45,7 +45,7 @@ struct file_system_type afs_fs_type = {
 	.init_fs_context	= afs_init_fs_context,
 	.parameters		= &afs_fs_parameters,
 	.kill_sb		= afs_kill_super,
-	.fs_flags		= 0,
+	.fs_flags		= FS_RENAME_DOES_D_MOVE,
 };
 MODULE_ALIAS_FS("afs");
 
@@ -656,6 +656,8 @@ static struct inode *afs_alloc_inode(struct super_block *sb)
 	vnode->cb_type		= 0;
 	vnode->lock_state	= AFS_VNODE_LOCK_NONE;
 
+	init_rwsem(&vnode->rmdir_lock);
+
 	_leave(" = %p", &vnode->vfs_inode);
 	return &vnode->vfs_inode;
 }
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 8da9dd5bc2b6..f67815ebb1b9 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -108,8 +108,12 @@ enum afs_edit_dir_reason {
 	afs_edit_dir_for_create,
 	afs_edit_dir_for_link,
 	afs_edit_dir_for_mkdir,
-	afs_edit_dir_for_rename,
+	afs_edit_dir_for_rename_0,
+	afs_edit_dir_for_rename_1,
+	afs_edit_dir_for_rename_2,
 	afs_edit_dir_for_rmdir,
+	afs_edit_dir_for_silly_0,
+	afs_edit_dir_for_silly_1,
 	afs_edit_dir_for_symlink,
 	afs_edit_dir_for_unlink,
 };
@@ -161,6 +165,7 @@ enum afs_flock_event {
 	afs_flock_fail_perm,
 	afs_flock_no_lockers,
 	afs_flock_release_fail,
+	afs_flock_silly_delete,
 	afs_flock_timestamp,
 	afs_flock_try_to_lock,
 	afs_flock_vfs_lock,
@@ -273,8 +278,12 @@ enum afs_flock_operation {
 	EM(afs_edit_dir_for_create,		"Create") \
 	EM(afs_edit_dir_for_link,		"Link  ") \
 	EM(afs_edit_dir_for_mkdir,		"MkDir ") \
-	EM(afs_edit_dir_for_rename,		"Rename") \
+	EM(afs_edit_dir_for_rename_0,		"Renam0") \
+	EM(afs_edit_dir_for_rename_1,		"Renam1") \
+	EM(afs_edit_dir_for_rename_2,		"Renam2") \
 	EM(afs_edit_dir_for_rmdir,		"RmDir ") \
+	EM(afs_edit_dir_for_silly_0,		"S_Ren0") \
+	EM(afs_edit_dir_for_silly_1,		"S_Ren1") \
 	EM(afs_edit_dir_for_symlink,		"Symlnk") \
 	E_(afs_edit_dir_for_unlink,		"Unlink")
 
@@ -337,6 +346,7 @@ enum afs_flock_operation {
 	EM(afs_flock_fail_perm,			"ErrPerm ")		\
 	EM(afs_flock_no_lockers,		"NoLocker")		\
 	EM(afs_flock_release_fail,		"Rel_Fail")		\
+	EM(afs_flock_silly_delete,		"SillyDel")		\
 	EM(afs_flock_timestamp,			"Timestmp")		\
 	EM(afs_flock_try_to_lock,		"TryToLck")		\
 	EM(afs_flock_vfs_lock,			"VFSLock ")		\
@@ -964,6 +974,26 @@ TRACE_EVENT(afs_reload_dir,
 		      __entry->fid.vid, __entry->fid.vnode, __entry->fid.unique)
 	    );
 
+TRACE_EVENT(afs_silly_rename,
+	    TP_PROTO(struct afs_vnode *vnode, bool done),
+
+	    TP_ARGS(vnode, done),
+
+	    TP_STRUCT__entry(
+		    __field_struct(struct afs_fid,	fid		)
+		    __field(bool,			done		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->fid = vnode->fid;
+		    __entry->done = done;
+			   ),
+
+	    TP_printk("%llx:%llx:%x done=%u",
+		      __entry->fid.vid, __entry->fid.vnode, __entry->fid.unique,
+		      __entry->done)
+	    );
+
 #endif /* _TRACE_AFS_H */
 
 /* This part must be outside protection */

