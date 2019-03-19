Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA235C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B0C2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfCSN5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:57:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726464AbfCSN5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:57:14 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 77F09648DCA63002E5C0;
        Tue, 19 Mar 2019 21:57:11 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.211)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 19 Mar 2019 21:57:04
 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 3/3] staging: erofs: support IO read error injection
Date:   Tue, 19 Mar 2019 21:55:01 +0800
Message-ID: <20190319135501.28712-3-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190319135501.28712-1-gaoxiang25@huawei.com>
References: <20190319135501.28712-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Used to simulate disk IO read error for testing fatal
error tolerance.

Here are the details,
1) use bio->bi_private to indicate super_block
   for non-compressed bios since some (mainly meta)
   pages can be of the corresponding bdev inode;
2) get super_block dynamically for compressed bios,
   therefore it could not inject bios full of staging
   pages, yet it doesn't affect the normal usage.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/Documentation/filesystems/erofs.txt |  1 +
 drivers/staging/erofs/data.c                              | 10 +++++++++-
 drivers/staging/erofs/internal.h                          |  3 ++-
 drivers/staging/erofs/super.c                             |  3 ++-
 drivers/staging/erofs/unzip_vle.c                         | 10 ++++++++--
 5 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/erofs/Documentation/filesystems/erofs.txt b/drivers/staging/erofs/Documentation/filesystems/erofs.txt
index 961ec4da7705..74cf84ac48a3 100644
--- a/drivers/staging/erofs/Documentation/filesystems/erofs.txt
+++ b/drivers/staging/erofs/Documentation/filesystems/erofs.txt
@@ -60,6 +60,7 @@ fault_injection=%d     Enable fault injection in all supported types with
                        specified injection rate. Supported injection type:
                        Type_Name                Type_Value
                        FAULT_KMALLOC            0x000000001
+                       FAULT_READ_IO            0x000000002
 (no)user_xattr         Setup Extended User Attributes. Note: xattr is enabled
                        by default if CONFIG_EROFS_FS_XATTR is selected.
 (no)acl                Setup POSIX Access Control List. Note: acl is enabled
diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
index 526e0dbea5b5..16302ee54261 100644
--- a/drivers/staging/erofs/data.c
+++ b/drivers/staging/erofs/data.c
@@ -17,11 +17,17 @@
 
 static inline void read_endio(struct bio *bio)
 {
+	struct super_block *const sb = bio->bi_private;
 	int i;
 	struct bio_vec *bvec;
-	const blk_status_t err = bio->bi_status;
+	blk_status_t err = bio->bi_status;
 	struct bvec_iter_all iter_all;
 
+	if (time_to_inject(EROFS_SB(sb), FAULT_READ_IO)) {
+		erofs_show_injection_info(FAULT_READ_IO);
+		err = BLK_STS_IOERR;
+	}
+
 	bio_for_each_segment_all(bvec, bio, i, iter_all) {
 		struct page *page = bvec->bv_page;
 
@@ -69,6 +75,7 @@ struct page *__erofs_get_meta_page(struct super_block *sb,
 			err = PTR_ERR(bio);
 			goto err_out;
 		}
+		bio->bi_private = sb;
 
 		err = bio_add_page(bio, page, PAGE_SIZE, 0);
 		if (unlikely(err != PAGE_SIZE)) {
@@ -288,6 +295,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 			bio = NULL;
 			goto err_out;
 		}
+		bio->bi_private = inode->i_sb;
 	}
 
 	err = bio_add_page(bio, page, PAGE_SIZE, 0);
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index ba1d86f3470e..5d7addd9cff0 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -44,11 +44,12 @@
 
 enum {
 	FAULT_KMALLOC,
+	FAULT_READ_IO,
 	FAULT_MAX,
 };
 
 #ifdef CONFIG_EROFS_FAULT_INJECTION
-extern char *erofs_fault_name[FAULT_MAX];
+extern const char *erofs_fault_name[FAULT_MAX];
 #define IS_FAULT_SET(fi, type) ((fi)->inject_type & (1 << (type)))
 
 struct erofs_fault_info {
diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
index 15c784fba879..ce025e6e4399 100644
--- a/drivers/staging/erofs/super.c
+++ b/drivers/staging/erofs/super.c
@@ -141,8 +141,9 @@ static int superblock_read(struct super_block *sb)
 }
 
 #ifdef CONFIG_EROFS_FAULT_INJECTION
-char *erofs_fault_name[FAULT_MAX] = {
+const char *erofs_fault_name[FAULT_MAX] = {
 	[FAULT_KMALLOC]		= "kmalloc",
+	[FAULT_READ_IO]		= "read IO error",
 };
 
 static void __erofs_build_fault_attr(struct erofs_sb_info *sbi,
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index d05fed4f8013..9fabdf596438 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -843,8 +843,8 @@ static void z_erofs_vle_unzip_kickoff(void *ptr, int bios)
 
 static inline void z_erofs_vle_read_endio(struct bio *bio)
 {
-	const blk_status_t err = bio->bi_status;
 	struct erofs_sb_info *sbi = NULL;
+	blk_status_t err = bio->bi_status;
 	unsigned int i;
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
@@ -856,9 +856,15 @@ static inline void z_erofs_vle_read_endio(struct bio *bio)
 		DBG_BUGON(PageUptodate(page));
 		DBG_BUGON(!page->mapping);
 
-		if (unlikely(!sbi && !z_erofs_is_stagingpage(page)))
+		if (unlikely(!sbi && !z_erofs_is_stagingpage(page))) {
 			sbi = EROFS_SB(page->mapping->host->i_sb);
 
+			if (time_to_inject(sbi, FAULT_READ_IO)) {
+				erofs_show_injection_info(FAULT_READ_IO);
+				err = BLK_STS_IOERR;
+			}
+		}
+
 		/* sbi should already be gotten if the page is managed */
 		if (sbi)
 			cachemngd = erofs_page_is_managed(sbi, page);
-- 
2.12.2

