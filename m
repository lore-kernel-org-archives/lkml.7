Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2714C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8918821582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfLRJYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:24:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:60562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfLRJYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:24:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 93C0CAB71;
        Wed, 18 Dec 2019 09:24:41 +0000 (UTC)
Subject: Re: [RFC PATCH 1/3] x86/xen: add basic KASAN support for PV kernel
To:     Sergey Dyasli <sergey.dyasli@citrix.com>, xen-devel@lists.xen.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>
References: <20191217140804.27364-1-sergey.dyasli@citrix.com>
 <20191217140804.27364-2-sergey.dyasli@citrix.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <934a2950-9079-138d-5476-5eabd84dfec5@suse.com>
Date:   Wed, 18 Dec 2019 10:24:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191217140804.27364-2-sergey.dyasli@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.19 15:08, Sergey Dyasli wrote:
> This enables to use Outline instrumentation for Xen PV kernels.
> 
> KASAN_INLINE and KASAN_VMALLOC options currently lead to boot crashes
> and hence disabled.
> 
> Rough edges in the patch are marked with XXX.
> 
> Signed-off-by: Sergey Dyasli <sergey.dyasli@citrix.com>
> ---
>   arch/x86/mm/init.c          | 14 ++++++++++++++
>   arch/x86/mm/kasan_init_64.c | 28 ++++++++++++++++++++++++++++
>   arch/x86/xen/Makefile       |  7 +++++++
>   arch/x86/xen/enlighten_pv.c |  3 +++
>   arch/x86/xen/mmu_pv.c       | 13 +++++++++++--
>   arch/x86/xen/multicalls.c   | 10 ++++++++++
>   drivers/xen/Makefile        |  2 ++
>   kernel/Makefile             |  2 ++
>   lib/Kconfig.kasan           |  3 ++-
>   9 files changed, 79 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index e7bb483557c9..0c98a45eec6c 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -8,6 +8,8 @@
>   #include <linux/kmemleak.h>
>   #include <linux/sched/task.h>
>   
> +#include <xen/xen.h>
> +
>   #include <asm/set_memory.h>
>   #include <asm/e820/api.h>
>   #include <asm/init.h>
> @@ -835,6 +837,18 @@ void free_kernel_image_pages(const char *what, void *begin, void *end)
>   	unsigned long end_ul = (unsigned long)end;
>   	unsigned long len_pages = (end_ul - begin_ul) >> PAGE_SHIFT;
>   
> +	/*
> +	 * XXX: skip this for now. Otherwise it leads to:
> +	 *
> +	 * (XEN) mm.c:2713:d157v0 Bad type (saw 8c00000000000001 != exp e000000000000000) for mfn 36f40 (pfn 02f40)
> +	 * (XEN) mm.c:1043:d157v0 Could not get page type PGT_writable_page
> +	 * (XEN) mm.c:1096:d157v0 Error getting mfn 36f40 (pfn 02f40) from L1 entry 8010000036f40067 for l1e_owner d157, pg_owner d157
> +	 *
> +	 * and further #PF error: [PROT] [WRITE] in the kernel.
> +	 */
> +	if (xen_pv_domain() && IS_ENABLED(CONFIG_KASAN))
> +		return;
> +

I guess this is related to freeing some kasan page tables without
unpinning them?

>   	free_init_pages(what, begin_ul, end_ul);
>   
>   	/*
> diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
> index cf5bc37c90ac..caee2022f8b0 100644
> --- a/arch/x86/mm/kasan_init_64.c
> +++ b/arch/x86/mm/kasan_init_64.c
> @@ -13,6 +13,8 @@
>   #include <linux/sched/task.h>
>   #include <linux/vmalloc.h>
>   
> +#include <xen/xen.h>
> +
>   #include <asm/e820/types.h>
>   #include <asm/pgalloc.h>
>   #include <asm/tlbflush.h>
> @@ -20,6 +22,9 @@
>   #include <asm/pgtable.h>
>   #include <asm/cpu_entry_area.h>
>   
> +#include <xen/interface/xen.h>
> +#include <asm/xen/hypervisor.h>
> +
>   extern struct range pfn_mapped[E820_MAX_ENTRIES];
>   
>   static p4d_t tmp_p4d_table[MAX_PTRS_PER_P4D] __initdata __aligned(PAGE_SIZE);
> @@ -305,6 +310,12 @@ static struct notifier_block kasan_die_notifier = {
>   };
>   #endif
>   
> +#ifdef CONFIG_XEN
> +/* XXX: this should go to some header */
> +void __init set_page_prot(void *addr, pgprot_t prot);
> +void __init pin_pagetable_pfn(unsigned cmd, unsigned long pfn);
> +#endif
> +

Instead of exporting those, why don't you ...

>   void __init kasan_early_init(void)
>   {
>   	int i;
> @@ -332,6 +343,16 @@ void __init kasan_early_init(void)
>   	for (i = 0; pgtable_l5_enabled() && i < PTRS_PER_P4D; i++)
>   		kasan_early_shadow_p4d[i] = __p4d(p4d_val);
>   
> +	if (xen_pv_domain()) {
> +		/* PV page tables must have PAGE_KERNEL_RO */
> +		set_page_prot(kasan_early_shadow_pud, PAGE_KERNEL_RO);
> +		set_page_prot(kasan_early_shadow_pmd, PAGE_KERNEL_RO);
> +		set_page_prot(kasan_early_shadow_pte, PAGE_KERNEL_RO);

add a function doing that to mmu_pv.c (e.g. xen_pv_kasan_early_init())?

> +
> +		/* Add mappings to the initial PV page tables */
> +		kasan_map_early_shadow((pgd_t *)xen_start_info->pt_base);
> +	}
> +
>   	kasan_map_early_shadow(early_top_pgt);
>   	kasan_map_early_shadow(init_top_pgt);
>   }
> @@ -369,6 +390,13 @@ void __init kasan_init(void)
>   				__pgd(__pa(tmp_p4d_table) | _KERNPG_TABLE));
>   	}
>   
> +	if (xen_pv_domain()) {
> +		/* PV page tables must be pinned */
> +		set_page_prot(early_top_pgt, PAGE_KERNEL_RO);
> +		pin_pagetable_pfn(MMUEXT_PIN_L4_TABLE,
> +				  PFN_DOWN(__pa_symbol(early_top_pgt)));

and another one like xen_pv_kasan_init() here.

> +	}
> +
>   	load_cr3(early_top_pgt);
>   	__flush_tlb_all();
>   
> diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
> index 084de77a109e..102fad0b0bca 100644
> --- a/arch/x86/xen/Makefile
> +++ b/arch/x86/xen/Makefile
> @@ -1,3 +1,10 @@
> +KASAN_SANITIZE_enlighten_pv.o := n
> +KASAN_SANITIZE_enlighten.o := n
> +KASAN_SANITIZE_irq.o := n
> +KASAN_SANITIZE_mmu_pv.o := n
> +KASAN_SANITIZE_p2m.o := n
> +KASAN_SANITIZE_multicalls.o := n
> +
>   # SPDX-License-Identifier: GPL-2.0
>   OBJECT_FILES_NON_STANDARD_xen-asm_$(BITS).o := y
>   
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index ae4a41ca19f6..27de55699f24 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -72,6 +72,7 @@
>   #include <asm/mwait.h>
>   #include <asm/pci_x86.h>
>   #include <asm/cpu.h>
> +#include <asm/kasan.h>
>   
>   #ifdef CONFIG_ACPI
>   #include <linux/acpi.h>
> @@ -1231,6 +1232,8 @@ asmlinkage __visible void __init xen_start_kernel(void)
>   	/* Get mfn list */
>   	xen_build_dynamic_phys_to_machine();
>   
> +	kasan_early_init();
> +
>   	/*
>   	 * Set up kernel GDT and segment registers, mainly so that
>   	 * -fstack-protector code can be executed.
> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> index c8dbee62ec2a..eaf63f1f26af 100644
> --- a/arch/x86/xen/mmu_pv.c
> +++ b/arch/x86/xen/mmu_pv.c
> @@ -1079,7 +1079,7 @@ static void xen_exit_mmap(struct mm_struct *mm)
>   
>   static void xen_post_allocator_init(void);
>   
> -static void __init pin_pagetable_pfn(unsigned cmd, unsigned long pfn)
> +void __init pin_pagetable_pfn(unsigned cmd, unsigned long pfn)
>   {
>   	struct mmuext_op op;
>   
> @@ -1767,7 +1767,7 @@ static void __init set_page_prot_flags(void *addr, pgprot_t prot,
>   	if (HYPERVISOR_update_va_mapping((unsigned long)addr, pte, flags))
>   		BUG();
>   }
> -static void __init set_page_prot(void *addr, pgprot_t prot)
> +void __init set_page_prot(void *addr, pgprot_t prot)
>   {
>   	return set_page_prot_flags(addr, prot, UVMF_NONE);
>   }
> @@ -1943,6 +1943,15 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
>   	if (i && i < pgd_index(__START_KERNEL_map))
>   		init_top_pgt[i] = ((pgd_t *)xen_start_info->pt_base)[i];
>   
> +#ifdef CONFIG_KASAN
> +	/*
> +	 * Copy KASAN mappings
> +	 * ffffec0000000000 - fffffbffffffffff (=44 bits) kasan shadow memory (16TB)
> +	 */
> +	for (i = 0xec0 >> 3; i < 0xfc0 >> 3; i++)
> +		init_top_pgt[i] = ((pgd_t *)xen_start_info->pt_base)[i];
> +#endif
> +
>   	/* Make pagetable pieces RO */
>   	set_page_prot(init_top_pgt, PAGE_KERNEL_RO);
>   	set_page_prot(level3_ident_pgt, PAGE_KERNEL_RO);
> diff --git a/arch/x86/xen/multicalls.c b/arch/x86/xen/multicalls.c
> index 07054572297f..5e4729efbbe2 100644
> --- a/arch/x86/xen/multicalls.c
> +++ b/arch/x86/xen/multicalls.c
> @@ -99,6 +99,15 @@ void xen_mc_flush(void)
>   				ret++;
>   	}
>   
> +	/*
> +	 * XXX: Kasan produces quite a lot (~2000) of warnings in a form of:
> +	 *
> +	 *     (XEN) mm.c:3222:d155v0 mfn 3704b already pinned
> +	 *
> +	 * during kasan_init(). They are benign, but silence them for now.
> +	 * Otherwise, booting takes too long due to printk() spam.
> +	 */
> +#ifndef CONFIG_KASAN

It might be interesting to identify the problematic page tables.

I guess this would require some hacking to avoid the multicalls in order
to identify which page table should not be pinned again.


Juergen
