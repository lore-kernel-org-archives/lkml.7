Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A70DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE109208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564491475;
	bh=yKtD2ROz3z7PxmJh4swT1lK9yf8df6u9FrH0f4i/qig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v/XUmoH0FjfT4IwyRVHqvSOq2EK6ljNIBURT1xc4Fk1rp6Ge+quMLRCHM+H1StAdR
	 OQa1pupJTOu+BAx5ul0Wif8wgj2g0eHK13ZM55M94D1l+a3ATo9L2/OABcftAWBzdx
	 /2wICNQxwqnNQ633fnBld2tvnE0n8jT50zDfuF/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfG3M5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:57:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:32970 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726241AbfG3M5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:57:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ECEAAAC20;
        Tue, 30 Jul 2019 12:57:51 +0000 (UTC)
Date:   Tue, 30 Jul 2019 14:57:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] mm: release the spinlock on zap_pte_range
Message-ID: <20190730125751.GS9330@dhcp22.suse.cz>
References: <20190729071037.241581-1-minchan@kernel.org>
 <20190729074523.GC9330@dhcp22.suse.cz>
 <20190729082052.GA258885@google.com>
 <20190729083515.GD9330@dhcp22.suse.cz>
 <20190730121110.GA184615@google.com>
 <20190730123237.GR9330@dhcp22.suse.cz>
 <20190730123935.GB184615@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730123935.GB184615@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Nick - the email thread starts http://lkml.kernel.org/r/20190729071037.241581-1-minchan@kernel.org
 A very brief summary is that mark_page_accessed seems to be quite
 expensive and the question is whether we still need it and why
 SetPageReferenced cannot be used instead. More below.]

On Tue 30-07-19 21:39:35, Minchan Kim wrote:
> On Tue, Jul 30, 2019 at 02:32:37PM +0200, Michal Hocko wrote:
> > On Tue 30-07-19 21:11:10, Minchan Kim wrote:
> > > On Mon, Jul 29, 2019 at 10:35:15AM +0200, Michal Hocko wrote:
> > > > On Mon 29-07-19 17:20:52, Minchan Kim wrote:
> > > > > On Mon, Jul 29, 2019 at 09:45:23AM +0200, Michal Hocko wrote:
> > > > > > On Mon 29-07-19 16:10:37, Minchan Kim wrote:
> > > > > > > In our testing(carmera recording), Miguel and Wei found unmap_page_range
> > > > > > > takes above 6ms with preemption disabled easily. When I see that, the
> > > > > > > reason is it holds page table spinlock during entire 512 page operation
> > > > > > > in a PMD. 6.2ms is never trivial for user experince if RT task couldn't
> > > > > > > run in the time because it could make frame drop or glitch audio problem.
> > > > > > 
> > > > > > Where is the time spent during the tear down? 512 pages doesn't sound
> > > > > > like a lot to tear down. Is it the TLB flushing?
> > > > > 
> > > > > Miguel confirmed there is no such big latency without mark_page_accessed
> > > > > in zap_pte_range so I guess it's the contention of LRU lock as well as
> > > > > heavy activate_page overhead which is not trivial, either.
> > > > 
> > > > Please give us more details ideally with some numbers.
> > > 
> > > I had a time to benchmark it via adding some trace_printk hooks between
> > > pte_offset_map_lock and pte_unmap_unlock in zap_pte_range. The testing
> > > device is 2018 premium mobile device.
> > > 
> > > I can get 2ms delay rather easily to release 2M(ie, 512 pages) when the
> > > task runs on little core even though it doesn't have any IPI and LRU
> > > lock contention. It's already too heavy.
> > > 
> > > If I remove activate_page, 35-40% overhead of zap_pte_range is gone
> > > so most of overhead(about 0.7ms) comes from activate_page via
> > > mark_page_accessed. Thus, if there are LRU contention, that 0.7ms could
> > > accumulate up to several ms.
> > 
> > Thanks for this information. This is something that should be a part of
> > the changelog. I am sorry to still poke into this because I still do not
> 
> I will include it.
> 
> > have a full understanding of what is going on and while I do not object
> > to drop the spinlock I still suspect this is papering over a deeper
> > problem.
> 
> I couldn't come up with better solution. Feel free to suggest it.
> 
> > 
> > If mark_page_accessed is really expensive then why do we even bother to
> > do it in the tear down path in the first place? Why don't we simply set
> > a referenced bit on the page to reflect the young pte bit? I might be
> > missing something here of course.
> 
> commit bf3f3bc5e73
> Author: Nick Piggin <npiggin@suse.de>
> Date:   Tue Jan 6 14:38:55 2009 -0800
> 
>     mm: don't mark_page_accessed in fault path
> 
>     Doing a mark_page_accessed at fault-time, then doing SetPageReferenced at
>     unmap-time if the pte is young has a number of problems.
> 
>     mark_page_accessed is supposed to be roughly the equivalent of a young pte
>     for unmapped references. Unfortunately it doesn't come with any context:
>     after being called, reclaim doesn't know who or why the page was touched.
> 
>     So calling mark_page_accessed not only adds extra lru or PG_referenced
>     manipulations for pages that are already going to have pte_young ptes anyway,
>     but it also adds these references which are difficult to work with from the
>     context of vma specific references (eg. MADV_SEQUENTIAL pte_young may not
>     wish to contribute to the page being referenced).
> 
>     Then, simply doing SetPageReferenced when zapping a pte and finding it is
>     young, is not a really good solution either. SetPageReferenced does not
>     correctly promote the page to the active list for example. So after removing
>     mark_page_accessed from the fault path, several mmap()+touch+munmap() would
>     have a very different result from several read(2) calls for example, which
>     is not really desirable.

Well, I have to say that this is rather vague to me. Nick, could you be
more specific about which workloads do benefit from this change? Let's
say that the zapped pte is the only referenced one and then reclaim
finds the page on inactive list. We would go and reclaim it. But does
that matter so much? Hot pages would be referenced from multiple ptes
very likely, no?

That being said, cosindering that mark_page_accessed is not free, do we
have strong reasons to keep it?

Or do I miss something?

>     Signed-off-by: Nick Piggin <npiggin@suse.de>
>     Acked-by: Johannes Weiner <hannes@saeurebad.de>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

-- 
Michal Hocko
SUSE Labs
