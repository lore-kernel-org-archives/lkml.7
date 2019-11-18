Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D14C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 15:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA81521D6C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 15:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfKRPnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 10:43:39 -0500
Received: from foss.arm.com ([217.140.110.172]:36142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfKRPnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 10:43:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6AC7328;
        Mon, 18 Nov 2019 07:43:38 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A4503F703;
        Mon, 18 Nov 2019 07:43:37 -0800 (PST)
Date:   Mon, 18 Nov 2019 15:43:35 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20191118154334.tolws225robfncp6@e107158-lin.cambridge.arm.com>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <20191028143749.GE4114@hirez.programming.kicks-ass.net>
 <20191028140147.036a0001@grimm.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191028140147.036a0001@grimm.local.home>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve

On 10/28/19 14:01, Steven Rostedt wrote:
> On Mon, 28 Oct 2019 15:37:49 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Oct 09, 2019 at 11:46:11AM +0100, Qais Yousef wrote:
> > > Capacity Awareness refers to the fact that on heterogeneous systems
> > > (like Arm big.LITTLE), the capacity of the CPUs is not uniform, hence
> > > when placing tasks we need to be aware of this difference of CPU
> > > capacities.
> > > 
> > > In such scenarios we want to ensure that the selected CPU has enough
> > > capacity to meet the requirement of the running task. Enough capacity
> > > means here that capacity_orig_of(cpu) >= task.requirement.
> > > 
> > > The definition of task.requirement is dependent on the scheduling class.
> > > 
> > > For CFS, utilization is used to select a CPU that has >= capacity value
> > > than the cfs_task.util.
> > > 
> > > 	capacity_orig_of(cpu) >= cfs_task.util
> > > 
> > > DL isn't capacity aware at the moment but can make use of the bandwidth
> > > reservation to implement that in a similar manner CFS uses utilization.
> > > The following patchset implements that:
> > > 
> > > https://lore.kernel.org/lkml/20190506044836.2914-1-luca.abeni@santannapisa.it/
> > > 
> > > 	capacity_orig_of(cpu)/SCHED_CAPACITY >= dl_deadline/dl_runtime
> > > 
> > > For RT we don't have a per task utilization signal and we lack any
> > > information in general about what performance requirement the RT task
> > > needs. But with the introduction of uclamp, RT tasks can now control
> > > that by setting uclamp_min to guarantee a minimum performance point.
> > > 
> > > ATM the uclamp value are only used for frequency selection; but on
> > > heterogeneous systems this is not enough and we need to ensure that the
> > > capacity of the CPU is >= uclamp_min. Which is what implemented here.
> > > 
> > > 	capacity_orig_of(cpu) >= rt_task.uclamp_min
> > > 
> > > Note that by default uclamp.min is 1024, which means that RT tasks will
> > > always be biased towards the big CPUs, which make for a better more
> > > predictable behavior for the default case.
> > > 
> > > Must stress that the bias acts as a hint rather than a definite
> > > placement strategy. For example, if all big cores are busy executing
> > > other RT tasks we can't guarantee that a new RT task will be placed
> > > there.
> > > 
> > > On non-heterogeneous systems the original behavior of RT should be
> > > retained. Similarly if uclamp is not selected in the config.
> > > 
> > > Signed-off-by: Qais Yousef <qais.yousef@arm.com>  
> > 
> > Works for me; Steve you OK with this?
> 
> Nothing against it, but I want to take a deeper look before we accept
> it. Are you OK in waiting a week? I'm currently at Open Source Summit
> and still have two more talks to write (giving them Thursday). I wont
> have time to look till next week.

Apologies if I am being too pushy. But not sure whether this is waiting for its
turn in the queue or slipped through the cracks, hence another gentle reminder
in case it's the latter :-)

Many thanks

--
Qais Yousef
