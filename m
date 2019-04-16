Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C9AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7408D20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfDPR6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:58:01 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57598 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730272AbfDPRxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:46 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHA-0005XH-H9; Tue, 16 Apr 2019 17:53:44 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 29/62] dlmfs: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:07 +0100
Message-Id: <20190416175340.21068-29-viro@ZenIV.linux.org.uk>
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
 fs/ocfs2/dlmfs/dlmfs.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 8decbe95dcec..98885181e1fe 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -349,17 +349,11 @@ static struct inode *dlmfs_alloc_inode(struct super_block *sb)
 	return &ip->ip_vfs_inode;
 }
 
-static void dlmfs_i_callback(struct rcu_head *head)
+static void dlmfs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(dlmfs_inode_cache, DLMFS_I(inode));
 }
 
-static void dlmfs_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, dlmfs_i_callback);
-}
-
 static void dlmfs_evict_inode(struct inode *inode)
 {
 	int status;
@@ -605,7 +599,7 @@ static const struct inode_operations dlmfs_root_inode_operations = {
 static const struct super_operations dlmfs_ops = {
 	.statfs		= simple_statfs,
 	.alloc_inode	= dlmfs_alloc_inode,
-	.destroy_inode	= dlmfs_destroy_inode,
+	.free_inode	= dlmfs_free_inode,
 	.evict_inode	= dlmfs_evict_inode,
 	.drop_inode	= generic_delete_inode,
 };
-- 
2.11.0

