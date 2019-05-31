Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B417C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDB7261F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="YfySRIOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfEaB3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 21:29:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36272 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfEaB3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 21:29:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id u22so5096007pfm.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 18:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=f4gRzIGXi1mDc2FtVSWstZVWHsOvGLa5d9X0R30VsDM=;
        b=YfySRIObbbtvlWxhE+IzUYvZd67NDkLLv0L5Tz1QEVnBoLt+kZ4NQFKm/qvV/341rs
         eSyjAB03T5wumOhyF/8B3C3/tDV/w86LoY5xaC2bVnzLMoWm2OQySAp15k5BAwsGlPE8
         4AbsxneXmd254FDShLIfdPC9yNvS1i2pzNsac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=f4gRzIGXi1mDc2FtVSWstZVWHsOvGLa5d9X0R30VsDM=;
        b=OvAgrF/GxK8CAeYbQQb2aCeleo4v1vl/L8YFkELzfgK7oxVXL5RBXKdE210YlYh5hP
         eAk0cVX7xv9mCGq29zhQlZuuVHqkVQUfCT+FDKFDRn7FlSvDxGNyjrWAx/VQ+xtOpqQK
         XWZJBz6/qxDLF5pUEikA+ezSNmErzfO68qBBo554VNEALwIzghU7RVEB9G/o33x+2/Dy
         7NLEmAbus74zrUinHhO83OqzZtCAY1NrkCkwHN7EOdhzBN/8AMnqG/U/YyfdPwYhlP2K
         uPQoEkwXAByy3KmYaPjRxubBFJ+FjVDrgQAraDEXOQK2UpSnpM7zcWEFVJ3VweWRGUHQ
         jepg==
X-Gm-Message-State: APjAAAWUNcLZIceQrT9UiOwrx5Il5aij9sxzCtHgwQVIpJU0Mkyr/aus
        7Zwgwp4R5Bzv/4VhCnduncU5t7hflj8=
X-Google-Smtp-Source: APXvYqyuG8+K93SRp9Q4zP7GaBPMHetIbjJP6dg2yQSblvYwWaXI/X/WAbFBfORCA3uw9A9/7BpWmQ==
X-Received: by 2002:a63:9d09:: with SMTP id i9mr6152255pgd.195.1559266175663;
        Thu, 30 May 2019 18:29:35 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id s1sm2682489pgp.94.2019.05.30.18.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 18:29:34 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] powerpc/book3e: KASAN Full support for 64bit
In-Reply-To: <3401648225001077db54172ee87573b21e1cfa38.1553782837.git.christophe.leroy@c-s.fr>
References: <3401648225001077db54172ee87573b21e1cfa38.1553782837.git.christophe.leroy@c-s.fr>
Date:   Fri, 31 May 2019 11:29:29 +1000
Message-ID: <877ea7za12.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

I tried this on the t4240rdb and it fails to boot if KASAN is
enabled. It does boot with the patch applied but KASAN disabled, so that
narrows it down a little bit.

I need to focus on 3s first so I'll just drop 3e from my patch set for
now.

Regards,
Daniel

> The KASAN shadow area is mapped into vmemmap space:
> 0x8000 0400 0000 0000 to 0x8000 0600 0000 0000.
> For this vmemmap has to be disabled.
>
> Cc: Daniel Axtens <dja@axtens.net>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/Kconfig                  |   1 +
>  arch/powerpc/Kconfig.debug            |   3 +-
>  arch/powerpc/include/asm/kasan.h      |  11 +++
>  arch/powerpc/kernel/Makefile          |   2 +
>  arch/powerpc/kernel/head_64.S         |   3 +
>  arch/powerpc/kernel/setup_64.c        |  20 +++---
>  arch/powerpc/mm/kasan/Makefile        |   1 +
>  arch/powerpc/mm/kasan/kasan_init_64.c | 129 ++++++++++++++++++++++++++++++++++
>  8 files changed, 159 insertions(+), 11 deletions(-)
>  create mode 100644 arch/powerpc/mm/kasan/kasan_init_64.c
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 1a2fb50126b2..e0b7c45e4dc7 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -174,6 +174,7 @@ config PPC
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_JUMP_LABEL
>  	select HAVE_ARCH_KASAN			if PPC32
> +	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64 && !SPARSEMEM_VMEMMAP
>  	select HAVE_ARCH_KGDB
>  	select HAVE_ARCH_MMAP_RND_BITS
>  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 61febbbdd02b..b4140dd6b4e4 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -370,4 +370,5 @@ config PPC_FAST_ENDIAN_SWITCH
>  config KASAN_SHADOW_OFFSET
>  	hex
>  	depends on KASAN
> -	default 0xe0000000
> +	default 0xe0000000 if PPC32
> +	default 0x6800040000000000 if PPC64
> diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
> index 296e51c2f066..756b3d58f921 100644
> --- a/arch/powerpc/include/asm/kasan.h
> +++ b/arch/powerpc/include/asm/kasan.h
> @@ -23,10 +23,21 @@
>  
>  #define KASAN_SHADOW_OFFSET	ASM_CONST(CONFIG_KASAN_SHADOW_OFFSET)
>  
> +#ifdef CONFIG_PPC32
>  #define KASAN_SHADOW_END	0UL
>  
>  #define KASAN_SHADOW_SIZE	(KASAN_SHADOW_END - KASAN_SHADOW_START)
>  
> +#else
> +
> +#include <asm/pgtable.h>
> +
> +#define KASAN_SHADOW_SIZE	(KERN_VIRT_SIZE >> KASAN_SHADOW_SCALE_SHIFT)
> +
> +#define KASAN_SHADOW_END	(KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
> +
> +#endif /* CONFIG_PPC32 */
> +
>  #ifdef CONFIG_KASAN
>  void kasan_early_init(void);
>  void kasan_mmu_init(void);
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 0ea6c4aa3a20..7f232c06f11d 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -35,6 +35,8 @@ KASAN_SANITIZE_early_32.o := n
>  KASAN_SANITIZE_cputable.o := n
>  KASAN_SANITIZE_prom_init.o := n
>  KASAN_SANITIZE_btext.o := n
> +KASAN_SANITIZE_paca.o := n
> +KASAN_SANITIZE_setup_64.o := n
>  
>  ifdef CONFIG_KASAN
>  CFLAGS_early_32.o += -DDISABLE_BRANCH_PROFILING
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 3fad8d499767..80fbd8024fb2 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -966,6 +966,9 @@ start_here_multiplatform:
>  	 * and SLB setup before we turn on relocation.
>  	 */
>  
> +#ifdef CONFIG_KASAN
> +	bl	kasan_early_init
> +#endif
>  	/* Restore parameters passed from prom_init/kexec */
>  	mr	r3,r31
>  	bl	early_setup		/* also sets r13 and SPRG_PACA */
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index ba404dd9ce1d..d2bf860dd966 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -311,6 +311,16 @@ void __init early_setup(unsigned long dt_ptr)
>   	DBG(" -> early_setup(), dt_ptr: 0x%lx\n", dt_ptr);
>  
>  	/*
> +	 * Configure exception handlers. This include setting up trampolines
> +	 * if needed, setting exception endian mode, etc...
> +	 */
> +	configure_exceptions();
> +
> +	/* Apply all the dynamic patching */
> +	apply_feature_fixups();
> +	setup_feature_keys();
> +
> +	/*
>  	 * Do early initialization using the flattened device
>  	 * tree, such as retrieving the physical memory map or
>  	 * calculating/retrieving the hash table size.
> @@ -325,16 +335,6 @@ void __init early_setup(unsigned long dt_ptr)
>  	setup_paca(paca_ptrs[boot_cpuid]);
>  	fixup_boot_paca();
>  
> -	/*
> -	 * Configure exception handlers. This include setting up trampolines
> -	 * if needed, setting exception endian mode, etc...
> -	 */
> -	configure_exceptions();
> -
> -	/* Apply all the dynamic patching */
> -	apply_feature_fixups();
> -	setup_feature_keys();
> -
>  	/* Initialize the hash table or TLB handling */
>  	early_init_mmu();
>  
> diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
> index 6577897673dd..0bfbe3892808 100644
> --- a/arch/powerpc/mm/kasan/Makefile
> +++ b/arch/powerpc/mm/kasan/Makefile
> @@ -3,3 +3,4 @@
>  KASAN_SANITIZE := n
>  
>  obj-$(CONFIG_PPC32)           += kasan_init_32.o
> +obj-$(CONFIG_PPC64)	+= kasan_init_64.o
> diff --git a/arch/powerpc/mm/kasan/kasan_init_64.c b/arch/powerpc/mm/kasan/kasan_init_64.c
> new file mode 100644
> index 000000000000..7fd71b8e883b
> --- /dev/null
> +++ b/arch/powerpc/mm/kasan/kasan_init_64.c
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define DISABLE_BRANCH_PROFILING
> +
> +#include <linux/kasan.h>
> +#include <linux/printk.h>
> +#include <linux/memblock.h>
> +#include <linux/sched/task.h>
> +#include <asm/pgalloc.h>
> +
> +static void __init kasan_populate_pte(pte_t *ptep, pgprot_t prot)
> +{
> +	unsigned long va = (unsigned long)kasan_early_shadow_page;
> +	phys_addr_t pa = __pa(kasan_early_shadow_page);
> +	int i;
> +
> +	for (i = 0; i < PTRS_PER_PTE; i++, ptep++)
> +		__set_pte_at(&init_mm, va, ptep, pfn_pte(PHYS_PFN(pa), prot), 0);
> +}
> +
> +static void __init kasan_populate_pmd(pmd_t *pmdp)
> +{
> +	int i;
> +
> +	for (i = 0; i < PTRS_PER_PMD; i++)
> +		pmd_populate_kernel(&init_mm, pmdp + i, kasan_early_shadow_pte);
> +}
> +
> +static void __init kasan_populate_pud(pud_t *pudp)
> +{
> +	int i;
> +
> +	for (i = 0; i < PTRS_PER_PUD; i++)
> +		pud_populate(&init_mm, pudp + i, kasan_early_shadow_pmd);
> +}
> +
> +static void __init *kasan_alloc_pgtable(unsigned long size)
> +{
> +	void *ptr = memblock_alloc_try_nid(size, size, MEMBLOCK_LOW_LIMIT,
> +					   __pa(MAX_DMA_ADDRESS), NUMA_NO_NODE);
> +
> +	if (!ptr)
> +		panic("%s: Failed to allocate %lu bytes align=0x%lx max_addr=%lx\n",
> +		      __func__, size, size, __pa(MAX_DMA_ADDRESS));
> +
> +	return ptr;
> +}
> +
> +static int __init kasan_map_page(unsigned long va, unsigned long pa, pgprot_t prot)
> +{
> +	pgd_t *pgdp = pgd_offset_k(va);
> +	pud_t *pudp;
> +	pmd_t *pmdp;
> +	pte_t *ptep;
> +
> +	if (pgd_none(*pgdp) || (void *)pgd_page_vaddr(*pgdp) == kasan_early_shadow_pud) {
> +		pudp = kasan_alloc_pgtable(PUD_TABLE_SIZE);
> +		kasan_populate_pud(pudp);
> +		pgd_populate(&init_mm, pgdp, pudp);
> +	}
> +	pudp = pud_offset(pgdp, va);
> +	if (pud_none(*pudp) || (void *)pud_page_vaddr(*pudp) == kasan_early_shadow_pmd) {
> +		pmdp = kasan_alloc_pgtable(PMD_TABLE_SIZE);
> +		kasan_populate_pmd(pmdp);
> +		pud_populate(&init_mm, pudp, pmdp);
> +	}
> +	pmdp = pmd_offset(pudp, va);
> +	if (!pmd_present(*pmdp) || (void *)pmd_page_vaddr(*pmdp) == kasan_early_shadow_pte) {
> +		ptep = kasan_alloc_pgtable(PTE_TABLE_SIZE);
> +		kasan_populate_pte(ptep, PAGE_KERNEL);
> +		pmd_populate_kernel(&init_mm, pmdp, ptep);
> +	}
> +	ptep = pte_offset_kernel(pmdp, va);
> +
> +	__set_pte_at(&init_mm, va, ptep, pfn_pte(pa >> PAGE_SHIFT, prot), 0);
> +
> +	return 0;
> +}
> +
> +static void __init kasan_init_region(struct memblock_region *reg)
> +{
> +	void *start = __va(reg->base);
> +	void *end = __va(reg->base + reg->size);
> +	unsigned long k_start, k_end, k_cur;
> +
> +	if (start >= end)
> +		return;
> +
> +	k_start = (unsigned long)kasan_mem_to_shadow(start);
> +	k_end = (unsigned long)kasan_mem_to_shadow(end);
> +
> +	for (k_cur = k_start; k_cur < k_end; k_cur += PAGE_SIZE) {
> +		void *va = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +
> +		kasan_map_page(k_cur, __pa(va), PAGE_KERNEL);
> +	}
> +	flush_tlb_kernel_range(k_start, k_end);
> +}
> +
> +void __init kasan_init(void)
> +{
> +	struct memblock_region *reg;
> +
> +	for_each_memblock(memory, reg)
> +		kasan_init_region(reg);
> +
> +	/* It's too early to use clear_page() ! */
> +	memset(kasan_early_shadow_page, 0, sizeof(kasan_early_shadow_page));
> +
> +	/* Enable error messages */
> +	init_task.kasan_depth = 0;
> +	pr_info("KASAN init done\n");
> +}
> +
> +/* The early shadow maps everything to a single page of zeroes */
> +asmlinkage void __init kasan_early_init(void)
> +{
> +	unsigned long addr = KASAN_SHADOW_START;
> +	unsigned long end = KASAN_SHADOW_END;
> +	pgd_t *pgdp = pgd_offset_k(addr);
> +
> +	kasan_populate_pte(kasan_early_shadow_pte, PAGE_KERNEL);
> +	kasan_populate_pmd(kasan_early_shadow_pmd);
> +	kasan_populate_pud(kasan_early_shadow_pud);
> +
> +	do {
> +		pgd_populate(&init_mm, pgdp, kasan_early_shadow_pud);
> +	} while (pgdp++, addr = pgd_addr_end(addr, end), addr != end);
> +}
> -- 
> 2.13.3
