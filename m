Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01769C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 08:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D039524650
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 08:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfLSIlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 03:41:39 -0500
Received: from outbound-smtp22.blacknight.com ([81.17.249.190]:51182 "EHLO
        outbound-smtp22.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbfLSIlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 03:41:39 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id 48434B86FE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 08:41:37 +0000 (GMT)
Received: (qmail 3991 invoked from network); 19 Dec 2019 08:41:37 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Dec 2019 08:41:37 -0000
Date:   Thu, 19 Dec 2019 08:41:34 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Rik van Riel <riel@surriel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pauld@redhat.com,
        valentin.schneider@arm.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, hdanton@sina.com, parth@linux.ibm.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains
Message-ID: <20191219084134.GH3178@techsingularity.net>
References: <20191218154402.GF3178@techsingularity.net>
 <37ec5587dbb4035b883e5a69b56da4cc67f0e5ff.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <37ec5587dbb4035b883e5a69b56da4cc67f0e5ff.camel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 09:58:01PM -0500, Rik van Riel wrote:
> On Wed, 2019-12-18 at 15:44 +0000, Mel Gorman wrote:
> 
> > +			/*
> > +			 * Ignore imbalance unless busiest sd is close
> > to 50%
> > +			 * utilisation. At that point balancing for
> > memory
> > +			 * bandwidth and potentially avoiding
> > unnecessary use
> > +			 * of HT siblings is as relevant as memory
> > locality.
> > +			 */
> > +			imbalance_max = (busiest->group_weight >> 1) -
> > imbalance_adj;
> > +			if (env->imbalance <= imbalance_adj &&
> > +			    busiest->sum_nr_running < imbalance_max) {
> > +				env->imbalance = 0;
> > +			}
> > +		}
> >  		return;
> >  	}
> 
> I can see how the 50% point is often great for HT,
> but I wonder if that is also the case for SMT4 and
> SMT8 systems...
> 

Maybe, maybe not but it's not the most important concern. The highlight
in the comment was about memory bandwidth and HT was simply an additional
concern. Ideally memory bandwidth and consumption would be taken into
account but we know nothing about either. Even if peak memory bandwidth
was known, the reference pattern matters a *lot* which can be readily
illustrated by using STREAM and observing the different bandwidths for
different reference patterns. Similarly, while we might know pages that
were referenced, we do not know the bandwidth consumption without taking
additional overhead with a PMU. Hence, it makes sense to at least hope
that the active tasks have similar memory bandwidth requirements and load
balance as normal when we are near the 50% active tasks/busy CPUs. If
SMT4 or SMT8 have different requirements or it matters for memory
bandwidth then it would need to be carefully examined by someone with
access to such hardware to determine an arch-specific and maybe even a
per-CPU-family cutoff.

In the context of this patch, it unconditionally makes sense that the
basic case of two communicating tasks are not migrating cross-node on
wakeup and then again on load balance.

-- 
Mel Gorman
SUSE Labs
