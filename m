Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D61C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6D52080A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbfFRJCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:02:45 -0400
Received: from foss.arm.com ([217.140.110.172]:58088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728754AbfFRJCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:02:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64697360;
        Tue, 18 Jun 2019 02:02:44 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BA453F246;
        Tue, 18 Jun 2019 02:02:43 -0700 (PDT)
Date:   Tue, 18 Jun 2019 10:02:42 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/fair: Introduce fits_capacity()
Message-ID: <20190618090239.a4prlefzpc27gwve@queper01-lin>
References: <b477ac75a2b163048bdaeb37f57b4c3f04f75a31.1559631700.git.viresh.kumar@linaro.org>
 <20190605091644.w3g7hc7r3eiscz4f@queper01-lin>
 <20190606025204.qe5v7j6fysjkgxc6@vireshk-i7>
 <20190617150204.GG3436@hirez.programming.kicks-ass.net>
 <20190618031217.63md32da5pzydqia@vireshk-i7>
 <CAJZ5v0g4shiz+Hq+0fS1GQjQX7tK5EyLiX-SOpDoTm4xswV8bg@mail.gmail.com>
 <20190618074728.gf6wugkbndhhcqql@vireshk-i7>
 <CAJZ5v0hi_zXPWqMS_VFnrbs8=BZbhcQRzm6B7fNZYWTXQhA3Mw@mail.gmail.com>
 <20190618082553.tonhmthyy6mo3iui@queper01-lin>
 <CAJZ5v0ikk5CF=wEku-9rhX2HaQzp6LZM2aHTaQn_sOcLq1BXRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ikk5CF=wEku-9rhX2HaQzp6LZM2aHTaQn_sOcLq1BXRg@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 Jun 2019 at 10:36:56 (+0200), Rafael J. Wysocki wrote:
> On Tue, Jun 18, 2019 at 10:25 AM Quentin Perret <quentin.perret@arm.com> wrote:
> >
> > On Tuesday 18 Jun 2019 at 10:10:48 (+0200), Rafael J. Wysocki wrote:
> > > On Tue, Jun 18, 2019 at 9:47 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > On 18-06-19, 09:26, Rafael J. Wysocki wrote:
> > > > > On Tue, Jun 18, 2019 at 5:12 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > > >
> > > > > > +Rafael
> > > > > >
> > > > > > On 17-06-19, 17:02, Peter Zijlstra wrote:
> > > > > > > On Thu, Jun 06, 2019 at 08:22:04AM +0530, Viresh Kumar wrote:
> > > > > > > > Hmm, even if the values are same currently I am not sure if we want
> > > > > > > > the same for ever. I will write a patch for it though, if Peter/Rafael
> > > > > > > > feel the same as you.
> > > > > > >
> > > > > > > Is it really the same variable or just two numbers that happen to be the
> > > > > > > same?
> > > > > >
> > > > > > In both cases we are trying to keep the load under 80% of what can be supported.
> > > > > > But I am not sure of the answer to your question.
> > > > > >
> > > > > > Maybe Rafael knows :)
> > > > >
> > > > > Which variable?
> > > >
> > > > Schedutil multiplies the target frequency by 1.25 (20% more capacity eventually)
> > > > to get enough room for more load and similar thing is done in fair.c at several
> > > > places to see if the new task can fit in a runqueue without overloading it.
> > >
> > > For the schedutil part, see the changelog of the commit that introduced it:
> > >
> > > 9bdcb44e391d cpufreq: schedutil: New governor based on scheduler
> > > utilization data
> > >
> > > As for the other places, I don't know about the exact reasoning.
> > >
> > > > Quentin suggested to use common code for this calculation and that is what is
> > > > getting discussed here.
> > >
> > > I guess if the rationale for the formula is the same in all cases, it
> > > would be good to consolidate that code and document the rationale
> > > while at it.
> >
> > I _think_ it is, but I guess others could correct me if this is
> > incorrect.
> >
> > When choosing a CPU or a frequency using a util value, we look for a
> > capacity that will provide us with 20% of idle time. And in both case we
> > use the same threshold, just hardcoded in different places. Hence the
> > suggestion to unify things.
> >
> > I hope that makes sense :-)
> 
> Well, for schedutil, the 1.25 value comes from the case when
> utilization is not frequency-invariant  the next-frequency formula is
> recursive (the next frequency is proportional to the current one).  It
> is chosen to get the new frequency equal to the old one if (util /
> max) is .8.  That translates to the "capacity that will provide 20%
> more of idle time" in the frequency-invariant utilization case, but
> the original rationale was different.

OK, thanks, I wasn't aware of this. I understood it the other way
around, but re-reading the commit message you shared earlier this makes
sense.

I guess it is also worth mentioning that, to the best of my knowledge,
the vast majority of real-world sugov users are in fact frequency
invariant. So perhaps there is still a case for the code factorization
suggested earlier. But in the end it is really just a cleanup to help
maintainability, so if you guys don't buy in there is no point pushing
further :-)

Thanks,
Quentin
