Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D132FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1969218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfLQMk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:40:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55284 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbfLQMkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:40:05 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ihC8q-0001pe-Ce; Tue, 17 Dec 2019 13:39:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 36EE71C2A3D;
        Tue, 17 Dec 2019 13:39:52 +0100 (CET)
Date:   Tue, 17 Dec 2019 12:39:52 -0000
From:   "tip-bot2 for Peng Wang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] schied/fair: Skip calculating @contrib without load
Cc:     Peng Wang <rocking@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1576208740-35609-1-git-send-email-rocking@linux.alibaba.com>
References: <1576208740-35609-1-git-send-email-rocking@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <157658639209.30329.5550277285445533985.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d040e0734fb3dedfe24c3d94f5a32b4812eca610
Gitweb:        https://git.kernel.org/tip/d040e0734fb3dedfe24c3d94f5a32b4812eca610
Author:        Peng Wang <rocking@linux.alibaba.com>
AuthorDate:    Fri, 13 Dec 2019 11:45:40 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Dec 2019 13:32:51 +01:00

schied/fair: Skip calculating @contrib without load

Because of the:

	if (!load)
		runnable = running = 0;

clause in ___update_load_sum(), all the actual users of @contrib in
accumulate_sum():

	if (load)
		sa->load_sum += load * contrib;
	if (runnable)
		sa->runnable_load_sum += runnable * contrib;
	if (running)
		sa->util_sum += contrib << SCHED_CAPACITY_SHIFT;

don't happen, and therefore we don't care what @contrib actually is and
calculating it is pointless.

If we count the times when @load equals zero and not as below:

	if (load) {
		load_is_not_zero_count++;
		contrib = __accumulate_pelt_segments(periods,
				1024 - sa->period_contrib,delta);
	} else
		load_is_zero_count++;

As we can see, load_is_zero_count is much bigger than
load_is_zero_count, and the gap is gradually widening:

	load_is_zero_count:            6016044 times
	load_is_not_zero_count:         244316 times
	19:50:43 up 1 min,  1 user,  load average: 0.09, 0.06, 0.02

	load_is_zero_count:            7956168 times
	load_is_not_zero_count:         261472 times
	19:51:42 up 2 min,  1 user,  load average: 0.03, 0.05, 0.01

	load_is_zero_count:           10199896 times
	load_is_not_zero_count:         278364 times
	19:52:51 up 3 min,  1 user,  load average: 0.06, 0.05, 0.01

	load_is_zero_count:           14333700 times
	load_is_not_zero_count:         318424 times
	19:54:53 up 5 min,  1 user,  load average: 0.01, 0.03, 0.00

Perhaps we can gain some performance advantage by saving these
unnecessary calculation.

Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot < vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/1576208740-35609-1-git-send-email-rocking@linux.alibaba.com
---
 kernel/sched/pelt.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index a96db50..bd006b7 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -129,8 +129,20 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
 		 * Step 2
 		 */
 		delta %= 1024;
-		contrib = __accumulate_pelt_segments(periods,
-				1024 - sa->period_contrib, delta);
+		if (load) {
+			/*
+			 * This relies on the:
+			 *
+			 * if (!load)
+			 *	runnable = running = 0;
+			 *
+			 * clause from ___update_load_sum(); this results in
+			 * the below usage of @contrib to dissapear entirely,
+			 * so no point in calculating it.
+			 */
+			contrib = __accumulate_pelt_segments(periods,
+					1024 - sa->period_contrib, delta);
+		}
 	}
 	sa->period_contrib = delta;
 
@@ -205,7 +217,9 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	 * This means that weight will be 0 but not running for a sched_entity
 	 * but also for a cfs_rq if the latter becomes idle. As an example,
 	 * this happens during idle_balance() which calls
-	 * update_blocked_averages()
+	 * update_blocked_averages().
+	 *
+	 * Also see the comment in accumulate_sum().
 	 */
 	if (!load)
 		runnable = running = 0;
