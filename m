Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DF7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E9F222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571408155;
	bh=tqkhVy6K9DRd/fnlXzwMdum0V410wCGaMZTRYiZXGVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y/ZAh6kg9wW0ZO2VRIFQmpx8QRBUpEJ7PR3ytuybwJDIwUZJlAtmvcCpScy/gLM3C
	 NwVl6fGfLEuSDGhSecYR6HGQTjJ+/XRL5+lrqCBacMwUj/sku6H73gShdOgh68k8LE
	 0eIBb1mScJUIsdxAljSjT+nWyIY9MKYXvSvQITJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442863AbfJROPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:15:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:58186 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392990AbfJROPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:15:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8FCAACCA;
        Fri, 18 Oct 2019 14:15:50 +0000 (UTC)
Date:   Fri, 18 Oct 2019 16:15:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote hugepages
Message-ID: <20191018141550.GS5017@dhcp22.suse.cz>
References: <20190904205522.GA9871@redhat.com>
 <alpine.DEB.2.21.1909051400380.217933@chino.kir.corp.google.com>
 <20190909193020.GD2063@dhcp22.suse.cz>
 <20190925070817.GH23050@dhcp22.suse.cz>
 <alpine.DEB.2.21.1909261149380.39830@chino.kir.corp.google.com>
 <20190927074803.GB26848@dhcp22.suse.cz>
 <CAHk-=wgba5zOJtGBFCBP3Oc1m4ma+AR+80s=hy=BbvNr3GqEmA@mail.gmail.com>
 <20190930112817.GC15942@dhcp22.suse.cz>
 <20191001054343.GA15624@dhcp22.suse.cz>
 <20191001083743.GC15624@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001083743.GC15624@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been some time since I've posted these results. The hugetlb issue
got resolved but I would still like to hear back about these findings
because they suggest that the current bail out strategy doesn't seem
to produce very good results. Essentially it doesn't really help THP
locality (on moderately filled up nodes) and it introduces a strong
dependency on kswapd which is not a source of the high order pages.
Also the overral THP success rate is decreased on a pretty standard "RAM
is used for page cache" workload.

That makes me think that the only possible workload that might really
benefit from this heuristic is a THP demanding one on a heavily
fragmented node with a lot of free memory while other nodes are not
fragmented and have quite a lot of free memory. If that is the case, is
this something to optimize for?

I am keeping all the results for the reference in a condensed form

On Tue 01-10-19 10:37:43, Michal Hocko wrote:
> I have split out my kvm machine into two nodes to get at least some
> idea how these patches behave
> $ numactl -H
> available: 2 nodes (0-1)
> node 0 cpus: 0 2
> node 0 size: 475 MB
> node 0 free: 432 MB
> node 1 cpus: 1 3
> node 1 size: 503 MB
> node 1 free: 458 MB
> 
> First run with 5.3 and without THP
> $ echo never > /sys/kernel/mm/transparent_hugepage/enabled
> root@test1:~# sh thp_test.sh 
> 7f4bdefec000 prefer:1 anon=102400 dirty=102400 active=86115 N0=41963 N1=60437 kernelpagesize_kB=4
> 7fd0f248b000 prefer:1 anon=102400 dirty=102400 active=86909 N0=40079 N1=62321 kernelpagesize_kB=4
> 7f2a69fc3000 prefer:1 anon=102400 dirty=102400 active=85244 N0=44455 N1=57945 kernelpagesize_kB=4
> 
> So we get around 56-60% pages to the preferred node
> 
> Now let's enable THPs
> AnonHugePages:    407552 kB
> 7f05c6dee000 prefer:1 anon=102400 dirty=102400 active=52718 N0=50688 N1=51712 kernelpagesize_kB=4
> Few more runs
> AnonHugePages:    407552 kB
> 7effca1b9000 prefer:1 anon=102400 dirty=102400 active=65977 N0=53760 N1=48640 kernelpagesize_kB=4
> AnonHugePages:    407552 kB
> 7f474bfc4000 prefer:1 anon=102400 dirty=102400 active=52676 N0=8704 N1=93696 kernelpagesize_kB=4
> 
> The utilization is again almost 100% and the preferred node usage
> varied a lot between 47-91%.
> 
> Now with 5.3 + all 4 patches this time:
> AnonHugePages:    401408 kB
> 7f8114ab4000 prefer:1 anon=102400 dirty=102400 active=51892 N0=3072 N1=99328 kernelpagesize_kB=4
> AnonHugePages:    376832 kB
> 7f37a1404000 prefer:1 anon=102400 dirty=102400 active=55204 N0=23153 N1=79247 kernelpagesize_kB=4
> AnonHugePages:    372736 kB
> 7f4abe4af000 prefer:1 anon=102400 dirty=102400 active=52399 N0=23646 N1=78754 kernelpagesize_kB=4
> 
> The THP utilization varies again and the locality is higher in average
> 76+%.  Which is even higher than the base page case. I was really
> wondering what is the reason for that So I've added a simple debugging

> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 8caab1f81a52..565f667f6dcb 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2140,9 +2140,11 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
>  			 * to prefer hugepage backing, retry allowing remote
>  			 * memory as well.
>  			 */
> -			if (!page && (gfp & __GFP_DIRECT_RECLAIM))
> +			if (!page && (gfp & __GFP_DIRECT_RECLAIM)) {
>  				page = __alloc_pages_node(hpage_node,
>  						gfp | __GFP_NORETRY, order);
> +				printk("XXX: %s\n", !page ? "fail" : hpage_node == page_to_nid(page)?"match":"fallback");
> +			}
>  
>  			goto out;
>  		}
> 
> Cases like
> AnonHugePages:    407552 kB
> 7f3ab2ebf000 prefer:1 anon=102400 dirty=102400 active=77503 N0=43520 N1=58880 kernelpagesize_kB=4
>      85 XXX: fallback
> a very successful ones on the other hand
> AnonHugePages:    280576 kB
> 7feffd9c2000 prefer:1 anon=102400 dirty=102400 active=52563 N0=3131 N1=99269 kernelpagesize_kB=4
>      62 XXX: fail
>       3 XXX: fallback
> 
> Note that 62 failing THPs is 31744 pages which also explains much higher
> locality I suspect (we simply allocate small pages from the preferred
> node).
> 
> This is just a very trivial test and I still have to grasp the outcome.
> My current feeling is that the whole thing is very timing specific and
> the higher local utilization depends on somebody else doing a reclaim
> on our behalf with patches applied.
> 
> 5.3 without any patches behaves more stable although there is a slightly
> higher off node THP success rate but it also seems that the same
> overall THP success rate can be achieved from the local node as well so
> performing compaction would make more sense for those.
> 
> With the simple hack on top of 5.3
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9c9194959271..414d0eaa6287 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4685,7 +4685,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
>  {
>  	struct page *page;
>  	unsigned int alloc_flags = ALLOC_WMARK_LOW;
> -	gfp_t alloc_mask; /* The gfp_t that was actually used for allocation */
> +	gfp_t alloc_mask, first_alloc_mask; /* The gfp_t that was actually used for allocation */
>  	struct alloc_context ac = { };
>  
>  	/*
> @@ -4711,7 +4711,10 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
>  	alloc_flags |= alloc_flags_nofragment(ac.preferred_zoneref->zone, gfp_mask);
>  
>  	/* First allocation attempt */
> -	page = get_page_from_freelist(alloc_mask, order, alloc_flags, &ac);
> +	first_alloc_mask = alloc_mask;
> +	if (order && (alloc_mask & __GFP_DIRECT_RECLAIM))
> +		first_alloc_mask |= __GFP_THISNODE;
> +	page = get_page_from_freelist(first_alloc_mask, order, alloc_flags, &ac);
>  	if (likely(page))
>  		goto out;
>  
> I am getting
> AnonHugePages:    407552 kB
> 7f88a67ca000 prefer:1 anon=102400 dirty=102400 active=60362 N0=39424 N1=62976 kernelpagesize_kB=4
> 
> AnonHugePages:    407552 kB
> 7f18f0de5000 prefer:1 anon=102400 dirty=102400 active=51685 N0=34720 N1=67680 kernelpagesize_kB=4
> 
> AnonHugePages:    407552 kB
> 7f443f89e000 prefer:1 anon=102400 dirty=102400 active=52382 N0=62976 N1=39424 kernelpagesize_kB=4
> 
> While first two rounds looked very promising with 60%+ locality with a
> consistent THP utilization then the locality went crazy so there is
> more to look into. The fast path still seems to make some difference
> though.
-- 
Michal Hocko
SUSE Labs
