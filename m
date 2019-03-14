Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F26C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7006C217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TmsWX/eN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfCNPaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:30:02 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51197 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbfCNPaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:30:02 -0400
Received: by mail-it1-f195.google.com with SMTP id m137so5359197ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 08:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1gzwrXH/29MVXlo3dBM3RLcsMx5XahkKtGIjc4wjdo=;
        b=TmsWX/eNiz4+87UGE+AtdUSGAi153qnYUmQdV2BfjZBeW8VFz742UqlQXfVibchRgr
         DlaDGgvG/dPmF6aUqTJ4T81AiqdF4fKF3S78Jg3tlkfjP4uP42IvL7XyKnWKLc830rlw
         P7Zein1MRtojChESRkFw67vqrbc8gejBzpMl3InLF/BqM91oyv3Uw72oeEohAatwvE6i
         mq1bnni+ovEdC+uqF32iPHNPVbvQLVptp056MwlyRy4fZX3jnWHgHztTUb3cEEh3xTe3
         RA+CWaD3F15szskVNqdpIqVfwtOnkbfJUNXzHY0XVDMBefNQyZKWnWlIov/8uPpDHnD5
         NdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1gzwrXH/29MVXlo3dBM3RLcsMx5XahkKtGIjc4wjdo=;
        b=iKwX8tAiWgi2hYh3uv2XR+wfdNKCmK39NUr15x8tbAZSdpglzBHutHpkaEI1ZYAzdY
         TIviAaitZks+pnQLmby0Qn/zSUKQnZUhItb8Ya7hJ6DIMbjNKVjgJZmPWl39Vq3s3/Eg
         5KOVTomVw1hews5ZYZnotl++uwwYhu0GM76ImxGbsptEYgEOaz+ltueC6auBEa2qxJf7
         sU+4ty58ZeOWQT2A+vwAaA8uui1os5OcwpyTiUOCBukdVUeHz/07spoTWGWXYRZgZZPj
         anOkREHTtQ+zIq45DWk5+uZxIfnjPSIImB04Ja87I/yxlauI+K+EVLmhLv9nbwPMC5kT
         ge5w==
X-Gm-Message-State: APjAAAVuRK2ZXFyi0CE2T6sqGlmrEvVgiS7jKqdAKm7dUjNyK4mZGM75
        /FiRS27hHccu75lE/swhtE68Fx7/IAv6CM858HCVxw==
X-Google-Smtp-Source: APXvYqziY5kDHan/+KOpFeNe1TR4rYDPq2qN7GBpLFH0hsKbpSVGfvf+UVkAL+DpH3u+6H66zQ7KfJEESHohuApuNDg=
X-Received: by 2002:a24:a81:: with SMTP id 123mr2411999itw.43.1552577400467;
 Thu, 14 Mar 2019 08:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com> <CAJuCfpGAZ6XxJj=e-wVzGx3zmRRLPs=wXm8K0BcjWOm5hM0FcQ@mail.gmail.com>
 <20190314144600.2ulpeipad7jbxyiy@e110439-lin>
In-Reply-To: <20190314144600.2ulpeipad7jbxyiy@e110439-lin>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 14 Mar 2019 08:29:48 -0700
Message-ID: <CAJuCfpFDVi7O+yqQ+F0DT3pRZN=BtRD8NyUH5Tys0VVkd9JAGg@mail.gmail.com>
Subject: Re: [PATCH v7 01/15] sched/core: uclamp: Add CPU's clamp buckets refcounting
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Thu, Mar 14, 2019 at 7:46 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>
> On 13-Mar 14:32, Suren Baghdasaryan wrote:
> > On Fri, Feb 8, 2019 at 2:06 AM Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> > >
> > > Utilization clamping allows to clamp the CPU's utilization within a
> > > [util_min, util_max] range, depending on the set of RUNNABLE tasks on
> > > that CPU. Each task references two "clamp buckets" defining its minimum
> > > and maximum (util_{min,max}) utilization "clamp values". A CPU's clamp
> > > bucket is active if there is at least one RUNNABLE tasks enqueued on
> > > that CPU and refcounting that bucket.
> > >
> > > When a task is {en,de}queued {on,from} a rq, the set of active clamp
> > > buckets on that CPU can change. Since each clamp bucket enforces a
> > > different utilization clamp value, when the set of active clamp buckets
> > > changes, a new "aggregated" clamp value is computed for that CPU.
> > >
> > > Clamp values are always MAX aggregated for both util_min and util_max.
> > > This ensures that no tasks can affect the performance of other
> > > co-scheduled tasks which are more boosted (i.e. with higher util_min
> > > clamp) or less capped (i.e. with higher util_max clamp).
> > >
> > > Each task has a:
> > >    task_struct::uclamp[clamp_id]::bucket_id
> > > to track the "bucket index" of the CPU's clamp bucket it refcounts while
> > > enqueued, for each clamp index (clamp_id).
> > >
> > > Each CPU's rq has a:
> > >    rq::uclamp[clamp_id]::bucket[bucket_id].tasks
> > > to track how many tasks, currently RUNNABLE on that CPU, refcount each
> > > clamp bucket (bucket_id) of a clamp index (clamp_id).
> > >
> > > Each CPU's rq has also a:
> > >    rq::uclamp[clamp_id]::bucket[bucket_id].value
> > > to track the clamp value of each clamp bucket (bucket_id) of a clamp
> > > index (clamp_id).
> > >
> > > The rq::uclamp::bucket[clamp_id][] array is scanned every time we need
> > > to find a new MAX aggregated clamp value for a clamp_id. This operation
> > > is required only when we dequeue the last task of a clamp bucket
> > > tracking the current MAX aggregated clamp value. In these cases, the CPU
> > > is either entering IDLE or going to schedule a less boosted or more
> > > clamped task.
> > > The expected number of different clamp values, configured at build time,
> > > is small enough to fit the full unordered array into a single cache
> > > line.
> >
> > I assume you are talking about "struct uclamp_rq uclamp[UCLAMP_CNT]"
> > here.
>
> No, I'm talking about the rq::uclamp::bucket[clamp_id][], which is an
> array of:
>
>    struct uclamp_bucket {
>         unsigned long value : bits_per(SCHED_CAPACITY_SCALE);
>         unsigned long tasks : BITS_PER_LONG - bits_per(SCHED_CAPACITY_SCALE);
>    };
>
> defined as part of:
>
>    struct uclamp_rq {
>         unsigned int value;
>         struct uclamp_bucket bucket[UCLAMP_BUCKETS];
>    };
>
>
> So, it's an array of UCLAMP_BUCKETS (value, tasks) pairs.
>
> > uclamp_rq size depends on UCLAMP_BUCKETS configurable to be up
> > to 20. sizeof(long)*20 is already more than 64 bytes. What am I
> > missing?
>
> Right, the comment above refers to the default configuration, which is
> 5 buckets. With that configuration we have:
>
>
> $> pahole kernel/sched/core.o
>
> ---8<---
>    struct uclamp_bucket {
>            long unsigned int          value:11;             /*     0:53  8 */
>            long unsigned int          tasks:53;             /*     0: 0  8 */
>
>            /* size: 8, cachelines: 1, members: 2 */
>            /* last cacheline: 8 bytes */
>    };
>
>    struct uclamp_rq {
>            unsigned int               value;                /*     0     4 */
>
>            /* XXX 4 bytes hole, try to pack */
>
>            struct uclamp_bucket       bucket[5];            /*     8    40 */
>
>            /* size: 48, cachelines: 1, members: 2 */
>            /* sum members: 44, holes: 1, sum holes: 4 */
>            /* last cacheline: 48 bytes */
>    };
>
>    struct rq {
>            // ...
>            /* --- cacheline 2 boundary (128 bytes) --- */
>            struct uclamp_rq           uclamp[2];            /*   128    96 */
>            /* --- cacheline 3 boundary (192 bytes) was 32 bytes ago --- */
>            // ...
>    };
> ---8<---
>
> Where you see the array fits into a single cache line.
>
> Actually I notice now that, since when we removed the bucket dedicated
> to the default values, we now have some spare space and we can
> probably increase the default (and minimum) value of UCLAMP_BUCKETS to
> be 7.
>
> This will uses two full cache lines in struct rq, one for each clamp
> index...  Although 7 it's a bit of a odd number and gives by default
> buckets of ~14% size instead of the ~20%.
>
> Thoughts ?

Got it. From reading the documentation at the beginning my impression
was that whatever value I choose within allowed 5-20 range it would
still fit in a cache line. To disambiguate it might be worse
mentioning that this is true for the default value or for values up to
7. Thanks!

> [...]
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
