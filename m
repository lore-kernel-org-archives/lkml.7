Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD82BC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9491420874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OcvV0ncR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbfFLM2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:28:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49179 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfFLM23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:28:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5CCSN5Z685191
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 12 Jun 2019 05:28:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5CCSN5Z685191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560342503;
        bh=oIVJEOdoZvmVLvEi4yi8nrOfcAuXixs2rt9tEVgfEtU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=OcvV0ncRZ5kVRTKkJjgfrKUnu9qGDuRZmGtU+0U3HXq9v38uoZqUaECIGAzJ6v9AI
         K4gpbmajCHoZz0501xE/0g/pt5tmtt1kcUymZjHW+P4MP4oNn+fqbSlavEBhTRqtts
         cG55BlRwgBLJNRE4sH/GXd0YcKUMFMO2o/3Or9lHv+Fi9+aoqRt0NnV8OlXbcl7z7S
         wKoJ16g9y/P1FBkG6fbfsKD/xvTSQoPcmPSvqEKJomvNSgeOtUHg2XRJzro99PNzrH
         4eCazQApEcRXk2xDSTy3tB5mAIOppFHFzLxn0vNQT7jU1fXuBZDnDir4PIOUN4Slll
         6zBcXISctsiXg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5CCSM7J685188;
        Wed, 12 Jun 2019 05:28:22 -0700
Date:   Wed, 12 Jun 2019 05:28:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Lezcano <tipbot@zytor.com>
Message-ID: <tip-2840eef0513c518faeb8a0ab8d07268c6285cdd0@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          daniel.lezcano@linaro.org, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20190527205521.12091-3-daniel.lezcano@linaro.org>
References: <20190527205521.12091-3-daniel.lezcano@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/timings: Fix timings buffer inspection
Git-Commit-ID: 2840eef0513c518faeb8a0ab8d07268c6285cdd0
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

Commit-ID:  2840eef0513c518faeb8a0ab8d07268c6285cdd0
Gitweb:     https://git.kernel.org/tip/2840eef0513c518faeb8a0ab8d07268c6285cdd0
Author:     Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate: Mon, 27 May 2019 22:55:15 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 12 Jun 2019 10:47:03 +0200

genirq/timings: Fix timings buffer inspection

It appears the index beginning computation is not correct, the current
code does:

     i = (irqts->count & IRQ_TIMINGS_MASK) - 1

If irqts->count is equal to zero, we end up with an index equal to -1,
but that does not happen because the function checks against zero
before and returns in such case.

However, if irqts->count is a multiple of IRQ_TIMINGS_SIZE, the
resulting & bit op will be zero and leads also to a -1 index.

Re-introduce the iteration loop belonging to the previous variance
code which was correct.

Fixes: bbba0e7c5cda "genirq/timings: Add array suffix computation code"
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: andriy.shevchenko@linux.intel.com
Link: https://lkml.kernel.org/r/20190527205521.12091-3-daniel.lezcano@linaro.org

---
 kernel/irq/timings.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 4f5daf3db13b..19d2fad379ee 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -267,6 +267,23 @@ void irq_timings_disable(void)
 #define PREDICTION_MAX		10 /* 2 ^ PREDICTION_MAX useconds */
 #define PREDICTION_BUFFER_SIZE	16 /* slots for EMAs, hardly more than 16 */
 
+/*
+ * Number of elements in the circular buffer: If it happens it was
+ * flushed before, then the number of elements could be smaller than
+ * IRQ_TIMINGS_SIZE, so the count is used, otherwise the array size is
+ * used as we wrapped. The index begins from zero when we did not
+ * wrap. That could be done in a nicer way with the proper circular
+ * array structure type but with the cost of extra computation in the
+ * interrupt handler hot path. We choose efficiency.
+ */
+#define for_each_irqts(i, irqts)					\
+	for (i = irqts->count < IRQ_TIMINGS_SIZE ?			\
+		     0 : irqts->count & IRQ_TIMINGS_MASK,		\
+		     irqts->count = min(IRQ_TIMINGS_SIZE,		\
+					irqts->count);			\
+	     irqts->count > 0; irqts->count--,				\
+		     i = (i + 1) & IRQ_TIMINGS_MASK)
+
 struct irqt_stat {
 	u64	last_ts;
 	u64	ema_time[PREDICTION_BUFFER_SIZE];
@@ -526,11 +543,7 @@ u64 irq_timings_next_event(u64 now)
 	 * model while decrementing the counter because we consume the
 	 * data from our circular buffer.
 	 */
-
-	i = (irqts->count & IRQ_TIMINGS_MASK) - 1;
-	irqts->count = min(IRQ_TIMINGS_SIZE, irqts->count);
-
-	for (; irqts->count > 0; irqts->count--, i = (i + 1) & IRQ_TIMINGS_MASK) {
+	for_each_irqts(i, irqts) {
 		irq = irq_timing_decode(irqts->values[i], &ts);
 		s = idr_find(&irqt_stats, irq);
 		if (s)
