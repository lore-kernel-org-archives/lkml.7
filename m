Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F97C4360C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 00:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F202E222CA
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 00:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbfJEAdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 20:33:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:34432 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730400AbfJEAdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 20:33:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 17:33:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,258,1566889200"; 
   d="scan'208";a="191743043"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga008.fm.intel.com with ESMTP; 04 Oct 2019 17:33:22 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        hughd@google.com, aarcange@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] hugetlb: remove unused hstate in hugetlb_fault_mutex_hash()
Date:   Sat,  5 Oct 2019 08:33:02 +0800
Message-Id: <20191005003302.785-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927151033.aad57472652a0b3a6948df6e@linux-foundation.org>
References: <20190927151033.aad57472652a0b3a6948df6e@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first parameter hstate in function hugetlb_fault_mutex_hash() is not
used anymore.

This patch removes it.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/hugetlbfs/inode.c    |  4 ++--
 include/linux/hugetlb.h |  4 ++--
 mm/hugetlb.c            | 12 ++++++------
 mm/userfaultfd.c        |  5 +----
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a478df035651..715db1e34174 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -440,7 +440,7 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 			u32 hash;
 
 			index = page->index;
-			hash = hugetlb_fault_mutex_hash(h, mapping, index, 0);
+			hash = hugetlb_fault_mutex_hash(mapping, index, 0);
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 			/*
@@ -644,7 +644,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 		addr = index * hpage_size;
 
 		/* mutex taken here, fault path and hole punch */
-		hash = hugetlb_fault_mutex_hash(h, mapping, index, addr);
+		hash = hugetlb_fault_mutex_hash(mapping, index, addr);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 		/* See if already present in mapping to avoid alloc/free */
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 53fc34f930d0..40e9e3fad1cf 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -105,8 +105,8 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason);
 void free_huge_page(struct page *page);
 void hugetlb_fix_reserve_counts(struct inode *inode);
 extern struct mutex *hugetlb_fault_mutex_table;
-u32 hugetlb_fault_mutex_hash(struct hstate *h, struct address_space *mapping,
-				pgoff_t idx, unsigned long address);
+u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx,
+				unsigned long address);
 
 pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ef37c85423a5..e0f033baac9d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3916,7 +3916,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			 * handling userfault.  Reacquire after handling
 			 * fault to make calling code simpler.
 			 */
-			hash = hugetlb_fault_mutex_hash(h, mapping, idx, haddr);
+			hash = hugetlb_fault_mutex_hash(mapping, idx, haddr);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			ret = handle_userfault(&vmf, VM_UFFD_MISSING);
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
@@ -4043,8 +4043,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 }
 
 #ifdef CONFIG_SMP
-u32 hugetlb_fault_mutex_hash(struct hstate *h, struct address_space *mapping,
-			    pgoff_t idx, unsigned long address)
+u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx,
+				unsigned long address)
 {
 	unsigned long key[2];
 	u32 hash;
@@ -4061,8 +4061,8 @@ u32 hugetlb_fault_mutex_hash(struct hstate *h, struct address_space *mapping,
  * For uniprocesor systems we always use a single mutex, so just
  * return 0 and avoid the hashing overhead.
  */
-u32 hugetlb_fault_mutex_hash(struct hstate *h, struct address_space *mapping,
-			    pgoff_t idx, unsigned long address)
+u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx,
+				unsigned long address)
 {
 	return 0;
 }
@@ -4106,7 +4106,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * get spurious allocation failures if two CPUs race to instantiate
 	 * the same page in the page cache.
 	 */
-	hash = hugetlb_fault_mutex_hash(h, mapping, idx, haddr);
+	hash = hugetlb_fault_mutex_hash(mapping, idx, haddr);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 	entry = huge_ptep_get(ptep);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 0a40746a5b1e..5c0a80626cf0 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -214,7 +214,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 	unsigned long src_addr, dst_addr;
 	long copied;
 	struct page *page;
-	struct hstate *h;
 	unsigned long vma_hpagesize;
 	pgoff_t idx;
 	u32 hash;
@@ -271,8 +270,6 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 			goto out_unlock;
 	}
 
-	h = hstate_vma(dst_vma);
-
 	while (src_addr < src_start + len) {
 		pte_t dst_pteval;
 
@@ -283,7 +280,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		 */
 		idx = linear_page_index(dst_vma, dst_addr);
 		mapping = dst_vma->vm_file->f_mapping;
-		hash = hugetlb_fault_mutex_hash(h, mapping, idx, dst_addr);
+		hash = hugetlb_fault_mutex_hash(mapping, idx, dst_addr);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 		err = -ENOMEM;
-- 
2.17.1

