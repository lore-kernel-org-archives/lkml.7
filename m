Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364E9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067C42089C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571403693;
	bh=Bevh8gSJ/jtVLsZIKj/ZV4ezP4mN9fYBUs3vexfffSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F1/1QaLhlreCMugmoBNpJD4URy/39L9XD3MnXkoIWhKgEVievq6eJc+2LuFUc9qTZ
	 a+LcLxJItc3NTLSbZHPJ/V71ukFqrHtnbGjSfwMB/H04MuL0YfXyajbKd7CEyBJnNN
	 h+P0rhRkXws0jq3KNy2kWcZLYVpRGezXRINpZ6ho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410211AbfJRNBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:01:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:44958 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2410165AbfJRNBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:01:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 70035AEF3;
        Fri, 18 Oct 2019 13:01:28 +0000 (UTC)
Date:   Fri, 18 Oct 2019 15:01:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mm, meminit: Recalculate pcpu batch and high limits
 after init completes
Message-ID: <20191018130127.GP5017@dhcp22.suse.cz>
References: <20191018105606.3249-1-mgorman@techsingularity.net>
 <20191018105606.3249-3-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018105606.3249-3-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18-10-19 11:56:05, Mel Gorman wrote:
> Deferred memory initialisation updates zone->managed_pages during
> the initialisation phase but before that finishes, the per-cpu page
> allocator (pcpu) calculates the number of pages allocated/freed in
> batches as well as the maximum number of pages allowed on a per-cpu list.
> As zone->managed_pages is not up to date yet, the pcpu initialisation
> calculates inappropriately low batch and high values.
> 
> This increases zone lock contention quite severely in some cases with the
> degree of severity depending on how many CPUs share a local zone and the
> size of the zone. A private report indicated that kernel build times were
> excessive with extremely high system CPU usage. A perf profile indicated
> that a large chunk of time was lost on zone->lock contention.
> 
> This patch recalculates the pcpu batch and high values after deferred
> initialisation completes on each node. It was tested on a 2-socket AMD
> EPYC 2 machine using a kernel compilation workload -- allmodconfig and
> all available CPUs.
> 
> mmtests configuration: config-workload-kernbench-max
> Configuration was modified to build on a fresh XFS partition.
> 
> kernbench
>                                 5.4.0-rc3              5.4.0-rc3
>                                   vanilla         resetpcpu-v1r1
> Amean     user-256    13249.50 (   0.00%)    15928.40 * -20.22%*
> Amean     syst-256    14760.30 (   0.00%)     4551.77 *  69.16%*
> Amean     elsp-256      162.42 (   0.00%)      118.46 *  27.06%*
> Stddev    user-256       42.97 (   0.00%)       50.83 ( -18.30%)
> Stddev    syst-256      336.87 (   0.00%)       33.70 (  90.00%)
> Stddev    elsp-256        2.46 (   0.00%)        0.81 (  67.01%)
> 
>                    5.4.0-rc3   5.4.0-rc3
>                      vanillaresetpcpu-v1r1
> Duration User       39766.24    47802.92
> Duration System     44298.10    13671.93
> Duration Elapsed      519.11      387.65
> 
> The patch reduces system CPU usage by 69.16% and total build time by
> 27.06%. The variance of system CPU usage is also much reduced.

The fix makes sense. It would be nice to see the difference in the batch
sizes from the initial setup compared to the one after the deferred
intialization is done

> Cc: stable@vger.kernel.org # v4.15+

Hmm, are you sure about 4.15? Doesn't this go all the way down to
deferred initialization? I do not see any recent changes on when
setup_per_cpu_pageset is called.

> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cafe568d36f6..0a0dd74edc83 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1818,6 +1818,14 @@ static int __init deferred_init_memmap(void *data)
>  	 */
>  	while (spfn < epfn)
>  		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> +
> +	/*
> +	 * The number of managed pages has changed due to the initialisation
> +	 * so the pcpu batch and high limits needs to be updated or the limits
> +	 * will be artificially small.
> +	 */
> +	zone_pcp_update(zone);
> +
>  zone_empty:
>  	pgdat_resize_unlock(pgdat, &flags);
>  
> @@ -8516,7 +8524,6 @@ void free_contig_range(unsigned long pfn, unsigned int nr_pages)
>  	WARN(count != 0, "%d pages are still in use!\n", count);
>  }
>  
> -#ifdef CONFIG_MEMORY_HOTPLUG
>  /*
>   * The zone indicated has a new number of managed_pages; batch sizes and percpu
>   * page high values need to be recalulated.
> @@ -8527,7 +8534,6 @@ void __meminit zone_pcp_update(struct zone *zone)
>  	__zone_pcp_update(zone);
>  	mutex_unlock(&pcp_batch_high_lock);
>  }
> -#endif
>  
>  void zone_pcp_reset(struct zone *zone)
>  {
> -- 
> 2.16.4
> 

-- 
Michal Hocko
SUSE Labs
