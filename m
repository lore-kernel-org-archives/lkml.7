Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D84BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8272075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfCSN5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:57:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5269 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726464AbfCSN5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:57:09 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 622ABE167F3B7F0F2826;
        Tue, 19 Mar 2019 21:57:06 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.211)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 19 Mar 2019 21:56:59
 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/3] staging: erofs: fix error handling when failed to read compresssed data
Date:   Tue, 19 Mar 2019 21:54:59 +0800
Message-ID: <20190319135501.28712-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Complete read error handling paths for all three kinds of
compressed pages:

 1) For cache-managed pages, PG_uptodate will be checked since
    read_endio will unlock and SetPageUptodate for these pages;

 2) For inplaced pages, read_endio cannot SetPageUptodate directly
    since it should be used to mark the final decompressed data,
    PG_error will be set with page locked for IO error instead;

 3) For staging pages, PG_error is used, which is similar to
    what we do for inplaced pages.

Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

This series focus on fixing error handling when failed to read
compresssed data due to previous incomplete paths.

In addition, the last 2 patches add IO error fault injection
for reading paths, which I have used to test the first patch as well.

Thanks,
Gao Xiang

 drivers/staging/erofs/unzip_vle.c | 41 ++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 8715bc50e09c..3416d3f10324 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -972,6 +972,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	overlapped = false;
 	compressed_pages = grp->compressed_pages;
 
+	err = 0;
 	for (i = 0; i < clusterpages; ++i) {
 		unsigned int pagenr;
 
@@ -981,26 +982,39 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 		DBG_BUGON(!page);
 		DBG_BUGON(!page->mapping);
 
-		if (z_erofs_is_stagingpage(page))
-			continue;
+		if (!z_erofs_is_stagingpage(page)) {
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
-		if (page->mapping == MNGD_MAPPING(sbi)) {
-			DBG_BUGON(!PageUptodate(page));
-			continue;
-		}
+			if (page->mapping == MNGD_MAPPING(sbi)) {
+				if (unlikely(!PageUptodate(page)))
+					err = -EIO;
+				continue;
+			}
 #endif
 
-		/* only non-head page could be reused as a compressed page */
-		pagenr = z_erofs_onlinepage_index(page);
+			/*
+			 * only if non-head page can be selected
+			 * for inplace decompression
+			 */
+			pagenr = z_erofs_onlinepage_index(page);
 
-		DBG_BUGON(pagenr >= nr_pages);
-		DBG_BUGON(pages[pagenr]);
-		++sparsemem_pages;
-		pages[pagenr] = page;
+			DBG_BUGON(pagenr >= nr_pages);
+			DBG_BUGON(pages[pagenr]);
+			++sparsemem_pages;
+			pages[pagenr] = page;
+
+			overlapped = true;
+		}
 
-		overlapped = true;
+		/* PG_error needs checking for inplaced and staging pages */
+		if (unlikely(PageError(page))) {
+			DBG_BUGON(PageUptodate(page));
+			err = -EIO;
+		}
 	}
 
+	if (unlikely(err))
+		goto out;
+
 	llen = (nr_pages << PAGE_SHIFT) - work->pageofs;
 
 	if (z_erofs_vle_workgrp_fmt(grp) == Z_EROFS_VLE_WORKGRP_FMT_PLAIN) {
@@ -1194,6 +1208,7 @@ pickup_page_for_submission(struct z_erofs_vle_workgroup *grp,
 	if (page->mapping == mc) {
 		WRITE_ONCE(grp->compressed_pages[nr], page);
 
+		ClearPageError(page);
 		if (!PagePrivate(page)) {
 			/*
 			 * impossible to be !PagePrivate(page) for
-- 
2.12.2

