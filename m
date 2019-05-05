Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4734C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 03:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A23205ED
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 03:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfEEDk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 23:40:59 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3004 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726524AbfEEDk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 23:40:58 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id CF7D13334185D4094407;
        Sun,  5 May 2019 11:40:56 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 5 May 2019 11:40:55 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sun, 5 May 2019 11:40:55 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <linux-f2fs-devel@lists.sourceforge.net>, <jaegeuk@kernel.org>
CC:     <drosen@google.com>, <linux-kernel@vger.kernel.org>,
        <chao@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to avoid potential race on sbi->unusable_block_count access/update
Date:   Sun, 5 May 2019 11:40:46 +0800
Message-ID: <20190505034046.17905-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme720-chm.china.huawei.com (10.1.199.116) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sbi.stat_lock to protect sbi->unusable_block_count accesss/udpate, in
order to avoid potential race on it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 4 ++++
 fs/f2fs/segment.c    | 5 ++++-
 fs/f2fs/super.c      | 6 ++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 805a33088e82..ed70b68b2b38 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1536,7 +1536,11 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	clear_sbi_flag(sbi, SBI_IS_DIRTY);
 	clear_sbi_flag(sbi, SBI_NEED_CP);
 	clear_sbi_flag(sbi, SBI_QUOTA_SKIP_FLUSH);
+
+	spin_lock(&sbi->stat_lock);
 	sbi->unusable_block_count = 0;
+	spin_unlock(&sbi->stat_lock);
+
 	__set_cp_next_pack(sbi);
 
 	/*
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8388d2abacb5..8dee063c833f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2169,8 +2169,11 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 			 * before, we must track that to know how much space we
 			 * really have.
 			 */
-			if (f2fs_test_bit(offset, se->ckpt_valid_map))
+			if (f2fs_test_bit(offset, se->ckpt_valid_map)) {
+				spin_lock(&sbi->stat_lock);
 				sbi->unusable_block_count++;
+				spin_unlock(&sbi->stat_lock);
+			}
 		}
 
 		if (f2fs_test_and_clear_bit(offset, se->discard_map))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index dce4416cb1d8..d40cae0cba56 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1226,10 +1226,13 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_blocks = total_count - start_count;
 	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
 						sbi->current_reserved_blocks;
+
+	spin_lock(&sbi->stat_lock);
 	if (unlikely(buf->f_bfree <= sbi->unusable_block_count))
 		buf->f_bfree = 0;
 	else
 		buf->f_bfree -= sbi->unusable_block_count;
+	spin_unlock(&sbi->stat_lock);
 
 	if (buf->f_bfree > F2FS_OPTION(sbi).root_reserved_blocks)
 		buf->f_bavail = buf->f_bfree -
@@ -1508,7 +1511,10 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 	if (err)
 		goto out_unlock;
 
+	spin_lock(&sbi->stat_lock);
 	sbi->unusable_block_count = 0;
+	spin_unlock(&sbi->stat_lock);
+
 out_unlock:
 	mutex_unlock(&sbi->gc_mutex);
 restore_flag:
-- 
2.18.0.rc1

