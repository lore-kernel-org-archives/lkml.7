Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFB1C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D78C205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfHNL04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:26:56 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42224 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfHNL0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:26:55 -0400
Received: by mail-oi1-f193.google.com with SMTP id o6so3170911oic.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 04:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4v4qkIfH3jO9OemUkVOmNfKO3Ze07me/8dLA6V285s=;
        b=qp2YZAgUARaGwnSC3WaD/s+m7gH6iQ/mf2Ido2LNqjEPLf7p8mAPotLR2UjRvHngmx
         ymMItW2wqMXUphf3YTbXIfytDe0l3E2OSDPRpIaU+FbjuVY+XMtzhQ4gDT2maIR6Y4rn
         FHmSgs72LtlZEftEDNCR98aSjpPJDJ+sXaJ3Ktdx1IB+P/BXBIOxtOe/PK7qSCOY8vcy
         uI6TFkGcwZLfBBdd9FEHHk7oeyPQQhRBoC3WOuyf+WnfUUsih5u4BravJ2mURAZoKKlX
         UGtxJzyLFu+b0/a2bQVjpyHvd9dQVyxwaLxUYIZhXeNq717+i9fbaEgZmJdiqtF97ks4
         5dEg==
X-Gm-Message-State: APjAAAWt+8LSzzZsBJoDThEyvcMYCZ8Y2pwvAf4Ln2W92zutHv3wxTjU
        9QLB0I2V0vLcq0NQW77n98KPaWQtSxFwN+Sf6Cc=
X-Google-Smtp-Source: APXvYqw9xnb/rL5SZzZcbLmA1koBCQkAzjM/18IlUnfBbaC+B/pqAWLIhE56InNBDawbI3Q0s6UnN07wPGIrSD8KIbw=
X-Received: by 2002:aca:3bc6:: with SMTP id i189mr4507576oia.153.1565782014777;
 Wed, 14 Aug 2019 04:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190814104131.20190-1-mark.rutland@arm.com> <20190814104131.20190-2-mark.rutland@arm.com>
In-Reply-To: <20190814104131.20190-2-mark.rutland@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 14 Aug 2019 13:26:43 +0200
Message-ID: <CAMuHMdV_hZ-uMmKdqEutLL5+XkhhcKdSaurMUS2N46AhZwDNKQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] sched/core: add is_kthread() helper
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>, kan.liang@intel.com,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, Aug 14, 2019 at 12:43 PM Mark Rutland <mark.rutland@arm.com> wrote:
> Code checking whether a task is a kthread isn't very consistent. Some
> code correctly tests task->flags & PF_THREAD, while other code checks
> task->mm (which can be true for a kthread which calls use_mm()).
>
> So that we can clean this up and keep the code easy to follow, let's add
> an obvious helper function to test whether a task is a kthread.
> Subsequent patches will use this as part of cleaning up and correcting
> open-coded tests.
>
> At the same time, let's fix up the kerneldoc for is_idle_task() for
> consistency with the new helper, using true/false rather than 0/1, given
> the functions return bool.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Thanks for your patch!

> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1621,13 +1621,24 @@ extern struct task_struct *idle_task(int cpu);
>   * is_idle_task - is the specified task an idle task?
>   * @p: the task in question.
>   *
> - * Return: 1 if @p is an idle task. 0 otherwise.
> + * Return: true if @p is an idle task, false otherwise.
>   */
>  static inline bool is_idle_task(const struct task_struct *p)
>  {
>         return !!(p->flags & PF_IDLE);
>  }
>
> +/**
> + * is_kthread - is the specified task a kthread
> + * @p: the task in question.
> + *
> + * Return: true if @p is a kthread, false otherwise.
> + */
> +static inline bool is_kthread(const struct task_struct *p)
> +{
> +       return !!(p->flags & PF_KTHREAD);

The !! is not really needed.
Probably you followed is_idle_task() above (where it's also not needed).

> +}
> +

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
