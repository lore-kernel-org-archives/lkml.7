Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7B2C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA7F2063F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DxN5X3ra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfF0Vr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:47:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34830 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF0Vr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:47:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id f15so4150803wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 14:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PzZt6XuMzPi+f0gEcTLAkPhPkafzoXJbDf8oWpxJ0aU=;
        b=DxN5X3raZefiu0gnkZ/CQkYMwgsr6oMmNER685hAq7U93AFkM/Co0/DMW+0/4AJwRz
         JZmmWfS0oEaSTqvWMYhLgnQa2C+Qb0FCOx03ArngRGKzfHW714j9UkK296+dH+cxr5HW
         39LXgMgNAwFsp38qXR01o/LC719A9geKjjisG/VIFhQCWCVpPSLG4XJt555THZ39Xgek
         rlYOTPHOXYZqRWMitz0+gXLK54OFj5Az1/p/UQod0gan8gMC4uy3KvphKHaSH7H0MlMy
         CivAqCKNix0IytJmSR/Ikj4UEYNDUYb3MPseNNpFvttQorRkz/LP94RnFJknIF9ke3Q7
         l99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PzZt6XuMzPi+f0gEcTLAkPhPkafzoXJbDf8oWpxJ0aU=;
        b=EXUOQRW6bf4zx5ddbqBwwPQL9fJaoN8KttzKGcnXnFRDOkNbIb7YJWM0vI2BfSXZVi
         s1kYmH//AXlFjMpmZFzugF751nyjDuHVqRTQmcHANsVH6wAM70rpS9BekVQeydrzhgoM
         aMlGTsrMhTXWidtX5g0Bp6P3+D0INcbUIsURmmDfRfIejUGvOLL4i5wR9Ny5iiNRVZ5B
         GyfpAbva5T+5f1UYV0rk6mKI79JpwrgmPeUDSsfBzCigTWYEnjV920WH9dt6dRayFPNK
         BhSTZCqJLxRBC6pFwdcfjLtSSNjB+fB1jnVx+cFSjQ9pUOTRVDm9R+MvmgrZ5grk0Xuo
         rsMg==
X-Gm-Message-State: APjAAAUk8EaEsmuB8Ng9OrYfISRTsCKgVuMcQbcfv+8wfvtM8uTNI0QB
        t6Xsblgc8CdHFwd2Cg7+PVBfIKfWfksZc8zsi7mamg==
X-Google-Smtp-Source: APXvYqy5VCppPtraXbrxbq8fGiYCcCZUMoXJqjj3i7Nc04lYPbeJymPHIVzymagrcVORS64b1gz7r3RljKGSI7/XO60=
X-Received: by 2002:adf:db12:: with SMTP id s18mr4475065wri.335.1561672043602;
 Thu, 27 Jun 2019 14:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190601082722.44543-1-irogers@google.com> <20190621082422.GH3436@hirez.programming.kicks-ass.net>
 <CAP-5=fW7sMjQEHm+1e=cdAi+ZyP53UyU7xhAbnouMApuxYqrhw@mail.gmail.com> <20190624075520.GC3436@hirez.programming.kicks-ass.net>
In-Reply-To: <20190624075520.GC3436@hirez.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 Jun 2019 14:47:12 -0700
Message-ID: <CAP-5=fU=xbP39b6WZV4h92g6Ub_w4tH2JdApw5t6DTyZqxShUQ@mail.gmail.com>
Subject: Re: [PATCH] perf cgroups: Don't rotate events for cgroups unnecessarily
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

group_index On Mon, Jun 24, 2019 at 12:55 AM Peter Zijlstra
<peterz@infradead.org> wrote:
>
> On Fri, Jun 21, 2019 at 11:01:29AM -0700, Ian Rogers wrote:
> > On Fri, Jun 21, 2019 at 1:24 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Sat, Jun 01, 2019 at 01:27:22AM -0700, Ian Rogers wrote:
> > > > @@ -3325,6 +3331,15 @@ static int flexible_sched_in(struct perf_event *event, void *data)
> > > >                       sid->can_add_hw = 0;
> > > >       }
> > > >
> > > > +     /*
> > > > +      * If the group wasn't scheduled then set that multiplexing is necessary
> > > > +      * for the context. Note, this won't be set if the event wasn't
> > > > +      * scheduled due to event_filter_match failing due to the earlier
> > > > +      * return.
> > > > +      */
> > > > +     if (event->state == PERF_EVENT_STATE_INACTIVE)
> > > > +             sid->ctx->rotate_necessary = 1;
> > > > +
> > > >       return 0;
> > > >  }
> > >
> > > That looked odd; which had me look harder at this function which
> > > resulted in the below. Should we not terminate the context interation
> > > the moment one flexible thingy fails to schedule?
> >
> > If we knew all the events were hardware events then this would be
> > true, as there may be software events that always schedule then the
> > continued iteration is necessary.
>
> But this is the 'old' code, where this is guaranteed by the context.
> That is, if this is a hardware context; there wil only be software
> events due to them being in a group with hardware events.
>
> If this is a software group, then we'll never fail to schedule and we'll
> not get in this branch to begin with.
>
> Or am I now confused for having been staring at two different code-bases
> at the same time?

I believe you're right and I'd overlooked this. I think there is a
more efficient version of this code possible that I can follow up
with. There are 3 perf_event_contexts, potentially a sw and hw context
within the task_struct and one per-CPU in perf_cpu_context. With this
change I'm focussed on improving rotation of cgroup events that appear
system wide within the per-CPU context. Without cgroup events the
system wide events don't need to be iterated over during scheduling
in. The branch that can set rotate_necessary will only be necessary
for the task hardware events. For system wide events, considered with
cgroup mode scheduling in, the branch is necessary as rotation may be
necessary. It'd be possible to have variants of flexible_sched_in that
behave differently in the task software event context, and the system
wide and task hardware contexts.

I have a series of patches related to Kan Liang's cgroup
perf_event_groups improvements. I'll mail these out and see if I can
avoid the branch in the task software event context case.

Thanks,
Ian
