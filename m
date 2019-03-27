Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C17BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514962075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbfC0Xlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:41:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfC0Xlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:41:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B9F4C8831D;
        Wed, 27 Mar 2019 23:41:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B557187C1;
        Wed, 27 Mar 2019 23:41:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 08/68] vfs: Convert bdev to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:41:34 +0000
Message-ID: <155373009391.7602.12895418464195854878.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 27 Mar 2019 23:41:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the bdev filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: linux-fsdevel@vger.kernel.org
---

 fs/block_dev.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 78d3257435c0..f3151c9c9191 100644
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
@@ -844,19 +845,16 @@ static const struct super_operations bdev_sops = {
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
 

