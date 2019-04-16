Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6797BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494C421773
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbfDPR5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:57:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57630 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730289AbfDPRxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:47 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHB-0005Y9-J4; Tue, 16 Apr 2019 17:53:45 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 37/62] squashfs: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:15 +0100
Message-Id: <20190416175340.21068-37-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416175340.21068-1-viro@ZenIV.linux.org.uk>
References: <20190416174900.GT2217@ZenIV.linux.org.uk>
 <20190416175340.21068-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/squashfs/super.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 40e657386fa5..767046d9f65d 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -473,18 +473,11 @@ static struct inode *squashfs_alloc_inode(struct super_block *sb)
 }
 
 
-static void squashfs_i_callback(struct rcu_head *head)
+static void squashfs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(squashfs_inode_cachep, squashfs_i(inode));
 }
 
-static void squashfs_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, squashfs_i_callback);
-}
-
-
 static struct file_system_type squashfs_fs_type = {
 	.owner = THIS_MODULE,
 	.name = "squashfs",
@@ -496,7 +489,7 @@ MODULE_ALIAS_FS("squashfs");
 
 static const struct super_operations squashfs_super_ops = {
 	.alloc_inode = squashfs_alloc_inode,
-	.destroy_inode = squashfs_destroy_inode,
+	.free_inode = squashfs_free_inode,
 	.statfs = squashfs_statfs,
 	.put_super = squashfs_put_super,
 	.remount_fs = squashfs_remount
-- 
2.11.0

