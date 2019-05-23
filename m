Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6EEC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E1B21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Zokiu3YQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbfEWM6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:58:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42916 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730741AbfEWM6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:58:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so6166277wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 05:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nqdpY2LQg8cD0Q7ImVAeUfx8gIe6ICusJd7h8JzZcDE=;
        b=Zokiu3YQNIavDTtCpIhDCFiP/tTPmfP+fqgYKJo/eSQIF2xEh7ytvAN7ICF/k7PLc7
         tOQ6+rz0i77Mx4SY3lHYDlpDV58r3m1URlnKktyRNi4GHYxzcc4/G0SuEOdR2y7UqfYC
         ZylymUqDwchH/8pYuIaHsfIoWVVfQGVIYWe6gV4XFq2OJu2Hql9nVIwcotzEHrvMmbFt
         RdTq9Eu9+npyYM2DM+bO6h+/iPTf/MkAE+qAqouuBwrEd5HdvtZQSqRsBaepJNv3G8D/
         isIB377mlMu0LYPXTYWCiMqLuxeJSWprFcmGvAkcaPFGwWospmDrDny10Ia6wWzREloC
         QApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nqdpY2LQg8cD0Q7ImVAeUfx8gIe6ICusJd7h8JzZcDE=;
        b=aplE2oWbHYPXZXA06U0tyDTXBppsvUKMDREpHiIawsT0T5PYHxBpbHKKiVc5sUIYVM
         lKUAjkM7C1bmJ1UF0PqrO2RMSdCdLyHCA5nUnFG4xWgd/bxBR7pQAjo9P311uSY9wSWH
         JBq0La9njPO4MY0NZqToGQDIZWwqYN5ovKXU1RswCWVhS7deFyIRdXJkRm3VMCdiVZqx
         XO9Raw+J9zvgY5MGCXJI6oU/wgbLPDjmNLtscojEyh281+4hAuKoBQ3gb8DWkvL+IQtj
         aFeikhh+37Gy+MpY+PUP3HcAsz3SXMN8g3NlniDXBhGBIAJHm8gTjOC2M39WV9H5vJ0+
         N1Gg==
X-Gm-Message-State: APjAAAWmgZlPsfOSJ3tt0HwYy5CuxF3m1TJgOYfTvqQ4oqIUCCJ1dPJT
        mueEzcLhEybvUu4X2/QNoAMqDw==
X-Google-Smtp-Source: APXvYqzV/+VY6wKY3Jnwt76G7ppkPUAaS2+L0GpjNPcmnINNdD7bVXm2MCFpzJ4FrzZLFjFNLoSvOA==
X-Received: by 2002:adf:dc84:: with SMTP id r4mr1392200wrj.85.1558616298931;
        Thu, 23 May 2019 05:58:18 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id s13sm9876118wmh.31.2019.05.23.05.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:58:18 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RFC v2 2/2] clocksource: timer-davinci: add support for clocksource
Date:   Thu, 23 May 2019 14:58:13 +0200
Message-Id: <20190523125813.29506-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523125813.29506-1-brgl@bgdev.pl>
References: <20190523125813.29506-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Extend the davinci-timer driver to also register a clock source.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clocksource/timer-davinci.c | 70 +++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index a8fc7b3805c9..c478991da253 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -42,6 +42,8 @@
 #define DAVINCI_TIMER_MIN_DELTA			0x01
 #define DAVINCI_TIMER_MAX_DELTA			0xfffffffe
 
+#define DAVINCI_TIMER_CLKSRC_BITS		32
+
 #define DAVINCI_TIMER_TGCR_DEFAULT \
 		(DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED | DAVINCI_TIMER_UNRESET)
 
@@ -61,6 +63,16 @@ struct davinci_clockevent {
 	unsigned int enamode_mask;
 };
 
+/*
+ * This must be globally accessible by davinci_timer_read_sched_clock(), so
+ * let's keep it here.
+ */
+static struct {
+	struct clocksource dev;
+	void __iomem *base;
+	unsigned int tim_off;
+} davinci_clocksource;
+
 static struct davinci_clockevent *
 to_davinci_clockevent(struct clock_event_device *clockevent)
 {
@@ -159,6 +171,32 @@ static irqreturn_t davinci_timer_irq_timer(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static u64 notrace davinci_timer_read_sched_clock(void)
+{
+	return readl_relaxed(davinci_clocksource.base +
+			     davinci_clocksource.tim_off);
+}
+
+static u64 davinci_clocksource_read(struct clocksource *dev)
+{
+	return davinci_timer_read_sched_clock();
+}
+
+static void davinci_clocksource_init(void __iomem *base, unsigned int tim_off,
+				     unsigned int prd_off, unsigned int shift)
+{
+	davinci_tcr_update(base,
+			   DAVINCI_TIMER_ENAMODE_MASK << shift,
+			   DAVINCI_TIMER_ENAMODE_DISABLED << shift);
+
+	writel_relaxed(0x0, base + tim_off);
+	writel_relaxed(UINT_MAX, base + prd_off);
+
+	davinci_tcr_update(base,
+			   DAVINCI_TIMER_ENAMODE_MASK << shift,
+			   DAVINCI_TIMER_ENAMODE_ONESHOT << shift);
+}
+
 static void davinci_timer_init(void __iomem *base)
 {
 	/* Set clock to internal mode and disable it. */
@@ -248,6 +286,38 @@ int __init davinci_timer_register(struct clk *clk,
 					DAVINCI_TIMER_MIN_DELTA,
 					DAVINCI_TIMER_MAX_DELTA);
 
+	davinci_clocksource.dev.rating = 300;
+	davinci_clocksource.dev.read = davinci_clocksource_read;
+	davinci_clocksource.dev.mask =
+			CLOCKSOURCE_MASK(DAVINCI_TIMER_CLKSRC_BITS);
+	davinci_clocksource.dev.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+	davinci_clocksource.base = base;
+
+	if (timer_cfg->cmp_off) {
+		davinci_clocksource.dev.name = "tim12";
+		davinci_clocksource.tim_off = DAVINCI_TIMER_REG_TIM12;
+		davinci_clocksource_init(base,
+					 DAVINCI_TIMER_REG_TIM12,
+					 DAVINCI_TIMER_REG_PRD12,
+					 DAVINCI_TIMER_ENAMODE_SHIFT_TIM12);
+	} else {
+		davinci_clocksource.dev.name = "tim34";
+		davinci_clocksource.tim_off = DAVINCI_TIMER_REG_TIM34;
+		davinci_clocksource_init(base,
+					 DAVINCI_TIMER_REG_TIM34,
+					 DAVINCI_TIMER_REG_PRD34,
+					 DAVINCI_TIMER_ENAMODE_SHIFT_TIM34);
+	}
+
+	rv = clocksource_register_hz(&davinci_clocksource.dev, tick_rate);
+	if (rv) {
+		pr_err("Unable to register clocksource");
+		return rv;
+	}
+
+	sched_clock_register(davinci_timer_read_sched_clock,
+			     DAVINCI_TIMER_CLKSRC_BITS, tick_rate);
+
 	return 0;
 }
 
-- 
2.21.0

