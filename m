Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA655CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3EB205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfJ3J0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:26:48 -0400
Received: from foss.arm.com ([217.140.110.172]:32924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfJ3J0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:26:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B80E1F1;
        Wed, 30 Oct 2019 02:26:47 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB2F63F6C4;
        Wed, 30 Oct 2019 02:26:45 -0700 (PDT)
Date:   Wed, 30 Oct 2019 09:26:43 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Patrick Bellasi <patrick.bellasi@matbug.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20191030092642.pxmc3o2lvphjs4mb@e107158-lin.cambridge.arm.com>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <CAKfTPtA6Fvc374oTfbHYkviAJbZebHkBg=w2O3f0oZ0m3ujVjA@mail.gmail.com>
 <20191029110224.awoi37pdquachqtd@e107158-lin.cambridge.arm.com>
 <CAKfTPtA=CzkTVwdCJL6ULYB628tWdGAvpD-sHfgSfL59PyYvxA@mail.gmail.com>
 <20191029114824.2kb4fygxxx72r3in@e107158-lin.cambridge.arm.com>
 <CAKfTPtD7e-dXhZ3mG36igArt=0f-mNc52vaJ1bb-jv5zB9bkgg@mail.gmail.com>
 <20191029124630.ivfbpenue3fw33qt@e107158-lin.cambridge.arm.com>
 <CAKfTPtDnt6oh7X6dGnPUn70sLJXAQoxdkn0GCwdPvA8G4Wg0fA@mail.gmail.com>
 <20191029203619.GA7607@darkstar>
 <CAKfTPtDFLsn-uSV2ms1qPMMs+2GYWK2jYw8=-2pr_BpBRid6Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDFLsn-uSV2ms1qPMMs+2GYWK2jYw8=-2pr_BpBRid6Kw@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/19 09:04, Vincent Guittot wrote:
> On Tue, 29 Oct 2019 at 21:36, Patrick Bellasi
> <patrick.bellasi@matbug.net> wrote:
> > Some time ago we agreed that going to MAX_OPP for RT tasks was
> > "mandatory". That was defenitively a big change, likely much more
> > impacting than the one proposed by this patch.
> >
> > On many mobile devices we ended up pinning RT tasks on LITTLE cores
> > (mainly) to save quite a lot of energy by avoiding the case of big
> > CPUs randomly spiking to MAX_OPP just because of a small RT task
> > waking up on them. We also added some heuristic in schedutil has a
> > "band aid" for the effects of the aforementioned choice.
> >
> > By running RT on LITTLEs there could be also some wakeup latency
> > improvement? Yes, maybe... would be interesting to have some real
> > HW *and* SW use-case on hand to compare.
> >
> > However, we know that RT is all about "latency", but what is a bit
> > more fuzzy is the definition of "latency":
> >
> >  A) wakeup-latency
> >     From a scheduler standpoint it's quite often considered as the the
> >     time it takes to "wakeup" a task and actually start executing its
> >     instructions.
> >
> >  B) completion-time
> >     From an app standpoint, it's quite often important the time to
> >     complete the task activation and go back to sleep.
> >
> > Running at MAX_OPP looks much more related to the need to complete
> > fast than waking up fast, especially considering that that decision
> 
> You will wake up faster as well when running at MAX_OPP because
> instructions will run faster or at least as fast. That being said,
> running twice faster doesn't mean at all waking up twice faster but
> for sure it will be faster although the gain can be really short.
> Whereas running on a big core with more capacity doesn't mean that you
> will wake up faster because of uarch difference.
> I agree that "long" running rt task will most probably benefit from
> big cores to complete earlier but that no more obvious for short one.

Idle states and other power management features are a known source of latency.
This latency changes across hardware all the time and RT people are accustomed
to test against this.

Android has a wakelock which AFAIR disabled deep sleep because on some sections
the wakeup latency can hinder throughput for some apps. So it's a known problem
outside RT universe too.

> 
> > was taken looking mainly (perhaps only) to SMP systems.
> >
> > On heterogeneous systems, "wakeup-latency" and "completion-time" are
> > two metrics which *maybe* can be better served by different cores.
> > However, it's very difficult to argument if one metric is more
> > important than the other. It's even more difficult to quantify it
> > because of the multitide of HW and SW combinations.
> 
> That's the point of my comment, choosing big cores as default and
> always best choice is far from being obvious.

It's consistent and deterministic unlike the current situation of it depends on
your luck. What you get across boots/runs is completely random and this is
worse than what this patch offers.

The default for Linux has always been putting the system at the highest
performance point by default. And this translates to the biggest CPU at
the highest frequency. It's not ideal but consistent. This doesn't prevent
people from tweaking their systems to get what they want.

> And this patch changes the default behavior without study of the
> impact apart from stating that this should be ok

Without this patch there's no way for an RT task to guarantee a minimum
performance requirement.

I don't think there's a change of the default behavior because without this
patch we could still end up on a big CPU.

And you're stating that the difference between wakeup time in big cores and
little cores is a problem. And as I stated several times this is a known source
of latency that changes across systems and if somebody cares about idle state
latencies then they probably looking at something beyond generic systems and
need to tune it to guarantee a deterministic low latency behavior.

I still don't see any proposed alternative to what should be the default
behavior.

--
Qais Yousef
