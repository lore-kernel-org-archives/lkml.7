Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67267C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECD020651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387832AbfC0Xsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:48:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbfC0Xsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:48:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A692330642A8;
        Wed, 27 Mar 2019 23:48:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8333819C5A;
        Wed, 27 Mar 2019 23:48:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 65/68] vfs: Convert bpf to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:48:48 +0000
Message-ID: <155373052878.7602.14285941854686957081.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 27 Mar 2019 23:48:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the bpf filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexei Starovoitov <ast@kernel.org>
cc: Daniel Borkmann <daniel@iogearbox.net>
cc: Martin KaFai Lau <kafai@fb.com>
cc: Song Liu <songliubraving@fb.com>
cc: Yonghong Song <yhs@fb.com>
cc: netdev@vger.kernel.org
cc: bpf@vger.kernel.org
---

 kernel/bpf/inode.c |   92 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 34 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 2ada5e21dfa6..8ea3a1f11e10 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -17,8 +17,9 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/kdev_t.h>
-#include <linux/parser.h>
 #include <linux/filter.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
@@ -588,58 +589,52 @@ static const struct super_operations bpf_super_ops = {
 
 enum {
 	OPT_MODE,
-	OPT_ERR,
 };
 
-static const match_table_t bpf_mount_tokens = {
-	{ OPT_MODE, "mode=%o" },
-	{ OPT_ERR, NULL },
+static const struct fs_parameter_spec bpf_param_specs[] = {
+	fsparam_u32oct	("mode",			OPT_MODE),
+	{}
+};
+
+static const struct fs_parameter_description bpf_fs_parameters = {
+	.name		= "bpf",
+	.specs		= bpf_param_specs,
 };
 
 struct bpf_mount_opts {
 	umode_t mode;
 };
 
-static int bpf_parse_options(char *data, struct bpf_mount_opts *opts)
+static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	substring_t args[MAX_OPT_ARGS];
-	int option, token;
-	char *ptr;
+	struct bpf_mount_opts *opts = fc->fs_private;
+	struct fs_parse_result result;
+	int opt;
 
-	opts->mode = S_IRWXUGO;
-
-	while ((ptr = strsep(&data, ",")) != NULL) {
-		if (!*ptr)
-			continue;
-
-		token = match_token(ptr, bpf_mount_tokens, args);
-		switch (token) {
-		case OPT_MODE:
-			if (match_octal(&args[0], &option))
-				return -EINVAL;
-			opts->mode = option & S_IALLUGO;
-			break;
+	opt = fs_parse(fc, &bpf_fs_parameters, param, &result);
+	if (opt < 0)
 		/* We might like to report bad mount options here, but
 		 * traditionally we've ignored all mount options, so we'd
 		 * better continue to ignore non-existing options for bpf.
 		 */
-		}
+		return opt == -ENOPARAM ? 0 : opt;
+
+	switch (opt) {
+	case OPT_MODE:
+		opts->mode = result.uint_32 & S_IALLUGO;
+		break;
 	}
 
 	return 0;
 }
 
-static int bpf_fill_super(struct super_block *sb, void *data, int silent)
+static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	static const struct tree_descr bpf_rfiles[] = { { "" } };
-	struct bpf_mount_opts opts;
+	struct bpf_mount_opts *opts = fc->fs_private;
 	struct inode *inode;
 	int ret;
 
-	ret = bpf_parse_options(data, &opts);
-	if (ret)
-		return ret;
-
 	ret = simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
 	if (ret)
 		return ret;
@@ -649,21 +644,50 @@ static int bpf_fill_super(struct super_block *sb, void *data, int silent)
 	inode = sb->s_root->d_inode;
 	inode->i_op = &bpf_dir_iops;
 	inode->i_mode &= ~S_IALLUGO;
-	inode->i_mode |= S_ISVTX | opts.mode;
+	inode->i_mode |= S_ISVTX | opts->mode;
 
 	return 0;
 }
 
-static struct dentry *bpf_mount(struct file_system_type *type, int flags,
-				const char *dev_name, void *data)
+static int bpf_get_tree(struct fs_context *fc)
+{
+	return vfs_get_super(fc, vfs_get_independent_super, bpf_fill_super);
+}
+
+static void bpf_free_fc(struct fs_context *fc)
 {
-	return mount_nodev(type, flags, data, bpf_fill_super);
+	kfree(fc->fs_private);
+}
+
+static const struct fs_context_operations bpf_context_ops = {
+	.free		= bpf_free_fc,
+	.parse_param	= bpf_parse_param,
+	.get_tree	= bpf_get_tree,
+};
+
+/*
+ * Set up the filesystem mount context.
+ */
+static int bpf_init_fs_context(struct fs_context *fc)
+{
+	struct bpf_mount_opts *opts;
+
+	opts = kzalloc(sizeof(struct bpf_mount_opts), GFP_KERNEL);
+	if (!opts)
+		return -ENOMEM;
+
+	opts->mode = S_IRWXUGO;
+
+	fc->fs_private = opts;
+	fc->ops = &bpf_context_ops;
+	return 0;
 }
 
 static struct file_system_type bpf_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "bpf",
-	.mount		= bpf_mount,
+	.init_fs_context = bpf_init_fs_context,
+	.parameters	= &bpf_fs_parameters,
 	.kill_sb	= kill_litter_super,
 };
 

