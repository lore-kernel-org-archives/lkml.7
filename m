Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160C3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 20:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13B42173E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 20:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huT97VPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404409AbfHWUAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 16:00:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40522 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403768AbfHWUAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 16:00:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so6326565pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=q5hCNWmuFRqUpgzAusy3QlIl24Uhrc1t1PhVr0FXqic=;
        b=huT97VPn2PYKYmr2xcn7IY3JM0O0RXwEGiPTUWSOOx3QCX0aDdFp15Jo5TbRCuzLxR
         aAv9K8s0vCLiZCcznIwvhtKG2qFIsxYjEN/xbLg8hPSx969ehlvWioXLUqOP1h865gzp
         eCYeQVTOmE56LsN68b+gH77N/p6s20vFurSIfDb8Itm0gYJXfqQdSMIhv3E5igV+03nn
         jK2EFocrbWf39WrnO+7QlUygYIWU3OnGAEY3Tu0l7RvUi48BEtQ7fWshymtj+pw9yDjL
         OMQZOfNdAiigDbP1KJCnSCMZRTVxxwvBTXcAtzGhrF+OdAbtuKBvz1NI/OZFF/qYEqfr
         GOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=q5hCNWmuFRqUpgzAusy3QlIl24Uhrc1t1PhVr0FXqic=;
        b=jcZNaIuLRVCQoVUOROnrcpOEnD+oSxcvnlz2XgfikojUJ690kTjuElidBb97uzb2cH
         /yn73A8gByG5M5agMC+DRTKiG6wpgi3x1Yrv+xE59uXSuqQaCS9iPaXzfFf8YKTRwe2b
         Nd1LprROb/MEGFlcU8IVdzNqJtVfJ/rg51LuXpb0gTGgu66l6OHzXkXmdQD0krAQkXy+
         /k3n+QEL+hjM9YJRmejKwzyPvCmF0ObsKIyMYH7WsyrwQvPWtLOo7ZJQDIM8Qy9KQOWh
         8bT1EafuaKD+DDRmLUUWzYl2902EsQaICbKTgmB14yB8QUodtT2xgUUuf/22sOXK39L0
         dJaQ==
X-Gm-Message-State: APjAAAUsKuc5FlUTtndq0qOuyaRZKU4gnEGZZP36i4021v4DXgWY1M0R
        rzn61xfGhqNmeZRrBwq7AvyjVg==
X-Google-Smtp-Source: APXvYqwh5S1SS//KgWADX5JFH89HHbvxamv59gzqAF3717qs3u0Ty+ezBNwx0A/+2twKCoHLaOGXUw==
X-Received: by 2002:a63:eb56:: with SMTP id b22mr5554435pgk.355.1566590445173;
        Fri, 23 Aug 2019 13:00:45 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id k5sm3070431pjl.32.2019.08.23.13.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 13:00:44 -0700 (PDT)
From:   bsegall@google.com
To:     Liangyan <liangyan.peng@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, shanpeic@linux.alibaba.com,
        xlpang@linux.alibaba.com
Subject: Re: [PATCH] sched/fair: don't assign runtime for throttled cfs_rq
References: <20190814180021.165389-1-liangyan.peng@linux.alibaba.com>
Date:   Fri, 23 Aug 2019 13:00:43 -0700
In-Reply-To: <20190814180021.165389-1-liangyan.peng@linux.alibaba.com>
        (Liangyan's message of "Thu, 15 Aug 2019 02:00:21 +0800")
Message-ID: <xm26d0gvirdg.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liangyan <liangyan.peng@linux.alibaba.com> writes:

> do_sched_cfs_period_timer() will refill cfs_b runtime and call
> distribute_cfs_runtime() to unthrottle cfs_rq, sometimes cfs_b->runtime
> will allocate all quota to one cfs_rq incorrectly.
> This will cause other cfs_rq can't get runtime and will be throttled.
> We find that one throttled cfs_rq has non-negative
> cfs_rq->runtime_remaining and cause an unexpetced cast from s64 to u64
> in snippet: distribute_cfs_runtime() {
> runtime = -cfs_rq->runtime_remaining + 1; }.
> This cast will cause that runtime will be a large number and
> cfs_b->runtime will be subtracted to be zero at last.
>
> This commit prevents cfs_rq to be assgined new runtime if it has been
> throttled to avoid the above incorrect type cast.
>
> Signed-off-by: Liangyan <liangyan.peng@linux.alibaba.com>

Could you mention in the message that this a throttled cfs_rq can have
account_cfs_rq_runtime called on it because it is throttled before
idle_balance, and the idle_balance calls update_rq_clock to add time
that is accounted to the task.

I think this solution is less risky than unthrottling
in this area, so other than that:

Reviewed-by: Ben Segall <bsegall@google.com>


> ---
>  kernel/sched/fair.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 81fd8a2a605b..b14d67d28138 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4068,6 +4068,8 @@ static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
>  	if (likely(cfs_rq->runtime_remaining > 0))
>  		return;
>  
> +	if (cfs_rq->throttled)
> +		return;
>  	/*
>  	 * if we're unable to extend our runtime we resched so that the active
>  	 * hierarchy can be throttled
