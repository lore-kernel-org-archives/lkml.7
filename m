Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A55C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB32F21841
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iSt+KozE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390936AbfEXLQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:16:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34823 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390856AbfEXLQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:16:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so9608696wrv.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OVCnRskmJCeqZXRUtBHTU3a0dRFZnt0B8APXmqZl1PE=;
        b=iSt+KozEePLOt00yptQg4U7xEgXqAzfPyZlBkSB8rsZ6OtjxaUBKIKfXhMXsFcAIeO
         7pqnkJ1PnIUul3tBicMbE4tvxLzoY8nwY3BJMY5WRPcpba6j6U+Dy3VT7aWbblAnr2RJ
         bbZYAKKTaNyKHWEsMfMPp8fwTi61DSxczu3LyxUb0kQ9bI2wMoVLDKlluuRJf8N+e+7u
         bUHhO/KAuOc9Z025MWY10RgUNyLmgblRzh8SCdg3cdLZw5bhKee1+D36cMdUfpweXETK
         o6hAXcY0BvphSPze1AadEQV24/Xah6W9/xGxs6oiHXeHiCZNzp6NL9wj2vkVi0k2qO1m
         R2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OVCnRskmJCeqZXRUtBHTU3a0dRFZnt0B8APXmqZl1PE=;
        b=LjbiqOpt4TKWIpN5OnxJEdBV0KTzhtoTqrAFPUkEoAMj8gWdMWPh6mNCGlSn1AFRmQ
         YZ9uVUtRf11wRZ2yLBnMpAqfs7aPRy+28mhnwWQCd4mpWd1lw2omHPeXG5O8iWnP3LAF
         76sp482b/FElip8e65Yg9Gh6+YYalMLyou4wvsjbociuoSAwcuyGowDCgdwt1teJvRID
         8iAZ3sNOqKE6k/x4Y2+UGKgvJamtUbG/jcRQUhGg6QzlMzvmpF8GfJ0pnrYNEOCNjR9D
         X1HkZ1fLrKGK2xw//RgfeXRvlLrIz3UR2BD67Zt/vDhXJ4UBIfmXRE6ui64RglNRGZmP
         X79g==
X-Gm-Message-State: APjAAAVrqeBImLYXQ7PSqLk+lIrGLfX5JE5BeDb0/R2VZ02780Qcx/58
        EAirU/1LiW8y/JyS2oFC0gMXoa9Ilik=
X-Google-Smtp-Source: APXvYqwSVWXushrLaqcjDUL7QPeX8seJFMMrfVpKutgtlib86Ky9xHAd+am5U60x5t2rGWFNo7TwCw==
X-Received: by 2002:a05:6000:43:: with SMTP id k3mr62372855wrx.234.1558696599149;
        Fri, 24 May 2019 04:16:39 -0700 (PDT)
Received: from clegane.local (73.82.95.92.rev.sfr.net. [92.95.82.73])
        by smtp.gmail.com with ESMTPSA id h12sm2575392wre.14.2019.05.24.04.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:16:38 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: [PATCH V2 2/9] genirq/timings: Fix timings buffer inspection
Date:   Fri, 24 May 2019 13:16:08 +0200
Message-Id: <20190524111615.4891-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524111615.4891-1-daniel.lezcano@linaro.org>
References: <20190524111615.4891-1-daniel.lezcano@linaro.org>
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
index 60362aca4ca4..250bb00ccd85 100644
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
@@ -528,11 +545,7 @@ u64 irq_timings_next_event(u64 now)
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

