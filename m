Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E14C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892F920663
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554142084;
	bh=TBC3SizQ6f3AHiZwTr/ExnAdJk+ZvcvNTaprb7p7ts8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zUPXtFhg6hhaa8juZ1SAH7vBO+kPZfpdfzZfQHpilLO15TaJrz/7aqRNnhUMPq7sI
	 AsOBWWL8o4TN4nPQl0mfjAwYenyyKjCzPDo9ox3aEMS/3YpXLkcgGKPKhjUKdbmCPk
	 wAbxsC0d1/21hFOdEbJN/j5m+vkpEctySMxjpa68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbfDARKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728931AbfDARKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:10:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D33982192C;
        Mon,  1 Apr 2019 17:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138646;
        bh=TBC3SizQ6f3AHiZwTr/ExnAdJk+ZvcvNTaprb7p7ts8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2t+Nm7St5F7D/szHFGJrSy4TkOHsJmpIVHKMLUS4QryTj51qDRt/5xB3ggFJnS0t+
         HaFAgUAGsRS3dbJFzGHsmNA2lrLnc69IidxKCOZCzoWP0izcJSiSXJQJZS7asf9QTK
         jkUTEaa6w/eB+UCET7GPtYt46xh+2QmS0eOJw2ro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 5.0 088/146] staging: erofs: fix error handling when failed to read compresssed data
Date:   Mon,  1 Apr 2019 19:01:40 +0200
Message-Id: <20190401170056.262028451@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <gaoxiang25@huawei.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/erofs/unzip_vle.c |   41 +++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -977,6 +977,7 @@ repeat:
 	overlapped = false;
 	compressed_pages = grp->compressed_pages;
 
+	err = 0;
 	for (i = 0; i < clusterpages; ++i) {
 		unsigned int pagenr;
 
@@ -986,26 +987,39 @@ repeat:
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
+
+			DBG_BUGON(pagenr >= nr_pages);
+			DBG_BUGON(pages[pagenr]);
+			++sparsemem_pages;
+			pages[pagenr] = page;
 
-		DBG_BUGON(pagenr >= nr_pages);
-		DBG_BUGON(pages[pagenr]);
-		++sparsemem_pages;
-		pages[pagenr] = page;
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
@@ -1203,6 +1217,7 @@ repeat:
 	if (page->mapping == mc) {
 		WRITE_ONCE(grp->compressed_pages[nr], page);
 
+		ClearPageError(page);
 		if (!PagePrivate(page)) {
 			/*
 			 * impossible to be !PagePrivate(page) for


