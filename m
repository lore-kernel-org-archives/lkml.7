Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC94C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F60217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfCNQMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:12:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfCNQMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:12:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 425C63005FCB;
        Thu, 14 Mar 2019 16:12:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8EF617DCF;
        Thu, 14 Mar 2019 16:12:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 28/38] vfs: Convert qib_fs/ipathfs to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        linux-rdma@vger.kernel.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 16:12:36 +0000
Message-ID: <155257995679.13720.15998651209647465846.stgit@warthog.procyon.org.uk>
In-Reply-To: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 14 Mar 2019 16:12:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

