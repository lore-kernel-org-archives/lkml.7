Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1FCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7F72077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePSLDtta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfCMVIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:08:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34668 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfCMVIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:08:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id o10so5345715wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 14:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Sj3/B1TutE7la+qMYdWFTfOoySCQcB6tOlTXpfsPD4=;
        b=ePSLDtta3Qr1+qwoucTpXM5FUs9cR7BnqAkQleX8O5gxCJghKJJmRCF/H9DElRtHjf
         /wwhXbjE7XlIx1I2G+x5qCzPBdG8mxsEnpF50B5do+hxYPNHOJqDty/aniOPOtw7N9ma
         qsNdorwgm87VfUx1ckbB82QIPzJPW1yAZ+9p5SMV3bp1bnUoFe7aSXypIIieeMisKI/p
         E5emh/YA+4wdMMLfqApSVvrifgJROCOKi63V5yv19WU9IIE7Cd3cGluEnyqUsuBiywP7
         iOkq0xLIIo9fUVfxSYCnTa+58TkLF8wGFN5FrHRaKpHlY3d/Oz6FFFlCfBFjBWuT36sU
         5DWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Sj3/B1TutE7la+qMYdWFTfOoySCQcB6tOlTXpfsPD4=;
        b=qmxZNXMyCYZTAjqZbiCg8lEqJUMIm7rWTOU10n1AM7q3yZnXE1NCPPfYSt0/mdadtL
         vwe7pQfZfHwgRZJg+lKPYaytFIZbqtbuZPB7IH8w7c5GuPR3hJWEXseavLje1wh51FH1
         Dwt5y7eaj/nvCDwAltbFDzcqC3os0v6rQAMTTdgYTfqmkCL+ddqEAPZxE6yQ12Dqidkh
         +6/VL/i5q3TAknnErw7MkRWi3azA61fcJx5OnIdVX62xc3EutBeqTP3Pgd77sSlIbToI
         9tMEBgGp++ZjQbUMKn1+NecufNaKLhRlTGwOiPtRGplYY4sTkdv2gkH/QAXBa2JS8SEF
         q1dg==
X-Gm-Message-State: APjAAAV5suutAwEjAD9hWIkT5tjsf8vVSS31vteonKV1mUaZQGOL0kLc
        MQymR+1Hmr7ng4p+Zdul/FWdl+TlJcZ5hiDiGH4Y/w==
X-Google-Smtp-Source: APXvYqyGNkL/4Nz9VIhhygAIQ57GzNzZvEd3Ngn2HKilMsRWxNynpN3fAjC8vgB+w1SGrsjbVl33Xw4x/8t9tQcmcQ8=
X-Received: by 2002:a1c:f61a:: with SMTP id w26mr130775wmc.70.1552511312837;
 Wed, 13 Mar 2019 14:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com> <20190313140925.GE5922@hirez.programming.kicks-ass.net>
 <20190313152359.lkyzel7fakjoi5hu@e110439-lin> <20190313194619.GR2482@worktop.programming.kicks-ass.net>
In-Reply-To: <20190313194619.GR2482@worktop.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 13 Mar 2019 14:08:21 -0700
Message-ID: <CAJuCfpHy0+6f9mRd+cF-oQrrUWJ4m8mOQJ7XMzkDL4mhfYyj2g@mail.gmail.com>
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

On Wed, Mar 13, 2019 at 12:46 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 13, 2019 at 03:23:59PM +0000, Patrick Bellasi wrote:
> > On 13-Mar 15:09, Peter Zijlstra wrote:
> > > On Fri, Feb 08, 2019 at 10:05:40AM +0000, Patrick Bellasi wrote:
>
> > > > +static inline void uclamp_rq_update(struct rq *rq, unsigned int clamp_id)
> > > > +{
> > > > + struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
> > > > + unsigned int max_value = uclamp_none(clamp_id);
> > >
> > > That's 1024 for uclamp_max
> > >
> > > > + unsigned int bucket_id;
> > > > +
> > > > + /*
> > > > +  * Both min and max clamps are MAX aggregated, thus the topmost
> > > > +  * bucket with some tasks defines the rq's clamp value.
> > > > +  */
> > > > + bucket_id = UCLAMP_BUCKETS;
> > > > + do {
> > > > +         --bucket_id;
> > > > +         if (!rq->uclamp[clamp_id].bucket[bucket_id].tasks)
> > > > +                 continue;
> > > > +         max_value = bucket[bucket_id].value;
> > >
> > > but this will then _lower_ it. That's not a MAX aggregate.
> >
> > For uclamp_max we want max_value=1024 when there are no active tasks,
> > which means: no max clamp enforced on CFS/RT "idle" cpus.
> >
> > If instead there are active RT/CFS tasks then we want the clamp value
> > of the max group, which means: MAX aggregate active clamps.
> >
> > That's what the code above does and the comment says.
>
> That's (obviously) not how I read it... maybe something like:
>
> static inline void uclamp_rq_update(struct rq *rq, unsigned int clamp_id)
> {
>         struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
>         int i;
>
>         /*
>          * Since both min and max clamps are max aggregated, find the
>          * top most bucket with tasks in.
>          */
>         for (i = UCLMAP_BUCKETS-1; i>=0; i--) {
>                 if (!bucket[i].tasks)
>                         continue;
>                 return bucket[i].value;
>         }
>
>         /* No tasks -- default clamp values */
>         return uclamp_none(clamp_id);
> }
>
> would make it clearer?

This way it's also more readable/obvious when it's used inside
uclamp_rq_dec_id, assuming uclamp_rq_update is renamed into smth like
get_max_rq_uclamp.
