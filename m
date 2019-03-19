Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F312C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF772175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RabtLW+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfCSUsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:48:32 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36721 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfCSUsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:48:31 -0400
Received: by mail-vs1-f65.google.com with SMTP id n4so151427vsm.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 13:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=68O72KdfpoCazvPkabkboM/V7sONRJd4JjRTMoBAp80=;
        b=RabtLW+p0FSEoSzOiSlgYoElypms3lbI1Kqh6pjY+tqRMAG3Azrc+HuuUPdwgIiNFb
         x3SQUKhVvPb2mDmda2zjqcL3v1Hwui6MW34JKUZxSy9y3wA8W187KBTN72i3o7vaIIr5
         Wm6v4DdsckSHnAZkkOffHlJv/WvELcmnDTIMiC9fuSYcengsIsltvrNpJMgeSbO6n/fq
         6T7KpJ3QRNJs+oP08ZGrBY5B8QKdO1rBRY4faBucftKsVFphZpac/LTwTu32NAg8/D45
         ii16ebtHTmdFLEP/xzX5naw9upNvgu85UoM2ru6EIBa5GBQQuZlWHD/cCpYH7nyzSkM2
         wxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=68O72KdfpoCazvPkabkboM/V7sONRJd4JjRTMoBAp80=;
        b=rVQ9utdW0wKOKnGKNkII5brXFWiHaFfv73xGJb07n5zvvmJEfAtl6VYbOF/nMPxQ1k
         Q4AuJcjuUS45sweU05gdM0Qta7aPbA6ps+9OViBAAbE7OkK26UZRCFtMfWmMlVCzYRD9
         e/EjQ498crr1LKxVc1UUU3YareMtRQwa6+irc5rCJEarNv0tPvRbxiUyEXTgV2gocSZ4
         d6TThQ2ODKjzKwmY1+BPtwgZvmc6iWQ7BH2mslB11UjdgevUh0Nt6HRxxuPrFnGd0RSd
         ppX77etiLO6stFwPO0phbktevQDcCs77M06I+27jZrm68UjpiwnCOYkSv5j7QK69Fbg2
         BbAA==
X-Gm-Message-State: APjAAAUI3NwgdUkNRAXRKt637tKTWSQivblf6tjX/sRiPzc5uRZYQVgN
        Y7BsEnktS3/QGmRX3qdB339t/tjMQk2Sozq7JNcGtQ==
X-Google-Smtp-Source: APXvYqwNtFw4wL+eBm1PxjmuVVd0GjiUI9ZQc30NpbCQPx8CCuckWmrXmlv9vsVssJujvHYVZpOo8Th1VJY5Y9D4l8w=
X-Received: by 2002:a67:ff07:: with SMTP id v7mr2690599vsp.231.1553028510184;
 Tue, 19 Mar 2019 13:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190314130113.919278615@infradead.org> <20190314130705.750219024@infradead.org>
In-Reply-To: <20190314130705.750219024@infradead.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 19 Mar 2019 13:48:18 -0700
Message-ID: <CABPqkBQr4VbNQG9R9j8Di=6fSziUw1s_QLyE9L7nsMTdWd8GtQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/8] perf/x86: Remove PERF_X86_EVENT_COMMITTED
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 6:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> The flag PERF_X86_EVENT_COMMITTED is used to find uncommitted events
> for which to call put_event_constraint() when scheduling fails.
>
> These are the newly added events to the list, and must form, per
> definition, the tail of cpuc->event_list[]. By computing the list
> index of the last successfull schedule, then iteration can start there
> and the flag is redundant.
>
> There are only 3 callers of x86_schedule_events(), notably:
>
>  - x86_pmu_add()
>  - x86_pmu_commit_txn()
>  - validate_group()
>
> For x86_pmu_add(), cpuc->n_events isn't updated until after
> schedule_events() succeeds, therefore cpuc->n_events points to the
> desired index.
>
Correct.

> For x86_pmu_commit_txn(), cpuc->n_events is updated, but we can
> trivially compute the desired value with cpuc->n_txn -- the number of
> events added in this transaction.
>
I suggest you put this explanation in the code so that it is easier to
understand.

> For validate_group(), we can make the rule for x86_pmu_add() work by
> simply setting cpuc->n_events to 0 before calling schedule_events().
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Stephane Eranian <eranian@google.com>

> ---
>  arch/x86/events/core.c       |   21 ++++++---------------
>  arch/x86/events/perf_event.h |    1 -
>  2 files changed, 6 insertions(+), 16 deletions(-)
>
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -925,19 +925,16 @@ int x86_schedule_events(struct cpu_hw_ev
>         if (!unsched && assign) {
>                 for (i = 0; i < n; i++) {
>                         e = cpuc->event_list[i];
> -                       e->hw.flags |= PERF_X86_EVENT_COMMITTED;
>                         if (x86_pmu.commit_scheduling)
>                                 x86_pmu.commit_scheduling(cpuc, i, assign[i]);
>                 }
>         } else {
> -               for (i = 0; i < n; i++) {
> +               i = cpuc->n_events;
> +               if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
> +                       i -= cpuc->n_txn;
> +
> +               for (; i < n; i++) {
>                         e = cpuc->event_list[i];
> -                       /*
> -                        * do not put_constraint() on comitted events,
> -                        * because they are good to go
> -                        */
> -                       if ((e->hw.flags & PERF_X86_EVENT_COMMITTED))
> -                               continue;
>
>                         /*
>                          * release events that failed scheduling
> @@ -1372,11 +1369,6 @@ static void x86_pmu_del(struct perf_even
>         int i;
>
>         /*
> -        * event is descheduled
> -        */
> -       event->hw.flags &= ~PERF_X86_EVENT_COMMITTED;
> -
> -       /*
>          * If we're called during a txn, we only need to undo x86_pmu.add.
>          * The events never got scheduled and ->cancel_txn will truncate
>          * the event_list.
> @@ -2079,8 +2071,7 @@ static int validate_group(struct perf_ev
>         if (n < 0)
>                 goto out;
>
> -       fake_cpuc->n_events = n;
> -
> +       fake_cpuc->n_events = 0;
>         ret = x86_pmu.schedule_events(fake_cpuc, n, NULL);
>
>  out:
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -61,7 +61,6 @@ struct event_constraint {
>  #define PERF_X86_EVENT_PEBS_LDLAT      0x0001 /* ld+ldlat data address sampling */
>  #define PERF_X86_EVENT_PEBS_ST         0x0002 /* st data address sampling */
>  #define PERF_X86_EVENT_PEBS_ST_HSW     0x0004 /* haswell style datala, store */
> -#define PERF_X86_EVENT_COMMITTED       0x0008 /* event passed commit_txn */

I would put a placeholder saying that bit 3 is available or renumbered
the other masks below

>  #define PERF_X86_EVENT_PEBS_LD_HSW     0x0010 /* haswell style datala, load */
>  #define PERF_X86_EVENT_PEBS_NA_HSW     0x0020 /* haswell style datala, unknown */
>  #define PERF_X86_EVENT_EXCL            0x0040 /* HT exclusivity on counter */
>
>
