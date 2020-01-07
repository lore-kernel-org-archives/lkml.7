Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68769C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA6720678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 10:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgAGKQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:16:53 -0500
Received: from outbound-smtp05.blacknight.com ([81.17.249.38]:43278 "EHLO
        outbound-smtp05.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726558AbgAGKQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:16:53 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp05.blacknight.com (Postfix) with ESMTPS id 492B19890A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jan 2020 10:16:50 +0000 (GMT)
Received: (qmail 3988 invoked from network); 7 Jan 2020 10:16:49 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Jan 2020 10:16:49 -0000
Date:   Tue, 7 Jan 2020 10:16:46 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Hillf Danton <hdanton@sina.com>, Rik van Riel <riel@surriel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Parth Shah <parth@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v3
Message-ID: <20200107101646.GG3466@techsingularity.net>
References: <20200106144250.GA3466@techsingularity.net>
 <04033a63f11a9c59ebd2b099355915e4e889b772.camel@surriel.com>
 <20200106163303.GC3466@techsingularity.net>
 <20200107015111.4836-1-hdanton@sina.com>
 <20200107091256.GE3466@techsingularity.net>
 <CAKfTPtAMeta=jtTkTewdFN1UyqT+iyRhm9pfNDjkydfJQjaorQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtAMeta=jtTkTewdFN1UyqT+iyRhm9pfNDjkydfJQjaorQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:43:08AM +0100, Vincent Guittot wrote:
> > > > > It's not directly related to the number of CPUs in the node. Are you
> > > > > thinking of busiest->group_weight?
> > > >
> > > > I am, because as it is right now that if condition
> > > > looks like it might never be true for imbalance_pct 115.
> > > >
> > > > Presumably you put that check there for a reason, and
> > > > would like it to trigger when the amount by which a node
> > > > is busy is less than 2 * (imbalance_pct - 100).
> > >
> > >
> > > If three per cent can make any sense in helping determine utilisation
> > > low then the busy load has to meet
> > >
> > >       busiest->sum_nr_running < max(3, cpus in the node / 32);
> > >
> >
> > Why 3% and why would the low utilisation cut-off depend on the number of
> 
> But in the same way, why only 6 tasks ? which is the value with
> default imbalance_pct ?

I laid this out in another mail sent based on timing so I would repeat
myself other than to say it's predictable across machines.

> I expect a machine with 128 CPUs to have more bandwidth than a machine
> with only 32 CPUs and as a result to allow more imbalance
> 

I would expect so too with the caveat that there can be more memory
channels within a node so positioning does matter but we can't take
everything into account without creating a convulated mess. Worse, we have
no decent method for estimating bandwidth as it depends on the reference
pattern and scheduler domains do not currently take memory channels into
account. Maybe they should but that's a whole different discussion that
we do not want to get into right now.

> Maybe the number of running tasks (or idle cpus) is not the right
> metrics to choose if we can allow a small degree of imbalance because
> this doesn't take into account it wether the tasks are long running or
> short running ones
> 

I think running tasks at least is the least bad metric. idle CPUs gets
caught up in corner cases with bindings and util_avg can be skewed by
outliers. Running tasks is a sensible starting point until there is a
concrete use case that shows it is unworkable. Lets see what you think of
the other untested patch I posted that takes the group weight and child
domain weight into account.

-- 
Mel Gorman
SUSE Labs
