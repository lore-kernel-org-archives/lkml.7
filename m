Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BAEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7E520651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbfC0Xoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:44:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55631 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfC0Xoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:44:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C6BB30B24F6;
        Wed, 27 Mar 2019 23:44:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58F555D9C4;
        Wed, 27 Mar 2019 23:44:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 31/68] vfs: Convert qib_fs/ipathfs to use the new mount
 API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        linux-rdma@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:44:27 +0000
Message-ID: <155373026764.7602.420612273283807556.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 27 Mar 2019 23:44:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the qib_fs/ipathfs filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

[Q] Can qib_remove() race with qibfs_kill_super()?  Should qib_super
    accesses be serialised with some sort of lock?

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
cc: linux-rdma@vger.kernel.org
---

 drivers/infiniband/hw/qib/qib_fs.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index 1d940a2885c9..fc4f62a248a1 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -34,6 +34,7 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
@@ -506,7 +507,7 @@ static int remove_device_files(struct super_block *sb,
  * after device init.  The direct add_cntr_files() call handles adding
  * them from the init code, when the fs is already mounted.
  */
-static int qibfs_fill_super(struct super_block *sb, void *data, int silent)
+static int qibfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct qib_devdata *dd, *tmp;
 	unsigned long flags;
@@ -540,17 +541,26 @@ static int qibfs_fill_super(struct super_block *sb, void *data, int silent)
 	return ret;
 }
 
-static struct dentry *qibfs_mount(struct file_system_type *fs_type, int flags,
-			const char *dev_name, void *data)
+static int qibfs_get_tree(struct fs_context *fc)
 {
-	struct dentry *ret;
+	int ret;
 
-	ret = mount_single(fs_type, flags, data, qibfs_fill_super);
-	if (!IS_ERR(ret))
-		qib_super = ret->d_sb;
+	ret = vfs_get_super(fc, vfs_get_single_super, qibfs_fill_super);
+	if (ret == 0)
+		qib_super = fc->root->d_sb;
 	return ret;
 }
 
+static const struct fs_context_operations qibfs_context_ops = {
+	.get_tree	= qibfs_get_tree,
+};
+
+static int qibfs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &qibfs_context_ops;
+	return 0;
+}
+
 static void qibfs_kill_super(struct super_block *s)
 {
 	kill_litter_super(s);
@@ -589,7 +599,7 @@ int qibfs_remove(struct qib_devdata *dd)
 static struct file_system_type qibfs_fs_type = {
 	.owner =        THIS_MODULE,
 	.name =         "ipathfs",
-	.mount =        qibfs_mount,
+	.init_fs_context = qibfs_init_fs_context,
 	.kill_sb =      qibfs_kill_super,
 };
 MODULE_ALIAS_FS("ipathfs");

