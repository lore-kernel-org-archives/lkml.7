Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C086C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6112D20729
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMPTru0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfKOINM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 03:13:12 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35406 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfKOINL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:13:11 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so7353957lfl.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 00:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GTuooXfeRJCn+Le2dc6w/geRWvuq4bPUY6baj5P3vh8=;
        b=tMPTru0VmkKgO4TtmWounwu7MnPwXGtKmiDlCwMqoo4HV0v3hCnQEQIdLRJlwdH0hN
         TYCejypUBj5umj4BlavTWpbHIwAtZ/XcBIZlO/t+2YlPcm+IwO7JAfYxOXyloaHWjiiU
         VliwE5H6VKtPhgKES2ZwR9+hvOrsybdFTEV76B+8W0OychwR9lGseeBBiiitbKcaTJNn
         BgsdOVpJumkfx70X2PPoBUARE6VzwVtJ4An7JdFCdhBidnameUZR9BiAE9QE2uuagVE3
         dZoqb2/RKtJYpzC3PT+D/fMZdPZRyQ+Jdtd8mfBLSksgXYuKyP2aaTBqaajuIvdA2H0g
         ySwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GTuooXfeRJCn+Le2dc6w/geRWvuq4bPUY6baj5P3vh8=;
        b=Th2p+qL8YvHuAqxhL5dl7azDls0BVFldxUtaLZ86qe0+7O+qBGKQUpSzWthBwNXjwD
         APTXyM2ZAC/laHbqXxZKm0vzrrBZGIXncmeXk99Qw0ZVtnmodcd1ZTF5ty8NWE7U0oRN
         MgGl4vpXTpFQjCteXuGu8MTWra2AV/cktCI1D/ahA2bnO3DWdcUA3rcAtIVXefH83HhM
         Oxg5nxIBRUpvdOBm6i4uU0GDCsIqqLpcy6mwfMwDtbT7/Z9YT1HAL6biwGYtn+hXHPeC
         ok/Rn5+dfWfjoEjHiCe03f3j1CUSJeRpnn6SPYmyHQZUFBFra100oPQVDmlb+7g2z4bi
         Tt/w==
X-Gm-Message-State: APjAAAWtyj1bd9/QHYJ22s2wJsb0linos6enlaMH/7qSGWH3e5yjeJYf
        LuDHlS+C1r5XHBi4XE2fi7KbqKTl5gnH9HcYbWsu3g==
X-Google-Smtp-Source: APXvYqxEPbCeln0OjPfZh9YCZR0YccGTcjka4RocqjsgSXaiMdmhdDchG+opaGL6fCg/Lor+FFN69I6M8EshiCZm/uo=
X-Received: by 2002:a19:ed12:: with SMTP id y18mr9899503lfy.151.1573805590014;
 Fri, 15 Nov 2019 00:13:10 -0800 (PST)
MIME-Version: 1.0
References: <20191113165334.14291-1-valentin.schneider@arm.com>
In-Reply-To: <20191113165334.14291-1-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Nov 2019 09:12:58 +0100
Message-ID: <CAKfTPtCeGPS57wdyVjA7mnQTW4EeTrd0LX-_1f_+MWp--1FRNQ@mail.gmail.com>
Subject: Re: [PATCH] sched/uclamp: Fix overzealous type replacement
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Tejun Heo <tj@kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019 at 17:55, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Some uclamp helpers had their return type changed from 'unsigned int' to
> 'enum uclamp_id' by commit
>
>   0413d7f33e60 ("sched/uclamp: Always use 'enum uclamp_id' for clamp_id values")
>
> but it happens that some *actually* do return an unsigned int value. Those
> are the helpers that return a utilization value: uclamp_rq_max_value() and
> uclamp_eff_value(). Fix those up.
>
> Note that this doesn't lead to any obj diff using a relatively recent
> aarch64 compiler (8.3-2019.03). The current code of e.g. uclamp_eff_value()
> already figures out that the return value is 11 bits (bits_per(1024)) and
> doesn't seem to do anything funny. I'm still marking this as fixing the
> above commit to be on the safe side.
>
> Fixes: 0413d7f33e60 ("sched/uclamp: Always use 'enum uclamp_id' for clamp_id values")
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/core.c  | 4 ++--
>  kernel/sched/sched.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 513a4794ff36..71a45025cd2e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -853,7 +853,7 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
>  }
>
>  static inline
> -enum uclamp_id uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
> +unsigned int uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
>                                    unsigned int clamp_value)
>  {
>         struct uclamp_bucket *bucket = rq->uclamp[clamp_id].bucket;
> @@ -918,7 +918,7 @@ uclamp_eff_get(struct task_struct *p, enum uclamp_id clamp_id)
>         return uc_req;
>  }
>
> -enum uclamp_id uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
> +unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id)
>  {
>         struct uclamp_se uc_eff;
>

And static inline enum uclamp_id uclamp_none(enum uclamp_id clamp_id) ?

Should it be fixed as well as it can return SCHED_CAPACITY_SCALE ?



> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 05c282775f21..280a3c735935 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2300,7 +2300,7 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
>  #endif /* CONFIG_CPU_FREQ */
>
>  #ifdef CONFIG_UCLAMP_TASK
> -enum uclamp_id uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
> +unsigned int uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
>
>  static __always_inline
>  unsigned int uclamp_util_with(struct rq *rq, unsigned int util,
> --
> 2.22.0
>
