Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0A0C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363A12075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbfDPRxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:53:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57498 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfDPRxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSH6-0005Uh-W1; Tue, 16 Apr 2019 17:53:41 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 04/62] spufs: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:52:42 +0100
Message-Id: <20190416175340.21068-4-viro@ZenIV.linux.org.uk>
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
 arch/powerpc/platforms/cell/spufs/inode.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index db329d4bf1c3..c1a75216050a 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -71,17 +71,11 @@ spufs_alloc_inode(struct super_block *sb)
 	return &ei->vfs_inode;
 }
 
-static void spufs_i_callback(struct rcu_head *head)
+static void spufs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(spufs_inode_cache, SPUFS_I(inode));
 }
 
-static void spufs_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, spufs_i_callback);
-}
-
 static void
 spufs_init_once(void *p)
 {
@@ -739,7 +733,7 @@ spufs_fill_super(struct super_block *sb, void *data, int silent)
 	struct spufs_sb_info *info;
 	static const struct super_operations s_ops = {
 		.alloc_inode = spufs_alloc_inode,
-		.destroy_inode = spufs_destroy_inode,
+		.free_inode = spufs_free_inode,
 		.statfs = simple_statfs,
 		.evict_inode = spufs_evict_inode,
 		.show_options = spufs_show_options,
-- 
2.11.0

