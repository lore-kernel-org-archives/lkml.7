Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE06C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C2720651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbfC0Xok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:44:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfC0Xoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:44:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4CD630FE5B9;
        Wed, 27 Mar 2019 23:44:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94ED760589;
        Wed, 27 Mar 2019 23:44:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 32/68] vfs: Convert ibmasmfs to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:44:34 +0000
Message-ID: <155373027484.7602.9446083590236560498.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 27 Mar 2019 23:44:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ibmasmfs filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

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
 

