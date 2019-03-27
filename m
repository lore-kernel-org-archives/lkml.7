Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6085FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336182075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfC0XlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:41:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39398 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfC0XlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:41:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9590A30FE5C4;
        Wed, 27 Mar 2019 23:41:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 935355C23E;
        Wed, 27 Mar 2019 23:41:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 05/68] vfs: Provide a mount_pseudo-replacement for the
 new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:41:12 +0000
Message-ID: <155373007279.7602.18218484316637670571.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 27 Mar 2019 23:41:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a function, vfs_init_pseudo_fs_context(), that provides a common
infrastructure for converting pseudo-filesystems that can never be
mountable.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-fsdevel@vger.kernel.org
---

 fs/libfs.c                 |   93 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs_context.h |    7 +++
 2 files changed, 100 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 0fb590d79f30..ceaf69c885c2 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -16,6 +16,7 @@
 #include <linux/exportfs.h>
 #include <linux/writeback.h>
 #include <linux/buffer_head.h> /* sync_mapping_buffers */
+#include <linux/fs_context.h>
 
 #include <linux/uaccess.h>
 
@@ -233,6 +234,98 @@ static const struct super_operations simple_super_operations = {
 	.statfs		= simple_statfs,
 };
 
+struct pseudo_fs_context {
+	struct qstr d_name;
+	const struct super_operations *ops;
+	const struct xattr_handler **xattr;
+	const struct dentry_operations *dops;
+	unsigned long magic;
+};
+
+static int pseudo_fs_get_tree(struct fs_context *fc)
+{
+	struct pseudo_fs_context *ctx = fc->fs_private;
+	struct super_block *s;
+	struct dentry *dentry;
+	struct inode *root;
+
+	s = sget_userns(fc->fs_type, NULL, set_anon_super, SB_KERNMOUNT|SB_NOUSER,
+			&init_user_ns, NULL);
+	if (IS_ERR(s))
+		return PTR_ERR(s);
+
+	s->s_maxbytes = MAX_LFS_FILESIZE;
+	s->s_blocksize = PAGE_SIZE;
+	s->s_blocksize_bits = PAGE_SHIFT;
+	s->s_magic = ctx->magic;
+	s->s_op = ctx->ops ?: &simple_super_operations;
+	s->s_xattr = ctx->xattr;
+	s->s_time_gran = 1;
+	root = new_inode(s);
+	if (!root)
+		goto Enomem;
+	/*
+	 * since this is the first inode, make it number 1. New inodes created
+	 * after this must take care not to collide with it (by passing
+	 * max_reserved of 1 to iunique).
+	 */
+	root->i_ino = 1;
+	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
+	root->i_atime = root->i_mtime = root->i_ctime = current_time(root);
+	dentry = __d_alloc(s, &ctx->d_name);
+	if (!dentry) {
+		iput(root);
+		goto Enomem;
+	}
+	d_instantiate(dentry, root);
+	s->s_root = dentry;
+	s->s_d_op = ctx->dops;
+	s->s_flags |= SB_ACTIVE;
+	fc->root = dget(s->s_root);
+	return 0;
+
+Enomem:
+	deactivate_locked_super(s);
+	return -ENOMEM;
+}
+
+static void pseudo_fs_free(struct fs_context *fc)
+{
+	kfree(fc->fs_private);
+}
+
+static const struct fs_context_operations pseudo_fs_context_ops = {
+	.free		= pseudo_fs_free,
+	.get_tree	= pseudo_fs_get_tree,
+};
+
+/*
+ * Common helper for pseudo-filesystems (sockfs, pipefs, bdev - stuff that
+ * will never be mountable)
+ */
+int vfs_init_pseudo_fs_context(struct fs_context *fc,
+			       const char *name,
+			       const struct super_operations *ops,
+			       const struct xattr_handler **xattr,
+			       const struct dentry_operations *dops,
+			       unsigned long magic)
+{
+	struct pseudo_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	ctx->d_name = (struct qstr)QSTR_INIT(name, strlen(name));
+	ctx->ops = ops;
+	ctx->xattr = xattr;
+	ctx->dops = dops;
+	ctx->magic = magic;
+	fc->fs_private = ctx;
+	fc->ops = &pseudo_fs_context_ops;
+	return 0;
+}
+EXPORT_SYMBOL(vfs_init_pseudo_fs_context);
+
 /*
  * Common helper for pseudo-filesystems (sockfs, pipefs, bdev - stuff that
  * will never be mountable)
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 98b44ad89378..a779022d06f5 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -121,6 +121,13 @@ extern int generic_parse_monolithic(struct fs_context *fc, void *data);
 extern int vfs_get_tree(struct fs_context *fc);
 extern void put_fs_context(struct fs_context *fc);
 
+extern int vfs_init_pseudo_fs_context(struct fs_context *fc,
+				      const char *name,
+				      const struct super_operations *ops,
+				      const struct xattr_handler **xattr,
+				      const struct dentry_operations *dops,
+				      unsigned long magic);
+
 /*
  * sget() wrapper to be called from the ->get_tree() op.
  */

