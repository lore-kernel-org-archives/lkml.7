Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FD0C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74972067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="nmgokblF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfHMULz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 16:11:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:12883 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbfHMULo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 16:11:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 467P4Z4ZXJz9v0CT;
        Tue, 13 Aug 2019 22:11:42 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=nmgokblF; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id J1jHv429O_Ri; Tue, 13 Aug 2019 22:11:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 467P4Z3X0jz9v0CM;
        Tue, 13 Aug 2019 22:11:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565727102; bh=sZz+4/QPH3BrIuv33OaUl5OUR8G7POTQoxTtzjOGeLc=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=nmgokblFz2b0J04VERTZs3bWDU4ADDjRGaa3DMzyJoHEaXBgX9zggMb7wwu3K1yog
         8nPeyar6VvSHFcj2geMWb7rdemUj3/i6+KJg3Y/rYm4NXpwRqlNzodl8Ni0eWOP2W0
         DeT//4jT2uqUiINlXttWnN8mCxsLT7gWdOIlFcw4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9B1638B7F2;
        Tue, 13 Aug 2019 22:11:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fvQfPSgScDAj; Tue, 13 Aug 2019 22:11:42 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5513F8B7F0;
        Tue, 13 Aug 2019 22:11:42 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 33B6F69632; Tue, 13 Aug 2019 20:11:42 +0000 (UTC)
Message-Id: <6aab930b3791d722784bada7e975a8d9504e7753.1565726867.git.christophe.leroy@c-s.fr>
In-Reply-To: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
References: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 09/10] powerpc/mm: make __ioremap_caller() common to PPC32
 and PPC64
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 13 Aug 2019 20:11:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__ioremap_caller() do the same thing. Define a common one.

__ioremap() is not reused because most of the tests included in
it are unnecessary when coming from __ioremap_caller()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/ioremap.c    | 99 ++++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/pgtable_32.c | 75 ---------------------------------
 arch/powerpc/mm/pgtable_64.c | 61 ---------------------------
 3 files changed, 99 insertions(+), 136 deletions(-)

diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
index 889ee656cf64..537c9148cea1 100644
--- a/arch/powerpc/mm/ioremap.c
+++ b/arch/powerpc/mm/ioremap.c
@@ -76,6 +76,105 @@ void __iomem *ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long f
 }
 EXPORT_SYMBOL(ioremap_prot);
 
+int __weak ioremap_range(unsigned long ea, phys_addr_t pa, unsigned long size,
+			 pgprot_t prot, int nid)
+{
+	unsigned long i;
+
+	for (i = 0; i < size; i += PAGE_SIZE) {
+		int err = map_kernel_page(ea + i, pa + i, prot);
+
+		if (err) {
+			if (slab_is_available())
+				unmap_kernel_range(ea, size);
+			else
+				WARN_ON_ONCE(1); /* Should clean up */
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+void __iomem *__ioremap_caller(phys_addr_t addr, unsigned long size,
+			       pgprot_t prot, void *caller)
+{
+	phys_addr_t pa = addr & PAGE_MASK;
+	int ret;
+	unsigned long va;
+
+	size = PAGE_ALIGN(addr + size) - pa;
+
+#ifdef CONFIG_PPC64
+	/* We don't support the 4K PFN hack with ioremap */
+	if (pgprot_val(prot) & H_PAGE_4K_PFN)
+		return NULL;
+#else
+	/*
+	 * If the address lies within the first 16 MB, assume it's in ISA
+	 * memory space
+	 */
+	if (pa < SZ_16M)
+		pa += _ISA_MEM_BASE;
+
+#ifndef CONFIG_CRASH_DUMP
+	/*
+	 * Don't allow anybody to remap normal RAM that we're using.
+	 * mem_init() sets high_memory so only do the check after that.
+	 */
+	if (slab_is_available() && pa <= virt_to_phys(high_memory - 1) &&
+	    page_is_ram(__phys_to_pfn(pa))) {
+		pr_err("%s(): phys addr 0x%llx is RAM lr %ps\n", __func__,
+		       (unsigned long long)pa, __builtin_return_address(0));
+		return NULL;
+	}
+#endif
+#endif /* CONFIG_PPC64 */
+
+	if (size == 0 || pa == 0)
+		return NULL;
+
+	/*
+	 * Is it already mapped?  Perhaps overlapped by a previous
+	 * mapping.
+	 */
+	va = p_block_mapped(pa);
+	if (va)
+		return (void __iomem *)va + (addr & ~PAGE_MASK);
+
+	/*
+	 * Choose an address to map it to.
+	 * Once the vmalloc system is running, we use it.
+	 * Before that, we map using addresses going
+	 * down from ioremap_bot.  vmalloc will use
+	 * the addresses from IOREMAP_BASE through
+	 * ioremap_bot
+	 *
+	 */
+	if (slab_is_available()) {
+		struct vm_struct *area;
+
+		area = __get_vm_area_caller(size, VM_IOREMAP, IOREMAP_BASE,
+					    ioremap_bot, caller);
+		if (area == NULL)
+			return NULL;
+
+		area->phys_addr = pa;
+		va = (unsigned long)area->addr;
+	} else {
+		ioremap_bot -= size;
+		va = ioremap_bot;
+	}
+	ret = ioremap_range(va, pa, size, prot, NUMA_NO_NODE);
+	if (!ret)
+		return (void __iomem *)va + (addr & ~PAGE_MASK);
+
+	if (!slab_is_available())
+		ioremap_bot += size;
+
+	return NULL;
+}
+
 /*
  * Unmap an IO region and remove it from vmalloc'd list.
  * Access to IO memory should be serialized by driver.
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 4597f45e4dc6..bacf3b85191c 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -35,81 +35,6 @@
 
 extern char etext[], _stext[], _sinittext[], _einittext[];
 
-void __iomem *
-__ioremap_caller(phys_addr_t addr, unsigned long size, pgprot_t prot, void *caller)
-{
-	unsigned long v, i;
-	phys_addr_t p;
-	int err;
-
-	/*
-	 * Choose an address to map it to.
-	 * Once the vmalloc system is running, we use it.
-	 * Before then, we use space going down from IOREMAP_TOP
-	 * (ioremap_bot records where we're up to).
-	 */
-	p = addr & PAGE_MASK;
-	size = PAGE_ALIGN(addr + size) - p;
-
-	/*
-	 * If the address lies within the first 16 MB, assume it's in ISA
-	 * memory space
-	 */
-	if (p < 16*1024*1024)
-		p += _ISA_MEM_BASE;
-
-#ifndef CONFIG_CRASH_DUMP
-	/*
-	 * Don't allow anybody to remap normal RAM that we're using.
-	 * mem_init() sets high_memory so only do the check after that.
-	 */
-	if (slab_is_available() && p <= virt_to_phys(high_memory - 1) &&
-	    page_is_ram(__phys_to_pfn(p))) {
-		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
-		       (unsigned long long)p, __builtin_return_address(0));
-		return NULL;
-	}
-#endif
-
-	if (size == 0)
-		return NULL;
-
-	/*
-	 * Is it already mapped?  Perhaps overlapped by a previous
-	 * mapping.
-	 */
-	v = p_block_mapped(p);
-	if (v)
-		goto out;
-
-	if (slab_is_available()) {
-		struct vm_struct *area;
-		area = get_vm_area_caller(size, VM_IOREMAP, caller);
-		if (area == 0)
-			return NULL;
-		area->phys_addr = p;
-		v = (unsigned long) area->addr;
-	} else {
-		v = (ioremap_bot -= size);
-	}
-
-	/*
-	 * Should check if it is a candidate for a BAT mapping
-	 */
-
-	err = 0;
-	for (i = 0; i < size && err == 0; i += PAGE_SIZE)
-		err = map_kernel_page(v + i, p + i, prot);
-	if (err) {
-		if (slab_is_available())
-			vunmap((void *)v);
-		return NULL;
-	}
-
-out:
-	return (void __iomem *) (v + ((unsigned long)addr & ~PAGE_MASK));
-}
-
 static void __init *early_alloc_pgtable(unsigned long size)
 {
 	void *ptr = memblock_alloc(size, size);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 32220f7381d7..781263df9f5e 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -101,67 +101,6 @@ unsigned long __pte_frag_size_shift;
 EXPORT_SYMBOL(__pte_frag_size_shift);
 #endif
 
-int __weak ioremap_range(unsigned long ea, phys_addr_t pa, unsigned long size, pgprot_t prot, int nid)
-{
-	unsigned long i;
-
-	for (i = 0; i < size; i += PAGE_SIZE) {
-		int err = map_kernel_page(ea + i, pa + i, prot);
-		if (err) {
-			if (slab_is_available())
-				unmap_kernel_range(ea, size);
-			else
-				WARN_ON_ONCE(1); /* Should clean up */
-			return err;
-		}
-	}
-
-	return 0;
-}
-
-void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
-				pgprot_t prot, void *caller)
-{
-	phys_addr_t paligned;
-	void __iomem *ret;
-
-	/*
-	 * Choose an address to map it to.
-	 * Once the vmalloc system is running, we use it.
-	 * Before that, we map using addresses going
-	 * down from ioremap_bot.  vmalloc will use
-	 * the addresses from IOREMAP_BASE through
-	 * ioremap_bot
-	 * 
-	 */
-	paligned = addr & PAGE_MASK;
-	size = PAGE_ALIGN(addr + size) - paligned;
-
-	if ((size == 0) || (paligned == 0))
-		return NULL;
-
-	if (slab_is_available()) {
-		struct vm_struct *area;
-
-		area = __get_vm_area_caller(size, VM_IOREMAP,
-					    IOREMAP_BASE, ioremap_bot,
-					    caller);
-		if (area == NULL)
-			return NULL;
-
-		area->phys_addr = paligned;
-		ret = __ioremap_at(paligned, area->addr, size, prot);
-	} else {
-		ret = __ioremap_at(paligned, (void *)ioremap_bot - size, size, prot);
-		if (ret)
-			ioremap_bot -= size;
-	}
-
-	if (ret)
-		ret += addr & ~PAGE_MASK;
-	return ret;
-}
-
 #ifndef __PAGETABLE_PUD_FOLDED
 /* 4 level page table */
 struct page *pgd_page(pgd_t pgd)
-- 
2.13.3

