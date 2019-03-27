Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F57C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4738D2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733108AbfC0XnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:43:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731002AbfC0XnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:43:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C5C0C0586D8;
        Wed, 27 Mar 2019 23:43:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0F665C28D;
        Wed, 27 Mar 2019 23:43:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 20/68] vfs: Kill off mount_pseudo() and
 mount_pseudo_xattr()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:43:06 +0000
Message-ID: <155373018685.7602.13175035775252327410.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 27 Mar 2019 23:43:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kill off mount_pseudo() and mount_pseudo_xattr() as they're replaced with
vfs_init_pseudo_fs_context().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-fsdevel@vger.kernel.org
---

 fs/libfs.c         |   53 ----------------------------------------------------
 include/linux/fs.h |   13 -------------
 2 files changed, 66 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index ceaf69c885c2..9a15590b65da 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -326,59 +326,6 @@ int vfs_init_pseudo_fs_context(struct fs_context *fc,
 }
 EXPORT_SYMBOL(vfs_init_pseudo_fs_context);
 
-/*
- * Common helper for pseudo-filesystems (sockfs, pipefs, bdev - stuff that
- * will never be mountable)
- */
-struct dentry *mount_pseudo_xattr(struct file_system_type *fs_type, char *name,
-	const struct super_operations *ops, const struct xattr_handler **xattr,
-	const struct dentry_operations *dops, unsigned long magic)
-{
-	struct super_block *s;
-	struct dentry *dentry;
-	struct inode *root;
-	struct qstr d_name = QSTR_INIT(name, strlen(name));
-
-	s = sget_userns(fs_type, NULL, set_anon_super, SB_KERNMOUNT|SB_NOUSER,
-			&init_user_ns, NULL);
-	if (IS_ERR(s))
-		return ERR_CAST(s);
-
-	s->s_maxbytes = MAX_LFS_FILESIZE;
-	s->s_blocksize = PAGE_SIZE;
-	s->s_blocksize_bits = PAGE_SHIFT;
-	s->s_magic = magic;
-	s->s_op = ops ? ops : &simple_super_operations;
-	s->s_xattr = xattr;
-	s->s_time_gran = 1;
-	root = new_inode(s);
-	if (!root)
-		goto Enomem;
-	/*
-	 * since this is the first inode, make it number 1. New inodes created
-	 * after this must take care not to collide with it (by passing
-	 * max_reserved of 1 to iunique).
-	 */
-	root->i_ino = 1;
-	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
-	root->i_atime = root->i_mtime = root->i_ctime = current_time(root);
-	dentry = __d_alloc(s, &d_name);
-	if (!dentry) {
-		iput(root);
-		goto Enomem;
-	}
-	d_instantiate(dentry, root);
-	s->s_root = dentry;
-	s->s_d_op = dops;
-	s->s_flags |= SB_ACTIVE;
-	return dget(s->s_root);
-
-Enomem:
-	deactivate_locked_super(s);
-	return ERR_PTR(-ENOMEM);
-}
-EXPORT_SYMBOL(mount_pseudo_xattr);
-
 int simple_open(struct inode *inode, struct file *file)
 {
 	if (inode->i_private)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8b42df09b04c..b738e8e5b096 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2245,19 +2245,6 @@ struct super_block *sget(struct file_system_type *type,
 			int (*test)(struct super_block *,void *),
 			int (*set)(struct super_block *,void *),
 			int flags, void *data);
-extern struct dentry *mount_pseudo_xattr(struct file_system_type *, char *,
-					 const struct super_operations *ops,
-					 const struct xattr_handler **xattr,
-					 const struct dentry_operations *dops,
-					 unsigned long);
-
-static inline struct dentry *
-mount_pseudo(struct file_system_type *fs_type, char *name,
-	     const struct super_operations *ops,
-	     const struct dentry_operations *dops, unsigned long magic)
-{
-	return mount_pseudo_xattr(fs_type, name, ops, NULL, dops, magic);
-}
 
 /* Alas, no aliases. Too much hassle with bringing module.h everywhere */
 #define fops_get(fops) \

