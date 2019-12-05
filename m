Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B402EC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 03:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8668E2073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 03:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jkHXGE9M";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="K+oU3+Uj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfLEDW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 22:22:57 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:44900
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728449AbfLEDW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 22:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575516175;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=ZxfkLmFazMJpiu9m+ih76+k+ybK4xc+/rzCa3efKykg=;
        b=jkHXGE9MvpOWTyqvBvfgXimjbQGHnBucRA6gMLWjyV0QOM4DC+viu/rfiRvgdvVl
        MshNIXRhxGmORBExa9V1zzYHX2p78/Y5Ng4kBZdw7ekjZ/Vkh6QP5Xw8O9JtscrELA8
        59r6GAO95iF9I+mkHC76Sjebl0GsBVSHmhaOUt4w=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575516175;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=ZxfkLmFazMJpiu9m+ih76+k+ybK4xc+/rzCa3efKykg=;
        b=K+oU3+UjZnH/ilq2yLg4E+ZiaYmy8HfTjDs41JWiGE8PkbKiCijLYyFrYAFsO4Zc
        m8ew6k9OPCrpMszFeje3uXq94xlNi2JoGGzQxJzBY1YXpTpyzMAB3XLuGQHD2Lz7S5Q
        uz8zn0ISAcowI0lLSXJx1ibbSKrTwHNGjqd+a+Vk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C940EC447A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: cleanup duplicate stats for atomic files
Date:   Thu, 5 Dec 2019 03:22:55 +0000
Message-ID: <0101016ed414fcf8-82a0c15b-83d5-460c-b7d9-e6327abdd10c-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 1.9.1
X-SES-Outgoing: 2019.12.05-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate sbi->aw_cnt stats counter that tracks
the number of atomic files currently opened (it also shows
incorrect value sometimes). Use more reliable sbi->atomic_files
to show in the stats.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/debug.c   | 3 +--
 fs/f2fs/f2fs.h    | 7 +------
 fs/f2fs/file.c    | 1 -
 fs/f2fs/segment.c | 1 -
 4 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 9b0bedd..0e87813 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -56,7 +56,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->nquota_files = sbi->nquota_files;
 	si->ndirty_all = sbi->ndirty_inode[DIRTY_META];
 	si->inmem_pages = get_pages(sbi, F2FS_INMEM_PAGES);
-	si->aw_cnt = atomic_read(&sbi->aw_cnt);
+	si->aw_cnt = sbi->atomic_files;
 	si->vw_cnt = atomic_read(&sbi->vw_cnt);
 	si->max_aw_cnt = atomic_read(&sbi->max_aw_cnt);
 	si->max_vw_cnt = atomic_read(&sbi->max_vw_cnt);
@@ -495,7 +495,6 @@ int f2fs_build_stats(struct f2fs_sb_info *sbi)
 	for (i = META_CP; i < META_MAX; i++)
 		atomic_set(&sbi->meta_count[i], 0);
 
-	atomic_set(&sbi->aw_cnt, 0);
 	atomic_set(&sbi->vw_cnt, 0);
 	atomic_set(&sbi->max_aw_cnt, 0);
 	atomic_set(&sbi->max_vw_cnt, 0);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5a888a0..26a61e8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1327,7 +1327,6 @@ struct f2fs_sb_info {
 	atomic_t inline_xattr;			/* # of inline_xattr inodes */
 	atomic_t inline_inode;			/* # of inline_data inodes */
 	atomic_t inline_dir;			/* # of inline_dentry inodes */
-	atomic_t aw_cnt;			/* # of atomic writes */
 	atomic_t vw_cnt;			/* # of volatile writes */
 	atomic_t max_aw_cnt;			/* max # of atomic writes */
 	atomic_t max_vw_cnt;			/* max # of volatile writes */
@@ -3386,13 +3385,9 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 		((sbi)->block_count[(curseg)->alloc_type]++)
 #define stat_inc_inplace_blocks(sbi)					\
 		(atomic_inc(&(sbi)->inplace_count))
-#define stat_inc_atomic_write(inode)					\
-		(atomic_inc(&F2FS_I_SB(inode)->aw_cnt))
-#define stat_dec_atomic_write(inode)					\
-		(atomic_dec(&F2FS_I_SB(inode)->aw_cnt))
 #define stat_update_max_atomic_write(inode)				\
 	do {								\
-		int cur = atomic_read(&F2FS_I_SB(inode)->aw_cnt);	\
+		int cur = F2FS_I_SB(inode)->atomic_files;	\
 		int max = atomic_read(&F2FS_I_SB(inode)->max_aw_cnt);	\
 		if (cur > max)						\
 			atomic_set(&F2FS_I_SB(inode)->max_aw_cnt, cur);	\
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 85af112..dfe6efe 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1935,7 +1935,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	F2FS_I(inode)->inmem_task = current;
-	stat_inc_atomic_write(inode);
 	stat_update_max_atomic_write(inode);
 out:
 	inode_unlock(inode);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 56e8144..c0917d5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -334,7 +334,6 @@ void f2fs_drop_inmem_pages(struct inode *inode)
 	}
 
 	fi->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
-	stat_dec_atomic_write(inode);
 
 	spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
 	if (!list_empty(&fi->inmem_ilist))
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

