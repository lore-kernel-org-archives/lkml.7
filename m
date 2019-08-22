Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E809EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7A92082F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/3Bzjx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390799AbfHVSs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 14:48:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40477 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbfHVSs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:48:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id w16so4544343pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 11:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=knLIZp+zbOlNhuJ4IK30KG/S108pFq9/fsx7RaEndME=;
        b=Y/3Bzjx68Z/0x/qyRf5TmSwdU/l3KYW+FJAfKio/i72CU6lYkPg+uQR+uvH3HPQHZF
         yiwVw8oDBsgK1c59LZNoizarw0s5UBRbbNViBSwmovomkF1xVgU1E0hg+2WA1aN9VWB6
         kNmBksdx8HzIQrWBw88JvqCZJONM/r4afd4OIvxtUpoW+EkqxiJ6F8cUQ2HoP6iX7AC0
         t7B5khxe+/5zrEso8b4AW2JTHA4OUnLvbM7P2lcgep2yeh0PHWpEricbYlnxEvEQGrfs
         4jA9sjkxwhsaJNLmMjA+6f+KbtwdwNlzS2EbBmAeGcx3ndmC0SCsLlvOvPQmB+64q2Dd
         seQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=knLIZp+zbOlNhuJ4IK30KG/S108pFq9/fsx7RaEndME=;
        b=EBPTz+I9iTTBS+vbQ9tMHy9dhxlNprta6fCG56mo310xsrKFDGlgogm9B7Y1iEvmMc
         QwqbpsJS/+ltGOK8lBidnyDYHaSjakkMEKDrnOXOpTNPlJNbKcZRvfpaNvNYmxgAqFKQ
         42ejF4e3h29jYr9EaOWI9oMfHudQAR0GYntoLhx7VhOS3B9zj+FvdKO8yGAuQLmqTips
         /ybWFHrRGlB7y8z9cTJibGYLadJ7LiTRQExE+x6FNv0zdL1sTsN1UweUaNY20xTE2qBX
         7sqewWrnBH26kDdAznSnbhe6HVLyFG7aEeIbxuh1xfUuX1dxIrzgnYKZm3F7b4rGqYB0
         F4pg==
X-Gm-Message-State: APjAAAXEpTjF09JfKegnhs8P2aTgGzPFczKIUlIgozqNrQYIZYihVAfp
        JHLyXPAKzeHN0BZ9XXw+9SjbFg==
X-Google-Smtp-Source: APXvYqx9ItZpsQA3aP7c+m+ExOGac4lh9311IY90jGMZ4xk/1RTlPD477snAzdaXSWuU6Y7AlalpEA==
X-Received: by 2002:a63:2148:: with SMTP id s8mr570768pgm.336.1566499706029;
        Thu, 22 Aug 2019 11:48:26 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id j10sm110010pfn.188.2019.08.22.11.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 11:48:25 -0700 (PDT)
From:   bsegall@google.com
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, liangyan.peng@linux.alibaba.com,
        shanpeic@linux.alibaba.com, xlpang@linux.alibaba.com,
        pjt@google.com, stable@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Add missing unthrottle_cfs_rq()
References: <0004fb54-cdee-2197-1cbf-6e2111d39ed9@arm.com>
        <20190820105420.7547-1-valentin.schneider@arm.com>
Date:   Thu, 22 Aug 2019 11:48:24 -0700
In-Reply-To: <20190820105420.7547-1-valentin.schneider@arm.com> (Valentin
        Schneider's message of "Tue, 20 Aug 2019 11:54:20 +0100")
Message-ID: <xm26lfvlhw93.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valentin Schneider <valentin.schneider@arm.com> writes:

> Turns out a cfs_rq->runtime_remaining can become positive in
> assign_cfs_rq_runtime(), but this codepath has no call to
> unthrottle_cfs_rq().
>
> This can leave us in a situation where we have a throttled cfs_rq with
> positive ->runtime_remaining, which breaks the math in
> distribute_cfs_runtime(): this function expects a negative value so that
> it may safely negate it into a positive value.
>
> Add the missing unthrottle_cfs_rq(). While at it, add a WARN_ON where
> we expect negative values, and pull in a comment from the mailing list
> that didn't make it in [1].
>
> [1]: https://lkml.kernel.org/r/BANLkTi=NmCxKX6EbDQcJYDJ5kKyG2N1ssw@mail.gmail.com
>
> Cc: <stable@vger.kernel.org>
> Fixes: ec12cb7f31e2 ("sched: Accumulate per-cfs_rq cpu usage and charge against bandwidth")
> Reported-by: Liangyan <liangyan.peng@linux.alibaba.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Having now seen the rest of the thread:

Could you send the repro, as it doesn't seem to have reached lkml, so
that I can confirm my guess as to what's going on?

It seems most likely we throttle during one of the remove-change-adds in
set_cpus_allowed and friends or during the put half of pick_next_task
followed by idle balance to drop the lock. Then distribute races with a
later assign_cfs_rq_runtime so that the account finds runtime in the
cfs_b.

Re clock_task, it's only frozen for the purposes of pelt, not delta_exec

The other possible way to fix this would be to skip assign if throttled,
since the only time it could succeed is if we're racing with a
distribute that will unthrottle use anyways.

The main advantage of that is the risk of screwy behavior due to unthrottling
in the middle of pick_next/put_prev. The disadvantage is that we already
have the lock, if it works we don't need an ipi to trigger a preempt,
etc. (But I think one of the issues is that we may trigger the preempt
on the previous task, not the next, and I'm not 100% sure that will
carry over correctly)



> ---
>  kernel/sched/fair.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1054d2cf6aaa..219ff3f328e5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4385,6 +4385,11 @@ static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq)
>  	return rq_clock_task(rq_of(cfs_rq)) - cfs_rq->throttled_clock_task_time;
>  }
>  
> +static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
> +{
> +	return cfs_bandwidth_used() && cfs_rq->throttled;
> +}
> +
>  /* returns 0 on failure to allocate runtime */
>  static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>  {
> @@ -4411,6 +4416,9 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>  
>  	cfs_rq->runtime_remaining += amount;
>  
> +	if (cfs_rq->runtime_remaining > 0 && cfs_rq_throttled(cfs_rq))
> +		unthrottle_cfs_rq(cfs_rq);
> +
>  	return cfs_rq->runtime_remaining > 0;
>  }
>  
> @@ -4439,11 +4447,6 @@ void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
>  	__account_cfs_rq_runtime(cfs_rq, delta_exec);
>  }
>  
> -static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
> -{
> -	return cfs_bandwidth_used() && cfs_rq->throttled;
> -}
> -
>  /* check whether cfs_rq, or any parent, is throttled */
>  static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
>  {
> @@ -4628,6 +4631,10 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
>  		if (!cfs_rq_throttled(cfs_rq))
>  			goto next;
>  
> +		/* By the above check, this should never be true */
> +		WARN_ON(cfs_rq->runtime_remaining > 0);
> +
> +		/* Pick the minimum amount to return to a positive quota state */
>  		runtime = -cfs_rq->runtime_remaining + 1;
>  		if (runtime > remaining)
>  			runtime = remaining;
