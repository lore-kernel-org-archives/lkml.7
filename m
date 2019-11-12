Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7E7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281AB21783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3AEQBxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfKLUrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:47:15 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46320 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfKLUrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:47:15 -0500
Received: by mail-qt1-f195.google.com with SMTP id r20so7255679qtp.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 12:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G8vn8K8yf3KdYtdZ+l67xvjrVMvoEOqcBLvRFufvaC0=;
        b=D3AEQBxlZMle+Qlfga/0SunccwFXMBPRR37fdO/sA6Wf8HrifNzxIvVxjwnzmm0CC8
         b0uz3ZQbNAgEttShyYJFl+PK9QJOkITRlHdjJuZzq2vfjk3wYRoB/6svg5f4tHNcSebn
         ILQMK8r4zJtupKTYE2m6fhU85JPvnFbbd8/NhG19wlr1H9LXDSezdXYt8lKHYPYhyPQi
         yozFKcPwYcDR+ic16yhy/nzD9JJYKtr3EDFhyP27X8os54mlhGKn7MG7Q8sJULv7GHyf
         7Vn/A6GOTLdta8TQjhXjySPt5296t6WUNFvWX10k2J9/ZGavhYVB8CiFlmzibSiDYPlV
         rx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G8vn8K8yf3KdYtdZ+l67xvjrVMvoEOqcBLvRFufvaC0=;
        b=eAsjmrZVmi3vYa+tThiO23j1utONlzWrCz++uZPmeigmzI1HOnqnpq9Ro7+bRMN/Lf
         MSy0C3A5W5ognX2PCfS1YzkJzSS47SWvtIDlZm3Vk/i9YS+Yk0I04E2wgsVMazG7iS9h
         ckbNkdKzlvq35cCZlUfFPIGxFYm9RhTC/49dlW4dLMHVgZwaVX6Wlr7c0TgJjIQbgyKA
         JbbkhQdmwxsrGQk/F2VgvC5D9p7lj9z+cHlyExKCg5D7A7l5Jr63Q1HtQ2uo8HqqSz8m
         SbL0NuUfvXhzs5TOF2f56zAMSrztZ8jogU7V/LGmpUyVw1P53gYD3nM8dc1CLH8SACfd
         Slrw==
X-Gm-Message-State: APjAAAWN2U0WC53/Btup2JjzkX2GcEJvrn9ta1+Agt+rAPltCsOTwTa8
        WYNZqbcBqCm2gESw9SBawQ==
X-Google-Smtp-Source: APXvYqyLsYW7PJMI9dfkzqXRVcxtUOXuwEDrLpvNjc4+Bhy/HKjwtfbrSdgUqT+x3/CY7QxMyZxAsA==
X-Received: by 2002:ac8:53c5:: with SMTP id c5mr4994869qtq.348.1573591634270;
        Tue, 12 Nov 2019 12:47:14 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id q3sm10156946qkf.18.2019.11.12.12.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 12:47:13 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:47:08 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] x86/mm/KASLR: Adjust the padding size for the
 direct  mapping.
Message-ID: <20191112204707.jyruwkb4pbdj3jvv@gabell>
References: <20191102010911.21460-1-msys.mizuma@gmail.com>
 <20191102010911.21460-5-msys.mizuma@gmail.com>
 <20191104004825.GK7616@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104004825.GK7616@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 08:48:25AM +0800, Baoquan He wrote:
> On 11/01/19 at 09:09pm, Masayoshi Mizuma wrote:
> > ---
> >  arch/x86/mm/kaslr.c | 65 ++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 50 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> > index dc6182eec..a80eed563 100644
> > --- a/arch/x86/mm/kaslr.c
> > +++ b/arch/x86/mm/kaslr.c
> > @@ -70,15 +70,60 @@ static inline bool kaslr_memory_enabled(void)
> >  	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
> >  }
> >  
> > +/*
> > + * Even though a huge virtual address space is reserved for the direct
> > + * mapping of physical memory, e.g in 4-level paging mode, it's 64TB,
> > + * rare system can own enough physical memory to use it up, most are
> > + * even less than 1TB. So with KASLR enabled, we adapt the size of
> > + * direct mapping area to the size of actual physical memory plus the
> > + * configured padding CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING.
> > + * The left part will be taken out to join memory randomization.
> > + */
> > +static inline unsigned long calc_direct_mapping_size(void)
> > +{
> > +	unsigned long padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
> > +	unsigned long size_tb, memory_tb;
> > +#ifdef CONFIG_MEMORY_HOTPLUG
> > +	unsigned long actual, maximum, base;
> > +
> > +	if (boot_params.max_addr) {
> > +		/*
> > +		 * The padding size should set to get for kaslr_regions[].base
> > +		 * bigger address than the maximum memory address the system can
> > +		 * have. kaslr_regions[].base points "actual size + padding" or
> > +		 * higher address. If "actual size + padding" points the lower
> > +		 * address than the maximum memory size, fix the padding size.
> > +		 */
> > +		actual = roundup(PFN_PHYS(max_pfn), 1UL << TB_SHIFT);
> > +		maximum = roundup(boot_params.max_addr, 1UL << TB_SHIFT);
> > +		base = actual + (padding << TB_SHIFT);
> > +
> > +		if (maximum > base)
> > +			padding = (maximum - actual) >> TB_SHIFT;
> > +	}
> > +#endif
> > +	memory_tb =  DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
> > +			padding;
> 
> Yes, wrapping up the whole adjusting code block for the direct mapping
> area into a function looks much better. This was also suggested by Ingo
> when I posted UV system issue fix before, just later the UV system issue
> is not seen in the current code.
> 
> However, I have a small concern about the memory_tb calculateion here.
> We can treat the (actual RAM + CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING)
> as the default memory_tb, then check if we need adjst it according to
> boot_params.max_addr. Discarding the local padding variable can make
> code much simpler? And it is a little confusing when mix with the
> later padding concept when doing randomization, I mean the get_padding()
> thing.
> 
> 
> 	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
>                 CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
> 
> 	if (boot_params.max_addr) {
> 		maximum = roundup(boot_params.max_addr, 1UL << TB_SHIFT);
> 
> 		if (maximum > memory_tb)
> 			memory_tb = maximum;
> 	}
> #endif
> 
> Personal opinion. Anyway, this patch looks good to me. Thanks.

Your suggesion makes it simpler, thanks!
So I'll modify calc_direct_mapping_size() as following.
Does it make sense?

static inline unsigned long calc_direct_mapping_size(void)
{
       unsigned long size_tb, memory_tb;

       memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
               CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;

#ifdef CONFIG_MEMORY_HOTPLUG
       if (boot_params.max_addr) {
               unsigned long maximum_tb;

               maximum_tb = DIV_ROUND_UP(boot_params.max_addr,
                               1UL << TB_SHIFT);

               if (maximum_tb > memory_tb)
                       memory_tb = maximum_tb;
       }
#endif
       size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);

       /*
        * Adapt physical memory region size based on available memory
        */
       if (memory_tb < size_tb)
               size_tb = memory_tb;

       return size_tb;
}

Thanks,
Masa

> 
> Thanks
> Baoquan
> 
> 
> > +
> > +	size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
> > +
> > +	/*
> > +	 * Adapt physical memory region size based on available memory
> > +	 */
> > +	if (memory_tb < size_tb)
> > +		size_tb = memory_tb;
> > +
> > +	return size_tb;
> > +}
> > +
> >  /* Initialize base and padding for each memory region randomized with KASLR */
> >  void __init kernel_randomize_memory(void)
> >  {
> > -	size_t i;
> > -	unsigned long vaddr_start, vaddr;
> > -	unsigned long rand, memory_tb;
> > -	struct rnd_state rand_state;
> > +	unsigned long vaddr_start, vaddr, rand;
> >  	unsigned long remain_entropy;
> >  	unsigned long vmemmap_size;
> > +	struct rnd_state rand_state;
> > +	size_t i;
> >  
> >  	vaddr_start = pgtable_l5_enabled() ? __PAGE_OFFSET_BASE_L5 : __PAGE_OFFSET_BASE_L4;
> >  	vaddr = vaddr_start;
> > @@ -95,20 +140,10 @@ void __init kernel_randomize_memory(void)
> >  	if (!kaslr_memory_enabled())
> >  		return;
> >  
> > -	kaslr_regions[0].size_tb = 1 << (MAX_PHYSMEM_BITS - TB_SHIFT);
> > +	kaslr_regions[0].size_tb = calc_direct_mapping_size();
> >  	kaslr_regions[1].size_tb = VMALLOC_SIZE_TB;
> >  
> > -	/*
> > -	 * Update Physical memory mapping to available and
> > -	 * add padding if needed (especially for memory hotplug support).
> > -	 */
> >  	BUG_ON(kaslr_regions[0].base != &page_offset_base);
> > -	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
> > -		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
> > -
> > -	/* Adapt phyiscal memory region size based on available memory */
> > -	if (memory_tb < kaslr_regions[0].size_tb)
> > -		kaslr_regions[0].size_tb = memory_tb;
> >  
> >  	/*
> >  	 * Calculate the vmemmap region size in TBs, aligned to a TB
> > -- 
> > 2.20.1
> > 
> 
