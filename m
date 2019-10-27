Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862E9CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 22:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6E52064A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 22:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfJ0WDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 18:03:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:48398 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726881AbfJ0WDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 18:03:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DE7E7AD78;
        Sun, 27 Oct 2019 22:03:11 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dsterba@suse.com
Cc:     dave@stgolabs.net, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] fs/affs: Replace binary semaphores with mutexes
Date:   Sun, 27 Oct 2019 15:01:43 -0700
Message-Id: <20191027220143.10756-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At a slight footprint cost (24 vs 32 bytes), mutexes are more optimal
than semaphores; it's also a nicer interface for mutual exclusion,
which is why they are encouraged over binary semaphores, when possible.

For both i_link_lock and i_ext_lock (and hence i_hash_lock which I
annotated for the hash lock mapping hackery for lockdep), their semantics
imply traditional lock ownership; that is, the lock owner is the same for
both lock/unlock operations and does not run in irq context. Therefore
it is safe to convert.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
Compile tested only.

 fs/affs/affs.h  | 16 ++++++++--------
 fs/affs/super.c |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index a92eb6ae2ae2..a755bef7c4c7 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -43,8 +43,8 @@ struct affs_ext_key {
  */
 struct affs_inode_info {
 	atomic_t i_opencnt;
-	struct semaphore i_link_lock;		/* Protects internal inode access. */
-	struct semaphore i_ext_lock;		/* Protects internal inode access. */
+	struct mutex i_link_lock;		/* Protects internal inode access. */
+	struct mutex i_ext_lock;		/* Protects internal inode access. */
 #define i_hash_lock i_ext_lock
 	u32	 i_blkcnt;			/* block count */
 	u32	 i_extcnt;			/* extended block count */
@@ -293,30 +293,30 @@ affs_adjust_bitmapchecksum(struct buffer_head *bh, u32 val)
 static inline void
 affs_lock_link(struct inode *inode)
 {
-	down(&AFFS_I(inode)->i_link_lock);
+	mutex_lock(&AFFS_I(inode)->i_link_lock);
 }
 static inline void
 affs_unlock_link(struct inode *inode)
 {
-	up(&AFFS_I(inode)->i_link_lock);
+	mutex_unlock(&AFFS_I(inode)->i_link_lock);
 }
 static inline void
 affs_lock_dir(struct inode *inode)
 {
-	down(&AFFS_I(inode)->i_hash_lock);
+	mutex_lock_nested(&AFFS_I(inode)->i_hash_lock, SINGLE_DEPTH_NESTING);
 }
 static inline void
 affs_unlock_dir(struct inode *inode)
 {
-	up(&AFFS_I(inode)->i_hash_lock);
+	mutex_unlock(&AFFS_I(inode)->i_hash_lock);
 }
 static inline void
 affs_lock_ext(struct inode *inode)
 {
-	down(&AFFS_I(inode)->i_ext_lock);
+	mutex_lock(&AFFS_I(inode)->i_ext_lock);
 }
 static inline void
 affs_unlock_ext(struct inode *inode)
 {
-	up(&AFFS_I(inode)->i_ext_lock);
+	mutex_unlock(&AFFS_I(inode)->i_ext_lock);
 }
diff --git a/fs/affs/super.c b/fs/affs/super.c
index cc463ae47c12..9fcff55c65af 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -121,8 +121,8 @@ static void init_once(void *foo)
 {
 	struct affs_inode_info *ei = (struct affs_inode_info *) foo;
 
-	sema_init(&ei->i_link_lock, 1);
-	sema_init(&ei->i_ext_lock, 1);
+	mutex_init(&ei->i_link_lock);
+	mutex_init(&ei->i_ext_lock);
 	inode_init_once(&ei->vfs_inode);
 }
 
-- 
2.16.4

