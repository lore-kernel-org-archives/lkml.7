Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D889C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC51227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576699793;
	bh=W2uMCJVpanpiKWXRI26gL3PaRjh3Wk4iqNVcFWlQmck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eLCpOd5u4FJ+8LUebDrJtUrbCgcdgWzl0WKfnbwoWwQ+7rHjZB4vKA0kHvQu7HS3x
	 GQ2TjkOpiP16qJq1HHMbCXusADma8iYShxaMD0ygpo0BzHeKR+tnxGBbWVZjTlCUQL
	 HB7HCAdoVXw7gX7mG4NTh+Zuc2gKJff5AQJXavN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfLRUJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:09:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfLRUJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:09:50 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D46424650;
        Wed, 18 Dec 2019 20:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576699789;
        bh=W2uMCJVpanpiKWXRI26gL3PaRjh3Wk4iqNVcFWlQmck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WVjdznsmLsk/6M4cPCUDn12ivFAgiZtOffllkTOac3FUEK7TFFywLr1VDRClqt9+w
         1YzwlwVqy7o22UsjdZ8ZDAwei9fYhCoiu671cqccIBcH6I6VbzT0l/BO2ZGuc1ju2L
         ciRzz/1K9crParmMGPVjXxrFj+19geCADZpNzZwg=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs: declare nested quota_sem and remove unnecessary sems
Date:   Wed, 18 Dec 2019 12:09:46 -0800
Message-Id: <20191218200947.20445-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
In-Reply-To: <20191218200947.20445-1-jaegeuk@kernel.org>
References: <20191218200947.20445-1-jaegeuk@kernel.org>
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
 fs/f2fs/super.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9e85894d12c9..e6fb4b52eb91 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2158,7 +2158,7 @@ static int f2fs_dquot_commit(struct dquot *dquot)
 	struct f2fs_sb_info *sbi = F2FS_SB(dquot->dq_sb);
 	int ret;
 
-	down_read(&sbi->quota_sem);
+	down_read_nested(&sbi->quota_sem, SINGLE_DEPTH_NESTING);
 	ret = dquot_commit(dquot);
 	if (ret < 0)
 		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
@@ -2182,13 +2182,10 @@ static int f2fs_dquot_acquire(struct dquot *dquot)
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
 
@@ -2196,29 +2193,22 @@ static int f2fs_dquot_mark_dquot_dirty(struct dquot *dquot)
 {
 	struct super_block *sb = dquot->dq_sb;
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-	int ret;
-
-	down_read(&sbi->quota_sem);
-	ret = dquot_mark_dquot_dirty(dquot);
+	int ret = dquot_mark_dquot_dirty(dquot);
 
 	/* if we are using journalled quota */
 	if (is_journalled_quota(sbi))
 		set_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
 
-	up_read(&sbi->quota_sem);
 	return ret;
 }
 
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
2.24.0.525.g8f36a354ae-goog

