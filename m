Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1D6C04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A096F217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fj9dGlCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfEISkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:40:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfEISkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SztKd1ju+6SnNDo4BjWr81OOwqXWrYRbPTmT3bN77eU=; b=fj9dGlCvNYfI6Br9Am2Zi3JLGB
        eAMtthKG4CZvd3zQDzNKXT47VW5vNDYnqnzVpfPL+mPkciQoNnHoPeb4e10aj63dKPGKTeC8Ix1zD
        2bvW9RB6wCVeJDVWJzMKgVK+wFIF1Xb8i3EkaVdJskUUcNGQmyo5Qj6JYHxQL0osI99womSn0y5F7
        Sn9WJXxyd5YbqW9+tl/y6U1zjVNw23lDg1gFSnib5mi8cq2chEwsFwenTT/hy52V97YvKJsO96OQN
        rAl0s26wpKhZ7M/E5mmwgYGOBlFzvv8pTPmrFol631L1al/p0/grM4Rx098aV4NZgvaJMtrpBQSPn
        ht++QOng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOnxd-0001KL-2w; Thu, 09 May 2019 18:40:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 013B520268735; Thu,  9 May 2019 20:40:02 +0200 (CEST)
Date:   Thu, 9 May 2019 20:40:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Will Deacon <will.deacon@arm.com>, jstancek@redhat.com,
        akpm@linux-foundation.org, stable@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
        namit@vmware.com, minchan@kernel.org, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] mm: mmu_gather: remove __tlb_reset_range() for force
 flush
Message-ID: <20190509184002.GC2623@hirez.programming.kicks-ass.net>
References: <1557264889-109594-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190509083726.GA2209@brain-police>
 <20190509103813.GP2589@hirez.programming.kicks-ass.net>
 <20190509105446.GL2650@hirez.programming.kicks-ass.net>
 <6a907073-67ec-04fe-aaae-c1adcb62e3df@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a907073-67ec-04fe-aaae-c1adcb62e3df@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 11:35:55AM -0700, Yang Shi wrote:
> 
> 
> On 5/9/19 3:54 AM, Peter Zijlstra wrote:
> > On Thu, May 09, 2019 at 12:38:13PM +0200, Peter Zijlstra wrote:
> > 
> > > That's tlb->cleared_p*, and yes agreed. That is, right until some
> > > architecture has level dependent TLBI instructions, at which point we'll
> > > need to have them all set instead of cleared.
> > > Anyway; am I correct in understanding that the actual problem is that
> > > we've cleared freed_tables and the ARM64 tlb_flush() will then not
> > > invalidate the cache and badness happens?
> > > 
> > > Because so far nobody has actually provided a coherent description of
> > > the actual problem we're trying to solve. But I'm thinking something
> > > like the below ought to do.
> > There's another 'fun' issue I think. For architectures like ARM that
> > have range invalidation and care about VM_EXEC for I$ invalidation, the
> > below doesn't quite work right either.
> > 
> > I suspect we also have to force: tlb->vma_exec = 1.
> 
> Isn't the below code in tlb_flush enough to guarantee this?
> 
> ...
> } else if (tlb->end) {
>                struct vm_area_struct vma = {
>                        .vm_mm = tlb->mm,
>                        .vm_flags = (tlb->vma_exec ? VM_EXEC    : 0) |
>                                    (tlb->vma_huge ? VM_HUGETLB : 0),
>                };

Only when vma_exec is actually set... and there is no guarantee of that
in the concurrent path (the last VMA we iterate might not be executable,
but the TLBI we've missed might have been).

More specific, the 'fun' case is if we have no present page in the whole
executable page, in that case tlb->end == 0 and we never call into the
arch code, never giving it chance to flush I$.
