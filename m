Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524B7C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BA121849
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfGQV7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 17:59:41 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:58363 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727543AbfGQV7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 17:59:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TX9KWw9_1563400771;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TX9KWw9_1563400771)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Jul 2019 05:59:38 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     hughd@google.com, kirill.shutemov@linux.intel.com, mhocko@suse.com,
        vbabka@suse.cz, rientjes@google.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v4 PATCH 1/2] mm: thp: make transhuge_vma_suitable available for anonymous THP
Date:   Thu, 18 Jul 2019 05:59:17 +0800
Message-Id: <1563400758-124759-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563400758-124759-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1563400758-124759-1-git-send-email-yang.shi@linux.alibaba.com>
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

And regroup some functions in include/linux/mm.h to solve compile issue since
transhuge_vma_suitable() needs call vma_is_anonymous() which was defined
after huge_mm.h is included.

Cc: Hugh Dickins <hughd@google.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/linux/huge_mm.h | 23 +++++++++++++++++++++++
 include/linux/mm.h      | 34 +++++++++++++++++-----------------
 mm/huge_memory.c        |  2 +-
 mm/memory.c             | 13 -------------
 4 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7cd5c15..45ede62 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -121,6 +121,23 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 
 bool transparent_hugepage_enabled(struct vm_area_struct *vma);
 
+#define HPAGE_CACHE_INDEX_MASK (HPAGE_PMD_NR - 1)
+
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
+
 #define transparent_hugepage_use_zero_page()				\
 	(transparent_hugepage_flags &					\
 	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
@@ -271,6 +288,12 @@ static inline bool transparent_hugepage_enabled(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
+		unsigned long haddr)
+{
+	return false;
+}
+
 static inline void prep_transhuge_page(struct page *page) {}
 
 #define transparent_hugepage_flags 0UL
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0389c34..beae0ae 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -541,6 +541,23 @@ static inline void vma_set_anonymous(struct vm_area_struct *vma)
 	vma->vm_ops = NULL;
 }
 
+static inline bool vma_is_anonymous(struct vm_area_struct *vma)
+{
+	return !vma->vm_ops;
+}
+
+#ifdef CONFIG_SHMEM
+/*
+ * The vma_is_shmem is not inline because it is used only by slow
+ * paths in userfault.
+ */
+bool vma_is_shmem(struct vm_area_struct *vma);
+#else
+static inline bool vma_is_shmem(struct vm_area_struct *vma) { return false; }
+#endif
+
+int vma_is_stack_for_current(struct vm_area_struct *vma);
+
 /* flush_tlb_range() takes a vma, not a mm, and can care about flags */
 #define TLB_FLUSH_VMA(mm,flags) { .vm_mm = (mm), .vm_flags = (flags) }
 
@@ -1629,23 +1646,6 @@ static inline void cancel_dirty_page(struct page *page)
 
 int get_cmdline(struct task_struct *task, char *buffer, int buflen);
 
-static inline bool vma_is_anonymous(struct vm_area_struct *vma)
-{
-	return !vma->vm_ops;
-}
-
-#ifdef CONFIG_SHMEM
-/*
- * The vma_is_shmem is not inline because it is used only by slow
- * paths in userfault.
- */
-bool vma_is_shmem(struct vm_area_struct *vma);
-#else
-static inline bool vma_is_shmem(struct vm_area_struct *vma) { return false; }
-#endif
-
-int vma_is_stack_for_current(struct vm_area_struct *vma);
-
 extern unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 885642c..782dd14 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -689,7 +689,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	struct page *page;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 
-	if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
+	if (!transhuge_vma_suitable(vma, haddr))
 		return VM_FAULT_FALLBACK;
 	if (unlikely(anon_vma_prepare(vma)))
 		return VM_FAULT_OOM;
diff --git a/mm/memory.c b/mm/memory.c
index 89325f9..e2bb51b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3162,19 +3162,6 @@ static vm_fault_t pte_alloc_one_map(struct vm_fault *vmf)
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

