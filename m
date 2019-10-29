Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773BECA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AA02087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732193AbfJ2Lsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:48:30 -0400
Received: from foss.arm.com ([217.140.110.172]:51150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfJ2Ls3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:48:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01EA7337;
        Tue, 29 Oct 2019 04:48:29 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCCAD3F71E;
        Tue, 29 Oct 2019 04:48:27 -0700 (PDT)
Date:   Tue, 29 Oct 2019 11:48:25 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20191029114824.2kb4fygxxx72r3in@e107158-lin.cambridge.arm.com>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <CAKfTPtA6Fvc374oTfbHYkviAJbZebHkBg=w2O3f0oZ0m3ujVjA@mail.gmail.com>
 <20191029110224.awoi37pdquachqtd@e107158-lin.cambridge.arm.com>
 <CAKfTPtA=CzkTVwdCJL6ULYB628tWdGAvpD-sHfgSfL59PyYvxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtA=CzkTVwdCJL6ULYB628tWdGAvpD-sHfgSfL59PyYvxA@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/19 12:17, Vincent Guittot wrote:
> On Tue, 29 Oct 2019 at 12:02, Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > On 10/29/19 09:13, Vincent Guittot wrote:
> > > On Wed, 9 Oct 2019 at 12:46, Qais Yousef <qais.yousef@arm.com> wrote:
> > > >
> > > > Capacity Awareness refers to the fact that on heterogeneous systems
> > > > (like Arm big.LITTLE), the capacity of the CPUs is not uniform, hence
> > > > when placing tasks we need to be aware of this difference of CPU
> > > > capacities.
> > > >
> > > > In such scenarios we want to ensure that the selected CPU has enough
> > > > capacity to meet the requirement of the running task. Enough capacity
> > > > means here that capacity_orig_of(cpu) >= task.requirement.
> > > >
> > > > The definition of task.requirement is dependent on the scheduling class.
> > > >
> > > > For CFS, utilization is used to select a CPU that has >= capacity value
> > > > than the cfs_task.util.
> > > >
> > > >         capacity_orig_of(cpu) >= cfs_task.util
> > > >
> > > > DL isn't capacity aware at the moment but can make use of the bandwidth
> > > > reservation to implement that in a similar manner CFS uses utilization.
> > > > The following patchset implements that:
> > > >
> > > > https://lore.kernel.org/lkml/20190506044836.2914-1-luca.abeni@santannapisa.it/
> > > >
> > > >         capacity_orig_of(cpu)/SCHED_CAPACITY >= dl_deadline/dl_runtime
> > > >
> > > > For RT we don't have a per task utilization signal and we lack any
> > > > information in general about what performance requirement the RT task
> > > > needs. But with the introduction of uclamp, RT tasks can now control
> > > > that by setting uclamp_min to guarantee a minimum performance point.
> > > >
> > > > ATM the uclamp value are only used for frequency selection; but on
> > > > heterogeneous systems this is not enough and we need to ensure that the
> > > > capacity of the CPU is >= uclamp_min. Which is what implemented here.
> > > >
> > > >         capacity_orig_of(cpu) >= rt_task.uclamp_min
> > > >
> > > > Note that by default uclamp.min is 1024, which means that RT tasks will
> > > > always be biased towards the big CPUs, which make for a better more
> > > > predictable behavior for the default case.
> > >
> > > hmm... big cores are not always the best choices for rt tasks, they
> > > generally took more time to wake up or to switch context because of
> > > the pipeline depth and others branch predictions
> >
> > Can you quantify this into a number? I suspect this latency should be in the
> 
> As a general rule, we pinned IRQs on little core because of such
> responsiveness  difference. I don't have numbers in mind as the tests
> were run at the beg of b.L system.. few years ago
> Then, if you look at some idle states definitions in DT, you will see
> that exit latency of cluster down state of big core of hikey960 is
> 2900us vs 1600us for little

I don't think hikey960 is a good system to use as a reference. SD845 shows more
sensible numbers

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sdm845.dtsi?h=v5.4-rc5#n407

> 
> > 200-300us range. And the difference between little and big should be much
> > smaller than that, no? We can't give guarantees in Linux in that order in
> > general and for serious real time users they have to do extra tweaks like
> > disabling power management which can introduce latency and hinder determinism.
> > Beside enabling PREEMPT_RT.
> >
> > For generic systems a few ms is the best we can give and we can easily fall out
> > of this without any tweaks.
> >
> > The choice of going to the maximum performance point in the system for RT tasks
> > by default goes beyond this patch anyway. I'm just making it consistent here
> > since we have different performance levels and RT didn't understand this
> > before.
> >
> > So what I'm doing here is just make things consistent rather than change the
> > default.
> >
> > What do you suggest?
> 
> Making big cores the default CPUs for all RT tasks is not a minor
> change and IMO locality should stay the default behavior when there is
> no uclamp constraint

How this is affecting locality? The task will always go to the big core, so it
should be local.

And before introducing uclamp the default was going to the maximum frequency
anyway - which is the highest performance point. So what this does is basically
make sure that if we asked for a 1024 capacity, we get that.

Beside the decision is taken by the setup of the system wide uclamp.min. We
can change this to be something smaller but I don't think we can come up with
a better value by default. Admin should tune this to something smaller if the
performance of their little cores is good for their needs.

What this patch says if I want my uclamp.min of my RT task to be 1024, then we
give better guarantees it'll get that 1024 performance it asked for. And the
default of 1024 is consistent with what Linux has always done for RT out of the
box.

--
Qais Yousef
