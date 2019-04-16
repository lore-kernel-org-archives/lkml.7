Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957C5C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5B820880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfDPRyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:54:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57718 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730370AbfDPRxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHE-0005aN-QC; Tue, 16 Apr 2019 17:53:48 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 59/62] shmem: make use of ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:37 +0100
Message-Id: <20190416175340.21068-59-viro@ZenIV.linux.org.uk>
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

same situation as for hugetlbfs

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 mm/shmem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b3db3779a30a..dbb7a6dadba7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3635,9 +3635,8 @@ static struct inode *shmem_alloc_inode(struct super_block *sb)
 	return &info->vfs_inode;
 }
 
-static void shmem_destroy_callback(struct rcu_head *head)
+static void shmem_free_in_core_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	if (S_ISLNK(inode->i_mode))
 		kfree(inode->i_link);
 	kmem_cache_free(shmem_inode_cachep, SHMEM_I(inode));
@@ -3647,7 +3646,6 @@ static void shmem_destroy_inode(struct inode *inode)
 {
 	if (S_ISREG(inode->i_mode))
 		mpol_free_shared_policy(&SHMEM_I(inode)->policy);
-	call_rcu(&inode->i_rcu, shmem_destroy_callback);
 }
 
 static void shmem_init_inode(void *foo)
@@ -3738,6 +3736,7 @@ static const struct inode_operations shmem_special_inode_operations = {
 
 static const struct super_operations shmem_ops = {
 	.alloc_inode	= shmem_alloc_inode,
+	.free_inode	= shmem_free_in_core_inode,
 	.destroy_inode	= shmem_destroy_inode,
 #ifdef CONFIG_TMPFS
 	.statfs		= shmem_statfs,
-- 
2.11.0

