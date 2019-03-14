Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2396C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A155A2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfCNQJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:09:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfCNQJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:09:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C937C6516D;
        Thu, 14 Mar 2019 16:09:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC7F51001E63;
        Thu, 14 Mar 2019 16:09:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/38] vfs: Convert anon_inodes to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 16:09:32 +0000
Message-ID: <155257977219.13720.16485911333225583114.stgit@warthog.procyon.org.uk>
In-Reply-To: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 14 Mar 2019 16:09:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-fsdevel@vger.kernel.org
---

 fs/anon_inodes.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 91262c34b797..e05d01e5b28f 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/magic.h>
 #include <linux/anon_inodes.h>
+#include <linux/fs_context.h>
 
 #include <linux/uaccess.h>
 
@@ -38,16 +39,17 @@ static const struct dentry_operations anon_inodefs_dentry_operations = {
 	.d_dname	= anon_inodefs_dname,
 };
 
-static struct dentry *anon_inodefs_mount(struct file_system_type *fs_type,
-				int flags, const char *dev_name, void *data)
+static int anon_inodefs_init_fs_context(struct fs_context *fc)
 {
-	return mount_pseudo(fs_type, "anon_inode:", NULL,
-			&anon_inodefs_dentry_operations, ANON_INODE_FS_MAGIC);
+	return vfs_init_pseudo_fs_context(fc, "anon_inode:",
+					  NULL, NULL,
+					  &anon_inodefs_dentry_operations,
+					  ANON_INODE_FS_MAGIC);
 }
 
 static struct file_system_type anon_inode_fs_type = {
 	.name		= "anon_inodefs",
-	.mount		= anon_inodefs_mount,
+	.init_fs_context = anon_inodefs_init_fs_context,
 	.kill_sb	= kill_anon_super,
 };
 

