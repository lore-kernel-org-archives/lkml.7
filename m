Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B105C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92C320651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732946AbfC0Xsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:48:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387818AbfC0Xs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:48:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D10AC5D61E;
        Wed, 27 Mar 2019 23:48:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B66E5DC1A;
        Wed, 27 Mar 2019 23:48:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 62/68] vfs: Convert coda to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:48:26 +0000
Message-ID: <155373050664.7602.7982161310298752638.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 27 Mar 2019 23:48:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the coda filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Note this is slightly tricky as coda currently only has a binary mount data
interface.  This is handled through the parse_monolithic hook.

Also add a more conventional interface with a parameter named "fd" that
takes an fd that refers to a coda psdev, thereby specifying the index to
use.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jan Harkes <jaharkes@cs.cmu.edu>
cc: coda@cs.cmu.edu
---

 fs/coda/inode.c |  171 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 116 insertions(+), 55 deletions(-)

diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 97424cf206c0..aaed68ba960b 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -2,9 +2,9 @@
 /*
  * Super block/filesystem wide operations
  *
- * Copyright (C) 1996 Peter J. Braam <braam@maths.ox.ac.uk> and 
- * Michael Callahan <callahan@maths.ox.ac.uk> 
- * 
+ * Copyright (C) 1996 Peter J. Braam <braam@maths.ox.ac.uk> and
+ * Michael Callahan <callahan@maths.ox.ac.uk>
+ *
  * Rewritten for Linux 2.1.  Peter Braam <braam@cs.cmu.edu>
  * Copyright (C) Carnegie Mellon University
  */
@@ -24,6 +24,8 @@
 #include <linux/pid_namespace.h>
 #include <linux/uaccess.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/vmalloc.h>
 
 #include <linux/coda.h>
@@ -93,10 +95,10 @@ void coda_destroy_inodecache(void)
 	kmem_cache_destroy(coda_inode_cachep);
 }
 
-static int coda_remount(struct super_block *sb, int *flags, char *data)
+static int coda_reconfigure(struct fs_context *fc)
 {
-	sync_filesystem(sb);
-	*flags |= SB_NOATIME;
+	sync_filesystem(fc->root->d_sb);
+	fc->sb_flags |= SB_NOATIME;
 	return 0;
 }
 
@@ -108,78 +110,111 @@ static const struct super_operations coda_super_operations =
 	.evict_inode	= coda_evict_inode,
 	.put_super	= coda_put_super,
 	.statfs		= coda_statfs,
-	.remount_fs	= coda_remount,
 };
 
-static int get_device_index(struct coda_mount_data *data)
+struct coda_fs_context {
+	int	idx;
+};
+
+enum {
+	Opt_fd,
+};
+
+static const struct fs_parameter_spec coda_param_specs[] = {
+	fsparam_fd	("fd",				Opt_fd),
+	{}
+};
+
+static const struct fs_parameter_description coda_fs_parameters = {
+	.name		= "coda",
+	.specs		= coda_param_specs,
+};
+
+static int coda_parse_fd(struct fs_context *fc, int fd)
 {
+	struct coda_fs_context *ctx = fc->fs_private;
 	struct fd f;
 	struct inode *inode;
 	int idx;
 
-	if (data == NULL) {
-		pr_warn("%s: Bad mount data\n", __func__);
-		return -1;
-	}
-
-	if (data->version != CODA_MOUNT_VERSION) {
-		pr_warn("%s: Bad mount version\n", __func__);
-		return -1;
-	}
-
-	f = fdget(data->fd);
+	f = fdget(fd);
 	if (!f.file)
-		goto Ebadf;
+		return -EBADF;
+
 	inode = file_inode(f.file);
 	if (!S_ISCHR(inode->i_mode) || imajor(inode) != CODA_PSDEV_MAJOR) {
 		fdput(f);
-		goto Ebadf;
+		return invalf(fc, "code: Not coda psdev");
 	}
 
 	idx = iminor(inode);
 	fdput(f);
 
-	if (idx < 0 || idx >= MAX_CODADEVS) {
-		pr_warn("%s: Bad minor number\n", __func__);
-		return -1;
+	if (idx < 0 || idx >= MAX_CODADEVS)
+		return invalf(fc, "coda: Bad minor number");
+	ctx->idx = idx;
+	return 0;
+}
+
+static int coda_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, &coda_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_fd:
+		return coda_parse_fd(fc, result.uint_32);
+	}
+
+	return 0;
+}
+
+/*
+ * Parse coda's binary mount data form.  We ignore any errors and go with index
+ * 0 if we get one for backward compatibility.
+ */
+static int coda_parse_monolithic(struct fs_context *fc, void *_data)
+{
+	struct coda_mount_data *data = _data;
+
+	if (!data) {
+		invalf(fc, "coda: Bad mount data");
+		return 0;
+	}
+	if (data->version != CODA_MOUNT_VERSION) {
+		invalf(fc, "coda: Bad mount version");
+		return 0;
 	}
 
-	return idx;
-Ebadf:
-	pr_warn("%s: Bad file\n", __func__);
-	return -1;
+	coda_parse_fd(fc, data->fd);
+	return 0;
 }
 
-static int coda_fill_super(struct super_block *sb, void *data, int silent)
+static int coda_fill_super(struct super_block *sb, struct fs_context *fc)
 {
+	struct coda_fs_context *ctx = fc->fs_private;
 	struct inode *root = NULL;
 	struct venus_comm *vc;
 	struct CodaFid fid;
 	int error;
-	int idx;
 
-	if (task_active_pid_ns(current) != &init_pid_ns)
-		return -EINVAL;
+	infof(fc, "coda: device index: %i\n", ctx->idx);
 
-	idx = get_device_index((struct coda_mount_data *) data);
-
-	/* Ignore errors in data, for backward compatibility */
-	if(idx == -1)
-		idx = 0;
-	
-	pr_info("%s: device index: %i\n", __func__,  idx);
-
-	vc = &coda_comms[idx];
+	vc = &coda_comms[ctx->idx];
 	mutex_lock(&vc->vc_mutex);
 
 	if (!vc->vc_inuse) {
-		pr_warn("%s: No pseudo device\n", __func__);
+		errorf(fc, "coda: No pseudo device");
 		error = -EINVAL;
 		goto unlock_out;
 	}
 
 	if (vc->vc_sb) {
-		pr_warn("%s: Device already mounted\n", __func__);
+		errorf(fc, "coda: Device already mounted");
 		error = -EBUSY;
 		goto unlock_out;
 	}
@@ -207,7 +242,7 @@ static int coda_fill_super(struct super_block *sb, void *data, int silent)
 		goto error;
 	}
 	pr_info("%s: rootfid is %s\n", __func__, coda_f2s(&fid));
-	
+
 	/* make root inode */
         root = coda_cnode_make(&fid, sb);
         if (IS_ERR(root)) {
@@ -215,7 +250,7 @@ static int coda_fill_super(struct super_block *sb, void *data, int silent)
 		pr_warn("Failure of coda_cnode_make for root: error %d\n",
 			error);
 		goto error;
-	} 
+	}
 
 	pr_info("%s: rootinode is %ld dev %s\n",
 		__func__, root->i_ino, root->i_sb->s_id);
@@ -268,7 +303,7 @@ int coda_setattr(struct dentry *de, struct iattr *iattr)
 	struct coda_vattr vattr;
 	int error;
 
-	memset(&vattr, 0, sizeof(vattr)); 
+	memset(&vattr, 0, sizeof(vattr));
 
 	inode->i_ctime = current_time(inode);
 	coda_iattr_to_vattr(iattr, &vattr);
@@ -278,7 +313,7 @@ int coda_setattr(struct dentry *de, struct iattr *iattr)
 	error = venus_setattr(inode->i_sb, coda_i2f(inode), &vattr);
 
 	if (!error) {
-	        coda_vattr_to_iattr(inode, &vattr); 
+	        coda_vattr_to_iattr(inode, &vattr);
 		coda_cache_clear_inode(inode);
 	}
 	return error;
@@ -293,7 +328,7 @@ const struct inode_operations coda_file_inode_operations = {
 static int coda_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	int error;
-	
+
 	error = venus_statfs(dentry, buf);
 
 	if (error) {
@@ -310,23 +345,49 @@ static int coda_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bsize = 4096;
 	buf->f_namelen = CODA_MAXNAMLEN;
 
-	return 0; 
+	return 0;
 }
 
-/* init_coda: used by filesystems.c to register coda */
+static int coda_get_tree(struct fs_context *fc)
+{
+	if (task_active_pid_ns(current) != &init_pid_ns)
+		return -EINVAL;
+
+	return vfs_get_super(fc, vfs_get_independent_super, coda_fill_super);
+}
+
+static void coda_free_fc(struct fs_context *fc)
+{
+	kfree(fc->fs_private);
+}
 
-static struct dentry *coda_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static const struct fs_context_operations coda_context_ops = {
+	.free		= coda_free_fc,
+	.parse_param	= coda_parse_param,
+	.parse_monolithic = coda_parse_monolithic,
+	.get_tree	= coda_get_tree,
+	.reconfigure	= coda_reconfigure,
+};
+
+static int coda_init_fs_context(struct fs_context *fc)
 {
-	return mount_nodev(fs_type, flags, data, coda_fill_super);
+	struct coda_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct coda_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	fc->fs_private = ctx;
+	fc->ops = &coda_context_ops;
+	return 0;
 }
 
 struct file_system_type coda_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "coda",
-	.mount		= coda_mount,
+	.init_fs_context = coda_init_fs_context,
+	.parameters	= &coda_fs_parameters,
 	.kill_sb	= kill_anon_super,
 	.fs_flags	= FS_BINARY_MOUNTDATA,
 };
 MODULE_ALIAS_FS("coda");
-

