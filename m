Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71676ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D9021D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfJKSWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 14:22:03 -0400
Received: from foss.arm.com ([217.140.110.172]:39556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728472AbfJKSWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:22:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F316142F;
        Fri, 11 Oct 2019 11:22:02 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BFB23F703;
        Fri, 11 Oct 2019 11:21:59 -0700 (PDT)
Subject: Re: [PATCH v6 16/17] arm64: kexec: configure trans_pgd page table for
 kexec
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
 <20191004185234.31471-17-pasha.tatashin@soleen.com>
From:   James Morse <james.morse@arm.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com
Message-ID: <45a2f0b8-5bac-8b5d-d595-f92e9acb27ad@arm.com>
Date:   Fri, 11 Oct 2019 19:21:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191004185234.31471-17-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 04/10/2019 19:52, Pavel Tatashin wrote:
> Configure a page table located in kexec-safe memory that has
> the following mappings:
> 
> 1. identity mapping for text of relocation function with executable
>    permission.
> 2. identity mapping for argument for relocation function.
> 3. linear mappings for all source ranges
> 4. linear mappings for all destination ranges.
> 
> Also, configure el2_vector, that is used to jump to new kernel from EL2 on
> non-VHE kernels.


> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index d5b79d4c7fae..450d8440f597 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -90,6 +90,23 @@ static inline void crash_prepare_suspend(void) {}
>  static inline void crash_post_resume(void) {}
>  #endif
>  
> +#if defined(CONFIG_KEXEC_CORE)
> +/* Global variables for the arm64_relocate_new_kernel routine. */
> +extern const unsigned char arm64_relocate_new_kernel[];
> +extern const unsigned long arm64_relocate_new_kernel_size;
> +
> +/* Body of the vector for escalating to EL2 from relocation routine */
> +extern const unsigned char kexec_el1_sync[];
> +extern const unsigned long kexec_el1_sync_size;

> +#define KEXEC_EL2_VECTOR_TABLE_SIZE	2048


> +#define KEXEC_EL2_SYNC_OFFSET		(KEXEC_EL2_VECTOR_TABLE_SIZE / 2)

Yuck.

Please don't generate one-off vectors like this. Create _all_ of them, and have the ones
that should never happen spin round a branch. Someone will hit one eventually, its a lot
easier to work out what happened if it stops on the first fault, instead of executing junk
and flying off into the weeds.

git grep invalid_vector

Having the vectors at a known offset in the page that does the relocation means you have a
fair idea what happened from just the PC.


> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index fb6138a1c9ff..71479013dd24 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -74,15 +71,124 @@ static void *kexec_page_alloc(void *arg)

> +/*
> + * Map source segments starting from KEXEC_SRC_START, and map destination
> + * segments starting from KEXEC_DST_START, and return size of copy in
> + * *copy_len argument.
> + * Relocation function essentially needs to do:
> + * memcpy(KEXEC_DST_START, KEXEC_SRC_START, copy_len);
> + */
> +static int map_segments(struct kimage *kimage, pgd_t *pgdp,
> +			struct trans_pgd_info *info,
> +			unsigned long *copy_len)
> +{
> +	unsigned long *ptr = 0;
> +	unsigned long dest = 0;
> +	unsigned long src_va = KEXEC_SRC_START;
> +	unsigned long dst_va = KEXEC_DST_START;
> +	unsigned long len = 0;
> +	unsigned long entry, addr;
> +	int rc;
> +
> +	for (entry = kimage->head; !(entry & IND_DONE); entry = *ptr++) {
> +		addr = entry & PAGE_MASK;
> +
> +		switch (entry & IND_FLAGS) {
> +		case IND_DESTINATION:
> +			dest = addr;
> +			break;
> +		case IND_INDIRECTION:
> +			ptr = __va(addr);
> +			if (rc)
> +				return rc;
> +			break;

> +		case IND_SOURCE:
> +			rc = trans_pgd_map_page(info, pgdp, __va(addr),
> +						src_va, PAGE_KERNEL);
> +			if (rc)
> +				return rc;
> +			rc = trans_pgd_map_page(info, pgdp, __va(dest),
> +						dst_va, PAGE_KERNEL);
> +			if (rc)
> +				return rc;
> +			dest += PAGE_SIZE;
> +			src_va += PAGE_SIZE;
> +			dst_va += PAGE_SIZE;
> +			len += PAGE_SIZE;
> +		}

It looks like you're building a swiss cheese.

If you disable RODATA_FULL_DEFAULT_ENABLED, the kernel will use block mappings for the
linear map. This dramatically reduces the amount of memory in use. On Juno running with
39bit/4K, there is typically 6G of contiguous memory with no firmware/uefi holes in it.
This is mapped by 6 1G block mappings, which take up no additional memory.

For the first go at supporting this in mainline please keep as close as possible to the
existing hibernate code. Please use the helpers that copy the linear map.
(if you cant do pa->va in the relocation assembly you'd need to generate a virtually
addressed structure, which could then use hibernate's relocation assembly)

If all this extra code turns out to be a significant performance improvement, I'd like to
see the numbers. We can come back to it after we've got the simplest way of running
kexec's relocation with the MMU on merged.


> +static int mmu_relocate_setup(struct kimage *kimage, unsigned long kern_reloc,
> +			      struct kern_reloc_arg *kern_reloc_arg)
> +{
> +	struct trans_pgd_info info = {
> +		.trans_alloc_page	= kexec_page_alloc,
> +		.trans_alloc_arg	= kimage,
> +	};
> +
> +	pgd_t *trans_ttbr0 = kexec_page_alloc(kimage);
> +	pgd_t *trans_ttbr1 = kexec_page_alloc(kimage);
> +	int rc;
> +
> +	if (!trans_ttbr0 || !trans_ttbr1)
> +		return -ENOMEM;
> +
> +	rc = map_segments(kimage, trans_ttbr1, &info,
> +			  &kern_reloc_arg->copy_len);
> +	if (rc)
> +		return rc;
> +
> +	/* Map relocation function va == pa */
> +	rc = trans_pgd_map_page(&info, trans_ttbr0,  __va(kern_reloc),
> +				kern_reloc, PAGE_KERNEL_EXEC);
> +	if (rc)
> +		return rc;

You can't do this with the page table helpers. We support platforms with no memory in
range of TTBR0's VA space. See dd006da21646f

You will need some idmapped memory to turn the MMU off on a system that booted at EL1.
This will need to be in a set of page tables that the helpers can't easily touch - so it
should only be a single page. (like the arch code's existing idmap - although that may
have been overwritten).

(I have a machine where this is a problem, if I get the time I will have a stab at making
hibernate's safe page idmaped).


>  int machine_kexec_post_load(struct kimage *kimage)
>  {
> +	unsigned long el2_vector = 0;
>  	unsigned long kern_reloc;
>  	struct kern_reloc_arg *kern_reloc_arg;
> +	int rc = 0;
> +
> +	/*
> +	 * Sanity check that relocation function + el2_vector fit into one
> +	 * page.
> +	 */
> +	if (arm64_relocate_new_kernel_size > KEXEC_EL2_VECTOR_TABLE_SIZE) {
> +		pr_err("can't fit relocation function and el2_vector in one page");
> +		return -ENOMEM;
> +	}

If you need them to fit in one page, why are the separate?
hibernate does this as a compile time check.


>  
>  	kern_reloc = page_to_phys(kimage->control_code_page);
>  	memcpy(__va(kern_reloc), arm64_relocate_new_kernel,
>  	       arm64_relocate_new_kernel_size);
>  
> +	/* Setup vector table only when EL2 is available, but no VHE */
> +	if (is_hyp_mode_available() && !is_kernel_in_hyp_mode()) {
> +		el2_vector = kern_reloc + KEXEC_EL2_VECTOR_TABLE_SIZE;
> +		memcpy(__va(el2_vector + KEXEC_EL2_SYNC_OFFSET), kexec_el1_sync,
> +		       kexec_el1_sync_size);
> +	}
> +
>  	kern_reloc_arg = kexec_page_alloc(kimage);
>  	if (!kern_reloc_arg)
>  		return -ENOMEM;

Thanks,

James
