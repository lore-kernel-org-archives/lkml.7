Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F349AC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F522070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbfIENy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:54:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730303AbfIENyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:54:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1CD3FC057EC0;
        Thu,  5 Sep 2019 13:54:55 +0000 (UTC)
Received: from localhost (ovpn-12-28.pek2.redhat.com [10.72.12.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25B77600CC;
        Thu,  5 Sep 2019 13:54:53 +0000 (UTC)
Date:   Thu, 5 Sep 2019 21:54:51 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] x86/mm/KASLR: Cleanup calculation for direct
 mapping size
Message-ID: <20190905135451.GD20805@MiWiFi-R3L-srv>
References: <20190830214707.1201-1-msys.mizuma@gmail.com>
 <20190830214707.1201-5-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830214707.1201-5-msys.mizuma@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 05 Sep 2019 13:54:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/19 at 05:47pm, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> Cleanup calculation for direct mapping size.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  arch/x86/mm/kaslr.c | 50 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 35 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index dc6182eec..8e5f3642e 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -70,15 +70,45 @@ static inline bool kaslr_memory_enabled(void)
>  	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
>  }
>  
> +/*
> + * Even though a huge virtual address space is reserved for the direct
> + * mapping of physical memory, e.g in 4-level paging mode, it's 64TB,
> + * rare system can own enough physical memory to use it up, most are
> + * even less than 1TB. So with KASLR enabled, we adapt the size of
> + * direct mapping area to the size of actual physical memory plus the
> + * configured padding CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING.
> + * The left part will be taken out to join memory randomization.
> + */
> +static inline unsigned long calc_direct_mapping_size(void)

I think patch 4 and 5 can be merged, just keep one
calc_direct_mapping_size() to do the mapping size calculation for the
direct mapping section, it's not that complicated. Adding
phys_memmap_size() makes it a little redundent, in my opinion.

Thanks
Baoquan

> +{
> +	unsigned long size_tb, memory_tb;
> +
> +	/*
> +	 * Update Physical memory mapping to available and
> +	 * add padding if needed (especially for memory hotplug support).
> +	 */
> +	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
> +		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
> +
> +	size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
> +
> +	/*
> +	 * Adapt physical memory region size based on available memory
> +	 */
> +	if (memory_tb < size_tb)
> +		size_tb = memory_tb;
> +
> +	return size_tb;
> +}
> +
>  /* Initialize base and padding for each memory region randomized with KASLR */
>  void __init kernel_randomize_memory(void)
>  {
> -	size_t i;
> -	unsigned long vaddr_start, vaddr;
> -	unsigned long rand, memory_tb;
> -	struct rnd_state rand_state;
> +	unsigned long vaddr_start, vaddr, rand;
>  	unsigned long remain_entropy;
>  	unsigned long vmemmap_size;
> +	struct rnd_state rand_state;
> +	size_t i;
>  
>  	vaddr_start = pgtable_l5_enabled() ? __PAGE_OFFSET_BASE_L5 : __PAGE_OFFSET_BASE_L4;
>  	vaddr = vaddr_start;
> @@ -95,20 +125,10 @@ void __init kernel_randomize_memory(void)
>  	if (!kaslr_memory_enabled())
>  		return;
>  
> -	kaslr_regions[0].size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
> +	kaslr_regions[0].size_tb = calc_direct_mapping_size();
>  	kaslr_regions[1].size_tb = VMALLOC_SIZE_TB;
>  
> -	/*
> -	 * Update Physical memory mapping to available and
> -	 * add padding if needed (especially for memory hotplug support).
> -	 */
>  	BUG_ON(kaslr_regions[0].base != &page_offset_base);
> -	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
> -		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
> -
> -	/* Adapt phyiscal memory region size based on available memory */
> -	if (memory_tb < kaslr_regions[0].size_tb)
> -		kaslr_regions[0].size_tb = memory_tb;
>  
>  	/*
>  	 * Calculate the vmemmap region size in TBs, aligned to a TB
> -- 
> 2.18.1
> 
