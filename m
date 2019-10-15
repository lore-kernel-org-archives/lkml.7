Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628F3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2268F21848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rhGTsL53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfJONGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:06:43 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41824 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbfJONGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:06:43 -0400
Received: by mail-vs1-f65.google.com with SMTP id l2so13054225vsr.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 06:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rNOlv3NjVeyQoBdu+mBLCof6nCnJjTRih3rxG6wI0Rc=;
        b=rhGTsL53yetLxs9HbEFP3SVNGZ9WhPPu9ZCP6S56L3oRjry+hL6HOwj6DDwx+fF3IF
         bwbs7XGCZiyKjvfTtmZIDnYEGTRDiqZwrae6vRyCqpqHfIX8LEtDBDVQcebexP6hs4dq
         fm0TSVFFlHaFuH4zthVu6co0xNQvYWDyFVHxNrpD03GqZRj5XOV3qBkZJ6iZ0kFdUpzB
         p2XnlitTTNrN0x/qDI1oWYKBqckkREo271eo58exPHfJ00z3+cLdADTe0zHD2/uvc7co
         WhaFhkn+ZqSjn9l9+BZJ6iPmf6wHCHXSXG+dp3ibdZtK7LjxlYCAnBmWSDVQItj+vZXP
         yKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNOlv3NjVeyQoBdu+mBLCof6nCnJjTRih3rxG6wI0Rc=;
        b=M8I4YBnqaz2slI6f98fxnSzZBAQDAyN92RMxuqFKF0BRAOOnu3qZZ2GbbBEQcTNp4T
         bDIYUSiXn+/o7v1lT4iV4ytDwvbG8AedjhtOVLWfHppoJNkyG3uanqZwmSe+egY+9rSE
         dYKfBc9SzyZ8U2gRS8/5GJrGXAtXelVqgVJ6AnxB/HpMeb11V4PQjpdZkIEc830e3oTR
         YMh7lCXSLEuWc/N2Cc/A13QR1hHUS8NrUb1JFM9OY8Ly1ny4KVrp4r+KAw7tWcPejN3f
         oKgrmyvQIghHk81aiOHvqr57x6DsldL5Lr9ooVdvc/y1M0/bz0a0RSgpVZ0HZXISamsz
         V0Ug==
X-Gm-Message-State: APjAAAUtrZkimyVFEMGHMK4DpBscvGcAbgm79T1nQobVXwJqaZFy4zdS
        7Ka2SGk2imGDsBb9J77zPFO/93uhZizfUw61L9J/3w==
X-Google-Smtp-Source: APXvYqypVfUGTpAza4VLnzEyKjqobPPXW581gBdi2BYaMn0ijCdmNFl+uKP1xChRfG9KdmJKJ2jsBna1yMSk93SxYOY=
X-Received: by 2002:a67:ef89:: with SMTP id r9mr20648010vsp.200.1571144801705;
 Tue, 15 Oct 2019 06:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191004083205.29302-1-daniel.lezcano@linaro.org>
In-Reply-To: <20191004083205.29302-1-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Oct 2019 15:06:04 +0200
Message-ID: <CAPDyKFo4WE4trWhxcxDcp1S+uPb6OJBY=-+fYht9k_4DpuQrNQ@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] cpuidle: play_idle: Make play_idle more flexible
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "open list:CPU IDLE TIME MANAGEMENT FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2019 at 10:32, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The play_idle function has two users, the intel powerclamp and the
> idle_injection.
>
> The idle injection cooling device uses the function via the
> idle_injection powercap's APIs. Unfortunately, play_idle is currently
> limited by the idle state depth: by default the deepest idle state is
> selected. On the ARM[64] platforms, most of the time it is the cluster
> idle state, the exit latency and the residency can be very high. That
> reduces the scope of the idle injection usage because the impact on
> the performances can be very significant.
>
> If the idle injection cycles can be done with a shallow state like a
> retention state, the cooling effect would eventually give similar
> results than the cpufreq cooling device.
>
> In order to prepare the function to receive an idle state parameter,
> let's replace the 'use_deepest_state' boolean field with 'use_state'
> and use this value to enter the specific idle state.
>
> The current code keeps the default behavior which is go to the deepest
> idle state.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/cpuidle/cpuidle.c | 21 +++++++++++----------
>  include/linux/cpuidle.h   | 13 ++++++-------
>  kernel/sched/idle.c       | 10 +++++-----
>  3 files changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 0895b988fa92..f8b54f277589 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -99,31 +99,31 @@ static int find_deepest_state(struct cpuidle_driver *drv,
>  }
>
>  /**
> - * cpuidle_use_deepest_state - Set/clear governor override flag.
> - * @enable: New value of the flag.
> + * cpuidle_use_state - Force the cpuidle framework to enter an idle state.
> + * @state: An integer for an idle state
>   *
> - * Set/unset the current CPU to use the deepest idle state (override governors
> - * going forward if set).
> + * Specify an idle state the cpuidle framework must step in and bypass
> + * the idle state selection process.
>   */
> -void cpuidle_use_deepest_state(bool enable)
> +void cpuidle_use_state(int state)
>  {
>         struct cpuidle_device *dev;
>
>         preempt_disable();
>         dev = cpuidle_get_device();
>         if (dev)
> -               dev->use_deepest_state = enable;
> +               dev->use_state = state;
>         preempt_enable();
>  }
>
>  /**
>   * cpuidle_find_deepest_state - Find the deepest available idle state.
> - * @drv: cpuidle driver for the given CPU.
> - * @dev: cpuidle device for the given CPU.
>   */
> -int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> -                              struct cpuidle_device *dev)
> +int cpuidle_find_deepest_state(void)
>  {
> +       struct cpuidle_device *dev = cpuidle_get_device();
> +       struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
> +
>         return find_deepest_state(drv, dev, UINT_MAX, 0, false);
>  }
>
> @@ -554,6 +554,7 @@ static void __cpuidle_unregister_device(struct cpuidle_device *dev)
>  static void __cpuidle_device_init(struct cpuidle_device *dev)
>  {
>         memset(dev->states_usage, 0, sizeof(dev->states_usage));
> +       dev->use_state = CPUIDLE_STATE_NOUSE;
>         dev->last_residency = 0;
>         dev->next_hrtimer = 0;
>  }
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 2dc4c6b19c25..ba0751b26e37 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -15,6 +15,7 @@
>  #include <linux/list.h>
>  #include <linux/hrtimer.h>
>
> +#define CPUIDLE_STATE_NOUSE    -1
>  #define CPUIDLE_STATE_MAX      10
>  #define CPUIDLE_NAME_LEN       16
>  #define CPUIDLE_DESC_LEN       32
> @@ -80,11 +81,11 @@ struct cpuidle_driver_kobj;
>  struct cpuidle_device {
>         unsigned int            registered:1;
>         unsigned int            enabled:1;
> -       unsigned int            use_deepest_state:1;
>         unsigned int            poll_time_limit:1;
>         unsigned int            cpu;
>         ktime_t                 next_hrtimer;
>
> +       int                     use_state;
>         int                     last_state_idx;
>         int                     last_residency;
>         u64                     poll_limit_ns;
> @@ -203,19 +204,17 @@ static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL; }
>  #endif
>
>  #ifdef CONFIG_CPU_IDLE
> -extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> -                                     struct cpuidle_device *dev);
> +extern int cpuidle_find_deepest_state(void);
>  extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
>                                 struct cpuidle_device *dev);
> -extern void cpuidle_use_deepest_state(bool enable);
> +extern void cpuidle_use_state(int state);
>  #else
> -static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
> -                                            struct cpuidle_device *dev)
> +static inline int cpuidle_find_deepest_state(void)
>  {return -ENODEV; }
>  static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
>                                        struct cpuidle_device *dev)
>  {return -ENODEV; }
> -static inline void cpuidle_use_deepest_state(bool enable)
> +static inline void cpuidle_use_state(int state)
>  {
>  }
>  #endif
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index b98283fc6914..17da9cb309e1 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -165,7 +165,8 @@ static void cpuidle_idle_call(void)
>          * until a proper wakeup interrupt happens.
>          */
>
> -       if (idle_should_enter_s2idle() || dev->use_deepest_state) {
> +       if (idle_should_enter_s2idle() ||
> +           dev->use_state != CPUIDLE_STATE_NOUSE) {
>                 if (idle_should_enter_s2idle()) {
>                         rcu_idle_enter();
>
> @@ -181,8 +182,7 @@ static void cpuidle_idle_call(void)
>                 tick_nohz_idle_stop_tick();
>                 rcu_idle_enter();
>
> -               next_state = cpuidle_find_deepest_state(drv, dev);
> -               call_cpuidle(drv, dev, next_state);
> +               call_cpuidle(drv, dev, dev->use_state);

This doesn't look correct to me.

More precisely, in the s2idle case, we always pick the deepest state.
But from the change above, we would invoke call_cpuidle() with
CPUIDLE_STATE_NOUSE, right!?

>         } else {
>                 bool stop_tick = true;
>
> @@ -328,7 +328,7 @@ void play_idle(unsigned long duration_us)
>         rcu_sleep_check();
>         preempt_disable();
>         current->flags |= PF_IDLE;
> -       cpuidle_use_deepest_state(true);
> +       cpuidle_use_state(cpuidle_find_deepest_state());
>
>         it.done = 0;
>         hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> @@ -339,7 +339,7 @@ void play_idle(unsigned long duration_us)
>         while (!READ_ONCE(it.done))
>                 do_idle();
>
> -       cpuidle_use_deepest_state(false);
> +       cpuidle_use_state(CPUIDLE_STATE_NOUSE);
>         current->flags &= ~PF_IDLE;
>
>         preempt_fold_need_resched();
> --
> 2.17.1
>

Kind regards
Uffe
