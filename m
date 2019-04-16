Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDEBC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384E720880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfDPRy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:54:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57714 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfDPRxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHE-0005aH-Mh; Tue, 16 Apr 2019 17:53:48 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 58/62] hugetlb: make use of ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:36 +0100
Message-Id: <20190416175340.21068-58-viro@ZenIV.linux.org.uk>
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

moving synchronous parts of ->destroy_inode() to ->evict_inode() is
not possible here - they are balancing the stuff done in ->alloc_inode(),
not the things acquired while using it or sanity checks.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/hugetlbfs/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9285dd4f4b1c..c74ef4426282 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1051,9 +1051,8 @@ static struct inode *hugetlbfs_alloc_inode(struct super_block *sb)
 	return &p->vfs_inode;
 }
 
-static void hugetlbfs_i_callback(struct rcu_head *head)
+static void hugetlbfs_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(hugetlbfs_inode_cachep, HUGETLBFS_I(inode));
 }
 
@@ -1061,7 +1060,6 @@ static void hugetlbfs_destroy_inode(struct inode *inode)
 {
 	hugetlbfs_inc_free_inodes(HUGETLBFS_SB(inode->i_sb));
 	mpol_free_shared_policy(&HUGETLBFS_I(inode)->policy);
-	call_rcu(&inode->i_rcu, hugetlbfs_i_callback);
 }
 
 static const struct address_space_operations hugetlbfs_aops = {
@@ -1108,6 +1106,7 @@ static const struct inode_operations hugetlbfs_inode_operations = {
 
 static const struct super_operations hugetlbfs_ops = {
 	.alloc_inode    = hugetlbfs_alloc_inode,
+	.free_inode     = hugetlbfs_free_inode,
 	.destroy_inode  = hugetlbfs_destroy_inode,
 	.evict_inode	= hugetlbfs_evict_inode,
 	.statfs		= hugetlbfs_statfs,
-- 
2.11.0

