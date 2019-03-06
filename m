Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F6BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF252064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZF+CeOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfCFHux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:50:53 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36758 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfCFHuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:50:52 -0500
Received: by mail-ot1-f65.google.com with SMTP id v62so9935471otb.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 23:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GU5+nWYRQSdd+qoWAV+Sui40HhvplPa7wwWz68NUclA=;
        b=SZF+CeOdm8wUpQfRGsYuvMc2/0ifd3meyyWQv7N1Xmx0t0ivK/OK8a7vcYYbf2V6rS
         JRUD/zhF1YVU7YlCb9E3rWYez4JQYH01wshuljE8FK6jtRFGaxYM84v/hRsfCWt3WjJ1
         Tb/UqI8WdMvEXGIXP6yCFx8pSmVwiv+JAslYvFkv+3oY1pBqudmkPBfX4kfKcxduAc+p
         C67fabIBoCpC4GuKffundTyTExL8OHX7LgR6hdgwae7ehS88DOUw6MhOaQdtz5IdDDIs
         qtEpzWt0WA2R5CnRopSCJ1HJgksT0CsHGWUTjdP/WXA8IowcQOSMLAOmwKXVYFksXSR7
         R9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GU5+nWYRQSdd+qoWAV+Sui40HhvplPa7wwWz68NUclA=;
        b=uYjo4N6g3fV0NvFK+jKpqjgQfjcYljQGnS23dAc7Wf2rXTYZZfLMUsTblfAMBQr/0b
         AREEpVDiLgcVx1CTnnl/baAEANH9b68sQDOPkUyF0aTFFjzBmoNWzvrGB8ByYOA6GvQM
         GL0hqEKSV77+VnG0fQs+dgKAK2tHnFWnuaWu1IFWFZfymIC9fw2b2XcsDbYmzy5Af3mF
         e7G/nFwxiFmTLCqWVLRYj0o2LyO1BieFXrJLuPTsB/PPdC+uJxT0laA00P0ZgTi7Y8IL
         Xm2giTnBm/Ujezy9GaFbZ873OCnwPGag1V82gPKUy9nDciIswxNI/2Ae4x5i0soRCX0B
         OMMA==
X-Gm-Message-State: APjAAAVCaUFAqFy7B5RqHmvLFHWsoclaQF6eePQewgREaihvKSTXinMI
        GcmldJ5GoxDTDzl6OKkizGJ1Y8lfoAKxhGomYGU=
X-Google-Smtp-Source: APXvYqzR6/YvTkPf4rN4TtjwMqrBtkONOCvM8jNjc2EenL1nYFKita67nidr5TRPbqKEs6sR3rRbgVG4LhQrt7+SVgI=
X-Received: by 2002:a9d:130:: with SMTP id 45mr3762804otu.355.1551858651179;
 Tue, 05 Mar 2019 23:50:51 -0800 (PST)
MIME-Version: 1.0
References: <1550831866-32749-1-git-send-email-chunyan.zhang@unisoc.com>
 <20190222105957.wxhlcmoag5f3i4fi@queper01-lin> <9099990618e242e1bab77ce3f9d9b1e3@BJMBX02.spreadtrum.com>
 <20190304135810.rq2ojnbn5vezrab3@queper01-lin> <20190304152616.GM32494@hirez.programming.kicks-ass.net>
 <20190304164816.4fnxxesjwzdoqria@queper01-lin> <20190304174028.GO32494@hirez.programming.kicks-ass.net>
 <20190304175030.4slf247y2eftkmu4@queper01-lin> <20190304184708.GQ32494@hirez.programming.kicks-ass.net>
 <20190304191059.mzwid3udqwtzejww@queper01-lin> <20190305083202.GU32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190305083202.GU32494@hirez.programming.kicks-ass.net>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 6 Mar 2019 15:50:39 +0800
Message-ID: <CABOV4+W2wHBCU_HVFjKAazgxHGaJgmErgDyjVEdX4ipg09V+JA@mail.gmail.com>
Subject: Re: [PATCH] sched/cpufreq: Fix 32bit math overflow
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Quentin Perret <quentin.perret@arm.com>,
        =?UTF-8?B?V2FuZywgVmluY2VudCAo546L5LqJKQ==?= 
        <Vincent.Wang@unisoc.com>,
        =?UTF-8?B?WmhhbmcsIENodW55YW4gKOW8oOaYpeiJsyk=?= 
        <Chunyan.Zhang@unisoc.com>, Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 4:32 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Mar 04, 2019 at 07:11:01PM +0000, Quentin Perret wrote:
>
> > So yeah, that works for me.
>
> Chunyan, Vincent; can you verify the below cures your ill?

Verified by Vincent, the patch below can fix the problem Vincent found
on our platform before.

Thanks,
Chunyan

>
> ---
> Subject: sched/cpufreq: Fix 32bit math overflow
>
> Vincent Wang reported that get_next_freq() has a mult overflow issue on
> 32bit platforms in the IOWAIT boost case, since in that case {util,max}
> are in freq units instead of capacity units.
>
> Solve this by moving the IOWAIT boost to capacity units. And since this
> means @max is constant; simplify the code.
>
> Cc: Chunyan Zhang <chunyan.zhang@unisoc.com>
> Reported-by: Vincent Wang <vincent.wang@unisoc.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 58 +++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 34 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 2efe629425be..72b62ac1c7c2 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -48,10 +48,10 @@ struct sugov_cpu {
>
>         bool                    iowait_boost_pending;
>         unsigned int            iowait_boost;
> -       unsigned int            iowait_boost_max;
>         u64                     last_update;
>
>         unsigned long           bw_dl;
> +       unsigned long           min;
>         unsigned long           max;
>
>         /* The field below is for single-CPU policies only: */
> @@ -303,8 +303,7 @@ static bool sugov_iowait_reset(struct sugov_cpu *sg_cpu, u64 time,
>         if (delta_ns <= TICK_NSEC)
>                 return false;
>
> -       sg_cpu->iowait_boost = set_iowait_boost
> -               ? sg_cpu->sg_policy->policy->min : 0;
> +       sg_cpu->iowait_boost = set_iowait_boost ? sg_cpu->min : 0;
>         sg_cpu->iowait_boost_pending = set_iowait_boost;
>
>         return true;
> @@ -344,14 +343,12 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
>
>         /* Double the boost at each request */
>         if (sg_cpu->iowait_boost) {
> -               sg_cpu->iowait_boost <<= 1;
> -               if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
> -                       sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
> +               sg_cpu->iowait_boost = min(sg_cpu->iowait_boost << 1, SCHED_CAPACITY_SCALE);
>                 return;
>         }
>
>         /* First wakeup after IO: start with minimum boost */
> -       sg_cpu->iowait_boost = sg_cpu->sg_policy->policy->min;
> +       sg_cpu->iowait_boost = sg_cpu->min;
>  }
>
>  /**
> @@ -373,47 +370,38 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
>   * This mechanism is designed to boost high frequently IO waiting tasks, while
>   * being more conservative on tasks which does sporadic IO operations.
>   */
> -static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
> -                              unsigned long *util, unsigned long *max)
> +static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
> +                                       unsigned long util, unsigned long max)
>  {
> -       unsigned int boost_util, boost_max;
> +       unsigned long boost;
>
>         /* No boost currently required */
>         if (!sg_cpu->iowait_boost)
> -               return;
> +               return util;
>
>         /* Reset boost if the CPU appears to have been idle enough */
>         if (sugov_iowait_reset(sg_cpu, time, false))
> -               return;
> +               return util;
>
> -       /*
> -        * An IO waiting task has just woken up:
> -        * allow to further double the boost value
> -        */
> -       if (sg_cpu->iowait_boost_pending) {
> -               sg_cpu->iowait_boost_pending = false;
> -       } else {
> +       if (!sg_cpu->iowait_boost_pending) {
>                 /*
> -                * Otherwise: reduce the boost value and disable it when we
> -                * reach the minimum.
> +                * No boost pending; reduce the boost value.
>                  */
>                 sg_cpu->iowait_boost >>= 1;
> -               if (sg_cpu->iowait_boost < sg_cpu->sg_policy->policy->min) {
> +               if (sg_cpu->iowait_boost < sg_cpu->min) {
>                         sg_cpu->iowait_boost = 0;
> -                       return;
> +                       return util;
>                 }
>         }
>
> +       sg_cpu->iowait_boost_pending = false;
> +
>         /*
> -        * Apply the current boost value: a CPU is boosted only if its current
> -        * utilization is smaller then the current IO boost level.
> +        * @util is already in capacity scale; convert iowait_boost
> +        * into the same scale so we can compare.
>          */
> -       boost_util = sg_cpu->iowait_boost;
> -       boost_max = sg_cpu->iowait_boost_max;
> -       if (*util * boost_max < *max * boost_util) {
> -               *util = boost_util;
> -               *max = boost_max;
> -       }
> +       boost = (sg_cpu->iowait_boost * max) >> SCHED_CAPACITY_SHIFT;
> +       return max(boost, util);
>  }
>
>  #ifdef CONFIG_NO_HZ_COMMON
> @@ -460,7 +448,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>
>         util = sugov_get_util(sg_cpu);
>         max = sg_cpu->max;
> -       sugov_iowait_apply(sg_cpu, time, &util, &max);
> +       util = sugov_iowait_apply(sg_cpu, time, util, max);
>         next_f = get_next_freq(sg_policy, util, max);
>         /*
>          * Do not reduce the frequency if the CPU has not been idle
> @@ -500,7 +488,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>
>                 j_util = sugov_get_util(j_sg_cpu);
>                 j_max = j_sg_cpu->max;
> -               sugov_iowait_apply(j_sg_cpu, time, &j_util, &j_max);
> +               j_util = sugov_iowait_apply(j_sg_cpu, time, j_util, j_max);
>
>                 if (j_util * max > j_max * util) {
>                         util = j_util;
> @@ -837,7 +825,9 @@ static int sugov_start(struct cpufreq_policy *policy)
>                 memset(sg_cpu, 0, sizeof(*sg_cpu));
>                 sg_cpu->cpu                     = cpu;
>                 sg_cpu->sg_policy               = sg_policy;
> -               sg_cpu->iowait_boost_max        = policy->cpuinfo.max_freq;
> +               sg_cpu->min                     =
> +                       (SCHED_CAPACITY_SCALE * policy->cpuinfo.min_freq) /
> +                       policy->cpuinfo.max_freq;
>         }
>
>         for_each_cpu(cpu, policy->cpus) {
