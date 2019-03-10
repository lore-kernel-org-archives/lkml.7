Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5EFC10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 01:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7506E206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 01:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oPNZFD0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCJBTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 20:19:11 -0500
Received: from mail-io1-f73.google.com ([209.85.166.73]:55625 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfCJBTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 20:19:11 -0500
Received: by mail-io1-f73.google.com with SMTP id l10so1271209iob.22
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 17:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0Yb2ivGv5k2eEZFqDaeb2AMWK/OeRIAqkI0UIANBdSk=;
        b=oPNZFD0u4/uhlNdesjj0nps43el+5vEaWETEUy12QTiHxMV+XS5yFbmZKISRtxFNG5
         dKWWoBBhXtJZPfcIT/oFsQor0CVaWiLlLS87tKNCYTv85G2XZg+Hv9r6tfnPFbIGY6Un
         SNGdRMg05dZskRUyqM2LIB5r6U28IbDBz5PJK/sgVrxMjBJtfSiF4GDger33PFbzQ3/V
         RdWI9nwiV6I7gLmISzKZ3dWTOEkVTwixb/Nob1jM7uiO4IABEGaAA33lL84qG5hGXKGb
         XMyAh6HfjdLukWrrG6lkqNzh+60rHUSwrcfxjOOObGKwXrTy2XupT/tlf5HU2vReBnn3
         ld9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0Yb2ivGv5k2eEZFqDaeb2AMWK/OeRIAqkI0UIANBdSk=;
        b=LtM+XlNIU3fNYskz+qu3afuR2yk2aKA70OBMV9FChtSE9n1WEbRJWlRSL6lThsII/m
         w52Ki9njM6x0i0TBb7+J/0AHZZyKVrfCY5j2GPyaND4oYopg/zyrdVAsM4qkaXmiGIBn
         0OTqoe2Xna3VPfbATAP3AztwAJNFDNqQ+AP8J5F4uiCLfbkmeZ5aFmn4HEmaFAIz2f5J
         XjyjSar+u1TeSvGyxf6w1xkzmfJY8DOLetPFc3yTu3cz03We93Q4v3GcuMDmTNN1vU9v
         GlvNL5FL9LhIrVPEx25P0hL6LgRbG9B2xyROcWajejijMXCj7s6AlIsUlrTEyGrJ7BPk
         JVmA==
X-Gm-Message-State: APjAAAWXyWnGVhnLcPCLvTq4vdRdJrOyE/FCw6qvi+HEiPYBEot9CcK4
        GfF/VJLI5gXBsfScKf+uWKfRYrRjl/4=
X-Google-Smtp-Source: APXvYqzb7py1oPWQlx4fRa9Z+HVEK1bN2fB0qOGJMFr6UeE7WrMjrMYMPcQraL6qYk6xnNQti0o0/6kxf8A=
X-Received: by 2002:a05:660c:484:: with SMTP id a4mr16369624itk.15.1552180749805;
 Sat, 09 Mar 2019 17:19:09 -0800 (PST)
Date:   Sat,  9 Mar 2019 18:19:04 -0700
In-Reply-To: <20190218231319.178224-1-yuzhao@google.com>
Message-Id: <20190310011906.254635-1-yuzhao@google.com>
Mime-Version: 1.0
References: <20190218231319.178224-1-yuzhao@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v3 1/3] arm64: mm: use appropriate ctors for page tables
From:   Yu Zhao <yuzhao@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For pte page, use pgtable_page_ctor(); for pmd page, use
pgtable_pmd_page_ctor(); and for the rest (pud, p4d and pgd),
don't use any.

For now, we don't select ARCH_ENABLE_SPLIT_PMD_PTLOCK and
pgtable_pmd_page_ctor() is a nop. When we do in patch 3, we
make sure pmd is not folded so we won't mistakenly call
pgtable_pmd_page_ctor() on pud or p4d.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/mm/mmu.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b6f5aa52ac67..f704b291f2c5 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -98,7 +98,7 @@ pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 }
 EXPORT_SYMBOL(phys_mem_access_prot);
 
-static phys_addr_t __init early_pgtable_alloc(void)
+static phys_addr_t __init early_pgtable_alloc(int shift)
 {
 	phys_addr_t phys;
 	void *ptr;
@@ -173,7 +173,7 @@ static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
 static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 				unsigned long end, phys_addr_t phys,
 				pgprot_t prot,
-				phys_addr_t (*pgtable_alloc)(void),
+				phys_addr_t (*pgtable_alloc)(int),
 				int flags)
 {
 	unsigned long next;
@@ -183,7 +183,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 	if (pmd_none(pmd)) {
 		phys_addr_t pte_phys;
 		BUG_ON(!pgtable_alloc);
-		pte_phys = pgtable_alloc();
+		pte_phys = pgtable_alloc(PAGE_SHIFT);
 		__pmd_populate(pmdp, pte_phys, PMD_TYPE_TABLE);
 		pmd = READ_ONCE(*pmdp);
 	}
@@ -207,7 +207,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 
 static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
 		     phys_addr_t phys, pgprot_t prot,
-		     phys_addr_t (*pgtable_alloc)(void), int flags)
+		     phys_addr_t (*pgtable_alloc)(int), int flags)
 {
 	unsigned long next;
 	pmd_t *pmdp;
@@ -245,7 +245,7 @@ static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
 static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 				unsigned long end, phys_addr_t phys,
 				pgprot_t prot,
-				phys_addr_t (*pgtable_alloc)(void), int flags)
+				phys_addr_t (*pgtable_alloc)(int), int flags)
 {
 	unsigned long next;
 	pud_t pud = READ_ONCE(*pudp);
@@ -257,7 +257,7 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 	if (pud_none(pud)) {
 		phys_addr_t pmd_phys;
 		BUG_ON(!pgtable_alloc);
-		pmd_phys = pgtable_alloc();
+		pmd_phys = pgtable_alloc(PMD_SHIFT);
 		__pud_populate(pudp, pmd_phys, PUD_TYPE_TABLE);
 		pud = READ_ONCE(*pudp);
 	}
@@ -293,7 +293,7 @@ static inline bool use_1G_block(unsigned long addr, unsigned long next,
 
 static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 			   phys_addr_t phys, pgprot_t prot,
-			   phys_addr_t (*pgtable_alloc)(void),
+			   phys_addr_t (*pgtable_alloc)(int),
 			   int flags)
 {
 	unsigned long next;
@@ -303,7 +303,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 	if (pgd_none(pgd)) {
 		phys_addr_t pud_phys;
 		BUG_ON(!pgtable_alloc);
-		pud_phys = pgtable_alloc();
+		pud_phys = pgtable_alloc(PUD_SHIFT);
 		__pgd_populate(pgdp, pud_phys, PUD_TYPE_TABLE);
 		pgd = READ_ONCE(*pgdp);
 	}
@@ -344,7 +344,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 				 unsigned long virt, phys_addr_t size,
 				 pgprot_t prot,
-				 phys_addr_t (*pgtable_alloc)(void),
+				 phys_addr_t (*pgtable_alloc)(int),
 				 int flags)
 {
 	unsigned long addr, length, end, next;
@@ -370,11 +370,23 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 	} while (pgdp++, addr = next, addr != end);
 }
 
-static phys_addr_t pgd_pgtable_alloc(void)
+static phys_addr_t pgd_pgtable_alloc(int shift)
 {
 	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
-	if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
-		BUG();
+	BUG_ON(!ptr);
+
+	/*
+	 * Call proper page table ctor in case later we need to
+	 * call core mm functions like apply_to_page_range() on
+	 * this pre-allocated page table.
+	 *
+	 * We don't select ARCH_ENABLE_SPLIT_PMD_PTLOCK if pmd is
+	 * folded, and if so pgtable_pmd_page_ctor() becomes nop.
+	 */
+	if (shift == PAGE_SHIFT)
+		BUG_ON(!pgtable_page_ctor(virt_to_page(ptr)));
+	else if (shift == PMD_SHIFT)
+		BUG_ON(!pgtable_pmd_page_ctor(virt_to_page(ptr)));
 
 	/* Ensure the zeroed page is visible to the page table walker */
 	dsb(ishst);
-- 
2.21.0.360.g471c308f928-goog

