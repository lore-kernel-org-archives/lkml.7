Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196CBC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B25206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfK0PPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:15:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:44296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfK0PPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:15:00 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1A8B20674;
        Wed, 27 Nov 2019 15:14:58 +0000 (UTC)
Date:   Wed, 27 Nov 2019 10:14:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de
Subject: Re: [PATCH] sched/clock: use static_branch_likely() check at
 sched_clock_running
Message-ID: <20191127101456.2c814108@gandalf.local.home>
In-Reply-To: <1574843848-26825-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1574843848-26825-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2019 16:37:28 +0800
Zhenzhong Duan <zhenzhong.duan@oracle.com> wrote:

> sched_clock_running is enabled early at bootup stage and never
> disabled. So hints that to compiler by using static_branch_likely()
> rather than static_branch_unlikely().

Looks like the confusion was the moving of the "!":

-       if (unlikely(!sched_clock_running))
+       if (!static_branch_unlikely(&sched_clock_running))

Where, it was unlikely that !sched_clock_running would be true, but
because the "!" was moved outside the "unlikely()" it makes the test
"likely()". That is, if we added an intermediate step, it would have
been:

	if (!likely(sched_clock_running))

which would have prevented the mistake that this patch fixes.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Fixes: 46457ea464f5 ("sched/clock: Use static key for sched_clock_running")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> ---
>  kernel/sched/clock.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> index 1152259..12bca64 100644
> --- a/kernel/sched/clock.c
> +++ b/kernel/sched/clock.c
> @@ -370,7 +370,7 @@ u64 sched_clock_cpu(int cpu)
>  	if (sched_clock_stable())
>  		return sched_clock() + __sched_clock_offset;
>  
> -	if (!static_branch_unlikely(&sched_clock_running))
> +	if (!static_branch_likely(&sched_clock_running))
>  		return sched_clock();
>  
>  	preempt_disable_notrace();
> @@ -393,7 +393,7 @@ void sched_clock_tick(void)
>  	if (sched_clock_stable())
>  		return;
>  
> -	if (!static_branch_unlikely(&sched_clock_running))
> +	if (!static_branch_likely(&sched_clock_running))
>  		return;
>  
>  	lockdep_assert_irqs_disabled();
> @@ -460,7 +460,7 @@ void __init sched_clock_init(void)
>  
>  u64 sched_clock_cpu(int cpu)
>  {
> -	if (!static_branch_unlikely(&sched_clock_running))
> +	if (!static_branch_likely(&sched_clock_running))
>  		return 0;
>  
>  	return sched_clock();

