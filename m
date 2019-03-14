Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426D3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1984D2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfCNQNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:13:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13173 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfCNQNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:13:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A95DC007358;
        Thu, 14 Mar 2019 16:13:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D598620CC;
        Thu, 14 Mar 2019 16:12:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 30/38] vfs: Convert oprofilefs to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Robert Richter <rric@kernel.org>, oprofile-list@lists.sf.net,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 16:12:58 +0000
Message-ID: <155257997844.13720.4532474218095393341.stgit@warthog.procyon.org.uk>
In-Reply-To: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 14 Mar 2019 16:13:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

