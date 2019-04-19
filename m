Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6B5C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5925222CC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfDSSXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:23:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbfDSSXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:23:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0C3F80F91;
        Fri, 19 Apr 2019 08:58:10 +0000 (UTC)
Received: from localhost (ovpn-12-186.pek2.redhat.com [10.72.12.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EDE0819C58;
        Fri, 19 Apr 2019 08:58:07 +0000 (UTC)
Date:   Fri, 19 Apr 2019 16:58:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH] kexec, x86/boot: map systab region in identity
 mapping before accessing it
Message-ID: <20190419085804.GD11060@MiWiFi-R3L-srv>
References: <20190416095209.GG27892@zn.tnic>
 <20190419083458.503-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419083458.503-1-kasong@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 19 Apr 2019 08:58:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/19 at 04:34pm, Kairui Song wrote:
>  /* Locates and clears a region for a new top level page table. */
>  void initialize_identity_maps(void)
>  {
> -	/* If running as an SEV guest, the encryption mask is required. */
> -	set_sev_encryption_mask();
> -
> -	/* Exclude the encryption mask from __PHYSICAL_MASK */
> -	physical_mask &= ~sme_me_mask;
> -
> -	/* Init mapping_info with run-time function/buffer pointers. */
> -	mapping_info.alloc_pgt_page = alloc_pgt_page;
> -	mapping_info.context = &pgt_data;
> -	mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sme_me_mask;
> -	mapping_info.kernpg_flag = _KERNPG_TABLE;
> -
> -	/*
> -	 * It should be impossible for this not to already be true,
> -	 * but since calling this a second time would rewind the other
> -	 * counters, let's just make sure this is reset too.
> -	 */
> -	pgt_data.pgt_buf_offset = 0;
> -
> -	/*
> -	 * If we came here via startup_32(), cr3 will be _pgtable already
> -	 * and we must append to the existing area instead of entirely
> -	 * overwriting it.
> -	 *
> -	 * With 5-level paging, we use '_pgtable' to allocate the p4d page table,
> -	 * the top-level page table is allocated separately.
> -	 *
> -	 * p4d_offset(top_level_pgt, 0) would cover both the 4- and 5-level
> -	 * cases. On 4-level paging it's equal to 'top_level_pgt'.
> -	 */
> -	top_level_pgt = read_cr3_pa();
> -	if (p4d_offset((pgd_t *)top_level_pgt, 0) == (p4d_t *)_pgtable) {
> -		debug_putstr("booted via startup_32()\n");
> -		pgt_data.pgt_buf = _pgtable + BOOT_INIT_PGT_SIZE;
> -		pgt_data.pgt_buf_size = BOOT_PGT_SIZE - BOOT_INIT_PGT_SIZE;
> -		memset(pgt_data.pgt_buf, 0, pgt_data.pgt_buf_size);
> -	} else {
> -		debug_putstr("booted via startup_64()\n");
> -		pgt_data.pgt_buf = _pgtable;
> -		pgt_data.pgt_buf_size = BOOT_PGT_SIZE;
> -		memset(pgt_data.pgt_buf, 0, pgt_data.pgt_buf_size);
> +	top_level_pgt = early_boot_top_pgt;
> +	if ((p4d_t *)top_level_pgt != (p4d_t *)_pgtable)
>  		top_level_pgt = (unsigned long)alloc_pgt_page(&pgt_data);

Kairui, will you make a patchset to include these changes separately
later on? I don't get the purposes of code changes. E.g here, I
don't know why you introduce a new variable early_boot_top_pgt, and
allocate the page table, even though they have been done in the old 
initialize_identity_maps().

Thanks
Baoquan

> -	}
>  }
>  
>  /*
> @@ -141,8 +41,7 @@ void add_identity_map(unsigned long start, unsigned long size)
>  		return;
>  
>  	/* Build the mapping. */
> -	kernel_ident_mapping_init(&mapping_info, (pgd_t *)top_level_pgt,
> -				  start, end);
> +	add_identity_map_pgd(start, end, top_level_pgt);
>  }
>  
>  /*
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index c0d6c560df69..6b3548080d15 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -345,6 +345,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>  	const unsigned long kernel_total_size = VO__end - VO__text;
>  	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
>  
> +	initialize_pgtable_alloc();
> +
>  	/* Retain x86 boot parameters pointer passed from startup_32/64. */
>  	boot_params = rmode;
>  
> diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
> index 6ff7e81b5628..443df2b65fbf 100644
> --- a/arch/x86/boot/compressed/pgtable.h
> +++ b/arch/x86/boot/compressed/pgtable.h
> @@ -16,5 +16,16 @@ extern unsigned long *trampoline_32bit;
>  
>  extern void trampoline_32bit_src(void *return_ptr);
>  
> +extern struct alloc_pgt_data pgt_data;
> +
> +extern unsigned long early_boot_top_pgt;
> +
> +void *alloc_pgt_page(void *context);
> +
> +int add_identity_map_pgd(unsigned long pstart,
> +			 unsigned long pend, unsigned long pgd);
> +
> +void initialize_pgtable_alloc(void);
> +
>  #endif /* __ASSEMBLER__ */
>  #endif /* BOOT_COMPRESSED_PAGETABLE_H */
> diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> index f8debf7aeb4c..cd36cf9e6a5c 100644
> --- a/arch/x86/boot/compressed/pgtable_64.c
> +++ b/arch/x86/boot/compressed/pgtable_64.c
> @@ -1,9 +1,30 @@
> +/*
> + * Since we're dealing with identity mappings, physical and virtual
> + * addresses are the same, so override these defines which are ultimately
> + * used by the headers in misc.h.
> + */
> +#define __pa(x)  ((unsigned long)(x))
> +#define __va(x)  ((void *)((unsigned long)(x)))
> +
> +/* No PAGE_TABLE_ISOLATION support needed either: */
> +#undef CONFIG_PAGE_TABLE_ISOLATION
> +
> +#include "misc.h"
> +#include "pgtable.h"
> +#include "../string.h"
> +
>  #include <linux/efi.h>
>  #include <asm/e820/types.h>
>  #include <asm/processor.h>
>  #include <asm/efi.h>
> -#include "pgtable.h"
> -#include "../string.h"
> +
> +/* For handling early ident mapping */
> +#include <asm/init.h>
> +#include <asm/pgtable.h>
> +/* Use the static base for this part of the boot process */
> +#undef __PAGE_OFFSET
> +#define __PAGE_OFFSET __PAGE_OFFSET_BASE
> +#include "../../mm/ident_map.c"
>  
>  /*
>   * __force_order is used by special_insns.h asm code to force instruction
> @@ -14,6 +35,28 @@
>   */
>  unsigned long __force_order;
>  
> +/* Used to track our page table allocation area. */
> +struct alloc_pgt_data {
> +	unsigned char *pgt_buf;
> +	unsigned long pgt_buf_size;
> +	unsigned long pgt_buf_offset;
> +};
> +
> +/* Used to track our allocated page tables. */
> +struct alloc_pgt_data pgt_data;
> +
> +/* Track the first loaded boot page table. */
> +unsigned long early_boot_top_pgt;
> +
> +phys_addr_t physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
> +
> +/*
> + * Mapping information structure passed to kernel_ident_mapping_init().
> + * Due to relocation, pointers must be assigned at run time not build time.
> + */
> +static struct x86_mapping_info mapping_info;
> +
> +/* For handling trampoline. */
>  #define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
>  #define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
>  
> @@ -202,3 +245,87 @@ void cleanup_trampoline(void *pgtable)
>  	/* Restore trampoline memory */
>  	memcpy(trampoline_32bit, trampoline_save, TRAMPOLINE_32BIT_SIZE);
>  }
> +
> +/*
> + * Allocates space for a page table entry, using struct alloc_pgt_data
> + * above. Besides the local callers, this is used as the allocation
> + * callback in mapping_info below.
> + */
> +void *alloc_pgt_page(void *context)
> +{
> +	struct alloc_pgt_data *pages = (struct alloc_pgt_data *)context;
> +	unsigned char *entry;
> +
> +	/* Validate there is space available for a new page. */
> +	if (pages->pgt_buf_offset >= pages->pgt_buf_size) {
> +		debug_putstr("out of pgt_buf in " __FILE__ "!?\n");
> +		debug_putaddr(pages->pgt_buf_offset);
> +		debug_putaddr(pages->pgt_buf_size);
> +		return NULL;
> +	}
> +
> +	entry = pages->pgt_buf + pages->pgt_buf_offset;
> +	pages->pgt_buf_offset += PAGE_SIZE;
> +
> +	return entry;
> +}
> +
> +/* Locates and clears a region for update or create page table. */
> +void initialize_pgtable_alloc(void)
> +{
> +	/* If running as an SEV guest, the encryption mask is required. */
> +	set_sev_encryption_mask();
> +
> +	/* Exclude the encryption mask from __PHYSICAL_MASK */
> +	physical_mask &= ~sme_me_mask;
> +
> +	/* Init mapping_info with run-time function/buffer pointers. */
> +	mapping_info.alloc_pgt_page = alloc_pgt_page;
> +	mapping_info.context = &pgt_data;
> +	mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sme_me_mask;
> +	mapping_info.kernpg_flag = _KERNPG_TABLE;
> +
> +	/*
> +	 * It should be impossible for this not to already be true,
> +	 * but since calling this a second time would rewind the other
> +	 * counters, let's just make sure this is reset too.
> +	 */
> +	pgt_data.pgt_buf_offset = 0;
> +
> +	/*
> +	 * If we came here via startup_32(), cr3 will be _pgtable already
> +	 * and we must append to the existing area instead of entirely
> +	 * overwriting it.
> +	 *
> +	 * With 5-level paging, we use '_pgtable' to allocate the p4d page
> +	 * table, the top-level page table is allocated separately.
> +	 *
> +	 * p4d_offset(early_boot_top_pgt, 0) would cover both the 4- and 5-level
> +	 * cases. On 4-level paging it's equal to 'early_boot_top_pgt'.
> +	 */
> +
> +	early_boot_top_pgt = read_cr3_pa();
> +	early_boot_top_pgt = (unsigned long)p4d_offset(
> +			(pgd_t *)early_boot_top_pgt, 0);
> +	if ((p4d_t *)early_boot_top_pgt == (p4d_t *)_pgtable) {
> +		debug_putstr("booted via startup_32()\n");
> +		pgt_data.pgt_buf = _pgtable + BOOT_INIT_PGT_SIZE;
> +		pgt_data.pgt_buf_size = BOOT_PGT_SIZE - BOOT_INIT_PGT_SIZE;
> +		memset(pgt_data.pgt_buf, 0, pgt_data.pgt_buf_size);
> +	} else {
> +		debug_putstr("booted via startup_64()\n");
> +		pgt_data.pgt_buf = _pgtable;
> +		pgt_data.pgt_buf_size = BOOT_PGT_SIZE;
> +		memset(pgt_data.pgt_buf, 0, pgt_data.pgt_buf_size);
> +	}
> +}
> +
> +/*
> + * Helper for mapping extra memory region in very early stage
> + * before extract and execute the actual kernel
> + */
> +int add_identity_map_pgd(unsigned long pstart, unsigned long pend,
> +			 unsigned long pgd)
> +{
> +	kernel_ident_mapping_init(&mapping_info, (pgd_t *)pgd, pstart, pend);
> +}
> diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
> index 680c320363db..fb37eb98b65d 100644
> --- a/arch/x86/include/asm/boot.h
> +++ b/arch/x86/include/asm/boot.h
> @@ -33,6 +33,8 @@
>  #ifdef CONFIG_X86_64
>  # define BOOT_STACK_SIZE	0x4000
>  
> +/* Reserve one page for possible extra mapping requirement */
> +# define BOOT_EXTRA_PGT_SIZE	(1*4096)
>  # define BOOT_INIT_PGT_SIZE	(6*4096)
>  # ifdef CONFIG_RANDOMIZE_BASE
>  /*
> @@ -43,12 +45,12 @@
>   * Total is 19 pages.
>   */
>  #  ifdef CONFIG_X86_VERBOSE_BOOTUP
> -#   define BOOT_PGT_SIZE	(19*4096)
> +#   define BOOT_PGT_SIZE	((19 * 4096) + BOOT_EXTRA_PGT_SIZE)
>  #  else /* !CONFIG_X86_VERBOSE_BOOTUP */
> -#   define BOOT_PGT_SIZE	(17*4096)
> +#   define BOOT_PGT_SIZE	((17 * 4096) + BOOT_EXTRA_PGT_SIZE)
>  #  endif
>  # else /* !CONFIG_RANDOMIZE_BASE */
> -#  define BOOT_PGT_SIZE		BOOT_INIT_PGT_SIZE
> +#  define BOOT_PGT_SIZE		(BOOT_INIT_PGT_SIZE + BOOT_EXTRA_PGT_SIZE)
>  # endif
>  
>  #else /* !CONFIG_X86_64 */
> -- 
> 2.20.1
> 
