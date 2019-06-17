Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91351C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574622086A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kh9NuNXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfFQOX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:23:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39945 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQOX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:23:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEMsP63453866
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:22:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEMsP63453866
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560781375;
        bh=JEJJ7kn/hwQkXY4f5Y/l4PcTf9/Ev4XdiNAqxTjQ8Vc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=kh9NuNXlCZAO7vOmNAFOXQD1c9OrH5x48nnKvuK8T+AEw3FOry/ZoWLJO/hOcYWax
         he7Wav6UVAkCdBm1rM4pMYJ8QSIBG6hpMJjenrDJpSxzkDPJnJx5/CtGvUX//xVMi0
         p9aXWtZgpmSD7W6kBljOhi4QZwfnmU0+GofjDpDAhfs+FGf9AE/R0iMryCsOPRw53H
         VdOG/amkvsC4rGCPm62gybilF34gtBbIQAu7n68iGHhzTB5UMLcpQYm34Y/YMSDJXw
         glUCzGA3qMaOLW/KrxTQQBP1p9jyrs/p+k0pBE8EpSk5gMX1mhjcir0gTGtu4Wsc7l
         Q6NuAJL2sALzg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEMsKW3453863;
        Mon, 17 Jun 2019 07:22:54 -0700
Date:   Mon, 17 Jun 2019 07:22:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for bsegall@google.com" <tipbot@zytor.com>
Message-ID: <tip-66567fcbaecac455caa1b13643155d686b51ce63@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, bsegall@google.com, pauld@redhat.com,
        xlpang@linux.alibaba.com
Reply-To: bsegall@google.com, xlpang@linux.alibaba.com, pauld@redhat.com,
          tglx@linutronix.de, hpa@zytor.com, torvalds@linux-foundation.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org
In-Reply-To: <xm26a7euy6iq.fsf_-_@bsegall-linux.svl.corp.google.com>
References: <xm26a7euy6iq.fsf_-_@bsegall-linux.svl.corp.google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Don't push cfs_bandwith slack timers
 forward
Git-Commit-ID: 66567fcbaecac455caa1b13643155d686b51ce63
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

Commit-ID:  66567fcbaecac455caa1b13643155d686b51ce63
Gitweb:     https://git.kernel.org/tip/66567fcbaecac455caa1b13643155d686b51ce63
Author:     bsegall@google.com <bsegall@google.com>
AuthorDate: Thu, 6 Jun 2019 10:21:01 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:16:01 +0200

sched/fair: Don't push cfs_bandwith slack timers forward

When a cfs_rq sleeps and returns its quota, we delay for 5ms before
waking any throttled cfs_rqs to coalesce with other cfs_rqs going to
sleep, as this has to be done outside of the rq lock we hold.

The current code waits for 5ms without any sleeps, instead of waiting
for 5ms from the first sleep, which can delay the unthrottle more than
we want. Switch this around so that we can't push this forward forever.

This requires an extra flag rather than using hrtimer_active, since we
need to start a new timer if the current one is in the process of
finishing.

Signed-off-by: Ben Segall <bsegall@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Xunlei Pang <xlpang@linux.alibaba.com>
Acked-by: Phil Auld <pauld@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/xm26a7euy6iq.fsf_-_@bsegall-linux.svl.corp.google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c  | 7 +++++++
 kernel/sched/sched.h | 8 ++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4c8f45ed093c..3c11dcdedcbc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4729,6 +4729,11 @@ static void start_cfs_slack_bandwidth(struct cfs_bandwidth *cfs_b)
 	if (runtime_refresh_within(cfs_b, min_left))
 		return;
 
+	/* don't push forwards an existing deferred unthrottle */
+	if (cfs_b->slack_started)
+		return;
+	cfs_b->slack_started = true;
+
 	hrtimer_start(&cfs_b->slack_timer,
 			ns_to_ktime(cfs_bandwidth_slack_period),
 			HRTIMER_MODE_REL);
@@ -4782,6 +4787,7 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 
 	/* confirm we're still not at a refresh boundary */
 	raw_spin_lock_irqsave(&cfs_b->lock, flags);
+	cfs_b->slack_started = false;
 	if (cfs_b->distribute_running) {
 		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		return;
@@ -4945,6 +4951,7 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	cfs_b->slack_timer.function = sched_cfs_slack_timer;
 	cfs_b->distribute_running = 0;
+	cfs_b->slack_started = false;
 }
 
 static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 607859a18b2a..b08dee29ef5e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -338,8 +338,10 @@ struct cfs_bandwidth {
 	u64			runtime_expires;
 	int			expires_seq;
 
-	short			idle;
-	short			period_active;
+	u8			idle;
+	u8			period_active;
+	u8			distribute_running;
+	u8			slack_started;
 	struct hrtimer		period_timer;
 	struct hrtimer		slack_timer;
 	struct list_head	throttled_cfs_rq;
@@ -348,8 +350,6 @@ struct cfs_bandwidth {
 	int			nr_periods;
 	int			nr_throttled;
 	u64			throttled_time;
-
-	bool                    distribute_running;
 #endif
 };
 
