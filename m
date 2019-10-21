Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D251CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80EA2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571653641;
	bh=OB8EEmq7M9s2F15IltrEFSmxXoRA1vIfL6aLQYlWpBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yE3xsEkCYDqHhyLKbOjuxz7CJt/7Hxw4yYRuJVI8Yk4LIesb4hyC7sGaM5NFPxAfP
	 19lqKLNn7n11zRdNlNS77wNchc41UrDOjpqe+DxAiB11aQSUlrH0D/fB7u7NuComtG
	 Znu1Rym8NaOsgCSkzetv8nZoVT1kskIQewehBdh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfJUK1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:27:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:40542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726725AbfJUK1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:27:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60E09B4FC;
        Mon, 21 Oct 2019 10:27:15 +0000 (UTC)
Date:   Mon, 21 Oct 2019 12:27:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] mm, meminit: Recalculate pcpu batch and high limits
 after init completes
Message-ID: <20191021102714.GH9379@dhcp22.suse.cz>
References: <20191021094808.28824-1-mgorman@techsingularity.net>
 <20191021094808.28824-2-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021094808.28824-2-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-10-19 10:48:06, Mel Gorman wrote:
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
> initialisation completes for every populated zone in the system. It
> was tested on a 2-socket AMD EPYC 2 machine using a kernel compilation
> workload -- allmodconfig and all available CPUs.
> 
> mmtests configuration: config-workload-kernbench-max
> Configuration was modified to build on a fresh XFS partition.
> 
> kernbench
>                                 5.4.0-rc3              5.4.0-rc3
>                                   vanilla           resetpcpu-v2
> Amean     user-256    13249.50 (   0.00%)    16401.31 * -23.79%*
> Amean     syst-256    14760.30 (   0.00%)     4448.39 *  69.86%*
> Amean     elsp-256      162.42 (   0.00%)      119.13 *  26.65%*
> Stddev    user-256       42.97 (   0.00%)       19.15 (  55.43%)
> Stddev    syst-256      336.87 (   0.00%)        6.71 (  98.01%)
> Stddev    elsp-256        2.46 (   0.00%)        0.39 (  84.03%)
> 
>                    5.4.0-rc3    5.4.0-rc3
>                      vanilla resetpcpu-v2
> Duration User       39766.24     49221.79
> Duration System     44298.10     13361.67
> Duration Elapsed      519.11       388.87
> 
> The patch reduces system CPU usage by 69.86% and total build time by
> 26.65%. The variance of system CPU usage is also much reduced.
> 
> Before, this was the breakdown of batch and high values over all zones was.
> 
>     256               batch: 1
>     256               batch: 63
>     512               batch: 7
>     256               high:  0
>     256               high:  378
>     512               high:  42
> 
> 512 pcpu pagesets had a batch limit of 7 and a high limit of 42. After the patch
> 
>     256               batch: 1
>     768               batch: 63
>     256               high:  0
>     768               high:  378
> 
> Cc: stable@vger.kernel.org # v4.1+
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c0b2e0306720..f972076d0f6b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1947,6 +1947,14 @@ void __init page_alloc_init_late(void)
>  	/* Block until all are initialised */
>  	wait_for_completion(&pgdat_init_all_done_comp);
>  
> +	/*
> +	 * The number of managed pages has changed due to the initialisation
> +	 * so the pcpu batch and high limits needs to be updated or the limits
> +	 * will be artificially small.
> +	 */
> +	for_each_populated_zone(zone)
> +		zone_pcp_update(zone);
> +
>  	/*
>  	 * We initialized the rest of the deferred pages.  Permanently disable
>  	 * on-demand struct page initialization.
> -- 
> 2.16.4

-- 
Michal Hocko
SUSE Labs
