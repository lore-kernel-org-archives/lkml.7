Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9B0C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D244520859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GauBSKsf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfE0U4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 16:56:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33923 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfE0Uzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:55:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id f8so17983466wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 13:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MjZ/pyBZBO4EDEwBpRQ6u4NGJabjhPzRMD0kf65cmv4=;
        b=GauBSKsfWkUC1ndbG21MewLXH8aQTbFfRtmwE0QfKWksuLdU2V1AKi/7bMLplJEzFB
         iY9xU9FbZht/hZvDRZy9xMUArd2o68734zpvMaqgR7NMp2JdO64lYu9Dgrq1PhGr5NdZ
         SvU8RmB3ilA1vCA4eVEZMCX//zKV/Y1DCLC8DKrbDPDgwCUgqnX/soDbKfneUKT4PEtI
         l1wCyjU9aTn5gyWosMH8wB7Uvmk4wZW9qDnGZXHe0+uoNyjs8vsdW2O/WrzgQxWLcQCV
         j9YBuE/dtDIavmPTLvz+k8rSg3IP+4fzrhfXKl3wvLnuURZQkb1Kr9IyEcHOxg9oCXVY
         jTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MjZ/pyBZBO4EDEwBpRQ6u4NGJabjhPzRMD0kf65cmv4=;
        b=sMNTeibdCNOzEz73FVw7Zj2YkMuKiTckCK8R0rkGN7xb+G8Mr/qXPvV7F7IQdembcb
         aD69ObwQh9m4MkDeD11HRd0F8JMcRFufJH+TIJgRwKwqV5eEm3JzFbla0p6Yl6OoZ/qK
         fy+uuQVe67vS90RmlkY1sgeJHlgAddUYhH39h4aZGRNRcotYp4rEXAiej8hx6ZCE1Bse
         bzC2cmCztPZavrI95odnNxk7ukgARdCzo+sLevPIaiIA2ykLIaGxlaT2G81Z4vXNQEQs
         xDYBNv4yko3J7xH5QF8f0bVZzU7dnr8givTTQFt034DmNC0VHq4V6i9oC/3iUPHqCMjK
         vsjw==
X-Gm-Message-State: APjAAAXIW9QznEVK8Y0/a/98wb+LWkU8PFktNkwd9sZQ4qS5I3Mt681d
        N7X09SBmtC700MW45HsOEJ9JLg==
X-Google-Smtp-Source: APXvYqywTuls5XsmHkJIY93E4xOaE2/n5U+HJAgU5hpIGFdxVhyXRlEiqJhYEzNeMqVUJ7o516jbNg==
X-Received: by 2002:a5d:504f:: with SMTP id h15mr307455wrt.208.1558990549613;
        Mon, 27 May 2019 13:55:49 -0700 (PDT)
Received: from clegane.local (30.94.129.77.rev.sfr.net. [77.129.94.30])
        by smtp.gmail.com with ESMTPSA id a1sm388565wmj.23.2019.05.27.13.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:55:48 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: [PATCH V3 7/8] genirq/timings: Add selftest for irqs circular buffer
Date:   Mon, 27 May 2019 22:55:20 +0200
Message-Id: <20190527205521.12091-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527205521.12091-1-daniel.lezcano@linaro.org>
References: <20190527205521.12091-1-daniel.lezcano@linaro.org>
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
 
-- 
2.17.1

