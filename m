Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55DCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930602075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbfC0XlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:41:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731337AbfC0XlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:41:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E51ED30FE5B9;
        Wed, 27 Mar 2019 23:41:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7E8519C5A;
        Wed, 27 Mar 2019 23:41:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 06/68] vfs: Convert aio to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Benjamin LaHaise <bcrl@kvack.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:41:19 +0000
Message-ID: <155373007983.7602.1375447093693026804.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 27 Mar 2019 23:41:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the aio filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Benjamin LaHaise <bcrl@kvack.org>
cc: linux-aio@kvack.org
---

 fs/aio.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 38b741aef0bf..42bf0c83da66 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -42,6 +42,7 @@
 #include <linux/ramfs.h>
 #include <linux/percpu-refcount.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 
 #include <asm/kmap_types.h>
 #include <linux/uaccess.h>
@@ -250,15 +251,11 @@ static struct file *aio_private_file(struct kioctx *ctx, loff_t nr_pages)
 	return file;
 }
 
-static struct dentry *aio_mount(struct file_system_type *fs_type,
-				int flags, const char *dev_name, void *data)
+static int aio_init_fs_context(struct fs_context *fc)
 {
-	struct dentry *root = mount_pseudo(fs_type, "aio:", NULL, NULL,
-					   AIO_RING_MAGIC);
-
-	if (!IS_ERR(root))
-		root->d_sb->s_iflags |= SB_I_NOEXEC;
-	return root;
+	fc->s_iflags |= SB_I_NOEXEC;
+	return vfs_init_pseudo_fs_context(fc, "aio:",
+					  NULL, NULL, NULL, AIO_RING_MAGIC);
 }
 
 /* aio_setup
@@ -269,7 +266,7 @@ static int __init aio_setup(void)
 {
 	static struct file_system_type aio_fs = {
 		.name		= "aio",
-		.mount		= aio_mount,
+		.init_fs_context = aio_init_fs_context,
 		.kill_sb	= kill_anon_super,
 	};
 	aio_mnt = kern_mount(&aio_fs);

