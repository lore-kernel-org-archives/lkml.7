Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8B4C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC1F21897
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sBTX5s7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391079AbfEXLQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:16:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35448 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391004AbfEXLQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:16:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so2699951wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wiujqhHBG1u+vChiNTLfiUzCMKatKnSUp5prmw5DeT8=;
        b=sBTX5s7KZa/ifhEXk5dHA08ZgX/YQJeuwlp4wp3g9u8dAOkNYrbI8/kR7T6Ji7Me/v
         bv+nlZMqs/BgPVsS3YXV7TJtRlhWfOHom4W9y384Fe6/8kdhJgqcFcmvMCIJDnEVcz/w
         VdHwHyHAp1sdwmTGc8CUwwd1L0U7fr3ODfie/YOD9aukwLengiCU8ChLUdA5l3mK2nSl
         +9O9hxcCKeDMFOdKsZQ3Z6TbI15nbyBc6aPb7d6psOjVIVsD1Fe1ZXyfCSFnyi+ydpTk
         bP1X+G25dI5w+pGd2KL6QND/RxuZvUkRIABDpHJdyX7EWnJaGGTl3jg1299JAe8T3m1m
         wJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wiujqhHBG1u+vChiNTLfiUzCMKatKnSUp5prmw5DeT8=;
        b=frM2JLMMmpG7b7/WIvzAvi8iK8C3KyY14+oB0SM2oAbdW8OXAeLGB72GZM3Lp5qqUg
         tM4/Oc0RAZcXYnp2CoDimqvZsWYz+TnLhVxsrd2RJ2kaL1nMM4nhge5ZZFvDWowyH+mI
         JqzIk259fBGNveqseLpAIZPugy61Q2Yj4lHROlgmJyFkg19xuJ21OIqr7Wg4HDylgOWh
         +OvEZJpBSO8jB2s8EPxrDbgvcw+LpWP+wiGfLuec/3bghCEhRVCE9OWZ6/toQOUBeNhi
         mb+hH8CptiRM4bjGdFGbURjzqIGvbUxpyvrlRdcbKPnxvR/OQedaye5oa0Cl70RILZ2k
         fhHA==
X-Gm-Message-State: APjAAAUlHVWhw9epFMNlI+3G6J59zRxfbASIpwn9BMNL//v4l31U1DUu
        VE/Ft61Wc5YS8ppxLOo1w26ftg==
X-Google-Smtp-Source: APXvYqz+8f/R4RPMG+3qC8aWmvzxVRZ6255SiIjdWXfXoSqur1FYOCKlA9x5UalVSQUnwx6PoOH1Sw==
X-Received: by 2002:a7b:cb85:: with SMTP id m5mr16100703wmi.85.1558696611440;
        Fri, 24 May 2019 04:16:51 -0700 (PDT)
Received: from clegane.local (73.82.95.92.rev.sfr.net. [92.95.82.73])
        by smtp.gmail.com with ESMTPSA id h12sm2575392wre.14.2019.05.24.04.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:16:50 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: [PATCH V2 8/9] genirq/timings: Add selftest for irqs circular buffer
Date:   Fri, 24 May 2019 13:16:14 +0200
Message-Id: <20190524111615.4891-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524111615.4891-1-daniel.lezcano@linaro.org>
References: <20190524111615.4891-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After testing the per cpu interrupt circular event, we want to make
sure the per interrupt circular buffer usage is correct.

Add tests to validate the interrupt circular buffer.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/irq/timings.c | 139 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index dae04117796c..5e4efac967fd 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -630,6 +630,141 @@ int irq_timings_alloc(int irq)
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
@@ -737,7 +872,11 @@ static int __init irq_timings_selftest(void)
 	}
 
 	ret = irq_timings_irqts_selftest();
+	if (ret)
+		goto out;
 
+	ret = irq_timings_irqs_selftest();
+out:
 	pr_info("---------- selftest end with %s -----------\n",
 		ret ? "failure" : "success");
 
-- 
2.17.1

