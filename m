Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88ADCA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B69B21929
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ds3wd9/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfKDItc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 03:49:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKDItc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 03:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=26LeBVxFf4lkYTPwvFJeB850lkIkOOfeBDgVGqh8C6c=; b=ds3wd9/FiqraXzDiqpjL/fSqE
        0RK5/ifNLaNyYbw6beNFJ+G8DRMZCg22z2/hpxcmfYtEX+bwQ15ZmQTJzsFnyQ8M44Zj2GYbI4CdZ
        p353kETbg238j+VfORhATQl/CjJvStidKnv25eYkZxISi3hIkqbHviPuCltiBALYKeD5+GcVCngWx
        daeSWWoUqJOG8T3g9zaxr9nYxPA+QwLpt5ERbCktnln7hG2EDxRkdNTTw6lX2BLvLZxAwxE+WMtXz
        hVlDJRMhrZpzcCO0RcjUtmlx/nAQVI3jpsVRtLU/2ltcaqn5AOj+2nFX9gYVGU5K2mwnb8op0Tt2N
        Pne8XIA4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRY3C-0002iJ-Ig; Mon, 04 Nov 2019 08:49:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 69362301747;
        Mon,  4 Nov 2019 09:48:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4A0E923CEFEAF; Mon,  4 Nov 2019 09:49:24 +0100 (CET)
Date:   Mon, 4 Nov 2019 09:49:24 +0100
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
Message-ID: <20191104084924.GB4131@hirez.programming.kicks-ass.net>
References: <20191101075727.26683-1-ying.huang@intel.com>
 <20191101075727.26683-11-ying.huang@intel.com>
 <20191101093145.GT4131@hirez.programming.kicks-ass.net>
 <877e4gcgsg.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877e4gcgsg.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 02:11:11PM +0800, Huang, Ying wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Fri, Nov 01, 2019 at 03:57:27PM +0800, Huang, Ying wrote:
> >
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 0a83e9cf6685..22bdbb7afac2 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -1486,6 +1486,41 @@ static bool numa_migration_check_rate_limit(struct pglist_data *pgdat,
> >>  	return true;
> >>  }
> >>  
> >> +#define NUMA_MIGRATION_ADJUST_STEPS	16
> >> +
> >> +static void numa_migration_adjust_threshold(struct pglist_data *pgdat,
> >> +					    unsigned long rate_limit,
> >> +					    unsigned long ref_threshold)
> >> +{
> >> +	unsigned long now = jiffies, last_threshold_jiffies;
> >> +	unsigned long unit_threshold, threshold;
> >> +	unsigned long try_migrate, ref_try_migrate, mdiff;
> >> +
> >> +	last_threshold_jiffies = pgdat->autonuma_threshold_jiffies;
> >> +	if (now > last_threshold_jiffies +
> >> +	    msecs_to_jiffies(sysctl_numa_balancing_scan_period_max) &&
> >> +	    cmpxchg(&pgdat->autonuma_threshold_jiffies,
> >> +		    last_threshold_jiffies, now) == last_threshold_jiffies) {
> >
> > That is seriously unreadable gunk.
> 
> The basic idea here is to adjust hot threshold every

Oh, I figured out what it does, but it's just really hard to read
because of those silly variable names.

This was just a first quick read through of the patches, and stuff like
this annoys me no end. I did start a rewrite with more sensible variable
names, but figured this might not be time for that.

I still need to think and review the whole concept in more detail, now
that I've read the patches. But I need to chase regressions first :/

FWIW, can you post a SLIT / NUMA distance table for such a system?
