Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC61CC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C043320645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fHejNoar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfFMR6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:58:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49926 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727856AbfFMR6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:58:07 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DHsATr007002
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 10:58:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=yfkmPBW/NLQwl/dH7qhTlDffK3PtcU3kE6J70hPIVKM=;
 b=fHejNoarTn64Gikvo4FFamfYIdvs6ajKJcLdK5q3xw4Zm9wkYGjy/mB33kFOSoet5jyS
 zfxzG9TOdJcoE6zHPTMmT/Rx0+eOwH6Bl50WHROZOxOqiRezkmv4wTyffg2ofOEJHJtP
 4DuVKuZFFCC6AVvyP4pYtKQOLb2RRqtSGcQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0b-00082601.pphosted.com with ESMTP id 2t3qmj0w0v-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 10:58:06 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 13 Jun 2019 10:58:05 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id BD41E62E1C18; Thu, 13 Jun 2019 10:58:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <oleg@redhat.com>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <matthew.wilcox@oracle.com>, <kirill.shutemov@linux.intel.com>,
        <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v4 5/5] uprobe: collapse THP pmd after removing all uprobes
Date:   Thu, 13 Jun 2019 10:57:47 -0700
Message-ID: <20190613175747.1964753-6-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190613175747.1964753-1-songliubraving@fb.com>
References: <20190613175747.1964753-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=791 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130131
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After all uprobes are removed from the huge page (with PTE pgtable), it
is possible to collapse the pmd and benefit from THP again. This patch
does the collapse.

An issue on earlier version was discovered by kbuild test robot.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/huge_mm.h |  7 +++++
 kernel/events/uprobes.c |  5 ++-
 mm/huge_memory.c        | 69 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7cd5c150c21d..30669e9a9340 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -250,6 +250,9 @@ static inline bool thp_migration_supported(void)
 	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
 }
 
+extern void try_collapse_huge_pmd(struct vm_area_struct *vma,
+				  struct page *page);
+
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
 #define HPAGE_PMD_MASK ({ BUILD_BUG(); 0; })
@@ -368,6 +371,10 @@ static inline bool thp_migration_supported(void)
 {
 	return false;
 }
+
+static inline void try_collapse_huge_pmd(struct vm_area_struct *vma,
+					 struct page *page) {}
+
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #endif /* _LINUX_HUGE_MM_H */
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index a20d7b43a056..9bec602bf79e 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -474,6 +474,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	struct page *old_page, *new_page;
 	struct vm_area_struct *vma;
 	int ret, is_register, ref_ctr_updated = 0;
+	struct page *orig_page = NULL;
 
 	is_register = is_swbp_insn(&opcode);
 	uprobe = container_of(auprobe, struct uprobe, arch);
@@ -512,7 +513,6 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
 
 	if (!is_register) {
-		struct page *orig_page;
 		pgoff_t index;
 
 		index = vaddr_to_offset(vma, vaddr & PAGE_MASK) >> PAGE_SHIFT;
@@ -540,6 +540,9 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (ret && is_register && ref_ctr_updated)
 		update_ref_ctr(uprobe, mm, -1);
 
+	if (!ret && orig_page && PageTransCompound(orig_page))
+		try_collapse_huge_pmd(vma, orig_page);
+
 	return ret;
 }
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9f8bce9a6b32..cc8464650b72 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2886,6 +2886,75 @@ static struct shrinker deferred_split_shrinker = {
 	.flags = SHRINKER_NUMA_AWARE,
 };
 
+/**
+ * try_collapse_huge_pmd - try collapse pmd for a pte mapped huge page
+ * @vma: vma containing the huge page
+ * @page: any sub page of the huge page
+ */
+void try_collapse_huge_pmd(struct vm_area_struct *vma,
+			   struct page *page)
+{
+	struct page *hpage = compound_head(page);
+	struct mm_struct *mm = vma->vm_mm;
+	struct mmu_notifier_range range;
+	unsigned long haddr;
+	unsigned long addr;
+	pmd_t *pmd, _pmd;
+	spinlock_t *ptl;
+	int i, count = 0;
+
+	VM_BUG_ON_PAGE(!PageCompound(page), page);
+
+	haddr = page_address_in_vma(hpage, vma);
+	pmd = mm_find_pmd(mm, haddr);
+	if (!pmd)
+		return;
+
+	lock_page(hpage);
+	ptl = pmd_lock(mm, pmd);
+
+	/* step 1: check all mapped PTEs */
+	for (i = 0, addr = haddr; i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE) {
+		pte_t *pte = pte_offset_map(pmd, addr);
+
+		if (pte_none(*pte))
+			continue;
+		if (hpage + i != vm_normal_page(vma, addr, *pte)) {
+			spin_unlock(ptl);
+			unlock_page(hpage);
+			return;
+		}
+		count++;
+	}
+
+	/* step 2: adjust rmap */
+	for (i = 0, addr = haddr; i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE) {
+		pte_t *pte = pte_offset_map(pmd, addr);
+		struct page *p;
+
+		if (pte_none(*pte))
+			continue;
+		p = vm_normal_page(vma, addr, *pte);
+		page_remove_rmap(p, false);
+	}
+
+	/* step 3: flip page table */
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, NULL, mm,
+				haddr, haddr + HPAGE_PMD_SIZE);
+	mmu_notifier_invalidate_range_start(&range);
+
+	_pmd = pmdp_collapse_flush(vma, haddr, pmd);
+	spin_unlock(ptl);
+	mmu_notifier_invalidate_range_end(&range);
+
+	/* step 4: free pgtable, set refcount, mm_counters, etc. */
+	page_ref_sub(page, count);
+	unlock_page(hpage);
+	mm_dec_nr_ptes(mm);
+	pte_free(mm, pmd_pgtable(_pmd));
+	add_mm_counter(mm, mm_counter_file(page), -count);
+}
+
 #ifdef CONFIG_DEBUG_FS
 static int split_huge_pages_set(void *data, u64 val)
 {
-- 
2.17.1

