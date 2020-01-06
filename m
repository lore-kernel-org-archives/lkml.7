Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC6FC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8A721734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgAFICE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:02:04 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42272 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726281AbgAFIB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:01:58 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EA950C201F57EAF36E37;
        Mon,  6 Jan 2020 16:01:55 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Mon, 6 Jan 2020 16:01:48 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/4] f2fs: compress: fix error path in prepare_compress_overwrite()
Date:   Mon, 6 Jan 2020 16:01:43 +0800
Message-ID: <20200106080144.52363-3-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200106080144.52363-1-yuchao0@huawei.com>
References: <20200106080144.52363-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- fix to release cluster pages in retry flow
- fix to call f2fs_put_dnode() & __do_map_lock() in error path

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index fc4510729654..3390351d2e39 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -626,20 +626,26 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 	}
 
 	for (i = 0; i < cc->cluster_size; i++) {
+		f2fs_bug_on(sbi, cc->rpages[i]);
+
 		page = find_lock_page(mapping, start_idx + i);
 		f2fs_bug_on(sbi, !page);
 
 		f2fs_wait_on_page_writeback(page, DATA, true, true);
 
-		cc->rpages[i] = page;
+		f2fs_compress_ctx_add_page(cc, page);
 		f2fs_put_page(page, 0);
 
 		if (!PageUptodate(page)) {
-			for (idx = 0; idx < cc->cluster_size; idx++) {
-				f2fs_put_page(cc->rpages[idx],
-						(idx <= i) ? 1 : 0);
+			for (idx = 0; idx <= i; idx++) {
+				unlock_page(cc->rpages[idx]);
 				cc->rpages[idx] = NULL;
 			}
+			for (idx = 0; idx < cc->cluster_size; idx++) {
+				page = find_lock_page(mapping, start_idx + idx);
+				f2fs_put_page(page, 1);
+				f2fs_put_page(page, 0);
+			}
 			kvfree(cc->rpages);
 			cc->nr_rpages = 0;
 			goto retry;
@@ -654,16 +660,20 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 		for (i = cc->cluster_size - 1; i > 0; i--) {
 			ret = f2fs_get_block(&dn, start_idx + i);
 			if (ret) {
-				/* TODO: release preallocate blocks */
 				i = cc->cluster_size;
-				goto unlock_pages;
+				break;
 			}
 
 			if (dn.data_blkaddr != NEW_ADDR)
 				break;
 		}
 
+		f2fs_put_dnode(&dn);
+
 		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
+
+		if (ret)
+			goto unlock_pages;
 	}
 
 	*fsdata = cc->rpages;
-- 
2.18.0.rc1

