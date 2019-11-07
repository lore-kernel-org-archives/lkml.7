Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC1BC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACDA21D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573154068;
	bh=PBhjHpiHePnx25/oiu/RFRiHoTI/vsJnixuQBq2ayKs=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=ZUDuJoVSVndur3AhZFIkRmTTbFTX0ZGCEd0rXK/reRbHlRPn5zmFG/8X6kBBU+Jbh
	 IUQqT3cyxr4ZHZnzox6lpOou7p9CRlmA93w/S8k6V4Rqpg/j36zG7pITF7nT0MI13W
	 ZpooGMTeeXBAEhUX3d8BjZ4MCEytMo4T0e3y9REw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfKGTO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:14:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbfKGTO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:14:27 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1864521882;
        Thu,  7 Nov 2019 19:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573154066;
        bh=PBhjHpiHePnx25/oiu/RFRiHoTI/vsJnixuQBq2ayKs=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=NA/+2iwH76buFPFddJDOLteOPDxueMx0ZqUkz4q4sgatD7WE0HwiekBN1DZf2HS6X
         pSVpgG9XF56kj24epcDNdyWLx5xLXJ1f4pmFRoxdOk14loUZapQd6kB5z9I9azLy5G
         0igDseg4Etza1atj9U48yc2+2xOveYm4kujqEsTg=
Date:   Thu, 7 Nov 2019 11:14:25 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/2 v2] f2fs: support aligned pinned file
Message-ID: <20191107191425.GA46490@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191022171602.93637-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022171602.93637-1-jaegeuk@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supports 2MB-aligned pinned file, which can guarantee no GC at all
by allocating fully valid 2MB segment.

Check free segments by has_not_enough_free_secs() with large budget.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v2 from v1:
 - avoid to allocate gc'ed segment and pinned segment consecutively
 - avoid to allocate SSR segment

 fs/f2fs/f2fs.h     |  4 +++-
 fs/f2fs/file.c     | 42 +++++++++++++++++++++++++++++++++++++-----
 fs/f2fs/recovery.c |  2 +-
 fs/f2fs/segment.c  | 31 +++++++++++++++++++++++++++----
 fs/f2fs/segment.h  |  2 ++
 fs/f2fs/super.c    |  1 +
 fs/f2fs/sysfs.c    |  2 ++
 7 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ca342f4c7db1..c681f51e351b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -890,6 +890,7 @@ enum {
 	CURSEG_WARM_NODE,	/* direct node blocks of normal files */
 	CURSEG_COLD_NODE,	/* indirect node blocks */
 	NO_CHECK_TYPE,
+	CURSEG_COLD_DATA_PINNED,/* cold data for pinned file */
 };
 
 struct flush_cmd {
@@ -1301,6 +1302,7 @@ struct f2fs_sb_info {
 
 	/* threshold for gc trials on pinned files */
 	u64 gc_pin_file_threshold;
+	struct rw_semaphore pin_sem;
 
 	/* maximum # of trials to find a victim segment for SSR and GC */
 	unsigned int max_victim_search;
@@ -3116,7 +3118,7 @@ void f2fs_release_discard_addrs(struct f2fs_sb_info *sbi);
 int f2fs_npages_for_summary_flush(struct f2fs_sb_info *sbi, bool for_ra);
 void allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 					unsigned int start, unsigned int end);
-void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi);
+void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi, int type);
 int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range);
 bool f2fs_exist_trim_candidates(struct f2fs_sb_info *sbi,
 					struct cp_control *cpc);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 29bc0a542759..c31a5bbc8090 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1545,12 +1545,44 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 	if (off_end)
 		map.m_len++;
 
-	if (f2fs_is_pinned_file(inode))
-		map.m_seg_type = CURSEG_COLD_DATA;
+	if (!map.m_len)
+		return 0;
+
+	if (f2fs_is_pinned_file(inode)) {
+		block_t len = (map.m_len >> sbi->log_blocks_per_seg) <<
+					sbi->log_blocks_per_seg;
+		block_t done = 0;
+
+		if (map.m_len % sbi->blocks_per_seg)
+			len += sbi->blocks_per_seg;
+
+		map.m_len = sbi->blocks_per_seg;
+next_alloc:
+		if (has_not_enough_free_secs(sbi, 0,
+			GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
+			mutex_lock(&sbi->gc_mutex);
+			err = f2fs_gc(sbi, true, false, NULL_SEGNO);
+			if (err && err != -ENODATA && err != -EAGAIN)
+				goto out_err;
+		}
 
-	err = f2fs_map_blocks(inode, &map, 1, (f2fs_is_pinned_file(inode) ?
-						F2FS_GET_BLOCK_PRE_DIO :
-						F2FS_GET_BLOCK_PRE_AIO));
+		down_write(&sbi->pin_sem);
+		map.m_seg_type = CURSEG_COLD_DATA_PINNED;
+		f2fs_allocate_new_segments(sbi, CURSEG_COLD_DATA);
+		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_DIO);
+		up_write(&sbi->pin_sem);
+
+		done += map.m_len;
+		len -= map.m_len;
+		map.m_lblk += map.m_len;
+		if (!err && len)
+			goto next_alloc;
+
+		map.m_len = done;
+	} else {
+		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
+	}
+out_err:
 	if (err) {
 		pgoff_t last_off;
 
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 783773e4560d..76477f71d4ee 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -711,7 +711,7 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 		f2fs_put_page(page, 1);
 	}
 	if (!err)
-		f2fs_allocate_new_segments(sbi);
+		f2fs_allocate_new_segments(sbi, NO_CHECK_TYPE);
 	return err;
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 25c750cd0272..8bb37f8a1845 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2690,7 +2690,7 @@ void allocate_segment_for_resize(struct f2fs_sb_info *sbi, int type,
 	up_read(&SM_I(sbi)->curseg_lock);
 }
 
-void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi)
+void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi, int type)
 {
 	struct curseg_info *curseg;
 	unsigned int old_segno;
@@ -2699,10 +2699,17 @@ void f2fs_allocate_new_segments(struct f2fs_sb_info *sbi)
 	down_write(&SIT_I(sbi)->sentry_lock);
 
 	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
+		if (type != NO_CHECK_TYPE && i != type)
+			continue;
+
 		curseg = CURSEG_I(sbi, i);
-		old_segno = curseg->segno;
-		SIT_I(sbi)->s_ops->allocate_segment(sbi, i, true);
-		locate_dirty_segment(sbi, old_segno);
+		if (type == NO_CHECK_TYPE || curseg->next_blkoff ||
+				get_valid_blocks(sbi, curseg->segno, false) ||
+				get_ckpt_valid_blocks(sbi, curseg->segno)) {
+			old_segno = curseg->segno;
+			SIT_I(sbi)->s_ops->allocate_segment(sbi, i, true);
+			locate_dirty_segment(sbi, old_segno);
+		}
 	}
 
 	up_write(&SIT_I(sbi)->sentry_lock);
@@ -3068,6 +3075,19 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 {
 	struct sit_info *sit_i = SIT_I(sbi);
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
+	bool put_pin_sem = false;
+
+	if (type == CURSEG_COLD_DATA) {
+		/* GC during CURSEG_COLD_DATA_PINNED allocation */
+		if (down_read_trylock(&sbi->pin_sem)) {
+			put_pin_sem = true;
+		} else {
+			type = CURSEG_WARM_DATA;
+			curseg = CURSEG_I(sbi, type);
+		}
+	} else if (type == CURSEG_COLD_DATA_PINNED) {
+		type = CURSEG_COLD_DATA;
+	}
 
 	down_read(&SM_I(sbi)->curseg_lock);
 
@@ -3133,6 +3153,9 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	mutex_unlock(&curseg->curseg_mutex);
 
 	up_read(&SM_I(sbi)->curseg_lock);
+
+	if (put_pin_sem)
+		up_read(&sbi->pin_sem);
 }
 
 static void update_device_state(struct f2fs_io_info *fio)
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 325781a1ae4d..a95467b202ea 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -313,6 +313,8 @@ struct sit_entry_set {
  */
 static inline struct curseg_info *CURSEG_I(struct f2fs_sb_info *sbi, int type)
 {
+	if (type == CURSEG_COLD_DATA_PINNED)
+		type = CURSEG_COLD_DATA;
 	return (struct curseg_info *)(SM_I(sbi)->curseg_array + type);
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f320fd11db48..c02a47ce551b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2853,6 +2853,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	spin_lock_init(&sbi->dev_lock);
 
 	init_rwsem(&sbi->sb_lock);
+	init_rwsem(&sbi->pin_sem);
 }
 
 static int init_percpu_info(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index b558b64a4c9c..f164959e4224 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -154,6 +154,8 @@ static ssize_t features_show(struct f2fs_attr *a,
 	if (f2fs_sb_has_casefold(sbi))
 		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "casefold");
+	len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
+				len ? ", " : "", "pin_file");
 	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
 	return len;
 }
-- 
2.19.0.605.g01d371f741-goog

