Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DFEC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A167207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575930238;
	bh=A+gppiBF+YkBTBbG9jAbQcsegmphuu6BqQl55N2MGpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uqIjVLNYNEliMh2H6mV3+T4t8zDvIPhke6Ux0uk6sEFlTDnmbePeGNDhm2Dq1Xn+P
	 gOz0ban0JLOK2AXCQGsc0IdslOUATvrHwvOQJvFkUlmJAnutL9Bs10OBiSDdgwdnYc
	 M1TwCFzyBLnEfIHl1Yw/FJN/I1ipLZ4AIcxccXyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfLIWXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 17:23:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbfLIWXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 17:23:47 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B9762071E;
        Mon,  9 Dec 2019 22:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575930227;
        bh=A+gppiBF+YkBTBbG9jAbQcsegmphuu6BqQl55N2MGpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QoM6NzNiGJqicb+Ws8gUtxZCWYelOHpEef3cGJYk6HEfrAGJOGUz/RZ4SFzVt5GsQ
         2Y9TUW4k9V5XXjX9g2774ksy4/mngjfVobySy5Tr2vaC99Y6KI5FQ0VahT0cmV60St
         wqF73/kj7rWlziKSdt+p6MhcVScbmlwg2IEW+2qw=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/6] f2fs: declare nested quota_sem and remove unnecessary sems
Date:   Mon,  9 Dec 2019 14:23:41 -0800
Message-Id: <20191209222345.1078-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20191209222345.1078-1-jaegeuk@kernel.org>
References: <20191209222345.1078-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.
f2fs_quota_sync
 -> down_read(&sbi->quota_sem)
 -> dquot_writeback_dquots
  -> f2fs_dquot_commit
   -> down_read(&sbi->quota_sem)

2.
f2fs_quota_sync
 -> down_read(&sbi->quota_sem)
  -> f2fs_write_data_pages
   -> f2fs_write_single_data_page
    -> down_write(&F2FS_I(inode)->i_sem)

f2fs_mkdir
 -> f2fs_do_add_link
   -> down_write(&F2FS_I(inode)->i_sem)
   -> f2fs_init_inode_metadata
    -> f2fs_new_node_page
     -> dquot_alloc_inode
      -> f2fs_dquot_mark_dquot_dirty
       -> down_read(&sbi->quota_sem)

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5111e1ffe58a..15888ca02e7f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2156,39 +2156,30 @@ static void f2fs_truncate_quota_inode_pages(struct super_block *sb)
 static int f2fs_dquot_commit(struct dquot *dquot)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(dquot->dq_sb);
-	int ret;
+	int ret = dquot_commit(dquot);
 
-	down_read(&sbi->quota_sem);
-	ret = dquot_commit(dquot);
 	if (ret < 0)
 		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
-	up_read(&sbi->quota_sem);
 	return ret;
 }
 
 static int f2fs_dquot_acquire(struct dquot *dquot)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(dquot->dq_sb);
-	int ret;
+	int ret = dquot_acquire(dquot);
 
-	down_read(&sbi->quota_sem);
-	ret = dquot_acquire(dquot);
 	if (ret < 0)
 		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
-	up_read(&sbi->quota_sem);
 	return ret;
 }
 
 static int f2fs_dquot_release(struct dquot *dquot)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(dquot->dq_sb);
-	int ret;
+	int ret = dquot_release(dquot);
 
-	down_read(&sbi->quota_sem);
-	ret = dquot_release(dquot);
 	if (ret < 0)
 		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
-	up_read(&sbi->quota_sem);
 	return ret;
 }
 
@@ -2198,7 +2189,7 @@ static int f2fs_dquot_mark_dquot_dirty(struct dquot *dquot)
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	int ret;
 
-	down_read(&sbi->quota_sem);
+	down_read_nested(&sbi->quota_sem, SINGLE_DEPTH_NESTING);
 	ret = dquot_mark_dquot_dirty(dquot);
 
 	/* if we are using journalled quota */
@@ -2212,13 +2203,10 @@ static int f2fs_dquot_mark_dquot_dirty(struct dquot *dquot)
 static int f2fs_dquot_commit_info(struct super_block *sb, int type)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-	int ret;
+	int ret = dquot_commit_info(sb, type);
 
-	down_read(&sbi->quota_sem);
-	ret = dquot_commit_info(sb, type);
 	if (ret < 0)
 		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
-	up_read(&sbi->quota_sem);
 	return ret;
 }
 
-- 
2.19.0.605.g01d371f741-goog

