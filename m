Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F20CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BD3217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfKASz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 14:55:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:52020 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727325AbfKASz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 14:55:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D61C8AB8F;
        Fri,  1 Nov 2019 18:55:23 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH] drivers/staging/exfat: Replace more binary semaphores with mutexes
Date:   Fri,  1 Nov 2019 11:53:32 -0700
Message-Id: <20191101185332.31786-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At a slight footprint cost (24 vs 32 bytes), mutexes are more optimal
than semaphores; it's also a nicer interface for mutual exclusion,
which is why they are encouraged over binary semaphores, when possible.
There is also lockdep support.

For both f_sem and b_sem, their semantics imply traditional lock
ownership; that is, the lock owner is the same for both lock/unlock
operations and not under irq contexts (ie for trylock/unlock scenarios).
Therefore it is safe to convert.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
This is part of further reducing semaphore users in the kernel.

This is a followup to the patch that converted the v and z sems, which
arguably could have been a single patch, but I just ran into these, and
it's probably easier to review, albeit trivial critical regions/lock usage.

 drivers/staging/exfat/exfat_cache.c | 48 ++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/exfat/exfat_cache.c b/drivers/staging/exfat/exfat_cache.c
index 1565ce65d39f..546a08fb26cc 100644
--- a/drivers/staging/exfat/exfat_cache.c
+++ b/drivers/staging/exfat/exfat_cache.c
@@ -12,8 +12,8 @@
 #define DIRTYBIT	0x02
 
 /* Local variables */
-static DEFINE_SEMAPHORE(f_sem);
-static DEFINE_SEMAPHORE(b_sem);
+static DEFINE_MUTEX(f_mutex);
+static DEFINE_MUTEX(b_mutex);
 
 static struct buf_cache_t *FAT_cache_find(struct super_block *sb, sector_t sec)
 {
@@ -315,9 +315,9 @@ int FAT_read(struct super_block *sb, u32 loc, u32 *content)
 {
 	s32 ret;
 
-	down(&f_sem);
+	mutex_lock(&f_mutex);
 	ret = __FAT_read(sb, loc, content);
-	up(&f_sem);
+	mutex_unlock(&f_mutex);
 
 	return ret;
 }
@@ -434,9 +434,9 @@ int FAT_write(struct super_block *sb, u32 loc, u32 content)
 {
 	s32 ret;
 
-	down(&f_sem);
+	mutex_lock(&f_mutex);
 	ret = __FAT_write(sb, loc, content);
-	up(&f_sem);
+	mutex_unlock(&f_mutex);
 
 	return ret;
 }
@@ -490,7 +490,7 @@ void FAT_release_all(struct super_block *sb)
 	struct buf_cache_t *bp;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
-	down(&f_sem);
+	mutex_lock(&f_mutex);
 
 	bp = p_fs->FAT_cache_lru_list.next;
 	while (bp != &p_fs->FAT_cache_lru_list) {
@@ -507,7 +507,7 @@ void FAT_release_all(struct super_block *sb)
 		bp = bp->next;
 	}
 
-	up(&f_sem);
+	mutex_unlock(&f_mutex);
 }
 
 void FAT_sync(struct super_block *sb)
@@ -515,7 +515,7 @@ void FAT_sync(struct super_block *sb)
 	struct buf_cache_t *bp;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
-	down(&f_sem);
+	mutex_lock(&f_mutex);
 
 	bp = p_fs->FAT_cache_lru_list.next;
 	while (bp != &p_fs->FAT_cache_lru_list) {
@@ -526,7 +526,7 @@ void FAT_sync(struct super_block *sb)
 		bp = bp->next;
 	}
 
-	up(&f_sem);
+	mutex_unlock(&f_mutex);
 }
 
 static struct buf_cache_t *buf_cache_find(struct super_block *sb, sector_t sec)
@@ -600,9 +600,9 @@ u8 *buf_getblk(struct super_block *sb, sector_t sec)
 {
 	u8 *buf;
 
-	down(&b_sem);
+	mutex_lock(&b_mutex);
 	buf = __buf_getblk(sb, sec);
-	up(&b_sem);
+	mutex_unlock(&b_mutex);
 
 	return buf;
 }
@@ -611,7 +611,7 @@ void buf_modify(struct super_block *sb, sector_t sec)
 {
 	struct buf_cache_t *bp;
 
-	down(&b_sem);
+	mutex_lock(&b_mutex);
 
 	bp = buf_cache_find(sb, sec);
 	if (likely(bp))
@@ -620,14 +620,14 @@ void buf_modify(struct super_block *sb, sector_t sec)
 	WARN(!bp, "[EXFAT] failed to find buffer_cache(sector:%llu).\n",
 	     (unsigned long long)sec);
 
-	up(&b_sem);
+	mutex_unlock(&b_mutex);
 }
 
 void buf_lock(struct super_block *sb, sector_t sec)
 {
 	struct buf_cache_t *bp;
 
-	down(&b_sem);
+	mutex_lock(&b_mutex);
 
 	bp = buf_cache_find(sb, sec);
 	if (likely(bp))
@@ -636,14 +636,14 @@ void buf_lock(struct super_block *sb, sector_t sec)
 	WARN(!bp, "[EXFAT] failed to find buffer_cache(sector:%llu).\n",
 	     (unsigned long long)sec);
 
-	up(&b_sem);
+	mutex_unlock(&b_mutex);
 }
 
 void buf_unlock(struct super_block *sb, sector_t sec)
 {
 	struct buf_cache_t *bp;
 
-	down(&b_sem);
+	mutex_lock(&b_mutex);
 
 	bp = buf_cache_find(sb, sec);
 	if (likely(bp))
@@ -652,7 +652,7 @@ void buf_unlock(struct super_block *sb, sector_t sec)
 	WARN(!bp, "[EXFAT] failed to find buffer_cache(sector:%llu).\n",
 	     (unsigned long long)sec);
 
-	up(&b_sem);
+	mutex_unlock(&b_mutex);
 }
 
 void buf_release(struct super_block *sb, sector_t sec)
@@ -660,7 +660,7 @@ void buf_release(struct super_block *sb, sector_t sec)
 	struct buf_cache_t *bp;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
-	down(&b_sem);
+	mutex_lock(&b_mutex);
 
 	bp = buf_cache_find(sb, sec);
 	if (likely(bp)) {
@@ -676,7 +676,7 @@ void buf_release(struct super_block *sb, sector_t sec)
 		move_to_lru(bp, &p_fs->buf_cache_lru_list);
 	}
 
-	up(&b_sem);
+	mutex_unlock(&b_mutex);
 }
 
 void buf_release_all(struct super_block *sb)
@@ -684,7 +684,7 @@ void buf_release_all(struct super_block *sb)
 	struct buf_cache_t *bp;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
-	down(&b_sem);
+	mutex_lock(&b_mutex);
 
 	bp = p_fs->buf_cache_lru_list.next;
 	while (bp != &p_fs->buf_cache_lru_list) {
@@ -701,7 +701,7 @@ void buf_release_all(struct super_block *sb)
 		bp = bp->next;
 	}
 
-	up(&b_sem);
+	mutex_unlock(&b_mutex);
 }
 
 void buf_sync(struct super_block *sb)
@@ -709,7 +709,7 @@ void buf_sync(struct super_block *sb)
 	struct buf_cache_t *bp;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
-	down(&b_sem);
+	mutex_lock(&b_mutex);
 
 	bp = p_fs->buf_cache_lru_list.next;
 	while (bp != &p_fs->buf_cache_lru_list) {
@@ -720,5 +720,5 @@ void buf_sync(struct super_block *sb)
 		bp = bp->next;
 	}
 
-	up(&b_sem);
+	mutex_unlock(&b_mutex);
 }
-- 
2.16.4

