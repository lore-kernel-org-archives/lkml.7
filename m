Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0DCC3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAFE22DD3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8XKJ8bK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbfHTRlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:41:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43829 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730746AbfHTRlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:41:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id v12so3800080pfn.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 10:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nL1brXEfQMdIxIJXPk/Y2+UflsnVuvtsUOeRD+MuXQE=;
        b=K8XKJ8bKRTslVZ76tJ4PUPFt1p/dMxR8oFMl8Fm7Ks6IhPnc2oyKSQ1bQniMiQP3/T
         MDciMxKSfnBaN+bGzkqIadMVKHWZVRdBeQgf/fXPcv9dsO9olIySiOGcTUZ5AgyXTXv/
         zjatU+bjT8uF/UCEFVJk+T6QAlarlIx37v+dOEg5kg0eVqbn4uak3cWTE8J2YQRGcfCv
         VBBH+2//hURClTZXu5VGctfLqVRImaF0WqPbRh2IC897jFU2NFRR6/FtQzBpXSUQAT00
         WciLVG6eeS7HuXzowi1dlNzlVE+gaWXPJGAZltwWf8usti3ZDPJ21hVOgPCmL/C2nOwP
         eeyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=nL1brXEfQMdIxIJXPk/Y2+UflsnVuvtsUOeRD+MuXQE=;
        b=qi3skASiPtLG8cIjccXQNgOsE6LwBeHH4W0qe9VOs3jnMHzA8k78ANE4qCQ6+hMH+F
         vNIicVkg4qC4+YONJBGrJPR9eXypoycvxHAN87vo7tdUsZ9mOwHM6JwmFHJsCauICc7d
         x8q1aSdnYWjNwjerY+lTOHTPwHOtXD1j0FE0e6oJNzdurbQb2ry3mwHRHA0OZAep8bnw
         trHkHAJlKW7e+nrBz2FhKWCxtVDIpzh5PdRdD0hhZQ/kIc3cwTBMb5H7rXxGqDcNSnuQ
         8fdQa19LX11EGg/g3lCTxxAePXGL4Zf/wQR6a8XoyOkDhcxxbAQVewe/MEh4Jd0uHYT3
         gO2g==
X-Gm-Message-State: APjAAAXrZLbhJCiWD8TYtH/jSpjGj0oeQkV/fy3HHOLvCdKVUsHoa0rJ
        TBJb5Sgqji2RTTy2IQHCJ9O7sGOn/6L1cg==
X-Google-Smtp-Source: APXvYqxp/gkn8Z/n+lFf5mLqXdQyUrj595hqoOZvbNvA/EiG0s9l/162vIpQtZ/Pk8XsRYYST3Seag==
X-Received: by 2002:a63:3006:: with SMTP id w6mr25998111pgw.440.1566322883800;
        Tue, 20 Aug 2019 10:41:23 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id z16sm19543049pgi.8.2019.08.20.10.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 10:41:23 -0700 (PDT)
From:   bsegall@google.com
To:     Qian Cai <cai@lca.pw>
Cc:     mingo@redhat.com, peterz@infradead.org, chiluk+linux@indeed.com,
        pauld@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] sched/fair: fix -Wunused-but-set-variable warnings
References: <1566310558-29584-1-git-send-email-cai@lca.pw>
Date:   Tue, 20 Aug 2019 10:41:22 -0700
In-Reply-To: <1566310558-29584-1-git-send-email-cai@lca.pw> (Qian Cai's
        message of "Tue, 20 Aug 2019 10:15:58 -0400")
Message-ID: <xm26y2znivjx.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <cai@lca.pw> writes:

> The linux-next commit "sched/fair: Fix low cpu usage with high
> throttling by removing expiration of cpu-local slices" [1] introduced a
> few compilation warnings,
>
> kernel/sched/fair.c: In function '__refill_cfs_bandwidth_runtime':
> kernel/sched/fair.c:4365:6: warning: variable 'now' set but not used
> [-Wunused-but-set-variable]
> kernel/sched/fair.c: In function 'start_cfs_bandwidth':
> kernel/sched/fair.c:4992:6: warning: variable 'overrun' set but not used
> [-Wunused-but-set-variable]
>
> Also, __refill_cfs_bandwidth_runtime() does no longer update the
> expiration time, so fix the comments accordingly.
>
> [1] https://lore.kernel.org/lkml/1558121424-2914-1-git-send-email-chiluk+linux@indeed.com/
>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  kernel/sched/fair.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 84959d3285d1..43d6eb033ca8 100644
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
> -	u64 now;
> -
> -	if (cfs_b->quota == RUNTIME_INF)
> -		return;
> -
> -	now = sched_clock_cpu(smp_processor_id());
> -	cfs_b->runtime = cfs_b->quota;
> +	if (cfs_b->quota != RUNTIME_INF)
> +		cfs_b->runtime = cfs_b->quota;
>  }

This is fine.

>  
>  static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
> @@ -4989,15 +4984,12 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>  
>  void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>  {
> -	u64 overrun;
> -
>  	lockdep_assert_held(&cfs_b->lock);
>  
>  	if (cfs_b->period_active)
>  		return;
>  
>  	cfs_b->period_active = 1;
> -	overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);

This is not - hrtimer_forward_now has effects we still need.

>  	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
>  }
