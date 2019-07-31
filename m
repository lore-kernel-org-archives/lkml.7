Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C37C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45E4208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbfGaP6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:58:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3673 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730160AbfGaP6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:58:37 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EF4BF432F7119B052D93;
        Wed, 31 Jul 2019 23:58:30 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 31 Jul
 2019 23:58:24 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 13/22] staging: erofs: refine erofs_allocpage()
Date:   Wed, 31 Jul 2019 23:57:43 +0800
Message-ID: <20190731155752.210602-14-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731155752.210602-1-gaoxiang25@huawei.com>
References: <20190731155752.210602-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove duplicated code in decompressor by introducing
failable erofs_allocpage().

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/decompressor.c | 12 +++---------
 drivers/staging/erofs/internal.h     |  2 +-
 drivers/staging/erofs/utils.c        |  5 +++--
 drivers/staging/erofs/zdata.c        |  5 +----
 4 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/erofs/decompressor.c b/drivers/staging/erofs/decompressor.c
index ee5762351f80..744c43a456e9 100644
--- a/drivers/staging/erofs/decompressor.c
+++ b/drivers/staging/erofs/decompressor.c
@@ -74,15 +74,9 @@ static int lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 			victim = availables[--top];
 			get_page(victim);
 		} else {
-			if (!list_empty(pagepool)) {
-				victim = lru_to_page(pagepool);
-				list_del(&victim->lru);
-				DBG_BUGON(page_ref_count(victim) != 1);
-			} else {
-				victim = alloc_pages(GFP_KERNEL, 0);
-				if (!victim)
-					return -ENOMEM;
-			}
+			victim = erofs_allocpage(pagepool, GFP_KERNEL, false);
+			if (unlikely(!victim))
+				return -ENOMEM;
 			victim->mapping = Z_EROFS_MAPPING_STAGING;
 		}
 		rq->out[i] = victim;
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 5e1ef2b5a458..a631acd0dc62 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -516,7 +516,7 @@ int erofs_namei(struct inode *dir, struct qstr *name,
 extern const struct file_operations erofs_dir_fops;
 
 /* utils.c / zdata.c */
-struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp);
+struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp, bool nofail);
 
 #if (EROFS_PCPUBUF_NR_PAGES > 0)
 void *erofs_get_pcpubuf(unsigned int pagenr);
diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
index 0e86e44d60d0..260ea2970b4b 100644
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -9,15 +9,16 @@
 #include "internal.h"
 #include <linux/pagevec.h>
 
-struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp)
+struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp, bool nofail)
 {
 	struct page *page;
 
 	if (!list_empty(pool)) {
 		page = lru_to_page(pool);
+		DBG_BUGON(page_ref_count(page) != 1);
 		list_del(&page->lru);
 	} else {
-		page = alloc_pages(gfp | __GFP_NOFAIL, 0);
+		page = alloc_pages(gfp | (nofail ? __GFP_NOFAIL : 0), 0);
 	}
 	return page;
 }
diff --git a/drivers/staging/erofs/zdata.c b/drivers/staging/erofs/zdata.c
index bc478eebf509..3078510e350d 100644
--- a/drivers/staging/erofs/zdata.c
+++ b/drivers/staging/erofs/zdata.c
@@ -634,10 +634,7 @@ z_erofs_vle_work_iter_end(struct z_erofs_vle_work_builder *builder)
 static inline struct page *__stagingpage_alloc(struct list_head *pagepool,
 					       gfp_t gfp)
 {
-	struct page *page = erofs_allocpage(pagepool, gfp);
-
-	if (unlikely(!page))
-		return NULL;
+	struct page *page = erofs_allocpage(pagepool, gfp, true);
 
 	page->mapping = Z_EROFS_MAPPING_STAGING;
 	return page;
-- 
2.17.1

