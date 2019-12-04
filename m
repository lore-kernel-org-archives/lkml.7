Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89984C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0AB2073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfLDNca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:32:30 -0500
Received: from foss.arm.com ([217.140.110.172]:55918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbfLDNca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:32:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2781B1FB;
        Wed,  4 Dec 2019 05:32:29 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBA633F68E;
        Wed,  4 Dec 2019 05:32:27 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:32:25 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Null pointer crash at find_idlest_group on db845c w/ linus/master
Message-ID: <20191204133224.uiqbkbpseree7xou@e107158-lin.cambridge.arm.com>
References: <CALAqxLXrWWnWi32BR1F8JOtrGt1y2Kzj__zWopLx1ZfRy3EZKA@mail.gmail.com>
 <CAKfTPtAvnLY3brp9iy_aHNu0rMM8nLfgeLc3CXEkMk3bwU1weA@mail.gmail.com>
 <20191204094216.u7yld5r3zelp22lf@e107158-lin.cambridge.arm.com>
 <20191204100925.GA15727@linaro.org>
 <629cca09-dde7-5d77-42e1-c68f2c1820d2@arm.com>
 <CAKfTPtDZLFn7msw88pTE_wr-BJo2ErqxpOW+ah0Jjcg6vE3SLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDZLFn7msw88pTE_wr-BJo2ErqxpOW+ah0Jjcg6vE3SLw@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/19 13:08, Vincent Guittot wrote:
> On Wed, 4 Dec 2019 at 11:41, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
> >
> > On 04/12/2019 10:09, Vincent Guittot wrote:
> > > Now, we test that a group has at least one allowed CPU for the task so we
> > > could skip the local group with the correct/wrong p->cpus_ptr
> > >
> > > The path is used for fork/exec ibut also for wakeup path for b.L when the task doesn't fit in the CPUs
> > >
> > > So we can probably imagine a scenario where we change task affinity while
> > > sleeping. If the wakeup happens on a CPU that belongs to the group that is not
> > > allowed, we can imagine that we skip the local_group
> > >
> >
> > Shoot, I think you're right. If it is the local group that is NULL, then
> > we most likely splat on:
> >
> >                 if (local->sgc->max_capacity >= idlest->sgc->max_capacity)
> >                         return NULL;
> >
> > We don't splat before because we just use local_sgs, which is uninitialized
> > but on the stack.
> >
> > Also; does it really have to involve an affinity "race"? AFAIU affinity
> > could have been changed a while back, but the waking CPU isn't allowed
> > so we skip the local_group (in simpler cases where each CPU is a group).
> 
> In fact, this will depend of the uninitialized values of local_sgs. I
> have been able to reproduce the situation where we skip local group
> but not to trigger the crash because the values already in the stack
> don't trigger the misfit comparison.

Will it be expensive to initialize local_sgs = {0}?

--
Qais Yousef
