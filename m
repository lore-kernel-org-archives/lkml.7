Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB2BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870F122D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="KpuUUTZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfICNDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:03:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42300 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbfICNDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:03:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id t12so19736194qtp.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 06:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8rs9sV5jz4oBwRMFrobVfTbIAhnmRuYrVcw2V0hyBK8=;
        b=KpuUUTZd7SU5IA+HJujngj0k+2czMnMpq5bMz7TXr1o6NfSf9mWcJ1DyVxVXZXxMiW
         6+GBkE7LgP/03EAQlC0rJ9rivF+Hf/pUTNylpQDvbB5Aywo0tQuVKGGUdvQEMaILmQjh
         KounDll/1de53oPvCEhdT9cecYWAYz97LRwmzaj9KtTP/4qsSb/ct3oV6saoYlS7cqEn
         S887WTCvRHqtcT271h9qSBKEtOVLORzKJrPCIoZcYkIA6N64P0c6SPstNdlSjnQcb0fm
         hpWuqowzoww0wdyk6ugkG0fwjbTYeb2n93QNieV8M6/zNAb1ytsDDddtUgRRCSrzPRxu
         pvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8rs9sV5jz4oBwRMFrobVfTbIAhnmRuYrVcw2V0hyBK8=;
        b=gKgbKrLWp3W0MqCSg74Yvnv+V9suRmsV4cLKSs5fAjKplP1PHrylUv7av1ZFN0y+vt
         MYGbZYQBpJtDGhMz7L101xkno8oUtHtzVy2CsvzH9NIiSihXEUe57+zBu1LLfJkt+PFT
         5ca3CUApMvoGmv+Z0magcHBrzRw5Udq16smtAm2U9PfhNNlXhWS/T6YpFMHM8Ym+1WX5
         n8k3ve882jK5wtb2I8vGoF1jng68Fn8KOIIZ3ccoFF9PUI+9SU61DDwLpcVUOC/Qoj9u
         RqzcbRp0POiBRXHZNZRbk3Jm73x5gcsa4BXDLbpv/wHfbMNUjkHYe+/Xh9nqtmkRL4tb
         w6LQ==
X-Gm-Message-State: APjAAAVBPgEzuh4cvUzdSzU4iw76+VI8XRwn6FMcKAGI7yKQOWSGO/U5
        JoWSRl97YVvT5Ufx+Rbyurhb1Q==
X-Google-Smtp-Source: APXvYqxsJrSjoToBnrsolskXjnGmZCsOCbBu3q5jz9CLd4A6ZvZq5eGjdfPaeCSS24yLTspVM/yPtg==
X-Received: by 2002:ad4:4047:: with SMTP id r7mr15405745qvp.197.1567515809127;
        Tue, 03 Sep 2019 06:03:29 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z5sm5781257qtb.49.2019.09.03.06.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 06:03:28 -0700 (PDT)
Message-ID: <1567515806.5576.41.camel@lca.pw>
Subject: Re: [PATCH -next v2] sched/fair: fix -Wunused-but-set-variable
 warnings
From:   Qian Cai <cai@lca.pw>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     bsegall@google.com, chiluk+linux@indeed.com, pauld@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 03 Sep 2019 09:03:26 -0400
In-Reply-To: <1566326455-8038-1-git-send-email-cai@lca.pw>
References: <1566326455-8038-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo or Peter, please take a look at this trivial patch. Still see the warning
in linux-next every day.

On Tue, 2019-08-20 at 14:40 -0400, Qian Cai wrote:
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
> [1] https://lore.kernel.org/lkml/1558121424-2914-1-git-send-email-chiluk+linux
> @indeed.com/
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v2: Keep hrtimer_forward_now() in start_cfs_bandwidth() per Ben.
> 
>  kernel/sched/fair.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 84959d3285d1..06782491691f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4354,21 +4354,16 @@ static inline u64 sched_cfs_bandwidth_slice(void)
>  }
>  
>  /*
> - * Replenish runtime according to assigned quota and update expiration time.
> - * We use sched_clock_cpu directly instead of rq->clock to avoid adding
> - * additional synchronization around rq->lock.
> + * Replenish runtime according to assigned quota. We use sched_clock_cpu
> + * directly instead of rq->clock to avoid adding additional synchronization
> + * around rq->lock.
>   *
>   * requires cfs_b->lock
>   */
>  void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
>  {
> -	u64 now;
> -
> -	if (cfs_b->quota == RUNTIME_INF)
> -		return;
> -
> -	now = sched_clock_cpu(smp_processor_id());
> -	cfs_b->runtime = cfs_b->quota;
> +	if (cfs_b->quota != RUNTIME_INF)
> +		cfs_b->runtime = cfs_b->quota;
>  }
>  
>  static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
> @@ -4989,15 +4984,13 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>  
>  void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>  {
> -	u64 overrun;
> -
>  	lockdep_assert_held(&cfs_b->lock);
>  
>  	if (cfs_b->period_active)
>  		return;
>  
>  	cfs_b->period_active = 1;
> -	overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
> +	hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
>  	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
>  }
>  
