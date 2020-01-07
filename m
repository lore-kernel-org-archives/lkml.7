Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD76CC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F582070E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgAGLmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:42:17 -0500
Received: from outbound-smtp38.blacknight.com ([46.22.139.221]:38585 "EHLO
        outbound-smtp38.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726690AbgAGLmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:42:17 -0500
Received: from mail.blacknight.com (unknown [81.17.254.26])
        by outbound-smtp38.blacknight.com (Postfix) with ESMTPS id 53612D71
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jan 2020 11:42:14 +0000 (GMT)
Received: (qmail 828 invoked from network); 7 Jan 2020 11:42:14 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Jan 2020 11:42:13 -0000
Date:   Tue, 7 Jan 2020 11:42:11 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
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
Message-ID: <20200107114211.GH3466@techsingularity.net>
References: <20191220084252.GL3178@techsingularity.net>
 <CAKfTPtDp624geHEnPmHki70L=ZrBuz6zJG3zW0VFy+_S064Etw@mail.gmail.com>
 <20200103143051.GA3027@techsingularity.net>
 <CAKfTPtCGm7-mq3duxi=ugy+mn=Yutw6w9c35+cSHK8aZn7rzNQ@mail.gmail.com>
 <20200106145225.GB3466@techsingularity.net>
 <CAKfTPtBa74nd4VP3+7V51Jv=-UpqNyEocyTzMYwjopCgfWPSXg@mail.gmail.com>
 <20200107095655.GF3466@techsingularity.net>
 <20200107112255.GV2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200107112255.GV2827@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 12:22:55PM +0100, Peter Zijlstra wrote:
> > Much more importantly, doing what you suggest allows an imbalance
> > of more CPUs than are backed by a single LLC. On high-end AMD EPYC 2
> > machines, busiest->group_weight scaled by imbalance_pct spans multiple L3
> > caches. That is going to have side-effects. While I also do not account
> > for the LLC group_weight, it's unlikely the cut-off I used would be
> > smaller than an LLC cache on a large machine as the cache.
> > 
> > These two points are why I didn't take the group weight into account.
> > 
> > Now if you want, I can do what you suggest anyway as long as you are happy
> > that the child domain weight is also taken into account and to bound the
> > largest possible allowed imbalance to deal with the case of a node having
> > multiple small LLC caches. That means that some machines will be using the
> > size of the node and some machines will use the size of an LLC. It's less
> > predictable overall as some machines will be "special" relative to others
> > making it harder to reproduce certain problems locally but it would take
> > imbalance_pct into account in a way that you're happy with.
> > 
> > Also bear in mind that whether LLC is accounted for or not, the final
> > result should be halved similar to the other imbalance calculations to
> > avoid over or under load balancing.
> 
> > +		/* Consider allowing a small imbalance between NUMA groups */
> > +		if (env->sd->flags & SD_NUMA) {
> > +			struct sched_domain *child = env->sd->child;
> 
> This assumes sd-child exists, which should be true for NUMA domains I
> suppose.
> 

I would be stunned if it was not. What sort of NUMA domain would not have
child domains? Does a memory-only NUMA node with no CPUs even generate
a scheduler domain? If it does, then I guess the check is necessary.

> > +			unsigned int imbalance_adj;
> > +
> > +			/*
> > +			 * Calculate an acceptable degree of imbalance based
> > +			 * on imbalance_adj. However, do not allow a greater
> > +			 * imbalance than the child domains weight to avoid
> > +			 * a case where the allowed imbalance spans multiple
> > +			 * LLCs.
> > +			 */
> 
> That comment is a wee misleading, @child is not an LLC per se. This
> could be the NUMA distance 2 domain, in which case @child is the NUMA
> distance 1 group.
> 
> That said, even then it probably makes sense to ensure you don't idle a
> whole smaller distance group.
> 

I hadn't considered that case but even then, it's just a comment fix.
Thanks.

-- 
Mel Gorman
SUSE Labs
