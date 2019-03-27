Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5936EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3117B20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbfC0XoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:44:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfC0Xn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:43:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C50C89C44;
        Wed, 27 Mar 2019 23:43:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E4996013C;
        Wed, 27 Mar 2019 23:43:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 27/68] vfs: Convert binfmt_misc to use the new mount API
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com
Date:   Wed, 27 Mar 2019 23:43:57 +0000
Message-ID: <155373023744.7602.3257494523895459222.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 27 Mar 2019 23:43:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the binfmt_misc filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: linux-fsdevel@vger.kernel.org
---

 fs/binfmt_misc.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index aa4a7a23ff99..0c32e59bfd20 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -22,6 +22,7 @@
 #include <linux/pagemap.h>
 #include <linux/namei.h>
 #include <linux/mount.h>
+#include <linux/fs_context.h>
 #include <linux/syscalls.h>
 #include <linux/fs.h>
 #include <linux/uaccess.h>
@@ -820,7 +821,7 @@ static const struct super_operations s_ops = {
 	.evict_inode	= bm_evict_inode,
 };
 
-static int bm_fill_super(struct super_block *sb, void *data, int silent)
+static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	int err;
 	static const struct tree_descr bm_files[] = {
@@ -835,10 +836,19 @@ static int bm_fill_super(struct super_block *sb, void *data, int silent)
 	return err;
 }
 
-static struct dentry *bm_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+static int bm_get_tree(struct fs_context *fc)
 {
-	return mount_single(fs_type, flags, data, bm_fill_super);
+	return vfs_get_super(fc, vfs_get_single_super, bm_fill_super);
+}
+
+static const struct fs_context_operations bm_context_ops = {
+	.get_tree	= bm_get_tree,
+};
+
+static int bm_init_fs_context(struct fs_context *fc)
+{
+	fc->ops = &bm_context_ops;
+	return 0;
 }
 
 static struct linux_binfmt misc_format = {
@@ -849,7 +859,7 @@ static struct linux_binfmt misc_format = {
 static struct file_system_type bm_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "binfmt_misc",
-	.mount		= bm_mount,
+	.init_fs_context = bm_init_fs_context,
 	.kill_sb	= kill_litter_super,
 };
 MODULE_ALIAS_FS("binfmt_misc");

