Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BE3C41514
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF5822CEC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567674012;
	bh=MHozAlL08p/dClPR5LPiHNkarN7p9tL8xXSSQ238VQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rZGS/c49sFCvp7cj1bjwMAOnsigU/VDcvVorAa+oq1j9YSlObaoam36yt4hPNfy4e
	 nbUR2bg1PPf6gU0Odkce3yuGvEYQybugHRaQqKKlOOaGs9XSRYfXRUAn00kdfeQ+pC
	 bRDepLVvyNSqIlLemuXFNhEeCPuME9lyH4oQRv6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732899AbfIEJAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 05:00:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:37750 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726231AbfIEJAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:00:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9EA39AE39;
        Thu,  5 Sep 2019 09:00:09 +0000 (UTC)
Date:   Thu, 5 Sep 2019 11:00:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [rfc 3/4] mm, page_alloc: avoid expensive reclaim when
 compaction may not succeed
Message-ID: <20190905090009.GF3838@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1909041252230.94813@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1909041253390.94813@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909041253390.94813@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Ccing Mike for checking on the hugetlb side of this change]

On Wed 04-09-19 12:54:22, David Rientjes wrote:
> Memory compaction has a couple significant drawbacks as the allocation
> order increases, specifically:
> 
>  - isolate_freepages() is responsible for finding free pages to use as
>    migration targets and is implemented as a linear scan of memory
>    starting at the end of a zone,
> 
>  - failing order-0 watermark checks in memory compaction does not account
>    for how far below the watermarks the zone actually is: to enable
>    migration, there must be *some* free memory available.  Per the above,
>    watermarks are not always suffficient if isolate_freepages() cannot
>    find the free memory but it could require hundreds of MBs of reclaim to
>    even reach this threshold (read: potentially very expensive reclaim with
>    no indication compaction can be successful), and
> 
>  - if compaction at this order has failed recently so that it does not even
>    run as a result of deferred compaction, looping through reclaim can often
>    be pointless.
> 
> For hugepage allocations, these are quite substantial drawbacks because
> these are very high order allocations (order-9 on x86) and falling back to
> doing reclaim can potentially be *very* expensive without any indication
> that compaction would even be successful.
> 
> Reclaim itself is unlikely to free entire pageblocks and certainly no
> reliance should be put on it to do so in isolation (recall lumpy reclaim).
> This means we should avoid reclaim and simply fail hugepage allocation if
> compaction is deferred.
> 
> It is also not helpful to thrash a zone by doing excessive reclaim if
> compaction may not be able to access that memory.  If order-0 watermarks
> fail and the allocation order is sufficiently large, it is likely better
> to fail the allocation rather than thrashing the zone.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  mm/page_alloc.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4458,6 +4458,28 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  		if (page)
>  			goto got_pg;
>  
> +		 if (order >= pageblock_order && (gfp_mask & __GFP_IO)) {
> +			/*
> +			 * If allocating entire pageblock(s) and compaction
> +			 * failed because all zones are below low watermarks
> +			 * or is prohibited because it recently failed at this
> +			 * order, fail immediately.
> +			 *
> +			 * Reclaim is
> +			 *  - potentially very expensive because zones are far
> +			 *    below their low watermarks or this is part of very
> +			 *    bursty high order allocations,
> +			 *  - not guaranteed to help because isolate_freepages()
> +			 *    may not iterate over freed pages as part of its
> +			 *    linear scan, and
> +			 *  - unlikely to make entire pageblocks free on its
> +			 *    own.
> +			 */
> +			if (compact_result == COMPACT_SKIPPED ||
> +			    compact_result == COMPACT_DEFERRED)
> +				goto nopage;
> +		}
> +
>  		/*
>  		 * Checks for costly allocations with __GFP_NORETRY, which
>  		 * includes THP page fault allocations

-- 
Michal Hocko
SUSE Labs
