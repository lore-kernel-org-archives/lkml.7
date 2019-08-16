Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD6FC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 05:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C44206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 05:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="cUDbwxmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfHPFlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 01:41:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:65206 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfHPFlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 01:41:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 468sdK5MTVz9tygC;
        Fri, 16 Aug 2019 07:41:41 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=cUDbwxmI; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id kZIXMzfE904p; Fri, 16 Aug 2019 07:41:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 468sdK48V6z9txty;
        Fri, 16 Aug 2019 07:41:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565934101; bh=hPDRwP/t5hodba8/Vz+KiCO7ao8KQFePDmRxANiwlYE=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=cUDbwxmIPQFBXxNLTx8Fu1MYDWjKkFl+VjPluJd0LRHqtPrUFXODLd58k+MoZvE5E
         vgk4V2zYE1RNGwNdutpFWezSqgZ/h8+yK3YivlzcvWk2JAK73MenUudarPDmZZpCtT
         R2wlKFR3aW5RHZq7Z7zFBOG0XJeaFKh8N6h08gMw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 82D468B776;
        Fri, 16 Aug 2019 07:41:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vegnyFmmgLNP; Fri, 16 Aug 2019 07:41:42 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5FEBF8B754;
        Fri, 16 Aug 2019 07:41:42 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5B7E06B6CC; Fri, 16 Aug 2019 05:41:42 +0000 (UTC)
Message-Id: <107aaf43583a5f5d09e0d4e84c4c4390ecfcd512.1565933217.git.christophe.leroy@c-s.fr>
In-Reply-To: <668aba4db6b9af6d8a151174e11a4289f1a6bbcd.1565933217.git.christophe.leroy@c-s.fr>
References: <668aba4db6b9af6d8a151174e11a4289f1a6bbcd.1565933217.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 3/5] powerpc/mm: move update_mmu_cache() into book3s hash
 utils.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 16 Aug 2019 05:41:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_mmu_cache() is only for BOOK3S, and can be simplified
for BOOK3S32.

Move it out of mem.c into respective BOOK3S32 and BOOK3S64
files containing hash utils.

BOOK3S64 version of hash_preload() is only used locally,
declare it static.

Remove the radix_enabled() stuff in BOOK3S32 version.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/book3s32/mmu.c        | 45 +++++++++++++++++++++++++++++
 arch/powerpc/mm/book3s64/hash_utils.c | 54 +++++++++++++++++++++++++++++++++--
 arch/powerpc/mm/mem.c                 | 52 ---------------------------------
 arch/powerpc/mm/mmu_decl.h            |  7 ++---
 4 files changed, 100 insertions(+), 58 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index e249fbf6b9c3..3e3c4077cdb7 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -310,6 +310,51 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 }
 
 /*
+ * This is called at the end of handling a user page fault, when the
+ * fault has been handled by updating a PTE in the linux page tables.
+ * We use it to preload an HPTE into the hash table corresponding to
+ * the updated linux PTE.
+ *
+ * This must always be called with the pte lock held.
+ */
+void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
+		      pte_t *ptep)
+{
+	/*
+	 * We don't need to worry about _PAGE_PRESENT here because we are
+	 * called with either mm->page_table_lock held or ptl lock held
+	 */
+	unsigned long trap;
+	bool is_exec;
+
+	/* We only want HPTEs for linux PTEs that have _PAGE_ACCESSED set */
+	if (!pte_young(*ptep) || address >= TASK_SIZE)
+		return;
+
+	/* We try to figure out if we are coming from an instruction
+	 * access fault and pass that down to __hash_page so we avoid
+	 * double-faulting on execution of fresh text. We have to test
+	 * for regs NULL since init will get here first thing at boot
+	 *
+	 * We also avoid filling the hash if not coming from a fault
+	 */
+
+	trap = current->thread.regs ? TRAP(current->thread.regs) : 0UL;
+	switch (trap) {
+	case 0x300:
+		is_exec = false;
+		break;
+	case 0x400:
+		is_exec = true;
+		break;
+	default:
+		return;
+	}
+
+	hash_preload(vma->vm_mm, address, is_exec, trap);
+}
+
+/*
  * Initialize the hash table and patch the instructions in hashtable.S.
  */
 void __init MMU_init_hw(void)
diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index e6d471058597..fdad5bc07d79 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -1518,8 +1518,8 @@ static bool should_hash_preload(struct mm_struct *mm, unsigned long ea)
 }
 #endif
 
-void hash_preload(struct mm_struct *mm, unsigned long ea,
-		  bool is_exec, unsigned long trap)
+static void hash_preload(struct mm_struct *mm, unsigned long ea,
+			 bool is_exec, unsigned long trap)
 {
 	int hugepage_shift;
 	unsigned long vsid;
@@ -1599,6 +1599,56 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	local_irq_restore(flags);
 }
 
+/*
+ * This is called at the end of handling a user page fault, when the
+ * fault has been handled by updating a PTE in the linux page tables.
+ * We use it to preload an HPTE into the hash table corresponding to
+ * the updated linux PTE.
+ *
+ * This must always be called with the pte lock held.
+ */
+void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
+		      pte_t *ptep)
+{
+	/*
+	 * We don't need to worry about _PAGE_PRESENT here because we are
+	 * called with either mm->page_table_lock held or ptl lock held
+	 */
+	unsigned long trap;
+	bool is_exec;
+
+	if (radix_enabled()) {
+		prefetch((void *)address);
+		return;
+	}
+
+	/* We only want HPTEs for linux PTEs that have _PAGE_ACCESSED set */
+	if (!pte_young(*ptep) || address >= TASK_SIZE)
+		return;
+
+	/* We try to figure out if we are coming from an instruction
+	 * access fault and pass that down to __hash_page so we avoid
+	 * double-faulting on execution of fresh text. We have to test
+	 * for regs NULL since init will get here first thing at boot
+	 *
+	 * We also avoid filling the hash if not coming from a fault
+	 */
+
+	trap = current->thread.regs ? TRAP(current->thread.regs) : 0UL;
+	switch (trap) {
+	case 0x300:
+		is_exec = false;
+		break;
+	case 0x400:
+		is_exec = true;
+		break;
+	default:
+		return;
+	}
+
+	hash_preload(vma->vm_mm, address, is_exec, trap);
+}
+
 #ifdef CONFIG_PPC_MEM_KEYS
 /*
  * Return the protection key associated with the given address and the
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index c45d44538ddb..3e9e9a051c93 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -407,58 +407,6 @@ void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
 EXPORT_SYMBOL(flush_icache_user_range);
 
 /*
- * This is called at the end of handling a user page fault, when the
- * fault has been handled by updating a PTE in the linux page tables.
- * We use it to preload an HPTE into the hash table corresponding to
- * the updated linux PTE.
- * 
- * This must always be called with the pte lock held.
- */
-#ifdef CONFIG_PPC_BOOK3S
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
-		      pte_t *ptep)
-{
-	/*
-	 * We don't need to worry about _PAGE_PRESENT here because we are
-	 * called with either mm->page_table_lock held or ptl lock held
-	 */
-	unsigned long trap;
-	bool is_exec;
-
-	if (radix_enabled()) {
-		prefetch((void *)address);
-		return;
-	}
-
-	/* We only want HPTEs for linux PTEs that have _PAGE_ACCESSED set */
-	if (!pte_young(*ptep) || address >= TASK_SIZE)
-		return;
-
-	/* We try to figure out if we are coming from an instruction
-	 * access fault and pass that down to __hash_page so we avoid
-	 * double-faulting on execution of fresh text. We have to test
-	 * for regs NULL since init will get here first thing at boot
-	 *
-	 * We also avoid filling the hash if not coming from a fault
-	 */
-
-	trap = current->thread.regs ? TRAP(current->thread.regs) : 0UL;
-	switch (trap) {
-	case 0x300:
-		is_exec = false;
-		break;
-	case 0x400:
-		is_exec = true;
-		break;
-	default:
-		return;
-	}
-
-	hash_preload(vma->vm_mm, address, is_exec, trap);
-}
-#endif /* CONFIG_PPC_BOOK3S */
-
-/*
  * System memory should not be in /proc/iomem but various tools expect it
  * (eg kdump).
  */
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 32c1a191c28a..9f325a7a09cb 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -82,10 +82,6 @@ static inline void print_system_hash_info(void) {}
 
 #else /* CONFIG_PPC_MMU_NOHASH */
 
-extern void hash_preload(struct mm_struct *mm, unsigned long ea,
-			 bool is_exec, unsigned long trap);
-
-
 extern void _tlbie(unsigned long address);
 extern void _tlbia(void);
 
@@ -95,6 +91,9 @@ void print_system_hash_info(void);
 
 #ifdef CONFIG_PPC32
 
+void hash_preload(struct mm_struct *mm, unsigned long ea,
+		  bool is_exec, unsigned long trap);
+
 extern void mapin_ram(void);
 extern void setbat(int index, unsigned long virt, phys_addr_t phys,
 		   unsigned int size, pgprot_t prot);
-- 
2.13.3

