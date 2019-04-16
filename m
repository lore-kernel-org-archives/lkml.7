Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B58C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C278320880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbfDPRyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:54:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57690 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730342AbfDPRxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:49 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHD-0005Zg-RN; Tue, 16 Apr 2019 17:53:47 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 52/62] ceph: use ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:30 +0100
Message-Id: <20190416175340.21068-52-viro@ZenIV.linux.org.uk>
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

a lot of non-delayed work in this case; all of that is left in
->destroy_inode()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ceph/inode.c | 5 +----
 fs/ceph/super.c | 1 +
 fs/ceph/super.h | 1 +
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 2d61ddda9bf5..dc0a36d0adf8 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -519,9 +519,8 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	return &ci->vfs_inode;
 }
 
-static void ceph_i_callback(struct rcu_head *head)
+void ceph_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	kfree(ci->i_symlink);
@@ -581,8 +580,6 @@ void ceph_destroy_inode(struct inode *inode)
 		ceph_buffer_put(ci->i_xattrs.prealloc_blob);
 
 	ceph_put_string(rcu_dereference_raw(ci->i_layout.pool_ns));
-
-	call_rcu(&inode->i_rcu, ceph_i_callback);
 }
 
 int ceph_drop_inode(struct inode *inode)
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 6d5bb2f74612..285edda4fc3b 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -848,6 +848,7 @@ static void ceph_umount_begin(struct super_block *sb)
 static const struct super_operations ceph_super_ops = {
 	.alloc_inode	= ceph_alloc_inode,
 	.destroy_inode	= ceph_destroy_inode,
+	.free_inode	= ceph_free_inode,
 	.write_inode    = ceph_write_inode,
 	.drop_inode	= ceph_drop_inode,
 	.sync_fs        = ceph_sync_fs,
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 16c03188578e..c5b4a05905c0 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -874,6 +874,7 @@ extern const struct inode_operations ceph_file_iops;
 
 extern struct inode *ceph_alloc_inode(struct super_block *sb);
 extern void ceph_destroy_inode(struct inode *inode);
+extern void ceph_free_inode(struct inode *inode);
 extern int ceph_drop_inode(struct inode *inode);
 
 extern struct inode *ceph_get_inode(struct super_block *sb,
-- 
2.11.0

