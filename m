Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4011C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C214D2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbfDPR73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:59:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57550 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730232AbfDPRxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:44 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSH8-0005Vz-Nj; Tue, 16 Apr 2019 17:53:42 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 17/62] fat: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:52:55 +0100
Message-Id: <20190416175340.21068-17-viro@ZenIV.linux.org.uk>
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
 fs/fat/inode.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 79bb0e73a65f..ba93d1373306 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -746,17 +746,11 @@ static struct inode *fat_alloc_inode(struct super_block *sb)
 	return &ei->vfs_inode;
 }
 
-static void fat_i_callback(struct rcu_head *head)
+static void fat_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(fat_inode_cachep, MSDOS_I(inode));
 }
 
-static void fat_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, fat_i_callback);
-}
-
 static void init_once(void *foo)
 {
 	struct msdos_inode_info *ei = (struct msdos_inode_info *)foo;
@@ -920,7 +914,7 @@ EXPORT_SYMBOL_GPL(fat_sync_inode);
 static int fat_show_options(struct seq_file *m, struct dentry *root);
 static const struct super_operations fat_sops = {
 	.alloc_inode	= fat_alloc_inode,
-	.destroy_inode	= fat_destroy_inode,
+	.free_inode	= fat_free_inode,
 	.write_inode	= fat_write_inode,
 	.evict_inode	= fat_evict_inode,
 	.put_super	= fat_put_super,
-- 
2.11.0

