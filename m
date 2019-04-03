Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92611C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1C5214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfDCTdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:33:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbfDCTdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:33:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5D6CC049598;
        Wed,  3 Apr 2019 19:33:44 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-125-190.rdu2.redhat.com [10.10.125.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8FD0A6012C;
        Wed,  3 Apr 2019 19:33:43 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v3 12/12] mm/hmm: convert various hmm_pfn_* to device_entry which is a better name
Date:   Wed,  3 Apr 2019 15:33:18 -0400
Message-Id: <20190403193318.16478-13-jglisse@redhat.com>
In-Reply-To: <20190403193318.16478-1-jglisse@redhat.com>
References: <20190403193318.16478-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 03 Apr 2019 19:33:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Convert hmm_pfn_* to device_entry_* as here we are dealing with device
driver specific entry format and hmm provide helpers to allow differents
components (including HMM) to create/parse device entry.

We keep wrapper with the old name so that we can convert driver to use the
new API in stages in each device driver tree. This will get remove once all
driver are converted.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/hmm.h | 93 +++++++++++++++++++++++++++++++--------------
 mm/hmm.c            | 19 +++++----
 2 files changed, 75 insertions(+), 37 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index f81fe2c0f343..51ec27a84668 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -239,36 +239,36 @@ static inline bool hmm_range_valid(struct hmm_range *range)
 }
 
 /*
- * hmm_pfn_to_page() - return struct page pointed to by a valid HMM pfn
- * @range: range use to decode HMM pfn value
- * @pfn: HMM pfn value to get corresponding struct page from
- * Returns: struct page pointer if pfn is a valid HMM pfn, NULL otherwise
+ * hmm_device_entry_to_page() - return struct page pointed to by a device entry
+ * @range: range use to decode device entry value
+ * @entry: device entry value to get corresponding struct page from
+ * Returns: struct page pointer if entry is a valid, NULL otherwise
  *
- * If the HMM pfn is valid (ie valid flag set) then return the struct page
- * matching the pfn value stored in the HMM pfn. Otherwise return NULL.
+ * If the device entry is valid (ie valid flag set) then return the struct page
+ * matching the entry value. Otherwise return NULL.
  */
-static inline struct page *hmm_pfn_to_page(const struct hmm_range *range,
-					   uint64_t pfn)
+static inline struct page *hmm_device_entry_to_page(const struct hmm_range *range,
+						    uint64_t entry)
 {
-	if (pfn == range->values[HMM_PFN_NONE])
+	if (entry == range->values[HMM_PFN_NONE])
 		return NULL;
-	if (pfn == range->values[HMM_PFN_ERROR])
+	if (entry == range->values[HMM_PFN_ERROR])
 		return NULL;
-	if (pfn == range->values[HMM_PFN_SPECIAL])
+	if (entry == range->values[HMM_PFN_SPECIAL])
 		return NULL;
-	if (!(pfn & range->flags[HMM_PFN_VALID]))
+	if (!(entry & range->flags[HMM_PFN_VALID]))
 		return NULL;
-	return pfn_to_page(pfn >> range->pfn_shift);
+	return pfn_to_page(entry >> range->pfn_shift);
 }
 
 /*
- * hmm_pfn_to_pfn() - return pfn value store in a HMM pfn
- * @range: range use to decode HMM pfn value
- * @pfn: HMM pfn value to extract pfn from
- * Returns: pfn value if HMM pfn is valid, -1UL otherwise
+ * hmm_device_entry_to_pfn() - return pfn value store in a device entry
+ * @range: range use to decode device entry value
+ * @entry: device entry to extract pfn from
+ * Returns: pfn value if device entry is valid, -1UL otherwise
  */
-static inline unsigned long hmm_pfn_to_pfn(const struct hmm_range *range,
-					   uint64_t pfn)
+static inline unsigned long
+hmm_device_entry_to_pfn(const struct hmm_range *range, uint64_t pfn)
 {
 	if (pfn == range->values[HMM_PFN_NONE])
 		return -1UL;
@@ -282,31 +282,66 @@ static inline unsigned long hmm_pfn_to_pfn(const struct hmm_range *range,
 }
 
 /*
- * hmm_pfn_from_page() - create a valid HMM pfn value from struct page
+ * hmm_device_entry_from_page() - create a valid device entry for a page
  * @range: range use to encode HMM pfn value
- * @page: struct page pointer for which to create the HMM pfn
- * Returns: valid HMM pfn for the page
+ * @page: page for which to create the device entry
+ * Returns: valid device entry for the page
  */
-static inline uint64_t hmm_pfn_from_page(const struct hmm_range *range,
-					 struct page *page)
+static inline uint64_t hmm_device_entry_from_page(const struct hmm_range *range,
+						  struct page *page)
 {
 	return (page_to_pfn(page) << range->pfn_shift) |
 		range->flags[HMM_PFN_VALID];
 }
 
 /*
- * hmm_pfn_from_pfn() - create a valid HMM pfn value from pfn
+ * hmm_device_entry_from_pfn() - create a valid device entry value from pfn
  * @range: range use to encode HMM pfn value
- * @pfn: pfn value for which to create the HMM pfn
- * Returns: valid HMM pfn for the pfn
+ * @pfn: pfn value for which to create the device entry
+ * Returns: valid device entry for the pfn
  */
-static inline uint64_t hmm_pfn_from_pfn(const struct hmm_range *range,
-					unsigned long pfn)
+static inline uint64_t hmm_device_entry_from_pfn(const struct hmm_range *range,
+						 unsigned long pfn)
 {
 	return (pfn << range->pfn_shift) |
 		range->flags[HMM_PFN_VALID];
 }
 
+/*
+ * Old API:
+ * hmm_pfn_to_page()
+ * hmm_pfn_to_pfn()
+ * hmm_pfn_from_page()
+ * hmm_pfn_from_pfn()
+ *
+ * This are the OLD API please use new API, it is here to avoid cross-tree
+ * merge painfullness ie we convert things to new API in stages.
+ */
+static inline struct page *hmm_pfn_to_page(const struct hmm_range *range,
+					   uint64_t pfn)
+{
+	return hmm_device_entry_to_page(range, pfn);
+}
+
+static inline unsigned long hmm_pfn_to_pfn(const struct hmm_range *range,
+					   uint64_t pfn)
+{
+	return hmm_device_entry_to_pfn(range, pfn);
+}
+
+static inline uint64_t hmm_pfn_from_page(const struct hmm_range *range,
+					 struct page *page)
+{
+	return hmm_device_entry_from_page(range, page);
+}
+
+static inline uint64_t hmm_pfn_from_pfn(const struct hmm_range *range,
+					unsigned long pfn)
+{
+	return hmm_device_entry_from_pfn(range, pfn);
+}
+
+
 
 #if IS_ENABLED(CONFIG_HMM_MIRROR)
 /*
diff --git a/mm/hmm.c b/mm/hmm.c
index 82fded7273d8..75d2ea906efb 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -542,7 +542,7 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
 			if (unlikely(!hmm_vma_walk->pgmap))
 				return -EBUSY;
 		}
-		pfns[i] = hmm_pfn_from_pfn(range, pfn) | cpu_flags;
+		pfns[i] = hmm_device_entry_from_pfn(range, pfn) | cpu_flags;
 	}
 	if (hmm_vma_walk->pgmap) {
 		put_dev_pagemap(hmm_vma_walk->pgmap);
@@ -606,7 +606,8 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 					   &fault, &write_fault);
 			if (fault || write_fault)
 				goto fault;
-			*pfn = hmm_pfn_from_pfn(range, swp_offset(entry));
+			*pfn = hmm_device_entry_from_pfn(range,
+					    swp_offset(entry));
 			*pfn |= cpu_flags;
 			return 0;
 		}
@@ -644,7 +645,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		return -EFAULT;
 	}
 
-	*pfn = hmm_pfn_from_pfn(range, pte_pfn(pte)) | cpu_flags;
+	*pfn = hmm_device_entry_from_pfn(range, pte_pfn(pte)) | cpu_flags;
 	return 0;
 
 fault:
@@ -797,7 +798,8 @@ static int hmm_vma_walk_pud(pud_t *pudp,
 					      hmm_vma_walk->pgmap);
 			if (unlikely(!hmm_vma_walk->pgmap))
 				return -EBUSY;
-			pfns[i] = hmm_pfn_from_pfn(range, pfn) | cpu_flags;
+			pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
+				  cpu_flags;
 		}
 		if (hmm_vma_walk->pgmap) {
 			put_dev_pagemap(hmm_vma_walk->pgmap);
@@ -870,7 +872,8 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 
 	pfn = pte_pfn(entry) + (start & mask);
 	for (; addr < end; addr += size, i++, pfn += pfn_inc)
-		range->pfns[i] = hmm_pfn_from_pfn(range, pfn) | cpu_flags;
+		range->pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
+				 cpu_flags;
 	hmm_vma_walk->last = end;
 
 unlock:
@@ -1213,7 +1216,7 @@ long hmm_range_dma_map(struct hmm_range *range,
 		 */
 		daddrs[i] = 0;
 
-		page = hmm_pfn_to_page(range, range->pfns[i]);
+		page = hmm_device_entry_to_page(range, range->pfns[i]);
 		if (page == NULL)
 			continue;
 
@@ -1243,7 +1246,7 @@ long hmm_range_dma_map(struct hmm_range *range,
 		enum dma_data_direction dir = DMA_FROM_DEVICE;
 		struct page *page;
 
-		page = hmm_pfn_to_page(range, range->pfns[i]);
+		page = hmm_device_entry_to_page(range, range->pfns[i]);
 		if (page == NULL)
 			continue;
 
@@ -1298,7 +1301,7 @@ long hmm_range_dma_unmap(struct hmm_range *range,
 		enum dma_data_direction dir = DMA_FROM_DEVICE;
 		struct page *page;
 
-		page = hmm_pfn_to_page(range, range->pfns[i]);
+		page = hmm_device_entry_to_page(range, range->pfns[i]);
 		if (page == NULL)
 			continue;
 
-- 
2.17.2

