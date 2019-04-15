Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF7AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2682077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfDOMfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:35:44 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:60102 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726298AbfDOMfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:35:44 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 41561422654C81408671;
        Mon, 15 Apr 2019 20:35:41 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 15 Apr 2019 20:35:40 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 15 Apr 2019 20:35:40 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to consider multiple device for readonly check
Date:   Mon, 15 Apr 2019 20:35:34 +0800
Message-ID: <20190415123534.25254-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce f2fs_hw_is_readonly() to check whether lower
device is readonly or not, it adapts multiple device scenario.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/f2fs.h       | 14 ++++++++++++++
 fs/f2fs/super.c      |  2 +-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 90e1bab86269..08b339c665a1 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -674,7 +674,7 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
 	if (!is_set_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG))
 		return 0;
 
-	if (bdev_read_only(sbi->sb->s_bdev)) {
+	if (f2fs_hw_is_readonly(sbi)) {
 		f2fs_msg(sbi->sb, KERN_INFO, "write access "
 			"unavailable, skipping orphan cleanup");
 		return 0;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b98b22039f58..4dd26ef95926 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3587,6 +3587,20 @@ static inline bool f2fs_realtime_discard_enable(struct f2fs_sb_info *sbi)
 					f2fs_hw_should_discard(sbi);
 }
 
+static inline bool f2fs_hw_is_readonly(struct f2fs_sb_info *sbi)
+{
+	int i;
+
+	if (!f2fs_is_multi_device(sbi))
+		return bdev_read_only(sbi->sb->s_bdev);
+
+	for (i = 0; i < sbi->s_ndevs; i++)
+		if (bdev_read_only(FDEV(i).bdev))
+			return true;
+	return false;
+}
+
+
 static inline void set_opt_mode(struct f2fs_sb_info *sbi, unsigned int mt)
 {
 	clear_opt(sbi, ADAPTIVE);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index cbbb1e35070d..0c3abcc0dd27 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3377,7 +3377,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		 * mount should be failed, when device has readonly mode, and
 		 * previous checkpoint was not done by clean system shutdown.
 		 */
-		if (bdev_read_only(sb->s_bdev) &&
+		if (f2fs_hw_is_readonly(sbi) &&
 				!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
 			err = -EROFS;
 			goto free_meta;
-- 
2.18.0.rc1

