Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549BDC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 04:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9B2208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 04:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dOYPVs5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfELELr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 00:11:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfELELr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 00:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=okCF2G2bDtULdDLlOPAao87uH7PkIsUp6GVlHHgydZ4=; b=dOYPVs5dvX8lEHg5muxxqJWqS
        /xG2ZXX2IkLiYFXOYPm0Huc19L3yU4aCZIgQFRHUxCBV4LBYfFgRyTnCmzEIHsKGGSSTgq/Fhxmr6
        K6lZERXbV2UvcE1awG3xBWu7fTQcDcoDFklJh/kgXo+sLdlhfw9a0eUIfLEOtRrWtFbQFBrEXWqGV
        o6+vZUj1hZhJP9cd8RZpkp06mOndvxH698rVsoFicFOt02JUqRRqp5iPfojLVdTPMaOh1LnbQjUFn
        6IUD6EtbtMfPK8dR+SvM7gNSYFXUGQvXSRU8vvE3LAIlDbDuRFZlC5wUp5u+k0uKI4pNEwABqvKXW
        6xglXU9LA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hPfpv-0000Gh-1h; Sun, 12 May 2019 04:11:43 +0000
Date:   Sat, 11 May 2019 21:11:42 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usercopy: Remove HARDENED_USERCOPY_PAGESPAN
Message-ID: <20190512041142.GA24542@bombadil.infradead.org>
References: <201905101341.A17DDD7@keescook>
 <ead5e4ad-d911-3680-04a4-ae98507ba48c@redhat.com>
 <201905111657.76FE0BDCEC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905111657.76FE0BDCEC@keescook>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 05:03:08PM -0700, Kees Cook wrote:
> On Fri, May 10, 2019 at 08:41:43PM -0400, Laura Abbott wrote:
> > On 5/10/19 3:43 PM, Kees Cook wrote:
> > > This feature continues to cause more problems than it solves[1]. Its
> > > intention was to check the bounds of page-allocator allocations by using
> > > __GFP_COMP, for which we would need to find all missing __GFP_COMP
> > > markings. This work has been on hold and there is an argument[2]
> > > that such markings are not even the correct signal for checking for
> > > same-allocation pages. Instead of depending on BROKEN, this just removes
> > > it entirely. It can be trivially reverted if/when a better solution for
> > > tracking page allocator sizes is found.
> > > 
> > > [1] https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg37479.html
> > > [2] https://lkml.kernel.org/r/20190415022412.GA29714@bombadil.infradead.org
> > 
> > I agree the page spanning is broken but is it worth keeping the
> > checks against __rodata __bss etc.?
> 
> They're all just white-listing later checks (except RODATA which is
> doing a cheap RO test which is redundant on any architecture with actual
> rodata...) so they don't have any value in staying without the rest of
> the page allocator logic.
> 
> > > -	/* Is the object wholly within one base page? */
> > > -	if (likely(((unsigned long)ptr & (unsigned long)PAGE_MASK) ==
> > > -		   ((unsigned long)end & (unsigned long)PAGE_MASK)))
> > > -		return;
> > > -
> > > -	/* Allow if fully inside the same compound (__GFP_COMP) page. */
> > > -	endpage = virt_to_head_page(end);
> > > -	if (likely(endpage == page))
> > > -		return;
> 
> We _could_ keep the mixed CMA/reserved/neither check if we really wanted
> to, but that's such a corner case of a corner case, I'm not sure it's
> worth doing the virt_to_head_page() across the whole span to figure
> it out.

I'd delete that first check, because it's a subset of the second check,

	/* Is the object wholly within a single (base or compound) page? */
	endpage = virt_to_head_page(end);
	if (likely(endpage == page))
		return;

	/*
	 * If the start and end are more than MAX_ORDER apart, they must
	 * be from separate allocations
	 */
	if (n >= (PAGE_SIZE << MAX_ORDER))
		usercopy_abort("spans too many pages", NULL, to_user, 0, n);

	/*
	 * If neither page is compound, we can't tell if the object is
	 * within a single allocation or not
	 */
	if (!PageCompound(page) && !PageCompound(endpage))
		return;

> I really wish we had size of allocation reliably held somewhere. We'll
> need it for doing memory tagging of the page allocator too...

I think we'll need to store those allocations in a separate data structure
on the side.  As far as the rest of the kernel is concerned, those struct
pages belong to them once the page allocator has given them.
