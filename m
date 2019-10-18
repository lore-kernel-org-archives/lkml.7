Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26499CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D85222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633970AbfJROKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:10:05 -0400
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:52314 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727988AbfJROKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:10:05 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id 312B41C2FD6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 15:10:02 +0100 (IST)
Received: (qmail 31552 invoked from network); 18 Oct 2019 14:10:01 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Oct 2019 14:10:01 -0000
Date:   Fri, 18 Oct 2019 15:09:59 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mm, meminit: Recalculate pcpu batch and high limits
 after init completes
Message-ID: <20191018140959.GK3321@techsingularity.net>
References: <20191018105606.3249-1-mgorman@techsingularity.net>
 <20191018105606.3249-3-mgorman@techsingularity.net>
 <20191018130127.GP5017@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20191018130127.GP5017@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 03:01:27PM +0200, Michal Hocko wrote:
> On Fri 18-10-19 11:56:05, Mel Gorman wrote:
> > Deferred memory initialisation updates zone->managed_pages during
> > the initialisation phase but before that finishes, the per-cpu page
> > allocator (pcpu) calculates the number of pages allocated/freed in
> > batches as well as the maximum number of pages allowed on a per-cpu list.
> > As zone->managed_pages is not up to date yet, the pcpu initialisation
> > calculates inappropriately low batch and high values.
> > 
> > This increases zone lock contention quite severely in some cases with the
> > degree of severity depending on how many CPUs share a local zone and the
> > size of the zone. A private report indicated that kernel build times were
> > excessive with extremely high system CPU usage. A perf profile indicated
> > that a large chunk of time was lost on zone->lock contention.
> > 
> > This patch recalculates the pcpu batch and high values after deferred
> > initialisation completes on each node. It was tested on a 2-socket AMD
> > EPYC 2 machine using a kernel compilation workload -- allmodconfig and
> > all available CPUs.
> > 
> > mmtests configuration: config-workload-kernbench-max
> > Configuration was modified to build on a fresh XFS partition.
> > 
> > kernbench
> >                                 5.4.0-rc3              5.4.0-rc3
> >                                   vanilla         resetpcpu-v1r1
> > Amean     user-256    13249.50 (   0.00%)    15928.40 * -20.22%*
> > Amean     syst-256    14760.30 (   0.00%)     4551.77 *  69.16%*
> > Amean     elsp-256      162.42 (   0.00%)      118.46 *  27.06%*
> > Stddev    user-256       42.97 (   0.00%)       50.83 ( -18.30%)
> > Stddev    syst-256      336.87 (   0.00%)       33.70 (  90.00%)
> > Stddev    elsp-256        2.46 (   0.00%)        0.81 (  67.01%)
> > 
> >                    5.4.0-rc3   5.4.0-rc3
> >                      vanillaresetpcpu-v1r1
> > Duration User       39766.24    47802.92
> > Duration System     44298.10    13671.93
> > Duration Elapsed      519.11      387.65
> > 
> > The patch reduces system CPU usage by 69.16% and total build time by
> > 27.06%. The variance of system CPU usage is also much reduced.
> 
> The fix makes sense. It would be nice to see the difference in the batch
> sizes from the initial setup compared to the one after the deferred
> intialization is done
> 

Before, this was the breakdown of batch and high values over all zones
were

    256               batch: 1
    256               batch: 63
    512               batch: 7

    256               high:  0
    256               high:  378
    512               high:  42

i.e. 512 pcpu pagesets had a batch limit of 7 and a high limit of 42.
These were for the NORMAL zones on the system. After the patch

    256               batch: 1
    768               batch: 63

    256               high:  0
    768               high:  378

> > Cc: stable@vger.kernel.org # v4.15+
> 
> Hmm, are you sure about 4.15? Doesn't this go all the way down to
> deferred initialization? I do not see any recent changes on when
> setup_per_cpu_pageset is called.
> 

No, I'm not 100% sure. It looks like this was always an issue from the
code but did not happen on at least one 4.12-based distribution kernel for
reasons that are non-obvious. Either way, the tag should have been "v4.1+"

Thanks.

-- 
Mel Gorman
SUSE Labs
