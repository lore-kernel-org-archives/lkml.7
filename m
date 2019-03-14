Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FE6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A042184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfCNQNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:13:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfCNQNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:13:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F688307AD0D;
        Thu, 14 Mar 2019 16:13:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC0D760F87;
        Thu, 14 Mar 2019 16:13:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 32/38] vfs: Convert xenfs to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 16:13:14 +0000
Message-ID: <155257999413.13720.1305392427435118436.stgit@warthog.procyon.org.uk>
In-Reply-To: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 14 Mar 2019 16:13:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
cc: Juergen Gross <jgross@suse.com>
cc: Stefano Stabellini <sstabellini@kernel.org>
cc: xen-devel@lists.xenproject.org
---

 drivers/xen/xenfs/super.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/xenfs/super.c b/drivers/xen/xenfs/super.c
index 71ddfb4cf61c..2e16214e9c7f 100644
--- a/drivers/xen/xenfs/super.c
+++ b/drivers/xen/xenfs/super.c
@@ -13,6 +13,7 @@
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
 #include <linux/magic.h>
 
 #include <xen/xen.h>
@@ -42,7 +43,7 @@ static const struct file_operations capabilities_file_ops = {
 	.llseek = default_llseek,
 };
 
-static int xenfs_fill_super(struct super_block *sb, void *data, int silent)
+static int xenfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	static const struct tree_descr xenfs_files[] = {
 		[2] = { "xenbus", &xen_xenbus_fops, S_IRUSR|S_IWUSR },
@@ -67,17 +68,25 @@ static int xenfs_fill_super(struct super_block *sb, void *data, int silent)
 			xen_initial_domain() ? xenfs_init_files : xenfs_files);
 }
 
-static struct dentry *xenfs_mount(struct file_system_type *fs_type,
-				  int flags, const char *dev_name,
-				  void *data)
+static int xenfs_get_tree(struct fs_context *fc)
 {
-	return mount_single(fs_type, flags, data, xenfs_fill_super);
+	return vfs_get_super(fc, vfs_get_single_super, xenfs_fill_super);
+}
+
+static const struct fs_context_operations xenfs_context_ops = {
+	.get_tree	= xenfs_get_tree,
+};
+
+static int xenfs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &xenfs_context_ops;
+	return 0;
 }
 
 static struct file_system_type xenfs_type = {
 	.owner =	THIS_MODULE,
 	.name =		"xenfs",
-	.mount =	xenfs_mount,
+	.init_fs_context = xenfs_init_fs_context,
 	.kill_sb =	kill_litter_super,
 };
 MODULE_ALIAS_FS("xenfs");

