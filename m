Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6CAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DD5204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387834AbfC0XtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:49:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbfC0Xs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:48:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 86A14A971A;
        Wed, 27 Mar 2019 23:48:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABEE81092001;
        Wed, 27 Mar 2019 23:48:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 66/68] vfs: Convert ubifs to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:48:56 +0000
Message-ID: <155373053689.7602.13296695814557418043.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 27 Mar 2019 23:48:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ubifs filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Richard Weinberger <richard@nod.at>
cc: Artem Bityutskiy <dedekind1@gmail.com>
cc: Adrian Hunter <adrian.hunter@intel.com>
cc: linux-mtd@lists.infradead.org
---

 fs/ubifs/super.c |  447 ++++++++++++++++++++++++------------------------------
 1 file changed, 200 insertions(+), 247 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 8dc2818fdd84..e77ad4dd2665 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -31,9 +31,9 @@
 #include <linux/module.h>
 #include <linux/ctype.h>
 #include <linux/kthread.h>
-#include <linux/parser.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/seq_file.h>
-#include <linux/mount.h>
 #include <linux/math64.h>
 #include <linux/writeback.h>
 #include "ubifs.h"
@@ -935,7 +935,7 @@ static int check_volume_empty(struct ubifs_info *c)
  * Opt_no_bulk_read: disable bulk-reads
  * Opt_chk_data_crc: check CRCs when reading data nodes
  * Opt_no_chk_data_crc: do not check CRCs when reading data nodes
- * Opt_override_compr: override default compressor
+ * Opt_compr: override default compressor
  * Opt_assert: set ubifs_assert() action
  * Opt_auth_key: The key name used for authentication
  * Opt_auth_hash_name: The hash type used for authentication
@@ -948,54 +948,47 @@ enum {
 	Opt_no_bulk_read,
 	Opt_chk_data_crc,
 	Opt_no_chk_data_crc,
-	Opt_override_compr,
+	Opt_compr,
 	Opt_assert,
 	Opt_auth_key,
 	Opt_auth_hash_name,
 	Opt_ignore,
-	Opt_err,
 };
 
-static const match_table_t tokens = {
-	{Opt_fast_unmount, "fast_unmount"},
-	{Opt_norm_unmount, "norm_unmount"},
-	{Opt_bulk_read, "bulk_read"},
-	{Opt_no_bulk_read, "no_bulk_read"},
-	{Opt_chk_data_crc, "chk_data_crc"},
-	{Opt_no_chk_data_crc, "no_chk_data_crc"},
-	{Opt_override_compr, "compr=%s"},
-	{Opt_auth_key, "auth_key=%s"},
-	{Opt_auth_hash_name, "auth_hash_name=%s"},
-	{Opt_ignore, "ubi=%s"},
-	{Opt_ignore, "vol=%s"},
-	{Opt_assert, "assert=%s"},
-	{Opt_err, NULL},
+static const struct fs_parameter_spec ubifs_param_specs[] = {
+	fsparam_flag	("fast_unmount",		Opt_fast_unmount),
+	fsparam_flag	("norm_unmount",		Opt_norm_unmount),
+	fsparam_flag	("bulk_read",			Opt_bulk_read),
+	fsparam_flag	("no_bulk_read",		Opt_no_bulk_read),
+	fsparam_flag	("chk_data_crc",		Opt_chk_data_crc),
+	fsparam_flag	("no_chk_data_crc",		Opt_no_chk_data_crc),
+	fsparam_enum	("compr",			Opt_compr),
+	fsparam_enum	("assert",			Opt_assert),
+	fsparam_string	("auth_key",			Opt_auth_key),
+	fsparam_string	("auth_hash_name",		Opt_auth_hash_name),
+	fsparam_string	("ubi",				Opt_ignore),
+	fsparam_string	("vol",				Opt_ignore),
+	{}
 };
 
-/**
- * parse_standard_option - parse a standard mount option.
- * @option: the option to parse
- *
- * Normally, standard mount options like "sync" are passed to file-systems as
- * flags. However, when a "rootflags=" kernel boot parameter is used, they may
- * be present in the options string. This function tries to deal with this
- * situation and parse standard options. Returns 0 if the option was not
- * recognized, and the corresponding integer flag if it was.
- *
- * UBIFS is only interested in the "sync" option, so do not check for anything
- * else.
- */
-static int parse_standard_option(const char *option)
-{
+static const struct fs_parameter_enum ubifs_param_enums[] = {
+	{ Opt_compr,	"none",		UBIFS_COMPR_NONE },
+	{ Opt_compr,	"lzo",		UBIFS_COMPR_LZO },
+	{ Opt_compr,	"zlib",		UBIFS_COMPR_ZLIB },
+	{ Opt_assert,	"report",	ASSACT_REPORT },
+	{ Opt_assert,	"read-only",	ASSACT_RO },
+	{ Opt_assert,	"panic",	ASSACT_PANIC },
+	{}
+};
 
-	pr_notice("UBIFS: parse %s\n", option);
-	if (!strcmp(option, "sync"))
-		return SB_SYNCHRONOUS;
-	return 0;
-}
+static const struct fs_parameter_description ubifs_fs_parameters = {
+	.name		= "ubifs",
+	.specs		= ubifs_param_specs,
+	.enums		= ubifs_param_enums,
+};
 
 /**
- * ubifs_parse_options - parse mount parameters.
+ * ubifs_parse_param - parse a parameter.
  * @c: UBIFS file-system description object
  * @options: parameters to parse
  * @is_remount: non-zero if this is FS re-mount
@@ -1003,119 +996,64 @@ static int parse_standard_option(const char *option)
  * This function parses UBIFS mount options and returns zero in case success
  * and a negative error code in case of failure.
  */
-static int ubifs_parse_options(struct ubifs_info *c, char *options,
-			       int is_remount)
+static int ubifs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	char *p;
-	substring_t args[MAX_OPT_ARGS];
-
-	if (!options)
-		return 0;
-
-	while ((p = strsep(&options, ","))) {
-		int token;
+	struct ubifs_info *c = fc->s_fs_info;
+	struct fs_parse_result result;
+	int opt;
 
-		if (!*p)
-			continue;
+	opt = fs_parse(fc, &ubifs_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
 
-		token = match_token(p, tokens, args);
-		switch (token) {
+	switch (opt) {
 		/*
 		 * %Opt_fast_unmount and %Opt_norm_unmount options are ignored.
 		 * We accept them in order to be backward-compatible. But this
 		 * should be removed at some point.
 		 */
-		case Opt_fast_unmount:
-			c->mount_opts.unmount_mode = 2;
-			break;
-		case Opt_norm_unmount:
-			c->mount_opts.unmount_mode = 1;
-			break;
-		case Opt_bulk_read:
-			c->mount_opts.bulk_read = 2;
-			c->bulk_read = 1;
-			break;
-		case Opt_no_bulk_read:
-			c->mount_opts.bulk_read = 1;
-			c->bulk_read = 0;
-			break;
-		case Opt_chk_data_crc:
-			c->mount_opts.chk_data_crc = 2;
-			c->no_chk_data_crc = 0;
-			break;
-		case Opt_no_chk_data_crc:
-			c->mount_opts.chk_data_crc = 1;
-			c->no_chk_data_crc = 1;
-			break;
-		case Opt_override_compr:
-		{
-			char *name = match_strdup(&args[0]);
-
-			if (!name)
-				return -ENOMEM;
-			if (!strcmp(name, "none"))
-				c->mount_opts.compr_type = UBIFS_COMPR_NONE;
-			else if (!strcmp(name, "lzo"))
-				c->mount_opts.compr_type = UBIFS_COMPR_LZO;
-			else if (!strcmp(name, "zlib"))
-				c->mount_opts.compr_type = UBIFS_COMPR_ZLIB;
-			else {
-				ubifs_err(c, "unknown compressor \"%s\"", name); //FIXME: is c ready?
-				kfree(name);
-				return -EINVAL;
-			}
-			kfree(name);
-			c->mount_opts.override_compr = 1;
-			c->default_compr = c->mount_opts.compr_type;
-			break;
-		}
-		case Opt_assert:
-		{
-			char *act = match_strdup(&args[0]);
-
-			if (!act)
-				return -ENOMEM;
-			if (!strcmp(act, "report"))
-				c->assert_action = ASSACT_REPORT;
-			else if (!strcmp(act, "read-only"))
-				c->assert_action = ASSACT_RO;
-			else if (!strcmp(act, "panic"))
-				c->assert_action = ASSACT_PANIC;
-			else {
-				ubifs_err(c, "unknown assert action \"%s\"", act);
-				kfree(act);
-				return -EINVAL;
-			}
-			kfree(act);
-			break;
-		}
-		case Opt_auth_key:
-			c->auth_key_name = kstrdup(args[0].from, GFP_KERNEL);
-			if (!c->auth_key_name)
-				return -ENOMEM;
-			break;
-		case Opt_auth_hash_name:
-			c->auth_hash_name = kstrdup(args[0].from, GFP_KERNEL);
-			if (!c->auth_hash_name)
-				return -ENOMEM;
-			break;
-		case Opt_ignore:
-			break;
-		default:
-		{
-			unsigned long flag;
-			struct super_block *sb = c->vfs_sb;
-
-			flag = parse_standard_option(p);
-			if (!flag) {
-				ubifs_err(c, "unrecognized mount option \"%s\" or missing value",
-					  p);
-				return -EINVAL;
-			}
-			sb->s_flags |= flag;
-			break;
-		}
-		}
+	case Opt_fast_unmount:
+		c->mount_opts.unmount_mode = 2;
+		break;
+	case Opt_norm_unmount:
+		c->mount_opts.unmount_mode = 1;
+		break;
+	case Opt_bulk_read:
+		c->mount_opts.bulk_read = 2;
+		c->bulk_read = 1;
+		break;
+	case Opt_no_bulk_read:
+		c->mount_opts.bulk_read = 1;
+		c->bulk_read = 0;
+		break;
+	case Opt_chk_data_crc:
+		c->mount_opts.chk_data_crc = 2;
+		c->no_chk_data_crc = 0;
+		break;
+	case Opt_no_chk_data_crc:
+		c->mount_opts.chk_data_crc = 1;
+		c->no_chk_data_crc = 1;
+		break;
+	case Opt_compr:
+		c->mount_opts.compr_type = result.uint_32;
+		c->mount_opts.override_compr = 1;
+		c->default_compr = c->mount_opts.compr_type;
+		break;
+	case Opt_assert:
+		c->assert_action = result.uint_32;
+		break;
+	case Opt_auth_key:
+		kfree(c->auth_key_name);
+		c->auth_key_name = param->string;
+		param->string = NULL;
+		break;
+	case Opt_auth_hash_name:
+		kfree(c->auth_hash_name);
+		c->auth_hash_name = param->string;
+		param->string = NULL;
+		break;
+	case Opt_ignore:
+		break;
 	}
 
 	return 0;
@@ -1927,21 +1865,30 @@ static void ubifs_put_super(struct super_block *sb)
 	mutex_unlock(&c->umount_mutex);
 }
 
-static int ubifs_remount_fs(struct super_block *sb, int *flags, char *data)
+static int ubifs_reconfigure(struct fs_context *fc)
 {
+	struct super_block *sb = fc->root->d_sb;
 	int err;
 	struct ubifs_info *c = sb->s_fs_info;
+	struct ubifs_info *reconf = fc->s_fs_info;
 
 	sync_filesystem(sb);
-	dbg_gen("old flags %#lx, new flags %#x", sb->s_flags, *flags);
+	dbg_gen("old flags %#lx, new flags %#x", sb->s_flags, fc->sb_flags);
 
-	err = ubifs_parse_options(c, data, 1);
-	if (err) {
-		ubifs_err(c, "invalid or unknown remount parameter");
-		return err;
-	}
+	/* Apply the mount option changes.
+	 *
+	 * [!] NOTE Replacing the auth_key_name and auth_hash_name is
+	 *     very dodgy without locking.  Previously it just leaked
+	 *     the old strings.  The strings only seem to be used
+	 *     during mounting, so don't reconfigure those.
+	 */
+	c->mount_opts		= reconf->mount_opts;
+	c->bulk_read		= reconf->bulk_read;
+	c->no_chk_data_crc	= reconf->no_chk_data_crc;
+	c->default_compr	= reconf->default_compr;
+	c->assert_action	= reconf->assert_action;
 
-	if (c->ro_mount && !(*flags & SB_RDONLY)) {
+	if (c->ro_mount && !(fc->sb_flags & SB_RDONLY)) {
 		if (c->ro_error) {
 			ubifs_msg(c, "cannot re-mount R/W due to prior errors");
 			return -EROFS;
@@ -1953,7 +1900,7 @@ static int ubifs_remount_fs(struct super_block *sb, int *flags, char *data)
 		err = ubifs_remount_rw(c);
 		if (err)
 			return err;
-	} else if (!c->ro_mount && (*flags & SB_RDONLY)) {
+	} else if (!c->ro_mount && (fc->sb_flags & SB_RDONLY)) {
 		if (c->ro_error) {
 			ubifs_msg(c, "cannot re-mount R/O due to prior errors");
 			return -EROFS;
@@ -1985,14 +1932,13 @@ const struct super_operations ubifs_super_operations = {
 	.evict_inode   = ubifs_evict_inode,
 	.statfs        = ubifs_statfs,
 	.dirty_inode   = ubifs_dirty_inode,
-	.remount_fs    = ubifs_remount_fs,
 	.show_options  = ubifs_show_options,
 	.sync_fs       = ubifs_sync_fs,
 };
 
 /**
  * open_ubi - parse UBI device name string and open the UBI device.
- * @name: UBI volume name
+ * @fc: The filesystem parameters
  * @mode: UBI volume open mode
  *
  * The primary method of mounting UBIFS is by specifying the UBI volume
@@ -2009,15 +1955,13 @@ const struct super_operations ubifs_super_operations = {
  * returns UBI volume description object in case of success and a negative
  * error code in case of failure.
  */
-static struct ubi_volume_desc *open_ubi(const char *name, int mode)
+static struct ubi_volume_desc *open_ubi(struct fs_context *fc, int mode)
 {
 	struct ubi_volume_desc *ubi;
+	const char *name = fc->source;
 	int dev, vol;
 	char *endptr;
 
-	if (!name || !*name)
-		return ERR_PTR(-EINVAL);
-
 	/* First, try to open using the device node path method */
 	ubi = ubi_open_volume_path(name, mode);
 	if (!IS_ERR(ubi))
@@ -2025,14 +1969,14 @@ static struct ubi_volume_desc *open_ubi(const char *name, int mode)
 
 	/* Try the "nodev" method */
 	if (name[0] != 'u' || name[1] != 'b' || name[2] != 'i')
-		return ERR_PTR(-EINVAL);
+		goto invalid_source;
 
 	/* ubi:NAME method */
 	if ((name[3] == ':' || name[3] == '!') && name[4] != '\0')
 		return ubi_open_volume_nm(0, name + 4, mode);
 
 	if (!isdigit(name[3]))
-		return ERR_PTR(-EINVAL);
+		goto invalid_source;
 
 	dev = simple_strtoul(name + 3, &endptr, 0);
 
@@ -2044,7 +1988,7 @@ static struct ubi_volume_desc *open_ubi(const char *name, int mode)
 	if (*endptr == '_' && isdigit(endptr[1])) {
 		vol = simple_strtoul(endptr + 1, &endptr, 0);
 		if (*endptr != '\0')
-			return ERR_PTR(-EINVAL);
+			goto invalid_source;
 		return ubi_open_volume(dev, vol, mode);
 	}
 
@@ -2052,57 +1996,11 @@ static struct ubi_volume_desc *open_ubi(const char *name, int mode)
 	if ((*endptr == ':' || *endptr == '!') && endptr[1] != '\0')
 		return ubi_open_volume_nm(dev, ++endptr, mode);
 
-	return ERR_PTR(-EINVAL);
-}
-
-static struct ubifs_info *alloc_ubifs_info(struct ubi_volume_desc *ubi)
-{
-	struct ubifs_info *c;
-
-	c = kzalloc(sizeof(struct ubifs_info), GFP_KERNEL);
-	if (c) {
-		spin_lock_init(&c->cnt_lock);
-		spin_lock_init(&c->cs_lock);
-		spin_lock_init(&c->buds_lock);
-		spin_lock_init(&c->space_lock);
-		spin_lock_init(&c->orphan_lock);
-		init_rwsem(&c->commit_sem);
-		mutex_init(&c->lp_mutex);
-		mutex_init(&c->tnc_mutex);
-		mutex_init(&c->log_mutex);
-		mutex_init(&c->umount_mutex);
-		mutex_init(&c->bu_mutex);
-		mutex_init(&c->write_reserve_mutex);
-		init_waitqueue_head(&c->cmt_wq);
-		c->buds = RB_ROOT;
-		c->old_idx = RB_ROOT;
-		c->size_tree = RB_ROOT;
-		c->orph_tree = RB_ROOT;
-		INIT_LIST_HEAD(&c->infos_list);
-		INIT_LIST_HEAD(&c->idx_gc);
-		INIT_LIST_HEAD(&c->replay_list);
-		INIT_LIST_HEAD(&c->replay_buds);
-		INIT_LIST_HEAD(&c->uncat_list);
-		INIT_LIST_HEAD(&c->empty_list);
-		INIT_LIST_HEAD(&c->freeable_list);
-		INIT_LIST_HEAD(&c->frdi_idx_list);
-		INIT_LIST_HEAD(&c->unclean_leb_list);
-		INIT_LIST_HEAD(&c->old_buds);
-		INIT_LIST_HEAD(&c->orph_list);
-		INIT_LIST_HEAD(&c->orph_new);
-		c->no_chk_data_crc = 1;
-		c->assert_action = ASSACT_RO;
-
-		c->highest_inum = UBIFS_FIRST_INO;
-		c->lhead_lnum = c->ltail_lnum = UBIFS_LOG_LNUM;
-
-		ubi_get_volume_info(ubi, &c->vi);
-		ubi_get_device_info(c->vi.ubi_num, &c->di);
-	}
-	return c;
+invalid_source:
+	return ERR_PTR(invalf(fc, "Invalid source name"));
 }
 
-static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
+static int ubifs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct ubifs_info *c = sb->s_fs_info;
 	struct inode *root;
@@ -2116,10 +2014,6 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
 		goto out;
 	}
 
-	err = ubifs_parse_options(c, data, 0);
-	if (err)
-		goto out_close;
-
 	/*
 	 * UBIFS provides 'backing_dev_info' in order to disable read-ahead. For
 	 * UBIFS, I/O is not deferred, it is done immediately in readpage,
@@ -2183,69 +2077,61 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
 	return err;
 }
 
-static int sb_test(struct super_block *sb, void *data)
+static int sb_test(struct super_block *sb, struct fs_context *fc)
 {
-	struct ubifs_info *c1 = data;
+	struct ubifs_info *c1 = fc->s_fs_info;
 	struct ubifs_info *c = sb->s_fs_info;
 
 	return c->vi.cdev == c1->vi.cdev;
 }
 
-static int sb_set(struct super_block *sb, void *data)
-{
-	sb->s_fs_info = data;
-	return set_anon_super(sb, NULL);
-}
-
-static struct dentry *ubifs_mount(struct file_system_type *fs_type, int flags,
-			const char *name, void *data)
+static int ubifs_get_tree(struct fs_context *fc)
 {
 	struct ubi_volume_desc *ubi;
-	struct ubifs_info *c;
+	struct ubifs_info *c = fc->s_fs_info;
 	struct super_block *sb;
 	int err;
 
-	dbg_gen("name %s, flags %#x", name, flags);
+	if (!fc->source || !*fc->source)
+		return invalf(fc, "No source specified");
+
+	dbg_gen("name %s, flags %#x", fc->source, fc->sb_flags);
 
 	/*
 	 * Get UBI device number and volume ID. Mount it read-only so far
 	 * because this might be a new mount point, and UBI allows only one
 	 * read-write user at a time.
 	 */
-	ubi = open_ubi(name, UBI_READONLY);
+	ubi = open_ubi(fc, UBI_READONLY);
 	if (IS_ERR(ubi)) {
-		if (!(flags & SB_SILENT))
-			pr_err("UBIFS error (pid: %d): cannot open \"%s\", error %d",
-			       current->pid, name, (int)PTR_ERR(ubi));
-		return ERR_CAST(ubi);
+		err = PTR_ERR(ubi);
+		if (!(fc->sb_flags & SB_SILENT))
+			errorf(fc, "UBIFS error (pid: %d): cannot open \"%s\", error %d",
+			       current->pid, fc->source, err);
+		return err;
 	}
 
-	c = alloc_ubifs_info(ubi);
-	if (!c) {
-		err = -ENOMEM;
-		goto out_close;
-	}
+	ubi_get_volume_info(ubi, &c->vi);
+	ubi_get_device_info(c->vi.ubi_num, &c->di);
 
 	dbg_gen("opened ubi%d_%d", c->vi.ubi_num, c->vi.vol_id);
 
-	sb = sget(fs_type, sb_test, sb_set, flags, c);
+	sb = sget_fc(fc, sb_test, set_anon_super_fc);
 	if (IS_ERR(sb)) {
 		err = PTR_ERR(sb);
-		kfree(c);
 		goto out_close;
 	}
 
 	if (sb->s_root) {
-		struct ubifs_info *c1 = sb->s_fs_info;
-		kfree(c);
 		/* A new mount point for already mounted UBIFS */
+		c = sb->s_fs_info;
 		dbg_gen("this ubi volume is already mounted");
-		if (!!(flags & SB_RDONLY) != c1->ro_mount) {
+		if (!!(fc->sb_flags & SB_RDONLY) != c->ro_mount) {
 			err = -EBUSY;
 			goto out_deact;
 		}
 	} else {
-		err = ubifs_fill_super(sb, data, flags & SB_SILENT ? 1 : 0);
+		err = ubifs_fill_super(sb, fc);
 		if (err)
 			goto out_deact;
 		/* We do not support atime */
@@ -2260,13 +2146,79 @@ static struct dentry *ubifs_mount(struct file_system_type *fs_type, int flags,
 	/* 'fill_super()' opens ubi again so we must close it here */
 	ubi_close_volume(ubi);
 
-	return dget(sb->s_root);
+	fc->root = dget(sb->s_root);
+	return 0;
 
 out_deact:
 	deactivate_locked_super(sb);
 out_close:
 	ubi_close_volume(ubi);
-	return ERR_PTR(err);
+	return err;
+}
+
+static void ubifs_free_fc(struct fs_context *fc)
+{
+	struct ubifs_info *c = fc->s_fs_info;
+
+	if (c) {
+		kfree(c->auth_key_name);
+		kfree(c->auth_hash_name);
+		kfree(c);
+	}
+}
+
+static const struct fs_context_operations ubifs_context_ops = {
+	.free		= ubifs_free_fc,
+	.parse_param	= ubifs_parse_param,
+	.get_tree	= ubifs_get_tree,
+	.reconfigure	= ubifs_reconfigure,
+};
+
+static int ubifs_init_fs_context(struct fs_context *fc)
+{
+	struct ubifs_info *c;
+
+	c = kzalloc(sizeof(struct ubifs_info), GFP_KERNEL);
+	if (!c)
+		return -ENOMEM;
+
+	spin_lock_init(&c->cnt_lock);
+	spin_lock_init(&c->cs_lock);
+	spin_lock_init(&c->buds_lock);
+	spin_lock_init(&c->space_lock);
+	spin_lock_init(&c->orphan_lock);
+	init_rwsem(&c->commit_sem);
+	mutex_init(&c->lp_mutex);
+	mutex_init(&c->tnc_mutex);
+	mutex_init(&c->log_mutex);
+	mutex_init(&c->umount_mutex);
+	mutex_init(&c->bu_mutex);
+	mutex_init(&c->write_reserve_mutex);
+	init_waitqueue_head(&c->cmt_wq);
+	c->buds = RB_ROOT;
+	c->old_idx = RB_ROOT;
+	c->size_tree = RB_ROOT;
+	c->orph_tree = RB_ROOT;
+	INIT_LIST_HEAD(&c->infos_list);
+	INIT_LIST_HEAD(&c->idx_gc);
+	INIT_LIST_HEAD(&c->replay_list);
+	INIT_LIST_HEAD(&c->replay_buds);
+	INIT_LIST_HEAD(&c->uncat_list);
+	INIT_LIST_HEAD(&c->empty_list);
+	INIT_LIST_HEAD(&c->freeable_list);
+	INIT_LIST_HEAD(&c->frdi_idx_list);
+	INIT_LIST_HEAD(&c->unclean_leb_list);
+	INIT_LIST_HEAD(&c->old_buds);
+	INIT_LIST_HEAD(&c->orph_list);
+	INIT_LIST_HEAD(&c->orph_new);
+	c->no_chk_data_crc = 1;
+	c->assert_action = ASSACT_RO;
+	c->highest_inum = UBIFS_FIRST_INO;
+	c->lhead_lnum = c->ltail_lnum = UBIFS_LOG_LNUM;
+
+	fc->s_fs_info = c;
+	fc->ops = &ubifs_context_ops;
+	return 0;
 }
 
 static void kill_ubifs_super(struct super_block *s)
@@ -2279,7 +2231,8 @@ static void kill_ubifs_super(struct super_block *s)
 static struct file_system_type ubifs_fs_type = {
 	.name    = "ubifs",
 	.owner   = THIS_MODULE,
-	.mount   = ubifs_mount,
+	.init_fs_context = ubifs_init_fs_context,
+	.parameters	= &ubifs_fs_parameters,
 	.kill_sb = kill_ubifs_super,
 };
 MODULE_ALIAS_FS("ubifs");

