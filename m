Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC719C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F1620823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bzlHlTc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfC1PRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:17:04 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:46134 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfC1PRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:17:03 -0400
Received: by mail-wr1-f41.google.com with SMTP id t17so2636249wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 08:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aycm97Plm6qVrne/2MmodSPEzVygGxEgmJGgQsC6tWo=;
        b=bzlHlTc/OWdk4Gtch8116Un4H6phB4eWSXxRgdAAOl0R+KiZj6/XUPS26NrIBL1nml
         9v5Mt9S77mDP0Ul4j6ieUiy23LZ0TaDppVxm13pLUsmy7ROnGIbxQ+RgVBYuVc7hv0WC
         9YbUNgWpgxTnesDA1suyoxiZbzTtDpvHQzmSLlC0bgSVEirF7nzjfknMmS9AAkhADXwl
         /hcwdMUdRu4Mjmn6G1A4RzLjDbTZ6B0J++HvwGQHhmPcPNHZlFLGG5gR/tN/BojlUSfh
         tf4RryMvSwaeRbbFvAimR9XI2Wv5DCm5UC1uWs+HLee5s43MBiVEf0eEtgvJWr4REVZ2
         Drzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aycm97Plm6qVrne/2MmodSPEzVygGxEgmJGgQsC6tWo=;
        b=YnfPbug94upVNlSF/hqLLYjbY/LPgzF25ZtGLvY1m72QvYNuJ8m2bychiz1GQ+zRvs
         K0+c3PmzoAJSKicLsG0XNsH/oWAxZ18bkZ3dOk39pFVPK6yMkCYOkqFKhRpeb/X/Znmc
         cKZplIVLtnPP7R6DhwKGiK4N/boF56B9MzBdm2uiWetVhvcd8d3BAQbgGBfkBzQ+ynzK
         RSlt4BzhSHtFMSRIf0KGUUer2/fYwvRs6jmyrylMUnCqrGUf335WYV/q/VR6aBkl9FUo
         p1GCsPN473O8+34Rw6ebp+izFaWHNP/iQFfVOtNii9+aFsW3iEA5ndfR5gA4Obh+nb3p
         3umQ==
X-Gm-Message-State: APjAAAWcEtlnwFPKCTra9ZcFrTISxlOTj3UjSmjiPqAs5t3uxwRaF4BQ
        BcFczUlb8OTZ270VrPT7wpwUWw==
X-Google-Smtp-Source: APXvYqxDSpTe/uUMsafKh89fkTDgF35JSDMeUnFJLKeik0mO6DzIbJKpKPx9ObDOE2J4hl+MBC5IpA==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr24060739wrw.301.1553786220051;
        Thu, 28 Mar 2019 08:17:00 -0700 (PDT)
Received: from clegane.local (148.127.130.77.rev.sfr.net. [77.130.127.148])
        by smtp.gmail.com with ESMTPSA id c10sm30070094wru.83.2019.03.28.08.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 08:16:59 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     rjw@rjwysocki.net, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] genirq/timings: Remove variance computation code
Date:   Thu, 28 Mar 2019 16:13:35 +0100
Message-Id: <20190328151336.5316-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch will introduce another approach to compute the next
interrupt based on the array suffixes derived algorithm. This one
will replace the variance computation code.

The patch review will be too complex if we change the code little by
little, it is much simpler to remove the variance code and add in the
next patch the suffix array code.

Remove the variance code in timings.c

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/irq/timings.c | 252 +------------------------------------------
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
-- 
2.17.1

