Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278B0CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E079420874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r8lanPsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfJ3IE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:04:58 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40777 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfJ3IE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:04:58 -0400
Received: by mail-lf1-f68.google.com with SMTP id f4so801660lfk.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 01:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tH0v8CKp4rkqpt8Oe+l5sC+1JZVbcOeXEIccbuIjsLY=;
        b=r8lanPsZ5r4DYw8xhoSUxPC6Og+6ox8PfERevdtaWjVFkqYsqWlqGYvRTXWFjBxxkF
         LSyNvdzS1ABOlsYBdGo9D7/bao9ip9WaDafN+ThzbwTB5RjYH2pICKu6rmHXFOr5+7fp
         r9XWIritTeXZnmg8Gw+YYIYAQFLsfH8j0fgisUPBVAgdF6EE38FHQkIjWbNicBmyaJNY
         cLl1ShtR0r4qiIoqDuwHuPahFVlphjGDVkc6F/9Cf+i6YvhjBaplw2C7N/YOa+PZXbjS
         K3YkvEYAVKG4f91YnSW+gypAdouX6DxoywsPlVNSARVENvJapuzEam0vAkKjdf+NyDjA
         hohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tH0v8CKp4rkqpt8Oe+l5sC+1JZVbcOeXEIccbuIjsLY=;
        b=ZhYT+eih0FiewkCrH40H3wAQD6I9zD15Dp7k5nbm6YuN4laFfEKYzSeBXFkWY0o8L8
         ZdxbSHaUrWwIlqFulqwEIdPtVIqfjpRfCRICyKcVHa/DyLT4NvxKekR0MIdUyFz3y/Rq
         BZRFzWAfs5ynsQHcnPDhbXBfQ39H+47K+Uu/2R4CnuiKD5Ik94KL+TxKQoxI4zW8XvJQ
         DSQ1GsmT25EERyar1KrvmkPGR+T3uYoEFlJIgOZSpiOO3RaCT0qDalaEMuKzcYHKMTCi
         gOLyNpYOOiEnts4oUU08oH7ViVye7SEbgUYQtdavPmsTs1lxIVqbiFInMwCaUrGrY6Nz
         xeyQ==
X-Gm-Message-State: APjAAAVCSB1p7RTMXjGBE4pW/uLExwWhrDUXrc1wOE6nyCCwJV87Xv1H
        PgmJrwq5F1Mo97507geCD9ANKuSVY4914Exu8yWPcg==
X-Google-Smtp-Source: APXvYqwmKaoz+eND32DeKMSy8hUHpIOc38nMiJiEindaniFhBHsD7p3AkfybNOSyJG/lVRrF48F5hff5bzutZdDIJWY=
X-Received: by 2002:ac2:5dc1:: with SMTP id x1mr5069448lfq.177.1572422695426;
 Wed, 30 Oct 2019 01:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191009104611.15363-1-qais.yousef@arm.com> <CAKfTPtA6Fvc374oTfbHYkviAJbZebHkBg=w2O3f0oZ0m3ujVjA@mail.gmail.com>
 <20191029110224.awoi37pdquachqtd@e107158-lin.cambridge.arm.com>
 <CAKfTPtA=CzkTVwdCJL6ULYB628tWdGAvpD-sHfgSfL59PyYvxA@mail.gmail.com>
 <20191029114824.2kb4fygxxx72r3in@e107158-lin.cambridge.arm.com>
 <CAKfTPtD7e-dXhZ3mG36igArt=0f-mNc52vaJ1bb-jv5zB9bkgg@mail.gmail.com>
 <20191029124630.ivfbpenue3fw33qt@e107158-lin.cambridge.arm.com>
 <CAKfTPtDnt6oh7X6dGnPUn70sLJXAQoxdkn0GCwdPvA8G4Wg0fA@mail.gmail.com> <20191029203619.GA7607@darkstar>
In-Reply-To: <20191029203619.GA7607@darkstar>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 30 Oct 2019 09:04:44 +0100
Message-ID: <CAKfTPtDFLsn-uSV2ms1qPMMs+2GYWK2jYw8=-2pr_BpBRid6Kw@mail.gmail.com>
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2019 at 21:36, Patrick Bellasi
<patrick.bellasi@matbug.net> wrote:
>
> Hi Vincent, Qais,
>
> On 29-Oct 13:54, Vincent Guittot wrote:
> > On Tue, 29 Oct 2019 at 13:46, Qais Yousef <qais.yousef@arm.com> wrote:
> > > On 10/29/19 13:20, Vincent Guittot wrote:
> > > > > > Making big cores the default CPUs for all RT tasks is not a minor
> > > > > > change and IMO locality should stay the default behavior when there is
> > > > > > no uclamp constraint
>
> The default value for system-wide's uclamp.min is 1024 because by
> default _we want_ RT tasks running at MAX_OPP. This means that by
> default RT tasks are running _under constraints_.
>
> The "no uclamp constraints" case you mention requires that you set
> uclamp.min=0 for that task. In that case, this patch will do exactly
> what you ask for: locality is preserved.
>
> > > > > How this is affecting locality? The task will always go to the big core, so it
> > > > > should be local.
> > > >
> > > > local with the waker
> > > > You will force rt task to run on big cluster although waker, data and
> > > > interrupts can be on little one.
> > > > So making big core as default is far from always being the best choice
> > >
> > > This is loaded with assumptions IMO. AFAICT we don't know what's the best
> > > choice.
>
> Agree... more on that after...
>
> > > First, the value of uclamp.min is outside of the scope of this patch. Unless
> > > what you're saying is that when uclamp.min is 1024 then we should NOT choose a
> > > big cpu then there's no disagreement about what this patch do. If that's what
> > > you're objecting to please be more specific about how do you see this working
> > > instead.
> >
> > My point is that this patch makes the big cores the default CPUs for
> > RT tasks which is far from being a minor change and far from being
> > an obvious default good choice
>
> Some time ago we agreed that going to MAX_OPP for RT tasks was
> "mandatory". That was defenitively a big change, likely much more
> impacting than the one proposed by this patch.
>
> On many mobile devices we ended up pinning RT tasks on LITTLE cores
> (mainly) to save quite a lot of energy by avoiding the case of big
> CPUs randomly spiking to MAX_OPP just because of a small RT task
> waking up on them. We also added some heuristic in schedutil has a
> "band aid" for the effects of the aforementioned choice.
>
> By running RT on LITTLEs there could be also some wakeup latency
> improvement? Yes, maybe... would be interesting to have some real
> HW *and* SW use-case on hand to compare.
>
> However, we know that RT is all about "latency", but what is a bit
> more fuzzy is the definition of "latency":
>
>  A) wakeup-latency
>     From a scheduler standpoint it's quite often considered as the the
>     time it takes to "wakeup" a task and actually start executing its
>     instructions.
>
>  B) completion-time
>     From an app standpoint, it's quite often important the time to
>     complete the task activation and go back to sleep.
>
> Running at MAX_OPP looks much more related to the need to complete
> fast than waking up fast, especially considering that that decision

You will wake up faster as well when running at MAX_OPP because
instructions will run faster or at least as fast. That being said,
running twice faster doesn't mean at all waking up twice faster but
for sure it will be faster although the gain can be really short.
Whereas running on a big core with more capacity doesn't mean that you
will wake up faster because of uarch difference.
I agree that "long" running rt task will most probably benefit from
big cores to complete earlier but that no more obvious for short one.

> was taken looking mainly (perhaps only) to SMP systems.
>
> On heterogeneous systems, "wakeup-latency" and "completion-time" are
> two metrics which *maybe* can be better served by different cores.
> However, it's very difficult to argument if one metric is more
> important than the other. It's even more difficult to quantify it
> because of the multitide of HW and SW combinations.

That's the point of my comment, choosing big cores as default and
always best choice is far from being obvious.
And this patch changes the default behavior without study of the
impact apart from stating that this should be ok

>
> Thus, what's proposed here can be far from being an "obvious good
> chooce", but it's also quite difficult to argue and proof that's
> defenitively _not_ a good choice. It's just a default which:
>
>  1) keeps things simple for RT tasks by using the same default
>     policy for both frequency and CPUs selection
>     we always run (when possible) at the highest available capacity
>
>  2) it's based on a per-task/system-wide tunable mechanism
>
> Is that not enought to justfy it as a default?
>
> Best,
> Patrick
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
