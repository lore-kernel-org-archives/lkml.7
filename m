Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FE1C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B932184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfCNQJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:09:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfCNQJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:09:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE6DB44F88;
        Thu, 14 Mar 2019 16:09:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B297617CEB;
        Thu, 14 Mar 2019 16:09:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/38] vfs: Convert aio to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Benjamin LaHaise <bcrl@kvack.org>, linux-aio@kvack.org,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 16:09:24 +0000
Message-ID: <155257976493.13720.7699938386165002407.stgit@warthog.procyon.org.uk>
In-Reply-To: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 14 Mar 2019 16:09:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

