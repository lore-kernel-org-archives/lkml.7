Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09351C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9B320651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbfC0Xsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:48:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbfC0Xsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:48:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1166B307E043;
        Wed, 27 Mar 2019 23:48:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA0761001DC0;
        Wed, 27 Mar 2019 23:48:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 63/68] vfs: Convert autofs to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:48:34 +0000
Message-ID: <155373051409.7602.14358871505533869521.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 27 Mar 2019 23:48:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the autofs filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/autofs/autofs_i.h |   13 +-
 fs/autofs/init.c     |    9 -
 fs/autofs/inode.c    |  429 +++++++++++++++++++++++++++-----------------------
 3 files changed, 247 insertions(+), 204 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 70c132acdab1..bedbb004baf8 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -204,16 +204,25 @@ static inline void managed_dentry_clear_managed(struct dentry *dentry)
 
 /* Initializing function */
 
-int autofs_fill_super(struct super_block *, void *, int);
+extern const struct fs_parameter_description autofs_fs_parameters;
+int autofs_init_fs_context(struct fs_context *fc);
 struct autofs_info *autofs_new_ino(struct autofs_sb_info *);
 void autofs_clean_ino(struct autofs_info *);
 
-static inline int autofs_prepare_pipe(struct file *pipe)
+static inline int autofs_check_pipe(struct file *pipe)
 {
 	if (!(pipe->f_mode & FMODE_CAN_WRITE))
 		return -EINVAL;
 	if (!S_ISFIFO(file_inode(pipe)->i_mode))
 		return -EINVAL;
+	return 0;
+}
+
+static inline int autofs_prepare_pipe(struct file *pipe)
+{
+	int ret = autofs_check_pipe(pipe);
+	if (ret < 0)
+		return ret;
 	/* We want a packet pipe */
 	pipe->f_flags |= O_DIRECT;
 	/* We don't expect -EAGAIN */
diff --git a/fs/autofs/init.c b/fs/autofs/init.c
index c0c1db2cc6ea..075ecdad7496 100644
--- a/fs/autofs/init.c
+++ b/fs/autofs/init.c
@@ -10,16 +10,11 @@
 #include <linux/init.h>
 #include "autofs_i.h"
 
-static struct dentry *autofs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
-{
-	return mount_nodev(fs_type, flags, data, autofs_fill_super);
-}
-
 struct file_system_type autofs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "autofs",
-	.mount		= autofs_mount,
+	.init_fs_context = autofs_init_fs_context,
+	.parameters	= &autofs_fs_parameters,
 	.kill_sb	= autofs_kill_sb,
 };
 MODULE_ALIAS_FS("autofs");
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 80597b88718b..ba9aa35e8259 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -9,7 +9,8 @@
 
 #include <linux/seq_file.h>
 #include <linux/pagemap.h>
-#include <linux/parser.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 
 #include "autofs_i.h"
 
@@ -112,150 +113,148 @@ static const struct super_operations autofs_sops = {
 	.evict_inode	= autofs_evict_inode,
 };
 
-enum {Opt_err, Opt_fd, Opt_uid, Opt_gid, Opt_pgrp, Opt_minproto, Opt_maxproto,
-	Opt_indirect, Opt_direct, Opt_offset, Opt_strictexpire,
-	Opt_ignore};
-
-static const match_table_t tokens = {
-	{Opt_fd, "fd=%u"},
-	{Opt_uid, "uid=%u"},
-	{Opt_gid, "gid=%u"},
-	{Opt_pgrp, "pgrp=%u"},
-	{Opt_minproto, "minproto=%u"},
-	{Opt_maxproto, "maxproto=%u"},
-	{Opt_indirect, "indirect"},
-	{Opt_direct, "direct"},
-	{Opt_offset, "offset"},
-	{Opt_strictexpire, "strictexpire"},
-	{Opt_ignore, "ignore"},
-	{Opt_err, NULL}
+struct autofs_fs_context {
+	kuid_t	uid;
+	kgid_t	gid;
+	};
+
+enum {
+	Opt_direct,
+	Opt_fd,
+	Opt_gid,
+	Opt_ignore,
+	Opt_indirect,
+	Opt_maxproto,
+	Opt_minproto,
+	Opt_offset,
+	Opt_pgrp,
+	Opt_strictexpire,
+	Opt_uid,
 };
 
-static int parse_options(char *options,
-			 struct inode *root, int *pgrp, bool *pgrp_set,
-			 struct autofs_sb_info *sbi)
+static const struct fs_parameter_spec autofs_param_specs[] = {
+	fsparam_flag	("direct",			Opt_direct),
+	fsparam_fd	("fd",				Opt_fd),
+	fsparam_u32	("gid",				Opt_gid),
+	fsparam_flag	("ignore",			Opt_ignore),
+	fsparam_flag	("indirect",			Opt_indirect),
+	fsparam_u32	("maxproto",			Opt_maxproto),
+	fsparam_u32	("minproto",			Opt_minproto),
+	fsparam_flag	("offset",			Opt_offset),
+	fsparam_u32	("pgrp",			Opt_pgrp),
+	fsparam_flag	("strictexpire",		Opt_strictexpire),
+	fsparam_u32	("uid",				Opt_uid),
+	{}
+};
+
+const struct fs_parameter_description autofs_fs_parameters = {
+	.name		= "autofs",
+	.specs		= autofs_param_specs,
+};
+
+/*
+ * Open the fd.  We do it here rather than in get_tree so that it's done in the
+ * context of the system call that passed the data and not the one that
+ * triggered the superblock creation, lest the fd gets reassigned.
+ */
+static int autofs_parse_fd(struct fs_context *fc, int pipefd)
 {
-	char *p;
-	substring_t args[MAX_OPT_ARGS];
-	int option;
-	int pipefd = -1;
-	kuid_t uid;
-	kgid_t gid;
+	struct autofs_sb_info *sbi = fc->s_fs_info;
+	struct file *pipe;
+	int ret;
 
-	root->i_uid = current_uid();
-	root->i_gid = current_gid();
+	pipe = fget(pipefd);
+	if (!pipe) {
+		errorf(fc, "Pipe file descriptor not open");
+		return -EBADF;
+	}
 
-	sbi->min_proto = AUTOFS_MIN_PROTO_VERSION;
-	sbi->max_proto = AUTOFS_MAX_PROTO_VERSION;
+	ret = autofs_check_pipe(pipe);
+	if (ret < 0) {
+		fput(pipe);
+		return invalf(fc, "Invalid/unusable pipe");
+	}
 
-	sbi->pipefd = -1;
+	sbi->pipefd = pipefd;
+	sbi->pipe = pipe;
+
+	return 0;
+}
 
-	if (!options)
-		return 1;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token;
-
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_fd:
-			if (match_int(args, &pipefd))
-				return 1;
-			sbi->pipefd = pipefd;
-			break;
-		case Opt_uid:
-			if (match_int(args, &option))
-				return 1;
-			uid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(uid))
-				return 1;
-			root->i_uid = uid;
-			break;
-		case Opt_gid:
-			if (match_int(args, &option))
-				return 1;
-			gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(gid))
-				return 1;
-			root->i_gid = gid;
-			break;
-		case Opt_pgrp:
-			if (match_int(args, &option))
-				return 1;
-			*pgrp = option;
-			*pgrp_set = true;
-			break;
-		case Opt_minproto:
-			if (match_int(args, &option))
-				return 1;
-			sbi->min_proto = option;
-			break;
-		case Opt_maxproto:
-			if (match_int(args, &option))
-				return 1;
-			sbi->max_proto = option;
-			break;
-		case Opt_indirect:
-			set_autofs_type_indirect(&sbi->type);
-			break;
-		case Opt_direct:
-			set_autofs_type_direct(&sbi->type);
-			break;
-		case Opt_offset:
-			set_autofs_type_offset(&sbi->type);
-			break;
-		case Opt_strictexpire:
-			sbi->flags |= AUTOFS_SBI_STRICTEXPIRE;
-			break;
-		case Opt_ignore:
-			sbi->flags |= AUTOFS_SBI_IGNORE;
-			break;
-		default:
+static int autofs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct autofs_fs_context *ctx = fc->fs_private;
+	struct autofs_sb_info *sbi = fc->s_fs_info;
+	struct fs_parse_result result;
+	struct pid *pgrp;
+	kuid_t uid;
+	kgid_t gid;
+	int opt;
+
+	opt = fs_parse(fc, &autofs_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_fd:
+		return autofs_parse_fd(fc, result.int_32);
+	case Opt_uid:
+		uid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(uid))
+			return 1;
+		ctx->uid = uid;
+		break;
+	case Opt_gid:
+		gid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(gid))
 			return 1;
-		}
+		ctx->gid = gid;
+		break;
+	case Opt_pgrp:
+		pgrp = find_get_pid(result.uint_32);
+		if (!pgrp)
+			return invalf(fc, "Could not find process group %u",
+				      result.uint_32);
+		put_pid(sbi->oz_pgrp);
+		sbi->oz_pgrp = pgrp;
+		break;
+	case Opt_minproto:
+		sbi->min_proto = result.uint_32;
+		break;
+	case Opt_maxproto:
+		sbi->max_proto = result.uint_32;
+		break;
+	case Opt_indirect:
+		set_autofs_type_indirect(&sbi->type);
+		break;
+	case Opt_direct:
+		set_autofs_type_direct(&sbi->type);
+		break;
+	case Opt_offset:
+		set_autofs_type_offset(&sbi->type);
+		break;
+	case Opt_strictexpire:
+		sbi->flags |= AUTOFS_SBI_STRICTEXPIRE;
+		break;
+	case Opt_ignore:
+		sbi->flags |= AUTOFS_SBI_IGNORE;
+		break;
 	}
-	return (sbi->pipefd < 0);
+
+	return 0;
 }
 
-int autofs_fill_super(struct super_block *s, void *data, int silent)
+static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
 {
+	struct autofs_fs_context *ctx = fc->fs_private;
+	struct autofs_sb_info *sbi = s->s_fs_info;
+	struct autofs_info *ino;
 	struct inode *root_inode;
 	struct dentry *root;
-	struct file *pipe;
-	struct autofs_sb_info *sbi;
-	struct autofs_info *ino;
-	int pgrp = 0;
-	bool pgrp_set = false;
-	int ret = -EINVAL;
 
-	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
-	if (!sbi)
-		return -ENOMEM;
 	pr_debug("starting up, sbi = %p\n", sbi);
 
-	s->s_fs_info = sbi;
-	sbi->magic = AUTOFS_SBI_MAGIC;
-	sbi->pipefd = -1;
-	sbi->pipe = NULL;
-	sbi->exp_timeout = 0;
-	sbi->oz_pgrp = NULL;
 	sbi->sb = s;
-	sbi->version = 0;
-	sbi->sub_version = 0;
-	sbi->flags = AUTOFS_SBI_CATATONIC;
-	set_autofs_type_indirect(&sbi->type);
-	sbi->min_proto = 0;
-	sbi->max_proto = 0;
-	mutex_init(&sbi->wq_mutex);
-	mutex_init(&sbi->pipe_mutex);
-	spin_lock_init(&sbi->fs_lock);
-	sbi->queues = NULL;
-	spin_lock_init(&sbi->lookup_lock);
-	INIT_LIST_HEAD(&sbi->active_list);
-	INIT_LIST_HEAD(&sbi->expiring_list);
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
 	s->s_magic = AUTOFS_SUPER_MAGIC;
@@ -264,38 +263,63 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	s->s_time_gran = 1;
 
 	/*
-	 * Get the root inode and dentry, but defer checking for errors.
+	 * Get the root inode and dentry.
 	 */
 	ino = autofs_new_ino(sbi);
-	if (!ino) {
-		ret = -ENOMEM;
-		goto fail_free;
-	}
+	if (!ino)
+		goto nomem;
+
 	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
+	root_inode->i_uid = ctx->uid;
+	root_inode->i_gid = ctx->gid;
+	root_inode->i_fop = &autofs_root_operations;
+	root_inode->i_op = &autofs_dir_inode_operations;
+
 	root = d_make_root(root_inode);
-	if (!root) {
-		ret = -ENOMEM;
-		goto fail_ino;
-	}
-	pipe = NULL;
+	if (!root)
+		goto nomem_ino;
 
 	root->d_fsdata = ino;
 
-	/* Can this call block? */
-	if (parse_options(data, root_inode, &pgrp, &pgrp_set, sbi)) {
-		pr_err("called with bogus options\n");
-		goto fail_dput;
-	}
+	if (autofs_type_trigger(sbi->type))
+		__managed_dentry_set_managed(root);
+
+	pr_debug("pipe fd = %d, pgrp = %u\n",
+		 sbi->pipefd, pid_nr(sbi->oz_pgrp));
+
+	autofs_prepare_pipe(sbi->pipe);
+
+	sbi->flags &= ~AUTOFS_SBI_CATATONIC;
+
+	/*
+	 * Success! Install the root dentry now to indicate completion.
+	 */
+	s->s_root = root;
+	return 0;
+
+	/*
+	 * Failure ... clean up.
+	 */
+nomem_ino:
+	autofs_free_ino(ino);
+nomem:
+	return -ENOMEM;
+}
+
+/*
+ * Validate the parameters and then request a superblock.
+ */
+static int autofs_get_tree(struct fs_context *fc)
+{
+	struct autofs_sb_info *sbi = fc->s_fs_info;
 
 	/* Test versions first */
 	if (sbi->max_proto < AUTOFS_MIN_PROTO_VERSION ||
-	    sbi->min_proto > AUTOFS_MAX_PROTO_VERSION) {
-		pr_err("kernel does not match daemon version "
-		       "daemon (%d, %d) kernel (%d, %d)\n",
-		       sbi->min_proto, sbi->max_proto,
-		       AUTOFS_MIN_PROTO_VERSION, AUTOFS_MAX_PROTO_VERSION);
-		goto fail_dput;
-	}
+	    sbi->min_proto > AUTOFS_MAX_PROTO_VERSION)
+		return invalf(fc, "kernel does not match daemon version "
+			      "daemon (%d, %d) kernel (%d, %d)\n",
+			      sbi->min_proto, sbi->max_proto,
+			      AUTOFS_MIN_PROTO_VERSION, AUTOFS_MAX_PROTO_VERSION);
 
 	/* Establish highest kernel protocol version */
 	if (sbi->max_proto > AUTOFS_MAX_PROTO_VERSION)
@@ -304,60 +328,75 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 		sbi->version = sbi->max_proto;
 	sbi->sub_version = AUTOFS_PROTO_SUBVERSION;
 
-	if (pgrp_set) {
-		sbi->oz_pgrp = find_get_pid(pgrp);
-		if (!sbi->oz_pgrp) {
-			pr_err("could not find process group %d\n",
-				pgrp);
-			goto fail_dput;
-		}
-	} else {
-		sbi->oz_pgrp = get_task_pid(current, PIDTYPE_PGID);
+	if (!sbi->pipe)
+		return invalf(fc, "No control pipe specified");
+
+	return vfs_get_super(fc, vfs_get_independent_super, autofs_fill_super);
+}
+
+static void autofs_free_fc(struct fs_context *fc)
+{
+	struct autofs_fs_context *ctx = fc->fs_private;
+	struct autofs_sb_info *sbi = fc->s_fs_info;
+
+	if (sbi) {
+		if (sbi->pipe)
+			fput(sbi->pipe);
+		put_pid(sbi->oz_pgrp);
+		kfree(sbi);
 	}
+	kfree(ctx);
+}
 
-	if (autofs_type_trigger(sbi->type))
-		__managed_dentry_set_managed(root);
+static const struct fs_context_operations autofs_context_ops = {
+	.free		= autofs_free_fc,
+	.parse_param	= autofs_parse_param,
+	.get_tree	= autofs_get_tree,
+};
 
-	root_inode->i_fop = &autofs_root_operations;
-	root_inode->i_op = &autofs_dir_inode_operations;
+/*
+ * Set up the filesystem mount context.
+ */
+int autofs_init_fs_context(struct fs_context *fc)
+{
+	struct autofs_fs_context *ctx;
+	struct autofs_sb_info *sbi;
 
-	pr_debug("pipe fd = %d, pgrp = %u\n",
-		 sbi->pipefd, pid_nr(sbi->oz_pgrp));
-	pipe = fget(sbi->pipefd);
+	ctx = kzalloc(sizeof(struct autofs_fs_context), GFP_KERNEL);
+	if (!ctx)
+		goto nomem;
 
-	if (!pipe) {
-		pr_err("could not open pipe file descriptor\n");
-		goto fail_put_pid;
-	}
-	ret = autofs_prepare_pipe(pipe);
-	if (ret < 0)
-		goto fail_fput;
-	sbi->pipe = pipe;
-	sbi->flags &= ~AUTOFS_SBI_CATATONIC;
+	ctx->uid = current_uid();
+	ctx->gid = current_gid();
 
-	/*
-	 * Success! Install the root dentry now to indicate completion.
-	 */
-	s->s_root = root;
+	sbi = kzalloc(sizeof(struct autofs_sb_info), GFP_KERNEL);
+	if (!sbi)
+		goto nomem_ctx;
+
+	sbi->magic = AUTOFS_SBI_MAGIC;
+	sbi->flags = AUTOFS_SBI_CATATONIC;
+	sbi->min_proto = AUTOFS_MIN_PROTO_VERSION;
+	sbi->max_proto = AUTOFS_MAX_PROTO_VERSION;
+	sbi->pipefd = -1;
+	sbi->oz_pgrp = get_task_pid(current, PIDTYPE_PGID);
+
+	set_autofs_type_indirect(&sbi->type);
+	mutex_init(&sbi->wq_mutex);
+	mutex_init(&sbi->pipe_mutex);
+	spin_lock_init(&sbi->fs_lock);
+	spin_lock_init(&sbi->lookup_lock);
+	INIT_LIST_HEAD(&sbi->active_list);
+	INIT_LIST_HEAD(&sbi->expiring_list);
+
+	fc->fs_private = ctx;
+	fc->s_fs_info = sbi;
+	fc->ops = &autofs_context_ops;
 	return 0;
 
-	/*
-	 * Failure ... clean up.
-	 */
-fail_fput:
-	pr_err("pipe file descriptor does not contain proper ops\n");
-	fput(pipe);
-fail_put_pid:
-	put_pid(sbi->oz_pgrp);
-fail_dput:
-	dput(root);
-	goto fail_free;
-fail_ino:
-	autofs_free_ino(ino);
-fail_free:
-	kfree(sbi);
-	s->s_fs_info = NULL;
-	return ret;
+nomem_ctx:
+	kfree(ctx);
+nomem:
+	return -ENOMEM;
 }
 
 struct inode *autofs_get_inode(struct super_block *sb, umode_t mode)

