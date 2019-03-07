Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E368C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED4F20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfCGJLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:11:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:44550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725795AbfCGJLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:11:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6CFA5B67F;
        Thu,  7 Mar 2019 09:11:22 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH] xen: fix dom0 boot on huge systems
Date:   Thu,  7 Mar 2019 10:11:19 +0100
Message-Id: <20190307091119.6700-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f7c90c2aa40048 ("x86/xen: don't write ptes directly in 32-bit
PV guests") introduced a regression for booting dom0 on huge systems
with lots of RAM (in the TB range).

Reason is that on those hosts the p2m list needs to be moved early in
the boot process and this requires temporary page tables to be created.
Said commit modified xen_set_pte_init() to use a hypercall for writing
a PTE, but this requires the page table being in the direct mapped
area, which is not the case for the temporary page tables used in
xen_relocate_p2m().

As the page tables are completely written before being linked to the
actual address space instead of set_pte() a plain write to memory can
be used in xen_relocate_p2m().

Fixes: f7c90c2aa40048 ("x86/xen: don't write ptes directly in 32-bit PV guests")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/mmu_pv.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 0f4fe206dcc2..20701977e6c0 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2114,10 +2114,10 @@ void __init xen_relocate_p2m(void)
 				pt = early_memremap(pt_phys, PAGE_SIZE);
 				clear_page(pt);
 				for (idx_pte = 0;
-						idx_pte < min(n_pte, PTRS_PER_PTE);
-						idx_pte++) {
-					set_pte(pt + idx_pte,
-							pfn_pte(p2m_pfn, PAGE_KERNEL));
+				     idx_pte < min(n_pte, PTRS_PER_PTE);
+				     idx_pte++) {
+					pt[idx_pte] = pfn_pte(p2m_pfn,
+							      PAGE_KERNEL);
 					p2m_pfn++;
 				}
 				n_pte -= PTRS_PER_PTE;
@@ -2125,8 +2125,7 @@ void __init xen_relocate_p2m(void)
 				make_lowmem_page_readonly(__va(pt_phys));
 				pin_pagetable_pfn(MMUEXT_PIN_L1_TABLE,
 						PFN_DOWN(pt_phys));
-				set_pmd(pmd + idx_pt,
-						__pmd(_PAGE_TABLE | pt_phys));
+				pmd[idx_pt] = __pmd(_PAGE_TABLE | pt_phys);
 				pt_phys += PAGE_SIZE;
 			}
 			n_pt -= PTRS_PER_PMD;
@@ -2134,7 +2133,7 @@ void __init xen_relocate_p2m(void)
 			make_lowmem_page_readonly(__va(pmd_phys));
 			pin_pagetable_pfn(MMUEXT_PIN_L2_TABLE,
 					PFN_DOWN(pmd_phys));
-			set_pud(pud + idx_pmd, __pud(_PAGE_TABLE | pmd_phys));
+			pud[idx_pmd] = __pud(_PAGE_TABLE | pmd_phys);
 			pmd_phys += PAGE_SIZE;
 		}
 		n_pmd -= PTRS_PER_PUD;
-- 
2.16.4

