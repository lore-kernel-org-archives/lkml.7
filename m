Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65712C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D12820651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387756AbfC0Xrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:47:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbfC0Xrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:47:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6CD8430832EF;
        Wed, 27 Mar 2019 23:47:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8C3519C5A;
        Wed, 27 Mar 2019 23:47:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 57/68] vfs: Convert pstore to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:47:47 +0000
Message-ID: <155373046781.7602.3527275113589619793.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 27 Mar 2019 23:47:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the pstore filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Kees Cook <keescook@chromium.org>
cc: Anton Vorontsov <anton@enomsg.org>
cc: Colin Cross <ccross@android.com>
cc: Tony Luck <tony.luck@intel.com>
---

 fs/pstore/inode.c |  109 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 71 insertions(+), 38 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index c60ee46f3e39..bb4e4cabd11f 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -19,6 +19,8 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/fsnotify.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
@@ -26,10 +28,8 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/string.h>
-#include <linux/mount.h>
 #include <linux/seq_file.h>
 #include <linux/ramfs.h>
-#include <linux/parser.h>
 #include <linux/sched.h>
 #include <linux/magic.h>
 #include <linux/pstore.h>
@@ -227,38 +227,48 @@ static struct inode *pstore_get_inode(struct super_block *sb)
 	return inode;
 }
 
+struct pstore_fs_context {
+	unsigned int	kmsg_bytes;
+};
+
 enum {
-	Opt_kmsg_bytes, Opt_err
+	Opt_kmsg_bytes,
 };
 
-static const match_table_t tokens = {
-	{Opt_kmsg_bytes, "kmsg_bytes=%u"},
-	{Opt_err, NULL}
+static const struct fs_parameter_spec pstore_param_specs[] = {
+	fsparam_u32	("kmsg_bytes",		Opt_kmsg_bytes),
+	{}
 };
 
-static void parse_options(char *options)
-{
-	char		*p;
-	substring_t	args[MAX_OPT_ARGS];
-	int		option;
+static const struct fs_parameter_description pstore_fs_parameters = {
+	.name		= "pstore",
+	.specs		= pstore_param_specs,
+};
 
-	if (!options)
-		return;
+static int pstore_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct pstore_fs_context *ctx = fc->fs_private;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, &pstore_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_kmsg_bytes:
+		ctx->kmsg_bytes = result.uint_32;
+		break;
+	}
 
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token;
+	return 0;
+}
 
-		if (!*p)
-			continue;
+static void pstore_apply_param(struct fs_context *fc)
+{
+	struct pstore_fs_context *ctx = fc->fs_private;
 
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_kmsg_bytes:
-			if (!match_int(&args[0], &option))
-				pstore_set_kmsg_bytes(option);
-			break;
-		}
-	}
+	pstore_set_kmsg_bytes(ctx->kmsg_bytes);
 }
 
 /*
@@ -271,11 +281,10 @@ static int pstore_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
-static int pstore_remount(struct super_block *sb, int *flags, char *data)
+static int pstore_reconfigure(struct fs_context *fc)
 {
-	sync_filesystem(sb);
-	parse_options(data);
-
+	sync_filesystem(fc->root->d_sb);
+	pstore_apply_param(fc);
 	return 0;
 }
 
@@ -283,7 +292,6 @@ static const struct super_operations pstore_ops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= generic_delete_inode,
 	.evict_inode	= pstore_evict_inode,
-	.remount_fs	= pstore_remount,
 	.show_options	= pstore_show_options,
 };
 
@@ -389,12 +397,10 @@ void pstore_get_records(int quiet)
 	inode_unlock(d_inode(root));
 }
 
-static int pstore_fill_super(struct super_block *sb, void *data, int silent)
+static int pstore_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
 
-	pstore_sb = sb;
-
 	sb->s_maxbytes		= MAX_LFS_FILESIZE;
 	sb->s_blocksize		= PAGE_SIZE;
 	sb->s_blocksize_bits	= PAGE_SHIFT;
@@ -402,7 +408,8 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_op		= &pstore_ops;
 	sb->s_time_gran		= 1;
 
-	parse_options(data);
+	pstore_sb = sb;
+	pstore_apply_param(fc);
 
 	inode = pstore_get_inode(sb);
 	if (inode) {
@@ -420,10 +427,35 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
 	return 0;
 }
 
-static struct dentry *pstore_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int pstore_get_tree(struct fs_context *fc)
+{
+	return vfs_get_super(fc, vfs_get_single_reconf_super,
+			     pstore_fill_super);
+}
+
+static void pstore_free_fc(struct fs_context *fc)
 {
-	return mount_single(fs_type, flags, data, pstore_fill_super);
+	kfree(fc->fs_private);
+}
+
+static const struct fs_context_operations pstore_context_ops = {
+	.free		= pstore_free_fc,
+	.parse_param	= pstore_parse_param,
+	.get_tree	= pstore_get_tree,
+	.reconfigure	= pstore_reconfigure,
+};
+
+static int pstore_init_fs_context(struct fs_context *fc)
+{
+	struct pstore_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct pstore_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	fc->fs_private = ctx;
+	fc->ops = &pstore_context_ops;
+	return 0;
 }
 
 static void pstore_kill_sb(struct super_block *sb)
@@ -435,7 +467,8 @@ static void pstore_kill_sb(struct super_block *sb)
 static struct file_system_type pstore_fs_type = {
 	.owner          = THIS_MODULE,
 	.name		= "pstore",
-	.mount		= pstore_mount,
+	.init_fs_context = pstore_init_fs_context,
+	.parameters	= &pstore_fs_parameters,
 	.kill_sb	= pstore_kill_sb,
 };
 

