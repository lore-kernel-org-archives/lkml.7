Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FE2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDE2206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfDCIjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:39:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49111 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfDCIjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:39:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x338cd751774771
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Apr 2019 01:38:40 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x338cd9x1774768;
        Wed, 3 Apr 2019 01:38:39 -0700
Date:   Wed, 3 Apr 2019 01:38:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Phil Auld <tipbot@zytor.com>
Message-ID: <tip-06ec5d30e8d57b820d44df6340dcb25010d6d0fa@git.kernel.org>
Cc:     mingo@kernel.org, pauld@redhat.com, efault@gmx.de,
        tglx@linutronix.de, peterz@infradead.org, anton@ozlabs.org,
        bsegall@google.com, torvalds@linux-foundation.org,
        stable@vger.kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
          hpa@zytor.com, peterz@infradead.org, bsegall@google.com,
          torvalds@linux-foundation.org, anton@ozlabs.org, efault@gmx.de,
          mingo@kernel.org, pauld@redhat.com, tglx@linutronix.de
In-Reply-To: <20190319130005.25492-1-pauld@redhat.com>
References: <20190319130005.25492-1-pauld@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Limit sched_cfs_period_timer loop to
 avoid hard lockup
Git-Commit-ID: 06ec5d30e8d57b820d44df6340dcb25010d6d0fa
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  06ec5d30e8d57b820d44df6340dcb25010d6d0fa
Gitweb:     https://git.kernel.org/tip/06ec5d30e8d57b820d44df6340dcb25010d6d0fa
Author:     Phil Auld <pauld@redhat.com>
AuthorDate: Tue, 19 Mar 2019 09:00:05 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Apr 2019 09:50:23 +0200

sched/fair: Limit sched_cfs_period_timer loop to avoid hard lockup

With extremely short cfs_period_us setting on a parent task group with a large
number of children the for loop in sched_cfs_period_timer can run until the
watchdog fires. There is no guarantee that the call to hrtimer_forward_now()
will ever return 0.  The large number of children can make
do_sched_cfs_period_timer() take longer than the period.

 NMI watchdog: Watchdog detected hard LOCKUP on cpu 24
 RIP: 0010:tg_nop+0x0/0x10
  <IRQ>
  walk_tg_tree_from+0x29/0xb0
  unthrottle_cfs_rq+0xe0/0x1a0
  distribute_cfs_runtime+0xd3/0xf0
  sched_cfs_period_timer+0xcb/0x160
  ? sched_cfs_slack_timer+0xd0/0xd0
  __hrtimer_run_queues+0xfb/0x270
  hrtimer_interrupt+0x122/0x270
  smp_apic_timer_interrupt+0x6a/0x140
  apic_timer_interrupt+0xf/0x20
  </IRQ>

To prevent this we add protection to the loop that detects when the loop has run
too many times and scales the period and quota up, proportionally, so that the timer
can complete before then next period expires.  This preserves the relative runtime
quota while preventing the hard lockup.

A warning is issued reporting this state and the new values.

Signed-off-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Anton Blanchard <anton@ozlabs.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/20190319130005.25492-1-pauld@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 40bd1e27b1b7..d4cce633eac8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4885,6 +4885,8 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+extern const u64 max_cfs_quota_period;
+
 static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 {
 	struct cfs_bandwidth *cfs_b =
@@ -4892,6 +4894,7 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 	unsigned long flags;
 	int overrun;
 	int idle = 0;
+	int count = 0;
 
 	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	for (;;) {
@@ -4899,6 +4902,28 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
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
+			cfs_b->quota /= old;
+
+			pr_warn_ratelimited(
+	"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us %lld, cfs_quota_us = %lld)\n",
+				smp_processor_id(),
+				new/NSEC_PER_USEC,
+				cfs_b->quota/NSEC_PER_USEC);
+
+			/* reset count so we don't come right back in here */
+			count = 0;
+		}
+
 		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
 	}
 	if (idle)
