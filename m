Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B6EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10222075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbfDPR4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:56:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57642 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730296AbfDPRxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:47 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHC-0005YS-1B; Tue, 16 Apr 2019 17:53:46 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 40/62] sysv: switch to ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:18 +0100
Message-Id: <20190416175340.21068-40-viro@ZenIV.linux.org.uk>
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
 fs/sysv/inode.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
index 273736f41be3..02b1d9d0c182 100644
--- a/fs/sysv/inode.c
+++ b/fs/sysv/inode.c
@@ -313,17 +313,11 @@ static struct inode *sysv_alloc_inode(struct super_block *sb)
 	return &si->vfs_inode;
 }
 
-static void sysv_i_callback(struct rcu_head *head)
+static void sysv_free_in_core_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(sysv_inode_cachep, SYSV_I(inode));
 }
 
-static void sysv_destroy_inode(struct inode *inode)
-{
-	call_rcu(&inode->i_rcu, sysv_i_callback);
-}
-
 static void init_once(void *p)
 {
 	struct sysv_inode_info *si = (struct sysv_inode_info *)p;
@@ -333,7 +327,7 @@ static void init_once(void *p)
 
 const struct super_operations sysv_sops = {
 	.alloc_inode	= sysv_alloc_inode,
-	.destroy_inode	= sysv_destroy_inode,
+	.free_inode	= sysv_free_in_core_inode,
 	.write_inode	= sysv_write_inode,
 	.evict_inode	= sysv_evict_inode,
 	.put_super	= sysv_put_super,
-- 
2.11.0

