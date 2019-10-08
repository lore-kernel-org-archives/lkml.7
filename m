Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407DCECE58E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2464420640
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbfJHMxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:53:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36936 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730301AbfJHMxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:53:23 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EE0A8341A32B5758DA77;
        Tue,  8 Oct 2019 20:53:20 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 8 Oct 2019
 20:53:14 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
        "Li Guifu" <bluce.liguifu@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH for-next 3/5] erofs: get rid of __stagingpage_alloc helper
Date:   Tue, 8 Oct 2019 20:56:14 +0800
Message-ID: <20191008125616.183715-3-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008125616.183715-1-gaoxiang25@huawei.com>
References: <20191008125616.183715-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now open code is much cleaner due to iterative development.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/zdata.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 93f8bc1a64f6..e2a89aa921b1 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -546,15 +546,6 @@ static bool z_erofs_collector_end(struct z_erofs_collector *clt)
 	return true;
 }
 
-static inline struct page *__stagingpage_alloc(struct list_head *pagepool,
-					       gfp_t gfp)
-{
-	struct page *page = erofs_allocpage(pagepool, gfp, true);
-
-	page->mapping = Z_EROFS_MAPPING_STAGING;
-	return page;
-}
-
 static bool should_alloc_managed_pages(struct z_erofs_decompress_frontend *fe,
 				       unsigned int cachestrategy,
 				       erofs_off_t la)
@@ -661,8 +652,9 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	/* should allocate an additional staging page for pagevec */
 	if (err == -EAGAIN) {
 		struct page *const newpage =
-			__stagingpage_alloc(pagepool, GFP_NOFS);
+			erofs_allocpage(pagepool, GFP_NOFS, true);
 
+		newpage->mapping = Z_EROFS_MAPPING_STAGING;
 		err = z_erofs_attach_page(clt, newpage,
 					  Z_EROFS_PAGE_TYPE_EXCLUSIVE);
 		if (!err)
@@ -1079,15 +1071,14 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 	unlock_page(page);
 	put_page(page);
 out_allocpage:
-	page = __stagingpage_alloc(pagepool, gfp);
+	page = erofs_allocpage(pagepool, gfp, true);
 	if (oldpage != cmpxchg(&pcl->compressed_pages[nr], oldpage, page)) {
 		list_add(&page->lru, pagepool);
 		cpu_relax();
 		goto repeat;
 	}
-	if (!tocache)
-		goto out;
-	if (add_to_page_cache_lru(page, mc, index + nr, gfp)) {
+
+	if (!tocache || add_to_page_cache_lru(page, mc, index + nr, gfp)) {
 		page->mapping = Z_EROFS_MAPPING_STAGING;
 		goto out;
 	}
-- 
2.17.1

