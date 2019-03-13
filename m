Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591A5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6A620643
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfCMSbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:31:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726033AbfCMSbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:31:35 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2DIM8vC099016
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 14:31:33 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r76tjs900-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 14:31:33 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 13 Mar 2019 18:31:30 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Mar 2019 18:31:27 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2DIVQeA28770552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Mar 2019 18:31:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 817724C050;
        Wed, 13 Mar 2019 18:31:26 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE30E4C040;
        Wed, 13 Mar 2019 18:31:24 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.233])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 13 Mar 2019 18:31:24 +0000 (GMT)
Date:   Wed, 13 Mar 2019 20:31:22 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] RISC-V: Allow booting kernel from any 4KB aligned
 address
References: <20190312220752.128141-1-anup.patel@wdc.com>
 <20190312220752.128141-4-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312220752.128141-4-anup.patel@wdc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19031318-0012-0000-0000-000003023927
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031318-0013-0000-0000-000021396070
Message-Id: <20190313183121.GB28630@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 10:08:22PM +0000, Anup Patel wrote:
> Currently, we have to boot RISCV64 kernel from a 2MB aligned physical
> address and RISCV32 kernel from a 4MB aligned physical address. This
> constraint is because initial pagetable setup (i.e. setup_vm()) maps
> entire RAM using hugepages (i.e. 2MB for 3-level pagetable and 4MB for
> 2-level pagetable).
> 
> Further, the above booting contraint also results in memory wastage
> because if we boot kernel from some <xyz> address (which is not same as
> RAM start address) then RISCV kernel will map PAGE_OFFSET virtual address
> lineraly to <xyz> physical address and memory between RAM start and <xyz>
> will be reserved/unusable.
> 
> For example, RISCV64 kernel booted from 0x80200000 will waste 2MB of RAM
> and RISCV32 kernel booted from 0x80400000 will waste 4MB of RAM.
> 
> This patch re-writes the initial pagetable setup code to allow booting
> RISV32 and RISCV64 kernel from any 4KB (i.e. PAGE_SIZE) aligned address.
> 
> To achieve this:
> 1. We map kernel, dtb and only some amount of RAM (few MBs) using 4KB
>    mappings in setup_vm() (called from head.S)
> 2. Once we reach paging_init() (called from setup_arch()) after
>    memblock setup, we map all available memory banks using 4KB
>    mappings and memblock APIs.

I'm not really familiar with RISC-V, but my guess would be that you'd get
worse TLB performance with 4KB mappings. Not mentioning the amount of
memory required for the page table itself.

If the only goal is to utilize the physical memory below the kernel, it
simply should not be reserved at the first place, something like:

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b379a75..6301ced 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -108,6 +108,7 @@ void __init setup_bootmem(void)
 	/* Find the memory region containing the kernel */
 	for_each_memblock(memory, reg) {
 		phys_addr_t vmlinux_end = __pa(_end);
+		phys_addr_t vmlinux_start = __pa(start);
 		phys_addr_t end = reg->base + reg->size;
 
 		if (reg->base <= vmlinux_end && vmlinux_end <= end) {
@@ -115,7 +116,8 @@ void __init setup_bootmem(void)
 			 * Reserve from the start of the region to the end of
 			 * the kernel
 			 */
-			memblock_reserve(reg->base, vmlinux_end - reg->base);
+			memblock_reserve(vmlinux_start,
+					 vmlinux_end - vmlinux_start);
 			mem_size = min(reg->size, (phys_addr_t)-PAGE_OFFSET);
 		}
 	}
 
> With this patch in-place, the booting constraint for RISCV32 and RISCV64
> kernel is much more relaxed and we can now boot kernel very close to
> RAM start thereby minimizng memory wastage.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/include/asm/fixmap.h     |   5 +
>  arch/riscv/include/asm/pgtable-64.h |   5 +
>  arch/riscv/include/asm/pgtable.h    |   6 +-
>  arch/riscv/kernel/head.S            |   1 +
>  arch/riscv/kernel/setup.c           |   4 +-
>  arch/riscv/mm/init.c                | 357 +++++++++++++++++++++++-----
>  6 files changed, 317 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 57afe604b495..5cf53dd882e5 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -21,6 +21,11 @@
>   */
>  enum fixed_addresses {
>  	FIX_HOLE,
> +#define FIX_FDT_SIZE	SZ_1M
> +	FIX_FDT_END,
> +	FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
> +	FIX_PTE,
> +	FIX_PMD,
>  	FIX_EARLYCON_MEM_BASE,
>  	__end_of_fixed_addresses
>  };
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index 7aa0ea9bd8bb..56ecc3dc939d 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -78,6 +78,11 @@ static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
>  	return __pmd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
>  }
>  
> +static inline unsigned long _pmd_pfn(pmd_t pmd)
> +{
> +	return pmd_val(pmd) >> _PAGE_PFN_SHIFT;
> +}
> +
>  #define pmd_ERROR(e) \
>  	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
>  
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 1141364d990e..05fa2115e736 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -121,12 +121,16 @@ static inline void pmd_clear(pmd_t *pmdp)
>  	set_pmd(pmdp, __pmd(0));
>  }
>  
> -
>  static inline pgd_t pfn_pgd(unsigned long pfn, pgprot_t prot)
>  {
>  	return __pgd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
>  }
>  
> +static inline unsigned long _pgd_pfn(pgd_t pgd)
> +{
> +	return pgd_val(pgd) >> _PAGE_PFN_SHIFT;
> +}
> +
>  #define pgd_index(addr) (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
>  
>  /* Locate an entry in the page global directory */
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 7966262b4f9d..12a3ec5eb8ab 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -63,6 +63,7 @@ clear_bss_done:
>  	/* Initialize page tables and relocate to virtual addresses */
>  	la sp, init_thread_union + THREAD_SIZE
>  	la a0, _start
> +	mv a1, s1
>  	call setup_vm
>  	call relocate
>  
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index ecb654f6a79e..acdd0f74982b 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -30,6 +30,7 @@
>  #include <linux/sched/task.h>
>  #include <linux/swiotlb.h>
>  
> +#include <asm/fixmap.h>
>  #include <asm/setup.h>
>  #include <asm/sections.h>
>  #include <asm/pgtable.h>
> @@ -62,7 +63,8 @@ unsigned long boot_cpu_hartid;
>  
>  void __init parse_dtb(unsigned int hartid, void *dtb)
>  {
> -	if (early_init_dt_scan(__va(dtb)))
> +	dtb = (void *)fix_to_virt(FIX_FDT) + ((uintptr_t)dtb & ~PAGE_MASK);
> +	if (early_init_dt_scan(dtb))
>  		return;
>  
>  	pr_err("No DTB passed to the kernel\n");
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index f35299f2f3d5..ee55a4b90dec 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1,14 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
>   * Copyright (C) 2012 Regents of the University of California
> - *
> - *   This program is free software; you can redistribute it and/or
> - *   modify it under the terms of the GNU General Public License
> - *   as published by the Free Software Foundation, version 2.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *   GNU General Public License for more details.
>   */
>  
>  #include <linux/init.h>
> @@ -43,13 +36,6 @@ void setup_zero_page(void)
>  	memset((void *)empty_zero_page, 0, PAGE_SIZE);
>  }
>  
> -void __init paging_init(void)
> -{
> -	setup_zero_page();
> -	local_flush_tlb_all();
> -	zone_sizes_init();
> -}
> -
>  void __init mem_init(void)
>  {
>  #ifdef CONFIG_FLATMEM
> @@ -146,13 +132,24 @@ void __init setup_bootmem(void)
>  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>  
> +#define MAX_EARLY_MAPPING_SIZE	SZ_128M
> +
>  #ifndef __PAGETABLE_PMD_FOLDED
> -#define NUM_SWAPPER_PMDS ((uintptr_t)-PAGE_OFFSET >> PGDIR_SHIFT)
> -pmd_t swapper_pmd[PTRS_PER_PMD*((-PAGE_OFFSET)/PGDIR_SIZE)] __page_aligned_bss;
> -pmd_t trampoline_pmd[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
> +#if MAX_EARLY_MAPPING_SIZE < PGDIR_SIZE
> +#define NUM_SWAPPER_PMDS	1UL
> +#else
> +#define NUM_SWAPPER_PMDS	(MAX_EARLY_MAPPING_SIZE/PGDIR_SIZE)
> +#endif
> +pmd_t swapper_pmd[PTRS_PER_PMD*NUM_SWAPPER_PMDS] __page_aligned_bss;
> +pmd_t trampoline_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>  pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
> +#define NUM_SWAPPER_PTES	(MAX_EARLY_MAPPING_SIZE/PMD_SIZE)
> +#else
> +#define NUM_SWAPPER_PTES	(MAX_EARLY_MAPPING_SIZE/PGDIR_SIZE)
>  #endif
>  
> +pte_t swapper_pte[PTRS_PER_PTE*NUM_SWAPPER_PTES] __page_aligned_bss;
> +pte_t trampoline_pte[PTRS_PER_PTE] __initdata __aligned(PAGE_SIZE);
>  pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
>  
>  void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
> @@ -172,76 +169,318 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
>  	}
>  }
>  
> +struct mapping_ops {
> +	pte_t *(*get_pte_virt)(phys_addr_t pa);
> +	phys_addr_t (*alloc_pte)(uintptr_t va, uintptr_t load_pa);
> +	pmd_t *(*get_pmd_virt)(phys_addr_t pa);
> +	phys_addr_t (*alloc_pmd)(uintptr_t va, uintptr_t load_pa);
> +};
> +
>  static inline void *__early_va(void *ptr, uintptr_t load_pa)
>  {
>  	extern char _start;
>  	uintptr_t va = (uintptr_t)ptr;
>  	uintptr_t sz = (uintptr_t)(&_end) - (uintptr_t)(&_start);
>  
> -	if (va >= PAGE_OFFSET && va < (PAGE_OFFSET + sz))
> +	if (va >= PAGE_OFFSET && va <= (PAGE_OFFSET + sz))
>  		return (void *)(load_pa + (va - PAGE_OFFSET));
>  	return (void *)va;
>  }
>  
> -asmlinkage void __init setup_vm(uintptr_t load_pa)
> +#define __early_pa(ptr, load_pa)	(uintptr_t)__early_va(ptr, load_pa)
> +
> +static phys_addr_t __init final_alloc_pgtable(void)
> +{
> +	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
> +}
> +
> +static pte_t *__init early_get_pte_virt(phys_addr_t pa)
>  {
> -	uintptr_t i;
> +	return (pte_t *)((uintptr_t)pa);
> +}
> +
> +static pte_t *__init final_get_pte_virt(phys_addr_t pa)
> +{
> +	clear_fixmap(FIX_PTE);
> +
> +	return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
> +}
> +
> +static phys_addr_t __init early_alloc_pte(uintptr_t va, uintptr_t load_pa)
> +{
> +	pte_t *base = __early_va(swapper_pte, load_pa);
> +	uintptr_t pte_num = ((va - PAGE_OFFSET) >> PMD_SHIFT);
> +
> +	BUG_ON(pte_num >= NUM_SWAPPER_PTES);
> +
> +	return (uintptr_t)&base[pte_num * PTRS_PER_PTE];
> +}
> +
> +static phys_addr_t __init final_alloc_pte(uintptr_t va, uintptr_t load_pa)
> +{
> +	return final_alloc_pgtable();
> +}
> +
> +static void __init create_pte_mapping(pte_t *ptep,
> +				      uintptr_t va, phys_addr_t pa,
> +				      phys_addr_t sz, pgprot_t prot)
> +{
> +	uintptr_t pte_index = pte_index(va);
> +
> +	BUG_ON(sz != PAGE_SIZE);
> +
> +	if (pte_none(ptep[pte_index]))
> +		ptep[pte_index] = pfn_pte(PFN_DOWN(pa), prot);
> +}
> +
>  #ifndef __PAGETABLE_PMD_FOLDED
> +static pmd_t *__init early_get_pmd_virt(phys_addr_t pa)
> +{
> +	return (pmd_t *)((uintptr_t)pa);
> +}
> +
> +static pmd_t *__init final_get_pmd_virt(phys_addr_t pa)
> +{
> +	clear_fixmap(FIX_PMD);
> +
> +	return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
> +}
> +
> +static phys_addr_t __init early_alloc_pmd(uintptr_t va, uintptr_t load_pa)
> +{
> +	pmd_t *base = __early_va(swapper_pmd, load_pa);
> +	uintptr_t pmd_num = (va - PAGE_OFFSET) >> PGDIR_SHIFT;
> +
> +	BUG_ON(pmd_num >= NUM_SWAPPER_PMDS);
> +
> +	return (uintptr_t)&base[pmd_num * PTRS_PER_PMD];
> +}
> +
> +static phys_addr_t __init final_alloc_pmd(uintptr_t va, uintptr_t load_pa)
> +{
> +	return final_alloc_pgtable();
> +}
> +
> +static void __init create_pmd_mapping(pmd_t *pmdp,
> +				      uintptr_t va, phys_addr_t pa,
> +				      phys_addr_t sz, pgprot_t prot,
> +				      uintptr_t ops_load_pa,
> +				      struct mapping_ops *ops)
> +{
> +	pte_t *ptep;
> +	phys_addr_t pte_phys;
> +	uintptr_t pmd_index = pmd_index(va);
> +
> +	if (sz == PMD_SIZE) {
> +		if (pmd_none(pmdp[pmd_index]))
> +			pmdp[pmd_index] = pfn_pmd(PFN_DOWN(pa), prot);
> +		return;
> +	}
> +
> +	if (pmd_none(pmdp[pmd_index])) {
> +		pte_phys = ops->alloc_pte(va, ops_load_pa);
> +		pmdp[pmd_index] = pfn_pmd(PFN_DOWN(pte_phys),
> +					  __pgprot(_PAGE_TABLE));
> +		ptep = ops->get_pte_virt(pte_phys);
> +		memset(ptep, 0, PAGE_SIZE);
> +	} else {
> +		pte_phys = PFN_PHYS(_pmd_pfn(pmdp[pmd_index]));
> +		ptep = ops->get_pte_virt(pte_phys);
> +	}
> +
> +	create_pte_mapping(ptep, va, pa, sz, prot);
> +}
> +
> +static void __init create_pgd_mapping(pgd_t *pgdp,
> +				      uintptr_t va, phys_addr_t pa,
> +				      phys_addr_t sz, pgprot_t prot,
> +				      uintptr_t ops_load_pa,
> +				      struct mapping_ops *ops)
> +{
>  	pmd_t *pmdp;
> +	phys_addr_t pmd_phys;
> +	uintptr_t pgd_index = pgd_index(va);
> +
> +	if (sz == PGDIR_SIZE) {
> +		if (pgd_val(pgdp[pgd_index]) == 0)
> +			pgdp[pgd_index] = pfn_pgd(PFN_DOWN(pa), prot);
> +		return;
> +	}
> +
> +	if (pgd_val(pgdp[pgd_index]) == 0) {
> +		pmd_phys = ops->alloc_pmd(va, ops_load_pa);
> +		pgdp[pgd_index] = pfn_pgd(PFN_DOWN(pmd_phys),
> +					  __pgprot(_PAGE_TABLE));
> +		pmdp = ops->get_pmd_virt(pmd_phys);
> +		memset(pmdp, 0, PAGE_SIZE);
> +	} else {
> +		pmd_phys = PFN_PHYS(_pgd_pfn(pgdp[pgd_index]));
> +		pmdp = ops->get_pmd_virt(pmd_phys);
> +	}
> +
> +	create_pmd_mapping(pmdp, va, pa, sz, prot, ops_load_pa, ops);
> +}
> +#else
> +static void __init create_pgd_mapping(pgd_t *pgdp,
> +				      uintptr_t va, phys_addr_t pa,
> +				      phys_addr_t sz, pgprot_t prot,
> +				      uintptr_t ops_load_pa,
> +				      struct mapping_ops *ops)
> +{
> +	pte_t *ptep;
> +	phys_addr_t pte_phys;
> +	uintptr_t pgd_index = pgd_index(va);
> +
> +	if (sz == PGDIR_SIZE) {
> +		if (pgd_val(pgdp[pgd_index]) == 0)
> +			pgdp[pgd_index] = pfn_pgd(PFN_DOWN(pa), prot);
> +		return;
> +	}
> +
> +	if (pgd_val(pgdp[pgd_index]) == 0) {
> +		pte_phys = ops->alloc_pte(va, ops_load_pa);
> +		pgdp[pgd_index] = pfn_pgd(PFN_DOWN(pte_phys),
> +					  __pgprot(_PAGE_TABLE));
> +		ptep = ops->get_pte_virt(pte_phys);
> +		memset(ptep, 0, PAGE_SIZE);
> +	} else {
> +		pte_phys = PFN_PHYS(_pgd_pfn(pgdp[pgd_index]));
> +		ptep = ops->get_pte_virt(pte_phys);
> +	}
> +
> +	create_pte_mapping(ptep, va, pa, sz, prot);
> +}
>  #endif
> -	pgd_t *pgdp;
> +
> +asmlinkage void __init setup_vm(uintptr_t load_pa, uintptr_t dtb_pa)
> +{
>  	phys_addr_t map_pa;
> +	uintptr_t va, end_va;
> +	uintptr_t load_sz = __early_pa(&_end, load_pa) - load_pa;
>  	pgprot_t tableprot = __pgprot(_PAGE_TABLE);
>  	pgprot_t prot = __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_EXEC);
> +	struct mapping_ops ops;
>  
>  	va_pa_offset = PAGE_OFFSET - load_pa;
>  	pfn_base = PFN_DOWN(load_pa);
>  
>  	/* Sanity check alignment and size */
>  	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
> -	BUG_ON((load_pa % (PAGE_SIZE * PTRS_PER_PTE)) != 0);
> +	BUG_ON((load_pa % PAGE_SIZE) != 0);
> +	BUG_ON(load_sz > MAX_EARLY_MAPPING_SIZE);
> +
> +	/* Setup mapping ops */
> +	ops.get_pte_virt = __early_va(early_get_pte_virt, load_pa);
> +	ops.alloc_pte = __early_va(early_alloc_pte, load_pa);
> +	ops.get_pmd_virt = NULL;
> +	ops.alloc_pmd = NULL;
>  
>  #ifndef __PAGETABLE_PMD_FOLDED
> -	pgdp = __early_va(trampoline_pg_dir, load_pa);
> -	map_pa = (uintptr_t)__early_va(trampoline_pmd, load_pa);
> -	pgdp[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =
> -		pfn_pgd(PFN_DOWN(map_pa), tableprot);
> -	trampoline_pmd[0] = pfn_pmd(PFN_DOWN(load_pa), prot);
> +	/* Update mapping ops for PMD */
> +	ops.get_pmd_virt = __early_va(early_get_pmd_virt, load_pa);
> +	ops.alloc_pmd = __early_va(early_alloc_pmd, load_pa);
> +
> +	/* Setup trampoline PGD and PMD */
> +	map_pa = __early_pa(trampoline_pmd, load_pa);
> +	create_pgd_mapping(__early_va(trampoline_pg_dir, load_pa),
> +			   PAGE_OFFSET, map_pa, PGDIR_SIZE, tableprot,
> +			   load_pa, &ops);
> +	map_pa = __early_pa(trampoline_pte, load_pa);
> +	create_pmd_mapping(__early_va(trampoline_pmd, load_pa),
> +			   PAGE_OFFSET, map_pa, PMD_SIZE, tableprot,
> +			   load_pa, &ops);
> +
> +	/* Setup swapper PGD and PMD for fixmap */
> +	map_pa = __early_pa(fixmap_pmd, load_pa);
> +	create_pgd_mapping(__early_va(swapper_pg_dir, load_pa),
> +			   FIXADDR_START, map_pa, PGDIR_SIZE, tableprot,
> +			   load_pa, &ops);
> +	map_pa = __early_pa(fixmap_pte, load_pa);
> +	create_pmd_mapping(__early_va(fixmap_pmd, load_pa),
> +			   FIXADDR_START, map_pa, PMD_SIZE, tableprot,
> +			   load_pa, &ops);
> +#else
> +	/* Setup trampoline PGD */
> +	map_pa = __early_pa(trampoline_pte, load_pa);
> +	create_pgd_mapping(__early_va(trampoline_pg_dir, load_pa),
> +			   PAGE_OFFSET, map_pa, PGDIR_SIZE, tableprot,
> +			   load_pa, &ops);
> +
> +	/* Setup swapper PGD for fixmap */
> +	map_pa = __early_pa(fixmap_pte, load_pa);
> +	create_pgd_mapping(__early_va(swapper_pg_dir, load_pa),
> +			   FIXADDR_START, map_pa, PGDIR_SIZE, tableprot,
> +			   load_pa, &ops);
> +#endif
>  
> -	pgdp = __early_va(swapper_pg_dir, load_pa);
> +	/* Setup trampoling PTE */
> +	end_va = PAGE_OFFSET + PAGE_SIZE*PTRS_PER_PTE;
> +	for (va = PAGE_OFFSET; va < end_va; va += PAGE_SIZE)
> +		create_pte_mapping(__early_va(trampoline_pte, load_pa),
> +				   va, load_pa + (va - PAGE_OFFSET),
> +				   PAGE_SIZE, prot);
> +
> +	/*
> +	 * Setup swapper PGD covering kernel and some amount of
> +	 * RAM which will allows us to reach paging_init(). We map
> +	 * all memory banks later in setup_vm_final() below.
> +	 */
> +	end_va = PAGE_OFFSET + load_sz;
> +	for (va = PAGE_OFFSET; va < end_va; va += PAGE_SIZE)
> +		create_pgd_mapping(__early_va(swapper_pg_dir, load_pa),
> +				   va, load_pa + (va - PAGE_OFFSET),
> +				   PAGE_SIZE, prot, load_pa, &ops);
> +
> +	/* Create fixed mapping for early parsing of FDT */
> +	end_va = __fix_to_virt(FIX_FDT) + FIX_FDT_SIZE;
> +	for (va = __fix_to_virt(FIX_FDT); va < end_va; va += PAGE_SIZE)
> +		create_pte_mapping(__early_va(fixmap_pte, load_pa),
> +				   va, dtb_pa + (va - __fix_to_virt(FIX_FDT)),
> +				   PAGE_SIZE, prot);
> +}
>  
> -	for (i = 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
> -		size_t o = (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
> +static void __init setup_vm_final(void)
> +{
> +	phys_addr_t pa, start, end;
> +	struct memblock_region *reg;
> +	struct mapping_ops ops;
> +	pgprot_t prot = __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_EXEC);
>  
> -		map_pa = (uintptr_t)__early_va(swapper_pmd, load_pa);
> -		pgdp[o] = pfn_pgd(PFN_DOWN(map_pa) + i, tableprot);
> -	}
> -	pmdp = __early_va(swapper_pmd, load_pa);
> -	for (i = 0; i < ARRAY_SIZE(swapper_pmd); i++)
> -		pmdp[i] = pfn_pmd(PFN_DOWN(load_pa + i * PMD_SIZE), prot);
> -
> -	map_pa = (uintptr_t)__early_va(fixmap_pmd, load_pa);
> -	pgdp[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =
> -		pfn_pgd(PFN_DOWN(map_pa), tableprot);
> -	pmdp = __early_va(fixmap_pmd, load_pa);
> -	map_pa = (uintptr_t)__early_va(fixmap_pte, load_pa);
> -	fixmap_pmd[(FIXADDR_START >> PMD_SHIFT) % PTRS_PER_PMD] =
> -		pfn_pmd(PFN_DOWN(map_pa), tableprot);
> +	/* Setup mapping ops */
> +	ops.get_pte_virt = final_get_pte_virt;
> +	ops.alloc_pte = final_alloc_pte;
> +#ifndef __PAGETABLE_PMD_FOLDED
> +	ops.get_pmd_virt = final_get_pmd_virt;
> +	ops.alloc_pmd = final_alloc_pmd;
>  #else
> -	pgdp = __early_va(trampoline_pg_dir, load_pa);
> -	pgdp[(PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD] =
> -		pfn_pgd(PFN_DOWN(load_pa), prot);
> -
> -	pgdp = __early_va(swapper_pg_dir, load_pa);
> -
> -	for (i = 0; i < (-PAGE_OFFSET)/PGDIR_SIZE; ++i) {
> -		size_t o = (PAGE_OFFSET >> PGDIR_SHIFT) % PTRS_PER_PGD + i;
> +	ops.get_pmd_virt = NULL;
> +	ops.alloc_pmd = NULL;
> +#endif
>  
> -		pgdp[o] = pfn_pgd(PFN_DOWN(load_pa + i * PGDIR_SIZE), prot);
> +	/* Map all memory banks */
> +	for_each_memblock(memory, reg) {
> +		start = reg->base;
> +		end = start + reg->size;
> +
> +		if (start >= end)
> +			break;
> +		if (memblock_is_nomap(reg))
> +			continue;
> +
> +		for (pa = start; pa < end; pa += PAGE_SIZE)
> +			create_pgd_mapping(swapper_pg_dir,
> +					   (uintptr_t)__va(pa), pa,
> +					   PAGE_SIZE, prot, 0, &ops);
>  	}
>  
> -	map_pa = (uintptr_t)__early_va(fixmap_pte, load_pa);
> -	pgdp[(FIXADDR_START >> PGDIR_SHIFT) % PTRS_PER_PGD] =
> -		pfn_pgd(PFN_DOWN(map_pa), tableprot);
> -#endif
> +	clear_fixmap(FIX_PTE);
> +	clear_fixmap(FIX_PMD);
> +}
> +
> +void __init paging_init(void)
> +{
> +	setup_vm_final();
> +	setup_zero_page();
> +	local_flush_tlb_all();
> +	zone_sizes_init();
>  }
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

