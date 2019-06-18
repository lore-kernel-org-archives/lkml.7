Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF350C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9364F20863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560847030;
	bh=pOl8hp7ErzE10odfbfXqxel4nCEJUGnoHpytMdJU71c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q0l+wnbAsCXM41FwjbKNWlgvXp/S/54IyrMxOzJVpRWb/6ejJZhDygGix1dV0Z288
	 rZQ5MdH/tMQ3B/sTwCsyB9B3C75S4GbwkIUpukyPeKa+y1oJZwr/9hBXHWRxxmPkSO
	 4hr3Enq9ohYOUcXGXavEXbuPVAsh/i8wreyEYUU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfFRIhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:37:08 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43741 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRIhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:37:08 -0400
Received: by mail-ot1-f68.google.com with SMTP id i8so13169558oth.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 01:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vs5hrJ5pfttuFADI0+px3A7KNInmvfHfM3AFeRhj2DQ=;
        b=YlnGXuGO2nnmLB0rw9rHFHKFgJWBwpPBxCBFXYR4X1qYyT8gXXu4aBtdjqV/pWwkmw
         lnCxWQNNkEXvFEKwldJxjXevsyl8ndo3qXK/R/H4vcHUwkiDT+oRbAX+QS1pPwaE7ecp
         Uv0mOXY9gjBCL7UcvavVqqNqKqsegtQ32nE2qUI0Xd01I+DqHPWuBFkmvxxPOWtosW4T
         ef2QEVa95/r2AQKLhhNlPsgBXgRItYaukP5+2Q9f21bBXnOxanqaESDeUPpkgEVwtHXz
         fN49XZv6J5m6vCPAAMVP4UCfxi+5O1do9hZNa20U28oCDIl7mzFSEqdzI2BrJQvCqbqm
         MGiA==
X-Gm-Message-State: APjAAAWxNEzfdnFxx9gOZSAFqDEN47DDWcpD+p5nFp6jEPADQjJeRL0P
        gyRknRd4NwOdG4WT+y407YfZnEhXYGwlmEESl4VlORAA
X-Google-Smtp-Source: APXvYqzJ7oYm3mvUKJ+guhd8vXPBhvs1ffS1Z9ZPYmdhoL9qrPqMUTU2cwTK+5VqqVjCCPcHT/c9OBNdZv77rU44U7o=
X-Received: by 2002:a9d:6959:: with SMTP id p25mr39616191oto.118.1560847027640;
 Tue, 18 Jun 2019 01:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <b477ac75a2b163048bdaeb37f57b4c3f04f75a31.1559631700.git.viresh.kumar@linaro.org>
 <20190605091644.w3g7hc7r3eiscz4f@queper01-lin> <20190606025204.qe5v7j6fysjkgxc6@vireshk-i7>
 <20190617150204.GG3436@hirez.programming.kicks-ass.net> <20190618031217.63md32da5pzydqia@vireshk-i7>
 <CAJZ5v0g4shiz+Hq+0fS1GQjQX7tK5EyLiX-SOpDoTm4xswV8bg@mail.gmail.com>
 <20190618074728.gf6wugkbndhhcqql@vireshk-i7> <CAJZ5v0hi_zXPWqMS_VFnrbs8=BZbhcQRzm6B7fNZYWTXQhA3Mw@mail.gmail.com>
 <20190618082553.tonhmthyy6mo3iui@queper01-lin>
In-Reply-To: <20190618082553.tonhmthyy6mo3iui@queper01-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Jun 2019 10:36:56 +0200
Message-ID: <CAJZ5v0ikk5CF=wEku-9rhX2HaQzp6LZM2aHTaQn_sOcLq1BXRg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Introduce fits_capacity()
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 10:25 AM Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Tuesday 18 Jun 2019 at 10:10:48 (+0200), Rafael J. Wysocki wrote:
> > On Tue, Jun 18, 2019 at 9:47 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 18-06-19, 09:26, Rafael J. Wysocki wrote:
> > > > On Tue, Jun 18, 2019 at 5:12 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > >
> > > > > +Rafael
> > > > >
> > > > > On 17-06-19, 17:02, Peter Zijlstra wrote:
> > > > > > On Thu, Jun 06, 2019 at 08:22:04AM +0530, Viresh Kumar wrote:
> > > > > > > Hmm, even if the values are same currently I am not sure if we want
> > > > > > > the same for ever. I will write a patch for it though, if Peter/Rafael
> > > > > > > feel the same as you.
> > > > > >
> > > > > > Is it really the same variable or just two numbers that happen to be the
> > > > > > same?
> > > > >
> > > > > In both cases we are trying to keep the load under 80% of what can be supported.
> > > > > But I am not sure of the answer to your question.
> > > > >
> > > > > Maybe Rafael knows :)
> > > >
> > > > Which variable?
> > >
> > > Schedutil multiplies the target frequency by 1.25 (20% more capacity eventually)
> > > to get enough room for more load and similar thing is done in fair.c at several
> > > places to see if the new task can fit in a runqueue without overloading it.
> >
> > For the schedutil part, see the changelog of the commit that introduced it:
> >
> > 9bdcb44e391d cpufreq: schedutil: New governor based on scheduler
> > utilization data
> >
> > As for the other places, I don't know about the exact reasoning.
> >
> > > Quentin suggested to use common code for this calculation and that is what is
> > > getting discussed here.
> >
> > I guess if the rationale for the formula is the same in all cases, it
> > would be good to consolidate that code and document the rationale
> > while at it.
>
> I _think_ it is, but I guess others could correct me if this is
> incorrect.
>
> When choosing a CPU or a frequency using a util value, we look for a
> capacity that will provide us with 20% of idle time. And in both case we
> use the same threshold, just hardcoded in different places. Hence the
> suggestion to unify things.
>
> I hope that makes sense :-)

Well, for schedutil, the 1.25 value comes from the case when
utilization is not frequency-invariant  the next-frequency formula is
recursive (the next frequency is proportional to the current one).  It
is chosen to get the new frequency equal to the old one if (util /
max) is .8.  That translates to the "capacity that will provide 20%
more of idle time" in the frequency-invariant utilization case, but
the original rationale was different.
