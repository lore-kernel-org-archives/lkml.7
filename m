Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72262C4CEC4
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 02:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498A4207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 02:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405180AbfITCWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 22:22:01 -0400
Received: from foss.arm.com ([217.140.110.172]:40192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404324AbfITCWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 22:22:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 215021570;
        Thu, 19 Sep 2019 19:22:00 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.40.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A51293F67D;
        Thu, 19 Sep 2019 19:21:55 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>, Jia He <justin.he@arm.com>
Subject: [PATCH v6 3/3] mm: fix double page fault on arm64 if PTE_AF is cleared
Date:   Fri, 20 Sep 2019 10:21:32 +0800
Message-Id: <20190920022132.149467-4-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190920022132.149467-1-justin.he@arm.com>
References: <20190920022132.149467-1-justin.he@arm.com>
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

Reported-by: Yibo Cai <Yibo.Cai@arm.com>
Signed-off-by: Jia He <justin.he@arm.com>
---
 mm/memory.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index e2bb51b6242e..7c38c1ce5440 100644
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
@@ -2140,8 +2147,12 @@ static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
 	return same;
 }
 
-static inline void cow_user_page(struct page *dst, struct page *src, unsigned long va, struct vm_area_struct *vma)
+static inline int cow_user_page(struct page *dst, struct page *src,
+				struct vm_fault *vmf)
 {
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long addr = vmf->address;
+
 	debug_dma_assert_idle(src);
 
 	/*
@@ -2151,21 +2162,52 @@ static inline void cow_user_page(struct page *dst, struct page *src, unsigned lo
 	 * fails, we just zero-fill it. Live with it.
 	 */
 	if (unlikely(!src)) {
-		void *kaddr = kmap_atomic(dst);
-		void __user *uaddr = (void __user *)(va & PAGE_MASK);
+		void *kaddr;
+		void __user *uaddr = (void __user *)(addr & PAGE_MASK);
+		pte_t entry;
+
+		/* On architectures with software "accessed" bits, we would
+		 * take a double page fault, so mark it accessed here.
+		 */
+		if (arch_faults_on_old_pte() && !pte_young(vmf->orig_pte)) {
+			spin_lock(vmf->ptl);
+			if (likely(pte_same(*vmf->pte, vmf->orig_pte))) {
+				entry = pte_mkyoung(vmf->orig_pte);
+				if (ptep_set_access_flags(vma, addr,
+							  vmf->pte, entry, 0))
+					update_mmu_cache(vma, addr, vmf->pte);
+			} else {
+				/* Other thread has already handled the fault
+				 * and we don't need to do anything. If it's
+				 * not the case, the fault will be triggered
+				 * again on the same address.
+				 */
+				spin_unlock(vmf->ptl);
+				return -1;
+			}
+			spin_unlock(vmf->ptl);
+		}
 
+		kaddr = kmap_atomic(dst);
 		/*
 		 * This really shouldn't fail, because the page is there
 		 * in the page tables. But it might just be unreadable,
 		 * in which case we just give up and fill the result with
 		 * zeroes.
 		 */
-		if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE))
+		if (__copy_from_user_inatomic(kaddr, uaddr, PAGE_SIZE)) {
+			/* Give a warn in case there can be some obscure
+			 * use-case
+			 */
+			WARN_ON_ONCE(1);
 			clear_page(kaddr);
+		}
 		kunmap_atomic(kaddr);
 		flush_dcache_page(dst);
 	} else
-		copy_user_highpage(dst, src, va, vma);
+		copy_user_highpage(dst, src, addr, vma);
+
+	return 0;
 }
 
 static gfp_t __get_fault_gfp_mask(struct vm_area_struct *vma)
@@ -2318,7 +2360,16 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 				vmf->address);
 		if (!new_page)
 			goto oom;
-		cow_user_page(new_page, old_page, vmf->address, vma);
+
+		if (cow_user_page(new_page, old_page, vmf)) {
+			/* COW failed, if the fault was solved by other,
+			 * it's fine. If not, userspace would re-fault on
+			 * the same address and we will handle the fault
+			 * from the second attempt.
+			 */
+			put_page(new_page);
+			goto normal;
+		}
 	}
 
 	if (mem_cgroup_try_charge_delay(new_page, mm, GFP_KERNEL, &memcg, false))
@@ -2420,6 +2471,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		}
 		put_page(old_page);
 	}
+
+normal:
 	return page_copied ? VM_FAULT_WRITE : 0;
 oom_free_new:
 	put_page(new_page);
-- 
2.17.1

