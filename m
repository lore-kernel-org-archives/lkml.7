Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B16FC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2809F218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=indeed.com header.i=@indeed.com header.b="jbE5L/rP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391099AbfIRUMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:12:10 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46467 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391086AbfIRUMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:12:09 -0400
Received: by mail-io1-f67.google.com with SMTP id d17so2087441ios.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 13:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/fiUUlYgxdJ9KfBpfNgNPKgRjOsYWfSvyTgY+Iv8qw8=;
        b=jbE5L/rPJx/LNsb6uiSic4hGnCcNDWpobwPFI9CGe1kpmfnYYCJtipQaR2t5HcxSTs
         rVJ406tzuEs1nYdZ5taQ1YQXpUcBFqvXQlWd71IsKQF+gLEhNXuU7V6VJln/Tvd1h/wk
         a3pWW5jxdmmbSP/Hk0UbxSMncCgELfoGfcMFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fiUUlYgxdJ9KfBpfNgNPKgRjOsYWfSvyTgY+Iv8qw8=;
        b=oPbBjqlBYgfYHXH30Zc/8RiaUWPtnBDT11R9qNmVpfhCzBi6jb8R4Mh/ZYhgErhAnW
         j33WZVaYs3cJ1nHm1ibeOIYPNKIutBrVPPSV04LTZvzVbDeIfbdG2kdWMyAI5fcPO8RR
         jMGaApy0Ryf8WDUexLkJ7ILewObZ0Pp14AFNzbP0P1/bUx2ooPpAHav/LnN6ZE14amRB
         69mFNnllFU59bxRtNq32kKNHn+KmPlmjunuTMKq5ZtQ1qIUsp5/hGYfazLxH2T0L42xA
         SiKOB4kaFv3dLQ+kW+bM+m+CZBS+dCSA1gqiUiliKLC7pogH0R8gE7ZVzZ+/n9D8sUc0
         lz5g==
X-Gm-Message-State: APjAAAUWwEKD0I9E8pESzRx9UWml1u02lKCfcivH5Z+tRI9rT4DYW7/Z
        TZXfvr1Mo5ycpq30+nmxcjMZ6wDD4duk7yEM5m4xmw==
X-Google-Smtp-Source: APXvYqy7j5H1SUGHGlFV/6C6S3ijJOEQhsjKUuJwbxc8woh+Dic9nmcz6trNBkIxWAQComeC89HOQYlm1MCWck3DGN4=
X-Received: by 2002:a6b:f717:: with SMTP id k23mr7185652iog.210.1568837527258;
 Wed, 18 Sep 2019 13:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <1568833304-5148-1-git-send-email-cai@lca.pw>
In-Reply-To: <1568833304-5148-1-git-send-email-cai@lca.pw>
From:   Dave Chiluk <chiluk+linux@indeed.com>
Date:   Wed, 18 Sep 2019 15:11:41 -0500
Message-ID: <CAC=E7cVyrc0dFnrGL84mqUYHsFfuijPrt2eq8ttCwgmCKJpVOg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: fix -Wunused-but-set-variable warnings
To:     Qian Cai <cai@lca.pw>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, Ben Segall <bsegall@google.com>,
        mgorman@suse.de, Phil Auld <pauld@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

de53fd7aedb1 has just been merged into Linus' mainline tree for
eventual inclusion in 5.4.  This should be pushed into there, and not
wait till 5.5.

Both I and Ben Segall have already +1'd this in previous threads.

Sorry for introducing the warnings.

Dave.

On Wed, Sep 18, 2019 at 2:02 PM Qian Cai <cai@lca.pw> wrote:
>
> The commit de53fd7aedb1 ("sched/fair: Fix low cpu usage with high
> throttling by removing expiration of cpu-local slices") introduced a few
> compilation warnings:
>
>   kernel/sched/fair.c: In function '__refill_cfs_bandwidth_runtime':
>   kernel/sched/fair.c:4365:6: warning: variable 'now' set but not used
>     [-Wunused-but-set-variable]
>   kernel/sched/fair.c: In function 'start_cfs_bandwidth':
>   kernel/sched/fair.c:4992:6: warning: variable 'overrun' set but not
>     used [-Wunused-but-set-variable]
>
> Also, __refill_cfs_bandwidth_runtime() does no longer update the
> expiration time, so fix the comments accordingly.
>
> Fixes: de53fd7aedb1 ("sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices")
> Reviewed-by: Ben Segall <bsegall@google.com>
> Reviewed-by: Dave Chiluk <chiluk+linux@indeed.com>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>
> Resend it since the offensive commit is now in the mainline.
>
>  kernel/sched/fair.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bbf68c3161..b4fb016e3557 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4354,21 +4354,16 @@ static inline u64 sched_cfs_bandwidth_slice(void)
>  }
>
>  /*
> - * Replenish runtime according to assigned quota and update expiration time.
> - * We use sched_clock_cpu directly instead of rq->clock to avoid adding
> - * additional synchronization around rq->lock.
> + * Replenish runtime according to assigned quota. We use sched_clock_cpu
> + * directly instead of rq->clock to avoid adding additional synchronization
> + * around rq->lock.
>   *
>   * requires cfs_b->lock
>   */
>  void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
>  {
> -       u64 now;
> -
> -       if (cfs_b->quota == RUNTIME_INF)
> -               return;
> -
> -       now = sched_clock_cpu(smp_processor_id());
> -       cfs_b->runtime = cfs_b->quota;
> +       if (cfs_b->quota != RUNTIME_INF)
> +               cfs_b->runtime = cfs_b->quota;
>  }
>
>  static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
> @@ -4994,15 +4989,13 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>
>  void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>  {
> -       u64 overrun;
> -
>         lockdep_assert_held(&cfs_b->lock);
>
>         if (cfs_b->period_active)
>                 return;
>
>         cfs_b->period_active = 1;
> -       overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
> +       hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
>         hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
>  }
>
> --
> 1.8.3.1
>
