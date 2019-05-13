Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625FAC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2046D208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k+xusdOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfEMVcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 17:32:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38671 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfEMVcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 17:32:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id y2so2431234pfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 14:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qeOtgj/iKlKZY1KTzkXNPoBebeCJwrDC/cCz2qL6pKY=;
        b=k+xusdOxFCNYDua8D0Qk+OrqDt3hw8KPbyEDnUz+QBCvzGHEN9nT+/tT174FKpFWq6
         C+8EXO2qysVFTgenWrGaRB/kHOAdWxrxRt9UPbXEw/8Hp3o9+jdVhQek6eDaye2TK8WI
         ecdwSeL60Rnsk8rCFUHOU6hKb3h6dyHCaFjsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qeOtgj/iKlKZY1KTzkXNPoBebeCJwrDC/cCz2qL6pKY=;
        b=hkqFXMkyIQh5PM2yIqZK5DsLNLP5sFiQoelqVluwACwYHbDS1DKYLbuoRntCOhhcGa
         4mUnpXP9hjv13GWy59Jj9hQ8HBcSM+9ZS8LrT7IvRSst6Xpuij/k04k+p6JVk2zKcbT2
         /ZYLGje8nI2W1jdFZI72p8VMb0nybEcMOS3+WPKJ5jD75A9FneEYmAJk32m6g6AnU1LC
         bAXkHWe1cSAJunPppWnBwCU3w50aQajDcXcCdSviviue6lSAkxRgePGIGxcQctowrcR1
         KF/PBHihp3APTdx7FrX3En0FSDLWnSRtQFR6cbOYpaDqhTjWZJi17C9fjk+p0yLucIBp
         7H4A==
X-Gm-Message-State: APjAAAXWCtM9HB9h2+Q91/yaslC9r0SzBbZv0hXHug0JtOEYxSlhoRMQ
        h0jEcCPirZLoTfI9ZmYB2qxXytVCEE0=
X-Google-Smtp-Source: APXvYqwisR+ufWQiWcK5iJsZgMAsaZ+6dAt/emAZ+QwXTEmcWpJcU265y7vy85/iLmHjOUXlQ9ABXg==
X-Received: by 2002:a63:1d09:: with SMTP id d9mr34287802pgd.289.1557783165765;
        Mon, 13 May 2019 14:32:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h187sm22228363pfc.52.2019.05.13.14.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 14:32:44 -0700 (PDT)
Date:   Mon, 13 May 2019 14:32:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usercopy: Remove HARDENED_USERCOPY_PAGESPAN
Message-ID: <201905131430.541A76A6FE@keescook>
References: <201905101341.A17DDD7@keescook>
 <ead5e4ad-d911-3680-04a4-ae98507ba48c@redhat.com>
 <201905111657.76FE0BDCEC@keescook>
 <20190512041142.GA24542@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512041142.GA24542@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 09:11:42PM -0700, Matthew Wilcox wrote:
> On Sat, May 11, 2019 at 05:03:08PM -0700, Kees Cook wrote:
> > On Fri, May 10, 2019 at 08:41:43PM -0400, Laura Abbott wrote:
> > > On 5/10/19 3:43 PM, Kees Cook wrote:
> > > > This feature continues to cause more problems than it solves[1]. Its
> > > > intention was to check the bounds of page-allocator allocations by using
> > > > __GFP_COMP, for which we would need to find all missing __GFP_COMP
> > > > markings. This work has been on hold and there is an argument[2]
> > > > that such markings are not even the correct signal for checking for
> > > > same-allocation pages. Instead of depending on BROKEN, this just removes
> > > > it entirely. It can be trivially reverted if/when a better solution for
> > > > tracking page allocator sizes is found.
> > > > 
> > > > [1] https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg37479.html
> > > > [2] https://lkml.kernel.org/r/20190415022412.GA29714@bombadil.infradead.org
> > > 
> > > I agree the page spanning is broken but is it worth keeping the
> > > checks against __rodata __bss etc.?
> > 
> > They're all just white-listing later checks (except RODATA which is
> > doing a cheap RO test which is redundant on any architecture with actual
> > rodata...) so they don't have any value in staying without the rest of
> > the page allocator logic.
> > 
> > > > -	/* Is the object wholly within one base page? */
> > > > -	if (likely(((unsigned long)ptr & (unsigned long)PAGE_MASK) ==
> > > > -		   ((unsigned long)end & (unsigned long)PAGE_MASK)))
> > > > -		return;
> > > > -
> > > > -	/* Allow if fully inside the same compound (__GFP_COMP) page. */
> > > > -	endpage = virt_to_head_page(end);
> > > > -	if (likely(endpage == page))
> > > > -		return;
> > 
> > We _could_ keep the mixed CMA/reserved/neither check if we really wanted
> > to, but that's such a corner case of a corner case, I'm not sure it's
> > worth doing the virt_to_head_page() across the whole span to figure
> > it out.
> 
> I'd delete that first check, because it's a subset of the second check,

It seemed easier to short-circuit with a math test before doing the slightly more expensive virt_to_head_page(end) call. Do you think that's sensible?

> 
> 	/* Is the object wholly within a single (base or compound) page? */
> 	endpage = virt_to_head_page(end);
> 	if (likely(endpage == page))
> 		return;
> 
> 	/*
> 	 * If the start and end are more than MAX_ORDER apart, they must
> 	 * be from separate allocations
> 	 */
> 	if (n >= (PAGE_SIZE << MAX_ORDER))
> 		usercopy_abort("spans too many pages", NULL, to_user, 0, n);
> 
> 	/*
> 	 * If neither page is compound, we can't tell if the object is
> 	 * within a single allocation or not
> 	 */
> 	if (!PageCompound(page) && !PageCompound(endpage))
> 		return;
> 
> > I really wish we had size of allocation reliably held somewhere. We'll
> > need it for doing memory tagging of the page allocator too...
> 
> I think we'll need to store those allocations in a separate data structure
> on the side.  As far as the rest of the kernel is concerned, those struct
> pages belong to them once the page allocator has given them.

Okay, let me work up a page-type refactoring while allocation size can
stay back-burnered.

-- 
Kees Cook
