Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9FCC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEB720855
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfDIMsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:48:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbfDIMsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 08:48:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8E143001C86;
        Tue,  9 Apr 2019 12:48:18 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D70416A970;
        Tue,  9 Apr 2019 12:48:17 +0000 (UTC)
Date:   Tue, 9 Apr 2019 08:48:16 -0400
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        bsegall@google.com, torvalds@linux-foundation.org,
        anton@ozlabs.org, efault@gmx.de, mingo@kernel.org,
        tglx@linutronix.de
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/fair: Limit sched_cfs_period_timer loop
 to avoid hard lockup
Message-ID: <20190409124815.GA10132@pauld.bos.csb>
References: <20190319130005.25492-1-pauld@redhat.com>
 <tip-06ec5d30e8d57b820d44df6340dcb25010d6d0fa@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-06ec5d30e8d57b820d44df6340dcb25010d6d0fa@git.kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 09 Apr 2019 12:48:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Peter,

On Wed, Apr 03, 2019 at 01:38:39AM -0700 tip-bot for Phil Auld wrote:
> Commit-ID:  06ec5d30e8d57b820d44df6340dcb25010d6d0fa
> Gitweb:     https://git.kernel.org/tip/06ec5d30e8d57b820d44df6340dcb25010d6d0fa
> Author:     Phil Auld <pauld@redhat.com>
> AuthorDate: Tue, 19 Mar 2019 09:00:05 -0400
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Wed, 3 Apr 2019 09:50:23 +0200

This commit seems to have gotten lost. It's not in tip and now the 
direct gitweb link is also showing bad commit reference. 

Did this fall victim to a reset or something?


Thanks,

Phil


> 
> sched/fair: Limit sched_cfs_period_timer loop to avoid hard lockup
> 
> With extremely short cfs_period_us setting on a parent task group with a large
> number of children the for loop in sched_cfs_period_timer can run until the
> watchdog fires. There is no guarantee that the call to hrtimer_forward_now()
> will ever return 0.  The large number of children can make
> do_sched_cfs_period_timer() take longer than the period.
> 
>  NMI watchdog: Watchdog detected hard LOCKUP on cpu 24
>  RIP: 0010:tg_nop+0x0/0x10
>   <IRQ>
>   walk_tg_tree_from+0x29/0xb0
>   unthrottle_cfs_rq+0xe0/0x1a0
>   distribute_cfs_runtime+0xd3/0xf0
>   sched_cfs_period_timer+0xcb/0x160
>   ? sched_cfs_slack_timer+0xd0/0xd0
>   __hrtimer_run_queues+0xfb/0x270
>   hrtimer_interrupt+0x122/0x270
>   smp_apic_timer_interrupt+0x6a/0x140
>   apic_timer_interrupt+0xf/0x20
>   </IRQ>
> 
> To prevent this we add protection to the loop that detects when the loop has run
> too many times and scales the period and quota up, proportionally, so that the timer
> can complete before then next period expires.  This preserves the relative runtime
> quota while preventing the hard lockup.
> 
> A warning is issued reporting this state and the new values.
> 
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Anton Blanchard <anton@ozlabs.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Mike Galbraith <efault@gmx.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: <stable@vger.kernel.org>
> Link: https://lkml.kernel.org/r/20190319130005.25492-1-pauld@redhat.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/sched/fair.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 40bd1e27b1b7..d4cce633eac8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4885,6 +4885,8 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
>  	return HRTIMER_NORESTART;
>  }
>  
> +extern const u64 max_cfs_quota_period;
> +
>  static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  {
>  	struct cfs_bandwidth *cfs_b =
> @@ -4892,6 +4894,7 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  	unsigned long flags;
>  	int overrun;
>  	int idle = 0;
> +	int count = 0;
>  
>  	raw_spin_lock_irqsave(&cfs_b->lock, flags);
>  	for (;;) {
> @@ -4899,6 +4902,28 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>  		if (!overrun)
>  			break;
>  
> +		if (++count > 3) {
> +			u64 new, old = ktime_to_ns(cfs_b->period);
> +
> +			new = (old * 147) / 128; /* ~115% */
> +			new = min(new, max_cfs_quota_period);
> +
> +			cfs_b->period = ns_to_ktime(new);
> +
> +			/* since max is 1s, this is limited to 1e9^2, which fits in u64 */
> +			cfs_b->quota *= new;
> +			cfs_b->quota /= old;
> +
> +			pr_warn_ratelimited(
> +	"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us %lld, cfs_quota_us = %lld)\n",
> +				smp_processor_id(),
> +				new/NSEC_PER_USEC,
> +				cfs_b->quota/NSEC_PER_USEC);
> +
> +			/* reset count so we don't come right back in here */
> +			count = 0;
> +		}
> +
>  		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
>  	}
>  	if (idle)

-- 
