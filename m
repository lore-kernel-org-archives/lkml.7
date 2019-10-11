Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E338EECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A7220673
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfJKSSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 14:18:38 -0400
Received: from foss.arm.com ([217.140.110.172]:39392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728721AbfJKSSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:18:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9AF2142F;
        Fri, 11 Oct 2019 11:18:37 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E19183F703;
        Fri, 11 Oct 2019 11:18:35 -0700 (PDT)
Subject: Re: [PATCH v6 08/17] arm64: hibernate: add trans_pgd public functions
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
 <20191004185234.31471-9-pasha.tatashin@soleen.com>
From:   James Morse <james.morse@arm.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com
Message-ID: <2ea69969-154d-fa55-767d-43ea8971dd0e@arm.com>
Date:   Fri, 11 Oct 2019 19:18:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191004185234.31471-9-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 04/10/2019 19:52, Pavel Tatashin wrote:
> trans_pgd_create_copy() and trans_pgd_map_page() are going to be
> the basis for new shared code that handles page tables for cases
> which are between kernels: kexec, and hibernate.
> 
> Note: Eventually, get_safe_page() will be moved into a function pointer
> passed via argument, but for now keep it as is.


> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index ce60bceed357..ded9034b9d39 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c

> @@ -242,6 +218,44 @@ static int create_safe_exec_page(void *src_start, size_t length,

> +/*
> + * Copies length bytes, starting at src_start into an new page,
> + * perform cache maintenance, then maps it at the specified address low
> + * address as executable.
> + *
> + * This is used by hibernate to copy the code it needs to execute when
> + * overwriting the kernel text. This function generates a new set of page
> + * tables, which it loads into ttbr0.
> + *
> + * Length is provided as we probably only want 4K of data, even on a 64K
> + * page system.
> + */
> +static int create_safe_exec_page(void *src_start, size_t length,
> +				 unsigned long dst_addr,
> +				 phys_addr_t *phys_dst_addr)
> +{
> +	void *page = (void *)get_safe_page(GFP_ATOMIC);
> +	pgd_t *trans_pgd;
> +	int rc;
> +
> +	if (!page)
> +		return -ENOMEM;
> +
> +	memcpy(page, src_start, length);
> +	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
> +
> +	trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
> +	if (!trans_pgd)
> +		return -ENOMEM;
> +
> +	rc = trans_pgd_map_page(trans_pgd, page, dst_addr,
> +				PAGE_KERNEL_EXEC);
> +	if (rc)
> +		return rc;
> +
>  	/*
>  	 * Load our new page tables. A strict BBM approach requires that we
>  	 * ensure that TLBs are free of any entries that may overlap with the

(I suspect you are going to to duplicate this in the kexec code. Kexec has the same
pattern: instructions that have to be copied to do the relocation of the rest of memory)


> @@ -462,6 +476,24 @@ static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,

> +int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
> +			  unsigned long end)
> +{
> +	int rc;
> +	pgd_t *trans_pgd = (pgd_t *)get_safe_page(GFP_ATOMIC);
> +
> +	if (!trans_pgd) {
> +		pr_err("Failed to allocate memory for temporary page tables.\n");
> +		return -ENOMEM;
> +	}
> +
> +	rc = copy_page_tables(trans_pgd, start, end);
> +	if (!rc)
> +		*dst_pgdp = trans_pgd;

*dst_pgdp was already allocated in swsusp_arch_resume().


> +
> +	return rc;
> +}
> +
>  /*
>   * Setup then Resume from the hibernate image using swsusp_arch_suspend_exit().
>   *
> @@ -488,7 +520,7 @@ int swsusp_arch_resume(void)
>  		pr_err("Failed to allocate memory for temporary page tables.\n");
>  		return -ENOMEM;
>  	}

If the allocation moves into 'trans_pgd_create_copy()', please move the code just above
here (cut off by the diff) that allocates it in swsusp_arch_resume().

Its actually okay to leak memory like this, hibernate's allocator acts as a memory pool.
It either gets freed if we fail to resume, or vanishes when the resumed kernel takes over.

Reviewed-by: James Morse <james.morse@arm.com>


> -	rc = copy_page_tables(tmp_pg_dir, PAGE_OFFSET, PAGE_END);
> +	rc = trans_pgd_create_copy(&tmp_pg_dir, PAGE_OFFSET, PAGE_END);
>  	if (rc)
>  		return rc;


Thanks,

James
