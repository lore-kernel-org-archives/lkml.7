Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3153C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E7A2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbfDPRyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:54:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57694 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730347AbfDPRxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:49 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHE-0005Zn-1p; Tue, 16 Apr 2019 17:53:48 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 53/62] ecryptfs: make use of ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:31 +0100
Message-Id: <20190416175340.21068-53-viro@ZenIV.linux.org.uk>
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

no idea if crypto destruction could be moved there as well

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ecryptfs/super.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
index 85411ceb0508..c3e511f2b6c0 100644
--- a/fs/ecryptfs/super.c
+++ b/fs/ecryptfs/super.c
@@ -67,9 +67,8 @@ static struct inode *ecryptfs_alloc_inode(struct super_block *sb)
 	return inode;
 }
 
-static void ecryptfs_i_callback(struct rcu_head *head)
+static void ecryptfs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	struct ecryptfs_inode_info *inode_info;
 	inode_info = ecryptfs_inode_to_private(inode);
 
@@ -92,7 +91,6 @@ static void ecryptfs_destroy_inode(struct inode *inode)
 	inode_info = ecryptfs_inode_to_private(inode);
 	BUG_ON(inode_info->lower_file);
 	ecryptfs_destroy_crypt_stat(&inode_info->crypt_stat);
-	call_rcu(&inode->i_rcu, ecryptfs_i_callback);
 }
 
 /**
@@ -186,6 +184,7 @@ static int ecryptfs_show_options(struct seq_file *m, struct dentry *root)
 const struct super_operations ecryptfs_sops = {
 	.alloc_inode = ecryptfs_alloc_inode,
 	.destroy_inode = ecryptfs_destroy_inode,
+	.free_inode = ecryptfs_free_inode,
 	.statfs = ecryptfs_statfs,
 	.remount_fs = NULL,
 	.evict_inode = ecryptfs_evict_inode,
-- 
2.11.0

