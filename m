Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F85C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B7F2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tuRV1Zu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfCMVX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:23:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53824 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfCMVX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:23:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id e74so763591wmg.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 14:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d80SjBQPI372fPrNSR2OW/xZJywruVGwSVEcb7iHozw=;
        b=tuRV1Zu7sfoxA4yP2I/0oN8wA9yG3pZK97eA8vRB1jhJwn6Gk/QLm6dhBX/PBVbZZ0
         qAyDIMjrmE2LvMxayNrJiYfj0RLVMxzhCWmQiK9XAa2tWN+gmcTymxbjXQ6W1QT0rtWf
         7Y0jpKpUxi51iXNjsfQ4WpRp5fpbTaixyKB50NmnXehVmaNcPqYe+plOX3a1FaqzjE/A
         HU8D4LzWXu/Z3fJUnjy2UYLf6vnsRA+SjmR5tomDI4U74gM1Yu6p5WIBlZnKTAvsn3CL
         b86oSTiOAcB5aJ4/JCQODN7VM1ok/wTj2cR9M47hmofAdnJLOv93MTR3blOdu4ceZzKS
         9Mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d80SjBQPI372fPrNSR2OW/xZJywruVGwSVEcb7iHozw=;
        b=ZYGItSS+ur5vY31t0Mn77++rkeB1MX7WFQOZ+viz0nGEuhVCAHm5BcCZN+U816bogV
         AL47+J8BmYWKsdzpz4mE7nE7f+t6Tok0qLigPVRwgZnG2zv8aixQ/eGWGHEbU7BOO60x
         9eyBzWSwAnIgox4QQAT56dnPV/tyWWX85w4eG0ylaUOg3/ebshDRLcOIqd7kVzR7MtiJ
         3sBPyN6ATJEQriAd1wWhfoQl2VQzARg4WzmVzdWrDeFUFjO1iq/ch6fyZVi4zuJD5zXM
         VKUKuwY+FMGlxqbZK/vbeIUNMlDoZDfQSe2xpy5dg9u7nWFrLhzR/Yzuhb7T4t6+lxRZ
         T6NQ==
X-Gm-Message-State: APjAAAWtZU8OGs6sjH/4XGL7HqTICenfiFUkkLS2CP5LMcSMvkF2p898
        BupjRSN8ixdJoiSczA/TCDkRso6eECja8Ve1PpvEqg==
X-Google-Smtp-Source: APXvYqw8HajRqvCW5T10NFUQiDN52vNqx1OmMj7SXTI8QUML3iWsKou4Jr5DfCSNgtZ1VrfTJ/lkd6uF+EU28HAfZ/E=
X-Received: by 2002:a1c:f61a:: with SMTP id w26mr166566wmc.70.1552512204479;
 Wed, 13 Mar 2019 14:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com> <20190313135238.GC5922@hirez.programming.kicks-ass.net>
In-Reply-To: <20190313135238.GC5922@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 13 Mar 2019 14:23:13 -0700
Message-ID: <CAJuCfpHNgSOR_ZujZ4XFS2sqGUaJKPOYoc8aqToO=qxA2LhBag@mail.gmail.com>
Subject: Re: [PATCH v7 01/15] sched/core: uclamp: Add CPU's clamp buckets refcounting
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Patrick Bellasi <patrick.bellasi@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 6:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Feb 08, 2019 at 10:05:40AM +0000, Patrick Bellasi wrote:
> > +/*
> > + * When a task is enqueued on a rq, the clamp bucket currently defined by the
> > + * task's uclamp::bucket_id is reference counted on that rq. This also
> > + * immediately updates the rq's clamp value if required.
> > + *
> > + * Since tasks know their specific value requested from user-space, we track
> > + * within each bucket the maximum value for tasks refcounted in that bucket.
> > + * This provide a further aggregation (local clamping) which allows to track
> > + * within each bucket the exact "requested" clamp value whenever all tasks
> > + * RUNNABLE in that bucket require the same clamp.
> > + */
> > +static inline void uclamp_rq_inc_id(struct task_struct *p, struct rq *rq,
> > +                                 unsigned int clamp_id)
> > +{
> > +     unsigned int bucket_id = p->uclamp[clamp_id].bucket_id;
> > +     unsigned int rq_clamp, bkt_clamp, tsk_clamp;
> > +
> > +     rq->uclamp[clamp_id].bucket[bucket_id].tasks++;
> > +
> > +     /*
> > +      * Local clamping: rq's buckets always track the max "requested"
> > +      * clamp value from all RUNNABLE tasks in that bucket.
> > +      */
> > +     tsk_clamp = p->uclamp[clamp_id].value;
> > +     bkt_clamp = rq->uclamp[clamp_id].bucket[bucket_id].value;
> > +     rq->uclamp[clamp_id].bucket[bucket_id].value = max(bkt_clamp, tsk_clamp);
>
> So, if I read this correct:
>
>  - here we track a max value in a bucket,
>
> > +     rq_clamp = READ_ONCE(rq->uclamp[clamp_id].value);
> > +     WRITE_ONCE(rq->uclamp[clamp_id].value, max(rq_clamp, tsk_clamp));
> > +}
> > +
> > +/*
> > + * When a task is dequeued from a rq, the clamp bucket reference counted by
> > + * the task is released. If this is the last task reference counting the rq's
> > + * max active clamp value, then the rq's clamp value is updated.
> > + * Both the tasks reference counter and the rq's cached clamp values are
> > + * expected to be always valid, if we detect they are not we skip the updates,
> > + * enforce a consistent state and warn.
> > + */
> > +static inline void uclamp_rq_dec_id(struct task_struct *p, struct rq *rq,
> > +                                 unsigned int clamp_id)
> > +{
> > +     unsigned int bucket_id = p->uclamp[clamp_id].bucket_id;
> > +     unsigned int rq_clamp, bkt_clamp;
> > +
> > +     SCHED_WARN_ON(!rq->uclamp[clamp_id].bucket[bucket_id].tasks);
> > +     if (likely(rq->uclamp[clamp_id].bucket[bucket_id].tasks))
> > +             rq->uclamp[clamp_id].bucket[bucket_id].tasks--;
> > +
> > +     /*
> > +      * Keep "local clamping" simple and accept to (possibly) overboost
> > +      * still RUNNABLE tasks in the same bucket.
> > +      */
> > +     if (likely(rq->uclamp[clamp_id].bucket[bucket_id].tasks))
> > +             return;
>
> (Oh man, I hope that generates semi sane code; long live CSE passes I
> suppose)
>
> But we never decrement that bkt_clamp value on dequeue.
>
> > +     bkt_clamp = rq->uclamp[clamp_id].bucket[bucket_id].value;
> > +
> > +     /* The rq's clamp value is expected to always track the max */
> > +     rq_clamp = READ_ONCE(rq->uclamp[clamp_id].value);
> > +     SCHED_WARN_ON(bkt_clamp > rq_clamp);
> > +     if (bkt_clamp >= rq_clamp) {
>
> head hurts, this reads ==, how can this ever not be so?
>
> > +             /*
> > +              * Reset rq's clamp bucket value to its nominal value whenever
> > +              * there are anymore RUNNABLE tasks refcounting it.
>
> -ENOPARSE
>
> > +              */
> > +             rq->uclamp[clamp_id].bucket[bucket_id].value =
> > +                     uclamp_bucket_value(rq_clamp);
>
> But basically you decrement the bucket value to the nominal value.
>
> > +             uclamp_rq_update(rq, clamp_id);
> > +     }
> > +}
>
> Given all that, what is to stop the bucket value to climbing to
> uclamp_bucket_value(+1)-1 and staying there (provided there's someone
> runnable)?
>
> Why are we doing this... ?

I agree with Peter, this part of the patch was the hardest to read.
SCHED_WARN_ON line makes sense to me. The condition that follows and
the following comment are a little baffling. Condition seems to
indicate that the code that follows should be executed only if we are
in the top-most occupied bucket (the bucket which has tasks and has
the highest uclamp value). So this bucket just lost its last task and
we should update rq->uclamp[clamp_id].value. However that's not
exactly what the code does... It also resets
rq->uclamp[clamp_id].bucket[bucket_id].value. So if I understand
correctly, unless the bucket that just lost its last task is the
top-most one its value will not be reset to nominal value. That looks
like a bug to me. Am I missing something?

Side note: some more explanation would be very helpful.
