Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287C8C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6492184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbfEXRgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:36:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:3719 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391691AbfEXRgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:36:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 10:36:05 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga005.fm.intel.com with ESMTP; 24 May 2019 10:36:04 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2] mm/swap: Fix release_pages() when releasing devmap pages
Date:   Fri, 24 May 2019 10:36:56 -0700
Message-Id: <20190524173656.8339-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Device pages can be more than type MEMORY_DEVICE_PUBLIC.

Handle all device pages within release_pages()

This was found via code inspection while determining if release_pages()
and the new put_user_pages() could be interchangeable.

Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V1:
	Add comment clarifying that put_devmap_managed_page() can still
	fail.
	Add Reviewed-by tags.

 mm/swap.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 9d0432baddb0..f03b7b4bfb4f 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -740,15 +740,18 @@ void release_pages(struct page **pages, int nr)
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
+			 * zone-device-pages can still fail here and will
+			 * therefore need put_page_testzero()
+			 */
+			if (put_devmap_managed_page(page))
+				continue;
 		}
 
 		page = compound_head(page);
-- 
2.20.1

