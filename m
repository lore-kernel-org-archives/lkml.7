Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EA4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17382075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbfC0XnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:43:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730978AbfC0XnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:43:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4946A309266B;
        Wed, 27 Mar 2019 23:43:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76CF562699;
        Wed, 27 Mar 2019 23:43:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 21/68] vfs: Use sget_fc() for pseudo-filesystems
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:43:13 +0000
Message-ID: <155373019372.7602.3546094909660562519.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 27 Mar 2019 23:43:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-fsdevel@vger.kernel.org
---

 fs/libfs.c |   25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 9a15590b65da..f6710316de00 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -242,18 +242,12 @@ struct pseudo_fs_context {
 	unsigned long magic;
 };
 
-static int pseudo_fs_get_tree(struct fs_context *fc)
+static int pseudo_fs_fill_super(struct super_block *s, struct fs_context *fc)
 {
 	struct pseudo_fs_context *ctx = fc->fs_private;
-	struct super_block *s;
 	struct dentry *dentry;
 	struct inode *root;
 
-	s = sget_userns(fc->fs_type, NULL, set_anon_super, SB_KERNMOUNT|SB_NOUSER,
-			&init_user_ns, NULL);
-	if (IS_ERR(s))
-		return PTR_ERR(s);
-
 	s->s_maxbytes = MAX_LFS_FILESIZE;
 	s->s_blocksize = PAGE_SIZE;
 	s->s_blocksize_bits = PAGE_SHIFT;
@@ -263,7 +257,8 @@ static int pseudo_fs_get_tree(struct fs_context *fc)
 	s->s_time_gran = 1;
 	root = new_inode(s);
 	if (!root)
-		goto Enomem;
+		return -ENOMEM;
+
 	/*
 	 * since this is the first inode, make it number 1. New inodes created
 	 * after this must take care not to collide with it (by passing
@@ -275,18 +270,17 @@ static int pseudo_fs_get_tree(struct fs_context *fc)
 	dentry = __d_alloc(s, &ctx->d_name);
 	if (!dentry) {
 		iput(root);
-		goto Enomem;
+		return -ENOMEM;
 	}
 	d_instantiate(dentry, root);
 	s->s_root = dentry;
 	s->s_d_op = ctx->dops;
-	s->s_flags |= SB_ACTIVE;
-	fc->root = dget(s->s_root);
 	return 0;
+}
 
-Enomem:
-	deactivate_locked_super(s);
-	return -ENOMEM;
+static int pseudo_fs_get_tree(struct fs_context *fc)
+{
+	return vfs_get_super(fc, vfs_get_independent_super, pseudo_fs_fill_super);
 }
 
 static void pseudo_fs_free(struct fs_context *fc)
@@ -320,6 +314,9 @@ int vfs_init_pseudo_fs_context(struct fs_context *fc,
 	ctx->xattr = xattr;
 	ctx->dops = dops;
 	ctx->magic = magic;
+
+	fc->sb_flags = SB_KERNMOUNT | SB_NOUSER;
+	fc->global = true;
 	fc->fs_private = ctx;
 	fc->ops = &pseudo_fs_context_ops;
 	return 0;

