Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7905FCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D421208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfJ3QYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:24:46 -0400
Received: from outbound-smtp34.blacknight.com ([46.22.139.253]:47084 "EHLO
        outbound-smtp34.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726261AbfJ3QYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:24:46 -0400
Received: from mail.blacknight.com (unknown [81.17.255.152])
        by outbound-smtp34.blacknight.com (Postfix) with ESMTPS id 6D831822
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 16:24:43 +0000 (GMT)
Received: (qmail 4411 invoked from network); 30 Oct 2019 16:24:43 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Oct 2019 16:24:43 -0000
Date:   Wed, 30 Oct 2019 16:24:40 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com
Subject: Re: [PATCH v4 00/10] sched/fair: rework the CFS load balance
Message-ID: <20191030162440.GO3016@techsingularity.net>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <20191021075038.GA27361@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20191021075038.GA27361@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 09:50:38AM +0200, Ingo Molnar wrote:
> > <SNIP>
> 
> Thanks, that's an excellent series!
> 

Agreed despite the level of whining and complaining I made during the
review.

> I've queued it up in sched/core with a handful of readability edits to 
> comments and changelogs.
> 
> There are some upstreaming caveats though, I expect this series to be a 
> performance regression magnet:
> 
>  - load_balance() and wake-up changes invariably are such: some workloads 
>    only work/scale well by accident, and if we touch the logic it might 
>    flip over into a less advantageous scheduling pattern.
> 
>  - In particular the changes from balancing and waking on runnable load 
>    to full load that includes blocking *will* shift IO-intensive 
>    workloads that you tests don't fully capture I believe. You also made 
>    idle balancing more aggressive in essence - which might reduce cache 
>    locality for some workloads.
> 
> A full run on Mel Gorman's magic scalability test-suite would be super 
> useful ...
> 

I queued this back on the 21st and it took this long for me to get back
to it.

What I tested did not include the fix for the last patch so I cannot say
the data is that useful. I also failed to include something that exercised
the IO paths in a way that idles rapidly as that can catch interesting
details (usually cpufreq related but sometimes load-balancing related).
There was no real thinking behind this decision, I just used an old
collection of tests to get a general feel for the series.

Most of the results were performance-neutral and some notable gains
(kernel compiles were 1-6% faster depending on the -j count). Hackbench
saw a disproportionate gain in terms of performance but I tend to be wary
of hackbench as improving it is rarely a universal win.
There tends to be some jitter around the point where a NUMA nodes worth
of CPUs gets overloaded. tbench (mmtests configuation network-tbench) on
a NUMA machine showed gains for low thread counts and high thread counts
but a loss near the boundary where a single node would get overloaded.

Some NAS-related workloads saw a drop in performance on NUMA machines
but the size class might be too small to be certain, I'd have to rerun
with the D class to be sure.  The biggest strange drop in performance
was the elapsed time to run the git test suite (mmtests configuration
workload-shellscripts modified to use a fresh XFS partition) took 17.61%
longer to execute on a UMA Skylake machine. This *might* be due to the
missing fix because it is mostly a single-task workload.

I'm not going to go through the results in detail because I think another
full round of testing would be required to take the fix into account. I'd
also prefer to wait to see if the review results in any material change
to the series.

-- 
Mel Gorman
SUSE Labs
