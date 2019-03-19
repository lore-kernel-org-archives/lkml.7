Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D11C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2F520857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfCSQX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:23:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727810AbfCSQX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:23:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0EE593082231;
        Tue, 19 Mar 2019 16:23:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-47.rdu2.redhat.com [10.10.120.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A07A129175;
        Tue, 19 Mar 2019 16:23:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 4/4] fuse: Move the subtype parameter into fuse
From:   David Howells <dhowells@redhat.com>
To:     miklos@szeredi.hu, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, anprice@redhat.com
Date:   Tue, 19 Mar 2019 16:23:53 +0000
Message-ID: <155301263386.7556.6722703415894365051.stgit@warthog.procyon.org.uk>
In-Reply-To: <155301260319.7556.1326405089184672936.stgit@warthog.procyon.org.uk>
References: <155301260319.7556.1326405089184672936.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 19 Mar 2019 16:23:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move as much as possible of the mount subtype apparatus into the fuse
driver.  The bits that are left involve determining whether it's permitted
to split the filesystem type string passed in to mount(2).  Consequently,
this means that we cannot get rid of the FS_HAS_SUBTYPE flag unless we
define that a type string with a dot in in always indicates a subtype
specification.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fs_context.c            |   12 ------------
 fs/fuse/inode.c            |   21 +++++++++++++++++++--
 fs/super.c                 |    5 -----
 include/linux/fs_context.h |    1 -
 4 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index ea027762c0b2..3325b435cb6f 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -432,7 +432,6 @@ void put_fs_context(struct fs_context *fc)
 	put_net(fc->net_ns);
 	put_user_ns(fc->user_ns);
 	put_cred(fc->cred);
-	kfree(fc->subtype);
 	put_filesystem(fc->fs_type);
 	kfree(fc->source);
 	kfree(fc);
@@ -498,17 +497,6 @@ static int legacy_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		return 0;
 	}
 
-	if ((fc->fs_type->fs_flags & FS_HAS_SUBTYPE) &&
-	    strcmp(param->key, "subtype") == 0) {
-		if (param->type != fs_value_is_string)
-			return invalf(fc, "VFS: Legacy: Non-string subtype");
-		if (fc->subtype)
-			return invalf(fc, "VFS: Legacy: Multiple subtype");
-		fc->subtype = param->string;
-		param->string = NULL;
-		return 0;
-	}
-
 	if (ctx->param_type == LEGACY_FS_MONOLITHIC_PARAMS)
 		return invalf(fc, "VFS: Legacy: Can't mix monolithic and individual options");
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3aebff5b902a..d830b20252f7 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -65,6 +65,7 @@ static struct file_system_type fuseblk_fs_type;
 #endif
 
 struct fuse_fs_context {
+	const char	*subtype;
 	bool		is_bdev;
 	int fd;
 	unsigned rootmode;
@@ -455,6 +456,7 @@ static int fuse_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 enum {
 	OPT_SOURCE,
+	OPT_SUBTYPE,
 	OPT_FD,
 	OPT_ROOTMODE,
 	OPT_USER_ID,
@@ -468,6 +470,7 @@ enum {
 
 static const struct fs_parameter_spec fuse_param_specs[] = {
 	fsparam_string	("source",		OPT_SOURCE),
+	fsparam_string	("subtype",		OPT_SUBTYPE),
 	fsparam_fd	("fd",			OPT_FD),
 	fsparam_u32oct	("rootmode",		OPT_ROOTMODE),
 	fsparam_u32	("user_id",		OPT_USER_ID),
@@ -496,11 +499,19 @@ static int fuse_parse_param(struct fs_context *fc, struct fs_parameter *param)
 
 	switch (opt) {
 	case OPT_SOURCE:
-		kfree(fc->source);
+		if (fc->source)
+			return invalf(fc, "fuse: Multiple sources specified");
 		fc->source = param->string;
 		param->string = NULL;
 		break;
 
+	case OPT_SUBTYPE:
+		if (ctx->subtype)
+			return invalf(fc, "fuse: Multiple subtypes specified");
+		ctx->subtype = param->string;
+		param->string = NULL;
+		return 0;
+
 	case OPT_FD:
 		ctx->fd = result.uint_32;
 		ctx->fd_present = 1;
@@ -556,7 +567,10 @@ static void fuse_free_fc(struct fs_context *fc)
 {
 	struct fuse_fs_context *ctx = fc->fs_private;
 
-	kfree(ctx);
+	if (ctx) {
+		kfree(ctx->subtype);
+		kfree(ctx);
+	}
 }
 
 static int fuse_show_options(struct seq_file *m, struct dentry *root)
@@ -1099,6 +1113,9 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 		sb->s_blocksize = PAGE_SIZE;
 		sb->s_blocksize_bits = PAGE_SHIFT;
 	}
+
+	sb->s_subtype = ctx->subtype;
+	ctx->subtype = NULL;
 	sb->s_magic = FUSE_SUPER_MAGIC;
 	sb->s_op = &fuse_super_operations;
 	sb->s_xattr = fuse_xattr_handlers;
diff --git a/fs/super.c b/fs/super.c
index 85851adb0f19..6d8dbf309241 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1536,11 +1536,6 @@ int vfs_get_tree(struct fs_context *fc)
 	sb = fc->root->d_sb;
 	WARN_ON(!sb->s_bdi);
 
-	if (fc->subtype && !sb->s_subtype) {
-		sb->s_subtype = fc->subtype;
-		fc->subtype = NULL;
-	}
-
 	/*
 	 * Write barrier is for super_cache_count(). We place it before setting
 	 * SB_BORN as the data dependency between the two functions is the
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index cb49b92f02af..524963c0cedb 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -82,7 +82,6 @@ struct fs_context {
 	struct net		*net_ns;	/* The network namespace for this mount */
 	const struct cred	*cred;		/* The mounter's credentials */
 	const char		*source;	/* The source name (eg. dev path) */
-	const char		*subtype;	/* The subtype to set on the superblock */
 	void			*security;	/* Linux S&M options */
 	void			*s_fs_info;	/* Proposed s_fs_info */
 	fmode_t			bdev_mode;	/* File open mode for bdev */

