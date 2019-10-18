Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F04CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E26D20854
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571403083;
	bh=V6dayAdIvSVOwzTCZhu4LltyIQp0Va5bZ/2w7e7Nga8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TEbFd82ZBWFzWXdMS5mLMJapaYifVpx74AqzDei7V8yVRcnuXMtcmW8YJpxsAbkMD
	 nDdXh/dkHLLRUrd4KcoRFLgC4v01uQWWZfqnWIVReOVXbF4sOdCFz84JXhZMmhRQvr
	 viovIcMemS1OBSp6sy7wYwcdmpttmkVcozXOsgLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407926AbfJRMvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:51:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:40408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726875AbfJRMvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:51:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4CE4FB3B6;
        Fri, 18 Oct 2019 12:51:20 +0000 (UTC)
Date:   Fri, 18 Oct 2019 14:51:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] mm, pcp: Share common code between memory hotplug
 and percpu sysctl handler
Message-ID: <20191018125119.GO5017@dhcp22.suse.cz>
References: <20191018105606.3249-1-mgorman@techsingularity.net>
 <20191018105606.3249-2-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018105606.3249-2-mgorman@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18-10-19 11:56:04, Mel Gorman wrote:
> Both the percpu_pagelist_fraction sysctl handler and memory hotplug
> have a common requirement of updating the pcpu page allocation batch
> and high values. Split the relevant helper to share common code.
> 
> No functional change.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c0b2e0306720..cafe568d36f6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7983,6 +7983,15 @@ int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *table, int write,
>  	return 0;
>  }
>  
> +static void __zone_pcp_update(struct zone *zone)
> +{
> +	unsigned int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		pageset_set_high_and_batch(zone,
> +				per_cpu_ptr(zone->pageset, cpu));
> +}
> +
>  /*
>   * percpu_pagelist_fraction - changes the pcp->high for each zone on each
>   * cpu.  It is the fraction of total pages in each zone that a hot per cpu
> @@ -8014,13 +8023,8 @@ int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *table, int write,
>  	if (percpu_pagelist_fraction == old_percpu_pagelist_fraction)
>  		goto out;
>  
> -	for_each_populated_zone(zone) {
> -		unsigned int cpu;
> -
> -		for_each_possible_cpu(cpu)
> -			pageset_set_high_and_batch(zone,
> -					per_cpu_ptr(zone->pageset, cpu));
> -	}
> +	for_each_populated_zone(zone)
> +		__zone_pcp_update(zone);
>  out:
>  	mutex_unlock(&pcp_batch_high_lock);
>  	return ret;
> @@ -8519,11 +8523,8 @@ void free_contig_range(unsigned long pfn, unsigned int nr_pages)
>   */
>  void __meminit zone_pcp_update(struct zone *zone)
>  {
> -	unsigned cpu;
>  	mutex_lock(&pcp_batch_high_lock);
> -	for_each_possible_cpu(cpu)
> -		pageset_set_high_and_batch(zone,
> -				per_cpu_ptr(zone->pageset, cpu));
> +	__zone_pcp_update(zone);
>  	mutex_unlock(&pcp_batch_high_lock);
>  }
>  #endif
> -- 
> 2.16.4
> 

-- 
Michal Hocko
SUSE Labs
