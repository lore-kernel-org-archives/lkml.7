Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC65C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEDC20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="P+q9EXk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbfJITHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 15:07:11 -0400
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:37260 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728804AbfJITHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:07:11 -0400
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Oct 2019 15:07:10 EDT
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1B40BC04D5;
        Wed,  9 Oct 2019 18:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1570647460; bh=MgRIVfEAJ94OkyjrBQhZFPU5pG5MPCWR3XI6euyMrTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+q9EXk90lZx9V+thbZSLXi49Y0ooOEh5vUOV8p3jhCTwLzIHl/RZ7ohsPJYil6S5
         MX+hMG6F8kJl+0eeDQWxtLCi/cwYPeHsOOdRGya1RISfM9OIOB2RQrkk1GecY+QMjj
         a/2Pn0fH8yKHPvi1RFOqc+3/3N4OND0/sYKMktnctjKSxiyuv6ceGCKkkh4dSwi6z/
         PayIEkKnBy3eEQxM10ruy0N3aFHd8dQOnMMvL5skgVWo+Wkdb7TJKBlw7Idw7ra3Qn
         nAiX1/VYXOy14er8uHy08AgCTMs9si1hkMijKYZ1o7w0ezfl4kf6mwUKW4hgYHc6SR
         jZs8RKEqLqEog==
Received: from vineetg-Latitude-E7450.internal.synopsys.com (vineetg-latitude-e7450.internal.synopsys.com [10.10.161.61])
        by mailhost.synopsys.com (Postfix) with ESMTP id 93B7EA006B;
        Wed,  9 Oct 2019 18:57:33 +0000 (UTC)
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v3] ARC: mm: remove __ARCH_USE_5LEVEL_HACK
Date:   Wed,  9 Oct 2019 11:57:31 -0700
Message-Id: <20191009185731.25814-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009184350.18323-1-vgupta@synopsys.com>
References: <20191009184350.18323-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the intermediate p4d accessors to make it 5 level compliant.

This is a non-functional change anyways since ARC has software page walker
with 2 lookup levels (pgd -> pte)

There is slight code bloat due to pulling in needless p*d_free_tlb()
macros which needs to be addressed seperately.

| bloat-o-meter2 vmlinux-with-5LEVEL_HACK vmlinux-patched
| add/remove: 0/0 grow/shrink: 2/0 up/down: 128/0 (128)
| function                                     old     new   delta
| free_pgd_range                               546     656    +110
| p4d_clear_bad                                  2      20     +18
| Total: Before=4137148, After=4137276, chg 0.000000%

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
v3 <- v2
  - fix highmem build error

v2 <- v1
 - fix highmem code
---
 arch/arc/include/asm/pgtable.h |  1 -
 arch/arc/mm/fault.c            | 10 ++++++++--
 arch/arc/mm/highmem.c          |  4 +++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arc/include/asm/pgtable.h b/arch/arc/include/asm/pgtable.h
index 976b5931372e..902d45428cea 100644
--- a/arch/arc/include/asm/pgtable.h
+++ b/arch/arc/include/asm/pgtable.h
@@ -33,7 +33,6 @@
 #define _ASM_ARC_PGTABLE_H
 
 #include <linux/bits.h>
-#define __ARCH_USE_5LEVEL_HACK
 #include <asm-generic/pgtable-nopmd.h>
 #include <asm/page.h>
 #include <asm/mmu.h>	/* to propagate CONFIG_ARC_MMU_VER <n> */
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 3861543b66a0..fb86bc3e9b35 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -30,6 +30,7 @@ noinline static int handle_kernel_vaddr_fault(unsigned long address)
 	 * with the 'reference' page table.
 	 */
 	pgd_t *pgd, *pgd_k;
+	p4d_t *p4d, *p4d_k;
 	pud_t *pud, *pud_k;
 	pmd_t *pmd, *pmd_k;
 
@@ -39,8 +40,13 @@ noinline static int handle_kernel_vaddr_fault(unsigned long address)
 	if (!pgd_present(*pgd_k))
 		goto bad_area;
 
-	pud = pud_offset(pgd, address);
-	pud_k = pud_offset(pgd_k, address);
+	p4d = p4d_offset(pgd, address);
+	p4d_k = p4d_offset(pgd_k, address);
+	if (!p4d_present(*p4d_k))
+		goto bad_area;
+
+	pud = pud_offset(p4d, address);
+	pud_k = pud_offset(p4d_k, address);
 	if (!pud_present(*pud_k))
 		goto bad_area;
 
diff --git a/arch/arc/mm/highmem.c b/arch/arc/mm/highmem.c
index a4856bfaedf3..fc8849e4f72e 100644
--- a/arch/arc/mm/highmem.c
+++ b/arch/arc/mm/highmem.c
@@ -111,12 +111,14 @@ EXPORT_SYMBOL(__kunmap_atomic);
 static noinline pte_t * __init alloc_kmap_pgtable(unsigned long kvaddr)
 {
 	pgd_t *pgd_k;
+	p4d_t *p4d_k;
 	pud_t *pud_k;
 	pmd_t *pmd_k;
 	pte_t *pte_k;
 
 	pgd_k = pgd_offset_k(kvaddr);
-	pud_k = pud_offset(pgd_k, kvaddr);
+	p4d_k = p4d_offset(pgd_k, kvaddr);
+	pud_k = pud_offset(p4d_k, kvaddr);
 	pmd_k = pmd_offset(pud_k, kvaddr);
 
 	pte_k = (pte_t *)memblock_alloc_low(PAGE_SIZE, PAGE_SIZE);
-- 
2.20.1

