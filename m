Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E10C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EA92184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfCNQKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:10:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfCNQKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:10:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49F093087E6D;
        Thu, 14 Mar 2019 16:10:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 749011001DEA;
        Thu, 14 Mar 2019 16:10:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 14/38] vfs: Convert ocxlflash to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 16:10:47 +0000
Message-ID: <155257984771.13720.11148732281013314260.stgit@warthog.procyon.org.uk>
In-Reply-To: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 14 Mar 2019 16:10:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Howells <dhowells@redhat.com>
cc: "Manoj N. Kumar" <manoj@linux.ibm.com>
cc: "Matthew R. Ochs" <mrochs@linux.ibm.com>
cc: Uma Krishnan <ukrishn@linux.ibm.com>
cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
cc: "Martin K. Petersen" <martin.petersen@oracle.com>
cc: linux-scsi@vger.kernel.org
---

 drivers/scsi/cxlflash/ocxl_hw.c |   21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 37b8dc60f5f6..a8d2cc6390c7 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -16,6 +16,7 @@
 #include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/poll.h>
 #include <linux/sched/signal.h>
 
@@ -39,27 +40,17 @@ static const struct dentry_operations ocxlflash_fs_dops = {
 	.d_dname	= simple_dname,
 };
 
-/*
- * ocxlflash_fs_mount() - mount the pseudo-filesystem
- * @fs_type:	File system type.
- * @flags:	Flags for the filesystem.
- * @dev_name:	Device name associated with the filesystem.
- * @data:	Data pointer.
- *
- * Return: pointer to the directory entry structure
- */
-static struct dentry *ocxlflash_fs_mount(struct file_system_type *fs_type,
-					 int flags, const char *dev_name,
-					 void *data)
+static int ocxlflash_fs_init_fs_context(struct fs_context *fc)
 {
-	return mount_pseudo(fs_type, "ocxlflash:", NULL, &ocxlflash_fs_dops,
-			    OCXLFLASH_FS_MAGIC);
+	return vfs_init_pseudo_fs_context(fc, "ocxlflash:",
+					  NULL, NULL,
+					  &ocxlflash_fs_dops, OCXLFLASH_FS_MAGIC);
 }
 
 static struct file_system_type ocxlflash_fs_type = {
 	.name		= "ocxlflash",
 	.owner		= THIS_MODULE,
-	.mount		= ocxlflash_fs_mount,
+	.init_fs_context = ocxlflash_fs_init_fs_context,
 	.kill_sb	= kill_anon_super,
 };
 

