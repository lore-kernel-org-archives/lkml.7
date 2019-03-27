Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702F3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4869520651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387449AbfC0XoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:44:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfC0XoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:44:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE10A30FE5B9;
        Wed, 27 Mar 2019 23:44:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F22722706;
        Wed, 27 Mar 2019 23:44:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 29/68] vfs: Convert efivarfs to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:44:11 +0000
Message-ID: <155373025163.7602.14229854994527411731.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 27 Mar 2019 23:44:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the efivarfs filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Garrett <matthew.garrett@nebula.com>
cc: Jeremy Kerr <jk@ozlabs.org>
cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
cc: linux-efi@vger.kernel.org
---

 fs/efivarfs/super.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 5b68e4294faa..1ea25c7a329a 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -10,6 +10,7 @@
 #include <linux/ctype.h>
 #include <linux/efi.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/ucs2_string.h>
@@ -191,7 +192,7 @@ static int efivarfs_destroy(struct efivar_entry *entry, void *data)
 	return 0;
 }
 
-static int efivarfs_fill_super(struct super_block *sb, void *data, int silent)
+static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode = NULL;
 	struct dentry *root;
@@ -226,10 +227,19 @@ static int efivarfs_fill_super(struct super_block *sb, void *data, int silent)
 	return err;
 }
 
-static struct dentry *efivarfs_mount(struct file_system_type *fs_type,
-				    int flags, const char *dev_name, void *data)
+static int efivarfs_get_tree(struct fs_context *fc)
 {
-	return mount_single(fs_type, flags, data, efivarfs_fill_super);
+	return vfs_get_super(fc, vfs_get_single_super, efivarfs_fill_super);
+}
+
+static const struct fs_context_operations efivarfs_context_ops = {
+	.get_tree	= efivarfs_get_tree,
+};
+
+static int efivarfs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &efivarfs_context_ops;
+	return 0;
 }
 
 static void efivarfs_kill_sb(struct super_block *sb)
@@ -244,7 +254,7 @@ static void efivarfs_kill_sb(struct super_block *sb)
 static struct file_system_type efivarfs_type = {
 	.owner   = THIS_MODULE,
 	.name    = "efivarfs",
-	.mount   = efivarfs_mount,
+	.init_fs_context = efivarfs_init_fs_context,
 	.kill_sb = efivarfs_kill_sb,
 };
 

