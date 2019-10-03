Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4424C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 05:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBE9222C3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 05:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570080426;
	bh=Jtt+0lrz55+dN399bd83jgSlLUIt3UNbmJDKZQBo8vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0KvzwLOEglrQy8A5jqe8SAa8LnuTyXEcamKf5a3zREju52WbpLrynRxdZNbcqdzOD
	 49UMhYJHinSbaSJmc/eiysRHS5bXoYMQDH5uOXKlzQBat9DHzULrh+Ww+H/laimzWK
	 gYmVy0RYDrRuY4/OSURuFTnECbrVhiEqSYnhEgA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfJCF1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 01:27:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:37426 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbfJCF1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 01:27:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6C2BB009;
        Thu,  3 Oct 2019 05:27:01 +0000 (UTC)
Date:   Thu, 3 Oct 2019 07:27:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [rfc] mm, hugetlb: allow hugepage allocations to excessively
 reclaim
Message-ID: <20191003052700.GB24174@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1910021556270.187014@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910021556270.187014@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-10-19 16:03:03, David Rientjes wrote:
> Hugetlb allocations use __GFP_RETRY_MAYFAIL to aggressively attempt to get 
> hugepages that the user needs.  Commit b39d0ee2632d ("mm, page_alloc: 
> avoid expensive reclaim when compaction may not succeed") intends to 
> improve allocator behind for thp allocations to prevent excessive amounts 
> of reclaim especially when constrained to a single node.
> 
> Since hugetlb allocations have explicitly preferred to loop and do reclaim 
> and compaction, exempt them from this new behavior at least for the time 
> being.  It is not shown that hugetlb allocation success rate has been 
> impacted by commit b39d0ee2632d but hugetlb allocations are admittedly 
> beyond the scope of what the patch is intended to address (thp 
> allocations).

It has become pretty clear that b39d0ee2632d has regressed hugetlb
allocation success rate for any non-trivial case (complately free
memory) http://lkml.kernel.org/r/20191001054343.GA15624@dhcp22.suse.cz.
And this really is not just about hugetlb requests, really. They are
likely the most obvious example but __GFP_RETRY_MAYFAIL in general is
supposed to try as hard as feasible to success the allocation. The
decision to bail out is done at a different spot and b39d0ee2632d is
effectively bypassing that logic.

Now to the patch itself. I didn't get to test it on my testing
workload but hey steps are clearly documented and easily to set up and
reproduce. I am at a training for today and unlikely to get to test by
the end of the week infortunatelly. Anyway the patch should be fixing
the problem because it explicitly opts out for __GFP_RETRY_MAYFAIL.

I am pretty sure we will need more follow ups because the bail out logic
is simply behaving quite randomly as my measurements show (I would really
appreciate a feedback there). We need a more systematic solution because
the current logic has been rushed through without a proper analysis and
without any actual workloads to verify the effect.

> Cc: Mike Kravetz <mike.kravetz@oracle.com>
Fixes: b39d0ee2632d ("mm, page_alloc: avoid expensive reclaim when compaction may not succeed")

> Signed-off-by: David Rientjes <rientjes@google.com>

I am willing to give my ack by considering that this is a clear
regression and this is probably the simplest fix but the changelog
should be explicit about the effect (feel free to borrow my numbers and
explanation in this thread).

> ---
>  Mike, you eluded that you may want to opt hugetlbfs out of this for the
>  time being in https://marc.info/?l=linux-kernel&m=156771690024533 --
>  not sure if you want to allow this excessive amount of reclaim for 
>  hugetlb allocations or not given the swap storms Andrea has shown is
>  possible (and nr_hugepages_mempolicy does exist), but hugetlbfs was not
>  part of the problem we are trying to address here so no objection to
>  opting it out.  
> 
>  You might want to consider how expensive hugetlb allocations can become
>  and disruptive to the system if it does not yield additional hugepages,
>  but that can be done at any time later as a general improvement rather
>  than part of a series aimed at thp.
> 
>  mm/page_alloc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4467,12 +4467,14 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  		if (page)
>  			goto got_pg;
>  
> -		 if (order >= pageblock_order && (gfp_mask & __GFP_IO)) {
> +		 if (order >= pageblock_order && (gfp_mask & __GFP_IO) &&
> +		     !(gfp_mask & __GFP_RETRY_MAYFAIL)) {
>  			/*
>  			 * If allocating entire pageblock(s) and compaction
>  			 * failed because all zones are below low watermarks
>  			 * or is prohibited because it recently failed at this
> -			 * order, fail immediately.
> +			 * order, fail immediately unless the allocator has
> +			 * requested compaction and reclaim retry.
>  			 *
>  			 * Reclaim is
>  			 *  - potentially very expensive because zones are far

-- 
Michal Hocko
SUSE Labs
