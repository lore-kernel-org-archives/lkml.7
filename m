Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5094BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D58620657
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551866763;
	bh=AOu2WkhpxixWeC9GLhdwl/bV2QdRCJA0uK0PLp4VtUo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dgoHjEmxCztzkLgKp42ttGoUP8KAUGLzEkKJgpI0Awdrvy9x4uZ8fDyKeBAj9TMDA
	 bFn3c0N27j7Tcgr2QkGE1oI8cEQ9fP/XqUv5S3RAFxmt5I5tTGugdvq4VVWh+NiUPJ
	 nn/iWOewrH82IQ+up+fzHO6a7OlDibMUid64jK6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbfCFKGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:06:01 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35820 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfCFKGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:06:01 -0500
Received: by mail-oi1-f193.google.com with SMTP id u128so9388624oie.2;
        Wed, 06 Mar 2019 02:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fMn2y0wLb1CBo4q1NKwIsbRSTL2ecL1sAS636t87BE0=;
        b=m9SL5Uwa3gl8LzHSPqpQBPyD0tjvGTXjMAb0vaNoWJq329J1IEbDJBv6hcVQsTOYH8
         IT7lMKQayOlwmot3Tw86Av63U4OFL1zy02ZBk5goH3yvlH5Hl8Xj2jdn5IccaDP/Nvid
         aWPLytMMFwp2oPQmtK1yon3q2VrWHRnPzfTe/h97e3MUD7mt5JhQHIKiJ/7tw9rBX1Xg
         EMyb/bE/22AtjyYQe4BPDQscWL9iUFPuX6J0mIVFeBDEQ1FQhstAJ8jQ8WGMybIHxQHk
         wOr3BG8qGEpQBvo2lqRmMHtb7nMNt7YwkVupxgV7CrIecV0dA4mxtPDiWNP4SoDU4pSr
         JOdA==
X-Gm-Message-State: APjAAAXqfObh8Ck3T4uzGB6VSzi4J88lSc7176O2q6XOGRiWHZ5OLhOT
        0TComJdAwM1N0rLCy3nxCyryEnBjsgpY1nbocdc=
X-Google-Smtp-Source: APXvYqxPZwUUgtBAKkQWSygXOoWN/84y5AilGvw90eR18kDi2Uo81Cpu7OzsnSoAwrocS02YRBXcJ3ue8dkpWlJl8MQ=
X-Received: by 2002:aca:6046:: with SMTP id u67mr1119180oib.84.1551866760371;
 Wed, 06 Mar 2019 02:06:00 -0800 (PST)
MIME-Version: 1.0
References: <9956076.F4luUDm1Dq@aspire.rjw.lan> <20190305104256.7kvedlttuovmptpc@queper01-lin>
 <2336151.IZk3Z8DVvP@aspire.rjw.lan> <6357319.Iupbu3ldGQ@aspire.rjw.lan>
 <20190305114406.GV32494@hirez.programming.kicks-ass.net> <20190305120040.y2vmnxrch6kgya3e@queper01-lin>
 <CAJZ5v0hYU763Jx0Ku0HsNMd261z7E0PhZ88_PH6MT=OLYYUAaQ@mail.gmail.com> <20190305173746.p32xolcpueudlzwn@queper01-lin>
In-Reply-To: <20190305173746.p32xolcpueudlzwn@queper01-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Mar 2019 11:05:47 +0100
Message-ID: <CAJZ5v0jJxMw6_6Ep=fee8VGEbqpFKQtA2kX5t1scNwX3GhaTTg@mail.gmail.com>
Subject: Re: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU
 frequency on global turbo changes
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Tue, Mar 5, 2019 at 6:37 PM Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Tuesday 05 Mar 2019 at 18:02:25 (+0100), Rafael J. Wysocki wrote:
> > But that 128 needs to be compared to
> >
> > (SCHED_CAPACITY_SCALE * cpuinfo.min_freq) / cpuinfo.max_freq
> >
> > so with SCHED_CAPACITY_SCALE equal to 1024 this means max_freq 8x
> > higher than min_freq.  That is not totally unreasonable IMO and
> > because sg_cpu->iowait_boost grows exponentially, the difference
> > between 8x and, say, 4x is one iteration.
> >
> > > The first steps will all be below the min freq, so they'll just be
> > > transparent, while right now the iowait boost kicks in much faster :/
> >
> > There can be one iteration of a difference this way or that way AFAICS
> > and I'm not even sure how much of a performance difference that makes
> > in practice.
>
> Yeah I don't expect that to have a huge impact TBH but it'd be nice to
> actually get numbers to verify that, that's all I'm saying :-)
>
> You have 'funny' platforms like Juno r0 out there where the min/max
> frequencies are 450MHz/850Mhz. In this case, starting from 128 you'll
> need 3 wake-ups to reach what is currently the starting point. I'm not
> sure if the impact is visible or not, but it's worth checking.

Please recall that the iowait boosting algo was different to start
with, though: it jumped to the max right away and then backed off.
That turned out to be overly aggressive in general and led to some
undesired "jittery" behavior, which is why it was changed.

Thus it looks like the platforms on which it still jumps to the max
right away may actually benefit from changing it to more steps. :-)

In turn, the platforms where it takes more than 3 steps for the boost
to get to the max would get a slight performance improvement from this
changes and I'm not sure why that could be bad.

Moreover, it didn't depend on the min originally, just on the max and
just because I wanted the number of backoff steps needed to go back
down to zero to be independent of the platform IIRC.  The dependency
on the min is sort of artificial here and leads to arbitrary
differences in behavior between different platforms which isn't
particularly fortunate.

With all of that in mind, I would go right away to making the boost
independent of min and max (the final number of steps to reach the max
is TBD in practice, but 3 looks like a good enough compromise to me).

FWIW, the internal governor in intel_pstate has been changed along
these lines already (the changes is waiting for Linus to pull it ATM).
