Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C711CC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DBA23CE7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfFDQrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 12:47:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:37263 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727470AbfFDQrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:47:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 09:47:08 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jun 2019 09:47:08 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v3] mm/swap: Fix release_pages() when releasing devmap pages
Date:   Tue,  4 Jun 2019 09:48:13 -0700
Message-Id: <20190604164813.31514-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

release_pages() is an optimized version of a loop around put_page().
Unfortunately for devmap pages the logic is not entirely correct in
release_pages().  This is because device pages can be more than type
MEMORY_DEVICE_PUBLIC.  There are in fact 4 types, private, public, FS
DAX, and PCI P2PDMA.  Some of these have specific needs to "put" the
page while others do not.

This logic to handle any special needs is contained in
put_devmap_managed_page().  Therefore all devmap pages should be
processed by this function where we can contain the correct logic for a
page put.

Handle all device type pages within release_pages() by calling
put_devmap_managed_page() on all devmap pages.  If
put_devmap_managed_page() returns true the page has been put and we
continue with the next page.  A false return of
put_devmap_managed_page() means the page did not require special
processing and should fall to "normal" processing.

This was found via code inspection while determining if release_pages()
and the new put_user_pages() could be interchangeable.[1]

[1] https://lore.kernel.org/lkml/20190523172852.GA27175@iweiny-DESK2.sc.intel.com/

Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V2:
	Update changelog for more clarity as requested by Michal
	Update comment WRT "failing" of put_devmap_managed_page()

Changes from V1:
	Add comment clarifying that put_devmap_managed_page() can still
	fail.
	Add Reviewed-by tags.

 mm/swap.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 7ede3eddc12a..6d153ce4cb8c 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -740,15 +740,20 @@ void release_pages(struct page **pages, int nr)
 		if (is_huge_zero_page(page))
 			continue;
 
-		/* Device public page can not be huge page */
-		if (is_device_public_page(page)) {
+		if (is_zone_device_page(page)) {
 			if (locked_pgdat) {
 				spin_unlock_irqrestore(&locked_pgdat->lru_lock,
 						       flags);
 				locked_pgdat = NULL;
 			}
-			put_devmap_managed_page(page);
-			continue;
+			/*
+			 * Not all zone-device-pages require special
+			 * processing.  Those pages return 'false' from
+			 * put_devmap_managed_page() expecting a call to
+			 * put_page_testzero()
+			 */
+			if (put_devmap_managed_page(page))
+				continue;
 		}
 
 		page = compound_head(page);
-- 
2.20.1

