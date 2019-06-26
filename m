Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1827BC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10032080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BpPX0SlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfFZOsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:48:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41880 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbfFZOr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:47:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so3060783wrm.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pZpH6RCNGAxgK3hStX/EjA5VCFJvxP+EAUqW2EeEzuo=;
        b=BpPX0SlVOzgY+4ZuFT2sIfbqsZ8dvsqmx6zUd7W/njJpS4giirBzHLSd8Ju1XaEInW
         s9SBcYeTsFWVE5A+IXMRQDZRwOCKX0IfzAnWOF+b1mk75zVXwr9F/W1kU2L8/2lc8tfZ
         7n5vzujBQSwViuyC04vOYNQZXoIfnaTaQEc9wJjszcyEUwdxNyiWoIWIqC9VCpBIIQvr
         vN907EPgPL7Wqlv8gdExkpNMfPIudb4YIR9KuA5exwVSbFOh+sT5tyhWDXVpWDdApqmZ
         r36yOAlNvNRZOZjhVifOyRPqxm91gmJT5pQ0Ixyt4vmwDS3f/XTxrFexr0vMZw3kVtFF
         TJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pZpH6RCNGAxgK3hStX/EjA5VCFJvxP+EAUqW2EeEzuo=;
        b=OI5st5nCP8cKkZ5J+LL8Uho+3Yhr5BVgW+ON+M1senP8kIm0rv2mk78K68dPHokaII
         doQbbfSmOGxaQZgTwUfhhTwDgBGusNbiVwZNq1qm3N8Og05ZTNiE//FhDkNmLiVaKvpV
         h0cuQjVVZHbifJhCBHO8oPERzctRAwv1iFH98MeRXfv6e2f2CW3VQ5Khh+4hJN1B/VrO
         hMZWD3c7Wpslwts9Jf7pwY/ISzkFBu86E8uE5yMkIMftMOxG/2wbLbcJ5RkLSP6FBmvG
         g2g4TcCYc4tdouIY1dF+Ou3UjZtaO0MYPrmWlTVv5DBSGcI2kAFSSvaWBqyTHHnvS8yb
         HLeQ==
X-Gm-Message-State: APjAAAWB+mSYQfD+fXW4gO63Paa2QV1ltcSbDyfBAU5oiW4eKhQYn5PM
        ap2q9IfHjVqBSCKLpBFU6z1gmQ==
X-Google-Smtp-Source: APXvYqwloGDE0/VRQ+C+dM+WYgCa103weguCtbDmtqg1ESrVDz0CqEN6ocCCi/rgXZnwQzOgOD694g==
X-Received: by 2002:adf:fe4e:: with SMTP id m14mr4263040wrs.21.1561560476230;
        Wed, 26 Jun 2019 07:47:56 -0700 (PDT)
Received: from mai.imgcgcw.net (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.gmail.com with ESMTPSA id h84sm2718557wmf.43.2019.06.26.07.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:47:55 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 25/25] clocksource/drivers/davinci: Add support for clocksource
Date:   Wed, 26 Jun 2019 16:46:51 +0200
Message-Id: <20190626144651.16742-25-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626144651.16742-1-daniel.lezcano@linaro.org>
References: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
 <20190626144651.16742-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Extend the davinci-timer driver to also register a clock source.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-davinci.c | 85 +++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index 246a5564495d..62745c962049 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -43,6 +43,8 @@
 #define DAVINCI_TIMER_MIN_DELTA			0x01
 #define DAVINCI_TIMER_MAX_DELTA			0xfffffffe
 
+#define DAVINCI_TIMER_CLKSRC_BITS		32
+
 #define DAVINCI_TIMER_TGCR_DEFAULT \
 		(DAVINCI_TIMER_TIMMODE_32BIT_UNCHAINED | DAVINCI_TIMER_UNRESET)
 
@@ -52,6 +54,16 @@ struct davinci_clockevent {
 	unsigned int cmp_off;
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
@@ -166,6 +178,53 @@ static irqreturn_t davinci_timer_irq_timer(int irq, void *data)
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
+/*
+ * Standard use-case: we're using tim12 for clockevent and tim34 for
+ * clocksource. The default is making the former run in oneshot mode
+ * and the latter in periodic mode.
+ */
+static void davinci_clocksource_init_tim34(void __iomem *base)
+{
+	int tcr;
+
+	tcr = DAVINCI_TIMER_ENAMODE_PERIODIC <<
+		DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;
+	tcr |= DAVINCI_TIMER_ENAMODE_ONESHOT <<
+		DAVINCI_TIMER_ENAMODE_SHIFT_TIM12;
+
+	writel_relaxed(0x0, base + DAVINCI_TIMER_REG_TIM34);
+	writel_relaxed(UINT_MAX, base + DAVINCI_TIMER_REG_PRD34);
+	writel_relaxed(tcr, base + DAVINCI_TIMER_REG_TCR);
+}
+
+/*
+ * Special use-case on da830: the DSP may use tim34. We're using tim12 for
+ * both clocksource and clockevent. We set tim12 to periodic and don't touch
+ * tim34.
+ */
+static void davinci_clocksource_init_tim12(void __iomem *base)
+{
+	unsigned int tcr;
+
+	tcr = DAVINCI_TIMER_ENAMODE_PERIODIC <<
+		DAVINCI_TIMER_ENAMODE_SHIFT_TIM12;
+
+	writel_relaxed(0x0, base + DAVINCI_TIMER_REG_TIM12);
+	writel_relaxed(UINT_MAX, base + DAVINCI_TIMER_REG_PRD12);
+	writel_relaxed(tcr, base + DAVINCI_TIMER_REG_TCR);
+}
+
 static void davinci_timer_init(void __iomem *base)
 {
 	/* Set clock to internal mode and disable it. */
@@ -247,6 +306,32 @@ int __init davinci_timer_register(struct clk *clk,
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
+		davinci_clocksource_init_tim12(base);
+	} else {
+		davinci_clocksource.dev.name = "tim34";
+		davinci_clocksource.tim_off = DAVINCI_TIMER_REG_TIM34;
+		davinci_clocksource_init_tim34(base);
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
2.17.1

