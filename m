Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446E3C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B672217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfCNQMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:12:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfCNQMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:12:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D2AF3082B40;
        Thu, 14 Mar 2019 16:12:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5B1745C2;
        Thu, 14 Mar 2019 16:12:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 25/38] vfs: Convert configfs to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 16:12:12 +0000
Message-ID: <155257993209.13720.11471841142418330060.stgit@warthog.procyon.org.uk>
In-Reply-To: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 14 Mar 2019 16:12:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Joel Becker <jlbec@evilplan.org>
cc: Christoph Hellwig <hch@lst.de>
---

 fs/configfs/mount.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index cfd91320e869..af4db09f46b4 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -27,6 +27,7 @@
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -66,7 +67,7 @@ static struct configfs_dirent configfs_root = {
 	.s_iattr	= NULL,
 };
 
-static int configfs_fill_super(struct super_block *sb, void *data, int silent)
+static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
 	struct dentry *root;
@@ -102,16 +103,25 @@ static int configfs_fill_super(struct super_block *sb, void *data, int silent)
 	return 0;
 }
 
-static struct dentry *configfs_do_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int configfs_get_tree(struct fs_context *fc)
 {
-	return mount_single(fs_type, flags, data, configfs_fill_super);
+	return vfs_get_super(fc, vfs_get_single_super, configfs_fill_super);
+}
+
+static const struct fs_context_operations configfs_context_ops = {
+	.get_tree	= configfs_get_tree,
+};
+
+static int configfs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &configfs_context_ops;
+	return 0;
 }
 
 static struct file_system_type configfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "configfs",
-	.mount		= configfs_do_mount,
+	.init_fs_context = configfs_init_fs_context,
 	.kill_sb	= kill_litter_super,
 };
 MODULE_ALIAS_FS("configfs");

