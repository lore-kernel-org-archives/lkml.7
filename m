Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4A7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9037C2183F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FMq59NM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfCSXz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:55:29 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40368 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCSXz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:55:28 -0400
Received: by mail-ua1-f68.google.com with SMTP id b8so205855uaq.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 16:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Uo8/7TYT9iFgR0+P4tx7d6/0m83KYczJ7RAbix01Nw=;
        b=FMq59NM9fQiCuzKEQKDzjmmn4lQeU77bUKVQ0kuLK5luT81fq+ZH6ap1kLv7cptnEP
         cix72py5P9Mt1Cpeu2RgBGC/KUjjBirsk0rKhLxoqS1j8UZu5fGqo89dZMraKZ15MD3r
         DbCn8huwXPdIxqz1AuXn1EMsckuumPkfd0G1EuJxk+Mf59jq/7aIBG7l22WjbvzYA9I8
         1vk7cq8UZ/Q4Ek00YjCSMLgkaQq4Sd+Ph0koxEi5IMPC56ZmoMvbaNrSL3mAbuEsNCY1
         OKTY1FbhkT/PO11ethT/Fg9BeeJREpIn7bbDw4I8U30bVQYhzTne1lTDo4F1YHwDmN0o
         /DpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Uo8/7TYT9iFgR0+P4tx7d6/0m83KYczJ7RAbix01Nw=;
        b=P2/X/ZZZoKxGu4JmoRO0Kp7P9KR1zNEvZHOiWVLDSxpiepo0O13D5gsWeripFbyLYZ
         wqb7XRxgmItgpXdbbYfoSs3DzZbYheEf2sNvh8ZhsbOv7xKL4n6DI8aJkxBqm24Kzx4v
         P+LCJ7NSHpdGDQVczZqZCG14ePHEAXmjCkqRehSCr2yqto8fLi0QffTMKE7QiwnsNOKw
         F2rLTjc6C1YRCHNCcarQQMsMGeXW5w6G/4sx0H/i3YA1pcsaX6shvJBcUXzo/24pPA8s
         CiFzUYMHQ0AL0SohwakFo9FNE5X83hJ1rQHh27xph6E7qU7/j06I28Zpoel+i83elr2z
         lUVA==
X-Gm-Message-State: APjAAAXp5B66y0+CXTYTigXtqEgiIsI5tahoOtV8towucPTigNGAhGtK
        svxfKonjX+gvHncktf36Ellp/n2D2qInREGICNJafw==
X-Google-Smtp-Source: APXvYqxUx37mcsQyBMnf5Y4fBVK9Q/anTndBUFS0dOX0TSR6mFyjLoAsiBVTLNpN4AKUW57SWZMQUMqnnCqhvg0fX4Y=
X-Received: by 2002:ab0:6787:: with SMTP id v7mr2916443uar.38.1553039727431;
 Tue, 19 Mar 2019 16:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190314130113.919278615@infradead.org> <20190314130706.061994422@infradead.org>
In-Reply-To: <20190314130706.061994422@infradead.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 19 Mar 2019 16:55:16 -0700
Message-ID: <CABPqkBSH5UBaV7+0JKgr4YmEke8Tu4Hry9GAFYT5C_gsncqf3A@mail.gmail.com>
Subject: Re: [RFC][PATCH 7/8] perf/x86: Optimize x86_schedule_events()
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
> Now that cpuc->event_constraint[] is retained, we can avoid calling
> get_event_constraints() over and over again.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/events/core.c       |   25 +++++++++++++++++++++----
>  arch/x86/events/intel/core.c |    3 ++-
>  2 files changed, 23 insertions(+), 5 deletions(-)
>
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -844,6 +844,12 @@ int perf_assign_events(struct event_cons
>  }
>  EXPORT_SYMBOL_GPL(perf_assign_events);
>
> +static inline bool is_ht_workaround_active(struct cpu_hw_events *cpuc)
> +{
> +       return is_ht_workaround_enabled() && !cpuc->is_fake &&
> +              READ_ONCE(cpuc->excl_cntrs->exclusive_present);
> +}
> +
>  int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
>  {
>         struct event_constraint *c;
> @@ -858,8 +864,20 @@ int x86_schedule_events(struct cpu_hw_ev
>                 x86_pmu.start_scheduling(cpuc);
>
>         for (i = 0, wmin = X86_PMC_IDX_MAX, wmax = 0; i < n; i++) {
> -               c = x86_pmu.get_event_constraints(cpuc, i, cpuc->event_list[i]);
> -               cpuc->event_constraint[i] = c;
> +               c = cpuc->event_constraint[i];
> +
> +               /*
> +                * Request constraints for new events; or for those events that
> +                * have a dynamic constraint due to the HT workaround -- for
> +                * those the constraint can change due to scheduling activity
> +                * on the other sibling.
> +                */
> +               if (!c || ((c->flags & PERF_X86_EVENT_DYNAMIC) &&
> +                          is_ht_workaround_active(cpuc))) {
> +
> +                       c = x86_pmu.get_event_constraints(cpuc, i, cpuc->event_list[i]);
> +                       cpuc->event_constraint[i] = c;
> +               }
On this one, I think there may be a problem with events with
shared_regs constraints.
Constraint is dynamic as it depends on other events which share the
same MSR, yet it
is not marked as DYNAMIC. But this may be okay because these other
events are all
on the same CPU and thus scheduled during the same ctx_sched_in(). Yet with the
swapping in intel_alt_er(), we need to double-check that we cannot
reuse a constraint
which could be stale. I believe this is okay, just double-check.

>
>                 wmin = min(wmin, c->weight);
>                 wmax = max(wmax, c->weight);
> @@ -903,8 +921,7 @@ int x86_schedule_events(struct cpu_hw_ev
>                  * N/2 counters can be used. This helps with events with
>                  * specific counter constraints.
>                  */
> -               if (is_ht_workaround_enabled() && !cpuc->is_fake &&
> -                   READ_ONCE(cpuc->excl_cntrs->exclusive_present))
> +               if (is_ht_workaround_active(cpuc))
>                         gpmax /= 2;
>
>                 unsched = perf_assign_events(cpuc->event_constraint, n, wmin,
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2945,7 +2945,8 @@ intel_get_event_constraints(struct cpu_h
>          * - dynamic constraint: handled by intel_get_excl_constraints()
>          */
>         c2 = __intel_get_event_constraints(cpuc, idx, event);
> -       if (c1 && (c1->flags & PERF_X86_EVENT_DYNAMIC)) {
> +       if (c1) {
> +               WARN_ON_ONCE(!(c1->flags & PERF_X86_EVENT_DYNAMIC));
>                 bitmap_copy(c1->idxmsk, c2->idxmsk, X86_PMC_IDX_MAX);
>                 c1->weight = c2->weight;
>                 c2 = c1;
>
>
