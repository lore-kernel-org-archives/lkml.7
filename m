Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DE9C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E6020705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578494449;
	bh=W3XU/GMv+6uRzWowtVIdqgj36lNGNaFQwEDB2XAiKZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mX2nlF4/LUtl1eoDmZhjyrJSxGEr+QG1fE9+y99bZw1HKFeNUJqyIlM4LoowBhUpE
	 ZYI/0OfraCo8Xs5LrGwnymOj3SsaHzp3gCOz8tV3K3Jqt75sClGB2D85DvhSn0X4xl
	 OUBSMDPYf01myF85jN1fekG+6IsKiiwHPa3t0mD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgAHOks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:40:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41706 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgAHOkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:40:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so3615917wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 06:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kj3sdKsTZaeIbGwmm89PcRIOcawKHePAIrmjBLLY4Uw=;
        b=pLliBDHMSB1mixddfzOHsUohwvyY+a9GXGHjUWIbnQYjedQNB+5ksBqbvaGIKY5y5y
         RI98+Wt4TtfWeiHuz5bmJ4I54AKPjFV/SfSCxhRDsHmEHMxLSrqW4n709aQ7j905Ai8s
         bsYWcBb37Fx8BrkkKJQZX5vvdh/HDuDDCeiBnMTAemm0oqfg/BDowGfcEgxUbYD3sD3I
         O3MXCUko4fVF3cvpGnEVM189Qt92JLMHt1EH+Kh0l09eoztEQT8aVrgqcIbWbQB+t4Tv
         VwymeVnBhZruJJuEKnW3SjRkbbyisWzLFBhglHQF/alIlkJvBvdP2X4V93CT0Oq8vCN0
         Jeig==
X-Gm-Message-State: APjAAAWOTxy630/7KtwBZayxJIKNgQqab93sKHW11VPL4J7Nvf968NXh
        //0LO4T9YO2LhgzWwDD1nDrt+aWq
X-Google-Smtp-Source: APXvYqz4mHG7mUJHfog9TrthVEXEGMiJMAUt0zcWnEcdnAdrTfaZ5UARWF/oHyOf5XJSPt7w0+vigQ==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr4958200wru.154.1578494446291;
        Wed, 08 Jan 2020 06:40:46 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id a1sm3971016wmj.40.2020.01.08.06.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 06:40:44 -0800 (PST)
Date:   Wed, 8 Jan 2020 15:40:44 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        "Jin, Zhi" <zhi.jin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm/page_alloc: Skip non present sections on zone
 initialization
Message-ID: <20200108144044.GB30379@dhcp22.suse.cz>
References: <20191230093828.24613-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230093828.24613-1-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-12-19 12:38:28, Kirill A. Shutemov wrote:
> memmap_init_zone() can be called on the ranges with holes during the
> boot. It will skip any non-valid PFNs one-by-one. It works fine as long
> as holes are not too big.
> 
> But huge holes in the memory map causes a problem. It takes over 20
> seconds to walk 32TiB hole. x86-64 with 5-level paging allows for much
> larger holes in the memory map which would practically hang the system.
> 
> Deferred struct page init doesn't help here. It only works on the
> present ranges.
> 
> Skipping non-present sections would fix the issue.

Makes sense to me.

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

That pfn inc back and forth is quite ugly TBH but whatever.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> 
> The situation can be emulated using the following QEMU patch:
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index ac08e6360437..f5f2258092e1 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1159,13 +1159,14 @@ void pc_memory_init(PCMachineState *pcms,
>      memory_region_add_subregion(system_memory, 0, ram_below_4g);
>      e820_add_entry(0, x86ms->below_4g_mem_size, E820_RAM);
>      if (x86ms->above_4g_mem_size > 0) {
> +        int shift = 45;
>          ram_above_4g = g_malloc(sizeof(*ram_above_4g));
>          memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g", ram,
>                                   x86ms->below_4g_mem_size,
>                                   x86ms->above_4g_mem_size);
> -        memory_region_add_subregion(system_memory, 0x100000000ULL,
> +        memory_region_add_subregion(system_memory, 1ULL << shift,
>                                      ram_above_4g);
> -        e820_add_entry(0x100000000ULL, x86ms->above_4g_mem_size, E820_RAM);
> +        e820_add_entry(1ULL << shift, x86ms->above_4g_mem_size, E820_RAM);
>      }
>  
>      if (!pcmc->has_reserved_memory &&
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index cde2a16b941a..694c26947bf6 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1928,7 +1928,7 @@ uint64_t cpu_get_tsc(CPUX86State *env);
>  /* XXX: This value should match the one returned by CPUID
>   * and in exec.c */
>  # if defined(TARGET_X86_64)
> -# define TCG_PHYS_ADDR_BITS 40
> +# define TCG_PHYS_ADDR_BITS 52
>  # else
>  # define TCG_PHYS_ADDR_BITS 36
>  # endif
> 
> ---
>  mm/page_alloc.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index df62a49cd09e..442dc0244bb4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5873,6 +5873,30 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
>  	return false;
>  }
>  
> +#ifdef CONFIG_SPARSEMEM
> +/* Skip PFNs that belong to non-present sections */
> +static inline __meminit unsigned long next_pfn(unsigned long pfn)
> +{
> +	unsigned long section_nr;
> +
> +	section_nr = pfn_to_section_nr(++pfn);
> +	if (present_section_nr(section_nr))
> +		return pfn;
> +
> +	while (++section_nr <= __highest_present_section_nr) {
> +		if (present_section_nr(section_nr))
> +			return section_nr_to_pfn(section_nr);
> +	}
> +
> +	return -1;
> +}
> +#else
> +static inline __meminit unsigned long next_pfn(unsigned long pfn)
> +{
> +	return pfn++;
> +}
> +#endif
> +
>  /*
>   * Initially all pages are reserved - free ones are freed
>   * up by memblock_free_all() once the early boot process is
> @@ -5912,8 +5936,10 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>  		 * function.  They do not exist on hotplugged memory.
>  		 */
>  		if (context == MEMMAP_EARLY) {
> -			if (!early_pfn_valid(pfn))
> +			if (!early_pfn_valid(pfn)) {
> +				pfn = next_pfn(pfn) - 1;
>  				continue;
> +			}
>  			if (!early_pfn_in_nid(pfn, nid))
>  				continue;
>  			if (overlap_memmap_init(zone, &pfn))
> -- 
> 2.24.1
> 

-- 
Michal Hocko
SUSE Labs
