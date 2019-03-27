Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB891C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7739E20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387822AbfC0Xsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:48:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbfC0Xso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:48:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A4C6C05242C;
        Wed, 27 Mar 2019 23:48:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FFDF19C5A;
        Wed, 27 Mar 2019 23:48:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 64/68] vfs: Convert devpts to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:48:41 +0000
Message-ID: <155373052127.7602.17325161039679063335.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 27 Mar 2019 23:48:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the devpts filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Christian Brauner <christian.brauner@ubuntu.com>
---

 fs/devpts/inode.c |  265 +++++++++++++++++++++++++----------------------------
 1 file changed, 124 insertions(+), 141 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 553a3f3300ae..ed4a49012570 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -15,6 +15,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/sched.h>
 #include <linux/namei.h>
 #include <linux/slab.h>
@@ -24,7 +26,6 @@
 #include <linux/magic.h>
 #include <linux/idr.h>
 #include <linux/devpts_fs.h>
-#include <linux/parser.h>
 #include <linux/fsnotify.h>
 #include <linux/seq_file.h>
 
@@ -109,14 +110,19 @@ enum {
 	Opt_err
 };
 
-static const match_table_t tokens = {
-	{Opt_uid, "uid=%u"},
-	{Opt_gid, "gid=%u"},
-	{Opt_mode, "mode=%o"},
-	{Opt_ptmxmode, "ptmxmode=%o"},
-	{Opt_newinstance, "newinstance"},
-	{Opt_max, "max=%d"},
-	{Opt_err, NULL}
+static const struct fs_parameter_spec devpts_param_specs[] = {
+	fsparam_u32	("gid",		Opt_gid),
+	fsparam_s32	("max",		Opt_max),
+	fsparam_u32oct	("mode",	Opt_mode),
+	fsparam_flag	("newinstance",	Opt_newinstance),
+	fsparam_u32oct	("ptmxmode",	Opt_ptmxmode),
+	fsparam_u32	("uid",		Opt_uid),
+	{}
+};
+
+static const struct fs_parameter_description devpts_fs_parameters = {
+	.name		= "devpts",
+	.specs		= devpts_param_specs,
 };
 
 struct pts_fs_info {
@@ -236,93 +242,56 @@ void devpts_release(struct pts_fs_info *fsi)
 	deactivate_super(fsi->sb);
 }
 
-#define PARSE_MOUNT	0
-#define PARSE_REMOUNT	1
-
 /*
- * parse_mount_options():
- *	Set @opts to mount options specified in @data. If an option is not
- *	specified in @data, set it to its default value.
- *
- * Note: @data may be NULL (in which case all options are set to default).
+ * devpts_parse_param - Parse mount parameters
  */
-static int parse_mount_options(char *data, int op, struct pts_mount_opts *opts)
+static int devpts_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	char *p;
+	struct pts_fs_info *fsi = fc->s_fs_info;
+	struct pts_mount_opts *opts = &fsi->mount_opts;
+	struct fs_parse_result result;
 	kuid_t uid;
 	kgid_t gid;
-
-	opts->setuid  = 0;
-	opts->setgid  = 0;
-	opts->uid     = GLOBAL_ROOT_UID;
-	opts->gid     = GLOBAL_ROOT_GID;
-	opts->mode    = DEVPTS_DEFAULT_MODE;
-	opts->ptmxmode = DEVPTS_DEFAULT_PTMX_MODE;
-	opts->max     = NR_UNIX98_PTY_MAX;
-
-	/* Only allow instances mounted from the initial mount
-	 * namespace to tap the reserve pool of ptys.
-	 */
-	if (op == PARSE_MOUNT)
-		opts->reserve =
-			(current->nsproxy->mnt_ns == init_task.nsproxy->mnt_ns);
-
-	while ((p = strsep(&data, ",")) != NULL) {
-		substring_t args[MAX_OPT_ARGS];
-		int token;
-		int option;
-
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_uid:
-			if (match_int(&args[0], &option))
-				return -EINVAL;
-			uid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(uid))
-				return -EINVAL;
-			opts->uid = uid;
-			opts->setuid = 1;
-			break;
-		case Opt_gid:
-			if (match_int(&args[0], &option))
-				return -EINVAL;
-			gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(gid))
-				return -EINVAL;
-			opts->gid = gid;
-			opts->setgid = 1;
-			break;
-		case Opt_mode:
-			if (match_octal(&args[0], &option))
-				return -EINVAL;
-			opts->mode = option & S_IALLUGO;
-			break;
-		case Opt_ptmxmode:
-			if (match_octal(&args[0], &option))
-				return -EINVAL;
-			opts->ptmxmode = option & S_IALLUGO;
-			break;
-		case Opt_newinstance:
-			break;
-		case Opt_max:
-			if (match_int(&args[0], &option) ||
-			    option < 0 || option > NR_UNIX98_PTY_MAX)
-				return -EINVAL;
-			opts->max = option;
-			break;
-		default:
-			pr_err("called with bogus options\n");
-			return -EINVAL;
-		}
+	int opt;
+
+	opt = fs_parse(fc, &devpts_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_uid:
+		uid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(uid))
+			return invalf(fc, "Unknown uid");
+		opts->uid = uid;
+		opts->setuid = 1;
+		break;
+	case Opt_gid:
+		gid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(gid))
+			return invalf(fc, "Unknown gid");
+		opts->gid = gid;
+		opts->setgid = 1;
+		break;
+	case Opt_mode:
+		opts->mode = result.uint_32 & S_IALLUGO;
+		break;
+	case Opt_ptmxmode:
+		opts->ptmxmode = result.uint_32 & S_IALLUGO;
+		break;
+	case Opt_newinstance:
+		break;
+	case Opt_max:
+		if (result.uint_32 > NR_UNIX98_PTY_MAX)
+			return invalf(fc, "max out of range");
+		opts->max = result.uint_32;
+		break;
 	}
 
 	return 0;
 }
 
-static int mknod_ptmx(struct super_block *sb)
+static int mknod_ptmx(struct super_block *sb, struct fs_context *fc)
 {
 	int mode;
 	int rc = -ENOMEM;
@@ -344,7 +313,7 @@ static int mknod_ptmx(struct super_block *sb)
 
 	dentry = d_alloc_name(root, "ptmx");
 	if (!dentry) {
-		pr_err("Unable to alloc dentry for ptmx node\n");
+		errorf(fc, "Unable to alloc dentry for ptmx node\n");
 		goto out;
 	}
 
@@ -353,7 +322,7 @@ static int mknod_ptmx(struct super_block *sb)
 	 */
 	inode = new_inode(sb);
 	if (!inode) {
-		pr_err("Unable to alloc inode for ptmx node\n");
+		errorf(fc, "Unable to alloc inode for ptmx node\n");
 		dput(dentry);
 		goto out;
 	}
@@ -384,13 +353,23 @@ static void update_ptmx_mode(struct pts_fs_info *fsi)
 	}
 }
 
-static int devpts_remount(struct super_block *sb, int *flags, char *data)
+static int devpts_reconfigure(struct fs_context *fc)
 {
-	int err;
-	struct pts_fs_info *fsi = DEVPTS_SB(sb);
-	struct pts_mount_opts *opts = &fsi->mount_opts;
+	struct pts_fs_info *fsi = DEVPTS_SB(fc->root->d_sb);
+	struct pts_fs_info *new = fc->s_fs_info;
 
-	err = parse_mount_options(data, PARSE_REMOUNT, opts);
+	/* Apply the revised options.  We don't want to change ->reserve.
+	 * Ideally, we'd update each option conditionally on it having being
+	 * explicitly changed, but the default is to reset everything so that
+	 * would break UAPI...
+	 */
+	fsi->mount_opts.setuid		= new->mount_opts.setuid;
+	fsi->mount_opts.setgid		= new->mount_opts.setgid;
+	fsi->mount_opts.uid		= new->mount_opts.uid;
+	fsi->mount_opts.gid		= new->mount_opts.gid;
+	fsi->mount_opts.mode		= new->mount_opts.mode;
+	fsi->mount_opts.ptmxmode	= new->mount_opts.ptmxmode;
+	fsi->mount_opts.max		= new->mount_opts.max;
 
 	/*
 	 * parse_mount_options() restores options to default values
@@ -400,7 +379,7 @@ static int devpts_remount(struct super_block *sb, int *flags, char *data)
 	 */
 	update_ptmx_mode(fsi);
 
-	return err;
+	return 0;
 }
 
 static int devpts_show_options(struct seq_file *seq, struct dentry *root)
@@ -424,31 +403,13 @@ static int devpts_show_options(struct seq_file *seq, struct dentry *root)
 
 static const struct super_operations devpts_sops = {
 	.statfs		= simple_statfs,
-	.remount_fs	= devpts_remount,
 	.show_options	= devpts_show_options,
 };
 
-static void *new_pts_fs_info(struct super_block *sb)
-{
-	struct pts_fs_info *fsi;
-
-	fsi = kzalloc(sizeof(struct pts_fs_info), GFP_KERNEL);
-	if (!fsi)
-		return NULL;
-
-	ida_init(&fsi->allocated_ptys);
-	fsi->mount_opts.mode = DEVPTS_DEFAULT_MODE;
-	fsi->mount_opts.ptmxmode = DEVPTS_DEFAULT_PTMX_MODE;
-	fsi->sb = sb;
-
-	return fsi;
-}
-
-static int
-devpts_fill_super(struct super_block *s, void *data, int silent)
+static int devpts_fill_super(struct super_block *s, struct fs_context *fc)
 {
+	struct pts_fs_info *fsi = DEVPTS_SB(s);
 	struct inode *inode;
-	int error;
 
 	s->s_iflags &= ~SB_I_NODEV;
 	s->s_blocksize = 1024;
@@ -457,20 +418,12 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
 	s->s_op = &devpts_sops;
 	s->s_d_op = &simple_dentry_operations;
 	s->s_time_gran = 1;
+	fsi->sb = s;
 
-	error = -ENOMEM;
-	s->s_fs_info = new_pts_fs_info(s);
-	if (!s->s_fs_info)
-		goto fail;
-
-	error = parse_mount_options(data, PARSE_MOUNT, &DEVPTS_SB(s)->mount_opts);
-	if (error)
-		goto fail;
-
-	error = -ENOMEM;
 	inode = new_inode(s);
 	if (!inode)
-		goto fail;
+		return -ENOMEM;
+
 	inode->i_ino = 1;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	inode->i_mode = S_IFDIR | S_IRUGO | S_IXUGO | S_IWUSR;
@@ -480,20 +433,11 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
 
 	s->s_root = d_make_root(inode);
 	if (!s->s_root) {
-		pr_err("get root dentry failed\n");
-		goto fail;
+		errorf(fc, "get root dentry failed");
+		return -ENOMEM;
 	}
 
-	error = mknod_ptmx(s);
-	if (error)
-		goto fail_dput;
-
-	return 0;
-fail_dput:
-	dput(s->s_root);
-	s->s_root = NULL;
-fail:
-	return error;
+	return mknod_ptmx(s, fc);
 }
 
 /*
@@ -502,10 +446,48 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
  *     Mount a new (private) instance of devpts.  PTYs created in this
  *     instance are independent of the PTYs in other devpts instances.
  */
-static struct dentry *devpts_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int devpts_get_tree(struct fs_context *fc)
+{
+	return vfs_get_super(fc, vfs_get_independent_super, devpts_fill_super);
+}
+
+static void devpts_free_fc(struct fs_context *fc)
+{
+	kfree(fc->s_fs_info);
+}
+
+static const struct fs_context_operations devpts_context_ops = {
+	.free		= devpts_free_fc,
+	.parse_param	= devpts_parse_param,
+	.get_tree	= devpts_get_tree,
+	.reconfigure	= devpts_reconfigure,
+};
+
+/*
+ * Set up the filesystem mount context.
+ */
+static int devpts_init_fs_context(struct fs_context *fc)
 {
-	return mount_nodev(fs_type, flags, data, devpts_fill_super);
+	struct pts_fs_info *fsi;
+
+	fsi = kzalloc(sizeof(struct pts_fs_info), GFP_KERNEL);
+	if (!fsi)
+		return -ENOMEM;
+
+	ida_init(&fsi->allocated_ptys);
+	fsi->mount_opts.uid     = GLOBAL_ROOT_UID;
+	fsi->mount_opts.gid     = GLOBAL_ROOT_GID;
+	fsi->mount_opts.mode    = DEVPTS_DEFAULT_MODE;
+	fsi->mount_opts.ptmxmode = DEVPTS_DEFAULT_PTMX_MODE;
+	fsi->mount_opts.max     = NR_UNIX98_PTY_MAX;
+
+	if (fc->purpose == FS_CONTEXT_FOR_MOUNT &&
+	    current->nsproxy->mnt_ns == init_task.nsproxy->mnt_ns)
+		fsi->mount_opts.reserve = true;
+
+	fc->s_fs_info = fsi;
+	fc->ops = &devpts_context_ops;
+	return 0;
 }
 
 static void devpts_kill_sb(struct super_block *sb)
@@ -520,7 +502,8 @@ static void devpts_kill_sb(struct super_block *sb)
 
 static struct file_system_type devpts_fs_type = {
 	.name		= "devpts",
-	.mount		= devpts_mount,
+	.init_fs_context = devpts_init_fs_context,
+	.parameters	= &devpts_fs_parameters,
 	.kill_sb	= devpts_kill_sb,
 	.fs_flags	= FS_USERNS_MOUNT,
 };

