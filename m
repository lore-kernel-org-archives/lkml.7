Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00C9C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD4A20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbfDPRyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:54:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57698 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730350AbfDPRxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:49 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHE-0005Zt-6k; Tue, 16 Apr 2019 17:53:48 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 54/62] ext4: make use of ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:32 +0100
Message-Id: <20190416175340.21068-54-viro@ZenIV.linux.org.uk>
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

the rest of this ->destroy_inode() instance could probably be folded
into ext4_evict_inode()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ext4/super.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6ed4eb81e674..981f702848e7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1107,9 +1107,8 @@ static int ext4_drop_inode(struct inode *inode)
 	return drop;
 }
 
-static void ext4_i_callback(struct rcu_head *head)
+static void ext4_free_in_core_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	kmem_cache_free(ext4_inode_cachep, EXT4_I(inode));
 }
 
@@ -1124,7 +1123,6 @@ static void ext4_destroy_inode(struct inode *inode)
 				true);
 		dump_stack();
 	}
-	call_rcu(&inode->i_rcu, ext4_i_callback);
 }
 
 static void init_once(void *foo)
@@ -1402,6 +1400,7 @@ static const struct quotactl_ops ext4_qctl_operations = {
 
 static const struct super_operations ext4_sops = {
 	.alloc_inode	= ext4_alloc_inode,
+	.free_inode	= ext4_free_in_core_inode,
 	.destroy_inode	= ext4_destroy_inode,
 	.write_inode	= ext4_write_inode,
 	.dirty_inode	= ext4_dirty_inode,
-- 
2.11.0

