Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A17DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547FA217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfCNQMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:12:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727568AbfCNQMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:12:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F57410FB2;
        Thu, 14 Mar 2019 16:12:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89FBD605CA;
        Thu, 14 Mar 2019 16:12:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 27/38] vfs: Convert fusectl to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 16:12:29 +0000
Message-ID: <155257994981.13720.5610815718387210460.stgit@warthog.procyon.org.uk>
In-Reply-To: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 14 Mar 2019 16:12:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-fsdevel@vger.kernel.org
---

 fs/fuse/control.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index fe80bea4ad89..14ce1e47f980 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -10,6 +10,7 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/fs_context.h>
 
 #define FUSE_CTL_SUPER_MAGIC 0x65735543
 
@@ -317,7 +318,7 @@ void fuse_ctl_remove_conn(struct fuse_conn *fc)
 	drop_nlink(d_inode(fuse_control_sb->s_root));
 }
 
-static int fuse_ctl_fill_super(struct super_block *sb, void *data, int silent)
+static int fuse_ctl_fill_super(struct super_block *sb, struct fs_context *fctx)
 {
 	static const struct tree_descr empty_descr = {""};
 	struct fuse_conn *fc;
@@ -343,10 +344,19 @@ static int fuse_ctl_fill_super(struct super_block *sb, void *data, int silent)
 	return 0;
 }
 
-static struct dentry *fuse_ctl_mount(struct file_system_type *fs_type,
-			int flags, const char *dev_name, void *raw_data)
+static int fuse_ctl_get_tree(struct fs_context *fc)
 {
-	return mount_single(fs_type, flags, raw_data, fuse_ctl_fill_super);
+	return vfs_get_super(fc, vfs_get_single_super, fuse_ctl_fill_super);
+}
+
+static const struct fs_context_operations fuse_ctl_context_ops = {
+	.get_tree	= fuse_ctl_get_tree,
+};
+
+static int fuse_ctl_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &fuse_ctl_context_ops;
+	return 0;
 }
 
 static void fuse_ctl_kill_sb(struct super_block *sb)
@@ -365,7 +375,7 @@ static void fuse_ctl_kill_sb(struct super_block *sb)
 static struct file_system_type fuse_ctl_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "fusectl",
-	.mount		= fuse_ctl_mount,
+	.init_fs_context = fuse_ctl_init_fs_context,
 	.kill_sb	= fuse_ctl_kill_sb,
 };
 MODULE_ALIAS_FS("fusectl");

