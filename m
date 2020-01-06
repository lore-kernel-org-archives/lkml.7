Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774B2C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB762075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgAFOwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:52:31 -0500
Received: from outbound-smtp23.blacknight.com ([81.17.249.191]:56618 "EHLO
        outbound-smtp23.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbgAFOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:52:31 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp23.blacknight.com (Postfix) with ESMTPS id 304CBB8810
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jan 2020 14:52:28 +0000 (GMT)
Received: (qmail 29262 invoked from network); 6 Jan 2020 14:52:28 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Jan 2020 14:52:27 -0000
Date:   Mon, 6 Jan 2020 14:52:25 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
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
Message-ID: <20200106145225.GB3466@techsingularity.net>
References: <20191220084252.GL3178@techsingularity.net>
 <CAKfTPtDp624geHEnPmHki70L=ZrBuz6zJG3zW0VFy+_S064Etw@mail.gmail.com>
 <20200103143051.GA3027@techsingularity.net>
 <CAKfTPtCGm7-mq3duxi=ugy+mn=Yutw6w9c35+cSHK8aZn7rzNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtCGm7-mq3duxi=ugy+mn=Yutw6w9c35+cSHK8aZn7rzNQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I sent out v3 before seeing this email as my mail only synchronises
periodically.

On Mon, Jan 06, 2020 at 02:55:00PM +0100, Vincent Guittot wrote:
> > -                       return;
> > -               }
> > +               } else {
> >
> > -               /*
> > -                * If there is no overload, we just want to even the number of
> > -                * idle cpus.
> > -                */
> > -               env->migration_type = migrate_task;
> > -               env->imbalance = max_t(long, 0, (local->idle_cpus -
> > +                       /*
> > +                        * If there is no overload, we just want to even the number of
> > +                        * idle cpus.
> > +                        */
> > +                       env->migration_type = migrate_task;
> > +                       env->imbalance = max_t(long, 0, (local->idle_cpus -
> >                                                  busiest->idle_cpus) >> 1);
> > +               }
> > +
> > +               /* Consider allowing a small imbalance between NUMA groups */
> > +               if (env->sd->flags & SD_NUMA) {
> > +                       long imbalance_adj, imbalance_max;
> > +
> > +                       /*
> > +                        * imbalance_adj is the allowable degree of imbalance
> > +                        * to exist between two NUMA domains. imbalance_pct
> > +                        * is used to estimate the number of active tasks
> > +                        * needed before memory bandwidth may be as important
> > +                        * as memory locality.
> > +                        */
> > +                       imbalance_adj = (100 / (env->sd->imbalance_pct - 100)) - 1;
> 
> This looks weird to me because you use imbalance_pct, which is
> meaningful only compare a ratio, to define a number that will be then
> compared to a number of tasks without taking into account the weight
> of the node. So whatever the node size, 32 or 128 CPUs, the
> imbalance_adj will be the same: 3 with the default imbalance_pct of
> NUMA level which is 125 AFAICT
> 

The intent in this version was to only cover the low utilisation case
regardless of the NUMA node size. There were too many corner cases
where the tradeoff of local memory latency versus local memory bandwidth
cannot be quantified. See Srikar's report as an example but it's a general
problem. The use of imbalance_pct was simply to find the smallest number of
running tasks were (imbalance_pct - 100) would be 1 running task and limit
the patch to address the low utilisation case only. It could be simply
hard-coded but that would ignore cases where an architecture overrides
imbalance_pct. I'm open to suggestion on how we could identify the point
where imbalances can be ignored without hitting other corner cases.

> > +
> > +                       /*
> > +                        * Allow small imbalances when the busiest group has
> > +                        * low utilisation.
> > +                        */
> > +                       imbalance_max = imbalance_adj << 1;
> 
> Why do you add this shift ?
> 

For very low utilisation, there is no balancing between nodes. For slightly
above that, there is limited balancing. After that, the load balancing
behaviour is unchanged as I believe we cannot determine if memory latency
or memory bandwidth is more important for arbitrary workloads.

-- 
Mel Gorman
SUSE Labs
