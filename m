Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73069C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD9320651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbfC0Xoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:44:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfC0Xoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:44:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DCB7E2D7F9;
        Wed, 27 Mar 2019 23:44:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF7E95D9C4;
        Wed, 27 Mar 2019 23:44:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 33/68] vfs: Convert oprofilefs to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Robert Richter <rric@kernel.org>, oprofile-list@lists.sf.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:44:42 +0000
Message-ID: <155373028202.7602.3952705593898940363.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 27 Mar 2019 23:44:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the oprofilefs filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Robert Richter <rric@kernel.org>
cc: oprofile-list@lists.sf.net
---

 drivers/oprofile/oprofilefs.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/oprofile/oprofilefs.c b/drivers/oprofile/oprofilefs.c
index 4ea08979312c..d83fcd39ee55 100644
--- a/drivers/oprofile/oprofilefs.c
+++ b/drivers/oprofile/oprofilefs.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/oprofile.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
 #include <linux/pagemap.h>
 #include <linux/uaccess.h>
 
@@ -238,7 +239,7 @@ struct dentry *oprofilefs_mkdir(struct dentry *parent, char const *name)
 }
 
 
-static int oprofilefs_fill_super(struct super_block *sb, void *data, int silent)
+static int oprofilefs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *root_inode;
 
@@ -263,18 +264,25 @@ static int oprofilefs_fill_super(struct super_block *sb, void *data, int silent)
 	return 0;
 }
 
-
-static struct dentry *oprofilefs_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int oprofilefs_get_tree(struct fs_context *fc)
 {
-	return mount_single(fs_type, flags, data, oprofilefs_fill_super);
+	return vfs_get_super(fc, vfs_get_single_super, oprofilefs_fill_super);
 }
 
+static const struct fs_context_operations oprofilefs_context_ops = {
+	.get_tree	= oprofilefs_get_tree,
+};
+
+static int oprofilefs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &oprofilefs_context_ops;
+	return 0;
+}
 
 static struct file_system_type oprofilefs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "oprofilefs",
-	.mount		= oprofilefs_mount,
+	.init_fs_context = oprofilefs_init_fs_context,
 	.kill_sb	= kill_litter_super,
 };
 MODULE_ALIAS_FS("oprofilefs");

