Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C52C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC73620859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LdCuBNGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfE0Uz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 16:55:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46372 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfE0Uzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:55:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id r7so17935634wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 13:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Phs2DAaIK8MGXZ+i6+CFVkqUm3dtIclSkuWO2pGztkE=;
        b=LdCuBNGlJJhVhaMjz2Ob0A6FFGgflwHEr1m4VkQRC8uyp3qf0DtuLOOUf9QDtX0mt7
         PXOVc2yDJCfimzO2B8rszVt0iQoABJL3VH9ccDUE02n9TkoGLI2hfkcOzFJjI/FR8f8v
         0dR4hOk8/uJBVlWhQvn3jjN2tW46cyldxbjtAH5T//KdZJ8478OoP474TtMz+t4K1W8U
         V5xNeX1QSOx7LMvHQ9mg8ESQ3XZSnBk8IOyPXzDOvdtaKB4xEf8ZIxdfPCxg7liqthYF
         SU1smHtrAQX7yNBv6G5jUhIuZaqc4L/qsgC/XSEvSu2ja9XO9XODQscfqn3lPCJQTdZ9
         6cBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Phs2DAaIK8MGXZ+i6+CFVkqUm3dtIclSkuWO2pGztkE=;
        b=iYq1zPsg+/nuCUkiNM30VP1qy147uJdgGQoAbPMUIM5UKJ2UfKNyamzJw0mr7uX7bB
         tMH7Q3ZMWkGQCmmibJIQtKG+HvYNdXzhtqAjxdhJ8D+iCvAhjykhl5UNweadFj/GxtyJ
         /jQZ/1oVSebCThYJhZoUukJWLS5pse9fcE2H525NewjMxwb78YNaK01fUYysvK13uU9s
         0wgL9kp3EYhxkX04H+b0Cn2fMrWBJ1cpAXMFV+w/ItrERSR6i1DdaHS8MYdtsqnx6w+r
         S0J5OxcMYjwfL3MiqWDsq3vajVMtWUlEPNSgivlUplj1u5RDBuXgfK3SpwiBr+1aDliE
         MwSw==
X-Gm-Message-State: APjAAAV3rP8CjnD4c/BVUP5jIOomaKRkvb/D3wnbQUTdhbxS1+ZI5h1t
        hSRPH2f5O1rPWZJ59XKsXwe4A3D40X4=
X-Google-Smtp-Source: APXvYqxiOGo/M6b2y8MLtGqjz1A9kqTnh3ZH7J5O7LVpNZnkvU+suylZb6BMg7ERtgpHnROdy8gV0A==
X-Received: by 2002:adf:e550:: with SMTP id z16mr2515773wrm.146.1558990547233;
        Mon, 27 May 2019 13:55:47 -0700 (PDT)
Received: from clegane.local (30.94.129.77.rev.sfr.net. [77.129.94.30])
        by smtp.gmail.com with ESMTPSA id a1sm388565wmj.23.2019.05.27.13.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:55:46 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: [PATCH V3 5/8] genirq/timings: Encapsulate storing function
Date:   Mon, 27 May 2019 22:55:18 +0200
Message-Id: <20190527205521.12091-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527205521.12091-1-daniel.lezcano@linaro.org>
References: <20190527205521.12091-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the next patches providing the selftest, we want to insert
interval values directly in the buffer in order to check the
correctness of the code. Encapsulate the code doing that in a always
inline function in order to reuse it in the test code.

No functional changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/irq/timings.c | 53 ++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 1d1c411d4cae..bc04eca6ef84 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -430,11 +430,43 @@ static u64 __irq_timings_next_event(struct irqt_stat *irqs, int irq, u64 now)
 	return irqs->last_ts + irqs->ema_time[index];
 }
 
+static __always_inline int irq_timings_interval_index(u64 interval)
+{
+	/*
+	 * The PREDICTION_FACTOR increase the interval size for the
+	 * array of exponential average.
+	 */
+	u64 interval_us = (interval >> 10) / PREDICTION_FACTOR;
+
+	return likely(interval_us) ? ilog2(interval_us) : 0;
+}
+
+static __always_inline void __irq_timings_store(int irq, struct irqt_stat *irqs,
+						u64 interval)
+{
+	int index;
+
+	/*
+	 * Get the index in the ema table for this interrupt.
+	 */
+	index = irq_timings_interval_index(interval);
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
 static inline void irq_timings_store(int irq, struct irqt_stat *irqs, u64 ts)
 {
 	u64 old_ts = irqs->last_ts;
 	u64 interval;
-	int index;
 
 	/*
 	 * The timestamps are absolute time values, we need to compute
@@ -465,24 +497,7 @@ static inline void irq_timings_store(int irq, struct irqt_stat *irqs, u64 ts)
 		return;
 	}
 
-	/*
-	 * Get the index in the ema table for this interrupt. The
-	 * PREDICTION_FACTOR increase the interval size for the array
-	 * of exponential average.
-	 */
-	index = likely(interval) ?
-		ilog2((interval >> 10) / PREDICTION_FACTOR) : 0;
-
-	/*
-	 * Store the index as an element of the pattern in another
-	 * circular array.
-	 */
-	irqs->circ_timings[irqs->count & IRQ_TIMINGS_MASK] = index;
-
-	irqs->ema_time[index] = irq_timings_ema_new(interval,
-						    irqs->ema_time[index]);
-
-	irqs->count++;
+	__irq_timings_store(irq, irqs, interval);
 }
 
 /**
-- 
2.17.1

