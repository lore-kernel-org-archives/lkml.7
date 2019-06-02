Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5DCC28CC3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 02:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A709274A5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 02:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfFBCZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 22:25:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfFBCZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 22:25:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A9B4630820C9
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2019 02:25:50 +0000 (UTC)
Received: from zhyan-laptop.redhat.com (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63E9719C58;
        Sun,  2 Jun 2019 02:25:47 +0000 (UTC)
From:   "Yan, Zheng" <zyan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     idryomov@redhat.com, jlayton@redhat.com,
        "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] ceph: use ceph_evict_inode to cleanup inode's resource
Date:   Sun,  2 Jun 2019 10:25:46 +0800
Message-Id: <20190602022546.16195-1-zyan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sun, 02 Jun 2019 02:25:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove_session_caps() relies on __wait_on_freeing_inode(), to wait for
freezing inode to remove its caps. But VFS wakes freeing inode waiters
before calling destroy_inode().

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/inode.c | 25 ++++++++++++++-----------
 fs/ceph/super.c |  1 +
 fs/ceph/super.h |  1 +
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 125ac54b5841..9e481b41d5bc 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -515,22 +515,13 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	return &ci->vfs_inode;
 }
 
-static void ceph_i_callback(struct rcu_head *head)
-{
-	struct inode *inode = container_of(head, struct inode, i_rcu);
-	struct ceph_inode_info *ci = ceph_inode(inode);
-
-	kfree(ci->i_symlink);
-	kmem_cache_free(ceph_inode_cachep, ci);
-}
-
-void ceph_destroy_inode(struct inode *inode)
+void ceph_evict_inode(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_inode_frag *frag;
 	struct rb_node *n;
 
-	dout("destroy_inode %p ino %llx.%llx\n", inode, ceph_vinop(inode));
+	dout("evict_inode %p ino %llx.%llx\n", inode, ceph_vinop(inode));
 
 	ceph_fscache_unregister_inode_cookie(ci);
 
@@ -577,7 +568,19 @@ void ceph_destroy_inode(struct inode *inode)
 		ceph_buffer_put(ci->i_xattrs.prealloc_blob);
 
 	ceph_put_string(rcu_dereference_raw(ci->i_layout.pool_ns));
+}
 
+static void ceph_i_callback(struct rcu_head *head)
+{
+	struct inode *inode = container_of(head, struct inode, i_rcu);
+	struct ceph_inode_info *ci = ceph_inode(inode);
+
+	kfree(ci->i_symlink);
+	kmem_cache_free(ceph_inode_cachep, ci);
+}
+
+void ceph_destroy_inode(struct inode *inode)
+{
 	call_rcu(&inode->i_rcu, ceph_i_callback);
 }
 
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index b1ee41372e85..67eb9d592ab7 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -842,6 +842,7 @@ static const struct super_operations ceph_super_ops = {
 	.destroy_inode	= ceph_destroy_inode,
 	.write_inode    = ceph_write_inode,
 	.drop_inode	= ceph_drop_inode,
+	.evict_inode	= ceph_evict_inode,
 	.sync_fs        = ceph_sync_fs,
 	.put_super	= ceph_put_super,
 	.remount_fs	= ceph_remount,
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 9c82d213a5ab..98d2bafc2ee2 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -882,6 +882,7 @@ static inline bool __ceph_have_pending_cap_snap(struct ceph_inode_info *ci)
 extern const struct inode_operations ceph_file_iops;
 
 extern struct inode *ceph_alloc_inode(struct super_block *sb);
+extern void ceph_evict_inode(struct inode *inode);
 extern void ceph_destroy_inode(struct inode *inode);
 extern int ceph_drop_inode(struct inode *inode);
 
-- 
2.17.2

