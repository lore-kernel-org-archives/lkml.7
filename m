Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EC4C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 00:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B857420693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 00:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS5cq528"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfGHAob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 20:44:31 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38315 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfGHAob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 20:44:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id d17so14466731oth.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 17:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CsomF3aEkbaPuVGfhBvf4Nm3oaWnH5+QD4/iZjHcgwA=;
        b=eS5cq5280vcnwuobSOUFvjmRcKOWP1kgjrPmfypy6STfdFWlr66YhOCwYs9ytLuvC2
         1twr591jR5c5sqZASg6TW2rnAKIjZjAQkflnzHVoEASMGFmdiZy3Q0yrNyxBuJpnqLro
         YPh1svz0A+U1rFnY99SKAxc3Zex9QQiefOjr7jvKd39Z5NtLgfjQcSuRJjA3KTU1t48r
         R5+DfrzEOYj7U97QDUjutTr8YmB/qIu6L6NYRpdgfIeQxJWD46s6KowWs6D+fOh60lIk
         UQPBY9fnB2bnrwvY22woW/RwSFhsYxQ6tBriwIjTqd3dR9xQ/s/8/jky2xJIblMt8MC3
         DqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CsomF3aEkbaPuVGfhBvf4Nm3oaWnH5+QD4/iZjHcgwA=;
        b=tSpUWAO/4o2ayP/BgcPDxK0lsABJXauSNJQI9btw0PmhyP5vT7Mx0lVxCnLAwGWguQ
         7dqTe7GqS4M4n3IqCEqPrKpoRbaFnK6sjo2wwEsFgQVoEwDxSWCNuj4qc3JOpVpmZyyQ
         RSaQWLI83DVk5ic4WQmR7daK58hcS1HsjPsuvyPR1Nj5pM2LjjTmFVYIuxBBRgN03ef7
         2UbLUCwFTLjr1jutmouB56Uj9yzK3F/p7hKp9+3TANo+7pZl87bhQYfNTQ2CYzxCYI/Y
         dNcpMl/FU3Tv4KSdw3spNbo7EwXYLXmd6Lk2UHcOxeUXQHbDCEXUUxfYVr9jw5wBcRl+
         MPdw==
X-Gm-Message-State: APjAAAXjit30Q0iYVnAHIiAP0fswxbUF1P15gMZIbBiCRugdFo5MxT71
        hz/Z13lNvKsAJJn3Rgf8wFu/pZqVYNvFxALJFVsq3F1GWEE=
X-Google-Smtp-Source: APXvYqwBW3GMnNwfi4Q4e0SyCgOVh+/Nwg1G1S5Q/UvjCOJrIHoCz5LFLbMJ5XdtAqu2MWpce5AUCwJ8KVjY7a0uapU=
X-Received: by 2002:a9d:6312:: with SMTP id q18mr11215164otk.45.1562546669932;
 Sun, 07 Jul 2019 17:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <1561983877-4727-1-git-send-email-wanpengli@tencent.com>
In-Reply-To: <1561983877-4727-1-git-send-email-wanpengli@tencent.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Mon, 8 Jul 2019 08:44:20 +0800
Message-ID: <CANRm+Czp4cayC0Jk5CcpBJV3zc7ZTqqnTDEvmRu2LqhsNriwEQ@mail.gmail.com>
Subject: Re: [PATCH] sched/core: Cache timer busy housekeeping target
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping Frederic, Peterz, any comments?
On Mon, 1 Jul 2019 at 20:24, Wanpeng Li <kernellwp@gmail.com> wrote:
>
> From: Wanpeng Li <wanpengli@tencent.com>
>
> Cache the busy housekeeping target for timer instead of researching each time.
> This patch reduces the total time of get_nohz_timer_target() for busy housekeeping
> CPU from 2u~3us to less than 1us which can be observed by ftrace.
>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  include/linux/hrtimer.h    | 1 +
>  include/linux/sched/nohz.h | 2 +-
>  kernel/sched/core.c        | 6 +++++-
>  kernel/time/hrtimer.c      | 6 ++++--
>  kernel/time/timer.c        | 7 +++++--
>  5 files changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
> index 2e8957e..0d8b271 100644
> --- a/include/linux/hrtimer.h
> +++ b/include/linux/hrtimer.h
> @@ -198,6 +198,7 @@ enum  hrtimer_base_type {
>  struct hrtimer_cpu_base {
>         raw_spinlock_t                  lock;
>         unsigned int                    cpu;
> +       unsigned int                    last_target_cpu;
>         unsigned int                    active_bases;
>         unsigned int                    clock_was_set_seq;
>         unsigned int                    hres_active             : 1,
> diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
> index 1abe91f..0afb094 100644
> --- a/include/linux/sched/nohz.h
> +++ b/include/linux/sched/nohz.h
> @@ -8,7 +8,7 @@
>
>  #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
>  extern void nohz_balance_enter_idle(int cpu);
> -extern int get_nohz_timer_target(void);
> +extern int get_nohz_timer_target(unsigned int cpu);
>  #else
>  static inline void nohz_balance_enter_idle(int cpu) { }
>  #endif
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7968e0f..f4ba63e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -549,11 +549,15 @@ void resched_cpu(int cpu)
>   * selecting an idle CPU will add more delays to the timers than intended
>   * (as that CPU's timer base may not be uptodate wrt jiffies etc).
>   */
> -int get_nohz_timer_target(void)
> +int get_nohz_timer_target(unsigned int last_target_cpu)
>  {
>         int i, cpu = smp_processor_id(), default_cpu = -1;
>         struct sched_domain *sd;
>
> +       if (!idle_cpu(last_target_cpu) &&
> +               housekeeping_cpu(last_target_cpu, HK_FLAG_TIMER))
> +               return last_target_cpu;
> +
>         if (housekeeping_cpu(cpu, HK_FLAG_TIMER)) {
>                 if (!idle_cpu(cpu))
>                         return cpu;
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 41dfff2..0d49bef 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -195,8 +195,10 @@ struct hrtimer_cpu_base *get_target_base(struct hrtimer_cpu_base *base,
>                                          int pinned)
>  {
>  #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
> -       if (static_branch_likely(&timers_migration_enabled) && !pinned)
> -               return &per_cpu(hrtimer_bases, get_nohz_timer_target());
> +       if (static_branch_likely(&timers_migration_enabled) && !pinned) {
> +               base->last_target_cpu = get_nohz_timer_target(base->last_target_cpu);
> +               return &per_cpu(hrtimer_bases, base->last_target_cpu);
> +       }
>  #endif
>         return base;
>  }
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 343c7ba..6ae045a 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -199,6 +199,7 @@ struct timer_base {
>         unsigned long           clk;
>         unsigned long           next_expiry;
>         unsigned int            cpu;
> +       unsigned int            last_target_cpu;
>         bool                    is_idle;
>         bool                    must_forward_clk;
>         DECLARE_BITMAP(pending_map, WHEEL_SIZE);
> @@ -865,8 +866,10 @@ get_target_base(struct timer_base *base, unsigned tflags)
>  {
>  #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
>         if (static_branch_likely(&timers_migration_enabled) &&
> -           !(tflags & TIMER_PINNED))
> -               return get_timer_cpu_base(tflags, get_nohz_timer_target());
> +           !(tflags & TIMER_PINNED)) {
> +               base->last_target_cpu = get_nohz_timer_target(base->last_target_cpu);
> +               return get_timer_cpu_base(tflags, base->last_target_cpu);
> +       }
>  #endif
>         return get_timer_this_cpu_base(tflags);
>  }
> --
> 2.7.4
>
