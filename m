Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B924C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138FE206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KwSiMP1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfKORiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:38:46 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43023 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfKORiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:38:46 -0500
Received: by mail-lj1-f194.google.com with SMTP id y23so11524100ljh.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 09:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=50cd0M7vAQD0/6/aPgnVf9jq4gEjJPZFTZXvnnB3MwU=;
        b=KwSiMP1IP3slUDOrKKnVnkI5MCqs5n8qdd1bgA+evI5pM6NhYrQGmNgTJMNGEQslPG
         syWMNqWSUllKjIclDTeKnrCSD2VR4LDdyq6GqUL8eOEZe2F/IFEbLkCwXJ8NzPtSzzOj
         PG1RFRbyqUXApKk5/sz2hQ/DtC7ArxTFwq3oXDsZ0HiDXUcHyMF8hwXrfTifIgL9XJYs
         M3wngaVH4nKk5QDWOi1T0SKhxqk7lBijbpoh0BkczXQxXP+ScRg8isACuCkpljWTU4lG
         SrQ1hCqA517CMyBtYfzu3e/RYjlWuy/B700uXXns6uobI57NgSUWmybXw2n+eaN3vkXt
         07sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=50cd0M7vAQD0/6/aPgnVf9jq4gEjJPZFTZXvnnB3MwU=;
        b=o/Bd6dzCi1jpJiFPbROf+XNKZ0vWMX+Fl04OfRawxiZVywX4FVQSzaGrk4e0mmVbiD
         kNlUbilkppKWMj+giOtFOgOTbGXSK4SQ3TWNsOhOAt2elsLrH82Gc9aNPrEcsYZBQIhR
         bqtjlrQFubbG6KiFa4beLyT7QNXhjkZFLoRJRRf1V9aO+5bVqy+ChO8uX0zY0wb1pGqx
         +sFOqwLZ2ki9s9oVN2Mn7iaW3sYxcocBKx9aSFkoLsISjLg7oqkYyAedyCa2PIw4L4mF
         Tr9Tda9KZ1GG8CaLTznBIzbid6ObPwWOc+2k+RgdFac24IFlznhjBuumbBZCAnPdQ49d
         alMw==
X-Gm-Message-State: APjAAAWhSb1XuxxZgPhKtCRLLqDj/YYY/UQUgvIUA2cnv5ESmxj6W0oe
        hoMtscb1Y3cF+gMUhUjHBkmm2MfnalrXT7p3hNA4Xw==
X-Google-Smtp-Source: APXvYqzDkE6nqWkPiGCg7cN35e7x0ULyD/gGZSxNepOyYVFSVmP9yAZFCOpPapWF5hY5oT4KjkCW+5IkhVid7pgAiz0=
X-Received: by 2002:a2e:9748:: with SMTP id f8mr10824717ljj.87.1573839523914;
 Fri, 15 Nov 2019 09:38:43 -0800 (PST)
MIME-Version: 1.0
References: <20191115103908.27610-1-valentin.schneider@arm.com>
In-Reply-To: <20191115103908.27610-1-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Nov 2019 18:38:32 +0100
Message-ID: <CAKfTPtC8bT69eH20tZnk8tfO-a9SPqFcKdMS3JzOd41LxBKG5Q@mail.gmail.com>
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

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

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
