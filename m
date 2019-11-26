Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56F6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968CA20722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfKZJj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 04:39:26 -0500
Received: from foss.arm.com ([217.140.110.172]:60304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727482AbfKZJj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 04:39:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70E6855D;
        Tue, 26 Nov 2019 01:39:25 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39FEF3F52E;
        Tue, 26 Nov 2019 01:39:24 -0800 (PST)
Date:   Tue, 26 Nov 2019 09:39:21 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20191126093921.7tjsxiliyfgea76o@e107158-lin.cambridge.arm.com>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <20191125163650.6a624fee@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191125163650.6a624fee@gandalf.local.home>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/19 16:36, Steven Rostedt wrote:
> Sorry for the very late response...

No worries and thanks for taking the time to look at this!

> 
> On Wed,  9 Oct 2019 11:46:11 +0100
> Qais Yousef <qais.yousef@arm.com> wrote:
> 
> > ATM the uclamp value are only used for frequency selection; but on
> > heterogeneous systems this is not enough and we need to ensure that the
> > capacity of the CPU is >= uclamp_min. Which is what implemented here.
> 
> Is it possible that the capacity can be fixed, where the process can
> just have a cpu mask of CPUs that has the capacity for it?

It is possible and I did consider it. But it didn't feel right because:

	1. The same can be achieved with regular affinities.
	2. On some systems, especially medium and lower end devices the number
	   of big cores might be small (2 bigs and 6 littles is common).
	   I couldn't justify that pinning to bigs is always better than
	   letting the system try to balance itself in case it gets overloaded.

The thing with RT is that generally we offer little guarantees if the system is
not designed properly and the user can easily shoot themselves in the foot.

This implementation offered the simplest best effort while still not being too
restrictive.

But the idea is valid and worth looking at in the future.

> 
> Not that this will affect this patch now, but just something for the
> future.
> 
> > 
> > 	capacity_orig_of(cpu) >= rt_task.uclamp_min
> > 
> > Note that by default uclamp.min is 1024, which means that RT tasks will
> > always be biased towards the big CPUs, which make for a better more
> > predictable behavior for the default case.
> > 
> > Must stress that the bias acts as a hint rather than a definite
> > placement strategy. For example, if all big cores are busy executing
> > other RT tasks we can't guarantee that a new RT task will be placed
> > there.
> > 
> > On non-heterogeneous systems the original behavior of RT should be
> > retained. Similarly if uclamp is not selected in the config.
> > 
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks for your time :-)

--
Qais Yousef
