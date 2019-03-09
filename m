Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3954DC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22DA20868
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m9ayY6z/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfCIDwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 22:52:34 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36683 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfCIDwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 22:52:34 -0500
Received: by mail-it1-f196.google.com with SMTP id v83so24435592itf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 19:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m377kZJyLVBelvFNmvVkrDdNPU+nsXM2F8Z21iX0YCQ=;
        b=m9ayY6z/EzLJdpsqf0ARQ566h+fNvCK43sc+5RsrKitBH7l5IJYnyxlVcknqGnusWm
         8TImiEA0X5wRp3f/WwfSofXpUBq0c3qgw+Y2wFaZBQo7LBl8E74BezC+JelThr8zR9vI
         eXsReEoRW6yjw4vwYV/ysGsz0oWGP+YtMAAiWcGOt7mJ0iXbuQSf2Wu3fxyQlrCRfrc7
         Gfoe6yYd2LjcztJi7lssLpYsp5FbeuckI6Y8DKDyuD52nfWkYUyh6Y6MPW3tDGMcTlN3
         PjT4U5nwWQ9kNQTSwfKeomhDAc+f1VEWOnQICfQTktrA3mtrIZUZdNq7nVaUtDirbyXF
         xRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m377kZJyLVBelvFNmvVkrDdNPU+nsXM2F8Z21iX0YCQ=;
        b=mkW6X2AKqq0TW4EOD6C9DjVnFHOT8ZE22ATXwby8YgD24MUY9fGCTuc/2oLS8G3jr2
         w5BEGn98XoSU3mUfWUrkGt3/hh24UHDacR9L3niiundX+Blq8oDjpQWZrcT4Imhf3fcE
         19uAOwZVmi3W6uu8NxEzyDaejC6C5/rP9AS+lacm9cvz6E17QSpTPgQAjdlT0i1jHXO3
         p48MhtTCpaY44orMoikytJIZAwbXU8zKSPecIrE+hU/ZAPQXCSUS9vMSzGFlp/9Fw26Q
         mm6mad90/b4UWVjSyVfmvWoCCb0PoRlbRIng8rX2v4Tc61RaLUeEV1O8uS1YNvYjujZE
         pHLg==
X-Gm-Message-State: APjAAAVlZyO0Df6KIIzv7UFhRX/+HLy28+E97sQowSiGUp7BjP3IDbA/
        lGkVobJ2ONSt6T34XRbZjYiUrg==
X-Google-Smtp-Source: APXvYqwCbLxEH0MAwR0zOVXRARtteHVK25Cgv6im4wYGYLl/7gE17TQQw41o7bgV8bkBqOTUfLBQwQ==
X-Received: by 2002:a24:38f:: with SMTP id e137mr8855070ite.99.1552103552925;
        Fri, 08 Mar 2019 19:52:32 -0800 (PST)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id n4sm3928063ioa.26.2019.03.08.19.52.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 08 Mar 2019 19:52:32 -0800 (PST)
Date:   Fri, 8 Mar 2019 20:52:27 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] arm64: mm: don't call page table ctors for init_mm
Message-ID: <20190309035227.GA214016@google.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
 <20190218231319.178224-2-yuzhao@google.com>
 <20190226151307.GB20230@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226151307.GB20230@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 03:13:07PM +0000, Mark Rutland wrote:
> Hi,
> 
> On Mon, Feb 18, 2019 at 04:13:18PM -0700, Yu Zhao wrote:
> > init_mm doesn't require page table lock to be initialized at
> > any level. Add a separate page table allocator for it, and the
> > new one skips page table ctors.
> 
> Just to check, in a previous reply you mentioned we need to call the
> ctors for our efi_mm, since we use apply_to_page_range() on that. Is
> that only because apply_to_pte_range() tries to take the ptl for non
> init_mm?

Precisely.

> ... or did I miss something else?
> 
> > The ctors allocate memory when ALLOC_SPLIT_PTLOCKS is set. Not
> > calling them avoids memory leak in case we call pte_free_kernel()
> > on init_mm.
> > 
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> 
> Assuming that was all, this patch makes sense to me. FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks.

> Thanks,
> Mark.
> 
> > ---
> >  arch/arm64/mm/mmu.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index fa7351877af3..e8bf8a6300e8 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -370,6 +370,16 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> >  	} while (pgdp++, addr = next, addr != end);
> >  }
> >  
> > +static phys_addr_t pgd_kernel_pgtable_alloc(int shift)
> > +{
> > +	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
> > +	BUG_ON(!ptr);
> > +
> > +	/* Ensure the zeroed page is visible to the page table walker */
> > +	dsb(ishst);
> > +	return __pa(ptr);
> > +}
> > +
> >  static phys_addr_t pgd_pgtable_alloc(int shift)
> >  {
> >  	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
> > @@ -591,7 +601,7 @@ static int __init map_entry_trampoline(void)
> >  	/* Map only the text into the trampoline page table */
> >  	memset(tramp_pg_dir, 0, PGD_SIZE);
> >  	__create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
> > -			     prot, pgd_pgtable_alloc, 0);
> > +			     prot, pgd_kernel_pgtable_alloc, 0);
> >  
> >  	/* Map both the text and data into the kernel page table */
> >  	__set_fixmap(FIX_ENTRY_TRAMP_TEXT, pa_start, prot);
> > @@ -1067,7 +1077,8 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
> >  		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> >  
> >  	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> > -			     size, PAGE_KERNEL, pgd_pgtable_alloc, flags);
> > +			     size, PAGE_KERNEL, pgd_kernel_pgtable_alloc,
> > +			     flags);
> >  
> >  	return __add_pages(nid, start >> PAGE_SHIFT, size >> PAGE_SHIFT,
> >  			   altmap, want_memblock);
> > -- 
> > 2.21.0.rc0.258.g878e2cd30e-goog
> > 
