Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E5CC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE992067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbgAHSDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:03:24 -0500
Received: from outbound-smtp39.blacknight.com ([46.22.139.222]:49827 "EHLO
        outbound-smtp39.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727090AbgAHSDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 13:03:23 -0500
Received: from mail.blacknight.com (unknown [81.17.254.26])
        by outbound-smtp39.blacknight.com (Postfix) with ESMTPS id F0D46D1F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jan 2020 18:03:20 +0000 (GMT)
Received: (qmail 19896 invoked from network); 8 Jan 2020 18:03:20 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Jan 2020 18:03:19 -0000
Date:   Wed, 8 Jan 2020 18:03:17 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains v2
Message-ID: <20200108180317.GM3466@techsingularity.net>
References: <20200106145225.GB3466@techsingularity.net>
 <CAKfTPtBa74nd4VP3+7V51Jv=-UpqNyEocyTzMYwjopCgfWPSXg@mail.gmail.com>
 <20200107095655.GF3466@techsingularity.net>
 <CAKfTPtAtJSWGPC1t+0xj_Daid0fZaWnN+b53WQ_a1-Js5fJ6sg@mail.gmail.com>
 <20200107115646.GI3466@techsingularity.net>
 <CAKfTPtAacdmxniM9yZUrQPW39LAvhpBQt6ZiGiwk5qpEx7zicA@mail.gmail.com>
 <20200107202406.GJ3466@techsingularity.net>
 <20200108131858.GZ2827@hirez.programming.kicks-ass.net>
 <20200108140349.GL3466@techsingularity.net>
 <20200108164657.GA16425@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200108164657.GA16425@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 05:46:57PM +0100, Vincent Guittot wrote:
> > Allowing just 1 extra task would work for netperf in some cases except when
> > softirq is involved. It would partially work for IO on ext4 as it's only
> > communicating with one journal thread but a bit more borderline for XFS
> > due to workqueue usage. XFS is not a massive concern in this context as
> > the workqueue is close to the IO issuer and short-lived so I don't think
> > it would crop up much for load balancing unlike ext4 where jbd2 could be
> > very active.
> > 
> > If v4 of the patch fails to meet approval then I'll try a patch that
> 
> My main concern with v4 was the mismatch between the computed value and the goal to not overload the LLCs
> 

Fair enough.

> > allows a hard-coded imbalance of 2 tasks (one communicating task and
> 
> If there is no good way to compute the allowed imbalance, a hard coded
> value of 2 is probably simple value to start with

Indeed.

> 
> > one kthread) regardless of NUMA domain span up to 50% of utilisation
> 
> Are you sure that it's necessary ? This degree of imbalance already applies only if the group has spare capacity
> 
> something like
> 
> +               /* Consider allowing a small imbalance between NUMA groups */
> +               if (env->sd->flags & SD_NUMA) {
> +
> +                       /*
> +                        * Until we found a good way to compute an acceptable
> +						 * degree of imbalance linked to the system topology
> +						 * and that will not impatc mem bandwith and latency,
> +						 * let start with a fixed small value.
> +						 */
> +                       imbalance_adj = 2;
> +
> +                       /*
> +                        * Ignore small imbalances when the busiest group has
> +                        * low utilisation.
> +                        */
> +                        env->imbalance -= min(env->imbalance, imbalance_adj);
> +               }
> 

This is more or less what I had in mind with the exception that the "low
utilisation" part of the comment would go away. The 50% utilisation may
be unnecessary and was based simply on the idea that at that point memory
bandwidth, HT considerations or both would also be dominating factors. I
can leave out the check and add it in as a separate patch if proven to
be necessary.

-- 
Mel Gorman
SUSE Labs
