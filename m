Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FC5C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 05:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A22208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 05:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gafcg6C8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfFWFtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 01:49:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49860 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726619AbfFWFtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 01:49:01 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5N5ipri015299
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 22:49:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=CFhlysmGz57clyaJ1HAINnv1wDIl1pPPAi1K6HzPDZ0=;
 b=gafcg6C8zP7ZBtoTG180sNk0r9ODkCNup9DgAtwrNhAafglZwxjmkMOIdDOdX4f6rBcZ
 gXDmKHBh5OmHh/aNzF0JLzF4/1Eugd5wpDQqo2J1e+rU4MAfN6QMKAOXDfphSvXS8hsx
 jn2PaPJumGspkXlSYEA8tLPi8R03XIGzCe8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t9gc0jd4a-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 22:48:59 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Sat, 22 Jun 2019 22:48:58 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id A436162E2CFB; Sat, 22 Jun 2019 22:48:55 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <matthew.wilcox@oracle.com>, <kirill.shutemov@linux.intel.com>,
        <peterz@infradead.org>, <oleg@redhat.com>, <rostedt@goodmis.org>,
        <kernel-team@fb.com>, <william.kucharski@oracle.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v6 5/6] khugepaged: enable collapse pmd for pte-mapped THP
Date:   Sat, 22 Jun 2019 22:48:28 -0700
Message-ID: <20190623054829.4018117-6-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190623054829.4018117-1-songliubraving@fb.com>
References: <20190623054829.4018117-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=350 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906230050
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

khugepaged needs exclusive mmap_sem to access page table. When it fails
to lock mmap_sem, the page will fault in as pte-mapped THP. As the page
is already a THP, khugepaged will not handle this pmd again.

This patch enables the khugepaged to retry retract_page_tables().

A new flag AS_COLLAPSE_PMD is introduced to show the address_space may
contain pte-mapped THPs. When khugepaged fails to trylock the mmap_sem,
it sets AS_COLLAPSE_PMD. Then, at a later time, khugepaged will retry
compound pages in this address_space.

Since collapse may happen at an later time, some pages may already fault
in. To handle these pages properly, it is necessary to prepare the pmd
before collapsing. prepare_pmd_for_collapse() is introduced to prepare
the pmd by removing rmap, adjusting refcount and mm_counter.

prepare_pmd_for_collapse() also double checks whether all ptes in this
pmd are mapping to the same THP. This is necessary because some subpage
of the THP may be replaced, for example by uprobe. In such cases, it
is not possible to collapse the pmd, so we fall back.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/pagemap.h |  1 +
 mm/khugepaged.c         | 69 +++++++++++++++++++++++++++++++++++------
 2 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 9ec3544baee2..eac881de2a46 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -29,6 +29,7 @@ enum mapping_flags {
 	AS_EXITING	= 4, 	/* final truncate in progress */
 	/* writeback related tags are not used */
 	AS_NO_WRITEBACK_TAGS = 5,
+	AS_COLLAPSE_PMD = 6,	/* try collapse pmd for THP */
 };
 
 /**
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a4f90a1b06f5..9b980327fd9b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1254,7 +1254,47 @@ static void collect_mm_slot(struct mm_slot *mm_slot)
 }
 
 #if defined(CONFIG_SHMEM) && defined(CONFIG_TRANSPARENT_HUGE_PAGECACHE)
-static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
+
+/* return whether the pmd is ready for collapse */
+bool prepare_pmd_for_collapse(struct vm_area_struct *vma, pgoff_t pgoff,
+			      struct page *hpage, pmd_t *pmd)
+{
+	unsigned long haddr = page_address_in_vma(hpage, vma);
+	unsigned long addr;
+	int i, count = 0;
+
+	/* step 1: check all mapped PTEs are to this huge page */
+	for (i = 0, addr = haddr; i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE) {
+		pte_t *pte = pte_offset_map(pmd, addr);
+
+		if (pte_none(*pte))
+			continue;
+
+		if (hpage + i != vm_normal_page(vma, addr, *pte))
+			return false;
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
+	page_ref_sub(hpage, count);
+	add_mm_counter(vma->vm_mm, mm_counter_file(hpage), -count);
+	return true;
+}
+
+extern pid_t sysctl_dump_pt_pid;
+static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
+				struct page *hpage)
 {
 	struct vm_area_struct *vma;
 	unsigned long addr;
@@ -1273,21 +1313,21 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		pmd = mm_find_pmd(vma->vm_mm, addr);
 		if (!pmd)
 			continue;
-		/*
-		 * We need exclusive mmap_sem to retract page table.
-		 * If trylock fails we would end up with pte-mapped THP after
-		 * re-fault. Not ideal, but it's more important to not disturb
-		 * the system too much.
-		 */
 		if (down_write_trylock(&vma->vm_mm->mmap_sem)) {
 			spinlock_t *ptl = pmd_lock(vma->vm_mm, pmd);
-			/* assume page table is clear */
+
+			if (!prepare_pmd_for_collapse(vma, pgoff, hpage, pmd)) {
+				spin_unlock(ptl);
+				up_write(&vma->vm_mm->mmap_sem);
+				continue;
+			}
 			_pmd = pmdp_collapse_flush(vma, addr, pmd);
 			spin_unlock(ptl);
 			up_write(&vma->vm_mm->mmap_sem);
 			mm_dec_nr_ptes(vma->vm_mm);
 			pte_free(vma->vm_mm, pmd_pgtable(_pmd));
-		}
+		} else
+			set_bit(AS_COLLAPSE_PMD, &mapping->flags);
 	}
 	i_mmap_unlock_write(mapping);
 }
@@ -1561,7 +1601,7 @@ static void collapse_file(struct mm_struct *mm,
 		/*
 		 * Remove pte page tables, so we can re-fault the page as huge.
 		 */
-		retract_page_tables(mapping, start);
+		retract_page_tables(mapping, start, new_page);
 		*hpage = NULL;
 
 		khugepaged_pages_collapsed++;
@@ -1622,6 +1662,7 @@ static void khugepaged_scan_file(struct mm_struct *mm,
 	int present, swap;
 	int node = NUMA_NO_NODE;
 	int result = SCAN_SUCCEED;
+	bool collapse_pmd = false;
 
 	present = 0;
 	swap = 0;
@@ -1640,6 +1681,14 @@ static void khugepaged_scan_file(struct mm_struct *mm,
 		}
 
 		if (PageTransCompound(page)) {
+			if (collapse_pmd ||
+			    test_and_clear_bit(AS_COLLAPSE_PMD,
+					       &mapping->flags)) {
+				collapse_pmd = true;
+				retract_page_tables(mapping, start,
+						    compound_head(page));
+				continue;
+			}
 			result = SCAN_PAGE_COMPOUND;
 			break;
 		}
-- 
2.17.1

