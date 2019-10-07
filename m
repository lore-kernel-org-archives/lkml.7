Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CA1C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E5421655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lwi/2gqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfJGLBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:01:47 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36695 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbfJGLBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:01:47 -0400
Received: by mail-ua1-f66.google.com with SMTP id r25so3890907uam.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 04:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R1oRUF11y/o3U7QcRwmH0Mc53BqFVEs/wzN6U4XQMDc=;
        b=Lwi/2gqa3jd5b1HtZIBvmhHdvcWT6VGdhZwF68nCh5NnkpMNliXn7dq8J9vdmJRsz6
         IPFstVWoiKT5sjM/zWX1F3YtuQ0sDx0zBful+eUKmAu4YTBzTNhxgXF1cwMMbp93qfE8
         PIafpzeYagBQwPYHTEg9E0MY5hGJpcAN+R/4HvrDvJ0RIyWFUE2kiI6P1yXNcOdX54e5
         /7LjJH7i6RVoMeYzolHJPuz7f1F6gnM1fL+2NDVEdO3bcmDGCsMaPHgdiUgsotMrWet1
         H+EeSQPXPu/j7bQIMfZU0jLbymFynrSZj80IU3JZNg2anjNNTndf1mg5P9loAT6rkRBz
         8yKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R1oRUF11y/o3U7QcRwmH0Mc53BqFVEs/wzN6U4XQMDc=;
        b=t7a9nCOJV6IujmqiNAoIu1vDYijfkCYuKIZc3oOp7zpKjj+8i1Jbp+6cM6LOsE80Gm
         YO0LqWIrCtFJwDxhZtR8vTm12etikVpvLDOUADblwNtE6PDSusSaOaPYCNYvReNz+OHH
         eGuNhlHKUe3nwR/XiCn333m6tOj9ZJuOj21OCIAziACB6MSM1RxsZdDmIrl7ybEdMB0R
         /d5nUMpZvdM/t9z5EejucNSjbBdGNOhkihTaMtCp0Pe2+te4xM2vDn1h8hGBMKjFV6sL
         6eWTzNi+XneI6nDFMisRlGIl7MIeUEtLU/YEy+Qnownmhfd5qJ5EyNiVyzRYq+bQsGgi
         XO3w==
X-Gm-Message-State: APjAAAWANGF455oND/r8CtlGFZbiM0Z4tx89dfIioiDiBjzEMXPoNlal
        +5yyhN/J34lkApaFcP2fCRWvKYi3R2aaB6kKRDnYDg==
X-Google-Smtp-Source: APXvYqyh9JDoPo46obh7lXypE/sze9sf9prXN17DP22IeLOsl/+a51x0LXMGLydFHvk99N51YuK0Ufq1C/mV64f2PXg=
X-Received: by 2002:ab0:70a2:: with SMTP id q2mr6510473ual.83.1570446103750;
 Mon, 07 Oct 2019 04:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191007104536.27276-1-mark.rutland@arm.com>
In-Reply-To: <20191007104536.27276-1-mark.rutland@arm.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 7 Oct 2019 13:01:32 +0200
Message-ID: <CANpmjNModNhea_tCjHwLCcDwVLN7eZepwRztvc2McE315P8uBw@mail.gmail.com>
Subject: Re: [PATCH] stop_machine: avoid potential race behaviour
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019 at 12:45, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Both multi_cpu_stop() and set_state() access multi_stop_data::state
> racily using plain accesses. These are subject to compiler
> transformations which could break the intended behaviour of the code,
> and this situation is detected by KCSAN on both arm64 and x86 (splats
> below).
>
> Let's improve matters by using READ_ONCE() and WRITE_ONCE() to ensure
> that the compiler cannot elide, replay, or tear loads and stores. In
> multi_cpu_stop() we expect the two loads of multi_stop_data::state to be
> a consistent value, so we snapshot the value into a temporary variable
> to ensure this.
>
> The state transitions are serialized by atomic manipulation of
> multi_stop_data::num_threads, and other fields in multi_stop_data are
> not modified while subject to concurrent reads.
>
> KCSAN splat on arm64:
>
> | BUG: KCSAN: data-race in multi_cpu_stop+0xa8/0x198 and set_state+0x80/0xb0
> |
> | write to 0xffff00001003bd00 of 4 bytes by task 24 on cpu 3:
> |  set_state+0x80/0xb0
> |  multi_cpu_stop+0x16c/0x198
> |  cpu_stopper_thread+0x170/0x298
> |  smpboot_thread_fn+0x40c/0x560
> |  kthread+0x1a8/0x1b0
> |  ret_from_fork+0x10/0x18
> |
> | read to 0xffff00001003bd00 of 4 bytes by task 14 on cpu 1:
> |  multi_cpu_stop+0xa8/0x198
> |  cpu_stopper_thread+0x170/0x298
> |  smpboot_thread_fn+0x40c/0x560
> |  kthread+0x1a8/0x1b0
> |  ret_from_fork+0x10/0x18
> |
> | Reported by Kernel Concurrency Sanitizer on:
> | CPU: 1 PID: 14 Comm: migration/1 Not tainted 5.3.0-00007-g67ab35a199f4-dirty #3
> | Hardware name: linux,dummy-virt (DT)
>
> KCSAN splat on x86:
>
> | write to 0xffffb0bac0013e18 of 4 bytes by task 19 on cpu 2:
> |  set_state kernel/stop_machine.c:170 [inline]
> |  ack_state kernel/stop_machine.c:177 [inline]
> |  multi_cpu_stop+0x1a4/0x220 kernel/stop_machine.c:227
> |  cpu_stopper_thread+0x19e/0x280 kernel/stop_machine.c:516
> |  smpboot_thread_fn+0x1a8/0x300 kernel/smpboot.c:165
> |  kthread+0x1b5/0x200 kernel/kthread.c:255
> |  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:352
> |
> | read to 0xffffb0bac0013e18 of 4 bytes by task 44 on cpu 7:
> |  multi_cpu_stop+0xb4/0x220 kernel/stop_machine.c:213
> |  cpu_stopper_thread+0x19e/0x280 kernel/stop_machine.c:516
> |  smpboot_thread_fn+0x1a8/0x300 kernel/smpboot.c:165
> |  kthread+0x1b5/0x200 kernel/kthread.c:255
> |  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:352
> |
> | Reported by Kernel Concurrency Sanitizer on:
> | CPU: 7 PID: 44 Comm: migration/7 Not tainted 5.3.0+ #1
> | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>

Thanks for fixing this!

Acked-by: Marco Elver <elver@google.com>

> ---
>  kernel/stop_machine.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> index c7031a22aa7b..998d50ee2d9b 100644
> --- a/kernel/stop_machine.c
> +++ b/kernel/stop_machine.c
> @@ -7,6 +7,7 @@
>   * Copyright (C) 2010          SUSE Linux Products GmbH
>   * Copyright (C) 2010          Tejun Heo <tj@kernel.org>
>   */
> +#include <linux/compiler.h>
>  #include <linux/completion.h>
>  #include <linux/cpu.h>
>  #include <linux/init.h>
> @@ -167,7 +168,7 @@ static void set_state(struct multi_stop_data *msdata,
>         /* Reset ack counter. */
>         atomic_set(&msdata->thread_ack, msdata->num_threads);
>         smp_wmb();
> -       msdata->state = newstate;
> +       WRITE_ONCE(msdata->state, newstate);
>  }
>
>  /* Last one to ack a state moves to the next state. */
> @@ -186,7 +187,7 @@ void __weak stop_machine_yield(const struct cpumask *cpumask)
>  static int multi_cpu_stop(void *data)
>  {
>         struct multi_stop_data *msdata = data;
> -       enum multi_stop_state curstate = MULTI_STOP_NONE;
> +       enum multi_stop_state newstate, curstate = MULTI_STOP_NONE;
>         int cpu = smp_processor_id(), err = 0;
>         const struct cpumask *cpumask;
>         unsigned long flags;
> @@ -210,8 +211,9 @@ static int multi_cpu_stop(void *data)
>         do {
>                 /* Chill out and ensure we re-read multi_stop_state. */
>                 stop_machine_yield(cpumask);
> -               if (msdata->state != curstate) {
> -                       curstate = msdata->state;
> +               newstate = READ_ONCE(msdata->state);
> +               if (newstate != curstate) {
> +                       curstate = newstate;
>                         switch (curstate) {
>                         case MULTI_STOP_DISABLE_IRQ:
>                                 local_irq_disable();
> --
> 2.11.0
>
