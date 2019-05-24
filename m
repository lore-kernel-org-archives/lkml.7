Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AA5C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D5821773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vGhRLZdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391029AbfEXLQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:16:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39001 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390973AbfEXLQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:16:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so4742223wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lvZ+JFSB5ojt72GfMWAJ6EobprUjj+jvH2Pe8i8Nlqo=;
        b=vGhRLZdmVNVGGcKBnIItowDcWfMq3Xaw389Y/cuQNZS4iDmNrDbBCBaX7j23/axhjX
         3oooQ0egkgP8w5lyPAe/HAxKtMBDhYdSX6EsSAPyYt0P4Ww1aoQiSNAaVNud2QXu3api
         GFKQY8wfQlR7UqVc6obKc9SULzAyDlvH5R2p0WlFfPzuHL3nuHYEUAMGSY5GRG+XFDlk
         OcjsVTGANwjDrbjGYzwli5ZADNkJVqhkkRyxw6DWF+ygOhLiqJQI2GfBGj7Lf4fQS/E/
         BXywzq0fUEuSt7fY19YaBAYj2KfVe34HZqK2TegGijJTDUytHGn2IupYEnTTU6nfhZDE
         dkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lvZ+JFSB5ojt72GfMWAJ6EobprUjj+jvH2Pe8i8Nlqo=;
        b=kXdt9D+c+tjMwJQ/+VRP8TfkTJDXvJM+qXO0Zgb1v6j8YUgtExdneT52Ys5kGG0rSR
         PKDtDuIqwXhYKDInBVr/Ne4MKg0JHocXt7u1f7whkKBc9B2+sxRny5pQwf+axJBtexby
         dDoFHQiXfHepvEsiN98DxKzLOvOe2XWKORY7q1fKB4W8dUn5gYgwIfbgoYHxlkYzh6Qf
         uOqzH5YCV2wCA5GJDXp6LJHzRHaZT5AQ/WxcmNCK1kk5hdOtZTXGTghu0Ysbli+2GBYU
         OQM68tXrTB3XLBkiQnQK8lcVFmD8Y/H89I8WkDSdqmT2I6QL33j4hknoT6ZAOWJgaj1F
         9IwQ==
X-Gm-Message-State: APjAAAVmbjBfq4gzg/EN3E/TEQ44c8FU+1YiSxLJZGSGT2KKBDDxwG4D
        kE7oP0ZLRcbqvuxSNNWBpajjFw==
X-Google-Smtp-Source: APXvYqy+UF7YScMw4fsKaK+MYTGXLzQwG03YeCQeqCMYHJj95yNud2jE39yceVrXzeJZh7NAXHV4mQ==
X-Received: by 2002:a1c:9a14:: with SMTP id c20mr15322201wme.104.1558696604433;
        Fri, 24 May 2019 04:16:44 -0700 (PDT)
Received: from clegane.local (73.82.95.92.rev.sfr.net. [92.95.82.73])
        by smtp.gmail.com with ESMTPSA id h12sm2575392wre.14.2019.05.24.04.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:16:43 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: [PATCH V2 6/9] genirq/timings: Encapsulate storing function
Date:   Fri, 24 May 2019 13:16:12 +0200
Message-Id: <20190524111615.4891-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524111615.4891-1-daniel.lezcano@linaro.org>
References: <20190524111615.4891-1-daniel.lezcano@linaro.org>
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
index 8928601b4b42..02689e6168c4 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -431,11 +431,43 @@ static u64 __irq_timings_next_event(struct irqt_stat *irqs, int irq, u64 now)
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
@@ -466,24 +498,7 @@ static inline void irq_timings_store(int irq, struct irqt_stat *irqs, u64 ts)
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

