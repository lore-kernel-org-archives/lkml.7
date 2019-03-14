Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D42C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631F52184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfCNQKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:10:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbfCNQKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:10:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6BA2A757D2;
        Thu, 14 Mar 2019 16:10:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A76E35C21F;
        Thu, 14 Mar 2019 16:10:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/38] vfs: Convert dax to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 16:10:16 +0000
Message-ID: <155257981689.13720.12884353658173264997.stgit@warthog.procyon.org.uk>
In-Reply-To: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 14 Mar 2019 16:10:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Dan Williams <dan.j.williams@intel.com>
cc: Vishal Verma <vishal.l.verma@intel.com>
cc: Keith Busch <keith.busch@intel.com>
cc: Dave Jiang <dave.jiang@intel.com>
cc: linux-nvdimm@lists.01.org
---

 drivers/dax/super.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0cb8c30ea278..40a9e665be32 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -13,6 +13,7 @@
 #include <linux/pagemap.h>
 #include <linux/module.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/magic.h>
 #include <linux/genhd.h>
 #include <linux/pfn_t.h>
@@ -435,16 +436,16 @@ static const struct super_operations dax_sops = {
 	.drop_inode = generic_delete_inode,
 };
 
-static struct dentry *dax_mount(struct file_system_type *fs_type,
-		int flags, const char *dev_name, void *data)
+static int dax_init_fs_context(struct fs_context *fc)
 {
-	return mount_pseudo(fs_type, "dax:", &dax_sops, NULL, DAXFS_MAGIC);
+	return vfs_init_pseudo_fs_context(fc, "dax:",
+					  &dax_sops, NULL, NULL, DAXFS_MAGIC);
 }
 
 static struct file_system_type dax_fs_type = {
-	.name = "dax",
-	.mount = dax_mount,
-	.kill_sb = kill_anon_super,
+	.name		= "dax",
+	.init_fs_context = dax_init_fs_context,
+	.kill_sb	= kill_anon_super,
 };
 
 static int dax_test(struct inode *inode, void *data)

