Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464D3C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B0621019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xZH5BEx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbfEMKaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:30:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52289 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbfEMKaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:30:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id y3so3882194wmm.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 03:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wiujqhHBG1u+vChiNTLfiUzCMKatKnSUp5prmw5DeT8=;
        b=xZH5BEx4DVqhI/yCyJ/9//mDG0TBL56xfES6Hh+yGgzJpmiCY/zM7Qc3RqlFAZGs34
         zVZTewhKISZTL7KtBNzxq2sG9+SDZZkVwp+mretiIOKougb51b9OJucvlMB5ON5VjwvY
         EOs/y5dnkTsbNcDMFFNV0lpkrPOtJrqj/Umn6K5+GfBBRFLkdxWk1LAPxiiiaJy9t8p2
         Ij1zd1SdZRGcMHcUgZvcy9Pz+/5DT4qrcC1FQC3v5YoN5Gmtq3mjBo2djFtJPLdIhroS
         ziLuB+3ODowvBXvumXaT4oU9b1fZ+QXCd3F+YMP1Q4clWFTcvNMtt/XGQk4coDli9gmQ
         PRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wiujqhHBG1u+vChiNTLfiUzCMKatKnSUp5prmw5DeT8=;
        b=kO09bmvqtniQdC7eAvXkz+DKvlyAL/R6cWJV6inWV1YV6DbaL5PTg2nMf1ZxlLJrrX
         NLkZI2YQZfFKC17imwIk0VpnfCfU0jG81LX8tmAaiET5oCbd0nBgoXWVD1qVkzr92TNy
         vYM18X+4F3jfQ0xn2RAPak5Bn/UE9v3+zYcRYxNzHJ1zMgII+yjeHc34Rq0xvmqtFrvN
         UDFJm7xsb3mkGZhNGbhVep8KV9EkPBW4ebOc/oqBZVgpA5lTOYuM/fOVxF0wuRRzexMU
         uU3EyLAFyx34L0QTgvc4yV3n6LB8WQd0r8x0SOTWNEstclkcjIXkeHlfeBmSVI/Zj4Gu
         xEew==
X-Gm-Message-State: APjAAAW2XphvaAUbcqzdh/1LfhZmLqJHodGnsy+2JK8HWZ4ZWCElejwE
        TAoy2Bdq5Gm9PgdQnT/1EQ0NIQ==
X-Google-Smtp-Source: APXvYqzBlxbNVjG8lDEznSqv+z/RT5iUL7Uff4XEPrGPllcMOK22V9G8CWMhLR8GKeKkES8GOneCUQ==
X-Received: by 2002:a1c:14e:: with SMTP id 75mr16071820wmb.100.1557743418190;
        Mon, 13 May 2019 03:30:18 -0700 (PDT)
Received: from clegane.local (205.29.129.77.rev.sfr.net. [77.129.29.205])
        by smtp.gmail.com with ESMTPSA id v192sm13645238wme.24.2019.05.13.03.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 03:30:17 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] genirq/timings: Add selftest for irqs circular buffer
Date:   Mon, 13 May 2019 12:29:52 +0200
Message-Id: <20190513102953.16424-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513102953.16424-1-daniel.lezcano@linaro.org>
References: <20190513102953.16424-1-daniel.lezcano@linaro.org>
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

