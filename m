Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E8CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DF52070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 05:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TffgZQMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfG2Fns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 01:43:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21538 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725988AbfG2Fnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 01:43:47 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6T5dUuf021469
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 22:43:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=+JlKBEUqXyb8ZWj/I+6NY0xWklku0HD2vMlP66Q9FBA=;
 b=TffgZQMZzuZIouxkrQO6q6eM8YwK1ii2AE5eej09xNMEB2cakINhqee/ygJubM6gUNm2
 66pVugmyYUpcIabtBWoic8yMo2KZU9P+bZNpgUpvkMtdOsmeS5kBOIjPwQ1WSX5QUb5B
 VPDJW41+dqNdSj3QG3g+iurbG4PuGf+DctQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u0jn3n8p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 22:43:46 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 28 Jul 2019 22:43:44 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 23B5D62E2BC0; Sun, 28 Jul 2019 22:43:44 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>
CC:     <matthew.wilcox@oracle.com>, <kirill.shutemov@linux.intel.com>,
        <oleg@redhat.com>, <kernel-team@fb.com>,
        <william.kucharski@oracle.com>, <srikar@linux.vnet.ibm.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 1/2] khugepaged: enable collapse pmd for pte-mapped THP
Date:   Sun, 28 Jul 2019 22:43:34 -0700
Message-ID: <20190729054335.3241150-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190729054335.3241150-1-songliubraving@fb.com>
References: <20190729054335.3241150-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-29_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=521 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907290067
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

khugepaged needs exclusive mmap_sem to access page table. When it fails
to lock mmap_sem, the page will fault in as pte-mapped THP. As the page
is already a THP, khugepaged will not handle this pmd again.

This patch enables the khugepaged to retry collapse the page table.

struct mm_slot (in khugepaged.c) is extended with an array, containing
addresses of pte-mapped THPs. We use array here for simplicity. We can
easily replace it with more advanced data structures when needed. This
array is protected by khugepaged_mm_lock.

In khugepaged_scan_mm_slot(), if the mm contains pte-mapped THP, we try
to collapse the page table.

Since collapse may happen at an later time, some pages may already fault
in. collapse_pte_mapped_thp() is added to properly handle these pages.
collapse_pte_mapped_thp() also double checks whether all ptes in this pmd
are mapping to the same THP. This is necessary because some subpage of
the THP may be replaced, for example by uprobe. In such cases, it is not
possible to collapse the pmd.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/khugepaged.h |  15 ++++
 mm/khugepaged.c            | 136 +++++++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 082d1d2a5216..2d700830fe0e 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -15,6 +15,16 @@ extern int __khugepaged_enter(struct mm_struct *mm);
 extern void __khugepaged_exit(struct mm_struct *mm);
 extern int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
 				      unsigned long vm_flags);
+#ifdef CONFIG_SHMEM
+extern int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
+					 unsigned long addr);
+#else
+static inline int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
+						unsigned long addr)
+{
+	return 0;
+}
+#endif
 
 #define khugepaged_enabled()					       \
 	(transparent_hugepage_flags &				       \
@@ -73,6 +83,11 @@ static inline int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
 {
 	return 0;
 }
+static inline int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
+						unsigned long addr)
+{
+	return 0;
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #endif /* _LINUX_KHUGEPAGED_H */
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index eaaa21b23215..247c25aeb096 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -76,6 +76,7 @@ static __read_mostly DEFINE_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
 
 static struct kmem_cache *mm_slot_cache __read_mostly;
 
+#define MAX_PTE_MAPPED_THP 8
 /**
  * struct mm_slot - hash lookup from mm to mm_slot
  * @hash: hash collision list
@@ -86,6 +87,10 @@ struct mm_slot {
 	struct hlist_node hash;
 	struct list_head mm_node;
 	struct mm_struct *mm;
+
+	/* pte-mapped THP in this mm */
+	int nr_pte_mapped_thp;
+	unsigned long pte_mapped_thp[MAX_PTE_MAPPED_THP];
 };
 
 /**
@@ -1281,11 +1286,141 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 			up_write(&vma->vm_mm->mmap_sem);
 			mm_dec_nr_ptes(vma->vm_mm);
 			pte_free(vma->vm_mm, pmd_pgtable(_pmd));
+		} else if (down_read_trylock(&vma->vm_mm->mmap_sem)) {
+			/* need down_read for khugepaged_test_exit() */
+			khugepaged_add_pte_mapped_thp(vma->vm_mm, addr);
+			up_read(&vma->vm_mm->mmap_sem);
 		}
 	}
 	i_mmap_unlock_write(mapping);
 }
 
+/*
+ * Notify khugepaged that given addr of the mm is pte-mapped THP. Then
+ * khugepaged should try to collapse the page table.
+ */
+int khugepaged_add_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
+{
+	struct mm_slot *mm_slot;
+	int ret = 0;
+
+	/* hold mmap_sem for khugepaged_test_exit() */
+	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_sem), mm);
+
+	if (unlikely(khugepaged_test_exit(mm)))
+		return 0;
+
+	if (!test_bit(MMF_VM_HUGEPAGE, &mm->flags) &&
+	    !test_bit(MMF_DISABLE_THP, &mm->flags)) {
+		ret = __khugepaged_enter(mm);
+		if (ret)
+			return ret;
+	}
+
+	spin_lock(&khugepaged_mm_lock);
+	mm_slot = get_mm_slot(mm);
+	if (likely(mm_slot && mm_slot->nr_pte_mapped_thp < MAX_PTE_MAPPED_THP))
+		mm_slot->pte_mapped_thp[mm_slot->nr_pte_mapped_thp++] = addr;
+
+	spin_unlock(&khugepaged_mm_lock);
+	return 0;
+}
+
+/**
+ * Try to collapse a pte-mapped THP for mm at address haddr.
+ *
+ * This function checks whether all the PTEs in the PMD are pointing to the
+ * right THP. If so, retract the page table so the THP can refault in with
+ * as pmd-mapped.
+ */
+static void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long haddr)
+{
+	struct vm_area_struct *vma = find_vma(mm, haddr);
+	pmd_t *pmd = mm_find_pmd(mm, haddr);
+	struct page *hpage = NULL;
+	unsigned long addr;
+	spinlock_t *ptl;
+	int count = 0;
+	pmd_t _pmd;
+	int i;
+
+	if (!vma || !pmd || pmd_trans_huge(*pmd))
+		return;
+
+	/* step 1: check all mapped PTEs are to the right huge page */
+	for (i = 0, addr = haddr; i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE) {
+		pte_t *pte = pte_offset_map(pmd, addr);
+		struct page *page;
+
+		if (pte_none(*pte))
+			continue;
+
+		page = vm_normal_page(vma, addr, *pte);
+
+		if (!PageCompound(page))
+			return;
+
+		if (!hpage) {
+			hpage = compound_head(page);
+			if (hpage->mapping != vma->vm_file->f_mapping)
+				return;
+		}
+
+		if (hpage + i != page)
+			return;
+		count++;
+	}
+
+	/* step 2: adjust rmap */
+	for (i = 0, addr = haddr; i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE) {
+		pte_t *pte = pte_offset_map(pmd, addr);
+		struct page *page;
+
+		if (pte_none(*pte))
+			continue;
+		page = vm_normal_page(vma, addr, *pte);
+		page_remove_rmap(page, false);
+	}
+
+	/* step 3: set proper refcount and mm_counters. */
+	if (hpage) {
+		page_ref_sub(hpage, count);
+		add_mm_counter(vma->vm_mm, mm_counter_file(hpage), -count);
+	}
+
+	/* step 4: collapse pmd */
+	ptl = pmd_lock(vma->vm_mm, pmd);
+	_pmd = pmdp_collapse_flush(vma, addr, pmd);
+	spin_unlock(ptl);
+	mm_dec_nr_ptes(mm);
+	pte_free(mm, pmd_pgtable(_pmd));
+}
+
+static int khugepaged_collapse_pte_mapped_thps(struct mm_slot *mm_slot)
+{
+	struct mm_struct *mm = mm_slot->mm;
+	int i;
+
+	lockdep_assert_held(&khugepaged_mm_lock);
+
+	if (likely(mm_slot->nr_pte_mapped_thp == 0))
+		return 0;
+
+	if (!down_write_trylock(&mm->mmap_sem))
+		return -EBUSY;
+
+	if (unlikely(khugepaged_test_exit(mm)))
+		goto out;
+
+	for (i = 0; i < mm_slot->nr_pte_mapped_thp; i++)
+		collapse_pte_mapped_thp(mm, mm_slot->pte_mapped_thp[i]);
+
+out:
+	mm_slot->nr_pte_mapped_thp = 0;
+	up_write(&mm->mmap_sem);
+	return 0;
+}
+
 /**
  * collapse_shmem - collapse small tmpfs/shmem pages into huge one.
  *
@@ -1667,6 +1802,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 		khugepaged_scan.address = 0;
 		khugepaged_scan.mm_slot = mm_slot;
 	}
+	khugepaged_collapse_pte_mapped_thps(mm_slot);
 	spin_unlock(&khugepaged_mm_lock);
 
 	mm = mm_slot->mm;
-- 
2.17.1

