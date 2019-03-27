Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BB5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1276F20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbfC0XrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:47:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731579AbfC0XrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:47:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E93830FE5C4;
        Wed, 27 Mar 2019 23:47:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 892485D9C5;
        Wed, 27 Mar 2019 23:47:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 53/68] vfs: Convert functionfs to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Felipe Balbi <balbi@kernel.org>,
        =?utf-8?q?Micha=C5=82?= Nazarewicz <mina86@mina86.com>,
        linux-usb@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:47:18 +0000
Message-ID: <155373043876.7602.1318289599022013332.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 27 Mar 2019 23:47:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the functionfs filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Felipe Balbi <balbi@kernel.org>
cc: Michał Nazarewicz <mina86@mina86.com>
cc: linux-usb@vger.kernel.org
---

 drivers/usb/gadget/function/f_fs.c |  233 +++++++++++++++++++-----------------
 1 file changed, 120 insertions(+), 113 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 20413c276c61..796c8b688477 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -17,6 +17,7 @@
 #include <linux/blkdev.h>
 #include <linux/pagemap.h>
 #include <linux/export.h>
+#include <linux/fs_parser.h>
 #include <linux/hid.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -1447,9 +1448,9 @@ struct ffs_sb_fill_data {
 	struct ffs_data *ffs_data;
 };
 
-static int ffs_sb_fill(struct super_block *sb, void *_data, int silent)
+static int ffs_sb_fill(struct super_block *sb, struct fs_context *fc)
 {
-	struct ffs_sb_fill_data *data = _data;
+	struct ffs_sb_fill_data *data = fc->fs_private;
 	struct inode	*inode;
 	struct ffs_data	*ffs = data->ffs_data;
 
@@ -1482,147 +1483,152 @@ static int ffs_sb_fill(struct super_block *sb, void *_data, int silent)
 	return 0;
 }
 
-static int ffs_fs_parse_opts(struct ffs_sb_fill_data *data, char *opts)
-{
-	ENTER();
+enum {
+	Opt_no_disconnect,
+	Opt_rmode,
+	Opt_fmode,
+	Opt_mode,
+	Opt_uid,
+	Opt_gid,
+};
 
-	if (!opts || !*opts)
-		return 0;
+static const struct fs_parameter_spec ffs_fs_param_specs[] = {
+	fsparam_bool	("no_disconnect",	Opt_no_disconnect),
+	fsparam_u32	("rmode",		Opt_rmode),
+	fsparam_u32	("fmode",		Opt_fmode),
+	fsparam_u32	("mode",		Opt_mode),
+	fsparam_u32	("uid",			Opt_uid),
+	fsparam_u32	("gid",			Opt_gid),
+	{}
+};
 
-	for (;;) {
-		unsigned long value;
-		char *eq, *comma;
-
-		/* Option limit */
-		comma = strchr(opts, ',');
-		if (comma)
-			*comma = 0;
-
-		/* Value limit */
-		eq = strchr(opts, '=');
-		if (unlikely(!eq)) {
-			pr_err("'=' missing in %s\n", opts);
-			return -EINVAL;
-		}
-		*eq = 0;
+static const struct fs_parameter_description ffs_fs_fs_parameters = {
+	.name		= "kAFS",
+	.specs		= ffs_fs_param_specs,
+};
 
-		/* Parse value */
-		if (kstrtoul(eq + 1, 0, &value)) {
-			pr_err("%s: invalid value: %s\n", opts, eq + 1);
-			return -EINVAL;
-		}
+static int ffs_fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct ffs_sb_fill_data *data = fc->fs_private;
+	struct fs_parse_result result;
+	int opt;
 
-		/* Interpret option */
-		switch (eq - opts) {
-		case 13:
-			if (!memcmp(opts, "no_disconnect", 13))
-				data->no_disconnect = !!value;
-			else
-				goto invalid;
-			break;
-		case 5:
-			if (!memcmp(opts, "rmode", 5))
-				data->root_mode  = (value & 0555) | S_IFDIR;
-			else if (!memcmp(opts, "fmode", 5))
-				data->perms.mode = (value & 0666) | S_IFREG;
-			else
-				goto invalid;
-			break;
+	ENTER();
 
-		case 4:
-			if (!memcmp(opts, "mode", 4)) {
-				data->root_mode  = (value & 0555) | S_IFDIR;
-				data->perms.mode = (value & 0666) | S_IFREG;
-			} else {
-				goto invalid;
-			}
-			break;
+	opt = fs_parse(fc, &ffs_fs_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
 
-		case 3:
-			if (!memcmp(opts, "uid", 3)) {
-				data->perms.uid = make_kuid(current_user_ns(), value);
-				if (!uid_valid(data->perms.uid)) {
-					pr_err("%s: unmapped value: %lu\n", opts, value);
-					return -EINVAL;
-				}
-			} else if (!memcmp(opts, "gid", 3)) {
-				data->perms.gid = make_kgid(current_user_ns(), value);
-				if (!gid_valid(data->perms.gid)) {
-					pr_err("%s: unmapped value: %lu\n", opts, value);
-					return -EINVAL;
-				}
-			} else {
-				goto invalid;
-			}
-			break;
+	switch (opt) {
+	case Opt_no_disconnect:
+		data->no_disconnect = result.boolean;
+		break;
+	case Opt_rmode:
+		data->root_mode  = (result.uint_32 & 0555) | S_IFDIR;
+		break;
+	case Opt_fmode:
+		data->perms.mode = (result.uint_32 & 0666) | S_IFREG;
+		break;
+	case Opt_mode:
+		data->root_mode  = (result.uint_32 & 0555) | S_IFDIR;
+		data->perms.mode = (result.uint_32 & 0666) | S_IFREG;
+		break;
 
-		default:
-invalid:
-			pr_err("%s: invalid option\n", opts);
-			return -EINVAL;
-		}
+	case Opt_uid:
+		data->perms.uid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(data->perms.uid))
+			goto unmapped_value;
+		break;
+	case Opt_gid:
+		data->perms.gid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(data->perms.gid))
+			goto unmapped_value;
+		break;
 
-		/* Next iteration */
-		if (!comma)
-			break;
-		opts = comma + 1;
+	default:
+		return -ENOPARAM;
 	}
 
 	return 0;
-}
 
-/* "mount -t functionfs dev_name /dev/function" ends up here */
+unmapped_value:
+	return invalf(fc, "%s: unmapped value: %u", param->key, result.uint_32);
+}
 
-static struct dentry *
-ffs_fs_mount(struct file_system_type *t, int flags,
-	      const char *dev_name, void *opts)
-{
-	struct ffs_sb_fill_data data = {
-		.perms = {
-			.mode = S_IFREG | 0600,
-			.uid = GLOBAL_ROOT_UID,
-			.gid = GLOBAL_ROOT_GID,
-		},
-		.root_mode = S_IFDIR | 0500,
-		.no_disconnect = false,
-	};
-	struct dentry *rv;
-	int ret;
+/*
+ * Set up the superblock for a mount.
+ */
+static int ffs_fs_get_tree(struct fs_context *fc)
+{
+	struct ffs_sb_fill_data *ctx = fc->fs_private;
 	void *ffs_dev;
 	struct ffs_data	*ffs;
 
 	ENTER();
 
-	ret = ffs_fs_parse_opts(&data, opts);
-	if (unlikely(ret < 0))
-		return ERR_PTR(ret);
+	if (!fc->source)
+		return invalf(fc, "No source specified");
 
-	ffs = ffs_data_new(dev_name);
+	ffs = ffs_data_new(fc->source);
 	if (unlikely(!ffs))
-		return ERR_PTR(-ENOMEM);
-	ffs->file_perms = data.perms;
-	ffs->no_disconnect = data.no_disconnect;
+		return -ENOMEM;
+	ffs->file_perms = ctx->perms;
+	ffs->no_disconnect = ctx->no_disconnect;
 
-	ffs->dev_name = kstrdup(dev_name, GFP_KERNEL);
+	ffs->dev_name = kstrdup(fc->source, GFP_KERNEL);
 	if (unlikely(!ffs->dev_name)) {
 		ffs_data_put(ffs);
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	}
 
-	ffs_dev = ffs_acquire_dev(dev_name);
+	ffs_dev = ffs_acquire_dev(ffs->dev_name);
 	if (IS_ERR(ffs_dev)) {
 		ffs_data_put(ffs);
-		return ERR_CAST(ffs_dev);
+		return PTR_ERR(ffs_dev);
 	}
+
 	ffs->private_data = ffs_dev;
-	data.ffs_data = ffs;
+	ctx->ffs_data = ffs;
+	return vfs_get_super(fc, vfs_get_independent_super, ffs_sb_fill);
+}
+
+static void ffs_fs_free_fc(struct fs_context *fc)
+{
+	struct ffs_sb_fill_data *ctx = fc->fs_private;
+
+	if (ctx) {
+		if (ctx->ffs_data) {
+			ffs_release_dev(ctx->ffs_data);
+			ffs_data_put(ctx->ffs_data);
+		}
 
-	rv = mount_nodev(t, flags, &data, ffs_sb_fill);
-	if (IS_ERR(rv) && data.ffs_data) {
-		ffs_release_dev(data.ffs_data);
-		ffs_data_put(data.ffs_data);
+		kfree(ctx);
 	}
-	return rv;
+}
+
+static const struct fs_context_operations ffs_fs_context_ops = {
+	.free		= ffs_fs_free_fc,
+	.parse_param	= ffs_fs_parse_param,
+	.get_tree	= ffs_fs_get_tree,
+};
+
+static int ffs_fs_init_fs_context(struct fs_context *fc)
+{
+	struct ffs_sb_fill_data *ctx;
+
+	ctx = kzalloc(sizeof(struct ffs_sb_fill_data), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->perms.mode = S_IFREG | 0600;
+	ctx->perms.uid = GLOBAL_ROOT_UID;
+	ctx->perms.gid = GLOBAL_ROOT_GID;
+	ctx->root_mode = S_IFDIR | 0500;
+	ctx->no_disconnect = false;
+
+	fc->fs_private = ctx;
+	fc->ops = &ffs_fs_context_ops;
+	return 0;
 }
 
 static void
@@ -1640,7 +1646,8 @@ ffs_fs_kill_sb(struct super_block *sb)
 static struct file_system_type ffs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "functionfs",
-	.mount		= ffs_fs_mount,
+	.init_fs_context = ffs_fs_init_fs_context,
+	.parameters	= &ffs_fs_fs_parameters,
 	.kill_sb	= ffs_fs_kill_sb,
 };
 MODULE_ALIAS_FS("functionfs");

