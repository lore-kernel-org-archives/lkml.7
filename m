Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77395C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C9A2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfCNQJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:09:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbfCNQJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:09:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A37873001C71;
        Thu, 14 Mar 2019 16:09:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2B1F17CEB;
        Thu, 14 Mar 2019 16:09:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/38] vfs: Convert bdev to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 16:09:39 +0000
Message-ID: <155257977902.13720.3208777626792774538.stgit@warthog.procyon.org.uk>
In-Reply-To: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 14 Mar 2019 16:09:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: linux-fsdevel@vger.kernel.org
---

 fs/block_dev.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index e9faa52bb489..2846970b5415 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -25,6 +25,7 @@
 #include <linux/writeback.h>
 #include <linux/mpage.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/uio.h>
 #include <linux/namei.h>
 #include <linux/log2.h>
@@ -842,19 +843,16 @@ static const struct super_operations bdev_sops = {
 	.evict_inode = bdev_evict_inode,
 };
 
-static struct dentry *bd_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int bd_init_fs_context(struct fs_context *fc)
 {
-	struct dentry *dent;
-	dent = mount_pseudo(fs_type, "bdev:", &bdev_sops, NULL, BDEVFS_MAGIC);
-	if (!IS_ERR(dent))
-		dent->d_sb->s_iflags |= SB_I_CGROUPWB;
-	return dent;
+	fc->s_iflags |= SB_I_CGROUPWB;
+	return vfs_init_pseudo_fs_context(fc, "bdev:",
+					  &bdev_sops, NULL, NULL, BDEVFS_MAGIC);
 }
 
 static struct file_system_type bd_type = {
 	.name		= "bdev",
-	.mount		= bd_mount,
+	.init_fs_context = bd_init_fs_context,
 	.kill_sb	= kill_anon_super,
 };
 

