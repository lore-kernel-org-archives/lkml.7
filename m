Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8677C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA92D20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbfC0XqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:46:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbfC0XqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:46:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E82F03099D37;
        Wed, 27 Mar 2019 23:46:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E62996A978;
        Wed, 27 Mar 2019 23:46:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 44/68] vfs: Convert fuse to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:46:04 +0000
Message-ID: <155373036414.7602.7964458548629410897.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 27 Mar 2019 23:46:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the fuse filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.
---

 fs/fuse/inode.c |  274 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 149 insertions(+), 125 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ec5d9953dfb6..bfcde29e4a1e 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -15,7 +15,8 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/parser.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/statfs.h>
 #include <linux/random.h>
 #include <linux/sched.h>
@@ -59,7 +60,12 @@ MODULE_PARM_DESC(max_user_congthresh,
 /** Congestion starts at 75% of maximum */
 #define FUSE_DEFAULT_CONGESTION_THRESHOLD (FUSE_DEFAULT_MAX_BACKGROUND * 3 / 4)
 
-struct fuse_mount_data {
+#ifdef CONFIG_BLOCK
+static struct file_system_type fuseblk_fs_type;
+#endif
+
+struct fuse_fs_context {
+	bool		is_bdev;
 	int fd;
 	unsigned rootmode;
 	kuid_t user_id;
@@ -448,6 +454,7 @@ static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
 }
 
 enum {
+	OPT_SOURCE,
 	OPT_FD,
 	OPT_ROOTMODE,
 	OPT_USER_ID,
@@ -459,111 +466,97 @@ enum {
 	OPT_ERR
 };
 
-static const match_table_t tokens = {
-	{OPT_FD,			"fd=%u"},
-	{OPT_ROOTMODE,			"rootmode=%o"},
-	{OPT_USER_ID,			"user_id=%u"},
-	{OPT_GROUP_ID,			"group_id=%u"},
-	{OPT_DEFAULT_PERMISSIONS,	"default_permissions"},
-	{OPT_ALLOW_OTHER,		"allow_other"},
-	{OPT_MAX_READ,			"max_read=%u"},
-	{OPT_BLKSIZE,			"blksize=%u"},
-	{OPT_ERR,			NULL}
+static const struct fs_parameter_spec fuse_param_specs[] = {
+	fsparam_string	("source",		OPT_SOURCE),
+	fsparam_fd	("fd",			OPT_FD),
+	fsparam_u32oct	("rootmode",		OPT_ROOTMODE),
+	fsparam_u32	("user_id",		OPT_USER_ID),
+	fsparam_u32	("group_id",		OPT_GROUP_ID),
+	fsparam_flag	("default_permissions",	OPT_DEFAULT_PERMISSIONS),
+	fsparam_flag	("allow_other",		OPT_ALLOW_OTHER),
+	fsparam_u32	("max_read",		OPT_MAX_READ),
+	fsparam_u32	("blksize",		OPT_BLKSIZE),
+	{}
+};
+
+static const struct fs_parameter_description fuse_fs_parameters = {
+	.name		= "fuse",
+	.specs		= fuse_param_specs,
 };
 
-static int fuse_match_uint(substring_t *s, unsigned int *res)
+static int fuse_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	int err = -ENOMEM;
-	char *buf = match_strdup(s);
-	if (buf) {
-		err = kstrtouint(buf, 10, res);
-		kfree(buf);
+	struct fs_parse_result result;
+	struct fuse_fs_context *ctx = fc->fs_private;
+	int opt;
+
+	opt = fs_parse(fc, &fuse_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case OPT_SOURCE:
+		kfree(fc->source);
+		fc->source = param->string;
+		param->string = NULL;
+		break;
+
+	case OPT_FD:
+		ctx->fd = result.uint_32;
+		ctx->fd_present = 1;
+		break;
+
+	case OPT_ROOTMODE:
+		if (!fuse_valid_type(result.uint_32))
+			return invalf(fc, "fuse: Invalid rootmode");
+		ctx->rootmode = result.uint_32;
+		ctx->rootmode_present = 1;
+		break;
+
+	case OPT_USER_ID:
+		ctx->user_id = make_kuid(fc->user_ns, result.uint_32);
+		if (!uid_valid(ctx->user_id))
+			return invalf(fc, "fuse: Invalid user_id");
+		ctx->user_id_present = 1;
+		break;
+
+	case OPT_GROUP_ID:
+		ctx->group_id = make_kgid(fc->user_ns, result.uint_32);
+		if (!gid_valid(ctx->group_id))
+			return invalf(fc, "fuse: Invalid group_id");
+		ctx->group_id_present = 1;
+		break;
+
+	case OPT_DEFAULT_PERMISSIONS:
+		ctx->default_permissions = 1;
+		break;
+
+	case OPT_ALLOW_OTHER:
+		ctx->allow_other = 1;
+		break;
+
+	case OPT_MAX_READ:
+		ctx->max_read = result.uint_32;
+		break;
+
+	case OPT_BLKSIZE:
+		if (!ctx->is_bdev)
+			return invalf(fc, "fuse: blksize only supported for fuseblk");
+		ctx->blksize = result.uint_32;
+		break;
+
+	default:
+		return -EINVAL;
 	}
-	return err;
+
+	return 0;
 }
 
-static int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
-			  struct user_namespace *user_ns)
+static void fuse_free_fc(struct fs_context *fc)
 {
-	char *p;
-	memset(d, 0, sizeof(struct fuse_mount_data));
-	d->max_read = ~0;
-	d->blksize = FUSE_DEFAULT_BLKSIZE;
-
-	while ((p = strsep(&opt, ",")) != NULL) {
-		int token;
-		int value;
-		unsigned uv;
-		substring_t args[MAX_OPT_ARGS];
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case OPT_FD:
-			if (match_int(&args[0], &value))
-				return 0;
-			d->fd = value;
-			d->fd_present = 1;
-			break;
-
-		case OPT_ROOTMODE:
-			if (match_octal(&args[0], &value))
-				return 0;
-			if (!fuse_valid_type(value))
-				return 0;
-			d->rootmode = value;
-			d->rootmode_present = 1;
-			break;
-
-		case OPT_USER_ID:
-			if (fuse_match_uint(&args[0], &uv))
-				return 0;
-			d->user_id = make_kuid(user_ns, uv);
-			if (!uid_valid(d->user_id))
-				return 0;
-			d->user_id_present = 1;
-			break;
-
-		case OPT_GROUP_ID:
-			if (fuse_match_uint(&args[0], &uv))
-				return 0;
-			d->group_id = make_kgid(user_ns, uv);
-			if (!gid_valid(d->group_id))
-				return 0;
-			d->group_id_present = 1;
-			break;
-
-		case OPT_DEFAULT_PERMISSIONS:
-			d->default_permissions = 1;
-			break;
-
-		case OPT_ALLOW_OTHER:
-			d->allow_other = 1;
-			break;
-
-		case OPT_MAX_READ:
-			if (match_int(&args[0], &value))
-				return 0;
-			d->max_read = value;
-			break;
-
-		case OPT_BLKSIZE:
-			if (!is_bdev || match_int(&args[0], &value))
-				return 0;
-			d->blksize = value;
-			break;
-
-		default:
-			return 0;
-		}
-	}
+	struct fuse_fs_context *ctx = fc->fs_private;
 
-	if (!d->fd_present || !d->rootmode_present ||
-	    !d->user_id_present || !d->group_id_present)
-		return 0;
-
-	return 1;
+	kfree(ctx);
 }
 
 static int fuse_show_options(struct seq_file *m, struct dentry *root)
@@ -1078,12 +1071,12 @@ void fuse_dev_free(struct fuse_dev *fud)
 }
 EXPORT_SYMBOL_GPL(fuse_dev_free);
 
-static int fuse_fill_super(struct super_block *sb, void *data, int silent)
+static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 {
+	struct fuse_fs_context *ctx = fsc->fs_private;
 	struct fuse_dev *fud;
 	struct fuse_conn *fc;
 	struct inode *root;
-	struct fuse_mount_data d;
 	struct file *file;
 	struct dentry *root_dentry;
 	struct fuse_req *init_req;
@@ -1096,13 +1089,10 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
 
-	if (!parse_fuse_opt(data, &d, is_bdev, sb->s_user_ns))
-		goto err;
-
 	if (is_bdev) {
 #ifdef CONFIG_BLOCK
 		err = -EINVAL;
-		if (!sb_set_blocksize(sb, d.blksize))
+		if (!sb_set_blocksize(sb, ctx->blksize))
 			goto err;
 #endif
 	} else {
@@ -1119,7 +1109,7 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	if (sb->s_user_ns != &init_user_ns)
 		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
 
-	file = fget(d.fd);
+	file = fget(ctx->fd);
 	err = -EINVAL;
 	if (!file)
 		goto err;
@@ -1162,17 +1152,17 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 		fc->dont_mask = 1;
 	sb->s_flags |= SB_POSIXACL;
 
-	fc->default_permissions = d.default_permissions;
-	fc->allow_other = d.allow_other;
-	fc->user_id = d.user_id;
-	fc->group_id = d.group_id;
-	fc->max_read = max_t(unsigned, 4096, d.max_read);
+	fc->default_permissions = ctx->default_permissions;
+	fc->allow_other = ctx->allow_other;
+	fc->user_id = ctx->user_id;
+	fc->group_id = ctx->group_id;
+	fc->max_read = max_t(unsigned, 4096, ctx->max_read);
 
 	/* Used by get_root_inode() */
 	sb->s_fs_info = fc;
 
 	err = -ENOMEM;
-	root = fuse_get_root_inode(sb, d.rootmode);
+	root = fuse_get_root_inode(sb, ctx->rootmode);
 	sb->s_d_op = &fuse_root_dentry_operations;
 	root_dentry = d_make_root(root);
 	if (!root_dentry)
@@ -1232,11 +1222,50 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	return err;
 }
 
-static struct dentry *fuse_mount(struct file_system_type *fs_type,
-		       int flags, const char *dev_name,
-		       void *raw_data)
+static int fuse_get_tree(struct fs_context *fc)
+{
+	struct fuse_fs_context *ctx = fc->fs_private;
+
+	if (!ctx->fd_present || !ctx->rootmode_present ||
+	    !ctx->user_id_present || !ctx->group_id_present)
+		return invalf(fc, "fuse: Missing mount parameter(s)");
+
+#ifdef CONFIG_BLOCK
+	if (ctx->is_bdev)
+		return vfs_get_block_super(fc, fuse_fill_super);
+#endif
+
+	return vfs_get_super(fc, vfs_get_independent_super, fuse_fill_super);
+}
+
+static const struct fs_context_operations fuse_context_ops = {
+	.free		= fuse_free_fc,
+	.parse_param	= fuse_parse_param,
+	.get_tree	= fuse_get_tree,
+};
+
+/*
+ * Set up the filesystem mount context.
+ */
+static int fuse_init_fs_context(struct fs_context *fc)
 {
-	return mount_nodev(fs_type, flags, raw_data, fuse_fill_super);
+	struct fuse_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct fuse_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->max_read = ~0;
+	ctx->blksize = FUSE_DEFAULT_BLKSIZE;
+
+#ifdef CONFIG_BLOCK
+	if (fc->fs_type == &fuseblk_fs_type)
+		ctx->is_bdev = true;
+#endif
+
+	fc->fs_private = ctx;
+	fc->ops = &fuse_context_ops;
+	return 0;
 }
 
 static void fuse_sb_destroy(struct super_block *sb)
@@ -1265,19 +1294,13 @@ static struct file_system_type fuse_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "fuse",
 	.fs_flags	= FS_HAS_SUBTYPE | FS_USERNS_MOUNT,
-	.mount		= fuse_mount,
+	.init_fs_context = fuse_init_fs_context,
+	.parameters	= &fuse_fs_parameters,
 	.kill_sb	= fuse_kill_sb_anon,
 };
 MODULE_ALIAS_FS("fuse");
 
 #ifdef CONFIG_BLOCK
-static struct dentry *fuse_mount_blk(struct file_system_type *fs_type,
-			   int flags, const char *dev_name,
-			   void *raw_data)
-{
-	return mount_bdev(fs_type, flags, dev_name, raw_data, fuse_fill_super);
-}
-
 static void fuse_kill_sb_blk(struct super_block *sb)
 {
 	fuse_sb_destroy(sb);
@@ -1287,7 +1310,8 @@ static void fuse_kill_sb_blk(struct super_block *sb)
 static struct file_system_type fuseblk_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "fuseblk",
-	.mount		= fuse_mount_blk,
+	.init_fs_context = fuse_init_fs_context,
+	.parameters	= &fuse_fs_parameters,
 	.kill_sb	= fuse_kill_sb_blk,
 	.fs_flags	= FS_REQUIRES_DEV | FS_HAS_SUBTYPE,
 };

