Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31210C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DD922D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u2Qd5JFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbfHURgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 13:36:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33380 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfHURgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:36:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so1898228pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 10:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SnrOb5SYSJB7PHh9rIIjU29OS+6dirX9zp8T/0vJeFs=;
        b=u2Qd5JFPCJLu0DEoIws0HZ3gzUbO8j+4tQUhYy9JRCRZvVJbWDps3GHoibcXuxG58K
         uc+bFhB9hh5VAUM/OtQdT9RKIaRY0MkJJKs9oOUFanpet9iWAgubz7hALWoa1t42tq8h
         wvYI/hCjb5UT3omZcQlBUTdk3hGwuUKu2SU/BUxmMur7s/mLMjW/7bqhTiimOM9ijHJI
         UNAbeQ1YLFDv9/Xz9pcdQM+DMxLbun3sShKbVfrqnE4MfxvZSDnypFagDeai2S3nVg1U
         wPiYaEbhlJ0kDQ0TZ6QLoSL7pokJOB4oUGKbRmqv8tMBoXoBDB3uBRU8cAPKFGncYFko
         qeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=SnrOb5SYSJB7PHh9rIIjU29OS+6dirX9zp8T/0vJeFs=;
        b=fwXhRVXwuTOCzAnFg0ta7Y9yF6CKYvchSMstZNzPtzz0bXFzHP9YjeYEZyCxjK5Ohl
         gIggV9cFNr4eVNg8s9BFwcfoaOntQSwii34arAkarHjvw0JiY2mHCD+wtzCMJf0NPOqL
         oXPQVMhGfK3UJNFw4ApEgOVa1ba0nWVGGbFGiLSQU7qqH5txJUfC3gRTSRgSwpt2ZXdQ
         Bjop8PcSuLFKtqxTH+tPDJ0/pcqztG3BY0dhOCy8RkP/ZOjE/FlkX/ANwnh4E/yRgf7D
         pEmnj4NM+Eo8nTU5jbNZJ/dj+T4qcmTKNE8y6PQL6/0PY+sXK0LVu4L7PvmLpkcCpekz
         3Azw==
X-Gm-Message-State: APjAAAWzsFpXRGvGyqnRG1QAFttxafbtORua+MuYW7hscz8fdjJYDQsQ
        L/UuhVDMy4ztmNYc4N0SQXpTwGs/1Zdshg==
X-Google-Smtp-Source: APXvYqxd3yrWpvurkg4nSpE3s7czUI5wSWElMDBHL+INwMjOGPzMJRTLDKQc0lkxoOeFNyFwqeCJ8g==
X-Received: by 2002:a17:90a:bf82:: with SMTP id d2mr1082601pjs.121.1566408975940;
        Wed, 21 Aug 2019 10:36:15 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id r27sm31539142pgn.25.2019.08.21.10.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 10:36:14 -0700 (PDT)
From:   bsegall@google.com
To:     Qian Cai <cai@lca.pw>
Cc:     mingo@redhat.com, peterz@infradead.org, chiluk+linux@indeed.com,
        pauld@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] sched/fair: fix -Wunused-but-set-variable warnings
References: <1566326455-8038-1-git-send-email-cai@lca.pw>
Date:   Wed, 21 Aug 2019 10:36:13 -0700
In-Reply-To: <1566326455-8038-1-git-send-email-cai@lca.pw> (Qian Cai's message
        of "Tue, 20 Aug 2019 14:40:55 -0400")
Message-ID: <xm26tvaaifoy.fsf@bsegall-linux.svl.corp.google.com>
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

Reviewed-by: Ben Segall <bsegall@google.com>

> ---
>
> v2: Keep hrtimer_forward_now() in start_cfs_bandwidth() per Ben.
>
>  kernel/sched/fair.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 84959d3285d1..06782491691f 100644
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
>  
>  static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
> @@ -4989,15 +4984,13 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
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
> +	hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
>  	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
>  }
