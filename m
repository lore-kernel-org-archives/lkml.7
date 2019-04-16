Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946E4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A762087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbfDPR7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:59:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57546 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbfDPRxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:44 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSH8-0005Vs-Km; Tue, 16 Apr 2019 17:53:42 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 16/62] f2fs: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:52:54 +0100
Message-Id: <20190416175340.21068-16-viro@ZenIV.linux.org.uk>
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
 fs/f2fs/super.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f2aaa2cc6b3e..9924eac76254 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1000,17 +1000,11 @@ static void f2fs_dirty_inode(struct inode *inode, int flags)
 	f2fs_inode_dirtied(inode, false);
 }
 
-static void f2fs_i_callback(struct rcu_head *head)
+static void f2fs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(f2fs_inode_cachep, F2FS_I(inode));
 }
 
-static void f2fs_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, f2fs_i_callback);
-}
-
 static void destroy_percpu_info(struct f2fs_sb_info *sbi)
 {
 	percpu_counter_destroy(&sbi->alloc_valid_block_count);
@@ -2166,8 +2160,8 @@ void f2fs_quota_off_umount(struct super_block *sb)
 
 static const struct super_operations f2fs_sops = {
 	.alloc_inode	= f2fs_alloc_inode,
+	.free_inode	= f2fs_free_inode,
 	.drop_inode	= f2fs_drop_inode,
-	.destroy_inode	= f2fs_destroy_inode,
 	.write_inode	= f2fs_write_inode,
 	.dirty_inode	= f2fs_dirty_inode,
 	.show_options	= f2fs_show_options,
-- 
2.11.0

