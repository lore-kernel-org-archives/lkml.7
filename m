Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF29C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1020821934
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256299;
	bh=SVyvQgEaS2n3edZ7nZf9yc8X9rgzTjRrdjVgXqGD66k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=USMBruxNc80dmsDoFc6eJA2zAjXaagfuKkYKkWxjGU4xFwKQ+XlcH7Bb+lMH/rNAg
	 1ZsVskFIqxVtI9ftHIgamszLYF6lSmeS5i8Ok+1bhni/Yt3eA9yCgtfaTBwLf0iyE0
	 1rddt7WLGP5PtVfA6AN1UULJTcd7IJc5ZhgstUBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388730AbfCVME4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:04:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388723AbfCVMEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:04:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A9812192D;
        Fri, 22 Mar 2019 12:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256291;
        bh=SVyvQgEaS2n3edZ7nZf9yc8X9rgzTjRrdjVgXqGD66k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a7hienFyIY9jGnEjZJ1YNpGLrO1VmXnrkUh8y7u3lpzNTRBv+pS+1sL/NpZ8FFw2o
         yGfgUSHp7TxrhDs/LnsIXoKbyV8n6ZR4+oqFxPKpwZfO7v31dUGl8YTSb2u4HWxpge
         wZHzMQX4GELljPLgWhR+Jkiv26Vcg/4nWxVA90uk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Jan Beulich <jbeulich@suse.com>
Subject: [PATCH 4.19 143/280] xen: fix dom0 boot on huge systems
Date:   Fri, 22 Mar 2019 12:14:56 +0100
Message-Id: <20190322111318.730430506@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit 01bd2ac2f55a1916d81dace12fa8d7ae1c79b5ea upstream.

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
Cc: stable@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/mmu_pv.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2106,10 +2106,10 @@ void __init xen_relocate_p2m(void)
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
@@ -2117,8 +2117,7 @@ void __init xen_relocate_p2m(void)
 				make_lowmem_page_readonly(__va(pt_phys));
 				pin_pagetable_pfn(MMUEXT_PIN_L1_TABLE,
 						PFN_DOWN(pt_phys));
-				set_pmd(pmd + idx_pt,
-						__pmd(_PAGE_TABLE | pt_phys));
+				pmd[idx_pt] = __pmd(_PAGE_TABLE | pt_phys);
 				pt_phys += PAGE_SIZE;
 			}
 			n_pt -= PTRS_PER_PMD;
@@ -2126,7 +2125,7 @@ void __init xen_relocate_p2m(void)
 			make_lowmem_page_readonly(__va(pmd_phys));
 			pin_pagetable_pfn(MMUEXT_PIN_L2_TABLE,
 					PFN_DOWN(pmd_phys));
-			set_pud(pud + idx_pmd, __pud(_PAGE_TABLE | pmd_phys));
+			pud[idx_pmd] = __pud(_PAGE_TABLE | pmd_phys);
 			pmd_phys += PAGE_SIZE;
 		}
 		n_pmd -= PTRS_PER_PUD;


