Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455AAC41514
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 05:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13525206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 05:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="eqy61oM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfHPFlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 01:41:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56499 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfHPFlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 01:41:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 468sdL5Y0Dz9tyNB;
        Fri, 16 Aug 2019 07:41:42 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=eqy61oM+; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ANlLqw9cc7wH; Fri, 16 Aug 2019 07:41:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 468sdL4Tt8z9tyN5;
        Fri, 16 Aug 2019 07:41:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565934102; bh=IOzXR83/2yIUIuhphrk6qopaUrL0F7OKCI3JBwQ7+O4=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=eqy61oM+shdErnJ6bB60zdpf5Rn0S1dn0c0Lb4Py5kMprQUt6YiqViT/WoOK6BuZs
         SavX+1DRgUriM3PXaRGgB5MAfiAcZuaue0sj0EMPgUNVq8ljx8Aw9XCvlqTS6vklVx
         KqNlI8hQEAYLY+2+Si+sMbahI1OMusz4vvVuWMew=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8A52C8B776;
        Fri, 16 Aug 2019 07:41:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hk_ClkD6lWck; Fri, 16 Aug 2019 07:41:43 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 66EC48B754;
        Fri, 16 Aug 2019 07:41:43 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 619696B6CC; Fri, 16 Aug 2019 05:41:43 +0000 (UTC)
Message-Id: <35f143c6fe29f9fd25c7f3cd4448ae401029ce3c.1565933217.git.christophe.leroy@c-s.fr>
In-Reply-To: <668aba4db6b9af6d8a151174e11a4289f1a6bbcd.1565933217.git.christophe.leroy@c-s.fr>
References: <668aba4db6b9af6d8a151174e11a4289f1a6bbcd.1565933217.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4/5] powerpc/mm: Simplify update_mmu_cache() on BOOK3S32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 16 Aug 2019 05:41:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On BOOK3S32, hash_preload() neither use is_exec nor trap,
so drop those parameters and simplify update_mmu_cached().

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/book3s32/mmu.c | 29 +++++++----------------------
 arch/powerpc/mm/mmu_decl.h     |  3 +--
 arch/powerpc/mm/pgtable_32.c   |  2 +-
 3 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 3e3c4077cdb7..3a62bf99f93f 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -297,8 +297,7 @@ void __init setbat(int index, unsigned long virt, phys_addr_t phys,
 /*
  * Preload a translation in the hash table
  */
-void hash_preload(struct mm_struct *mm, unsigned long ea,
-		  bool is_exec, unsigned long trap)
+void hash_preload(struct mm_struct *mm, unsigned long ea)
 {
 	pmd_t *pmd;
 
@@ -324,34 +323,20 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 	 * We don't need to worry about _PAGE_PRESENT here because we are
 	 * called with either mm->page_table_lock held or ptl lock held
 	 */
-	unsigned long trap;
-	bool is_exec;
 
 	/* We only want HPTEs for linux PTEs that have _PAGE_ACCESSED set */
 	if (!pte_young(*ptep) || address >= TASK_SIZE)
 		return;
 
-	/* We try to figure out if we are coming from an instruction
-	 * access fault and pass that down to __hash_page so we avoid
-	 * double-faulting on execution of fresh text. We have to test
-	 * for regs NULL since init will get here first thing at boot
-	 *
-	 * We also avoid filling the hash if not coming from a fault
-	 */
+	/* We have to test for regs NULL since init will get here first thing at boot */
+	if (!current->thread.regs)
+		return;
 
-	trap = current->thread.regs ? TRAP(current->thread.regs) : 0UL;
-	switch (trap) {
-	case 0x300:
-		is_exec = false;
-		break;
-	case 0x400:
-		is_exec = true;
-		break;
-	default:
+	/* We also avoid filling the hash if not coming from a fault */
+	if (TRAP(current->thread.regs) != 0x300 && TRAP(current->thread.regs) != 0x400)
 		return;
-	}
 
-	hash_preload(vma->vm_mm, address, is_exec, trap);
+	hash_preload(vma->vm_mm, address);
 }
 
 /*
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 9f325a7a09cb..adbaf2167214 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -91,8 +91,7 @@ void print_system_hash_info(void);
 
 #ifdef CONFIG_PPC32
 
-void hash_preload(struct mm_struct *mm, unsigned long ea,
-		  bool is_exec, unsigned long trap);
+void hash_preload(struct mm_struct *mm, unsigned long ea);
 
 extern void mapin_ram(void);
 extern void setbat(int index, unsigned long virt, phys_addr_t phys,
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 35cb96cfc258..97f401a06fcc 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -252,7 +252,7 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 		map_kernel_page(v, p, ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL);
 #ifdef CONFIG_PPC_BOOK3S_32
 		if (ktext)
-			hash_preload(&init_mm, v, false, 0x300);
+			hash_preload(&init_mm, v);
 #endif
 		v += PAGE_SIZE;
 		p += PAGE_SIZE;
-- 
2.13.3

