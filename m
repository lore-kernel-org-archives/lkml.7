Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1339C04AB1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 00:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696D22133D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 00:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Up8uv0Ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfELADN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 20:03:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41885 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfELADM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 20:03:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id f12so2532051plt.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 17:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8y80o7oSIlIzTCnyWQkOPMTGAyD56gpaeSiM/jdKK2U=;
        b=Up8uv0Ro+asj6bZpmf+2XYSZWCYr/M9KA7mJrddNqEPkhkzz6kB9OePFPDIeuj1jF3
         tlM3NuPEElrJfHddfeTGU9x8B7GGBsL0Y5eXRSon1D09kzysHRFcZo0q3LeZZLOzVYVH
         RfcHVfW050pkFtmhtxMh+a0Hy0k8c7OB3+p9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8y80o7oSIlIzTCnyWQkOPMTGAyD56gpaeSiM/jdKK2U=;
        b=pmeG2xPKNuIstaJBxYU90m0jQ4us3UVcjkiqiMCVpebji+C5wDTHoIjRgfHUhvqBD4
         +VBvvScZNt75+v4U2vLOHUmrGHyI+y4ubDqk4Ijr0nS/oY1h6//n6c3gJAB4z0dBox0t
         dEqi9MvbGl0Nb8sdmiN/SNKQokn4j4e9w98uxlD5pc6Z4KbjZZM73Zvc4xpg9I7eMiPr
         3xrHCnt9wt1+r3GGut6FGBiRPd9Jclm6cGdnFfv+M4fAleJccOba+MWVtZh485cQBPg2
         f2bxADDI5EV0v3CAdsVX+VrkI8C3uva5oQvuL4icvfh70RNxWfpPkvxvq1H7bqvZT/Bp
         7rNA==
X-Gm-Message-State: APjAAAXnx2KSED6KLuqa2rkbAeCCgmv7f5tGnqSxvWFvG/iHyQPhYKoV
        iaLfbK7Juy6If01hCCT5iWl4muC9OP4=
X-Google-Smtp-Source: APXvYqxtx4VJGXAcuH5FPuxZUKyt1J+9kXgxIg3zd31hyQBxk+z4yP1VTgYtwocA/1N3fyOW6tfLQQ==
X-Received: by 2002:a17:902:b410:: with SMTP id x16mr21770482plr.174.1557619391706;
        Sat, 11 May 2019 17:03:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l1sm11146220pgp.9.2019.05.11.17.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 May 2019 17:03:10 -0700 (PDT)
Date:   Sat, 11 May 2019 17:03:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usercopy: Remove HARDENED_USERCOPY_PAGESPAN
Message-ID: <201905111657.76FE0BDCEC@keescook>
References: <201905101341.A17DDD7@keescook>
 <ead5e4ad-d911-3680-04a4-ae98507ba48c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ead5e4ad-d911-3680-04a4-ae98507ba48c@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 08:41:43PM -0400, Laura Abbott wrote:
> On 5/10/19 3:43 PM, Kees Cook wrote:
> > This feature continues to cause more problems than it solves[1]. Its
> > intention was to check the bounds of page-allocator allocations by using
> > __GFP_COMP, for which we would need to find all missing __GFP_COMP
> > markings. This work has been on hold and there is an argument[2]
> > that such markings are not even the correct signal for checking for
> > same-allocation pages. Instead of depending on BROKEN, this just removes
> > it entirely. It can be trivially reverted if/when a better solution for
> > tracking page allocator sizes is found.
> > 
> > [1] https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg37479.html
> > [2] https://lkml.kernel.org/r/20190415022412.GA29714@bombadil.infradead.org
> > 
> > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   mm/usercopy.c    | 67 ------------------------------------------------
> >   security/Kconfig | 11 --------
> >   2 files changed, 78 deletions(-)
> > 
> > diff --git a/mm/usercopy.c b/mm/usercopy.c
> > index 14faadcedd06..15dc1bf03303 100644
> > --- a/mm/usercopy.c
> > +++ b/mm/usercopy.c
> > @@ -159,70 +159,6 @@ static inline void check_bogus_address(const unsigned long ptr, unsigned long n,
> >   		usercopy_abort("null address", NULL, to_user, ptr, n);
> >   }
> > -/* Checks for allocs that are marked in some way as spanning multiple pages. */
> > -static inline void check_page_span(const void *ptr, unsigned long n,
> > -				   struct page *page, bool to_user)
> > -{
> > -#ifdef CONFIG_HARDENED_USERCOPY_PAGESPAN
> > -	const void *end = ptr + n - 1;
> > -	struct page *endpage;
> > -	bool is_reserved, is_cma;
> > -
> > -	/*
> > -	 * Sometimes the kernel data regions are not marked Reserved (see
> > -	 * check below). And sometimes [_sdata,_edata) does not cover
> > -	 * rodata and/or bss, so check each range explicitly.
> > -	 */
> > -
> > -	/* Allow reads of kernel rodata region (if not marked as Reserved). */
> > -	if (ptr >= (const void *)__start_rodata &&
> > -	    end <= (const void *)__end_rodata) {
> > -		if (!to_user)
> > -			usercopy_abort("rodata", NULL, to_user, 0, n);
> > -		return;
> > -	}
> > -
> > -	/* Allow kernel data region (if not marked as Reserved). */
> > -	if (ptr >= (const void *)_sdata && end <= (const void *)_edata)
> > -		return;
> > -
> > -	/* Allow kernel bss region (if not marked as Reserved). */
> > -	if (ptr >= (const void *)__bss_start &&
> > -	    end <= (const void *)__bss_stop)
> > -		return;
> > -
> 
> 
> I agree the page spanning is broken but is it worth keeping the
> checks against __rodata __bss etc.?

They're all just white-listing later checks (except RODATA which is
doing a cheap RO test which is redundant on any architecture with actual
rodata...) so they don't have any value in staying without the rest of
the page allocator logic.

> 
> > -	/* Is the object wholly within one base page? */
> > -	if (likely(((unsigned long)ptr & (unsigned long)PAGE_MASK) ==
> > -		   ((unsigned long)end & (unsigned long)PAGE_MASK)))
> > -		return;
> > -
> > -	/* Allow if fully inside the same compound (__GFP_COMP) page. */
> > -	endpage = virt_to_head_page(end);
> > -	if (likely(endpage == page))
> > -		return;
> > -
> > -	/*
> > -	 * Reject if range is entirely either Reserved (i.e. special or
> > -	 * device memory), or CMA. Otherwise, reject since the object spans
> > -	 * several independently allocated pages.
> > -	 */
> > -	is_reserved = PageReserved(page);
> > -	is_cma = is_migrate_cma_page(page);
> > -	if (!is_reserved && !is_cma)
> > -		usercopy_abort("spans multiple pages", NULL, to_user, 0, n);
> > -
> > -	for (ptr += PAGE_SIZE; ptr <= end; ptr += PAGE_SIZE) {
> > -		page = virt_to_head_page(ptr);
> > -		if (is_reserved && !PageReserved(page))
> > -			usercopy_abort("spans Reserved and non-Reserved pages",
> > -				       NULL, to_user, 0, n);
> > -		if (is_cma && !is_migrate_cma_page(page))
> > -			usercopy_abort("spans CMA and non-CMA pages", NULL,
> > -				       to_user, 0, n);
> > -	}

We _could_ keep the mixed CMA/reserved/neither check if we really wanted
to, but that's such a corner case of a corner case, I'm not sure it's
worth doing the virt_to_head_page() across the whole span to figure
it out.

I really wish we had size of allocation reliably held somewhere. We'll
need it for doing memory tagging of the page allocator too...

-- 
Kees Cook
