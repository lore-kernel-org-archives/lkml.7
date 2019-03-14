Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A95C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3EE217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfCNQNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:13:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728050AbfCNQNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:13:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A49FC0AC368;
        Thu, 14 Mar 2019 16:13:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47B1E60634;
        Thu, 14 Mar 2019 16:13:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 35/38] vfs: Convert securityfs to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-security-module@vger.kernel.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Mar 2019 16:13:36 +0000
Message-ID: <155258001652.13720.11473812959592965169.stgit@warthog.procyon.org.uk>
In-Reply-To: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
References: <155257972443.13720.11743171471060355965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 14 Mar 2019 16:13:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-security-module@vger.kernel.org
---

 security/inode.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index b7772a9b315e..4fecbc8b072a 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -16,6 +16,7 @@
 #include <linux/sysfs.h>
 #include <linux/kobject.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
@@ -40,7 +41,7 @@ static const struct super_operations securityfs_super_operations = {
 	.evict_inode	= securityfs_evict_inode,
 };
 
-static int fill_super(struct super_block *sb, void *data, int silent)
+static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	static const struct tree_descr files[] = {{""}};
 	int error;
@@ -54,17 +55,25 @@ static int fill_super(struct super_block *sb, void *data, int silent)
 	return 0;
 }
 
-static struct dentry *get_sb(struct file_system_type *fs_type,
-		  int flags, const char *dev_name,
-		  void *data)
+static int securityfs_get_tree(struct fs_context *fc)
 {
-	return mount_single(fs_type, flags, data, fill_super);
+	return vfs_get_super(fc, vfs_get_single_super, securityfs_fill_super);
+}
+
+static const struct fs_context_operations securityfs_context_ops = {
+	.get_tree	= securityfs_get_tree,
+};
+
+static int securityfs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &securityfs_context_ops;
+	return 0;
 }
 
 static struct file_system_type fs_type = {
 	.owner =	THIS_MODULE,
 	.name =		"securityfs",
-	.mount =	get_sb,
+	.init_fs_context = securityfs_init_fs_context,
 	.kill_sb =	kill_litter_super,
 };
 

