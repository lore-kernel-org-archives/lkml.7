Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D886ECA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18F920856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iloSQ2AV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390170AbfJ2Pzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 11:55:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42859 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389829AbfJ2Pzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 11:55:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id z17so14281915qts.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 08:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LGwykVF9eGmzrxMoRYX/+TwYLyPzfUHHZXh1lGqHxQY=;
        b=iloSQ2AV2S/tTN4EsntXbSuRf06EUey384Z82+KXsRv4S7Q1E0H0ctYXMeRT9ICtwa
         iezJohJ8Bi+5UJsBsVJ39Vw6q59mUqe9ZNg+egomwpH4cGayH2mngHGayI8ojp6GfNf2
         OmFORgMr/96TYt1CRM5mm6zaxxIIQ+2BIG4HCaAnO/sNoNVtzyhvZshm0aKtOux/t85C
         f+yUZOTvE5sedLWQegK2vqUdUUAvCenwvOBy3mVn7/FhbLJ5STXaboNm01wBSROrkecZ
         xoM/WzyVTDVbIWNnLPptPmafgatKeLiQJKMPrPnDQ19XP7cyG6A7K/lkzakvEI71928A
         aN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LGwykVF9eGmzrxMoRYX/+TwYLyPzfUHHZXh1lGqHxQY=;
        b=dQpe7GF+i141IIqjhSWOikGGKO6paMNJrjsnXkx7ahzy62G7CKFQR7DYvDKPy1BkPO
         2dSwnr8II/fjIXFYqS6zv4XBU8fYUvkya5FLCqh51lFcQG7PFLZ8Ls9dEDlcipkhi57H
         mls8/pVPEhx7IoBAPP4o79quzrFJBRmDI3xNyyZ3O+dvd+iuA+HJAcd4MHLtLEPZGFui
         tUk3IyS7UUftKpPtkDj9WnytTvN1XhtwenajDde2lHutM4A+QRR5JzOEElT1ZutirWFQ
         uA3caffGkGKZPrxlK2FJ1of7E+/uQturDzgTgqmtDlVgYAQY9QpwrCHVMsDAtiuFU16Y
         taNA==
X-Gm-Message-State: APjAAAX16YkpdZDn7+ZFggXg1qV1Of6exeRGbW6/9WdUS5/KoF6Kfncn
        13QaKzuDtEtfOWpkQ1GSoA==
X-Google-Smtp-Source: APXvYqw5rQFUF8BhTc9qJfAsOZAfsx0CrySwHjZDuSHrKeh+22V8YemeVcWnUdvK/wgfAzNcnguqXg==
X-Received: by 2002:ac8:444c:: with SMTP id m12mr5134501qtn.266.1572364545766;
        Tue, 29 Oct 2019 08:55:45 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b9sm3046654qkk.61.2019.10.29.08.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 08:55:45 -0700 (PDT)
Date:   Tue, 29 Oct 2019 11:55:39 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] x86/mm/KASLR: Cleanup calculation for direct
 mapping size
Message-ID: <20191029155538.qvvp6j7cqjig45oc@gabell>
References: <20190830214707.1201-1-msys.mizuma@gmail.com>
 <20190830214707.1201-5-msys.mizuma@gmail.com>
 <20190905135451.GD20805@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905135451.GD20805@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 09:54:51PM +0800, Baoquan He wrote:
> On 08/30/19 at 05:47pm, Masayoshi Mizuma wrote:
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > 
> > Cleanup calculation for direct mapping size.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > ---
> >  arch/x86/mm/kaslr.c | 50 +++++++++++++++++++++++++++++++--------------
> >  1 file changed, 35 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> > index dc6182eec..8e5f3642e 100644
> > --- a/arch/x86/mm/kaslr.c
> > +++ b/arch/x86/mm/kaslr.c
> > @@ -70,15 +70,45 @@ static inline bool kaslr_memory_enabled(void)
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
> 
> I think patch 4 and 5 can be merged, just keep one
> calc_direct_mapping_size() to do the mapping size calculation for the
> direct mapping section, it's not that complicated. Adding
> phys_memmap_size() makes it a little redundent, in my opinion.

Thanks, I'll merge patch 4 and 5.

- Masa

> 
> Thanks
> Baoquan
> 
> > +{
> > +	unsigned long size_tb, memory_tb;
> > +
> > +	/*
> > +	 * Update Physical memory mapping to available and
> > +	 * add padding if needed (especially for memory hotplug support).
> > +	 */
> > +	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
> > +		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
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
> > @@ -95,20 +125,10 @@ void __init kernel_randomize_memory(void)
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
> > 2.18.1
> > 
