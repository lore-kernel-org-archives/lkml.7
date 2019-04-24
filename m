Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB285C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C19A20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128815;
	bh=UhkwRkpNRM6UA0l163+R/d9YWdPL+JC3yZa0ltqgTAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NP3XmA3dzCWfjyxaYAm+NAJZIhbn61njqzRtG44LQqK1NkzT+LcKWL/SLILou7S6f
	 4kaaX+725DBYbHNVf35UbB2yAYi0RIC8Zg8t7S4exDcgVx2RaxxnW0E7JLQCyoQwHo
	 Nis1J+v1F5jkw7/bWnbroUwphKO5TaAMCmZZu6y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390348AbfDXSAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389306AbfDXRXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:23:24 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B040B21904;
        Wed, 24 Apr 2019 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126603;
        bh=UhkwRkpNRM6UA0l163+R/d9YWdPL+JC3yZa0ltqgTAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VsFrDyg1gE8GTqzX/z3pGbllXVFXlDl20KfcCvpLoVPab83wz4J3X0cG53tUw6yAg
         mZ3QJsHjbAtbOTQK8MGNrtjcrOUkWb4UIaMHsJ/km3RhPQZpiX3lIKETFqZO84Ov8H
         XTnzQW4rQSGTCvvIMyMydvtLhjTs/xrksK+o2j84=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Ben Segall <bsegall@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 165/168] sched/fair: Limit sched_cfs_period_timer() loop to avoid hard lockup
Date:   Wed, 24 Apr 2019 19:10:09 +0200
Message-Id: <20190424170933.059711681@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2e8e19226398db8265a8e675fcc0118b9e80c9e8 ]

With extremely short cfs_period_us setting on a parent task group with a large
number of children the for loop in sched_cfs_period_timer() can run until the
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
Cc: <stable@vger.kernel.org>
Cc: Anton Blanchard <anton@ozlabs.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190319130005.25492-1-pauld@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7671ae95753f..d706cf4fda99 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4016,12 +4016,15 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
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
@@ -4029,6 +4032,28 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
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
2.19.1



