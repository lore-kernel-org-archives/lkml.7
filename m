Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC67C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6729B20652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551805360;
	bh=N0NM2eU/LZOpfpFNjRE4OfP+JhxjLXomBhLR/hCsMv0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aQIgfnpSryKqKy3e7AAIBWi+NU8hcSPKpouRhmF93c89h36Qskah4kzDcPyD0er+X
	 90kBRbLZadE643cFaAjA0Me1uExjZVSuCy1wbzYn+neOE0zrtqDQtQTCx1ljVM15H4
	 SlDfllB7vu/iszU5dyods9sOtmOF6cKVK+U4zWZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfCERCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:02:39 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45442 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfCERCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:02:38 -0500
Received: by mail-ot1-f67.google.com with SMTP id i12so8030002otp.12;
        Tue, 05 Mar 2019 09:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tvr8polrrIwEJt+aU5d+gHKuaz0gHGZpVKpThry6+z0=;
        b=Gpo1i3JEZ49icwu0riowhJgjsvLIUHuAezG5LKZVcnfVqe6VyXzV5OHNuGUtgCVZuf
         QBA4gudbcb8lkO8GPDNxCSiAFsJkLeccHU7C9wdFMsrG7PjTn04N/k44eBdfvwjOzAmU
         nDSZi9DscSu9cy3zWJA4Sojlj4GYydsJpvKw4GQ+lYnH0nn56t6X3CRG7/7HqHTOLKJB
         vyCgy/TVOvn8y4h4xJ/9m2mcPBNYIdvMom22ve0MzWh6O4j97mwaOWLGHTqVsMeQEBWb
         zXhbNdSuUoLGOdG/9sHLxv/N2eJf+Om4RtwVUssHB4Clo2VDXtAPlvqLGkneYhaTiHXc
         kC0A==
X-Gm-Message-State: APjAAAVQuKIgRthp7YR7zCHUlkyoU18tLMQ+MUcznHw9DqMvAwYNqMuL
        LoaI84z1+IQV08RVSrQkV9pLSsUr5NFs5TDTMYY=
X-Google-Smtp-Source: APXvYqxG9K6tLluRmr5fhi38TPgmkwVwxSjVYphnOoqIWbFuXHjGWAzEIezpz7CqOEDEpM8vz763RdKY4pyavRN/HTo=
X-Received: by 2002:a9d:6498:: with SMTP id g24mr1570223otl.343.1551805357424;
 Tue, 05 Mar 2019 09:02:37 -0800 (PST)
MIME-Version: 1.0
References: <9956076.F4luUDm1Dq@aspire.rjw.lan> <20190305104256.7kvedlttuovmptpc@queper01-lin>
 <2336151.IZk3Z8DVvP@aspire.rjw.lan> <6357319.Iupbu3ldGQ@aspire.rjw.lan>
 <20190305114406.GV32494@hirez.programming.kicks-ass.net> <20190305120040.y2vmnxrch6kgya3e@queper01-lin>
In-Reply-To: <20190305120040.y2vmnxrch6kgya3e@queper01-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Mar 2019 18:02:25 +0100
Message-ID: <CAJZ5v0hYU763Jx0Ku0HsNMd261z7E0PhZ88_PH6MT=OLYYUAaQ@mail.gmail.com>
Subject: Re: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU
 frequency on global turbo changes
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 1:00 PM Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Tuesday 05 Mar 2019 at 12:44:06 (+0100), Peter Zijlstra wrote:
> > On Tue, Mar 05, 2019 at 11:58:37AM +0100, Rafael J. Wysocki wrote:
> > > So after the Peter's patch "sched/cpufreq: Fix 32bit math overflow"
> > > I will need to recompute sg_cpu->min in sugov_limits().
> >
> > So there's still an open question; do we want that ->min thing to depend
> > on available frequencies _at_all_ ?
> >
> > I'm thinking it might be a good thing to have the iowait boost curve be
> > independent of all that.
> >
> > Like said; if we set it at 128 (static), it takes 9 consequtive wake-ups
> > for it to reach 1024 (max). While now the curve depends on how wide the
> > gap is between min_freq and max_freq. And it seems weird to have this
> > behaviour depend on that. To me at least.
>
> I'm not conceptually against it, but that really wants testing I think.
> I can already see how we're gonna see regressions: 128 is much lower
> than 'min' on my juno for ex, so with the approach you suggest it's
> gonna take several wake-up before the iowait stuff does anything at all.

But that 128 needs to be compared to

(SCHED_CAPACITY_SCALE * cpuinfo.min_freq) / cpuinfo.max_freq

so with SCHED_CAPACITY_SCALE equal to 1024 this means max_freq 8x
higher than min_freq.  That is not totally unreasonable IMO and
because sg_cpu->iowait_boost grows exponentially, the difference
between 8x and, say, 4x is one iteration.

> The first steps will all be below the min freq, so they'll just be
> transparent, while right now the iowait boost kicks in much faster :/

There can be one iteration of a difference this way or that way AFAICS
and I'm not even sure how much of a performance difference that makes
in practice.

OTOH I fundamentally don't see why the iowait boost should ramp up
faster on CPUs having a higher max_freq to min_freq ratio.  Say you
have two platforms, both with max_freq of 2 GHz and with min_freq
equal to 250 MHz and 500 MHz, respectively.  The ratios in question
will be 8 and 4 then, so the first one will reliably react 50% slower
to iowait than the second one for no particular reason at all.

> OTOH, you also have platforms like the recent Snapdragons with 30+ OPPs,
> and for them starting at 128 will speed things up.
>
> So maybe what you want is to start at max(min, 128) ?

That's not just min, though, or is it?
