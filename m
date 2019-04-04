Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A7DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DCE20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbfDDJrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:47:14 -0400
Received: from foss.arm.com ([217.140.101.70]:56712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730361AbfDDJrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:47:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67B1C169E;
        Thu,  4 Apr 2019 02:47:11 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.40.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B6113F557;
        Thu,  4 Apr 2019 02:47:05 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com
Cc:     mhocko@suse.com, mgorman@techsingularity.net, james.morse@arm.com,
        mark.rutland@arm.com, robin.murphy@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        logang@deltatee.com, david@redhat.com, cai@lca.pw
Subject: [RFC 2/2] arm64/mm: Enable ZONE_DEVICE for all page configs
Date:   Thu,  4 Apr 2019 15:16:50 +0530
Message-Id: <1554371210-24736-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554371210-24736-1-git-send-email-anshuman.khandual@arm.com>
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
 <1554371210-24736-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that vmemmap_populate_basepages() supports struct vmem_altmap based
allocations, ZONE_DEVICE can be functional across all page size configs.
Now vmemmap_populate_baepages() takes in actual struct vmem_altmap for
allocation and remove_pagetable() should accommodate such new PTE level
vmemmap mappings. Just remove the ARCH_HAS_ZONE_DEVICE dependency from
ARM64_4K_PAGES.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/Kconfig  |  2 +-
 arch/arm64/mm/mmu.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b5d8cf57e220..4a37a33a4fe5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -31,7 +31,7 @@ config ARM64
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
-	select ARCH_HAS_ZONE_DEVICE if ARM64_4K_PAGES
+	select ARCH_HAS_ZONE_DEVICE
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK if !PREEMPT
 	select ARCH_INLINE_READ_LOCK_BH if !PREEMPT
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2859aa89cc4a..509ed7e547a3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -818,8 +818,8 @@ static void __meminit free_pud_table(pud_t *pud_start, pgd_t *pgd, bool direct)
 #endif
 
 static void __meminit
-remove_pte_table(pte_t *pte_start, unsigned long addr,
-			unsigned long end, bool direct)
+remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
+		bool direct, struct vmem_altmap *altmap)
 {
 	pte_t *pte;
 
@@ -829,7 +829,7 @@ remove_pte_table(pte_t *pte_start, unsigned long addr,
 			continue;
 
 		if (!direct)
-			free_pagetable(pte_page(*pte), 0);
+			free_huge_pagetable(pte_page(*pte), 0, altmap);
 		spin_lock(&init_mm.page_table_lock);
 		pte_clear(&init_mm, addr, pte);
 		spin_unlock(&init_mm.page_table_lock);
@@ -860,7 +860,7 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
 			continue;
 		}
 		pte_base = pte_offset_kernel(pmd, 0UL);
-		remove_pte_table(pte_base, addr, next, direct);
+		remove_pte_table(pte_base, addr, next, direct, altmap);
 		free_pte_table(pte_base, pmd, direct);
 	}
 }
@@ -921,7 +921,7 @@ remove_pagetable(unsigned long start, unsigned long end,
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap)
 {
-	return vmemmap_populate_basepages(start, end, node, NULL);
+	return vmemmap_populate_basepages(start, end, node, altmap);
 }
 #else	/* !ARM64_SWAPPER_USES_SECTION_MAPS */
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
-- 
2.20.1

