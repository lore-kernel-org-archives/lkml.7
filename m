Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71EFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7153D2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366785;
	bh=hXWid/96J/QYiS7AC2ekBNXXNQJGSSvgqkdvPMrCjgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1i0NuYP05mpywF93KHWX13h89fkxiPo8Ymi7HnpLxEGwMTldpb/j3RFe1HhopxANB
	 68UwVzUzUNwXqyWwoDZjH4WP0tSbY1ThZwgRSdDk0ea5GMnp3epikBgeGNdTap5H7a
	 y6DiSPZzguJdZBFhMdeRnVh2iiIkEbaQb6PYBKlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388357AbfB1PNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:13:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388332AbfB1PNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:13:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 374232171F;
        Thu, 28 Feb 2019 15:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366778;
        bh=hXWid/96J/QYiS7AC2ekBNXXNQJGSSvgqkdvPMrCjgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=novksuc2xFDX/MtuoWyEBzMdgPyTT70NGCnVGQlOC0Bq8lepZw2YXlG99FxC3EnoP
         Z3PKtqRipemA4HNokBjqT+fokuuSfLBSCHgOtoc294HSIPZ5vclBO3kPLDmzWe6Cd5
         Z6bsb08beKYj1cr7XpKZASu5QJw1n/gtrUELV9U4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 47/64] arm64: ptdump: Don't iterate kernel page tables using PTRS_PER_PXX
Date:   Thu, 28 Feb 2019 10:10:48 -0500
Message-Id: <20190228151105.11277-47-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit d23c808c6fc6132e812690648e14c0d6b0cbe273 ]

When 52-bit virtual addressing is enabled for userspace
(CONFIG_ARM64_USER_VA_BITS_52=y), the kernel continues to utilise 48-bit
virtual addressing in TTBR1. Consequently, PTRS_PER_PGD reflects the
larger page table size for userspace and the pgd pointer for kernel page
tables is offset before being written to TTBR1.

This means that we can't use PTRS_PER_PGD to iterate over kernel page
tables unless we apply the same offset, which is fiddly to get right and
leads to some non-idiomatic walking code. Instead, just follow the usual
pattern when walking page tables by using a while loop driven by
pXd_offset() and pXd_addr_end().

Reported-by: Qian Cai <cai@lca.pw>
Tested-by: Qian Cai <cai@lca.pw>
Acked-by: Steve Capper <steve.capper@arm.com>
Tested-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/dump.c | 59 ++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 65dfc8571bf83..39ac622a2d72c 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -286,74 +286,73 @@ static void note_page(struct pg_state *st, unsigned long addr, unsigned level,
 
 }
 
-static void walk_pte(struct pg_state *st, pmd_t *pmdp, unsigned long start)
+static void walk_pte(struct pg_state *st, pmd_t *pmdp, unsigned long start,
+		     unsigned long end)
 {
-	pte_t *ptep = pte_offset_kernel(pmdp, 0UL);
-	unsigned long addr;
-	unsigned i;
+	unsigned long addr = start;
+	pte_t *ptep = pte_offset_kernel(pmdp, start);
 
-	for (i = 0; i < PTRS_PER_PTE; i++, ptep++) {
-		addr = start + i * PAGE_SIZE;
+	do {
 		note_page(st, addr, 4, READ_ONCE(pte_val(*ptep)));
-	}
+	} while (ptep++, addr += PAGE_SIZE, addr != end);
 }
 
-static void walk_pmd(struct pg_state *st, pud_t *pudp, unsigned long start)
+static void walk_pmd(struct pg_state *st, pud_t *pudp, unsigned long start,
+		     unsigned long end)
 {
-	pmd_t *pmdp = pmd_offset(pudp, 0UL);
-	unsigned long addr;
-	unsigned i;
+	unsigned long next, addr = start;
+	pmd_t *pmdp = pmd_offset(pudp, start);
 
-	for (i = 0; i < PTRS_PER_PMD; i++, pmdp++) {
+	do {
 		pmd_t pmd = READ_ONCE(*pmdp);
+		next = pmd_addr_end(addr, end);
 
-		addr = start + i * PMD_SIZE;
 		if (pmd_none(pmd) || pmd_sect(pmd)) {
 			note_page(st, addr, 3, pmd_val(pmd));
 		} else {
 			BUG_ON(pmd_bad(pmd));
-			walk_pte(st, pmdp, addr);
+			walk_pte(st, pmdp, addr, next);
 		}
-	}
+	} while (pmdp++, addr = next, addr != end);
 }
 
-static void walk_pud(struct pg_state *st, pgd_t *pgdp, unsigned long start)
+static void walk_pud(struct pg_state *st, pgd_t *pgdp, unsigned long start,
+		     unsigned long end)
 {
-	pud_t *pudp = pud_offset(pgdp, 0UL);
-	unsigned long addr;
-	unsigned i;
+	unsigned long next, addr = start;
+	pud_t *pudp = pud_offset(pgdp, start);
 
-	for (i = 0; i < PTRS_PER_PUD; i++, pudp++) {
+	do {
 		pud_t pud = READ_ONCE(*pudp);
+		next = pud_addr_end(addr, end);
 
-		addr = start + i * PUD_SIZE;
 		if (pud_none(pud) || pud_sect(pud)) {
 			note_page(st, addr, 2, pud_val(pud));
 		} else {
 			BUG_ON(pud_bad(pud));
-			walk_pmd(st, pudp, addr);
+			walk_pmd(st, pudp, addr, next);
 		}
-	}
+	} while (pudp++, addr = next, addr != end);
 }
 
 static void walk_pgd(struct pg_state *st, struct mm_struct *mm,
 		     unsigned long start)
 {
-	pgd_t *pgdp = pgd_offset(mm, 0UL);
-	unsigned i;
-	unsigned long addr;
+	unsigned long end = (start < TASK_SIZE_64) ? TASK_SIZE_64 : 0;
+	unsigned long next, addr = start;
+	pgd_t *pgdp = pgd_offset(mm, start);
 
-	for (i = 0; i < PTRS_PER_PGD; i++, pgdp++) {
+	do {
 		pgd_t pgd = READ_ONCE(*pgdp);
+		next = pgd_addr_end(addr, end);
 
-		addr = start + i * PGDIR_SIZE;
 		if (pgd_none(pgd)) {
 			note_page(st, addr, 1, pgd_val(pgd));
 		} else {
 			BUG_ON(pgd_bad(pgd));
-			walk_pud(st, pgdp, addr);
+			walk_pud(st, pgdp, addr, next);
 		}
-	}
+	} while (pgdp++, addr = next, addr != end);
 }
 
 void ptdump_walk_pgd(struct seq_file *m, struct ptdump_info *info)
-- 
2.19.1

