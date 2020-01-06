Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EC7C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5492124650
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgAFICG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:02:06 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42250 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725844AbgAFIB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:01:58 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D99BBB0FD549768C145A;
        Mon,  6 Jan 2020 16:01:55 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Mon, 6 Jan 2020 16:01:49 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/4] f2fs: compress: release compress context in caller of f2fs_read_multi_pages()
Date:   Mon, 6 Jan 2020 16:01:44 +0800
Message-ID: <20200106080144.52363-4-yuchao0@huawei.com>
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

Execute initialize/destroy flow of compress context outside of
f2fs_read_multi_pages()

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c |  1 +
 fs/f2fs/data.c     | 10 +++-------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 3390351d2e39..7727b6553a14 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -615,6 +615,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 
 		ret = f2fs_read_multi_pages(cc, &bio, cc->cluster_size,
 						&last_block_in_bio, false);
+		f2fs_destroy_compress_ctx(cc);
 		if (ret)
 			goto release_pages;
 		if (bio)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5476d33f2d76..e68b9f4b7913 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2121,7 +2121,6 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 							false);
 				f2fs_free_dic(dic);
 				f2fs_put_dnode(&dn);
-				f2fs_destroy_compress_ctx(cc);
 				*bio_ret = bio;
 				return ret;
 			}
@@ -2139,7 +2138,6 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 
 	f2fs_put_dnode(&dn);
 
-	f2fs_destroy_compress_ctx(cc);
 	*bio_ret = bio;
 	return 0;
 
@@ -2213,10 +2211,9 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 							max_nr_pages,
 							&last_block_in_bio,
 							is_readahead);
-				if (ret) {
-					f2fs_destroy_compress_ctx(&cc);
+				f2fs_destroy_compress_ctx(&cc);
+				if (ret)
 					goto set_error_page;
-				}
 			}
 			ret = f2fs_is_compressed_cluster(inode, page->index);
 			if (ret < 0)
@@ -2257,8 +2254,7 @@ int f2fs_mpage_readpages(struct address_space *mapping,
 							max_nr_pages,
 							&last_block_in_bio,
 							is_readahead);
-				if (ret)
-					f2fs_destroy_compress_ctx(&cc);
+				f2fs_destroy_compress_ctx(&cc);
 			}
 		}
 #endif
-- 
2.18.0.rc1

