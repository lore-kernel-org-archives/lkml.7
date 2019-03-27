Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47A4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85472146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387681AbfC0Xqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:46:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44413 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731206AbfC0Xqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:46:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B41333087950;
        Wed, 27 Mar 2019 23:46:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E5A05C23E;
        Wed, 27 Mar 2019 23:46:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 49/68] vfs: Convert jffs2 to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:46:44 +0000
Message-ID: <155373040456.7602.12983604512303323486.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 27 Mar 2019 23:46:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the jffs2 filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: David Woodhouse <dwmw2@infradead.org>
cc: linux-mtd@lists.infradead.org
---

 fs/jffs2/fs.c       |   21 +++---
 fs/jffs2/os-linux.h |    4 +
 fs/jffs2/super.c    |  172 +++++++++++++++++++++++++--------------------------
 3 files changed, 96 insertions(+), 101 deletions(-)

diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index eab04eca95a3..d79734bd7650 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/cred.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
 #include <linux/list.h>
 #include <linux/mtd/mtd.h>
 #include <linux/pagemap.h>
@@ -184,7 +185,7 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 	if (ivalid & ATTR_SIZE && inode->i_size > iattr->ia_size) {
 		truncate_setsize(inode, iattr->ia_size);
 		inode->i_blocks = (inode->i_size + 511) >> 9;
-	}	
+	}
 
 	return 0;
 }
@@ -390,7 +391,7 @@ void jffs2_dirty_inode(struct inode *inode, int flags)
 	jffs2_do_setattr(inode, &iattr);
 }
 
-int jffs2_do_remount_fs(struct super_block *sb, int *flags, char *data)
+int jffs2_do_remount_fs(struct super_block *sb, struct fs_context *fc)
 {
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
 
@@ -408,10 +409,10 @@ int jffs2_do_remount_fs(struct super_block *sb, int *flags, char *data)
 		mutex_unlock(&c->alloc_sem);
 	}
 
-	if (!(*flags & SB_RDONLY))
+	if (!(fc->sb_flags & SB_RDONLY))
 		jffs2_start_garbage_collect_thread(c);
 
-	*flags |= SB_NOATIME;
+	fc->sb_flags |= SB_NOATIME;
 	return 0;
 }
 
@@ -508,7 +509,7 @@ static int calculate_inocache_hashsize(uint32_t flash_size)
 	return hashsize;
 }
 
-int jffs2_do_fill_super(struct super_block *sb, void *data, int silent)
+int jffs2_do_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct jffs2_sb_info *c;
 	struct inode *root_i;
@@ -523,11 +524,11 @@ int jffs2_do_fill_super(struct super_block *sb, void *data, int silent)
 
 #ifndef CONFIG_JFFS2_FS_WRITEBUFFER
 	if (c->mtd->type == MTD_NANDFLASH) {
-		pr_err("Cannot operate on NAND flash unless jffs2 NAND support is compiled in\n");
+		errorf(fc, "Cannot operate on NAND flash unless jffs2 NAND support is compiled in");
 		return -EINVAL;
 	}
 	if (c->mtd->type == MTD_DATAFLASH) {
-		pr_err("Cannot operate on DataFlash unless jffs2 DataFlash support is compiled in\n");
+		errorf(fc, "Cannot operate on DataFlash unless jffs2 DataFlash support is compiled in");
 		return -EINVAL;
 	}
 #endif
@@ -541,12 +542,12 @@ int jffs2_do_fill_super(struct super_block *sb, void *data, int silent)
 	 */
 	if ((c->sector_size * blocks) != c->flash_size) {
 		c->flash_size = c->sector_size * blocks;
-		pr_info("Flash size not aligned to erasesize, reducing to %dKiB\n",
-			c->flash_size / 1024);
+		infof(fc, "Flash size not aligned to erasesize, reducing to %dKiB",
+		      c->flash_size / 1024);
 	}
 
 	if (c->flash_size < 5*c->sector_size) {
-		pr_err("Too few erase blocks (%d)\n",
+		errorf(fc, "Too few erase blocks (%d)",
 		       c->flash_size / c->sector_size);
 		return -EINVAL;
 	}
diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index a2dbbb3f4c74..ac23ae5cdb54 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -172,8 +172,8 @@ void jffs2_dirty_inode(struct inode *inode, int flags);
 struct inode *jffs2_new_inode (struct inode *dir_i, umode_t mode,
 			       struct jffs2_raw_inode *ri);
 int jffs2_statfs (struct dentry *, struct kstatfs *);
-int jffs2_do_remount_fs(struct super_block *, int *, char *);
-int jffs2_do_fill_super(struct super_block *sb, void *data, int silent);
+int jffs2_do_remount_fs(struct super_block *sb, struct fs_context *fc);
+int jffs2_do_fill_super(struct super_block *sb, struct fs_context *fc);
 void jffs2_gc_release_inode(struct jffs2_sb_info *c,
 			    struct jffs2_inode_info *f);
 struct jffs2_inode_info *jffs2_gc_fetch_inode(struct jffs2_sb_info *c,
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index bb6ae387469f..69dcc4e0b243 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -19,7 +19,8 @@
 #include <linux/fs.h>
 #include <linux/err.h>
 #include <linux/mount.h>
-#include <linux/parser.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/jffs2.h>
 #include <linux/pagemap.h>
 #include <linux/mtd/super.h>
@@ -160,96 +161,77 @@ static const struct export_operations jffs2_export_ops = {
 /*
  * JFFS2 mount options.
  *
+ * Opt_source: The source device
  * Opt_override_compr: override default compressor
  * Opt_rp_size: size of reserved pool in KiB
- * Opt_err: just end of array marker
  */
 enum {
+	Opt_source,
 	Opt_override_compr,
 	Opt_rp_size,
-	Opt_err,
 };
 
-static const match_table_t tokens = {
-	{Opt_override_compr, "compr=%s"},
-	{Opt_rp_size, "rp_size=%u"},
-	{Opt_err, NULL},
+static const struct fs_parameter_spec jffs2_param_specs[] = {
+	fsparam_string	("source",	Opt_source),
+	fsparam_enum	("compr",	Opt_override_compr),
+	fsparam_u32	("rp_size",	Opt_rp_size),
+	{}
 };
 
-static int jffs2_parse_options(struct jffs2_sb_info *c, char *data)
-{
-	substring_t args[MAX_OPT_ARGS];
-	char *p, *name;
-	unsigned int opt;
-
-	if (!data)
-		return 0;
-
-	while ((p = strsep(&data, ","))) {
-		int token;
-
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_override_compr:
-			name = match_strdup(&args[0]);
-
-			if (!name)
-				return -ENOMEM;
-			if (!strcmp(name, "none"))
-				c->mount_opts.compr = JFFS2_COMPR_MODE_NONE;
+static const struct fs_parameter_enum jffs2_param_enums[] = {
+	{ Opt_override_compr,	"none",	JFFS2_COMPR_MODE_NONE },
 #ifdef CONFIG_JFFS2_LZO
-			else if (!strcmp(name, "lzo"))
-				c->mount_opts.compr = JFFS2_COMPR_MODE_FORCELZO;
+	{ Opt_override_compr,	"lzo",	JFFS2_COMPR_MODE_FORCELZO },
 #endif
 #ifdef CONFIG_JFFS2_ZLIB
-			else if (!strcmp(name, "zlib"))
-				c->mount_opts.compr =
-						JFFS2_COMPR_MODE_FORCEZLIB;
+	{ Opt_override_compr,	"zlib",	JFFS2_COMPR_MODE_FORCEZLIB },
 #endif
-			else {
-				pr_err("Error: unknown compressor \"%s\"\n",
-				       name);
-				kfree(name);
-				return -EINVAL;
-			}
-			kfree(name);
-			c->mount_opts.override_compr = true;
-			break;
-		case Opt_rp_size:
-			if (match_int(&args[0], &opt))
-				return -EINVAL;
-			opt *= 1024;
-			if (opt > c->mtd->size) {
-				pr_warn("Too large reserve pool specified, max "
-					"is %llu KB\n", c->mtd->size / 1024);
-				return -EINVAL;
-			}
-			c->mount_opts.rp_size = opt;
-			break;
-		default:
-			pr_err("Error: unrecognized mount option '%s' or missing value\n",
-			       p);
-			return -EINVAL;
-		}
+	{}
+};
+
+const struct fs_parameter_description jffs2_fs_parameters = {
+	.name		= "jffs2",
+	.specs		= jffs2_param_specs,
+	.enums		= jffs2_param_enums,
+};
+
+static int jffs2_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct fs_parse_result result;
+	struct jffs2_sb_info *c = fc->s_fs_info;
+	int opt;
+
+	opt = fs_parse(fc, &jffs2_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_override_compr:
+		c->mount_opts.compr = result.uint_32;
+		c->mount_opts.override_compr = true;
+		break;
+	case Opt_rp_size:
+		if (result.uint_32 > UINT_MAX / 1024)
+			return invalf(fc, "jffs2: rp_size unrepresentable");
+		opt = result.uint_32 * 1024;
+		if (opt > c->mtd->size)
+			return invalf(fc, "jffs2: Too large reserve pool specified, max is %llu KB",
+				      c->mtd->size / 1024);
+		c->mount_opts.rp_size = opt;
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	return 0;
 }
 
-static int jffs2_remount_fs(struct super_block *sb, int *flags, char *data)
+static int jffs2_reconfigure(struct fs_context *fc)
 {
-	struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
-	int err;
+	struct super_block *sb = fc->root->d_sb;
 
 	sync_filesystem(sb);
-	err = jffs2_parse_options(c, data);
-	if (err)
-		return -EINVAL;
-
-	return jffs2_do_remount_fs(sb, flags, data);
+	return jffs2_do_remount_fs(sb, fc);
 }
 
 static const struct super_operations jffs2_super_operations =
@@ -258,7 +240,6 @@ static const struct super_operations jffs2_super_operations =
 	.destroy_inode =jffs2_destroy_inode,
 	.put_super =	jffs2_put_super,
 	.statfs =	jffs2_statfs,
-	.remount_fs =	jffs2_remount_fs,
 	.evict_inode =	jffs2_evict_inode,
 	.dirty_inode =	jffs2_dirty_inode,
 	.show_options =	jffs2_show_options,
@@ -268,26 +249,16 @@ static const struct super_operations jffs2_super_operations =
 /*
  * fill in the superblock
  */
-static int jffs2_fill_super(struct super_block *sb, void *data, int silent)
+static int jffs2_fill_super(struct super_block *sb, struct fs_context *fc)
 {
-	struct jffs2_sb_info *c;
-	int ret;
+	struct jffs2_sb_info *c = sb->s_fs_info;
 
 	jffs2_dbg(1, "jffs2_get_sb_mtd():"
 		  " New superblock for device %d (\"%s\")\n",
 		  sb->s_mtd->index, sb->s_mtd->name);
 
-	c = kzalloc(sizeof(*c), GFP_KERNEL);
-	if (!c)
-		return -ENOMEM;
-
 	c->mtd = sb->s_mtd;
 	c->os_priv = sb;
-	sb->s_fs_info = c;
-
-	ret = jffs2_parse_options(c, data);
-	if (ret)
-		return -EINVAL;
 
 	/* Initialize JFFS2 superblock locks, the further initialization will
 	 * be done later */
@@ -305,15 +276,37 @@ static int jffs2_fill_super(struct super_block *sb, void *data, int silent)
 #ifdef CONFIG_JFFS2_FS_POSIX_ACL
 	sb->s_flags |= SB_POSIXACL;
 #endif
-	ret = jffs2_do_fill_super(sb, data, silent);
-	return ret;
+	return jffs2_do_fill_super(sb, fc);
 }
 
-static struct dentry *jffs2_mount(struct file_system_type *fs_type,
-			int flags, const char *dev_name,
-			void *data)
+static int jffs2_get_tree(struct fs_context *fc)
 {
-	return mount_mtd(fs_type, flags, dev_name, data, jffs2_fill_super);
+	return vfs_get_mtd_super(fc, jffs2_fill_super);
+}
+
+static void jffs2_free_fc(struct fs_context *fc)
+{
+	kfree(fc->s_fs_info);
+}
+
+static const struct fs_context_operations jffs2_context_ops = {
+	.free		= jffs2_free_fc,
+	.parse_param	= jffs2_parse_param,
+	.get_tree	= jffs2_get_tree,
+	.reconfigure	= jffs2_reconfigure,
+};
+
+static int jffs2_init_fs_context(struct fs_context *fc)
+{
+	struct jffs2_sb_info *ctx;
+
+	ctx = kzalloc(sizeof(struct jffs2_sb_info), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	fc->s_fs_info = ctx;
+	fc->ops = &jffs2_context_ops;
+	return 0;
 }
 
 static void jffs2_put_super (struct super_block *sb)
@@ -350,7 +343,8 @@ static void jffs2_kill_sb(struct super_block *sb)
 static struct file_system_type jffs2_fs_type = {
 	.owner =	THIS_MODULE,
 	.name =		"jffs2",
-	.mount =	jffs2_mount,
+	.init_fs_context = jffs2_init_fs_context,
+	.parameters =	&jffs2_fs_parameters,
 	.kill_sb =	jffs2_kill_sb,
 };
 MODULE_ALIAS_FS("jffs2");

