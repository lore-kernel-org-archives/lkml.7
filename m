Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6737AC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E222184B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbfIELNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:13:52 -0400
Received: from foss.arm.com ([217.140.110.172]:42326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731124AbfIELNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:13:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24F4928;
        Thu,  5 Sep 2019 04:13:51 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56BCB3F718;
        Thu,  5 Sep 2019 04:13:49 -0700 (PDT)
Date:   Thu, 5 Sep 2019 12:13:47 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Patrick Bellasi <patrick.bellasi@arm.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
Message-ID: <20190905111346.2w6kuqrdvaqvgilu@e107158-lin.cambridge.arm.com>
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-2-subhra.mazumdar@oracle.com>
 <20190905083127.GA2332@hirez.programming.kicks-ass.net>
 <87r24v2i14.fsf@arm.com>
 <20190905104616.GD2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190905104616.GD2332@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/19 12:46, Peter Zijlstra wrote:
> On Thu, Sep 05, 2019 at 10:45:27AM +0100, Patrick Bellasi wrote:
> 
> > > From just reading the above, I would expect it to have the range
> > > [-20,19] just like normal nice. Apparently this is not so.
> > 
> > Regarding the range for the latency-nice values, I guess we have two
> > options:
> > 
> >   - [-20..19], which makes it similar to priorities
> >   downside: we quite likely end up with a kernel space representation
> >   which does not match the user-space one, e.g. look at
> >   task_struct::prio.
> > 
> >   - [0..1024], which makes it more similar to a "percentage"
> > 
> > Being latency-nice a new concept, we are not constrained by POSIX and
> > IMHO the [0..1024] scale is a better fit.
> > 
> > That will translate into:
> > 
> >   latency-nice=0 : default (current mainline) behaviour, all "biasing"
> >   policies are disabled and we wakeup up as fast as possible
> > 
> >   latency-nice=1024 : maximum niceness, where for example we can imaging
> >   to turn switch a CFS task to be SCHED_IDLE?
> 
> There's a few things wrong there; I really feel that if we call it nice,
> it should be like nice. Otherwise we should call it latency-bias and not
> have the association with nice to confuse people.
> 
> Secondly; the default should be in the middle of the range. Naturally
> this would be a signed range like nice [-(x+1),x] for some x. but if you
> want [0,1024], then the default really should be 512, but personally I
> like 0 better as a default, in which case we need negative numbers.
> 
> This is important because we want to be able to bias towards less
> importance to (tail) latency as well as more importantance to (tail)
> latency.
> 
> Specifically, Oracle wants to sacrifice (some) latency for throughput.
> Facebook OTOH seems to want to sacrifice (some) throughput for latency.

Another use case I'm considering is using latency-nice to prefer an idle CPU if
latency-nice is set otherwise go for the most energy efficient CPU.

Ie: sacrifice (some) energy for latency.

The way I see interpreting latency-nice here as a binary switch. But maybe we
can use the range to select what (some) energy to sacrifice mean here. Hmmm.

--
Qais Yousef
