Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE22DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE908206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfDPR5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:57:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57622 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730285AbfDPRxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:46 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHB-0005Xx-BM; Tue, 16 Apr 2019 17:53:45 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 35/62] reiserfs: convert to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:13 +0100
Message-Id: <20190416175340.21068-35-viro@ZenIV.linux.org.uk>
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
 fs/reiserfs/super.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 1fc934d24459..ab028ea0e561 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -650,17 +650,11 @@ static struct inode *reiserfs_alloc_inode(struct super_block *sb)
 	return &ei->vfs_inode;
 }
 
-static void reiserfs_i_callback(struct rcu_head *head)
+static void reiserfs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(reiserfs_inode_cachep, REISERFS_I(inode));
 }
 
-static void reiserfs_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, reiserfs_i_callback);
-}
-
 static void init_once(void *foo)
 {
 	struct reiserfs_inode_info *ei = (struct reiserfs_inode_info *)foo;
@@ -815,7 +809,7 @@ static struct dquot **reiserfs_get_dquots(struct inode *inode)
 
 static const struct super_operations reiserfs_sops = {
 	.alloc_inode = reiserfs_alloc_inode,
-	.destroy_inode = reiserfs_destroy_inode,
+	.free_inode = reiserfs_free_inode,
 	.write_inode = reiserfs_write_inode,
 	.dirty_inode = reiserfs_dirty_inode,
 	.evict_inode = reiserfs_evict_inode,
-- 
2.11.0

