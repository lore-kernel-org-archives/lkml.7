Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAC5C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E39208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dCjmqheu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfEMKaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:30:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36959 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbfEMKaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:30:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id e15so2219254wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 03:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OVCnRskmJCeqZXRUtBHTU3a0dRFZnt0B8APXmqZl1PE=;
        b=dCjmqheu9OCwBZAEeNAV56ihyvGOc9X0p3J9Kl5gUc+31+Qi6NFQAoJhzZuU1zIOfa
         2e59iMszAI3DOIwYF6e1EeLWiL1gGSMifaEib95F80Q6lIJ8vj09T/ZRby7HdJbYVrbX
         dUwrVAKH9wIQjAQeIfw/TULMWkAEm2mUb+ABsfQcp5SQpTSyJjU7KlOhQIGwLyqui1a1
         /iW2Zqtydfj05piNB/nUJyOJYPq549bCbF1irA9Q9WwEAuOI9HFZ0xtK2qpb/7vhap0A
         T7dyeMNhrPzV4WvDwDFaUIB6Q9oFVQYSVtzTBpTq41FR4lVB+9tMy0c4AySmz+L6Q1Fs
         ejAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OVCnRskmJCeqZXRUtBHTU3a0dRFZnt0B8APXmqZl1PE=;
        b=oZ0V64V94dZk5oPPAeumoakd37BcmLtjlzEsHECupnRAIk5PMgZcH51AcjI72FaZhZ
         7C+EhaC0uDxF1PgtBevKmm3BeJI2uxNuaSLOvH7+T2YLjNk9UPXqTsCa6S4ycQNwku3v
         YPwkjubhOAGUH+Bb6+lFtwbkB3T+RaTxlYydJ/GmiVfAJ+qTLWvAWHLa3OIQe8DdeEle
         njXiX6+boCw7x1GJ6ukb1t6DrFEidEF/KeQQap1GLB7CusJwtmzFkBr4Gv46eZtgHNy3
         Dg3MIgS7mVC8fsE88TBAxNcDawTQogn+z1Lmiy/W6NfrDr+nNHCkKN9WlwNgBSXyuKDr
         C4Ag==
X-Gm-Message-State: APjAAAUs96uIm2scT35I71u1JxlJN0/DNOyE+yE00hbgY3JKcm2QTtam
        ZtCrrNQeJF5bXXiBb80AU2pdpg==
X-Google-Smtp-Source: APXvYqyiZ54pUuuTxTaIRFuUurS6hUpARL+UK+NJkb2JGMr84xaVTvP5QB+juef/S98e2TvSqffdSg==
X-Received: by 2002:a5d:6703:: with SMTP id o3mr3610617wru.183.1557743405941;
        Mon, 13 May 2019 03:30:05 -0700 (PDT)
Received: from clegane.local (205.29.129.77.rev.sfr.net. [77.129.29.205])
        by smtp.gmail.com with ESMTPSA id v192sm13645238wme.24.2019.05.13.03.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 03:30:05 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] genirq/timings: Fix timings buffer inspection
Date:   Mon, 13 May 2019 12:29:46 +0200
Message-Id: <20190513102953.16424-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513102953.16424-1-daniel.lezcano@linaro.org>
References: <20190513102953.16424-1-daniel.lezcano@linaro.org>
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

