Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF358C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AB92075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="AK2aEHYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfFEIdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:33:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34939 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfFEIdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:33:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so2704416wrv.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 01:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EhWbTT+5eo9QxU62r83O6HwrMSm/jGTQFiSriaCzgkM=;
        b=AK2aEHYTMTTgembsknTlJHO7cTfazErya1CARRNO412kTQtZZwciskduOJwC7xOvU5
         LqSiTAOhK8ce/VK/XaV+rETEZ/lUS+TGhvieAKZB0Zhl896sb+IMBTuiZUwZUuN5otCd
         Pp2GJgftRcEQF+/WtYrf/qotOCzuycu0CzOJqgbgHm8F0Dv1neTVLbY9U9uaHI9vbra0
         yYBE7e8LVz+yZH+qqPlZ1Rs89hKTknumavPZD0d1SZnGfKHf67Z795tuNv/VA6Z51PsV
         4tWJ1VrFt6v54jCITuwRoM/06DImisumMC3flcJVFPzfSeAUTwWB3iqFTuZca3gwW5Ie
         +gTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EhWbTT+5eo9QxU62r83O6HwrMSm/jGTQFiSriaCzgkM=;
        b=Y8Gwc+bFtg+ADikB9M8/DPnYJsGQCF+gs4JVfV30HFZZk8/JuPoqqiphwTgNjjcxrW
         n+N3lmLe6w6+LeKHkN6pWy83kfZJ6p4zmXdMlJ/WXb9+xn0k5lTTl4Iifd6dPonl4WUF
         fG0l9cmeh1W5fGhLehr4g6tu6aqSAujihgIo2WmawSP9Czu4MD2HMCa3YvubN1zUsD3G
         w4pRouQNaBfKA/YMIqXvgJH6NF34jsiEaACzbfBgJYAJULdCDUXGuvcsNzrFTkE9ZLV5
         FowEzOYVGQFCd/KB0kWoXNoMuA8tM1M63A7O4OmNw6FY5yJNsJG2hR6QUudX/GY05kRJ
         p/ww==
X-Gm-Message-State: APjAAAW64Y2+kZu1zwDrKw9aAoPonf2offjPOq/tUI8reTFBlCoYbEWk
        Cg7s31y9qAQqn8GE+Z0PXHzfCw==
X-Google-Smtp-Source: APXvYqyrCBsPATmm5vC/XIiRQElJ1rdn5hHqIVJpfncoQGU5Wr7iMS8GBrOw0qC/dDqJRRyumd++Sg==
X-Received: by 2002:adf:b447:: with SMTP id v7mr24254105wrd.267.1559723621218;
        Wed, 05 Jun 2019 01:33:41 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b5sm15274471wrx.22.2019.06.05.01.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 01:33:40 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RFC v3 2/2] clocksource: timer-davinci: add support for clocksource
Date:   Wed,  5 Jun 2019 10:33:34 +0200
Message-Id: <20190605083334.22383-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605083334.22383-1-brgl@bgdev.pl>
References: <20190605083334.22383-1-brgl@bgdev.pl>
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
 drivers/clocksource/timer-davinci.c | 85 +++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index f8959dccae54..a9ca02390b66 100644
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
@@ -248,6 +307,32 @@ int __init davinci_timer_register(struct clk *clk,
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
2.21.0

