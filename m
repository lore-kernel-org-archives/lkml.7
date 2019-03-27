Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10699C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C6A204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbfC0XtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:49:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbfC0XtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:49:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0F62C007346;
        Wed, 27 Mar 2019 23:49:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A28660FDE;
        Wed, 27 Mar 2019 23:49:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 67/68] vfs: Convert orangefs to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:49:04 +0000
Message-ID: <155373054475.7602.4918098489201730987.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 27 Mar 2019 23:49:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the orangefs filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.
cc: Mike Marshall <hubcap@omnibond.com>
cc: Martin Brandenburg <martin@omnibond.com>
cc: devel@lists.orangefs.org
---

 fs/orangefs/orangefs-kernel.h |    8 +-
 fs/orangefs/orangefs-mod.c    |    3 -
 fs/orangefs/super.c           |  186 ++++++++++++++++++++++-------------------
 3 files changed, 105 insertions(+), 92 deletions(-)

diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index 17b24ad6b264..5b8379a6c815 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -32,6 +32,8 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/vmalloc.h>
 
 #include <linux/aio.h>
@@ -314,11 +316,9 @@ void purge_waiting_ops(void);
  * defined in super.c
  */
 extern uint64_t orangefs_features;
+extern const struct fs_parameter_description orangefs_fs_parameters;
 
-struct dentry *orangefs_mount(struct file_system_type *fst,
-			   int flags,
-			   const char *devname,
-			   void *data);
+int orangefs_init_fs_context(struct fs_context *fc);
 
 void orangefs_kill_sb(struct super_block *sb);
 int orangefs_remount(struct orangefs_sb_info_s *);
diff --git a/fs/orangefs/orangefs-mod.c b/fs/orangefs/orangefs-mod.c
index 85ef87245a87..f65cf0dd0f7e 100644
--- a/fs/orangefs/orangefs-mod.c
+++ b/fs/orangefs/orangefs-mod.c
@@ -44,7 +44,8 @@ MODULE_PARM_DESC(hash_table_size,
 
 static struct file_system_type orangefs_fs_type = {
 	.name = "pvfs2",
-	.mount = orangefs_mount,
+	.init_fs_context	= orangefs_init_fs_context,
+	.parameters		= &orangefs_fs_parameters,
 	.kill_sb = orangefs_kill_sb,
 	.owner = THIS_MODULE,
 };
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index dfaee90d30bd..f69d568818ce 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -9,8 +9,6 @@
 #include "orangefs-kernel.h"
 #include "orangefs-bufmap.h"
 
-#include <linux/parser.h>
-
 /* a cache for orangefs-inode objects (i.e. orangefs inode private data) */
 static struct kmem_cache *orangefs_inode_cache;
 
@@ -19,19 +17,22 @@ LIST_HEAD(orangefs_superblocks);
 
 DEFINE_SPINLOCK(orangefs_superblocks_lock);
 
-enum {
-	Opt_intr,
+enum orangefs_param {
 	Opt_acl,
+	Opt_intr,
 	Opt_local_lock,
+};
 
-	Opt_err
+static const struct fs_parameter_spec orangefs_param_specs[] = {
+	fsparam_flag	("acl",			Opt_acl),
+	fsparam_flag	("intr",		Opt_intr),
+	fsparam_flag	("local_lock",		Opt_local_lock),
+	{}
 };
 
-static const match_table_t tokens = {
-	{ Opt_acl,		"acl" },
-	{ Opt_intr,		"intr" },
-	{ Opt_local_lock,	"local_lock" },
-	{ Opt_err,	NULL }
+const struct fs_parameter_description orangefs_fs_parameters = {
+	.name		= "orangefs",
+	.specs		= orangefs_param_specs,
 };
 
 uint64_t orangefs_features;
@@ -49,48 +50,29 @@ static int orangefs_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
-static int parse_mount_options(struct super_block *sb, char *options,
-		int silent)
+static int orangefs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	struct orangefs_sb_info_s *orangefs_sb = ORANGEFS_SB(sb);
-	substring_t args[MAX_OPT_ARGS];
-	char *p;
-
-	/*
-	 * Force any potential flags that might be set from the mount
-	 * to zero, ie, initialize to unset.
-	 */
-	sb->s_flags &= ~SB_POSIXACL;
-	orangefs_sb->flags &= ~ORANGEFS_OPT_INTR;
-	orangefs_sb->flags &= ~ORANGEFS_OPT_LOCAL_LOCK;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token;
-
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_acl:
-			sb->s_flags |= SB_POSIXACL;
-			break;
-		case Opt_intr:
-			orangefs_sb->flags |= ORANGEFS_OPT_INTR;
-			break;
-		case Opt_local_lock:
-			orangefs_sb->flags |= ORANGEFS_OPT_LOCAL_LOCK;
-			break;
-		default:
-			goto fail;
-		}
+	struct orangefs_sb_info_s *orangefs_sb = fc->s_fs_info;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, &orangefs_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_acl:
+		fc->sb_flags |= SB_POSIXACL;
+		break;
+	case Opt_intr:
+		orangefs_sb->flags |= ORANGEFS_OPT_INTR;
+		break;
+	case Opt_local_lock:
+		orangefs_sb->flags |= ORANGEFS_OPT_LOCAL_LOCK;
+		break;
 	}
 
 	return 0;
-fail:
-	if (!silent)
-		gossip_err("Error: mount option [%s] is not supported.\n", p);
-	return -EINVAL;
 }
 
 static void orangefs_inode_cache_ctor(void *req)
@@ -207,10 +189,20 @@ static int orangefs_statfs(struct dentry *dentry, struct kstatfs *buf)
  * Remount as initiated by VFS layer.  We just need to reparse the mount
  * options, no need to signal pvfs2-client-core about it.
  */
-static int orangefs_remount_fs(struct super_block *sb, int *flags, char *data)
+static int orangefs_reconfigure(struct fs_context *fc)
 {
-	gossip_debug(GOSSIP_SUPER_DEBUG, "orangefs_remount_fs: called\n");
-	return parse_mount_options(sb, data, 1);
+	struct super_block *sb = fc->root->d_sb;
+	struct orangefs_sb_info_s *orangefs_sb = ORANGEFS_SB(sb);
+	struct orangefs_sb_info_s *revised = fc->s_fs_info;
+	unsigned int flags;
+
+	flags = orangefs_sb->flags;
+	flags &= ~(ORANGEFS_OPT_INTR | ORANGEFS_OPT_LOCAL_LOCK);
+	flags |= revised->flags;
+	WRITE_ONCE(orangefs_sb->flags, flags);
+
+	gossip_debug(GOSSIP_SUPER_DEBUG, "orangefs_reconfigure: called\n");
+	return 0;
 }
 
 /*
@@ -302,7 +294,6 @@ static const struct super_operations orangefs_s_ops = {
 	.destroy_inode = orangefs_destroy_inode,
 	.drop_inode = generic_delete_inode,
 	.statfs = orangefs_statfs,
-	.remount_fs = orangefs_remount_fs,
 	.show_options = orangefs_show_options,
 };
 
@@ -394,10 +385,9 @@ static int orangefs_unmount(int id, __s32 fs_id, const char *devname)
 }
 
 static int orangefs_fill_sb(struct super_block *sb,
-		struct orangefs_fs_mount_response *fs_mount,
-		void *data, int silent)
+			    struct fs_context *fc,
+			    struct orangefs_fs_mount_response *fs_mount)
 {
-	int ret = -EINVAL;
 	struct inode *root = NULL;
 	struct dentry *root_dentry = NULL;
 	struct orangefs_object_kref root_object;
@@ -412,12 +402,6 @@ static int orangefs_fill_sb(struct super_block *sb,
 	ORANGEFS_SB(sb)->fs_id = fs_mount->fs_id;
 	ORANGEFS_SB(sb)->id = fs_mount->id;
 
-	if (data) {
-		ret = parse_mount_options(sb, data, silent);
-		if (ret)
-			return ret;
-	}
-
 	/* Hang the xattr handlers off the superblock */
 	sb->s_xattr = orangefs_xattr_handlers;
 	sb->s_magic = ORANGEFS_SUPER_MAGIC;
@@ -454,31 +438,25 @@ static int orangefs_fill_sb(struct super_block *sb,
 	return 0;
 }
 
-struct dentry *orangefs_mount(struct file_system_type *fst,
-			   int flags,
-			   const char *devname,
-			   void *data)
+static int orangefs_get_tree(struct fs_context *fc)
 {
 	int ret = -EINVAL;
 	struct super_block *sb = ERR_PTR(-EINVAL);
 	struct orangefs_kernel_op_s *new_op;
-	struct dentry *d = ERR_PTR(-EINVAL);
+
+	if (!fc->source)
+		return invalf(fc, "Device name not specified.\n");
 
 	gossip_debug(GOSSIP_SUPER_DEBUG,
 		     "orangefs_mount: called with devname %s\n",
-		     devname);
-
-	if (!devname) {
-		gossip_err("ERROR: device name not specified.\n");
-		return ERR_PTR(-EINVAL);
-	}
+		     fc->source);
 
 	new_op = op_alloc(ORANGEFS_VFS_OP_FS_MOUNT);
 	if (!new_op)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	strncpy(new_op->upcall.req.fs_mount.orangefs_config_server,
-		devname,
+		fc->source,
 		ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
 
 	gossip_debug(GOSSIP_SUPER_DEBUG,
@@ -497,30 +475,27 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 		goto free_op;
 	}
 
-	sb = sget(fst, NULL, set_anon_super, flags, NULL);
+	sb = sget_fc(fc, NULL, set_anon_super_fc);
 
 	if (IS_ERR(sb)) {
-		d = ERR_CAST(sb);
+		ret = PTR_ERR(sb);
 		orangefs_unmount(new_op->downcall.resp.fs_mount.id,
-		    new_op->downcall.resp.fs_mount.fs_id, devname);
+				 new_op->downcall.resp.fs_mount.fs_id,
+				 fc->source);
 		goto free_op;
 	}
 
-	ret = orangefs_fill_sb(sb,
-	      &new_op->downcall.resp.fs_mount, data,
-	      flags & SB_SILENT ? 1 : 0);
+	ret = orangefs_fill_sb(sb, fc, &new_op->downcall.resp.fs_mount);
 
-	if (ret) {
-		d = ERR_PTR(ret);
+	if (ret)
 		goto free_sb_and_op;
-	}
 
 	/*
 	 * on successful mount, store the devname and data
 	 * used
 	 */
 	strncpy(ORANGEFS_SB(sb)->devname,
-		devname,
+		fc->source,
 		ORANGEFS_MAX_SERVER_ADDR_LEN - 1);
 
 	/* mount_pending must be cleared */
@@ -544,7 +519,7 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 	if (orangefs_userspace_version >= 20906) {
 		new_op = op_alloc(ORANGEFS_VFS_OP_FEATURES);
 		if (!new_op)
-			return ERR_PTR(-ENOMEM);
+			return -ENOMEM;
 		new_op->upcall.req.features.features = 0;
 		ret = service_operation(new_op, "orangefs_features", 0);
 		orangefs_features = new_op->downcall.resp.features.features;
@@ -553,7 +528,8 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 		orangefs_features = 0;
 	}
 
-	return dget(sb->s_root);
+	fc->root = dget(sb->s_root);
+	return 0;
 
 free_sb_and_op:
 	/* Will call orangefs_kill_sb with sb not in list. */
@@ -569,7 +545,43 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 
 	op_release(new_op);
 
-	return d;
+	return ret;
+}
+
+static void orangefs_free_fc(struct fs_context *fc)
+{
+	kfree(fc->s_fs_info);
+}
+
+static const struct fs_context_operations orangefs_context_ops = {
+	.free		= orangefs_free_fc,
+	.parse_param	= orangefs_parse_param,
+	.get_tree	= orangefs_get_tree,
+	.reconfigure	= orangefs_reconfigure,
+};
+
+/*
+ * Set up the filesystem mount context.
+ */
+int orangefs_init_fs_context(struct fs_context *fc)
+{
+	struct orangefs_sb_info_s *osi;
+
+	osi = kzalloc(sizeof(struct orangefs_sb_info_s), GFP_KERNEL);
+	if (!osi)
+		return -ENOMEM;
+
+	/*
+	 * Force any potential flags that might be set from the mount
+	 * to zero, ie, initialize to unset.
+	 */
+	fc->sb_flags_mask |= SB_POSIXACL;
+	osi->flags &= ~ORANGEFS_OPT_INTR;
+	osi->flags &= ~ORANGEFS_OPT_LOCAL_LOCK;
+
+	fc->s_fs_info = osi;
+	fc->ops = &orangefs_context_ops;
+	return 0;
 }
 
 void orangefs_kill_sb(struct super_block *sb)

