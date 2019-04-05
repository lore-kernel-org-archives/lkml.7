Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D481C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3C721855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDEUzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:55:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37331 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDEUzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:55:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35KtEOb2907717
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 13:55:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35KtDE92907714;
        Fri, 5 Apr 2019 13:55:13 -0700
Date:   Fri, 5 Apr 2019 13:55:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Lezcano <tipbot@zytor.com>
Message-ID: <tip-bfe83844987a52dc1f71f757b60523811502dc93@git.kernel.org>
Cc:     daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190328151336.5316-1-daniel.lezcano@linaro.org>
References: <20190328151336.5316-1-daniel.lezcano@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/timings: Remove variance computation code
Git-Commit-ID: bfe83844987a52dc1f71f757b60523811502dc93
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

Commit-ID:  bfe83844987a52dc1f71f757b60523811502dc93
Gitweb:     https://git.kernel.org/tip/bfe83844987a52dc1f71f757b60523811502dc93
Author:     Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate: Thu, 28 Mar 2019 16:13:35 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 5 Apr 2019 22:51:29 +0200

genirq/timings: Remove variance computation code

The variance computation did not provide the expected results and will be
replaced with a different approach to compute the next interrupt based on
the array suffixes derived algorithm.

There is no good way to transform the variance code to the new algorithm,
so for ease of review remove the existing code first.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: rjw@rjwysocki.net
Cc: ulf.hansson@linaro.org
Cc: linux-pm@vger.kernel.org
Link: https://lkml.kernel.org/r/20190328151336.5316-1-daniel.lezcano@linaro.org

---
 kernel/irq/timings.c | 252 +--------------------------------------------------
 1 file changed, 2 insertions(+), 250 deletions(-)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 1e4cb63a5c82..3cde046a2bc8 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -8,7 +8,6 @@
 #include <linux/interrupt.h>
 #include <linux/idr.h>
 #include <linux/irq.h>
-#include <linux/math64.h>
 
 #include <trace/events/irq.h>
 
@@ -19,13 +18,7 @@ DEFINE_STATIC_KEY_FALSE(irq_timing_enabled);
 DEFINE_PER_CPU(struct irq_timings, irq_timings);
 
 struct irqt_stat {
-	u64	next_evt;
-	u64	last_ts;
-	u64	variance;
-	u32	avg;
-	u32	nr_samples;
-	int	anomalies;
-	int	valid;
+	u64     next_evt;
 };
 
 static DEFINE_IDR(irqt_stats);
@@ -40,184 +33,6 @@ void irq_timings_disable(void)
 	static_branch_disable(&irq_timing_enabled);
 }
 
-/**
- * irqs_update - update the irq timing statistics with a new timestamp
- *
- * @irqs: an irqt_stat struct pointer
- * @ts: the new timestamp
- *
- * The statistics are computed online, in other words, the code is
- * designed to compute the statistics on a stream of values rather
- * than doing multiple passes on the values to compute the average,
- * then the variance. The integer division introduces a loss of
- * precision but with an acceptable error margin regarding the results
- * we would have with the double floating precision: we are dealing
- * with nanosec, so big numbers, consequently the mantisse is
- * negligeable, especially when converting the time in usec
- * afterwards.
- *
- * The computation happens at idle time. When the CPU is not idle, the
- * interrupts' timestamps are stored in the circular buffer, when the
- * CPU goes idle and this routine is called, all the buffer's values
- * are injected in the statistical model continuying to extend the
- * statistics from the previous busy-idle cycle.
- *
- * The observations showed a device will trigger a burst of periodic
- * interrupts followed by one or two peaks of longer time, for
- * instance when a SD card device flushes its cache, then the periodic
- * intervals occur again. A one second inactivity period resets the
- * stats, that gives us the certitude the statistical values won't
- * exceed 1x10^9, thus the computation won't overflow.
- *
- * Basically, the purpose of the algorithm is to watch the periodic
- * interrupts and eliminate the peaks.
- *
- * An interrupt is considered periodically stable if the interval of
- * its occurences follow the normal distribution, thus the values
- * comply with:
- *
- *      avg - 3 x stddev < value < avg + 3 x stddev
- *
- * Which can be simplified to:
- *
- *      -3 x stddev < value - avg < 3 x stddev
- *
- *      abs(value - avg) < 3 x stddev
- *
- * In order to save a costly square root computation, we use the
- * variance. For the record, stddev = sqrt(variance). The equation
- * above becomes:
- *
- *      abs(value - avg) < 3 x sqrt(variance)
- *
- * And finally we square it:
- *
- *      (value - avg) ^ 2 < (3 x sqrt(variance)) ^ 2
- *
- *      (value - avg) x (value - avg) < 9 x variance
- *
- * Statistically speaking, any values out of this interval is
- * considered as an anomaly and is discarded. However, a normal
- * distribution appears when the number of samples is 30 (it is the
- * rule of thumb in statistics, cf. "30 samples" on Internet). When
- * there are three consecutive anomalies, the statistics are resetted.
- *
- */
-static void irqs_update(struct irqt_stat *irqs, u64 ts)
-{
-	u64 old_ts = irqs->last_ts;
-	u64 variance = 0;
-	u64 interval;
-	s64 diff;
-
-	/*
-	 * The timestamps are absolute time values, we need to compute
-	 * the timing interval between two interrupts.
-	 */
-	irqs->last_ts = ts;
-
-	/*
-	 * The interval type is u64 in order to deal with the same
-	 * type in our computation, that prevent mindfuck issues with
-	 * overflow, sign and division.
-	 */
-	interval = ts - old_ts;
-
-	/*
-	 * The interrupt triggered more than one second apart, that
-	 * ends the sequence as predictible for our purpose. In this
-	 * case, assume we have the beginning of a sequence and the
-	 * timestamp is the first value. As it is impossible to
-	 * predict anything at this point, return.
-	 *
-	 * Note the first timestamp of the sequence will always fall
-	 * in this test because the old_ts is zero. That is what we
-	 * want as we need another timestamp to compute an interval.
-	 */
-	if (interval >= NSEC_PER_SEC) {
-		memset(irqs, 0, sizeof(*irqs));
-		irqs->last_ts = ts;
-		return;
-	}
-
-	/*
-	 * Pre-compute the delta with the average as the result is
-	 * used several times in this function.
-	 */
-	diff = interval - irqs->avg;
-
-	/*
-	 * Increment the number of samples.
-	 */
-	irqs->nr_samples++;
-
-	/*
-	 * Online variance divided by the number of elements if there
-	 * is more than one sample.  Normally the formula is division
-	 * by nr_samples - 1 but we assume the number of element will be
-	 * more than 32 and dividing by 32 instead of 31 is enough
-	 * precise.
-	 */
-	if (likely(irqs->nr_samples > 1))
-		variance = irqs->variance >> IRQ_TIMINGS_SHIFT;
-
-	/*
-	 * The rule of thumb in statistics for the normal distribution
-	 * is having at least 30 samples in order to have the model to
-	 * apply. Values outside the interval are considered as an
-	 * anomaly.
-	 */
-	if ((irqs->nr_samples >= 30) && ((diff * diff) > (9 * variance))) {
-		/*
-		 * After three consecutive anomalies, we reset the
-		 * stats as it is no longer stable enough.
-		 */
-		if (irqs->anomalies++ >= 3) {
-			memset(irqs, 0, sizeof(*irqs));
-			irqs->last_ts = ts;
-			return;
-		}
-	} else {
-		/*
-		 * The anomalies must be consecutives, so at this
-		 * point, we reset the anomalies counter.
-		 */
-		irqs->anomalies = 0;
-	}
-
-	/*
-	 * The interrupt is considered stable enough to try to predict
-	 * the next event on it.
-	 */
-	irqs->valid = 1;
-
-	/*
-	 * Online average algorithm:
-	 *
-	 *  new_average = average + ((value - average) / count)
-	 *
-	 * The variance computation depends on the new average
-	 * to be computed here first.
-	 *
-	 */
-	irqs->avg = irqs->avg + (diff >> IRQ_TIMINGS_SHIFT);
-
-	/*
-	 * Online variance algorithm:
-	 *
-	 *  new_variance = variance + (value - average) x (value - new_average)
-	 *
-	 * Warning: irqs->avg is updated with the line above, hence
-	 * 'interval - irqs->avg' is no longer equal to 'diff'
-	 */
-	irqs->variance = irqs->variance + (diff * (interval - irqs->avg));
-
-	/*
-	 * Update the next event
-	 */
-	irqs->next_evt = ts + irqs->avg;
-}
-
 /**
  * irq_timings_next_event - Return when the next event is supposed to arrive
  *
@@ -246,12 +61,6 @@ static void irqs_update(struct irqt_stat *irqs, u64 ts)
  */
 u64 irq_timings_next_event(u64 now)
 {
-	struct irq_timings *irqts = this_cpu_ptr(&irq_timings);
-	struct irqt_stat *irqs;
-	struct irqt_stat __percpu *s;
-	u64 ts, next_evt = U64_MAX;
-	int i, irq = 0;
-
 	/*
 	 * This function must be called with the local irq disabled in
 	 * order to prevent the timings circular buffer to be updated
@@ -259,64 +68,7 @@ u64 irq_timings_next_event(u64 now)
 	 */
 	lockdep_assert_irqs_disabled();
 
-	/*
-	 * Number of elements in the circular buffer: If it happens it
-	 * was flushed before, then the number of elements could be
-	 * smaller than IRQ_TIMINGS_SIZE, so the count is used,
-	 * otherwise the array size is used as we wrapped. The index
-	 * begins from zero when we did not wrap. That could be done
-	 * in a nicer way with the proper circular array structure
-	 * type but with the cost of extra computation in the
-	 * interrupt handler hot path. We choose efficiency.
-	 *
-	 * Inject measured irq/timestamp to the statistical model
-	 * while decrementing the counter because we consume the data
-	 * from our circular buffer.
-	 */
-	for (i = irqts->count & IRQ_TIMINGS_MASK,
-		     irqts->count = min(IRQ_TIMINGS_SIZE, irqts->count);
-	     irqts->count > 0; irqts->count--, i = (i + 1) & IRQ_TIMINGS_MASK) {
-
-		irq = irq_timing_decode(irqts->values[i], &ts);
-
-		s = idr_find(&irqt_stats, irq);
-		if (s) {
-			irqs = this_cpu_ptr(s);
-			irqs_update(irqs, ts);
-		}
-	}
-
-	/*
-	 * Look in the list of interrupts' statistics, the earliest
-	 * next event.
-	 */
-	idr_for_each_entry(&irqt_stats, s, i) {
-
-		irqs = this_cpu_ptr(s);
-
-		if (!irqs->valid)
-			continue;
-
-		if (irqs->next_evt <= now) {
-			irq = i;
-			next_evt = now;
-
-			/*
-			 * This interrupt mustn't use in the future
-			 * until new events occur and update the
-			 * statistics.
-			 */
-			irqs->valid = 0;
-			break;
-		}
-
-		if (irqs->next_evt < next_evt) {
-			irq = i;
-			next_evt = irqs->next_evt;
-		}
-	}
-
-	return next_evt;
+	return 0;
 }
 
 void irq_timings_free(int irq)
