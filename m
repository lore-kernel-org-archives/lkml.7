Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F83FC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8211B218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfGDIRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:17:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40374 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727012AbfGDIRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:17:43 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 29C5538450216D996387;
        Thu,  4 Jul 2019 16:17:41 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Thu, 4 Jul 2019 16:17:34 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Chen Gong <gongchen4@huawei.com>
Subject: [PATCH] f2fs: allocate memory in batch in build_sit_info()
Date:   Thu, 4 Jul 2019 16:17:30 +0800
Message-ID: <20190704081730.46414-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

build_sit_info() allocate all bitmaps for each segment one by one,
it's quite low efficiency, this pach changes to allocate large
continuous memory at a time, and divide it and assign for each bitmaps
of segment. For large size image, it can expect improving its mount
speed.

Signed-off-by: Chen Gong <gongchen4@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 51 +++++++++++++++++++++--------------------------
 fs/f2fs/segment.h |  1 +
 2 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 402fbbbb2d7c..73c803af1f31 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3929,7 +3929,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	struct sit_info *sit_i;
 	unsigned int sit_segs, start;
-	char *src_bitmap;
+	char *src_bitmap, *bitmap;
 	unsigned int bitmap_size;
 
 	/* allocate memory for SIT information */
@@ -3950,27 +3950,31 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 	if (!sit_i->dirty_sentries_bitmap)
 		return -ENOMEM;
 
+#ifdef CONFIG_F2FS_CHECK_FS
+	bitmap_size = MAIN_SEGS(sbi) * SIT_VBLOCK_MAP_SIZE * 4;
+#else
+	bitmap_size = MAIN_SEGS(sbi) * SIT_VBLOCK_MAP_SIZE * 3;
+#endif
+	sit_i->bitmap = f2fs_kzalloc(sbi, bitmap_size, GFP_KERNEL);
+	if (!sit_i->bitmap)
+		return -ENOMEM;
+
+	bitmap = sit_i->bitmap;
+
 	for (start = 0; start < MAIN_SEGS(sbi); start++) {
-		sit_i->sentries[start].cur_valid_map
-			= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
-		sit_i->sentries[start].ckpt_valid_map
-			= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
-		if (!sit_i->sentries[start].cur_valid_map ||
-				!sit_i->sentries[start].ckpt_valid_map)
-			return -ENOMEM;
+		sit_i->sentries[start].cur_valid_map = bitmap;
+		bitmap += SIT_VBLOCK_MAP_SIZE;
+
+		sit_i->sentries[start].ckpt_valid_map = bitmap;
+		bitmap += SIT_VBLOCK_MAP_SIZE;
 
 #ifdef CONFIG_F2FS_CHECK_FS
-		sit_i->sentries[start].cur_valid_map_mir
-			= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
-		if (!sit_i->sentries[start].cur_valid_map_mir)
-			return -ENOMEM;
+		sit_i->sentries[start].cur_valid_map_mir = bitmap;
+		bitmap += SIT_VBLOCK_MAP_SIZE;
 #endif
 
-		sit_i->sentries[start].discard_map
-			= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE,
-							GFP_KERNEL);
-		if (!sit_i->sentries[start].discard_map)
-			return -ENOMEM;
+		sit_i->sentries[start].discard_map = bitmap;
+		bitmap += SIT_VBLOCK_MAP_SIZE;
 	}
 
 	sit_i->tmp_map = f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
@@ -4440,21 +4444,12 @@ static void destroy_free_segmap(struct f2fs_sb_info *sbi)
 static void destroy_sit_info(struct f2fs_sb_info *sbi)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
-	unsigned int start;
 
 	if (!sit_i)
 		return;
 
-	if (sit_i->sentries) {
-		for (start = 0; start < MAIN_SEGS(sbi); start++) {
-			kvfree(sit_i->sentries[start].cur_valid_map);
-#ifdef CONFIG_F2FS_CHECK_FS
-			kvfree(sit_i->sentries[start].cur_valid_map_mir);
-#endif
-			kvfree(sit_i->sentries[start].ckpt_valid_map);
-			kvfree(sit_i->sentries[start].discard_map);
-		}
-	}
+	if (sit_i->sentries)
+		kvfree(sit_i->bitmap);
 	kvfree(sit_i->tmp_map);
 
 	kvfree(sit_i->sentries);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 2fd53462fa27..4d171b489130 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -226,6 +226,7 @@ struct sit_info {
 	block_t sit_base_addr;		/* start block address of SIT area */
 	block_t sit_blocks;		/* # of blocks used by SIT area */
 	block_t written_valid_blocks;	/* # of valid blocks in main area */
+	char *bitmap;			/* all bitmaps pointer */
 	char *sit_bitmap;		/* SIT bitmap pointer */
 #ifdef CONFIG_F2FS_CHECK_FS
 	char *sit_bitmap_mir;		/* SIT bitmap mirror */
-- 
2.18.0.rc1

