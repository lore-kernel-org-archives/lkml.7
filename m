Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED4EC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294062173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DVfCDgS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfEILFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:05:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55395 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfEILFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:05:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x49B4El91516529
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 9 May 2019 04:04:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x49B4El91516529
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557399855;
        bh=BhaEi5a8+vBEhNAXXLXG3xv0CV1lMdgmtWTqzr2sqe4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=DVfCDgS26lpluQsIXtluCTFLUpApAcjqpB5A+OR5LBoeRfZTgSZWz8GZOSYA5OL5B
         nzDrAd/vhfbKJnY0BB+OgkY/PUS1VMkTddNANT+QOWQDGLhCXxvfCaEI1ty2EKbiRe
         xW3kTDYyIwj4Q/zQRuoe9I6pBc1elFt7oC2P8gkuiVIha0yHr8StwWmt4lqPCeiHSO
         tsnLUb5CU9/nyfxxPSem8H/MVfi624Q2QzeiAFotvl0AUysZlFzC5ptUloqQV2D6yS
         cODJH69hPbU4xHyyrhTmZBWdf8WKDexEudKjgsKQGTibdQ5kePpdEsVH19yP2xy/+s
         VhvxPsHYzpFfQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x49B4DI41516525;
        Thu, 9 May 2019 04:04:13 -0700
Date:   Thu, 9 May 2019 04:04:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Brijesh Singh <tipbot@zytor.com>
Message-ID: <tip-eccd906484d1cd4b5da00f093d678badb6f48f28@git.kernel.org>
Cc:     kirill.shutemov@linux.intel.com, mingo@kernel.org, bp@suse.de,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        brijesh.singh@amd.com, mingo@redhat.com, tglx@linutronix.de,
        dave.hansen@intel.com, dan.j.williams@intel.com, hpa@zytor.com,
        x86@kernel.org, luto@kernel.org, Thomas.Lendacky@amd.com
Reply-To: mingo@kernel.org, bp@suse.de, kirill.shutemov@linux.intel.com,
          luto@kernel.org, dan.j.williams@intel.com, brijesh.singh@amd.com,
          mingo@redhat.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, Thomas.Lendacky@amd.com, hpa@zytor.com,
          x86@kernel.org, dave.hansen@intel.com, tglx@linutronix.de
In-Reply-To: <20190417154102.22613-1-brijesh.singh@amd.com>
References: <20190417154102.22613-1-brijesh.singh@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Do not use set_{pud, pmd}_safe() when
 splitting a large page
Git-Commit-ID: eccd906484d1cd4b5da00f093d678badb6f48f28
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  eccd906484d1cd4b5da00f093d678badb6f48f28
Gitweb:     https://git.kernel.org/tip/eccd906484d1cd4b5da00f093d678badb6f48f28
Author:     Brijesh Singh <brijesh.singh@amd.com>
AuthorDate: Wed, 17 Apr 2019 15:41:17 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 8 May 2019 19:08:35 +0200

x86/mm: Do not use set_{pud, pmd}_safe() when splitting a large page

The commit

  0a9fe8ca844d ("x86/mm: Validate kernel_physical_mapping_init() PTE population")

triggers this warning in SEV guests:

  WARNING: CPU: 0 PID: 0 at arch/x86/include/asm/pgalloc.h:87 phys_pmd_init+0x30d/0x386
  Call Trace:
   kernel_physical_mapping_init+0xce/0x259
   early_set_memory_enc_dec+0x10f/0x160
   kvm_smp_prepare_boot_cpu+0x71/0x9d
   start_kernel+0x1c9/0x50b
   secondary_startup_64+0xa4/0xb0

A SEV guest calls kernel_physical_mapping_init() to clear the encryption
mask from an existing mapping. While doing so, it also splits large
pages into smaller.

To split a page, kernel_physical_mapping_init() allocates a new page and
updates the existing entry. The set_{pud,pmd}_safe() helpers trigger a
warning when updating an entry with a page in the present state.

Add a new kernel_physical_mapping_change() helper which uses the
non-safe variants of set_{pmd,pud,p4d}() and {pmd,pud,p4d}_populate()
routines when updating the entry.

Since kernel_physical_mapping_change() may replace an existing
entry with a new entry, the caller is responsible to flush
the TLB at the end. Change early_set_memory_enc_dec() to use
kernel_physical_mapping_change() when it wants to clear the memory
encryption mask from the page table entry.

 [ bp:
   - massage commit message.
   - flesh out comment according to dhansen's request.
   - align function arguments at opening brace. ]

Fixes: 0a9fe8ca844d ("x86/mm: Validate kernel_physical_mapping_init() PTE population")
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Acked-by:  Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190417154102.22613-1-brijesh.singh@amd.com
---
 arch/x86/mm/init_64.c     | 144 +++++++++++++++++++++++++++++++++-------------
 arch/x86/mm/mem_encrypt.c |  10 +++-
 arch/x86/mm/mm_internal.h |   3 +
 3 files changed, 114 insertions(+), 43 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index bccff68e3267..5cd125bd2a85 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -58,6 +58,37 @@
 
 #include "ident_map.c"
 
+#define DEFINE_POPULATE(fname, type1, type2, init)		\
+static inline void fname##_init(struct mm_struct *mm,		\
+		type1##_t *arg1, type2##_t *arg2, bool init)	\
+{								\
+	if (init)						\
+		fname##_safe(mm, arg1, arg2);			\
+	else							\
+		fname(mm, arg1, arg2);				\
+}
+
+DEFINE_POPULATE(p4d_populate, p4d, pud, init)
+DEFINE_POPULATE(pgd_populate, pgd, p4d, init)
+DEFINE_POPULATE(pud_populate, pud, pmd, init)
+DEFINE_POPULATE(pmd_populate_kernel, pmd, pte, init)
+
+#define DEFINE_ENTRY(type1, type2, init)			\
+static inline void set_##type1##_init(type1##_t *arg1,		\
+			type2##_t arg2, bool init)		\
+{								\
+	if (init)						\
+		set_##type1##_safe(arg1, arg2);			\
+	else							\
+		set_##type1(arg1, arg2);			\
+}
+
+DEFINE_ENTRY(p4d, p4d, init)
+DEFINE_ENTRY(pud, pud, init)
+DEFINE_ENTRY(pmd, pmd, init)
+DEFINE_ENTRY(pte, pte, init)
+
+
 /*
  * NOTE: pagetable_init alloc all the fixmap pagetables contiguous on the
  * physical space so we can cache the place of the first one and move
@@ -414,7 +445,7 @@ void __init cleanup_highmap(void)
  */
 static unsigned long __meminit
 phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
-	      pgprot_t prot)
+	      pgprot_t prot, bool init)
 {
 	unsigned long pages = 0, paddr_next;
 	unsigned long paddr_last = paddr_end;
@@ -432,7 +463,7 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PAGE_MASK, paddr_next,
 					     E820_TYPE_RESERVED_KERN))
-				set_pte_safe(pte, __pte(0));
+				set_pte_init(pte, __pte(0), init);
 			continue;
 		}
 
@@ -452,7 +483,7 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
 			pr_info("   pte=%p addr=%lx pte=%016lx\n", pte, paddr,
 				pfn_pte(paddr >> PAGE_SHIFT, PAGE_KERNEL).pte);
 		pages++;
-		set_pte_safe(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
+		set_pte_init(pte, pfn_pte(paddr >> PAGE_SHIFT, prot), init);
 		paddr_last = (paddr & PAGE_MASK) + PAGE_SIZE;
 	}
 
@@ -468,7 +499,7 @@ phys_pte_init(pte_t *pte_page, unsigned long paddr, unsigned long paddr_end,
  */
 static unsigned long __meminit
 phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
-	      unsigned long page_size_mask, pgprot_t prot)
+	      unsigned long page_size_mask, pgprot_t prot, bool init)
 {
 	unsigned long pages = 0, paddr_next;
 	unsigned long paddr_last = paddr_end;
@@ -487,7 +518,7 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PMD_MASK, paddr_next,
 					     E820_TYPE_RESERVED_KERN))
-				set_pmd_safe(pmd, __pmd(0));
+				set_pmd_init(pmd, __pmd(0), init);
 			continue;
 		}
 
@@ -496,7 +527,8 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 				spin_lock(&init_mm.page_table_lock);
 				pte = (pte_t *)pmd_page_vaddr(*pmd);
 				paddr_last = phys_pte_init(pte, paddr,
-							   paddr_end, prot);
+							   paddr_end, prot,
+							   init);
 				spin_unlock(&init_mm.page_table_lock);
 				continue;
 			}
@@ -524,19 +556,20 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 		if (page_size_mask & (1<<PG_LEVEL_2M)) {
 			pages++;
 			spin_lock(&init_mm.page_table_lock);
-			set_pte_safe((pte_t *)pmd,
-				pfn_pte((paddr & PMD_MASK) >> PAGE_SHIFT,
-					__pgprot(pgprot_val(prot) | _PAGE_PSE)));
+			set_pte_init((pte_t *)pmd,
+				     pfn_pte((paddr & PMD_MASK) >> PAGE_SHIFT,
+					     __pgprot(pgprot_val(prot) | _PAGE_PSE)),
+				     init);
 			spin_unlock(&init_mm.page_table_lock);
 			paddr_last = paddr_next;
 			continue;
 		}
 
 		pte = alloc_low_page();
-		paddr_last = phys_pte_init(pte, paddr, paddr_end, new_prot);
+		paddr_last = phys_pte_init(pte, paddr, paddr_end, new_prot, init);
 
 		spin_lock(&init_mm.page_table_lock);
-		pmd_populate_kernel_safe(&init_mm, pmd, pte);
+		pmd_populate_kernel_init(&init_mm, pmd, pte, init);
 		spin_unlock(&init_mm.page_table_lock);
 	}
 	update_page_count(PG_LEVEL_2M, pages);
@@ -551,7 +584,7 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
  */
 static unsigned long __meminit
 phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
-	      unsigned long page_size_mask)
+	      unsigned long page_size_mask, bool init)
 {
 	unsigned long pages = 0, paddr_next;
 	unsigned long paddr_last = paddr_end;
@@ -573,7 +606,7 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & PUD_MASK, paddr_next,
 					     E820_TYPE_RESERVED_KERN))
-				set_pud_safe(pud, __pud(0));
+				set_pud_init(pud, __pud(0), init);
 			continue;
 		}
 
@@ -583,7 +616,7 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 				paddr_last = phys_pmd_init(pmd, paddr,
 							   paddr_end,
 							   page_size_mask,
-							   prot);
+							   prot, init);
 				continue;
 			}
 			/*
@@ -610,9 +643,10 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 		if (page_size_mask & (1<<PG_LEVEL_1G)) {
 			pages++;
 			spin_lock(&init_mm.page_table_lock);
-			set_pte_safe((pte_t *)pud,
-				pfn_pte((paddr & PUD_MASK) >> PAGE_SHIFT,
-					PAGE_KERNEL_LARGE));
+			set_pte_init((pte_t *)pud,
+				     pfn_pte((paddr & PUD_MASK) >> PAGE_SHIFT,
+					     PAGE_KERNEL_LARGE),
+				     init);
 			spin_unlock(&init_mm.page_table_lock);
 			paddr_last = paddr_next;
 			continue;
@@ -620,10 +654,10 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 
 		pmd = alloc_low_page();
 		paddr_last = phys_pmd_init(pmd, paddr, paddr_end,
-					   page_size_mask, prot);
+					   page_size_mask, prot, init);
 
 		spin_lock(&init_mm.page_table_lock);
-		pud_populate_safe(&init_mm, pud, pmd);
+		pud_populate_init(&init_mm, pud, pmd, init);
 		spin_unlock(&init_mm.page_table_lock);
 	}
 
@@ -634,14 +668,15 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 
 static unsigned long __meminit
 phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
-	      unsigned long page_size_mask)
+	      unsigned long page_size_mask, bool init)
 {
 	unsigned long paddr_next, paddr_last = paddr_end;
 	unsigned long vaddr = (unsigned long)__va(paddr);
 	int i = p4d_index(vaddr);
 
 	if (!pgtable_l5_enabled())
-		return phys_pud_init((pud_t *) p4d_page, paddr, paddr_end, page_size_mask);
+		return phys_pud_init((pud_t *) p4d_page, paddr, paddr_end,
+				     page_size_mask, init);
 
 	for (; i < PTRS_PER_P4D; i++, paddr = paddr_next) {
 		p4d_t *p4d;
@@ -657,39 +692,34 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 					     E820_TYPE_RAM) &&
 			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
 					     E820_TYPE_RESERVED_KERN))
-				set_p4d_safe(p4d, __p4d(0));
+				set_p4d_init(p4d, __p4d(0), init);
 			continue;
 		}
 
 		if (!p4d_none(*p4d)) {
 			pud = pud_offset(p4d, 0);
-			paddr_last = phys_pud_init(pud, paddr,
-					paddr_end,
-					page_size_mask);
+			paddr_last = phys_pud_init(pud, paddr, paddr_end,
+						   page_size_mask, init);
 			continue;
 		}
 
 		pud = alloc_low_page();
 		paddr_last = phys_pud_init(pud, paddr, paddr_end,
-					   page_size_mask);
+					   page_size_mask, init);
 
 		spin_lock(&init_mm.page_table_lock);
-		p4d_populate_safe(&init_mm, p4d, pud);
+		p4d_populate_init(&init_mm, p4d, pud, init);
 		spin_unlock(&init_mm.page_table_lock);
 	}
 
 	return paddr_last;
 }
 
-/*
- * Create page table mapping for the physical memory for specific physical
- * addresses. The virtual and physical addresses have to be aligned on PMD level
- * down. It returns the last physical address mapped.
- */
-unsigned long __meminit
-kernel_physical_mapping_init(unsigned long paddr_start,
-			     unsigned long paddr_end,
-			     unsigned long page_size_mask)
+static unsigned long __meminit
+__kernel_physical_mapping_init(unsigned long paddr_start,
+			       unsigned long paddr_end,
+			       unsigned long page_size_mask,
+			       bool init)
 {
 	bool pgd_changed = false;
 	unsigned long vaddr, vaddr_start, vaddr_end, vaddr_next, paddr_last;
@@ -709,19 +739,22 @@ kernel_physical_mapping_init(unsigned long paddr_start,
 			p4d = (p4d_t *)pgd_page_vaddr(*pgd);
 			paddr_last = phys_p4d_init(p4d, __pa(vaddr),
 						   __pa(vaddr_end),
-						   page_size_mask);
+						   page_size_mask,
+						   init);
 			continue;
 		}
 
 		p4d = alloc_low_page();
 		paddr_last = phys_p4d_init(p4d, __pa(vaddr), __pa(vaddr_end),
-					   page_size_mask);
+					   page_size_mask, init);
 
 		spin_lock(&init_mm.page_table_lock);
 		if (pgtable_l5_enabled())
-			pgd_populate_safe(&init_mm, pgd, p4d);
+			pgd_populate_init(&init_mm, pgd, p4d, init);
 		else
-			p4d_populate_safe(&init_mm, p4d_offset(pgd, vaddr), (pud_t *) p4d);
+			p4d_populate_init(&init_mm, p4d_offset(pgd, vaddr),
+					  (pud_t *) p4d, init);
+
 		spin_unlock(&init_mm.page_table_lock);
 		pgd_changed = true;
 	}
@@ -732,6 +765,37 @@ kernel_physical_mapping_init(unsigned long paddr_start,
 	return paddr_last;
 }
 
+
+/*
+ * Create page table mapping for the physical memory for specific physical
+ * addresses. Note that it can only be used to populate non-present entries.
+ * The virtual and physical addresses have to be aligned on PMD level
+ * down. It returns the last physical address mapped.
+ */
+unsigned long __meminit
+kernel_physical_mapping_init(unsigned long paddr_start,
+			     unsigned long paddr_end,
+			     unsigned long page_size_mask)
+{
+	return __kernel_physical_mapping_init(paddr_start, paddr_end,
+					      page_size_mask, true);
+}
+
+/*
+ * This function is similar to kernel_physical_mapping_init() above with the
+ * exception that it uses set_{pud,pmd}() instead of the set_{pud,pte}_safe()
+ * when updating the mapping. The caller is responsible to flush the TLBs after
+ * the function returns.
+ */
+unsigned long __meminit
+kernel_physical_mapping_change(unsigned long paddr_start,
+			       unsigned long paddr_end,
+			       unsigned long page_size_mask)
+{
+	return __kernel_physical_mapping_init(paddr_start, paddr_end,
+					      page_size_mask, false);
+}
+
 #ifndef CONFIG_NUMA
 void __init initmem_init(void)
 {
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 385afa2b9e17..51f50a7a07ef 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -301,9 +301,13 @@ static int __init early_set_memory_enc_dec(unsigned long vaddr,
 		else
 			split_page_size_mask = 1 << PG_LEVEL_2M;
 
-		kernel_physical_mapping_init(__pa(vaddr & pmask),
-					     __pa((vaddr_end & pmask) + psize),
-					     split_page_size_mask);
+		/*
+		 * kernel_physical_mapping_change() does not flush the TLBs, so
+		 * a TLB flush is required after we exit from the for loop.
+		 */
+		kernel_physical_mapping_change(__pa(vaddr & pmask),
+					       __pa((vaddr_end & pmask) + psize),
+					       split_page_size_mask);
 	}
 
 	ret = 0;
diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
index 319bde386d5f..eeae142062ed 100644
--- a/arch/x86/mm/mm_internal.h
+++ b/arch/x86/mm/mm_internal.h
@@ -13,6 +13,9 @@ void early_ioremap_page_table_range_init(void);
 unsigned long kernel_physical_mapping_init(unsigned long start,
 					     unsigned long end,
 					     unsigned long page_size_mask);
+unsigned long kernel_physical_mapping_change(unsigned long start,
+					     unsigned long end,
+					     unsigned long page_size_mask);
 void zone_sizes_init(void);
 
 extern int after_bootmem;
