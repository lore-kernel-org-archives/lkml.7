Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E037DC4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B1B2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560205858;
	bh=e+VeJnxtpzlvI42v3SjN2mLvhyZhkXm9AwXTJRT/v7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X65q15jP4kDGiaIfvpBTgyvnw7eHFj8Cn+USd0kAuiaTamm5xS3IuaQEvYYTcWRXh
	 BX6FtJg/qo/ZkcXZVAXOeKQmwmkgnrkThXOvapwSIeiyem5+Uq8HTseuHz+NNNSbCq
	 7dgilxWSr/av1HFi8yNRv8katfRAPO6nNw/u9C7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390343AbfFJWa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 18:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388328AbfFJWa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 18:30:57 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60C9120859;
        Mon, 10 Jun 2019 22:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560205856;
        bh=e+VeJnxtpzlvI42v3SjN2mLvhyZhkXm9AwXTJRT/v7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=frGO8G/4ulH/QqB3f1QF2jcbewiyh/kOleuIO7rIU5te7H8Gp01GCNrN2dB07bVrk
         DL5i16n1nITeeHcEjc9zbqQkXvYE2lYne0kDx2e8/msSN5I+4f+qDZH9juU9BSmBYh
         b55F2VuGRNvWflXtB+azitC/SmzKgS/CMAkhQtno=
Date:   Mon, 10 Jun 2019 15:30:55 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usercopy: Remove HARDENED_USERCOPY_PAGESPAN
Message-ID: <20190610223054.GT63833@gmail.com>
References: <201905101341.A17DDD7@keescook>
 <ead5e4ad-d911-3680-04a4-ae98507ba48c@redhat.com>
 <201905111657.76FE0BDCEC@keescook>
 <20190512041142.GA24542@bombadil.infradead.org>
 <201905131430.541A76A6FE@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905131430.541A76A6FE@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 02:32:43PM -0700, Kees Cook wrote:
> On Sat, May 11, 2019 at 09:11:42PM -0700, Matthew Wilcox wrote:
> > On Sat, May 11, 2019 at 05:03:08PM -0700, Kees Cook wrote:
> > > On Fri, May 10, 2019 at 08:41:43PM -0400, Laura Abbott wrote:
> > > > On 5/10/19 3:43 PM, Kees Cook wrote:
> > > > > This feature continues to cause more problems than it solves[1]. Its
> > > > > intention was to check the bounds of page-allocator allocations by using
> > > > > __GFP_COMP, for which we would need to find all missing __GFP_COMP
> > > > > markings. This work has been on hold and there is an argument[2]
> > > > > that such markings are not even the correct signal for checking for
> > > > > same-allocation pages. Instead of depending on BROKEN, this just removes
> > > > > it entirely. It can be trivially reverted if/when a better solution for
> > > > > tracking page allocator sizes is found.
> > > > > 
> > > > > [1] https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg37479.html
> > > > > [2] https://lkml.kernel.org/r/20190415022412.GA29714@bombadil.infradead.org
> > > > 
> > > > I agree the page spanning is broken but is it worth keeping the
> > > > checks against __rodata __bss etc.?
> > > 
> > > They're all just white-listing later checks (except RODATA which is
> > > doing a cheap RO test which is redundant on any architecture with actual
> > > rodata...) so they don't have any value in staying without the rest of
> > > the page allocator logic.
> > > 
> > > > > -	/* Is the object wholly within one base page? */
> > > > > -	if (likely(((unsigned long)ptr & (unsigned long)PAGE_MASK) ==
> > > > > -		   ((unsigned long)end & (unsigned long)PAGE_MASK)))
> > > > > -		return;
> > > > > -
> > > > > -	/* Allow if fully inside the same compound (__GFP_COMP) page. */
> > > > > -	endpage = virt_to_head_page(end);
> > > > > -	if (likely(endpage == page))
> > > > > -		return;
> > > 
> > > We _could_ keep the mixed CMA/reserved/neither check if we really wanted
> > > to, but that's such a corner case of a corner case, I'm not sure it's
> > > worth doing the virt_to_head_page() across the whole span to figure
> > > it out.
> > 
> > I'd delete that first check, because it's a subset of the second check,
> 
> It seemed easier to short-circuit with a math test before doing the slightly more expensive virt_to_head_page(end) call. Do you think that's sensible?
> 
> > 
> > 	/* Is the object wholly within a single (base or compound) page? */
> > 	endpage = virt_to_head_page(end);
> > 	if (likely(endpage == page))
> > 		return;
> > 
> > 	/*
> > 	 * If the start and end are more than MAX_ORDER apart, they must
> > 	 * be from separate allocations
> > 	 */
> > 	if (n >= (PAGE_SIZE << MAX_ORDER))
> > 		usercopy_abort("spans too many pages", NULL, to_user, 0, n);
> > 
> > 	/*
> > 	 * If neither page is compound, we can't tell if the object is
> > 	 * within a single allocation or not
> > 	 */
> > 	if (!PageCompound(page) && !PageCompound(endpage))
> > 		return;
> > 
> > > I really wish we had size of allocation reliably held somewhere. We'll
> > > need it for doing memory tagging of the page allocator too...
> > 
> > I think we'll need to store those allocations in a separate data structure
> > on the side.  As far as the rest of the kernel is concerned, those struct
> > pages belong to them once the page allocator has given them.
> 
> Okay, let me work up a page-type refactoring while allocation size can
> stay back-burnered.
> 
> -- 
> Kees Cook

Any progress on this patch?

- Eric
