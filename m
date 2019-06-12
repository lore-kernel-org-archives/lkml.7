Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251FBC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7BB208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XGsmVcWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438947AbfFLMaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:30:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58109 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438902AbfFLMaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:30:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5CCUVSF685666
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 12 Jun 2019 05:30:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5CCUVSF685666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560342632;
        bh=e6hcdRbdUjkQZNQmrqeLKPPW0kXkR4IMBC7o/G/trFs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=XGsmVcWpJmr3dCNj1pBITGVKzxB6HQ54wctoPbQ9M5PNbGl8afz+vNk3uhPhBZZGx
         wzwXbEP7NMvNDLPohCq7UVxBg4TbnaTMCoRQvbYcGeGnaSHQzV3kYYndrPyw/GzPS1
         9wbbVP9N5F7eo8HeBY7REHTg3Xmhj/rggOquI4v1T6ar/dmfGd+Pd130Dde/NSz+AI
         EdAAO38ACZjaSCm4kPZYQMhAn9UgT9fNvUOZkKQauQQnm+Gm4dVxS4YuRCsOVWh64m
         r7ga0DU2VQdGGYBfYD4yCiVXQ42vOuNiLY64bbjkeCGVoOXgDZR4198Q6FHhD5B8Q5
         k3tXtEHyWfGLQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5CCUTnJ685662;
        Wed, 12 Jun 2019 05:30:29 -0700
Date:   Wed, 12 Jun 2019 05:30:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Lezcano <tipbot@zytor.com>
Message-ID: <tip-23aa3b9a6b7d5029c1f124426bc5ba4430dcc29c@git.kernel.org>
Cc:     daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com
Reply-To: hpa@zytor.com, daniel.lezcano@linaro.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org
In-Reply-To: <20190527205521.12091-6-daniel.lezcano@linaro.org>
References: <20190527205521.12091-6-daniel.lezcano@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/timings: Encapsulate storing function
Git-Commit-ID: 23aa3b9a6b7d5029c1f124426bc5ba4430dcc29c
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

Commit-ID:  23aa3b9a6b7d5029c1f124426bc5ba4430dcc29c
Gitweb:     https://git.kernel.org/tip/23aa3b9a6b7d5029c1f124426bc5ba4430dcc29c
Author:     Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate: Mon, 27 May 2019 22:55:18 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 12 Jun 2019 10:47:04 +0200

genirq/timings: Encapsulate storing function

For the next patches providing the selftest, it is required to insert
interval values directly in the buffer in order to check the correctness of
the code. Encapsulate the code doing that in a always inline function in
order to reuse it in the test code.

No functional changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: andriy.shevchenko@linux.intel.com
Link: https://lkml.kernel.org/r/20190527205521.12091-6-daniel.lezcano@linaro.org

---
 kernel/irq/timings.c | 53 +++++++++++++++++++++++++++++++++-------------------
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
