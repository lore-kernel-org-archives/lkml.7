Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AD0CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC46208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfJ2Ug0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:36:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39348 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2Ug0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:36:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id g19so387818wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 13:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6PFHESszmIfaD8AtMndsfeEaNpXA3n0k01l9itcZNwI=;
        b=CdRd7vqNjsRGdCH3xWuo6DSq3XBMGFRQz+pj2NLJeNk8gYbaGOL1POAKVCDXCn7SZa
         RvVahf5k0BPK0vQ36TzUU+3+PY1HIctr6czmhTiPnmAhNB9Tj9ZFpmEZmLCkY2iJC+Yd
         psMKEd1UtdB1yREx91mqqafySpOAaGSQlNOLBIB4jhzo/OtGMKicqRKkYI+hvYFBxDZN
         Md6v8EilRXoW9b+LGOSMhuXIMsUsREb1kxDM1bjmrzvbvp6wlwlW9sUL9hAehXG9LK9e
         E7eS8ogR11zPqinds0UXNN7RWZS6n43/Bb6uftDe47grdGvJWgr1IzFVzUL2YhFxMZVL
         XvQw==
X-Gm-Message-State: APjAAAVo6cYK1/65vy2TBiolOGwrLspQctAp64rxnEGIEodHa3hYSi0h
        1VokxbAmZuGXUE9CveW4Oic=
X-Google-Smtp-Source: APXvYqxyDYHzaCsmairIUf2sbSYDpVPrMceQNSFXytazxnuOGPC0HnjYI6aihLl+wt/Q14wkQU6zmQ==
X-Received: by 2002:a1c:410a:: with SMTP id o10mr5796611wma.117.1572381383493;
        Tue, 29 Oct 2019 13:36:23 -0700 (PDT)
Received: from darkstar ([109.70.119.5])
        by smtp.gmail.com with ESMTPSA id x12sm4696274wmc.4.2019.10.29.13.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 13:36:22 -0700 (PDT)
Date:   Tue, 29 Oct 2019 20:36:19 +0000
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20191029203619.GA7607@darkstar>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <CAKfTPtA6Fvc374oTfbHYkviAJbZebHkBg=w2O3f0oZ0m3ujVjA@mail.gmail.com>
 <20191029110224.awoi37pdquachqtd@e107158-lin.cambridge.arm.com>
 <CAKfTPtA=CzkTVwdCJL6ULYB628tWdGAvpD-sHfgSfL59PyYvxA@mail.gmail.com>
 <20191029114824.2kb4fygxxx72r3in@e107158-lin.cambridge.arm.com>
 <CAKfTPtD7e-dXhZ3mG36igArt=0f-mNc52vaJ1bb-jv5zB9bkgg@mail.gmail.com>
 <20191029124630.ivfbpenue3fw33qt@e107158-lin.cambridge.arm.com>
 <CAKfTPtDnt6oh7X6dGnPUn70sLJXAQoxdkn0GCwdPvA8G4Wg0fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDnt6oh7X6dGnPUn70sLJXAQoxdkn0GCwdPvA8G4Wg0fA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent, Qais,

On 29-Oct 13:54, Vincent Guittot wrote:
> On Tue, 29 Oct 2019 at 13:46, Qais Yousef <qais.yousef@arm.com> wrote:
> > On 10/29/19 13:20, Vincent Guittot wrote:
> > > > > Making big cores the default CPUs for all RT tasks is not a minor
> > > > > change and IMO locality should stay the default behavior when there is
> > > > > no uclamp constraint

The default value for system-wide's uclamp.min is 1024 because by
default _we want_ RT tasks running at MAX_OPP. This means that by
default RT tasks are running _under constraints_.

The "no uclamp constraints" case you mention requires that you set
uclamp.min=0 for that task. In that case, this patch will do exactly
what you ask for: locality is preserved.

> > > > How this is affecting locality? The task will always go to the big core, so it
> > > > should be local.
> > >
> > > local with the waker
> > > You will force rt task to run on big cluster although waker, data and
> > > interrupts can be on little one.
> > > So making big core as default is far from always being the best choice
> >
> > This is loaded with assumptions IMO. AFAICT we don't know what's the best
> > choice.

Agree... more on that after...

> > First, the value of uclamp.min is outside of the scope of this patch. Unless
> > what you're saying is that when uclamp.min is 1024 then we should NOT choose a
> > big cpu then there's no disagreement about what this patch do. If that's what
> > you're objecting to please be more specific about how do you see this working
> > instead.
> 
> My point is that this patch makes the big cores the default CPUs for
> RT tasks which is far from being a minor change and far from being
> an obvious default good choice

Some time ago we agreed that going to MAX_OPP for RT tasks was
"mandatory". That was defenitively a big change, likely much more
impacting than the one proposed by this patch.

On many mobile devices we ended up pinning RT tasks on LITTLE cores
(mainly) to save quite a lot of energy by avoiding the case of big
CPUs randomly spiking to MAX_OPP just because of a small RT task
waking up on them. We also added some heuristic in schedutil has a
"band aid" for the effects of the aforementioned choice.

By running RT on LITTLEs there could be also some wakeup latency
improvement? Yes, maybe... would be interesting to have some real
HW *and* SW use-case on hand to compare.

However, we know that RT is all about "latency", but what is a bit
more fuzzy is the definition of "latency":

 A) wakeup-latency
    From a scheduler standpoint it's quite often considered as the the
    time it takes to "wakeup" a task and actually start executing its
    instructions.

 B) completion-time
    From an app standpoint, it's quite often important the time to
    complete the task activation and go back to sleep.

Running at MAX_OPP looks much more related to the need to complete
fast than waking up fast, especially considering that that decision
was taken looking mainly (perhaps only) to SMP systems.

On heterogeneous systems, "wakeup-latency" and "completion-time" are
two metrics which *maybe* can be better served by different cores.
However, it's very difficult to argument if one metric is more
important than the other. It's even more difficult to quantify it
because of the multitide of HW and SW combinations.

Thus, what's proposed here can be far from being an "obvious good
chooce", but it's also quite difficult to argue and proof that's
defenitively _not_ a good choice. It's just a default which:

 1) keeps things simple for RT tasks by using the same default
    policy for both frequency and CPUs selection
    we always run (when possible) at the highest available capacity

 2) it's based on a per-task/system-wide tunable mechanism

Is that not enought to justfy it as a default?

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
