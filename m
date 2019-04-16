Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FFFC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C37206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbfDPR6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:58:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57602 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbfDPRxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:45 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHA-0005XN-KI; Tue, 16 Apr 2019 17:53:44 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 30/62] ocfs2: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:08 +0100
Message-Id: <20190416175340.21068-30-viro@ZenIV.linux.org.uk>
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
 fs/ocfs2/super.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 96ae7cedd487..7982a93e630f 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -134,7 +134,7 @@ static int ocfs2_get_sector(struct super_block *sb,
 			    int block,
 			    int sect_size);
 static struct inode *ocfs2_alloc_inode(struct super_block *sb);
-static void ocfs2_destroy_inode(struct inode *inode);
+static void ocfs2_free_inode(struct inode *inode);
 static int ocfs2_susp_quotas(struct ocfs2_super *osb, int unsuspend);
 static int ocfs2_enable_quotas(struct ocfs2_super *osb);
 static void ocfs2_disable_quotas(struct ocfs2_super *osb);
@@ -147,7 +147,7 @@ static struct dquot **ocfs2_get_dquots(struct inode *inode)
 static const struct super_operations ocfs2_sops = {
 	.statfs		= ocfs2_statfs,
 	.alloc_inode	= ocfs2_alloc_inode,
-	.destroy_inode	= ocfs2_destroy_inode,
+	.free_inode	= ocfs2_free_inode,
 	.drop_inode	= ocfs2_drop_inode,
 	.evict_inode	= ocfs2_evict_inode,
 	.sync_fs	= ocfs2_sync_fs,
@@ -575,17 +575,11 @@ static struct inode *ocfs2_alloc_inode(struct super_block *sb)
 	return &oi->vfs_inode;
 }
 
-static void ocfs2_i_callback(struct rcu_head *head)
+static void ocfs2_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(ocfs2_inode_cachep, OCFS2_I(inode));
 }
 
-static void ocfs2_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, ocfs2_i_callback);
-}
-
 static unsigned long long ocfs2_max_file_offset(unsigned int bbits,
 						unsigned int cbits)
 {
-- 
2.11.0

