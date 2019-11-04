Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDA4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347C420578
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfKDKMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:12:54 -0500
Received: from mga06.intel.com ([134.134.136.31]:49568 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfKDKMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:12:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 02:12:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,266,1569308400"; 
   d="scan'208";a="401562020"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by fmsmga005.fm.intel.com with ESMTP; 04 Nov 2019 02:12:51 -0800
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
        <877e4gcgsg.fsf@yhuang-dev.intel.com>
        <20191104084924.GB4131@hirez.programming.kicks-ass.net>
Date:   Mon, 04 Nov 2019 18:12:50 +0800
In-Reply-To: <20191104084924.GB4131@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Mon, 4 Nov 2019 09:49:24 +0100")
Message-ID: <87ftj4ar19.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Nov 04, 2019 at 02:11:11PM +0800, Huang, Ying wrote:
>> Peter Zijlstra <peterz@infradead.org> writes:
>> 
>> > On Fri, Nov 01, 2019 at 03:57:27PM +0800, Huang, Ying wrote:
>> >
>> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> >> index 0a83e9cf6685..22bdbb7afac2 100644
>> >> --- a/kernel/sched/fair.c
>> >> +++ b/kernel/sched/fair.c
>> >> @@ -1486,6 +1486,41 @@ static bool numa_migration_check_rate_limit(struct pglist_data *pgdat,
>> >>  	return true;
>> >>  }
>> >>  
>> >> +#define NUMA_MIGRATION_ADJUST_STEPS	16
>> >> +
>> >> +static void numa_migration_adjust_threshold(struct pglist_data *pgdat,
>> >> +					    unsigned long rate_limit,
>> >> +					    unsigned long ref_threshold)
>> >> +{
>> >> +	unsigned long now = jiffies, last_threshold_jiffies;
>> >> +	unsigned long unit_threshold, threshold;
>> >> +	unsigned long try_migrate, ref_try_migrate, mdiff;
>> >> +
>> >> +	last_threshold_jiffies = pgdat->autonuma_threshold_jiffies;
>> >> +	if (now > last_threshold_jiffies +
>> >> +	    msecs_to_jiffies(sysctl_numa_balancing_scan_period_max) &&
>> >> +	    cmpxchg(&pgdat->autonuma_threshold_jiffies,
>> >> +		    last_threshold_jiffies, now) == last_threshold_jiffies) {
>> >
>> > That is seriously unreadable gunk.
>> 
>> The basic idea here is to adjust hot threshold every
>
> Oh, I figured out what it does, but it's just really hard to read
> because of those silly variable names.
>
> This was just a first quick read through of the patches, and stuff like
> this annoys me no end. I did start a rewrite with more sensible variable
> names, but figured this might not be time for that.

Sorry about the poor naming.  That is always hard for me.

> I still need to think and review the whole concept in more detail, now
> that I've read the patches. But I need to chase regressions first :/

Thanks for your help!

> FWIW, can you post a SLIT / NUMA distance table for such a system?

Sure.  Will send you as attachment in another email.

Best Regards,
Huang, Ying
