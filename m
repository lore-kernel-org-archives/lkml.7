Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D1EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA0F2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfCNQKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:10:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727654AbfCNQKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:10:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D09511DB89;
        Thu, 14 Mar 2019 16:10:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D9BB5D9C4;
        Thu, 14 Mar 2019 16:10:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/38] vfs: Convert zsmalloc to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-mm@kvack.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 16:09:59 +0000
Message-ID: <155257979989.13720.3823457480635712878.stgit@warthog.procyon.org.uk>
In-Reply-To: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 14 Mar 2019 16:10:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Minchan Kim <minchan@kernel.org>
cc: Nitin Gupta <ngupta@vflare.org>
cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
cc: linux-mm@kvack.org
---

 mm/zsmalloc.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 0787d33b80d8..02bfc7f70fab 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -52,6 +52,7 @@
 #include <linux/zsmalloc.h>
 #include <linux/zpool.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/migrate.h>
 #include <linux/pagemap.h>
 #include <linux/fs.h>
@@ -1814,19 +1815,21 @@ static void lock_zspage(struct zspage *zspage)
 	} while ((page = get_next_page(page)) != NULL);
 }
 
-static struct dentry *zs_mount(struct file_system_type *fs_type,
-				int flags, const char *dev_name, void *data)
-{
-	static const struct dentry_operations ops = {
-		.d_dname = simple_dname,
-	};
+static const struct dentry_operations zs_dentry_operations = {
+	.d_dname = simple_dname,
+};
 
-	return mount_pseudo(fs_type, "zsmalloc:", NULL, &ops, ZSMALLOC_MAGIC);
+
+static int zs_init_fs_context(struct fs_context *fc)
+{
+	return vfs_init_pseudo_fs_context(fc, "zsmalloc:",
+					  NULL, NULL,
+					  &zs_dentry_operations, ZSMALLOC_MAGIC);
 }
 
 static struct file_system_type zsmalloc_fs = {
 	.name		= "zsmalloc",
-	.mount		= zs_mount,
+	.init_fs_context = zs_init_fs_context,
 	.kill_sb	= kill_anon_super,
 };
 

