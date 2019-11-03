Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF81CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 12:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CBA20842
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 12:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="k94a7PKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfKCMhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 07:37:46 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:48260 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfKCMhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 07:37:45 -0500
Received: from grover.flets-west.jp (softbank126021098169.bbtec.net [126.21.98.169]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id xA3CaIVC018623;
        Sun, 3 Nov 2019 21:36:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com xA3CaIVC018623
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572784579;
        bh=iCIrgjy/jBJIf7jd88C0TplYGpd505IJ9u3iionPOJc=;
        h=From:To:Cc:Subject:Date:From;
        b=k94a7PKgsuhGwzrYW+HBq+d1x8NxPSysqFdJPm243dZ4BqqhP0dVDEZ0UtIFzcnqT
         xEqRRE3szsW3yOb82Kc+ne5P2W+rFpq3a6uLw0feK2WsLlWZmoa/3s/M1QMgWUmbSX
         f+w8mATLjKjscOy0aV6inAfVfJcsM7vlfUobBihxLdvtK2M6eKM4Rau8UcGqq/vHhc
         sZeS5Elo3QaFRcvLNxyfzLMmBQSdlOCUpMbUZx36H0y5XD12krQKATfIbyZxlbgMVp
         DsQfTYH2QMzY2WQZDEsovfM9aYvaAdoaV6VlWpQ8cLG+1nvWqsbaDONTDVTtSb/KwF
         c93WuDR7Jvt2w==
X-Nifty-SrcIP: [126.21.98.169]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        David Hildenbrand <david@redhat.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: mm: simplify the page end calculation in __create_pgd_mapping()
Date:   Sun,  3 Nov 2019 21:35:58 +0900
Message-Id: <20191103123559.8866-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate the page-aligned end address more simply.

The local variable, "length" is unneeded.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/mm/mmu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 60c929f3683b..a9f541912289 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -338,7 +338,7 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 				 phys_addr_t (*pgtable_alloc)(int),
 				 int flags)
 {
-	unsigned long addr, length, end, next;
+	unsigned long addr, end, next;
 	pgd_t *pgdp = pgd_offset_raw(pgdir, virt);
 
 	/*
@@ -350,9 +350,8 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 
 	phys &= PAGE_MASK;
 	addr = virt & PAGE_MASK;
-	length = PAGE_ALIGN(size + (virt & ~PAGE_MASK));
+	end = PAGE_ALIGN(virt + size);
 
-	end = addr + length;
 	do {
 		next = pgd_addr_end(addr, end);
 		alloc_init_pud(pgdp, addr, next, phys, prot, pgtable_alloc,
-- 
2.17.1

