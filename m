Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA16FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DC020880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbfDPR7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:59:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57556 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbfDPRxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:44 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSH8-0005WB-Ub; Tue, 16 Apr 2019 17:53:43 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 19/62] gfs2: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:52:57 +0100
Message-Id: <20190416175340.21068-19-viro@ZenIV.linux.org.uk>
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

... and use GFS2_I() to get the containing gfs2_inode by inode;
yes, we can feed the address of the first member of structure
to kmem_cache_free(), but let's do it in an obviously safe way.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/gfs2/super.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index ca71163ff7cf..7b8d2306b3d3 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1736,20 +1736,14 @@ static struct inode *gfs2_alloc_inode(struct super_block *sb)
 	return &ip->i_inode;
 }
 
-static void gfs2_i_callback(struct rcu_head *head)
+static void gfs2_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
-	kmem_cache_free(gfs2_inode_cachep, inode);
-}
-
-static void gfs2_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, gfs2_i_callback);
+	kmem_cache_free(gfs2_inode_cachep, GFS2_I(inode));
 }
 
 const struct super_operations gfs2_super_ops = {
 	.alloc_inode		= gfs2_alloc_inode,
-	.destroy_inode		= gfs2_destroy_inode,
+	.free_inode		= gfs2_free_inode,
 	.write_inode		= gfs2_write_inode,
 	.dirty_inode		= gfs2_dirty_inode,
 	.evict_inode		= gfs2_evict_inode,
-- 
2.11.0

