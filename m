Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDBDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4142081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MiEPa9ly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfCHVVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:21:19 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:42771 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfCHVVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:21:09 -0500
Received: by mail-wr1-f51.google.com with SMTP id r5so22802104wrg.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 13:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gFJMY0WOgzgIBhILE7R53AVVhKFuuRS1lwFXIQdyPQ0=;
        b=MiEPa9ly9rhL7wEcaJWsqBCN70885jx0dRT6i1Ii+/yyKY+1/CxRZueWogFrqZH0tj
         R8yU9ISl+4xsdP+DO3ABr3JSt9MlhdDzRKg6rzw3azl/uCxXGa9EWCB5Su9DLBSBTXBT
         4t0WcS7h3pmT8QWvJAoLea7FRLohnN9gKYlY68jxFTqvLu/MysR+yPKaxkDYW5D2KpZf
         AzY08xX1RUiPXgcp8KwOk+me7Wm/YArSh2MtsbETnUGM1seNyIsnWLjzN59x80N4SAPv
         5EX2P0b1B+uGKK4VFbGs1sr89x9kgrSzTRAzsSv55f8dscFOiDxiduCxqOtFqy0YdleG
         rQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gFJMY0WOgzgIBhILE7R53AVVhKFuuRS1lwFXIQdyPQ0=;
        b=oDBv8D+0ljPdLqjURwvhonPlqPuHiNhsYgs+iZjfX8tvaO6MykkfVfkKUDoibpJimI
         MKYP0nqwHCtBzU9yABmfB0tcQBYhiT2WRu++vbEz4r8VzoJ2kgXJUaQHatnimONvLg8z
         u1g53JdOvujtGh9WyAnZz9/gi4kfHy9t5On79Fbo4S9/5W7URwshw5f+rr2m2i7Z3iLV
         iYIt1rvK/fL6C/xyDEIniaEcm8b+J76ehoI8sthZxvPwAw2vXkp8Z7978Kje+Iroigqb
         5W1QkWM4phhsiTP32xepoJMfvfd3o0HFDPYOEx2oVY4bn32+Pf/l2Y3oc6G/ZFzfNo6A
         oNfg==
X-Gm-Message-State: APjAAAWLThdR/jPX0j8dzs+jj8MOqGyKOOi9r5PBEhKJkL5UEy66nn5G
        yX2HGXw3kv83uTOVxy71ptxs+A==
X-Google-Smtp-Source: APXvYqwljAxyM9X75eaE1vlF4Rf7n8ikonPyoAwIT5ePZ6643NUA//wxfG/xfeqG2YRj5EVPQ0J1iA==
X-Received: by 2002:adf:e548:: with SMTP id z8mr12774066wrm.52.1552080066096;
        Fri, 08 Mar 2019 13:21:06 -0800 (PST)
Received: from clegane.local (246.127.130.77.rev.sfr.net. [77.130.127.246])
        by smtp.gmail.com with ESMTPSA id d2sm13568507wrq.94.2019.03.08.13.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 13:21:05 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net, tglx@linutronix.de
Cc:     ulf.hansson@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] genirq/timings: Add array suffix computation code
Date:   Fri,  8 Mar 2019 22:20:46 +0100
Message-Id: <20190308212047.28767-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190308212047.28767-1-daniel.lezcano@linaro.org>
References: <20190308212047.28767-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous variance was discarding values from the timings when they
were considered as anomalies as stated by the normal law statistical
model.

However in the interrupt life, we can have multiple anomalies due to
the nature of the device generating the interrupts, and most of the
time we can observe a repeating pattern, that is particulary true for
network, console, MMC or SSD devices.

With the variance approach, we miss the patterns and we can only deal with the
interrupt coming in regular intervals.

After a long investigation, this patch provides the array suffixes
derived algorithm where we can detect regular and repeating patterns
interrupt events.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/irq/timings.c | 432 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 427 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 3cde046a2bc8..f88465563bd8 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -8,6 +8,8 @@
 #include <linux/interrupt.h>
 #include <linux/idr.h>
 #include <linux/irq.h>
+#include <linux/math64.h>
+#include <linux/log2.h>
 
 #include <trace/events/irq.h>
 
@@ -17,10 +19,6 @@ DEFINE_STATIC_KEY_FALSE(irq_timing_enabled);
 
 DEFINE_PER_CPU(struct irq_timings, irq_timings);
 
-struct irqt_stat {
-	u64     next_evt;
-};
-
 static DEFINE_IDR(irqt_stats);
 
 void irq_timings_enable(void)
@@ -33,6 +31,381 @@ void irq_timings_disable(void)
 	static_branch_disable(&irq_timing_enabled);
 }
 
+/*
+ * The main goal of this algorithm is to predict the next interrupt
+ * occurrence on the current CPU.
+ *
+ * Currently, the interrupt timings are stored in a circular array
+ * buffer every time there is an interrupt, as a tuple: the interrupt
+ * number and the associated timestamp when the event occurred <irq,
+ * timestamp>.
+ *
+ * For every interrupt occurring in a short period of time, we can
+ * measure the elapsed time between the occurrences for the same
+ * interrupt and we end up with a suite of intervals. The experience
+ * showed the interrupts are often coming following a periodic
+ * pattern.
+ *
+ * The objective of the algorithm is to find out this periodic pattern
+ * in a fastest way and use its period to predict the next irq event.
+ *
+ * When the next interrupt event is requested, we are in the situation
+ * where the interrupts are disabled and the circular buffer
+ * containing the timings is filled with the events which happened
+ * after the previous next-interrupt-event request.
+ *
+ * At this point, we read the circular buffer and we fill the irq
+ * related statistics structure. After this step, the circular array
+ * containing the timings is empty because all the values are
+ * dispatched in their corresponding buffers.
+ *
+ * Now for each interrupt, we can predict the next event by using the
+ * suffix array, log interval and exponential moving average
+ *
+ * 1. Suffix array
+ *
+ * Suffix array is an array of all the suffixes of a string. It is
+ * widely used as a data structure for compression, text search, ...
+ * For instance for the word 'banana', the suffixes will be: 'banana'
+ * 'anana' 'nana' 'ana' 'na' 'a'
+ *
+ * Usually, the suffix array is sorted but for our purpose it is
+ * not necessary and won't provide any improvement in the context of
+ * the solved problem where we clearly define the boundaries of the
+ * search by a max period and min period.
+ *
+ * The suffix array will build a suite of intervals of different
+ * length and will look for the repetition of each suite. If the suite
+ * is repeating then we have the period because it is the length of
+ * the suite whatever its position in the buffer.
+ *
+ * 2. Log interval
+ *
+ * We saw the irq timings allow to compute the interval of the
+ * occurrences for a specific interrupt. We can reasonibly assume the
+ * longer is the interval, the higher is the error for the next event
+ * and we can consider storing those interval values into an array
+ * where each slot in the array correspond to an interval at the power
+ * of 2 of the index. For example, index 12 will contain values
+ * between 2^11 and 2^12.
+ *
+ * At the end we have an array of values where at each index defines a
+ * [2^index - 1, 2 ^ index] interval values allowing to store a large
+ * number of values inside a small array.
+ *
+ * For example, if we have the value 1123, then we store it at
+ * ilog2(1123) = 10 index value.
+ *
+ * Storing those value at the specific index is done by computing an
+ * exponential moving average for this specific slot. For instance,
+ * for values 1800, 1123, 1453, ... fall under the same slot (10) and
+ * the exponential moving average is computed every time a new value
+ * is stored at this slot.
+ *
+ * 3. Exponential Moving Average
+ *
+ * The EMA is largely used to track a signal for stocks or as a low
+ * pass filter. The magic of the formula, is it is very simple and the
+ * reactivity of the average can be tuned with the factors called
+ * alpha.
+ *
+ * The higher the alphas are, the faster the average respond to the
+ * signal change. In our case, if a slot in the array is a big
+ * interval, we can have numbers with a big difference between
+ * them. The impact of those differences in the average computation
+ * can be tuned by changing the alpha value.
+ *
+ *
+ *  -- The algorithm --
+ *
+ * We saw the different processing above, now let's see how they are
+ * used together.
+ *
+ * For each interrupt:
+ *	For each interval:
+ *		Compute the index = ilog2(interval)
+ *		Compute a new_ema(buffer[index], interval)
+ *		Store the index in a circular buffer
+ *
+ *	Compute the suffix array of the indexes
+ *
+ *	For each suffix:
+ *		If the suffix is reverse-found 3 times
+ *			Return suffix
+ *
+ *	Return Not found
+ *
+ * However we can not have endless suffix array to be build, it won't
+ * make sense and it will add an extra overhead, so we can restrict
+ * this to a maximum suffix length of 5 and a minimum suffix length of
+ * 2. The experience showed 5 is the majority of the maximum pattern
+ * period found for different devices.
+ *
+ * The result is a pattern finding less than 1us for an interrupt.
+ *
+ * Example based on real values:
+ *
+ * Example 1 : MMC write/read interrupt interval:
+ *
+ *	223947, 1240, 1384, 1386, 1386,
+ *	217416, 1236, 1384, 1386, 1387,
+ *	214719, 1241, 1386, 1387, 1384,
+ *	213696, 1234, 1384, 1386, 1388,
+ *	219904, 1240, 1385, 1389, 1385,
+ *	212240, 1240, 1386, 1386, 1386,
+ *	214415, 1236, 1384, 1386, 1387,
+ *	214276, 1234, 1384, 1388, ?
+ *
+ * For each element, apply ilog2(value)
+ *
+ *	15, 8, 8, 8, 8,
+ *	15, 8, 8, 8, 8,
+ *	15, 8, 8, 8, 8,
+ *	15, 8, 8, 8, 8,
+ *	15, 8, 8, 8, 8,
+ *	15, 8, 8, 8, 8,
+ *	15, 8, 8, 8, 8,
+ *	15, 8, 8, 8, ?
+ *
+ * Max period of 5, we take the last (max_period * 3) 15 elements as
+ * we can be confident if the pattern repeats itself three times it is
+ * a repeating pattern.
+ *
+ *	             8,
+ *	15, 8, 8, 8, 8,
+ *	15, 8, 8, 8, 8,
+ *	15, 8, 8, 8, ?
+ *
+ * Suffixes are:
+ *
+ *  1) 8, 15, 8, 8, 8  <- max period
+ *  2) 8, 15, 8, 8
+ *  3) 8, 15, 8
+ *  4) 8, 15
+ *
+ * From there we search the repeating pattern for each suffix.
+ *
+ * buffer: 8, 15, 8, 8, 8, 8, 15, 8, 8, 8, 8, 15, 8, 8, 8
+ *         |   |  |  |  |  |   |  |  |  |  |   |  |  |  |
+ *         8, 15, 8, 8, 8  |   |  |  |  |  |   |  |  |  |
+ *                         8, 15, 8, 8, 8  |   |  |  |  |
+ *                                         8, 15, 8, 8, 8
+ *
+ * When moving the suffix, we found exactly 3 matches.
+ *
+ * The first suffix with period 5 is repeating.
+ *
+ * The next event is (3 * max_period) % suffix_period
+ *
+ * In this example, the result 0, so the next event is suffix[0] => 8
+ *
+ * However, 8 is the index in the array of exponential moving average
+ * which was calculated on the fly when storing the values, so the
+ * interval is ema[8] = 1366
+ *
+ *
+ * Example 2:
+ *
+ *	4, 3, 5, 100,
+ *	3, 3, 5, 117,
+ *	4, 4, 5, 112,
+ *	4, 3, 4, 110,
+ *	3, 5, 3, 117,
+ *	4, 4, 5, 112,
+ *	4, 3, 4, 110,
+ *	3, 4, 5, 112,
+ *	4, 3, 4, 110
+ *
+ * ilog2
+ *
+ *	0, 0, 0, 4,
+ *	0, 0, 0, 4,
+ *	0, 0, 0, 4,
+ *	0, 0, 0, 4,
+ *	0, 0, 0, 4,
+ *	0, 0, 0, 4,
+ *	0, 0, 0, 4,
+ *	0, 0, 0, 4,
+ *	0, 0, 0, 4
+ *
+ * Max period 5:
+ *	   0, 0, 4,
+ *	0, 0, 0, 4,
+ *	0, 0, 0, 4,
+ *	0, 0, 0, 4
+ *
+ * Suffixes:
+ *
+ *  1) 0, 0, 4, 0, 0
+ *  2) 0, 0, 4, 0
+ *  3) 0, 0, 4
+ *  4) 0, 0
+ *
+ * buffer: 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4
+ *         |  |  |  |  |  |  X
+ *         0, 0, 4, 0, 0, |  X
+ *                        0, 0
+ *
+ * buffer: 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0, 4
+ *         |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
+ *         0, 0, 4, 0, |  |  |  |  |  |  |  |  |  |  |
+ *                     0, 0, 4, 0, |  |  |  |  |  |  |
+ *                                 0, 0, 4, 0, |  |  |
+ *                                             0  0  4
+ *
+ * Pattern is found 3 times, the remaining is 1 which results from
+ * (max_period * 3) % suffix_period. This value is the index in the
+ * suffix arrays. The suffix array for a period 4 has the value 4
+ * at index 1.
+ */
+#define EMA_ALPHA_VAL		64
+#define EMA_ALPHA_SHIFT		7
+
+#define PREDICTION_PERIOD_MIN	2
+#define PREDICTION_PERIOD_MAX	5
+#define PREDICTION_FACTOR	4
+#define PREDICTION_MAX		10 /* 2 ^ PREDICTION_MAX useconds */
+#define PREDICTION_BUFFER_SIZE	16 /* slots for EMAs, hardly more than 16 */
+
+struct irqt_stat {
+	u64	last_ts;
+	int	ema_time[PREDICTION_BUFFER_SIZE];
+	int	timings[IRQ_TIMINGS_SIZE];
+	int	circ_timings[IRQ_TIMINGS_SIZE];
+	int	count;
+};
+
+/*
+ * Exponential moving average computation
+ */
+static int irq_timings_ema_new(s64 value, s64 ema_old)
+{
+	if (likely(ema_old))
+		return ema_old + (((value - ema_old) * EMA_ALPHA_VAL) >>
+				  EMA_ALPHA_SHIFT);
+	return value;
+}
+
+static int irq_timings_next_event_index(int *buffer, size_t len, int period_max)
+{
+	int i;
+
+	for (i = period_max; i >= PREDICTION_PERIOD_MIN ; i--) {
+
+		int *begin = &buffer[len - (i * 3)];
+		int *ptr = begin;
+
+		while (!memcmp(ptr, begin, i * sizeof(*ptr))) {
+			ptr += i;
+			if (ptr >= &buffer[len])
+				return begin[((i * 3) % i)];
+		}
+	}
+
+	return -1;
+}
+
+static u64 __irq_timings_next_event(struct irqt_stat *irqs, int irq, u64 now)
+{
+	int index, i;
+	int period_max;
+	int count, start;
+	int min = INT_MAX;
+
+	if ((now - irqs->last_ts) >= NSEC_PER_SEC) {
+		irqs->count = irqs->last_ts = 0;
+		return U64_MAX;
+	}
+
+	period_max = irqs->count > (3 * PREDICTION_PERIOD_MAX) ?
+		PREDICTION_PERIOD_MAX : irqs->count / 3;
+
+	if (period_max <= PREDICTION_PERIOD_MIN)
+		return U64_MAX;
+
+	/*
+	 * 'count' will depends if the circular buffer wrapped or not
+	 */
+	count = irqs->count < IRQ_TIMINGS_SIZE ?
+		irqs->count : IRQ_TIMINGS_SIZE;
+
+	start = irqs->count < IRQ_TIMINGS_SIZE ?
+		0 : (irqs->count & IRQ_TIMINGS_MASK);
+
+	/*
+	 * Copy the content of the circular buffer into another buffer
+	 * in order to linearize the buffer instead of dealing with
+	 * wrapping indexes and shifted array which will be prone to
+	 * error and extremelly difficult to debug.
+	 */
+	for (i = 0; i < count; i++) {
+		irqs->timings[i] = irqs->circ_timings[(start + i) &
+						      IRQ_TIMINGS_MASK];
+		min = min_t(int, irqs->timings[i], min);
+	}
+
+	index = irq_timings_next_event_index(irqs->timings, count, period_max);
+	if (index < 0)
+		return irqs->last_ts + min;
+
+	return irqs->last_ts + irqs->ema_time[index];
+}
+
+static inline void irq_timings_store(int irq, struct irqt_stat *irqs, u64 ts)
+{
+	u64 old_ts = irqs->last_ts;
+	u64 interval;
+	int index;
+
+	/*
+	 * The timestamps are absolute time values, we need to compute
+	 * the timing interval between two interrupts.
+	 */
+	irqs->last_ts = ts;
+
+	/*
+	 * The interval type is u64 in order to deal with the same
+	 * type in our computation, that prevent mindfuck issues with
+	 * overflow, sign and division.
+	 */
+	interval = ts - old_ts;
+
+	/*
+	 * The interrupt triggered more than one second apart, that
+	 * ends the sequence as predictible for our purpose. In this
+	 * case, assume we have the beginning of a sequence and the
+	 * timestamp is the first value. As it is impossible to
+	 * predict anything at this point, return.
+	 *
+	 * Note the first timestamp of the sequence will always fall
+	 * in this test because the old_ts is zero. That is what we
+	 * want as we need another timestamp to compute an interval.
+	 */
+	if (interval >= NSEC_PER_SEC) {
+		irqs->count = 0;
+		return;
+	}
+
+	/*
+	 * Get the index in the ema table for this interrupt. The
+	 * PREDICTION_FACTOR increase the interval size for the array
+	 * of exponential average.
+	 */
+	index = likely(interval) ?
+		ilog2((interval >> 10) / PREDICTION_FACTOR) : 0;
+
+	/*
+	 * Store the index as an element of the pattern in another
+	 * circular array.
+	 */
+	irqs->circ_timings[irqs->count & IRQ_TIMINGS_MASK] = index;
+
+	irqs->ema_time[index] = irq_timings_ema_new(interval,
+						    irqs->ema_time[index]);
+
+	irqs->count++;
+}
+
 /**
  * irq_timings_next_event - Return when the next event is supposed to arrive
  *
@@ -61,6 +434,12 @@ void irq_timings_disable(void)
  */
 u64 irq_timings_next_event(u64 now)
 {
+	struct irq_timings *irqts = this_cpu_ptr(&irq_timings);
+	struct irqt_stat *irqs;
+	struct irqt_stat __percpu *s;
+	u64 ts, next_evt = U64_MAX;
+	int i, irq = 0;
+
 	/*
 	 * This function must be called with the local irq disabled in
 	 * order to prevent the timings circular buffer to be updated
@@ -68,7 +447,50 @@ u64 irq_timings_next_event(u64 now)
 	 */
 	lockdep_assert_irqs_disabled();
 
-	return 0;
+	if (!irqts->count)
+		return next_evt;
+
+	/*
+	 * Number of elements in the circular buffer: If it happens it
+	 * was flushed before, then the number of elements could be
+	 * smaller than IRQ_TIMINGS_SIZE, so the count is used,
+	 * otherwise the array size is used as we wrapped. The index
+	 * begins from zero when we did not wrap. That could be done
+	 * in a nicer way with the proper circular array structure
+	 * type but with the cost of extra computation in the
+	 * interrupt handler hot path. We choose efficiency.
+	 *
+	 * Inject measured irq/timestamp to the pattern prediction
+	 * model while decrementing the counter because we consume the
+	 * data from our circular buffer.
+	 */
+	for (i = (irqts->count & IRQ_TIMINGS_MASK) - 1,
+		     irqts->count = min(IRQ_TIMINGS_SIZE, irqts->count);
+	     irqts->count > 0; irqts->count--, i = (i + 1) & IRQ_TIMINGS_MASK) {
+
+		irq = irq_timing_decode(irqts->values[i], &ts);
+		s = idr_find(&irqt_stats, irq);
+		if (s)
+			irq_timings_store(irq, this_cpu_ptr(s), ts);
+	}
+
+	/*
+	 * Look in the list of interrupts' statistics, the earliest
+	 * next event.
+	 */
+	idr_for_each_entry(&irqt_stats, s, i) {
+
+		irqs = this_cpu_ptr(s);
+
+		ts = __irq_timings_next_event(irqs, i, now);
+		if (ts <= now)
+			return now;
+
+		if (ts < next_evt)
+			next_evt = ts;
+	}
+
+	return next_evt;
 }
 
 void irq_timings_free(int irq)
-- 
2.17.1

