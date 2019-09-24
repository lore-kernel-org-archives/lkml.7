Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C83DC4320D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 23:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4835221655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 23:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ux0Cr0Z0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442071AbfIXXZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 19:25:25 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:44527 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442060AbfIXXZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 19:25:24 -0400
Received: by mail-yw1-f73.google.com with SMTP id n3so2754658ywh.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 16:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I0+ed5qgMVEqWKpob9KndzoL/arxaP80PcQihG9xudI=;
        b=ux0Cr0Z0Ycwm20bArU01Oc/qPO5LrAil4z5pwKynMCCcTG/tx0uY4uZo5oaTCxiecw
         200tkVynhY85wKdjkXBSmddMCY2tQ4GXIfwH49XBE7AXO7rdbDIwdaK1Ims0dyK7kFym
         JZBJOfvztxPkKmU/vQqcpVZ0bq3c7rYtiikO/MyLgaQeBFSBSMt7Ebmvomd29It5dJs0
         iShM48t4BhG9e86fzt2aF3Qh+QnEVBne1Sv8Q0EcnSwlqXj5363sjO/xAq5rwFGbT/WF
         IRlJO8pE9e0p7PjoTRITLeOR+q0k3I2joD6RdO3inVT9QtrCLVzPnD27oJJMKbn7R/no
         SUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I0+ed5qgMVEqWKpob9KndzoL/arxaP80PcQihG9xudI=;
        b=nTKe0zHXDLE/SfVbryx57iSgbHeruTfQYvMX86UuqqJa/7hO2AQf9PO8qE27uGI5RG
         5vk0Ozr5ei9T5SoUHPgBK2fB0PnQZXKp43n8qeHsJK96L8LGaGmwQ2Vnqjjk82d8Athv
         z4I93hZ4jOu1Gy8JhubwOGdCK6ZbdILRiuRSyIwqTlDmwD9bMLVFtsmfRd3KhhdBO9Ya
         wYHAzf4S/+GpPWYDyO+8zeaTY94AAD6N2Fmk8rAHtb9eHO+qfckcd9KU+a9tW92w9Qef
         MMMCHIkVt4S/KJsZRaQSodWo7xCycTuypBaomDyM9HyiQiK1XPPRLgwVdy1JW0KiajGH
         7SrQ==
X-Gm-Message-State: APjAAAWCV0HL3fnAtKFI/jEQQgz0Bfn0pdcCz1WoEXnOj90Zs6aw7TlK
        HFcD0iHmEDNMsRc7d3cZ5+3MzdYaPMA=
X-Google-Smtp-Source: APXvYqw9Fp9haV7xmpe3jZK31pIRzqTQV0Tr+Q5B6z/3oAW/KhxbGxWBFISCXV11wNDaezN3R13Xd5qcMEM=
X-Received: by 2002:a25:9c01:: with SMTP id c1mr1016307ybo.492.1569367521792;
 Tue, 24 Sep 2019 16:25:21 -0700 (PDT)
Date:   Tue, 24 Sep 2019 17:24:58 -0600
In-Reply-To: <20190924232459.214097-1-yuzhao@google.com>
Message-Id: <20190924232459.214097-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20190914070518.112954-1-yuzhao@google.com> <20190924232459.214097-1-yuzhao@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v3 3/4] mm: don't expose non-hugetlb page to fast gup prematurely
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

We don't want to expose a non-hugetlb page to the fast gup running
on a remote CPU before all local non-atomic ops on the page flags
are visible first.

For an anon page that isn't in swap cache, we need to make sure all
prior non-atomic ops, especially __SetPageSwapBacked() in
page_add_new_anon_rmap(), are ordered before set_pte_at() to prevent
the following race:

	CPU 1				CPU1
	set_pte_at()			get_user_pages_fast()
	  page_add_new_anon_rmap()	  gup_pte_range()
	  __SetPageSwapBacked()		    SetPageReferenced()

This demonstrates a non-fatal scenario. Though haven't been directly
observed, the fatal ones can exist, e.g., PG_lock set by fast gup
caller and then overwritten by __SetPageSwapBacked().

For an anon page that is already in swap cache or a file page, we
don't need smp_wmb() before set_pte_at() because adding to swap or
file cach serves as a valid write barrier. Using non-atomic ops
thereafter is a bug, obviously.

smp_wmb() is added following 11 of total 12 page_add_new_anon_rmap()
call sites, with the only exception being
do_huge_pmd_wp_page_fallback() because of an existing smp_wmb().

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 kernel/events/uprobes.c |  2 ++
 mm/huge_memory.c        |  6 ++++++
 mm/khugepaged.c         |  2 ++
 mm/memory.c             | 10 +++++++++-
 mm/migrate.c            |  2 ++
 mm/swapfile.c           |  6 ++++--
 mm/userfaultfd.c        |  2 ++
 7 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 84fa00497c49..7069785e2e52 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -194,6 +194,8 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 
 	flush_cache_page(vma, addr, pte_pfn(*pvmw.pte));
 	ptep_clear_flush_notify(vma, addr, pvmw.pte);
+	/* commit non-atomic ops before exposing to fast gup */
+	smp_wmb();
 	set_pte_at_notify(mm, addr, pvmw.pte,
 			mk_pte(new_page, vma->vm_page_prot));
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index de1f15969e27..21d271a29d96 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -616,6 +616,8 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		mem_cgroup_commit_charge(page, memcg, false, true);
 		lru_cache_add_active_or_unevictable(page, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
+		/* commit non-atomic ops before exposing to fast gup */
+		smp_wmb();
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
 		mm_inc_nr_ptes(vma->vm_mm);
@@ -1276,7 +1278,9 @@ static vm_fault_t do_huge_pmd_wp_page_fallback(struct vm_fault *vmf,
 	}
 	kfree(pages);
 
+	/* commit non-atomic ops before exposing to fast gup */
 	smp_wmb(); /* make pte visible before pmd */
+
 	pmd_populate(vma->vm_mm, vmf->pmd, pgtable);
 	page_remove_rmap(page, true);
 	spin_unlock(vmf->ptl);
@@ -1423,6 +1427,8 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf, pmd_t orig_pmd)
 		page_add_new_anon_rmap(new_page, vma, haddr, true);
 		mem_cgroup_commit_charge(new_page, memcg, false, true);
 		lru_cache_add_active_or_unevictable(new_page, vma);
+		/* commit non-atomic ops before exposing to fast gup */
+		smp_wmb();
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 		if (!page) {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 70ff98e1414d..f2901edce6de 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1074,6 +1074,8 @@ static void collapse_huge_page(struct mm_struct *mm,
 	count_memcg_events(memcg, THP_COLLAPSE_ALLOC, 1);
 	lru_cache_add_active_or_unevictable(new_page, vma);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
+	/* commit non-atomic ops before exposing to fast gup */
+	smp_wmb();
 	set_pmd_at(mm, address, pmd, _pmd);
 	update_mmu_cache_pmd(vma, address, pmd);
 	spin_unlock(pmd_ptl);
diff --git a/mm/memory.c b/mm/memory.c
index aa86852d9ec2..6dabbc3cd3b7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2367,6 +2367,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		 * mmu page tables (such as kvm shadow page tables), we want the
 		 * new page to be mapped directly into the secondary page table.
 		 */
+		/* commit non-atomic ops before exposing to fast gup */
+		smp_wmb();
 		set_pte_at_notify(mm, vmf->address, vmf->pte, entry);
 		update_mmu_cache(vma, vmf->address, vmf->pte);
 		if (old_page) {
@@ -2877,7 +2879,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	flush_icache_page(vma, page);
 	if (pte_swp_soft_dirty(vmf->orig_pte))
 		pte = pte_mksoft_dirty(pte);
-	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
 	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
 	vmf->orig_pte = pte;
 
@@ -2886,12 +2887,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
 		mem_cgroup_commit_charge(page, memcg, false, false);
 		lru_cache_add_active_or_unevictable(page, vma);
+		/* commit non-atomic ops before exposing to fast gup */
+		smp_wmb();
 	} else {
 		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
 		mem_cgroup_commit_charge(page, memcg, true, false);
 		activate_page(page);
 	}
 
+	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
 	swap_free(entry);
 	if (mem_cgroup_swap_full(page) ||
 	    (vma->vm_flags & VM_LOCKED) || PageMlocked(page))
@@ -3034,6 +3038,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	page_add_new_anon_rmap(page, vma, vmf->address, false);
 	mem_cgroup_commit_charge(page, memcg, false, false);
 	lru_cache_add_active_or_unevictable(page, vma);
+	/* commit non-atomic ops before exposing to fast gup */
+	smp_wmb();
 setpte:
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
 
@@ -3297,6 +3303,8 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 		page_add_new_anon_rmap(page, vma, vmf->address, false);
 		mem_cgroup_commit_charge(page, memcg, false, false);
 		lru_cache_add_active_or_unevictable(page, vma);
+		/* commit non-atomic ops before exposing to fast gup */
+		smp_wmb();
 	} else {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
 		page_add_file_rmap(page, false);
diff --git a/mm/migrate.c b/mm/migrate.c
index 9f4ed4e985c1..943d147ecc3e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2783,6 +2783,8 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		lru_cache_add_active_or_unevictable(page, vma);
 	get_page(page);
 
+	/* commit non-atomic ops before exposing to fast gup */
+	smp_wmb();
 	if (flush) {
 		flush_cache_page(vma, addr, pte_pfn(*ptep));
 		ptep_clear_flush_notify(vma, addr, ptep);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index dab43523afdd..5c5547053ee0 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1880,8 +1880,6 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
 	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
 	get_page(page);
-	set_pte_at(vma->vm_mm, addr, pte,
-		   pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	if (page == swapcache) {
 		page_add_anon_rmap(page, vma, addr, false);
 		mem_cgroup_commit_charge(page, memcg, true, false);
@@ -1889,7 +1887,11 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		page_add_new_anon_rmap(page, vma, addr, false);
 		mem_cgroup_commit_charge(page, memcg, false, false);
 		lru_cache_add_active_or_unevictable(page, vma);
+		/* commit non-atomic ops before exposing to fast gup */
+		smp_wmb();
 	}
+	set_pte_at(vma->vm_mm, addr, pte,
+		   pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	swap_free(entry);
 	/*
 	 * Move the page to the active list so it is not
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index c7ae74ce5ff3..4f92913242a1 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -92,6 +92,8 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 	mem_cgroup_commit_charge(page, memcg, false, false);
 	lru_cache_add_active_or_unevictable(page, dst_vma);
 
+	/* commit non-atomic ops before exposing to fast gup */
+	smp_wmb();
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
 
 	/* No need to invalidate - it was non-present before */
-- 
2.23.0.351.gc4317032e6-goog

