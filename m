Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6684BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E50520684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049624;
	bh=geCoCHVQx863wbIYzfpjXsM0WX8fBztZydOAlQk+AX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sfzaANMh5nPtBQYR20a4FQ6ArXsz+/KJ8m0xA+OVt4ngpkNjJJE1SzlmtD2iHRLGm
	 HdV3qKp7ZDUZ9svEabjP9Cjj/wrZs7sVCnp1+qWStq8dQ5NtHiP3Ha55vgHyHWtqT6
	 azkJbUk9uTJyFrEZOxY1DhmgZJpWiZMF+B07ojMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfCHMxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:53:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:57318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfCHMxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:53:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F39B20684;
        Fri,  8 Mar 2019 12:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049619;
        bh=geCoCHVQx863wbIYzfpjXsM0WX8fBztZydOAlQk+AX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IeyqHuAx02OkYPuG5fkfOTavO+nZCIFXEY81wx5gfBqq2UMnzzGFyKJTlObRGrO4+
         Ijnl8u5F5WZ4q2OF+gJp7BuxDemm9pPy7GjayNeStk95AgC+0DlIl+zSEzyCuq7yU1
         04Njy5towT+fLTtGUQjAp/g9plHyL6fwbf9uw6Vw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4.20 12/76] staging: erofs: compressed_pages should not be accessed again after freed
Date:   Fri,  8 Mar 2019 13:49:24 +0100
Message-Id: <20190308124915.216782955@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <gaoxiang25@huawei.com>

commit af692e117cb8cd9d3d844d413095775abc1217f9 upstream.

This patch resolves the following page use-after-free issue,
z_erofs_vle_unzip:
    ...
    for (i = 0; i < nr_pages; ++i) {
        ...
        z_erofs_onlinepage_endio(page);  (1)
    }

    for (i = 0; i < clusterpages; ++i) {
        page = compressed_pages[i];

        if (page->mapping == mngda)      (2)
            continue;
        /* recycle all individual staging pages */
        (void)z_erofs_gather_if_stagingpage(page_pool, page); (3)
        WRITE_ONCE(compressed_pages[i], NULL);
    }
    ...

After (1) is executed, page is freed and could be then reused, if
compressed_pages is scanned after that, it could fall info (2) or
(3) by mistake and that could finally be in a mess.

This patch aims to solve the above issue only with little changes
as much as possible in order to make the fix backport easier.

Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/staging/erofs/unzip_vle.c     |   38 +++++++++++++++++-----------------
 drivers/staging/erofs/unzip_vle.h     |    3 --
 drivers/staging/erofs/unzip_vle_lz4.c |   19 +++++++----------
 3 files changed, 29 insertions(+), 31 deletions(-)

--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -929,11 +929,10 @@ repeat:
 	if (llen > grp->llen)
 		llen = grp->llen;
 
-	err = z_erofs_vle_unzip_fast_percpu(compressed_pages,
-		clusterpages, pages, llen, work->pageofs,
-		z_erofs_onlinepage_endio);
+	err = z_erofs_vle_unzip_fast_percpu(compressed_pages, clusterpages,
+					    pages, llen, work->pageofs);
 	if (err != -ENOTSUPP)
-		goto out_percpu;
+		goto out;
 
 	if (sparsemem_pages >= nr_pages)
 		goto skip_allocpage;
@@ -954,8 +953,25 @@ skip_allocpage:
 	erofs_vunmap(vout, nr_pages);
 
 out:
+	/* must handle all compressed pages before endding pages */
+	for (i = 0; i < clusterpages; ++i) {
+		page = compressed_pages[i];
+
+#ifdef EROFS_FS_HAS_MANAGED_CACHE
+		if (page->mapping == mngda)
+			continue;
+#endif
+		/* recycle all individual staging pages */
+		(void)z_erofs_gather_if_stagingpage(page_pool, page);
+
+		WRITE_ONCE(compressed_pages[i], NULL);
+	}
+
 	for (i = 0; i < nr_pages; ++i) {
 		page = pages[i];
+		if (!page)
+			continue;
+
 		DBG_BUGON(page->mapping == NULL);
 
 		/* recycle all individual staging pages */
@@ -968,20 +984,6 @@ out:
 		z_erofs_onlinepage_endio(page);
 	}
 
-out_percpu:
-	for (i = 0; i < clusterpages; ++i) {
-		page = compressed_pages[i];
-
-#ifdef EROFS_FS_HAS_MANAGED_CACHE
-		if (page->mapping == mngda)
-			continue;
-#endif
-		/* recycle all individual staging pages */
-		(void)z_erofs_gather_if_stagingpage(page_pool, page);
-
-		WRITE_ONCE(compressed_pages[i], NULL);
-	}
-
 	if (pages == z_pagemap_global)
 		mutex_unlock(&z_pagemap_global_lock);
 	else if (unlikely(pages != pages_onstack))
--- a/drivers/staging/erofs/unzip_vle.h
+++ b/drivers/staging/erofs/unzip_vle.h
@@ -218,8 +218,7 @@ extern int z_erofs_vle_plain_copy(struct
 
 extern int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
 	unsigned clusterpages, struct page **pages,
-	unsigned outlen, unsigned short pageofs,
-	void (*endio)(struct page *));
+	unsigned int outlen, unsigned short pageofs);
 
 extern int z_erofs_vle_unzip_vmap(struct page **compressed_pages,
 	unsigned clusterpages, void *vaddr, unsigned llen,
--- a/drivers/staging/erofs/unzip_vle_lz4.c
+++ b/drivers/staging/erofs/unzip_vle_lz4.c
@@ -105,8 +105,7 @@ int z_erofs_vle_unzip_fast_percpu(struct
 				  unsigned int clusterpages,
 				  struct page **pages,
 				  unsigned int outlen,
-				  unsigned short pageofs,
-				  void (*endio)(struct page *))
+				  unsigned short pageofs)
 {
 	void *vin, *vout;
 	unsigned int nr_pages, i, j;
@@ -128,19 +127,16 @@ int z_erofs_vle_unzip_fast_percpu(struct
 	ret = z_erofs_unzip_lz4(vin, vout + pageofs,
 				clusterpages * PAGE_SIZE, outlen);
 
-	if (ret >= 0) {
-		outlen = ret;
-		ret = 0;
-	}
+	if (ret < 0)
+		goto out;
+	ret = 0;
 
 	for (i = 0; i < nr_pages; ++i) {
 		j = min((unsigned int)PAGE_SIZE - pageofs, outlen);
 
 		if (pages[i]) {
-			if (ret < 0) {
-				SetPageError(pages[i]);
-			} else if (clusterpages == 1 &&
-				   pages[i] == compressed_pages[0]) {
+			if (clusterpages == 1 &&
+			    pages[i] == compressed_pages[0]) {
 				memcpy(vin + pageofs, vout + pageofs, j);
 			} else {
 				void *dst = kmap_atomic(pages[i]);
@@ -148,12 +144,13 @@ int z_erofs_vle_unzip_fast_percpu(struct
 				memcpy(dst + pageofs, vout + pageofs, j);
 				kunmap_atomic(dst);
 			}
-			endio(pages[i]);
 		}
 		vout += PAGE_SIZE;
 		outlen -= j;
 		pageofs = 0;
 	}
+
+out:
 	preempt_enable();
 
 	if (clusterpages == 1)


