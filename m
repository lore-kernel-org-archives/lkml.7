Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFCDC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4220520863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfFRIWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:22:19 -0400
Received: from foss.arm.com ([217.140.110.172]:56578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfFRIWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:22:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AF2928;
        Tue, 18 Jun 2019 01:22:18 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 226CB3F246;
        Tue, 18 Jun 2019 01:22:17 -0700 (PDT)
Date:   Tue, 18 Jun 2019 09:22:12 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/fair: Introduce fits_capacity()
Message-ID: <20190618082209.xshfus2t626o2dgb@queper01-lin>
References: <b477ac75a2b163048bdaeb37f57b4c3f04f75a31.1559631700.git.viresh.kumar@linaro.org>
 <20190605091644.w3g7hc7r3eiscz4f@queper01-lin>
 <20190606025204.qe5v7j6fysjkgxc6@vireshk-i7>
 <20190617150204.GG3436@hirez.programming.kicks-ass.net>
 <20190618031217.63md32da5pzydqia@vireshk-i7>
 <CAJZ5v0g4shiz+Hq+0fS1GQjQX7tK5EyLiX-SOpDoTm4xswV8bg@mail.gmail.com>
 <20190618074728.gf6wugkbndhhcqql@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618074728.gf6wugkbndhhcqql@vireshk-i7>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 Jun 2019 at 13:17:28 (+0530), Viresh Kumar wrote:
> On 18-06-19, 09:26, Rafael J. Wysocki wrote:
> > On Tue, Jun 18, 2019 at 5:12 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > +Rafael
> > >
> > > On 17-06-19, 17:02, Peter Zijlstra wrote:
> > > > On Thu, Jun 06, 2019 at 08:22:04AM +0530, Viresh Kumar wrote:
> > > > > Hmm, even if the values are same currently I am not sure if we want
> > > > > the same for ever. I will write a patch for it though, if Peter/Rafael
> > > > > feel the same as you.
> > > >
> > > > Is it really the same variable or just two numbers that happen to be the
> > > > same?
> > >
> > > In both cases we are trying to keep the load under 80% of what can be supported.
> > > But I am not sure of the answer to your question.
> > >
> > > Maybe Rafael knows :)
> > 
> > Which variable?
> 
> Schedutil multiplies the target frequency by 1.25 (20% more capacity eventually)
> to get enough room for more load and similar thing is done in fair.c at several
> places to see if the new task can fit in a runqueue without overloading it.
> 
> Quentin suggested to use common code for this calculation and that is what is
> getting discussed here.

Right, sugov and load balance happen to use the same margin (1.25)
to check if a given util fits in a given capacity, though the thresholds
are hardcoded in different places (see map_util_freq() and
capacity_margin). So my suggestion was to unify the capacity_margin code
for frequency selection and CPU selection, for clarity and consistency.

But again, this is a small thing and FWIW Viresh's patch LGTM as-is so
no objection from my end if you guys would like to merge it.

Thanks,
Quentin
