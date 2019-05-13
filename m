Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D0DC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89FC21019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSHCuoqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfEMKaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:30:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52274 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfEMKaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:30:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id y3so3881738wmm.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 03:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lvZ+JFSB5ojt72GfMWAJ6EobprUjj+jvH2Pe8i8Nlqo=;
        b=dSHCuoqojnoQnhQPXQz7BOVR+dK7em4UWq9W9rNbeZ12DzLkg6+CSMkUVF3RJoH8J9
         3vwrdsnfCIYmRc69SgZPhD1rK9ulkby2MgOFR/87kjRSScR3JLGSzjEfJ0uPDXpVN0q+
         Bh6wnWmJfVs2UvMmrwleiJq8wtf8GMI3Jr55Gea3Ooec/6xHIj7t3WENxc0iopWgbhz1
         a/dgI5WH/UCZej5n3L9XHCoseNge88nTv9znxrHgM7ZFwJAMHYqeUOmyE7UGhCE/I7zI
         8P1EqmHWjKo3UBzbTpjmKGK5uB8U6nqufkFVdg8QY1gvQcjYk9OqOtOadY3pFUvwNC7r
         Iuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lvZ+JFSB5ojt72GfMWAJ6EobprUjj+jvH2Pe8i8Nlqo=;
        b=ER6m2I3ThIzqWFkdGokY60B9JsyXEfE/ZPrpaB8lO4SB0urCPDPqYXWMTt0q3q7JSJ
         u7Q983f6nuMXcKlDTHTXKnLbg9XfGOunxBHDM8BMcUQUnVauUI9BBTDAKM9APGJh88NF
         lBtK0HKIA1JCdC4MuIfEZv8vONCB35tlic376Ych7Sp4DRPW6A6mfRYOpaUnCTRuiT34
         uqwv+iE7m9We1zRwdUbom9bbljXZDoNhqjahfWLLc27W5GOB2w3podZJApGptwlZ6N0l
         M6j13BKEIi0HHyyJ9vTPsBDag+AUqNnHNUM/uN3rSJJhBKG0pnDSvWvRWZ4eNxyMITey
         kobw==
X-Gm-Message-State: APjAAAWCyZw95Y/hMeztXwMMa5p6VCMdzpI5vBc9GOdwtjrSnONO7YZo
        tKccAQjwrKobvC90Sr4RGhWYzCYpT60=
X-Google-Smtp-Source: APXvYqzY1IpQ8ViMGeKu5a98gdMYQrPVSxAYz/aIiaa6aIKTiK79+UDGvroRUBaVfh9I79yNNK6FaA==
X-Received: by 2002:a1c:b782:: with SMTP id h124mr15844451wmf.5.1557743411330;
        Mon, 13 May 2019 03:30:11 -0700 (PDT)
Received: from clegane.local (205.29.129.77.rev.sfr.net. [77.129.29.205])
        by smtp.gmail.com with ESMTPSA id v192sm13645238wme.24.2019.05.13.03.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 03:30:10 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] genirq/timings: Encapsulate storing function
Date:   Mon, 13 May 2019 12:29:50 +0200
Message-Id: <20190513102953.16424-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513102953.16424-1-daniel.lezcano@linaro.org>
References: <20190513102953.16424-1-daniel.lezcano@linaro.org>
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

