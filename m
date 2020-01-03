Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE004C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 09:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996202053B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 09:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgACJvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 04:51:21 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:59048 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725972AbgACJvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 04:51:20 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8145DAB6D6BC0B2438A2;
        Fri,  3 Jan 2020 17:51:19 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Fri, 3 Jan 2020 17:51:13 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH TEST] f2fs: compress: fix deadlock in prepare_compress_overwrite()
Date:   Fri, 3 Jan 2020 17:51:07 +0800
Message-ID: <20200103095107.8152-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

   100.00%    13.65%  fsstress  [f2fs]              [k] prepare_compress_overwrite
            |
            |--86.35%--prepare_compress_overwrite
            |          |
            |          |--46.78%--f2fs_read_multi_pages
            |          |          |
            |          |          |--19.81%--f2fs_decompress_end_io
            |          |          |          |
            |          |          |           --5.77%--unlock_page
            |          |          |
            |          |          |--19.53%--f2fs_get_dnode_of_data

In prepare_compress_overwrite(), we need to check cluster state before
read cluster data, otherwise, read normal cluster as a compressed one
will always cause failure and retry.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 9e8fba78db4d..f993b4ce1970 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -570,8 +570,7 @@ static void set_cluster_dirty(struct compress_ctx *cc)
 }
 
 static int prepare_compress_overwrite(struct compress_ctx *cc,
-		struct page **pagep, pgoff_t index, void **fsdata,
-		bool prealloc)
+		struct page **pagep, pgoff_t index, void **fsdata)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
 	struct address_space *mapping = cc->inode->i_mapping;
@@ -582,11 +581,20 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 	unsigned int start_idx = start_idx_of_cluster(cc);
 	int i, idx;
 	int ret;
+	bool prealloc;
+
+retry:
+	ret = is_compressed_cluster(cc);
+	if (ret <= 0)
+		return ret;
+
+	/* compressed case */
+	prealloc = (ret == CLUSTER_HAS_SPACE);
 
 	ret = f2fs_init_compress_ctx(cc);
 	if (ret)
 		return ret;
-retry:
+
 	/* keep page reference to avoid page reclaim */
 	for (i = 0; i < cc->cluster_size; i++) {
 		page = f2fs_pagecache_get_page(mapping, start_idx + i,
@@ -632,6 +640,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 						(idx <= i) ? 1 : 0);
 				cc->rpages[idx] = NULL;
 			}
+			kvfree(cc->rpages);
 			cc->nr_rpages = 0;
 			goto retry;
 		}
@@ -687,14 +696,8 @@ int f2fs_prepare_compress_overwrite(struct inode *inode,
 		.rpages = NULL,
 		.nr_rpages = 0,
 	};
-	int ret = is_compressed_cluster(&cc);
-
-	if (ret <= 0)
-		return ret;
 
-	/* compressed case */
-	return prepare_compress_overwrite(&cc, pagep, index,
-			fsdata, ret == CLUSTER_HAS_SPACE);
+	return prepare_compress_overwrite(&cc, pagep, index, fsdata);
 }
 
 bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
-- 
2.18.0.rc1

