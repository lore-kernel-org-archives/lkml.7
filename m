Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756D0C46460
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAD8208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YpEk8xi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfE0Uzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 16:55:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33369 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbfE0Uzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:55:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id d9so17972561wrx.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 13:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HugjAdec+ECusQ75/a+e3QzpsFyAQQ56btTZ6ZtG3KE=;
        b=YpEk8xi3Kr8+aIDze86ayOZcZ9ze8h5GcwnO+F2a4CZ9wJpYnMSy8LAy+LtiwW4FQ+
         ChjYrp6913P5x/dO9fHl/1/eEQo/OXl0oMBWh9KHX1+AKUMjNJDiEbltihff8/o3Y2qm
         xLH4jhBQXBO/aHL8kNhF457fYnjcQQJ+/Wie/zWbOLE/mJlYn29jfKDvMnQ2UF4IZV0f
         l5UDv5HFNt/fLqPqIIjO9azcxlp7/A9KUugru56YnSIVQ4u5K+fhtrLMG7mHsZDhJL0G
         YEFQSdoChEPkUzD/fQT/1pR6xspSCeicvBgHtTvEYZ/t6GeCYtu9Eh7fCbG7d3IAglzC
         Ttwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HugjAdec+ECusQ75/a+e3QzpsFyAQQ56btTZ6ZtG3KE=;
        b=FXEzsCJxPkbQVXgVQlzhP7L6Hg0PfJIP4LACyg+kgpOzks+hUI15c1yythncDTm7O+
         NOK3CDroHYaPdESLzIbck/BLqRM5eUuF21eilmq4A2vcjsgAUNIGTgPcq2gKfvNRaTJF
         2RC6fgWCQt+OkZl0GIDc3Il3O6zML8bOECQvV3Uy17SHWf5d5Mqp2nXkXqi10d1U7g4D
         iJ8JD7M6yREjOqXyUqOaY/bkQp6d5Fe4Tq90oZ485WTlKCXXkrqOOpG85KLuPruQs5OA
         PtCJrXZBWbyN7BnHSurXY/jF3V4ax6Lawhl1eekP6OA9WtCLZG8P0AUt6O/3C2V4g1LY
         7D+g==
X-Gm-Message-State: APjAAAXe/XPNJ1mfHNR0Xy0HVSPduaOu3OvA11glOQwM5/nob3TiJRo5
        KVLHl+5iMyjN1fm/yGXNupSiVYe4C3w=
X-Google-Smtp-Source: APXvYqyG53r06fUw9h3bPIQ+xWZzLmAevaCNs/n1qKutWxW+ohortvqYc4JcCe2mE4fASV+IJeiJUg==
X-Received: by 2002:a5d:4089:: with SMTP id o9mr208488wrp.6.1558990543774;
        Mon, 27 May 2019 13:55:43 -0700 (PDT)
Received: from clegane.local (30.94.129.77.rev.sfr.net. [77.129.94.30])
        by smtp.gmail.com with ESMTPSA id a1sm388565wmj.23.2019.05.27.13.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:55:42 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: [PATCH V3 2/8] genirq/timings: Fix timings buffer inspection
Date:   Mon, 27 May 2019 22:55:15 +0200
Message-Id: <20190527205521.12091-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527205521.12091-1-daniel.lezcano@linaro.org>
References: <20190527205521.12091-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
-- 
2.17.1

