Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C98C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A610B2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfCNQNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:13:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfCNQNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:13:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DCCA4C070142;
        Thu, 14 Mar 2019 16:13:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A32A16BF8C;
        Thu, 14 Mar 2019 16:13:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 31/38] vfs: Convert gadgetfs to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 16:13:06 +0000
Message-ID: <155257998686.13720.8551460564620091523.stgit@warthog.procyon.org.uk>
In-Reply-To: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 14 Mar 2019 16:13:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Felipe Balbi <balbi@kernel.org>
cc: linux-usb@vger.kernel.org
---

 drivers/usb/gadget/legacy/inode.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 249277d0e53f..441da16ffc39 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
 #include <linux/pagemap.h>
 #include <linux/uts.h>
 #include <linux/wait.h>
@@ -1990,7 +1991,7 @@ static const struct super_operations gadget_fs_operations = {
 };
 
 static int
-gadgetfs_fill_super (struct super_block *sb, void *opts, int silent)
+gadgetfs_fill_super (struct super_block *sb, struct fs_context *fc)
 {
 	struct inode	*inode;
 	struct dev_data	*dev;
@@ -2044,11 +2045,19 @@ gadgetfs_fill_super (struct super_block *sb, void *opts, int silent)
 }
 
 /* "mount -t gadgetfs path /dev/gadget" ends up here */
-static struct dentry *
-gadgetfs_mount (struct file_system_type *t, int flags,
-		const char *path, void *opts)
+static int gadgetfs_get_tree(struct fs_context *fc)
 {
-	return mount_single (t, flags, opts, gadgetfs_fill_super);
+	return vfs_get_super(fc, vfs_get_single_super, gadgetfs_fill_super);
+}
+
+static const struct fs_context_operations gadgetfs_context_ops = {
+	.get_tree	= gadgetfs_get_tree,
+};
+
+static int gadgetfs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &gadgetfs_context_ops;
+	return 0;
 }
 
 static void
@@ -2068,7 +2077,7 @@ gadgetfs_kill_sb (struct super_block *sb)
 static struct file_system_type gadgetfs_type = {
 	.owner		= THIS_MODULE,
 	.name		= shortname,
-	.mount		= gadgetfs_mount,
+	.init_fs_context = gadgetfs_init_fs_context,
 	.kill_sb	= gadgetfs_kill_sb,
 };
 MODULE_ALIAS_FS("gadgetfs");

