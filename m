Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B57C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC882084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbfDAGyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 02:54:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48606 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726865AbfDAGyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 02:54:03 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B164A5F56F5ED09DAED5;
        Mon,  1 Apr 2019 14:54:00 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 1 Apr 2019
 14:53:50 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH for-4.19 1/2] staging: erofs: fix error handling when failed to read compresssed data
Date:   Mon, 1 Apr 2019 14:53:08 +0800
Message-ID: <20190401065309.68109-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b6391ac73400eff38377a4a7364bd3df5efb5178 upstream.

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
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
This series resolves the following conflicts:
FAILED: patch "[PATCH] staging: erofs: fix error handling when failed to read" failed to apply to 4.19-stable tree
FAILED: patch "[PATCH] staging: erofs: keep corrupted fs from crashing kernel in" failed to apply to 4.19-stable tree

Thanks,
Gao Xiang

 drivers/staging/erofs/unzip_vle.c | 42 +++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index f44662dd795c..bb9a69158ba4 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -885,6 +885,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	overlapped = false;
 	compressed_pages = grp->compressed_pages;
 
+	err = 0;
 	for (i = 0; i < clusterpages; ++i) {
 		unsigned pagenr;
 
@@ -894,26 +895,39 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 		DBG_BUGON(page == NULL);
 		DBG_BUGON(page->mapping == NULL);
 
-		if (z_erofs_is_stagingpage(page))
-			continue;
+		if (!z_erofs_is_stagingpage(page)) {
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
-		if (page->mapping == mngda) {
-			DBG_BUGON(!PageUptodate(page));
-			continue;
-		}
+			if (page->mapping == mngda) {
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
 
-		overlapped = true;
+			overlapped = true;
+		}
+
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
@@ -1078,6 +1092,8 @@ static inline bool recover_managed_page(struct z_erofs_vle_workgroup *grp,
 		return true;
 
 	lock_page(page);
+	ClearPageError(page);
+
 	if (unlikely(!PagePrivate(page))) {
 		set_page_private(page, (unsigned long)grp);
 		SetPagePrivate(page);
-- 
2.17.1

