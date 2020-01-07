Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16458C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E481C2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgAGJNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:13:00 -0500
Received: from outbound-smtp14.blacknight.com ([46.22.139.231]:39253 "EHLO
        outbound-smtp14.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbgAGJNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:13:00 -0500
Received: from mail.blacknight.com (unknown [81.17.254.26])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id 8C6D61C2D11
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jan 2020 09:12:58 +0000 (GMT)
Received: (qmail 21528 invoked from network); 7 Jan 2020 09:12:58 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Jan 2020 09:12:58 -0000
Date:   Tue, 7 Jan 2020 09:12:56 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Rik van Riel <riel@surriel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pauld@redhat.com,
        valentin.schneider@arm.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, parth@linux.ibm.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v3
Message-ID: <20200107091256.GE3466@techsingularity.net>
References: <20200106144250.GA3466@techsingularity.net>
 <04033a63f11a9c59ebd2b099355915e4e889b772.camel@surriel.com>
 <20200106163303.GC3466@techsingularity.net>
 <20200107015111.4836-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200107015111.4836-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 09:51:11AM +0800, Hillf Danton wrote:
> 
> Hi Folks
> 
> On Mon, 06 Jan 2020 11:44:57 -0500 Rik van Riel wrote:
> > On Mon, 2020-01-06 at 16:33 +0000, Mel Gorman wrote:
> > > On Mon, Jan 06, 2020 at 10:47:18AM -0500, Rik van Riel wrote:
> > > > > +			imbalance_adj = (100 / (env->sd->imbalance_pct - 100)) - 1;
> > > > > +
> > > > > +			/*
> > > > > +			 * Allow small imbalances when the busiest group has
> > > > > +			 * low utilisation.
> > > > > +			 */
> > > > > +			imbalance_max = imbalance_adj << 1;
> > > > > +			if (busiest->sum_nr_running < imbalance_max)
> > > > > +				env->imbalance -= min(env->imbalance, imbalance_adj);
> > > > > +		}
> > > > > +
> > > >
> > > > Wait, so imbalance_max is a function only of
> > > > env->sd->imbalance_pct, and it gets compared
> > > > against busiest->sum_nr_running, which is related
> > > > to the number of CPUs in the node?
> > > >
> > >
> > > It's not directly related to the number of CPUs in the node. Are you
> > > thinking of busiest->group_weight?
> > 
> > I am, because as it is right now that if condition
> > looks like it might never be true for imbalance_pct 115.
> > 
> > Presumably you put that check there for a reason, and
> > would like it to trigger when the amount by which a node
> > is busy is less than 2 * (imbalance_pct - 100).
> 
> 
> If three per cent can make any sense in helping determine utilisation
> low then the busy load has to meet
> 
> 	busiest->sum_nr_running < max(3, cpus in the node / 32);
> 

Why 3% and why would the low utilisation cut-off depend on the number of
CPUs in the node? That simply means that the cut-off scales to machine
size and does not take into account any consideration between local memory
latency and memory bandwidth.

> And we can't skip pulling tasks from a numa node without comparing it
> to the local load
> 
> 	local->sum_nr_running * env->sd->imbalance_pct <
> 	busiest->sum_nr_running * 100;
> 
> with imbalance_pct taken into account.
> 

Again, why? In this context, an imbalance has already been calculated
and whether based on running tasks or idle CPUs, it's not a negative
number. The imbalance_adj used as already accounted for imbalance_pct
albeit not as a ratio as it's normally used.

-- 
Mel Gorman
SUSE Labs
