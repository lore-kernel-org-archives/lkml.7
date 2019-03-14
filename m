Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EA1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE482184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbfCNQNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:13:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbfCNQNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:13:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 362273C712;
        Thu, 14 Mar 2019 16:13:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A052282EA;
        Thu, 14 Mar 2019 16:13:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 33/38] vfs: Convert openpromfs to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 16:13:21 +0000
Message-ID: <155258000161.13720.10058849451002839171.stgit@warthog.procyon.org.uk>
In-Reply-To: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 14 Mar 2019 16:13:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/openpromfs/inode.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 1b2d0d2fe2ee..7ec384df0109 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/seq_file.h>
@@ -380,7 +381,7 @@ static const struct super_operations openprom_sops = {
 	.remount_fs	= openprom_remount,
 };
 
-static int openprom_fill_super(struct super_block *s, void *data, int silent)
+static int openprom_fill_super(struct super_block *s, struct fs_context *fc)
 {
 	struct inode *root_inode;
 	struct op_inode_info *oi;
@@ -414,16 +415,25 @@ static int openprom_fill_super(struct super_block *s, void *data, int silent)
 	return ret;
 }
 
-static struct dentry *openprom_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int openpromfs_get_tree(struct fs_context *fc)
 {
-	return mount_single(fs_type, flags, data, openprom_fill_super);
+	return vfs_get_super(fc, vfs_get_single_super, openprom_fill_super);
+}
+
+static const struct fs_context_operations openpromfs_context_ops = {
+	.get_tree	= openpromfs_get_tree,
+};
+
+static int openpromfs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &openpromfs_context_ops;
+	return 0;
 }
 
 static struct file_system_type openprom_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "openpromfs",
-	.mount		= openprom_mount,
+	.init_fs_context = openpromfs_init_fs_context,
 	.kill_sb	= kill_anon_super,
 };
 MODULE_ALIAS_FS("openpromfs");

