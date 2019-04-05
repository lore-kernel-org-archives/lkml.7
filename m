Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F941C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DFE206C0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XG6wtRLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbfDERAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:00:16 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:44584 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731185AbfDERAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:00:16 -0400
Received: by mail-vk1-f194.google.com with SMTP id q189so1590806vkq.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+j8JRpx63PertkzWVtVzgs5Y9k8FnyIUlW0cUxHjtY0=;
        b=XG6wtRLgq9xvOropKTtfRoU4BvZx8odmTka2MRaqCNzARfr7WQWYhzYckbAofBNqyE
         BAntEe3nel8V6gPgplKGrYirrciLyY5l6WgNasp4o0uVEUFID9OhVfkd1lLLd1EY5QDR
         uCcDSjUW3bQoco+VAjcdrKYuCOm2Qu7Pzig6FQbyFaj7otSgv9Fp0LGXawKgG8bVYj4w
         +78247a5okKUMQx/bfkFyStJ0vuR/nFdwEETuaWEMc1EwFScZndZQob/BBkhQdYNl48r
         hbGZTVBXT8fuNt/31OVhTrXh8OiOy4SVIIY5nmhOhbd6y9/bbPeMHdUJ2z0a60W5nSsH
         XUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+j8JRpx63PertkzWVtVzgs5Y9k8FnyIUlW0cUxHjtY0=;
        b=iNkRPcBPQQCYgx3PBMlkvg2JVhSZbJybiPZQR7wa9rb9dPGvSBxLEVI35vtIypURmL
         8FkSU/ldF59OXwQZ4dyeFEfogDvL/LINJk3fly8uhGw6j9be4ufdH799bc/6VwqbXKzS
         fhR+lnWZtv+hp4wUp28nuV3HJ4hQrKS7HRNpcL4iTBSl+dgHODjd3mKdjCU/8phoxHlU
         TS8Sv1zfjMKHb001LYGEnttAv0V4FzefkDZRpyMEHc/Hn7ZPK7wuE43wOyg1Nn+PvDsx
         o6pRQsY7IkojSK0av+buSiFDgdY0L+sPQKClJjD6JC4n+ANqorYEdYLtSlnvyx3HyH5P
         kJVw==
X-Gm-Message-State: APjAAAUIPusSuu+ciS81Rz1XKa8Awb+fMO1UG+D3zIw09w89p7vNP52v
        nWV0NLeo0qBjspOdNmFz5gKU/AWN6J+p+HbuJgiqgw==
X-Google-Smtp-Source: APXvYqwggi6XtkhYxAjkaTn/wNhOt3vDRsdWp1oIdBFFXPXu2gdSKEDRP2R7guRDHW2C0T94/GPi9Nx+N61sWRjuRLc=
X-Received: by 2002:a1f:607:: with SMTP id 7mr8502617vkg.2.1554483614815; Fri,
 05 Apr 2019 10:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190404183219.125083-1-eranian@google.com> <20190404183219.125083-4-eranian@google.com>
 <20190405071333.GB4038@hirez.programming.kicks-ass.net>
In-Reply-To: <20190405071333.GB4038@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 5 Apr 2019 10:00:03 -0700
Message-ID: <CABPqkBTzBYSN_k6FV=iOmmBfZWmG2N9fYHke_MdiCCgO=KFeUw@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf/x86/intel: force resched when TFA sysctl is modified
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, mingo@elte.hu,
        nelson.dsouza@intel.com, Jiri Olsa <jolsa@redhat.com>,
        tonyj@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 12:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Apr 04, 2019 at 11:32:19AM -0700, Stephane Eranian wrote:
> > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > index a4b7711ef0ee..8d356c2096bc 100644
> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -4483,6 +4483,60 @@ static ssize_t freeze_on_smi_store(struct device *cdev,
> >       return count;
> >  }
> >
> > +static void update_tfa_sched(void *ignored)
> > +{
> > +     struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> > +     struct pmu *pmu = x86_get_pmu();
> > +     struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
> > +     struct perf_event_context *task_ctx = cpuctx->task_ctx;
> > +
> > +     /* prevent any changes to the two contexts */
> > +     perf_ctx_lock(cpuctx, task_ctx);
> > +
> > +     /*
> > +      * check if PMC3 is used
> > +      * and if so force schedule out for all event types all contexts
> > +      */
> > +     if (test_bit(3, cpuc->active_mask))
> > +             perf_ctx_resched(cpuctx, task_ctx, EVENT_ALL|EVENT_CPU);
> > +
> > +     perf_ctx_unlock(cpuctx, task_ctx);
>
> I'm not particularly happy with exporting all that. Can't we create this
> new perf_ctx_resched() to include the locking and everything. Then the
> above reduces to:
>
>         if (test_bit(3, cpuc->active_mask))
>                 perf_ctx_resched(cpuctx);
>
> And we don't get to export the tricky bits.
>
The only reason I exported the locking is to protect
cpuc->active_mask. But if you
think there is no race, then sure,  we can just export a new
perf_ctx_resched() that
does the locking and invokes the ctx_resched() function.

> > +}
> > +
> > +static ssize_t show_sysctl_tfa(struct device *cdev,
> > +                           struct device_attribute *attr,
> > +                           char *buf)
> > +{
> > +     return snprintf(buf, 40, "%d\n", allow_tsx_force_abort);
> > +}
> > +
> > +static ssize_t set_sysctl_tfa(struct device *cdev,
> > +                           struct device_attribute *attr,
> > +                           const char *buf, size_t count)
> > +{
> > +     unsigned long val;
> > +     ssize_t ret;
> > +
> > +     ret = kstrtoul(buf, 0, &val);
>
> You want kstrtobool()
>
ok.

> > +     if (ret)
> > +             return ret;
> > +
> > +     /* looking for boolean value */
> > +     if (val > 2)
> > +             return -EINVAL;
> > +
> > +     /* no change */
> > +     if (val == allow_tsx_force_abort)
> > +             return count;
> > +
> > +     allow_tsx_force_abort ^= 1;
>
>         allow_tsx_force_abort = val;
>
> is simpler
>
ok.

> > +
> > +     on_each_cpu(update_tfa_sched, NULL, 1);
> > +
> > +     return count;
> > +}
