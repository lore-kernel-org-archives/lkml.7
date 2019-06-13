Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC8DC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC682084D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbfFMQsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:48:55 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:50227 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727926AbfFMEoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 00:44:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TU25N7U_1560401051;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TU25N7U_1560401051)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Jun 2019 12:44:19 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     hughd@google.com, kirill.shutemov@linux.intel.com, mhocko@suse.com,
        vbabka@suse.cz, rientjes@google.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 1/2] mm: thp: make transhuge_vma_suitable available for anonymous THP
Date:   Thu, 13 Jun 2019 12:44:00 +0800
Message-Id: <1560401041-32207-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1560401041-32207-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1560401041-32207-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The transhuge_vma_suitable() was only available for shmem THP, but
anonymous THP has the same check except pgoff check.  And, it will be
used for THP eligible check in the later patch, so make it available for
all kind of THPs.  This also helps reduce code duplication slightly.

Since anonymous THP doesn't have to check pgoff, so make pgoff check
shmem vma only.

Cc: Hugh Dickins <hughd@google.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/huge_memory.c |  2 +-
 mm/internal.h    | 25 +++++++++++++++++++++++++
 mm/memory.c      | 13 -------------
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9f8bce9..4bc2552 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -691,7 +691,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	struct page *page;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 
-	if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
+	if (!transhuge_vma_suitable(vma, haddr))
 		return VM_FAULT_FALLBACK;
 	if (unlikely(anon_vma_prepare(vma)))
 		return VM_FAULT_OOM;
diff --git a/mm/internal.h b/mm/internal.h
index 9eeaf2b..7f096ba 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -555,4 +555,29 @@ static inline bool is_migrate_highatomic_page(struct page *page)
 
 void setup_zone_pageset(struct zone *zone);
 extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define HPAGE_CACHE_INDEX_MASK (HPAGE_PMD_NR - 1)
+static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
+		unsigned long haddr)
+{
+	/* Don't have to check pgoff for anonymous vma */
+	if (!vma_is_anonymous(vma)) {
+		if (((vma->vm_start >> PAGE_SHIFT) & HPAGE_CACHE_INDEX_MASK) !=
+			(vma->vm_pgoff & HPAGE_CACHE_INDEX_MASK))
+			return false;
+	}
+
+	if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
+		return false;
+	return true;
+}
+#else
+static inline bool transhuge_vma_suitable(struct vma_area_struct *vma,
+		unsigned long haddr)
+{
+	return false;
+}
+#endif
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memory.c b/mm/memory.c
index 96f1d47..2286424 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3205,19 +3205,6 @@ static vm_fault_t pte_alloc_one_map(struct vm_fault *vmf)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGE_PAGECACHE
-
-#define HPAGE_CACHE_INDEX_MASK (HPAGE_PMD_NR - 1)
-static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
-		unsigned long haddr)
-{
-	if (((vma->vm_start >> PAGE_SHIFT) & HPAGE_CACHE_INDEX_MASK) !=
-			(vma->vm_pgoff & HPAGE_CACHE_INDEX_MASK))
-		return false;
-	if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
-		return false;
-	return true;
-}
-
 static void deposit_prealloc_pte(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-- 
1.8.3.1

