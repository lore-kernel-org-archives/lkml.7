Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A844C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECD720729
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FUR4r36m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfKOOID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:08:03 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39006 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfKOOID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:08:03 -0500
Received: by mail-lj1-f196.google.com with SMTP id p18so10848490ljc.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 06:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHXyS4BV5OVtqBWRmRRF2YVqJlV8moIcPViTWoSzmjI=;
        b=FUR4r36mPgKSflt6dlDzfMMMLLRk2dMxOoFSFhmSjwV3fIjHFWB/XhH0hOtwUKJzCS
         b6/ya4RhaSn8V6RzipWU4nIDMB0o8uV/G0zsKfyz3RJOhUBeUrpboU5rXkXe/I66dmo9
         s8Cj2GkNMPrhgyOK56WMxkY16btzG/RbnR+J7O4DlZ1Ze8I52eojK/P6xPA4HbTZmeFc
         DTWNCEbvpOeIyoTfhRrFEx+l/pKQin9Ale4EXwUxyBWEZMKGTpM2BF5fNJueFLDvoNSU
         PSTYizM5WddVBAEBbeWjF1lTu1UpevFe1WK/a1TzGMjP2xd33p7jjXVHa3169mcwrinc
         uQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHXyS4BV5OVtqBWRmRRF2YVqJlV8moIcPViTWoSzmjI=;
        b=BT6LGIa/F9EJhEcAe/vO3TPyCm7c+Yi4RaDAESve335aFiJVb3j5IEMbfW65KP8LdS
         g/Q5a41fZX7XPWRc02Fh2wCh7F13GdcY4xMZvLMCEXikgsPN2pCIrGlMErh43odSQjwI
         m48z2LFYy6lhEz8rNd8udvhOygc1Ohi25OUoBFQMBv4eRQkXGfJZZamBKyJSJ3dLrKdl
         ZhDiKvjB6U7Keijyzpf1O2zqfMGQFVIa9rlgxFvfIn/SGN4iRdUqwZlgj5B06BJoucNC
         rjNelAANMjSv1F3ZfdVGaIHcgUaGT6N07afOpp5Yj5WHqa78D31/7LsQGcWptiWpJspA
         l5lg==
X-Gm-Message-State: APjAAAWAWMDpXHav+uChDckzjEcfK3v5tWAT3xHGl6AsLFK+QQ0LWFhj
        oa/xBWHehd2f0xGHfWv+EBglqAiY4XNx/ZUljjll0g==
X-Google-Smtp-Source: APXvYqxc11sdU/BUWFa2FbYjiioRXxs0N77ZQoFDfrZAGKJVj7SKBP7CLlyof9+uHFre4aCluKjMFSx/JyX1bU9Ibmk=
X-Received: by 2002:a2e:7811:: with SMTP id t17mr5696893ljc.225.1573826880859;
 Fri, 15 Nov 2019 06:08:00 -0800 (PST)
MIME-Version: 1.0
References: <20191115103908.27610-1-valentin.schneider@arm.com>
In-Reply-To: <20191115103908.27610-1-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Nov 2019 15:07:48 +0100
Message-ID: <CAKfTPtBoi_5sUiGrTpYuV_u2vPkBK+caUzgaKxY3Ck3PKJXZiw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/uclamp: Fix overzealous type replacement
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Tejun Heo <tj@kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>,
        Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 at 11:39, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Some uclamp helpers had their return type changed from 'unsigned int' to
> 'enum uclamp_id' by commit
>
>   0413d7f33e60 ("sched/uclamp: Always use 'enum uclamp_id' for clamp_id values")
>
> but it happens that some do return a value in the [0, SCHED_CAPACITY_SCALE]
> range, which should really be unsigned int. The affected helpers are
> uclamp_none(), uclamp_rq_max_value() and uclamp_eff_value(). Fix those up.
>
> Note that this doesn't lead to any obj diff using a relatively recent
> aarch64 compiler (8.3-2019.03). The current code of e.g. uclamp_eff_value()
> properly returns an 11 bit value (bits_per(1024)) and doesn't seem to do
> anything funny. I'm still marking this as fixing the above commit to be on
> the safe side.
>
> Fixes: 0413d7f33e60 ("sched/uclamp: Always use 'enum uclamp_id' for clamp_id values")
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
> v2 changes:
> o Also fix uclamp_none() (Vincent)
> o Collect reviewed-by
> o Slightly reword changelog
> ---
>  kernel/sched/core.c  | 6 +++---
>  kernel/sched/sched.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 513a4794ff36..3ceff1c93ef1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -810,7 +810,7 @@ static inline unsigned int uclamp_bucket_base_value(unsigned int clamp_value)
>         return UCLAMP_BUCKET_DELTA * uclamp_bucket_id(clamp_value);
>  }
>
> -static inline enum uclamp_id uclamp_none(enum uclamp_id clamp_id)
> +static inline unsigned int uclamp_none(enum uclamp_id clamp_id)

Out of curiosity why uclamp decided to use unsigned int to manipulate
utilization instead of unsigned long which is the type of util_avg ?

>  {
>         if (clamp_id == UCLAMP_MIN)
>                 return 0;
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
