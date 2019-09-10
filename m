Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7519CC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 20:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB922168B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 20:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="SBDpDnVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfIJU6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 16:58:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44920 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfIJU6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 16:58:06 -0400
Received: by mail-qk1-f195.google.com with SMTP id i78so18530580qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 13:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KYFhv9bMRfcvUBHNAof2AFYDxJfGsK1ZyovdXaHUiLo=;
        b=SBDpDnVVvq1VmEXJpj059aHElpbOMJtMbWNNs7k6QDrk6XCa7yP6pKOobs4yeh98X5
         36Hk0QWYoE3LN01/Mshpx9Zc2DZAbiqYXIImiRdp4RNVW4/45kYFB0OxujOIbklCKPUY
         gveJ8dh5WlSGvoNlPgvvJ58hWWH1IinL+Kff6wkRRR3U0+rwQWL/31TCWsTSRYt2lFTC
         O1x9DY9/0bMQFx03a3OXB+WqKkRRmdvicyUCXiK70hRMHltTBLxmUn2Npi4WLoEvFywn
         OsCrYy00B7oVcbBhOvFbJ1Hn3s2lmATA+BwrQcEOn1YFU7t/FfRcUVgSN4h4L9SY1wvt
         MSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KYFhv9bMRfcvUBHNAof2AFYDxJfGsK1ZyovdXaHUiLo=;
        b=nPexPzyEP5fpQPX8UV4Kn8e+P3Zjvqb9xL/WKpbyfnAIPIgDnsXRSal+qvXFFGBjHB
         Ue8izLUtF/4F1EbW2vKl3Xre2XabrIhPzqa0M21PiCg3ISiDelnH0BIP8hyEzKDtebUz
         XE+CVGdjPZG9afpyrN3v2KAJkAmTSSp9BSomiqXc8Z4+OmEoFpetWBgRlBhYHaLZ6Lq1
         /7Kj/3GEuDxdJUadB3KX346UMGb6UIgBiLxpNIUbS6aTPG04s4NrvHz90jmYs9aLlVyN
         wb1pDj8lexdZGmO2violqwWc1mbCWwBM8wK0+oXmQe99KItG6Q7lqngeOYsXrldeFqRy
         K9CA==
X-Gm-Message-State: APjAAAXn4p0kbJYR66+FQpGXJQI+MkPM6JdQYCdHPo8GnIFA+IxnLv/u
        iQb7xcqckI1R3Fsuy/mhI1R4Dg==
X-Google-Smtp-Source: APXvYqxgYngqTRdEQRqPw0xdg2YUzduErdUjn74RnRnW8f5ZOTQSNS9iz6A2x8T8MWdCE1LICAYbFQ==
X-Received: by 2002:ae9:e00a:: with SMTP id m10mr33234934qkk.167.1568149084459;
        Tue, 10 Sep 2019 13:58:04 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v12sm5536512qtb.5.2019.09.10.13.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 13:58:03 -0700 (PDT)
Message-ID: <1568149081.5576.136.camel@lca.pw>
Subject: Re: [PATCH -next v2] sched/fair: fix -Wunused-but-set-variable
 warnings
From:   Qian Cai <cai@lca.pw>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, bsegall@google.com, chiluk+linux@indeed.com,
        pauld@redhat.com, linux-kernel@vger.kernel.org
Date:   Tue, 10 Sep 2019 16:58:01 -0400
In-Reply-To: <20190903141554.GS2349@hirez.programming.kicks-ass.net>
References: <1566326455-8038-1-git-send-email-cai@lca.pw>
         <1567515806.5576.41.camel@lca.pw>
         <20190903141554.GS2349@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-03 at 16:15 +0200, Peter Zijlstra wrote:
> On Tue, Sep 03, 2019 at 09:03:26AM -0400, Qian Cai wrote:
> > Ingo or Peter, please take a look at this trivial patch. Still see the warning
> > in linux-next every day.
> > 
> > On Tue, 2019-08-20 at 14:40 -0400, Qian Cai wrote:
> > > The linux-next commit "sched/fair: Fix low cpu usage with high
> > > throttling by removing expiration of cpu-local slices" [1] introduced a
> > > few compilation warnings,
> > > 
> > > kernel/sched/fair.c: In function '__refill_cfs_bandwidth_runtime':
> > > kernel/sched/fair.c:4365:6: warning: variable 'now' set but not used
> > > [-Wunused-but-set-variable]
> > > kernel/sched/fair.c: In function 'start_cfs_bandwidth':
> > > kernel/sched/fair.c:4992:6: warning: variable 'overrun' set but not used
> > > [-Wunused-but-set-variable]
> > > 
> > > Also, __refill_cfs_bandwidth_runtime() does no longer update the
> > > expiration time, so fix the comments accordingly.
> > > 
> > > [1] https://lore.kernel.org/lkml/1558121424-2914-1-git-send-email-chiluk+linux
> > > @indeed.com/
> > > 
> > > Signed-off-by: Qian Cai <cai@lca.pw>
> 
> Rewrote the Changelog like so:

Looks good. I suppose it still need Ingo to pick it up, as today's tip/auto-
latest still show those warnings.

> 
> ---
> Subject: sched/fair: Fix -Wunused-but-set-variable warnings
> From: Qian Cai <cai@lca.pw>
> Date: Tue, 20 Aug 2019 14:40:55 -0400
> 
> Commit de53fd7aedb1 ("sched/fair: Fix low cpu usage with high
> throttling by removing expiration of cpu-local slices") introduced a
> few compilation warnings:
> 
>   kernel/sched/fair.c: In function '__refill_cfs_bandwidth_runtime':
>   kernel/sched/fair.c:4365:6: warning: variable 'now' set but not used [-Wunused-but-set-variable]
>   kernel/sched/fair.c: In function 'start_cfs_bandwidth':
>   kernel/sched/fair.c:4992:6: warning: variable 'overrun' set but not used [-Wunused-but-set-variable]
> 
> Also, __refill_cfs_bandwidth_runtime() does no longer update the
> expiration time, so fix the comments accordingly.
> 
> Fixes: de53fd7aedb1 ("sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices")
> Signed-off-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ben Segall <bsegall@google.com>
> Reviewed-by: Dave Chiluk <chiluk+linux@indeed.com>
> Cc: mingo@redhat.com
> Cc: pauld@redhat.com
> Link: https://lkml.kernel.org/r/1566326455-8038-1-git-send-email-cai@lca.pw
> ---
>  kernel/sched/fair.c |   19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4386,21 +4386,16 @@ static inline u64 sched_cfs_bandwidth_sl
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
> @@ -5021,15 +5016,13 @@ static void init_cfs_rq_runtime(struct c
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
>  
