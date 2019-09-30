Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BA8C32793
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 01:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86252082F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 01:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfI3B6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 21:58:07 -0400
Received: from foss.arm.com ([217.140.110.172]:45426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfI3B6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 21:58:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF4C115A2;
        Sun, 29 Sep 2019 18:58:05 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.40.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1C5563F706;
        Sun, 29 Sep 2019 18:58:01 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>, Jia He <justin.he@arm.com>
Subject: [PATCH v10 3/3] mm: fix double page fault on arm64 if PTE_AF is cleared
Date:   Mon, 30 Sep 2019 09:57:40 +0800
Message-Id: <20190930015740.84362-4-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190930015740.84362-1-justin.he@arm.com>
References: <20190930015740.84362-1-justin.he@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we tested pmdk unit test [1] vmmalloc_fork TEST1 in arm64 guest, there
will be a double page fault in __copy_from_user_inatomic of cow_user_page.

Below call trace is from arm64 do_page_fault for debugging purpose
[  110.016195] Call trace:
[  110.016826]  do_page_fault+0x5a4/0x690
[  110.017812]  do_mem_abort+0x50/0xb0
[  110.018726]  el1_da+0x20/0xc4
[  110.019492]  __arch_copy_from_user+0x180/0x280
[  110.020646]  do_wp_page+0xb0/0x860
[  110.021517]  __handle_mm_fault+0x994/0x1338
[  110.022606]  handle_mm_fault+0xe8/0x180
[  110.023584]  do_page_fault+0x240/0x690
[  110.024535]  do_mem_abort+0x50/0xb0
[  110.025423]  el0_da+0x20/0x24

The pte info before __copy_from_user_inatomic is (PTE_AF is cleared):
[ffff9b007000] pgd=000000023d4f8003, pud=000000023da9b003, pmd=000000023d4b3003, pte=360000298607bd3

As told by Catalin: "On arm64 without hardware Access Flag, copying from
user will fail because the pte is old and cannot be marked young. So we
always end up with zeroed page after fork() + CoW for pfn mappings. we
don't always have a hardware-managed access flag on arm64."

This patch fix it by calling pte_mkyoung. Also, the parameter is
changed because vmf should be passed to cow_user_page()

Add a WARN_ON_ONCE when __copy_from_user_inatomic() returns error
in case there can be some obscure use-case.(by Kirill)

[1] https://github.com/pmem/pmdk/tree/master/src/test/vmmalloc_fork

Signed-off-by: Jia He <justin.he@arm.com>
Reported-by: Yibo Cai <Yibo.Cai@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/memory.c | 99 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 84 insertions(+), 15 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b1ca51a079f2..1f56b0118ef5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -118,6 +118,13 @@ int randomize_va_space __read_mostly =
 					2;
 #endif
 
+#ifndef arch_faults_on_old_pte
+static inline bool arch_faults_on_old_pte(void)
+{
+	return false;
+}
+#endif
+
 static int __init disable_randmaps(char *s)
 {
 	randomize_va_space = 0;
@@ -2145,32 +2152,82 @@ static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
 	return same;
 }
 
-static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va, struct vm_area_struct *vma)
+static inline bool cow_user_page(struct page *dst, struct page *src,
+				 struct vm_fault *vmf)
 {
+	bool ret;
+	void *kaddr;
+	void __user *uaddr;
+	bool force_mkyoung;
+	struct vm_area_struct *vma = vmf->vma;
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long addr = vmf->address;
+
 	debug_dma_assert_idle(src);
 
+	if (likely(src)) {
+		copy_user_highpage(dst, src, addr, vma);
+		return true;
+	}
+
 	/*
 	 * If the source page was a PFN mapping, we don't have
 	 * a "struct page" for it. We do a best-effort copy by
 	 * just copying from the original user address. If that
 	 * fails, we just zero-fill it. Live with it.
 	 */
-	if (unlikely(!src)) {
-		void *kaddr = kmap_atomic(dst);
-		void __user *uaddr = (void __user *)(va & PAGE_MASK);
+	kaddr = kmap_atomic(dst);
+	uaddr = (void __user *)(addr & PAGE_MASK);
+
+	/*
+	 * On architectures with software "accessed" bits, we would
+	 * take a double page fault, so mark it accessed here.
+	 */
+	force_mkyoung = arch_faults_on_old_pte() && !pte_young(vmf->orig_pte);
+	if (force_mkyoung) {
+		pte_t entry;
+
+		vmf->pte = pte_offset_map_lock(mm, vmf->pmd, addr, &vmf->ptl);
+		if (!likely(pte_same(*vmf->pte, vmf->orig_pte))) {
+			/*
+			 * Other thread has already handled the fault
+			 * and we don't need to do anything. If it's
+			 * not the case, the fault will be triggered
+			 * again on the same address.
+			 */
+			ret = false;
+			goto pte_unlock;
+		}
+
+		entry = pte_mkyoung(vmf->orig_pte);
+		if (ptep_set_access_flags(vma, addr, vmf->pte, entry, 0))
+			update_mmu_cache(vma, addr, vmf->pte);
+	}
 
+	/*
+	 * This really shouldn't fail, because the page is there
+	 * in the page tables. But it might just be unreadable,
+	 * in which case we just give up and fill the result with
+	 * zeroes.
+	 */
+	if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE)) {
 		/*
-		 * This really shouldn't fail, because the page is there
-		 * in the page tables. But it might just be unreadable,
-		 * in which case we just give up and fill the result with
-		 * zeroes.
+		 * Give a warn in case there can be some obscure
+		 * use-case
 		 */
-		if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE))
-			clear_page(kaddr);
-		kunmap_atomic(kaddr);
-		flush_dcache_page(dst);
-	} else
-		copy_user_highpage(dst, src, va, vma);
+		WARN_ON_ONCE(1);
+		clear_page(kaddr);
+	}
+
+	ret = true;
+
+pte_unlock:
+	if (force_mkyoung)
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+	kunmap_atomic(kaddr);
+	flush_dcache_page(dst);
+
+	return ret;
 }
 
 static gfp_t __get_fault_gfp_mask(struct vm_area_struct *vma)
@@ -2327,7 +2384,19 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 				vmf->address);
 		if (!new_page)
 			goto oom;
-		cow_user_page(new_page, old_page, vmf->address, vma);
+
+		if (!cow_user_page(new_page, old_page, vmf)) {
+			/*
+			 * COW failed, if the fault was solved by other,
+			 * it's fine. If not, userspace would re-fault on
+			 * the same address and we will handle the fault
+			 * from the second attempt.
+			 */
+			put_page(new_page);
+			if (old_page)
+				put_page(old_page);
+			return 0;
+		}
 	}
 
 	if (mem_cgroup_try_charge_delay(new_page, mm, GFP_KERNEL, &memcg, false))
-- 
2.17.1

