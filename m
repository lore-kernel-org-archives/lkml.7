Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3797CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9248C21734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vdUoTWpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfKAJcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 05:32:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41656 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbfKAJcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ejT2S2mIfvsplY7uEp7jOjxDsXfhP33JrtumCpA22pQ=; b=vdUoTWpkvBtAJ2UJHIGcKsrRh
        fynCJXsDYXQu4cNL2C/Qeepqc9JrMRc39j7TNApmNN4UFUlr6nfBdHkXoC79KQ3ohvp0jPnFd+I7r
        eEJBK97VC2dVmft2JU8iLP2NodljJ0d0OzyqJxtvg0QZhJtgSCyIUdmCx+WUwoQ50dIwCSidSHIwX
        rJQeRBUKgxT++OIYMWK4TD8SIK0P8Je5qHBWt8Imz9VGaMIoYF2LGM/6ospXVUxeZ7mGFNOOWypZs
        k1qhxDdmVyeU2cgguCeZIPnqD7Z7evBtYlMxK1qHEXm6pKmGIR58zjtcmylAXegOcTqx/Z8vJ03Bx
        ehUze0JSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQTHX-0004zL-QU; Fri, 01 Nov 2019 09:31:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8A5F8300334;
        Fri,  1 Nov 2019 10:30:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3010726540345; Fri,  1 Nov 2019 10:31:45 +0100 (CET)
Date:   Fri, 1 Nov 2019 10:31:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC 10/10] autonuma, memory tiering: Adjust hot threshold
 automatically
Message-ID: <20191101093145.GT4131@hirez.programming.kicks-ass.net>
References: <20191101075727.26683-1-ying.huang@intel.com>
 <20191101075727.26683-11-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101075727.26683-11-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 03:57:27PM +0800, Huang, Ying wrote:

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0a83e9cf6685..22bdbb7afac2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1486,6 +1486,41 @@ static bool numa_migration_check_rate_limit(struct pglist_data *pgdat,
>  	return true;
>  }
>  
> +#define NUMA_MIGRATION_ADJUST_STEPS	16
> +
> +static void numa_migration_adjust_threshold(struct pglist_data *pgdat,
> +					    unsigned long rate_limit,
> +					    unsigned long ref_threshold)
> +{
> +	unsigned long now = jiffies, last_threshold_jiffies;
> +	unsigned long unit_threshold, threshold;
> +	unsigned long try_migrate, ref_try_migrate, mdiff;
> +
> +	last_threshold_jiffies = pgdat->autonuma_threshold_jiffies;
> +	if (now > last_threshold_jiffies +
> +	    msecs_to_jiffies(sysctl_numa_balancing_scan_period_max) &&
> +	    cmpxchg(&pgdat->autonuma_threshold_jiffies,
> +		    last_threshold_jiffies, now) == last_threshold_jiffies) {

That is seriously unreadable gunk.

> +
> +		ref_try_migrate = rate_limit *
> +			sysctl_numa_balancing_scan_period_max / 1000;
> +		try_migrate = node_page_state(pgdat, NUMA_TRY_MIGRATE);
> +		mdiff = try_migrate - pgdat->autonuma_threshold_try_migrate;
> +		unit_threshold = ref_threshold / NUMA_MIGRATION_ADJUST_STEPS;
> +		threshold = pgdat->autonuma_threshold;
> +		if (!threshold)
> +			threshold = ref_threshold;
> +		if (mdiff > ref_try_migrate * 11 / 10)
> +			threshold = max(threshold - unit_threshold,
> +					unit_threshold);
> +		else if (mdiff < ref_try_migrate * 9 / 10)
> +			threshold = min(threshold + unit_threshold,
> +					ref_threshold);

And that is violating codingstyle.

> +		pgdat->autonuma_threshold_try_migrate = try_migrate;
> +		pgdat->autonuma_threshold = threshold;
> +	}
> +}


Maybe if you use variable names that are slightly shorter than half your
line length?
