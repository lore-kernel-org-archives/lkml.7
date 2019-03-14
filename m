Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B4FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A4E217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfCNQMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:12:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfCNQMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:12:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A5F73144A19;
        Thu, 14 Mar 2019 16:12:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4507A62508;
        Thu, 14 Mar 2019 16:12:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 29/38] vfs: Convert ibmasmfs to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 16:12:47 +0000
Message-ID: <155257996750.13720.15137615257711612407.stgit@warthog.procyon.org.uk>
In-Reply-To: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 14 Mar 2019 16:12:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Arnd Bergmann <arnd@arndb.de>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 drivers/misc/ibmasm/ibmasmfs.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/ibmasm/ibmasmfs.c b/drivers/misc/ibmasm/ibmasmfs.c
index fa840666bdd1..e615f335db99 100644
--- a/drivers/misc/ibmasm/ibmasmfs.c
+++ b/drivers/misc/ibmasm/ibmasmfs.c
@@ -74,6 +74,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/fs_context.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -88,13 +89,21 @@ static LIST_HEAD(service_processors);
 
 static struct inode *ibmasmfs_make_inode(struct super_block *sb, int mode);
 static void ibmasmfs_create_files (struct super_block *sb);
-static int ibmasmfs_fill_super (struct super_block *sb, void *data, int silent);
+static int ibmasmfs_fill_super(struct super_block *sb, struct fs_context *fc);
 
+static int ibmasmfs_get_tree(struct fs_context *fc)
+{
+	return vfs_get_super(fc, vfs_get_single_super, ibmasmfs_fill_super);
+}
 
-static struct dentry *ibmasmfs_mount(struct file_system_type *fst,
-			int flags, const char *name, void *data)
+static const struct fs_context_operations ibmasmfs_context_ops = {
+	.get_tree	= ibmasmfs_get_tree,
+};
+
+static int ibmasmfs_init_fs_context(struct fs_context *fc)
 {
-	return mount_single(fst, flags, data, ibmasmfs_fill_super);
+	fc->ops = &ibmasmfs_context_ops;
+	return 0;
 }
 
 static const struct super_operations ibmasmfs_s_ops = {
@@ -107,12 +116,12 @@ static const struct file_operations *ibmasmfs_dir_ops = &simple_dir_operations;
 static struct file_system_type ibmasmfs_type = {
 	.owner          = THIS_MODULE,
 	.name           = "ibmasmfs",
-	.mount          = ibmasmfs_mount,
+	.init_fs_context = ibmasmfs_init_fs_context,
 	.kill_sb        = kill_litter_super,
 };
 MODULE_ALIAS_FS("ibmasmfs");
 
-static int ibmasmfs_fill_super (struct super_block *sb, void *data, int silent)
+static int ibmasmfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *root;
 

