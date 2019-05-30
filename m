Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2044C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9997A25EE1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 17:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559239037;
	bh=w8hNSnfYZ3vC8KLmmbKZFRJHcMSb2JVko1p4pcUentA=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=wM9WgCzgw9j2aD+Pw4MTy3fCc/9KVaGxFkC2phG1LrWfC5k7uhek8KzzjbgYC6xL8
	 G9eiX6wRNeSRlQwoJjZ8kylAq8HyuEeTqRnGL8/386B3qg5w9dWvHyYculsAJDHeeE
	 5+qIgTqTMLp+g0Q1x2xI23RuioK3tki3fZGRnxI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfE3R5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 13:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfE3R5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 13:57:16 -0400
Received: from localhost (unknown [104.132.1.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47EE725EDD;
        Thu, 30 May 2019 17:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559239035;
        bh=w8hNSnfYZ3vC8KLmmbKZFRJHcMSb2JVko1p4pcUentA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=xN8e76AtwOSE3SMEmWxCUpUerbHkDmGhS1c9DeamLHkX5Ws5DnCZLtI96X8CGsJYB
         2ZjwIezD8mkoC9tbl2Q6AVAWXNDeiVm3l9nN82Sx6bqcH3ChfP9sMjFIdEZab6+RzF
         Rtzdpsn5e2Fw8ld/mr9Bp4pXrG6tWW1i5xZA3vAs=
Date:   Thu, 30 May 2019 10:57:14 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: add a rw_sem to cover quota flag changes
Message-ID: <20190530175714.GB28719@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190530033115.16853-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530033115.16853-1-jaegeuk@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thread 1:                        thread 2:
writeback                        checkpoint
set QUOTA_NEED_FLUSH
                                 clear QUOTA_NEED_FLUSH
f2fs_dquot_commit
dquot_commit
clear_dquot_dirty
                                 f2fs_quota_sync
                                 dquot_writeback_dquots
				 nothing to commit
commit_dqblk
quota_write
f2fs_quota_write
waiting for f2fs_lock_op()
				 pass __need_flush_quota
                                 (no F2FS_DIRTY_QDATA)

-> up-to-date quota is not written

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

v2 from v1:
 - avoid deadlock.
 - shorten the loop path

 fs/f2fs/checkpoint.c | 40 ++++++++++++++++++++--------------------
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/super.c      | 27 ++++++++++++++++++++++-----
 3 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 89825261d474..66f29907fc0e 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1131,17 +1131,26 @@ static void __prepare_cp_block(struct f2fs_sb_info *sbi)
 
 static bool __need_flush_quota(struct f2fs_sb_info *sbi)
 {
+	bool ret;
+
 	if (!is_journalled_quota(sbi))
 		return false;
-	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
-		return false;
-	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
-		return false;
-	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_FLUSH))
-		return true;
-	if (get_pages(sbi, F2FS_DIRTY_QDATA))
+
+	if (!down_write_trylock(&sbi->quota_sem))
 		return true;
-	return false;
+
+	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
+		ret = false;
+	else if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
+		ret = false;
+	else if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_FLUSH))
+		ret = true;
+	else if (get_pages(sbi, F2FS_DIRTY_QDATA))
+		ret = true;
+	else
+		ret = false;
+	up_write(&sbi->quota_sem);
+	return ret;
 }
 
 /*
@@ -1160,14 +1169,16 @@ static int block_operations(struct f2fs_sb_info *sbi)
 	blk_start_plug(&plug);
 
 retry_flush_quotas:
+	f2fs_lock_all(sbi);
 	if (__need_flush_quota(sbi)) {
 		int locked;
 
 		if (++cnt > DEFAULT_RETRY_QUOTA_FLUSH_COUNT) {
 			set_sbi_flag(sbi, SBI_QUOTA_SKIP_FLUSH);
-			f2fs_lock_all(sbi);
 			goto retry_flush_dents;
 		}
+
+		f2fs_unlock_all(sbi);
 		clear_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
 
 		/* only failed during mount/umount/freeze/quotactl */
@@ -1175,11 +1186,6 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		f2fs_quota_sync(sbi->sb, -1);
 		if (locked)
 			up_read(&sbi->sb->s_umount);
-	}
-
-	f2fs_lock_all(sbi);
-	if (__need_flush_quota(sbi)) {
-		f2fs_unlock_all(sbi);
 		cond_resched();
 		goto retry_flush_quotas;
 	}
@@ -1201,12 +1207,6 @@ static int block_operations(struct f2fs_sb_info *sbi)
 	 */
 	down_write(&sbi->node_change);
 
-	if (__need_flush_quota(sbi)) {
-		up_write(&sbi->node_change);
-		f2fs_unlock_all(sbi);
-		goto retry_flush_quotas;
-	}
-
 	if (get_pages(sbi, F2FS_DIRTY_IMETA)) {
 		up_write(&sbi->node_change);
 		f2fs_unlock_all(sbi);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9b3d9977cd1e..692c0922f5b2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1250,6 +1250,7 @@ struct f2fs_sb_info {
 	block_t unusable_block_count;		/* # of blocks saved by last cp */
 
 	unsigned int nquota_files;		/* # of quota sysfile */
+	struct rw_semaphore quota_sem;		/* blocking cp for flags */
 
 	/* # of pages, see count_type */
 	atomic_t nr_pages[NR_COUNT_TYPE];
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1dc02101e5e5..7a6d70d8e851 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1946,7 +1946,10 @@ int f2fs_quota_sync(struct super_block *sb, int type)
 	int cnt;
 	int ret;
 
+	down_read(&sbi->quota_sem);
 	ret = dquot_writeback_dquots(sb, type);
+	up_read(&sbi->quota_sem);
+
 	if (ret)
 		goto out;
 
@@ -2076,32 +2079,40 @@ static void f2fs_truncate_quota_inode_pages(struct super_block *sb)
 
 static int f2fs_dquot_commit(struct dquot *dquot)
 {
+	struct f2fs_sb_info *sbi = F2FS_SB(dquot->dq_sb);
 	int ret;
 
+	down_read(&sbi->quota_sem);
 	ret = dquot_commit(dquot);
 	if (ret < 0)
-		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_QUOTA_NEED_REPAIR);
+		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+	up_read(&sbi->quota_sem);
 	return ret;
 }
 
 static int f2fs_dquot_acquire(struct dquot *dquot)
 {
+	struct f2fs_sb_info *sbi = F2FS_SB(dquot->dq_sb);
 	int ret;
 
+	down_read(&sbi->quota_sem);
 	ret = dquot_acquire(dquot);
 	if (ret < 0)
-		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_QUOTA_NEED_REPAIR);
-
+		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+	up_read(&sbi->quota_sem);
 	return ret;
 }
 
 static int f2fs_dquot_release(struct dquot *dquot)
 {
+	struct f2fs_sb_info *sbi = F2FS_SB(dquot->dq_sb);
 	int ret;
 
+	down_read(&sbi->quota_sem);
 	ret = dquot_release(dquot);
 	if (ret < 0)
-		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_QUOTA_NEED_REPAIR);
+		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+	up_read(&sbi->quota_sem);
 	return ret;
 }
 
@@ -2111,22 +2122,27 @@ static int f2fs_dquot_mark_dquot_dirty(struct dquot *dquot)
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	int ret;
 
+	down_read(&sbi->quota_sem);
 	ret = dquot_mark_dquot_dirty(dquot);
 
 	/* if we are using journalled quota */
 	if (is_journalled_quota(sbi))
 		set_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
 
+	up_read(&sbi->quota_sem);
 	return ret;
 }
 
 static int f2fs_dquot_commit_info(struct super_block *sb, int type)
 {
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	int ret;
 
+	down_read(&sbi->quota_sem);
 	ret = dquot_commit_info(sb, type);
 	if (ret < 0)
-		set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
+		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+	up_read(&sbi->quota_sem);
 	return ret;
 }
 
@@ -3235,6 +3251,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	}
 
 	init_rwsem(&sbi->cp_rwsem);
+	init_rwsem(&sbi->quota_sem);
 	init_waitqueue_head(&sbi->cp_wait);
 	init_sb_info(sbi);
 
-- 
2.19.0.605.g01d371f741-goog

