Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5727FC04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 03:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217A02081C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 03:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfEUDf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 23:35:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56468 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbfEUDf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 23:35:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A671341;
        Mon, 20 May 2019 20:35:25 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.42.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 10D603F718;
        Mon, 20 May 2019 20:35:22 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] arm64/hugetlb: Use macros for contiguous huge page sizes
Date:   Tue, 21 May 2019 09:05:03 +0530
Message-Id: <1558409703-31894-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace all open encoded contiguous huge page size computations with
available macro encodings CONT_PTE_SIZE and CONT_PMD_SIZE. There are other
instances where these macros are used in the file and this change makes it
consistently use the same mnemonic.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/mm/hugetlbpage.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 6b4a47b..05b5dda 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -236,7 +236,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 
 	if (sz == PUD_SIZE) {
 		ptep = (pte_t *)pudp;
-	} else if (sz == (PAGE_SIZE * CONT_PTES)) {
+	} else if (sz == (CONT_PTE_SIZE)) {
 		pmdp = pmd_alloc(mm, pudp, addr);
 
 		WARN_ON(addr & (sz - 1));
@@ -254,7 +254,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
 			ptep = huge_pmd_share(mm, addr, pudp);
 		else
 			ptep = (pte_t *)pmd_alloc(mm, pudp, addr);
-	} else if (sz == (PMD_SIZE * CONT_PMDS)) {
+	} else if (sz == (CONT_PMD_SIZE)) {
 		pmdp = pmd_alloc(mm, pudp, addr);
 		WARN_ON(addr & (sz - 1));
 		return (pte_t *)pmdp;
@@ -462,9 +462,9 @@ static int __init hugetlbpage_init(void)
 #ifdef CONFIG_ARM64_4K_PAGES
 	add_huge_page_size(PUD_SIZE);
 #endif
-	add_huge_page_size(PMD_SIZE * CONT_PMDS);
+	add_huge_page_size(CONT_PMD_SIZE);
 	add_huge_page_size(PMD_SIZE);
-	add_huge_page_size(PAGE_SIZE * CONT_PTES);
+	add_huge_page_size(CONT_PTE_SIZE);
 
 	return 0;
 }
@@ -478,9 +478,9 @@ static __init int setup_hugepagesz(char *opt)
 #ifdef CONFIG_ARM64_4K_PAGES
 	case PUD_SIZE:
 #endif
-	case PMD_SIZE * CONT_PMDS:
+	case CONT_PMD_SIZE:
 	case PMD_SIZE:
-	case PAGE_SIZE * CONT_PTES:
+	case CONT_PTE_SIZE:
 		add_huge_page_size(ps);
 		return 1;
 	}
-- 
2.7.4

