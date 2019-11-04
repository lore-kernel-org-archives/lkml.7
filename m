Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46980CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A9E2190F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfKDGLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 01:11:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:10074 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfKDGLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 01:11:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2019 22:11:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,266,1569308400"; 
   d="scan'208";a="204511187"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by orsmga003.jf.intel.com with ESMTP; 03 Nov 2019 22:11:11 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC 10/10] autonuma, memory tiering: Adjust hot threshold automatically
References: <20191101075727.26683-1-ying.huang@intel.com>
        <20191101075727.26683-11-ying.huang@intel.com>
        <20191101093145.GT4131@hirez.programming.kicks-ass.net>
Date:   Mon, 04 Nov 2019 14:11:11 +0800
In-Reply-To: <20191101093145.GT4131@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Fri, 1 Nov 2019 10:31:45 +0100")
Message-ID: <877e4gcgsg.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Fri, Nov 01, 2019 at 03:57:27PM +0800, Huang, Ying wrote:
>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 0a83e9cf6685..22bdbb7afac2 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -1486,6 +1486,41 @@ static bool numa_migration_check_rate_limit(struct pglist_data *pgdat,
>>  	return true;
>>  }
>>  
>> +#define NUMA_MIGRATION_ADJUST_STEPS	16
>> +
>> +static void numa_migration_adjust_threshold(struct pglist_data *pgdat,
>> +					    unsigned long rate_limit,
>> +					    unsigned long ref_threshold)
>> +{
>> +	unsigned long now = jiffies, last_threshold_jiffies;
>> +	unsigned long unit_threshold, threshold;
>> +	unsigned long try_migrate, ref_try_migrate, mdiff;
>> +
>> +	last_threshold_jiffies = pgdat->autonuma_threshold_jiffies;
>> +	if (now > last_threshold_jiffies +
>> +	    msecs_to_jiffies(sysctl_numa_balancing_scan_period_max) &&
>> +	    cmpxchg(&pgdat->autonuma_threshold_jiffies,
>> +		    last_threshold_jiffies, now) == last_threshold_jiffies) {
>
> That is seriously unreadable gunk.

The basic idea here is to adjust hot threshold every
sysctl_numa_balancing_scan_period_max.  Because the application
accessing pattern may have spatial locality, and autonuma scans address
space linearly.  In general, the statistics of NUMA hint page fault
latency isn't stable in arbitrary internal (such as 1 s, or 200 ms,
etc).  But the scanning of the whole address space of the application is
expected to be finished within sysctl_numa_balancing_scan_period_max.
The statistics of NUMA hint page fault latency is expected to be much
more stable for the whole application.  So we choose to adjust hot
threshold every sysctl_numa_balancing_scan_period_max.

I will add comments for this in the next version.

>> +
>> +		ref_try_migrate = rate_limit *
>> +			sysctl_numa_balancing_scan_period_max / 1000;
>> +		try_migrate = node_page_state(pgdat, NUMA_TRY_MIGRATE);
>> +		mdiff = try_migrate - pgdat->autonuma_threshold_try_migrate;
>> +		unit_threshold = ref_threshold / NUMA_MIGRATION_ADJUST_STEPS;
>> +		threshold = pgdat->autonuma_threshold;
>> +		if (!threshold)
>> +			threshold = ref_threshold;
>> +		if (mdiff > ref_try_migrate * 11 / 10)
>> +			threshold = max(threshold - unit_threshold,
>> +					unit_threshold);
>> +		else if (mdiff < ref_try_migrate * 9 / 10)
>> +			threshold = min(threshold + unit_threshold,
>> +					ref_threshold);
>
> And that is violating codingstyle.

You mean I need to use braces here?

>> +		pgdat->autonuma_threshold_try_migrate = try_migrate;
>> +		pgdat->autonuma_threshold = threshold;
>> +	}
>> +}
>
>
> Maybe if you use variable names that are slightly shorter than half your
> line length?

Sure.  I will use shorter variable name in the next version.

Best Regards,
Huang, Ying
