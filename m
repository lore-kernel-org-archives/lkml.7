Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD49C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC812073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfDPT0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:26:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfDPT0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:26:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36603C0578F2;
        Tue, 16 Apr 2019 19:26:47 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE2635D9CA;
        Tue, 16 Apr 2019 19:26:44 +0000 (UTC)
Date:   Tue, 16 Apr 2019 15:26:43 -0400
From:   Phil Auld <pauld@redhat.com>
To:     sashal@kernel.org
Cc:     tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
        mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, bsegall@google.com,
        stable@vger.kernel.org, anton@ozlabs.org
Subject: Re: [tip:sched/urgent] sched/fair: Limit sched_cfs_period_timer()
 loop to avoid hard lockup
Message-ID: <20190416192642.GF17860@pauld.bos.csb>
References: <20190319130005.25492-1-pauld@redhat.com>
 <tip-2e8e19226398db8265a8e675fcc0118b9e80c9e8@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-2e8e19226398db8265a8e675fcc0118b9e80c9e8@git.kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 16 Apr 2019 19:26:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Sasha,

On Tue, Apr 16, 2019 at 08:32:09AM -0700 tip-bot for Phil Auld wrote:
> Commit-ID:  2e8e19226398db8265a8e675fcc0118b9e80c9e8
> Gitweb:     https://git.kernel.org/tip/2e8e19226398db8265a8e675fcc0118b9e80c9e8
> Author:     Phil Auld <pauld@redhat.com>
> AuthorDate: Tue, 19 Mar 2019 09:00:05 -0400
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Tue, 16 Apr 2019 16:50:05 +0200
> 
> sched/fair: Limit sched_cfs_period_timer() loop to avoid hard lockup
> 
> With extremely short cfs_period_us setting on a parent task group with a large
> number of children the for loop in sched_cfs_period_timer() can run until the
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
> Cc: <stable@vger.kernel.org>
> Cc: Anton Blanchard <anton@ozlabs.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lkml.kernel.org/r/20190319130005.25492-1-pauld@redhat.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---

The above commit won't work on the stable trees. Below is an updated version
that will work on v5.0.7, v4.19.34, v4.14.111, v4.9.168, and v4.4.178 with 
increasing offsets. I believe v3.18.138 will require more so that one is not 
included.

There is only a minor change to context, none of actual changes in the patch are
different.


Thanks,
Phil
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 310d0637fe4b..f0380229b6f2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4859,12 +4859,15 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+extern const u64 max_cfs_quota_period;
+
 static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 {
 	struct cfs_bandwidth *cfs_b =
 		container_of(timer, struct cfs_bandwidth, period_timer);
 	int overrun;
 	int idle = 0;
+	int count = 0;
 
 	raw_spin_lock(&cfs_b->lock);
 	for (;;) {
@@ -4872,6 +4875,28 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 		if (!overrun)
 			break;
 
+		if (++count > 3) {
+			u64 new, old = ktime_to_ns(cfs_b->period);
+
+			new = (old * 147) / 128; /* ~115% */
+			new = min(new, max_cfs_quota_period);
+
+			cfs_b->period = ns_to_ktime(new);
+
+			/* since max is 1s, this is limited to 1e9^2, which fits in u64 */
+			cfs_b->quota *= new;
+			cfs_b->quota = div64_u64(cfs_b->quota, old);
+
+			pr_warn_ratelimited(
+        "cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us %lld, cfs_quota_us = %lld)\n",
+	                        smp_processor_id(),
+	                        div_u64(new, NSEC_PER_USEC),
+                                div_u64(cfs_b->quota, NSEC_PER_USEC));
+
+			/* reset count so we don't come right back in here */
+			count = 0;
+		}
+
 		idle = do_sched_cfs_period_timer(cfs_b, overrun);
 	}
 	if (idle)



-- 
