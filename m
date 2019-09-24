Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FB3C4360C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 23:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE6F2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 23:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R1cAwf0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442081AbfIXXZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 19:25:26 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:34366 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442059AbfIXXZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 19:25:25 -0400
Received: by mail-qk1-f202.google.com with SMTP id b67so4070659qkc.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 16:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jF3LwHMy1Im/uN1Rxj0wLkf4Ra+UlXW81PKhiasIOf0=;
        b=R1cAwf0wmLc4JnxR+VS23xXSu3nPjvOeg7wranBMJiJc0XqUFVkNV/oehzgidbrevA
         MpduyYw37pqaEm8VweexNg876O72FXuUD+wV6nLgnoph0qgpXVrF+m7K6aZmD16COFGi
         bTG0dV4rg7IfGTIwZwKKgMjhQJ3o7i3HG0GNaRb6BYFUpS/HLuPpHc/HX07gbS3Z0I8J
         uNl/6SWHlcng5cWoiv9Gn2EQjg4O73ykGDFwk4Rp4Kp0e/EcQRYY+K7PU9TSN1uMWT4F
         dPcS+9uvmiwf1IAN/fwZHGSUCt5odnp5OyjHvVPPASJ1FnHcxVch0peeNhv6xXzO2RfI
         bK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jF3LwHMy1Im/uN1Rxj0wLkf4Ra+UlXW81PKhiasIOf0=;
        b=Pnqd9FGSM7pSi1E1binLxLWwDexXd4u/hzCpr0cokChnrLk6qW+EiK6eGTwBiL2UGl
         QppXEhlxElXeWI+5aNvg061RuRVNRKkrytDiIpU3u8rZT89LjYNLttR8uQ55KmgSC/Ni
         a3tFJccBVBVrurN9Cp+gy9qbQOQyVMu7m8uzJhCRLKir38vQVxdX9PveyyEoIrRllKIz
         VdG7xMUxPon5VTTAfY8diMRLlMXnlS2l0L0og3w/k3GQiIg0rYif7jSWZ9qWgGHFqonU
         qGfu/0jUZTgOz6MWMa2QW/P4NjtymO24gPSn97pCVxomxiiet+nD716Ep7XAI0sRI92z
         mCUg==
X-Gm-Message-State: APjAAAUgUVz9NlstazzuztZbo7sRNtER9ppOkmU+FJ7eR3a/GVPJ1ZCs
        +isWLUZW7TG1uC/TSII1kUJ+VCQzlF0=
X-Google-Smtp-Source: APXvYqzRxA7gbx3nXbEjQFUlhSXxq0dRZYKtZSkeGzz3NExksdaEKh57l926xkGw5CQFU2cJ3KBgwWaa120=
X-Received: by 2002:a0c:9952:: with SMTP id i18mr4976580qvd.202.1569367523787;
 Tue, 24 Sep 2019 16:25:23 -0700 (PDT)
Date:   Tue, 24 Sep 2019 17:24:59 -0600
In-Reply-To: <20190924232459.214097-1-yuzhao@google.com>
Message-Id: <20190924232459.214097-4-yuzhao@google.com>
Mime-Version: 1.0
References: <20190914070518.112954-1-yuzhao@google.com> <20190924232459.214097-1-yuzhao@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v3 4/4] mm: remove unnecessary smp_wmb() in __SetPageUptodate()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        "=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?=" <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Lance Roy <ldr709@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Airlie <airlied@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Jan Kara <jack@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Huang Ying <ying.huang@intel.com>,
        Aaron Lu <ziqian.lzq@antfin.com>,
        Omar Sandoval <osandov@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smp_wmb()s added in the previous patch guarantee that the user data
appears before a page is exposed by set_pte_at(). So there is no
need for __SetPageUptodate() to have a built-in one.

There are total 13 __SetPageUptodate() for the non-hugetlb case. 12
of them reuse smp_wmb()s added in the previous patch.

The one in shmem_mfill_atomic_pte() doesn't need a explicit write
barrier because of the following shmem_add_to_page_cache().

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/page-flags.h |  6 +++++-
 kernel/events/uprobes.c    |  2 +-
 mm/huge_memory.c           | 11 +++--------
 mm/khugepaged.c            |  2 +-
 mm/memory.c                | 13 ++++---------
 mm/migrate.c               |  7 +------
 mm/swapfile.c              |  2 +-
 mm/userfaultfd.c           |  7 +------
 8 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index f91cb8898ff0..2481f9ad5f5b 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -508,10 +508,14 @@ static inline int PageUptodate(struct page *page)
 	return ret;
 }
 
+/*
+ * Only use this function when there is a following write barrier, e.g.,
+ * an explicit smp_wmb() and/or the page will be added to page or swap
+ * cache locked.
+ */
 static __always_inline void __SetPageUptodate(struct page *page)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
-	smp_wmb();
 	__set_bit(PG_uptodate, &page->flags);
 }
 
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 7069785e2e52..6ceae92afcc0 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -194,7 +194,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 
 	flush_cache_page(vma, addr, pte_pfn(*pvmw.pte));
 	ptep_clear_flush_notify(vma, addr, pvmw.pte);
-	/* commit non-atomic ops before exposing to fast gup */
+	/* commit non-atomic ops and user data */
 	smp_wmb();
 	set_pte_at_notify(mm, addr, pvmw.pte,
 			mk_pte(new_page, vma->vm_page_prot));
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 21d271a29d96..101e7bd61e8f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -580,11 +580,6 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 	}
 
 	clear_huge_page(page, vmf->address, HPAGE_PMD_NR);
-	/*
-	 * The memory barrier inside __SetPageUptodate makes sure that
-	 * clear_huge_page writes become visible before the set_pmd_at()
-	 * write.
-	 */
 	__SetPageUptodate(page);
 
 	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
@@ -616,7 +611,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		mem_cgroup_commit_charge(page, memcg, false, true);
 		lru_cache_add_active_or_unevictable(page, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
-		/* commit non-atomic ops before exposing to fast gup */
+		/* commit non-atomic ops and user data */
 		smp_wmb();
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
@@ -1278,7 +1273,7 @@ static vm_fault_t do_huge_pmd_wp_page_fallback(struct vm_fault *vmf,
 	}
 	kfree(pages);
 
-	/* commit non-atomic ops before exposing to fast gup */
+	/* commit non-atomic ops and user data */
 	smp_wmb(); /* make pte visible before pmd */
 
 	pmd_populate(vma->vm_mm, vmf->pmd, pgtable);
@@ -1427,7 +1422,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 		page_add_new_anon_rmap(new_page, vma, haddr, true);
 		mem_cgroup_commit_charge(new_page, memcg, false, true);
 		lru_cache_add_active_or_unevictable(new_page, vma);
-		/* commit non-atomic ops before exposing to fast gup */
+		/* commit non-atomic ops and user data */
 		smp_wmb();
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f2901edce6de..668918842712 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1074,7 +1074,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	count_memcg_events(memcg, THP_COLLAPSE_ALLOC, 1);
 	lru_cache_add_active_or_unevictable(new_page, vma);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
-	/* commit non-atomic ops before exposing to fast gup */
+	/* commit non-atomic ops and user data */
 	smp_wmb();
 	set_pmd_at(mm, address, pmd, _pmd);
 	update_mmu_cache_pmd(vma, address, pmd);
diff --git a/mm/memory.c b/mm/memory.c
index 6dabbc3cd3b7..db001d919e60 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2367,7 +2367,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 * mmu page tables (such as kvm shadow page tables), we want the
 		 * new page to be mapped directly into the secondary page table.
 		 */
-		/* commit non-atomic ops before exposing to fast gup */
+		/* commit non-atomic ops and user data */
 		smp_wmb();
 		set_pte_at_notify(mm, vmf->address, vmf->pte, entry);
 		update_mmu_cache(vma, vmf->address, vmf->pte);
@@ -2887,7 +2887,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
 		mem_cgroup_commit_charge(page, memcg, false, false);
 		lru_cache_add_active_or_unevictable(page, vma);
-		/* commit non-atomic ops before exposing to fast gup */
+		/* commit non-atomic ops and user data */
 		smp_wmb();
 	} else {
 		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
@@ -3006,11 +3006,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 					false))
 		goto oom_free_page;
 
-	/*
-	 * The memory barrier inside __SetPageUptodate makes sure that
-	 * preceeding stores to the page contents become visible before
-	 * the set_pte_at() write.
-	 */
 	__SetPageUptodate(page);
 
 	entry = mk_pte(page, vma->vm_page_prot);
@@ -3038,7 +3033,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	page_add_new_anon_rmap(page, vma, vmf->address, false);
 	mem_cgroup_commit_charge(page, memcg, false, false);
 	lru_cache_add_active_or_unevictable(page, vma);
-	/* commit non-atomic ops before exposing to fast gup */
+	/* commit non-atomic ops and user data */
 	smp_wmb();
 setpte:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
@@ -3303,7 +3298,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
 		mem_cgroup_commit_charge(page, memcg, false, false);
 		lru_cache_add_active_or_unevictable(page, vma);
-		/* commit non-atomic ops before exposing to fast gup */
+		/* commit non-atomic ops and user data */
 		smp_wmb();
 	} else {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
diff --git a/mm/migrate.c b/mm/migrate.c
index 943d147ecc3e..dc0ab9fbe36e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2729,11 +2729,6 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 	if (mem_cgroup_try_charge(page, vma->vm_mm, GFP_KERNEL, &memcg, false))
 		goto abort;
 
-	/*
-	 * The memory barrier inside __SetPageUptodate makes sure that
-	 * preceding stores to the page contents become visible before
-	 * the set_pte_at() write.
-	 */
 	__SetPageUptodate(page);
 
 	if (is_zone_device_page(page)) {
@@ -2783,7 +2778,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		lru_cache_add_active_or_unevictable(page, vma);
 	get_page(page);
 
-	/* commit non-atomic ops before exposing to fast gup */
+	/* commit non-atomic ops and user data */
 	smp_wmb();
 	if (flush) {
 		flush_cache_page(vma, addr, pte_pfn(*ptep));
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5c5547053ee0..dc9f1b1ba1a6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1887,7 +1887,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		page_add_new_anon_rmap(page, vma, addr, false);
 		mem_cgroup_commit_charge(page, memcg, false, false);
 		lru_cache_add_active_or_unevictable(page, vma);
-		/* commit non-atomic ops before exposing to fast gup */
+		/* commit non-atomic ops and user data */
 		smp_wmb();
 	}
 	set_pte_at(vma->vm_mm, addr, pte,
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 4f92913242a1..34083680869e 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -58,11 +58,6 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 		*pagep = NULL;
 	}
 
-	/*
-	 * The memory barrier inside __SetPageUptodate makes sure that
-	 * preceeding stores to the page contents become visible before
-	 * the set_pte_at() write.
-	 */
 	__SetPageUptodate(page);
 
 	ret = -ENOMEM;
@@ -92,7 +87,7 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 	mem_cgroup_commit_charge(page, memcg, false, false);
 	lru_cache_add_active_or_unevictable(page, dst_vma);
 
-	/* commit non-atomic ops before exposing to fast gup */
+	/* commit non-atomic ops and user data */
 	smp_wmb();
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
 
-- 
2.23.0.351.gc4317032e6-goog

