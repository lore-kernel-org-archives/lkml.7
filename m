Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91972C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C5B20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GJtwmrTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438994AbfFLMcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:32:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53331 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438952AbfFLMcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:32:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5CCVusF685804
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 12 Jun 2019 05:31:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5CCVusF685804
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560342717;
        bh=uP9Cv5Ys+APeIoTdPtO5ghjaRQCKSib0HZHt0dadfwE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=GJtwmrTCZ3w4jB4FP5Ozu6qdoK1IixY9wlx9Q03/Oz4X8qKbXuWMQrc7w0H01l0vy
         e0soaix3MQUelva1kruQ8k3XWBMUC9HMwtB/e4VU43IznmOIb9o7QNR+m7mMkkRFcD
         QXYtAF8B9micHxpj1eqtdqdfQ+QYfcX4frCirbGGhhAW9tJCaPq6busZLWm12MAcrk
         tElrzZyFZg9KV7G2ycY3a9P4j5TW3JqikYrbXGzq0PjPE7ikKUfome2ZonBeijN440
         uuvhNe4lgVzfW+XEvT9Pdb3hIEHRXPkwiRHuOBwqN+8Yc3gsOLMzSOI/9QzyTMmqEw
         A4r5OepUs29vQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5CCVu7J685801;
        Wed, 12 Jun 2019 05:31:56 -0700
Date:   Wed, 12 Jun 2019 05:31:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Lezcano <tipbot@zytor.com>
Message-ID: <tip-f52da98d900e18a250cb14ca426d4041ea7002db@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, mingo@kernel.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          daniel.lezcano@linaro.org, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20190527205521.12091-8-daniel.lezcano@linaro.org>
References: <20190527205521.12091-8-daniel.lezcano@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/timings: Add selftest for irqs circular
 buffer
Git-Commit-ID: f52da98d900e18a250cb14ca426d4041ea7002db
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

Commit-ID:  f52da98d900e18a250cb14ca426d4041ea7002db
Gitweb:     https://git.kernel.org/tip/f52da98d900e18a250cb14ca426d4041ea7002db
Author:     Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate: Mon, 27 May 2019 22:55:20 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 12 Jun 2019 10:47:05 +0200

genirq/timings: Add selftest for irqs circular buffer

After testing the per cpu interrupt circular event, make sure the per
interrupt circular buffer usage is correct.

Add tests to validate the interrupt circular buffer.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: andriy.shevchenko@linux.intel.com
Link: https://lkml.kernel.org/r/20190527205521.12091-8-daniel.lezcano@linaro.org

---
 kernel/irq/timings.c | 139 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 95b63bdea156..5b13c2231d4f 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -629,6 +629,141 @@ int irq_timings_alloc(int irq)
 }
 
 #ifdef CONFIG_TEST_IRQ_TIMINGS
+struct timings_intervals {
+	u64 *intervals;
+	size_t count;
+};
+
+/*
+ * Intervals are given in nanosecond base
+ */
+static u64 intervals0[] __initdata = {
+	10000, 50000, 200000, 500000,
+	10000, 50000, 200000, 500000,
+	10000, 50000, 200000, 500000,
+	10000, 50000, 200000, 500000,
+	10000, 50000, 200000, 500000,
+	10000, 50000, 200000, 500000,
+	10000, 50000, 200000, 500000,
+	10000, 50000, 200000, 500000,
+	10000, 50000, 200000,
+};
+
+static u64 intervals1[] __initdata = {
+	223947000, 1240000, 1384000, 1386000, 1386000,
+	217416000, 1236000, 1384000, 1386000, 1387000,
+	214719000, 1241000, 1386000, 1387000, 1384000,
+	213696000, 1234000, 1384000, 1386000, 1388000,
+	219904000, 1240000, 1385000, 1389000, 1385000,
+	212240000, 1240000, 1386000, 1386000, 1386000,
+	214415000, 1236000, 1384000, 1386000, 1387000,
+	214276000, 1234000,
+};
+
+static u64 intervals2[] __initdata = {
+	4000, 3000, 5000, 100000,
+	3000, 3000, 5000, 117000,
+	4000, 4000, 5000, 112000,
+	4000, 3000, 4000, 110000,
+	3000, 5000, 3000, 117000,
+	4000, 4000, 5000, 112000,
+	4000, 3000, 4000, 110000,
+	3000, 4000, 5000, 112000,
+	4000,
+};
+
+static u64 intervals3[] __initdata = {
+	1385000, 212240000, 1240000,
+	1386000, 214415000, 1236000,
+	1384000, 214276000, 1234000,
+	1386000, 214415000, 1236000,
+	1385000, 212240000, 1240000,
+	1386000, 214415000, 1236000,
+	1384000, 214276000, 1234000,
+	1386000, 214415000, 1236000,
+	1385000, 212240000, 1240000,
+};
+
+static u64 intervals4[] __initdata = {
+	10000, 50000, 10000, 50000,
+	10000, 50000, 10000, 50000,
+	10000, 50000, 10000, 50000,
+	10000, 50000, 10000, 50000,
+	10000, 50000, 10000, 50000,
+	10000, 50000, 10000, 50000,
+	10000, 50000, 10000, 50000,
+	10000, 50000, 10000, 50000,
+	10000,
+};
+
+static struct timings_intervals tis[] __initdata = {
+	{ intervals0, ARRAY_SIZE(intervals0) },
+	{ intervals1, ARRAY_SIZE(intervals1) },
+	{ intervals2, ARRAY_SIZE(intervals2) },
+	{ intervals3, ARRAY_SIZE(intervals3) },
+	{ intervals4, ARRAY_SIZE(intervals4) },
+};
+
+static int __init irq_timings_test_irqs(struct timings_intervals *ti)
+{
+	struct irqt_stat __percpu *s;
+	struct irqt_stat *irqs;
+	int i, index, ret, irq = 0xACE5;
+
+	ret = irq_timings_alloc(irq);
+	if (ret) {
+		pr_err("Failed to allocate irq timings\n");
+		return ret;
+	}
+
+	s = idr_find(&irqt_stats, irq);
+	if (!s) {
+		ret = -EIDRM;
+		goto out;
+	}
+
+	irqs = this_cpu_ptr(s);
+
+	for (i = 0; i < ti->count; i++) {
+
+		index = irq_timings_interval_index(ti->intervals[i]);
+		pr_debug("%d: interval=%llu ema_index=%d\n",
+			 i, ti->intervals[i], index);
+
+		__irq_timings_store(irq, irqs, ti->intervals[i]);
+		if (irqs->circ_timings[i & IRQ_TIMINGS_MASK] != index) {
+			pr_err("Failed to store in the circular buffer\n");
+			goto out;
+		}
+	}
+
+	if (irqs->count != ti->count) {
+		pr_err("Count differs\n");
+		goto out;
+	}
+
+	ret = 0;
+out:
+	irq_timings_free(irq);
+
+	return ret;
+}
+
+static int __init irq_timings_irqs_selftest(void)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(tis); i++) {
+		pr_info("---> Injecting intervals number #%d (count=%zd)\n",
+			i, tis[i].count);
+		ret = irq_timings_test_irqs(&tis[i]);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
 static int __init irq_timings_test_irqts(struct irq_timings *irqts,
 					 unsigned count)
 {
@@ -736,7 +871,11 @@ static int __init irq_timings_selftest(void)
 	}
 
 	ret = irq_timings_irqts_selftest();
+	if (ret)
+		goto out;
 
+	ret = irq_timings_irqs_selftest();
+out:
 	pr_info("---------- selftest end with %s -----------\n",
 		ret ? "failure" : "success");
 
