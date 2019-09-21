Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AFBC4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 18:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32BB21835
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 18:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbfIUSpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 14:45:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2764 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728438AbfIUSpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 14:45:19 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C8D3E833CB90D33ABA42;
        Sun, 22 Sep 2019 02:45:15 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sun, 22 Sep
 2019 02:45:10 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2] erofs: fix erofs_get_meta_page locking by a cleanup
Date:   Sun, 22 Sep 2019 02:43:55 +0800
Message-ID: <20190921184355.149928-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190921073035.209811-1-gaoxiang25@huawei.com>
References: <20190921073035.209811-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After doing more drop_caches stress test on
our products, I found the mistake introduced by
a very recent cleanup [1].

The current rule is that "erofs_get_meta_page"
should be returned with page locked (although
it's mostly unnecessary for read-only fs after
pages are PG_uptodate), but a fix should be
done for this.

[1] https://lore.kernel.org/r/20190904020912.63925-26-gaoxiang25@huawei.com
Fixes: 618f40ea026b ("erofs: use read_cache_page_gfp for erofs_get_meta_page")
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
changelog from v1:
 - type of return value should be struct page *.

 fs/erofs/data.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 8a9fcbd0e8ac..fc3a8d8064f8 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -34,11 +34,15 @@ static void erofs_readendio(struct bio *bio)
 
 struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
 {
-	struct inode *const bd_inode = sb->s_bdev->bd_inode;
-	struct address_space *const mapping = bd_inode->i_mapping;
+	struct address_space *const mapping = sb->s_bdev->bd_inode->i_mapping;
+	struct page *page;
 
-	return read_cache_page_gfp(mapping, blkaddr,
+	page = read_cache_page_gfp(mapping, blkaddr,
 				   mapping_gfp_constraint(mapping, ~__GFP_FS));
+	/* should already be PageUptodate */
+	if (!IS_ERR(page))
+		lock_page(page);
+	return page;
 }
 
 static int erofs_map_blocks_flatmode(struct inode *inode,
-- 
2.17.1

