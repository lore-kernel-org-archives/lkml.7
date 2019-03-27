Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D562C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E85D2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733169AbfC0XnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:43:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730859AbfC0XnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:43:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7A1B458E5B;
        Wed, 27 Mar 2019 23:43:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4868C60589;
        Wed, 27 Mar 2019 23:43:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 22/68] vfs: Convert binderfs to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Christian Brauner <christian@brauner.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?b?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:43:20 +0000
Message-ID: <155373020049.7602.8355937001441630312.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 27 Mar 2019 23:43:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the binderfs filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christian Brauner <christian@brauner.io>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: "Arve Hjønnevåg" <arve@android.com>
cc: Todd Kjos <tkjos@android.com>
cc: Martijn Coenen <maco@android.com>
cc: Joel Fernandes <joel@joelfernandes.org>
cc: devel@driverdev.osuosl.org
---

 drivers/android/binderfs.c |  173 ++++++++++++++++++++++++--------------------
 1 file changed, 96 insertions(+), 77 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index e773f45d19d9..0a16ecc9594f 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -18,7 +18,8 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/mount.h>
-#include <linux/parser.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/radix-tree.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
@@ -48,22 +49,18 @@ static dev_t binderfs_dev;
 static DEFINE_MUTEX(binderfs_minors_mutex);
 static DEFINE_IDA(binderfs_minors);
 
-/**
- * binderfs_mount_opts - mount options for binderfs
- * @max: maximum number of allocatable binderfs binder devices
- */
-struct binderfs_mount_opts {
-	int max;
-};
-
 enum {
 	Opt_max,
-	Opt_err
 };
 
-static const match_table_t tokens = {
-	{ Opt_max, "max=%d" },
-	{ Opt_err, NULL     }
+static const struct fs_parameter_spec binderfs_param_specs[] = {
+	fsparam_s32   ("max",	Opt_max),
+	{}
+};
+
+static const struct fs_parameter_description binderfs_fs_parameters = {
+	.name		= "binderfs",
+	.specs		= binderfs_param_specs,
 };
 
 /**
@@ -75,7 +72,7 @@ static const match_table_t tokens = {
  *                  created.
  * @root_gid:       gid that needs to be used when a new binder device is
  *                  created.
- * @mount_opts:     The mount options in use.
+ * @max:	    Maximum number of allocatable binderfs binder devices.
  * @device_count:   The current number of allocated binder devices.
  */
 struct binderfs_info {
@@ -83,7 +80,7 @@ struct binderfs_info {
 	struct dentry *control_dentry;
 	kuid_t root_uid;
 	kgid_t root_gid;
-	struct binderfs_mount_opts mount_opts;
+	int max;
 	int device_count;
 };
 
@@ -138,7 +135,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 
 	/* Reserve new minor number for the new device. */
 	mutex_lock(&binderfs_minors_mutex);
-	if (++info->device_count <= info->mount_opts.max)
+	if (++info->device_count <= info->max)
 		minor = ida_alloc_max(&binderfs_minors,
 				      use_reserve ? BINDERFS_MAX_MINOR :
 						    BINDERFS_MAX_MINOR_CAPPED,
@@ -285,46 +282,36 @@ static void binderfs_evict_inode(struct inode *inode)
 }
 
 /**
- * binderfs_parse_mount_opts - parse binderfs mount options
- * @data: options to set (can be NULL in which case defaults are used)
+ * binderfs_parse_param - parse a binderfs mount option
+ * @fc: The context to be configured
+ * @param: The parameter to apply
  */
-static int binderfs_parse_mount_opts(char *data,
-				     struct binderfs_mount_opts *opts)
+static int binderfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	char *p;
-	opts->max = BINDERFS_MAX_MINOR;
-
-	while ((p = strsep(&data, ",")) != NULL) {
-		substring_t args[MAX_OPT_ARGS];
-		int token;
-		int max_devices;
-
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_max:
-			if (match_int(&args[0], &max_devices) ||
-			    (max_devices < 0 ||
-			     (max_devices > BINDERFS_MAX_MINOR)))
-				return -EINVAL;
-
-			opts->max = max_devices;
-			break;
-		default:
-			pr_err("Invalid mount options\n");
-			return -EINVAL;
-		}
+	struct fs_parse_result result;
+	struct binderfs_info *info = fc->s_fs_info;
+	int opt;
+
+	opt = fs_parse(fc, &binderfs_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_max:
+		info->max = result.int_32;
+		break;
 	}
 
 	return 0;
 }
 
-static int binderfs_remount(struct super_block *sb, int *flags, char *data)
+static int binderfs_reconfigure(struct fs_context *fc)
 {
-	struct binderfs_info *info = sb->s_fs_info;
-	return binderfs_parse_mount_opts(data, &info->mount_opts);
+	struct binderfs_info *info = fc->root->d_sb->s_fs_info;
+	struct binderfs_info *cfg = fc->s_fs_info;
+
+	info->max = cfg->max;
+	return 0;
 }
 
 static int binderfs_show_mount_opts(struct seq_file *seq, struct dentry *root)
@@ -332,15 +319,14 @@ static int binderfs_show_mount_opts(struct seq_file *seq, struct dentry *root)
 	struct binderfs_info *info;
 
 	info = root->d_sb->s_fs_info;
-	if (info->mount_opts.max <= BINDERFS_MAX_MINOR)
-		seq_printf(seq, ",max=%d", info->mount_opts.max);
+	if (info->max <= BINDERFS_MAX_MINOR)
+		seq_printf(seq, ",max=%d", info->max);
 
 	return 0;
 }
 
 static const struct super_operations binderfs_super_ops = {
 	.evict_inode    = binderfs_evict_inode,
-	.remount_fs	= binderfs_remount,
 	.show_options	= binderfs_show_mount_opts,
 	.statfs         = simple_statfs,
 };
@@ -462,10 +448,8 @@ static const struct inode_operations binderfs_dir_inode_operations = {
 	.unlink = binderfs_unlink,
 };
 
-static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
+static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
-	int ret;
-	struct binderfs_info *info;
 	struct inode *inode = NULL;
 
 	sb->s_blocksize = PAGE_SIZE;
@@ -488,24 +472,6 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_op = &binderfs_super_ops;
 	sb->s_time_gran = 1;
 
-	sb->s_fs_info = kzalloc(sizeof(struct binderfs_info), GFP_KERNEL);
-	if (!sb->s_fs_info)
-		return -ENOMEM;
-	info = sb->s_fs_info;
-
-	info->ipc_ns = get_ipc_ns(current->nsproxy->ipc_ns);
-
-	ret = binderfs_parse_mount_opts(data, &info->mount_opts);
-	if (ret)
-		return ret;
-
-	info->root_gid = make_kgid(sb->s_user_ns, 0);
-	if (!gid_valid(info->root_gid))
-		info->root_gid = GLOBAL_ROOT_GID;
-	info->root_uid = make_kuid(sb->s_user_ns, 0);
-	if (!uid_valid(info->root_uid))
-		info->root_uid = GLOBAL_ROOT_UID;
-
 	inode = new_inode(sb);
 	if (!inode)
 		return -ENOMEM;
@@ -524,11 +490,63 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
 	return binderfs_binder_ctl_create(sb);
 }
 
-static struct dentry *binderfs_mount(struct file_system_type *fs_type,
-				     int flags, const char *dev_name,
-				     void *data)
+static int binderfs_get_tree(struct fs_context *fc)
+{
+	if (!ns_capable(fc->user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return vfs_get_super(fc, vfs_get_independent_super, binderfs_fill_super);
+}
+
+static void binderfs_free_fc(struct fs_context *fc)
+{
+	struct binderfs_info *info = fc->s_fs_info;
+
+	if (info) {
+		struct ipc_namespace *ipc_ns = fc->s_fs_info;
+		put_ipc_ns(ipc_ns);
+		kfree(info);
+	}
+}
+
+static const struct fs_context_operations binderfs_context_ops = {
+	.free		= binderfs_free_fc,
+	.parse_param	= binderfs_parse_param,
+	.get_tree	= binderfs_get_tree,
+	.reconfigure	= binderfs_reconfigure,
+};
+
+static int binderfs_init_fs_context(struct fs_context *fc)
 {
-	return mount_nodev(fs_type, flags, data, binderfs_fill_super);
+	struct binderfs_info *info;
+	struct ipc_namespace *ipc_ns = current->nsproxy->ipc_ns;
+	struct user_namespace *user_ns = ipc_ns->user_ns;
+
+	info = kzalloc(sizeof(struct binderfs_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	switch (fc->purpose) {
+	case FS_CONTEXT_FOR_MOUNT:
+		put_user_ns(fc->user_ns);
+		fc->user_ns = get_user_ns(user_ns);
+		info->ipc_ns = get_ipc_ns(ipc_ns);
+
+		info->root_gid = make_kgid(user_ns, 0);
+		if (!gid_valid(info->root_gid))
+			info->root_gid = GLOBAL_ROOT_GID;
+		info->root_uid = make_kuid(user_ns, 0);
+		if (!uid_valid(info->root_uid))
+			info->root_uid = GLOBAL_ROOT_UID;
+		break;
+
+	default:
+		break;
+	}
+
+	fc->s_fs_info = info;
+	fc->ops = &binderfs_context_ops;
+	return 0;
 }
 
 static void binderfs_kill_super(struct super_block *sb)
@@ -545,7 +563,8 @@ static void binderfs_kill_super(struct super_block *sb)
 
 static struct file_system_type binder_fs_type = {
 	.name		= "binder",
-	.mount		= binderfs_mount,
+	.init_fs_context = binderfs_init_fs_context,
+	.parameters	= &binderfs_fs_parameters,
 	.kill_sb	= binderfs_kill_super,
 	.fs_flags	= FS_USERNS_MOUNT,
 };

