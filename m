Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F82C48BE3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAE5208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="aL+jleWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfFXJvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:51:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47026 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfFXJvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:51:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so13119994wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 02:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ERvP18ElM9iGQv4olP0pOB1DAN2oRrtEk4GL0uEhELg=;
        b=aL+jleWNR+s/HGePYfp2hzCjk2Cqss5aN1Pen0BBQN/vvUB2MtZAwiaXDd1M7KTXK2
         dp8xePAr7iXNbH9xwG6K5YZYiiG2rVXFn4qBOND+t6nS3CIqWKjOTLWfBe3/wazN2VG4
         dNOHnlU+uBHvguLS4e2jDcFyWlKi4iKR01RTIEA1Y1pPP6xFg7pv2imo/gE+jvDzIRiC
         M+rFjrO9TMCKl4n4nMmZ6qqGHRQDi0YMKS4VcP016Dc6VCAuG05BYxW6iWrBUGZPi4w6
         ck8YYiDxICHLiYKqZJbiXu++E7d2x64v4SOjmhRqPIHOXpc+bWET8F4b4Wz9vppO7HMq
         ZBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ERvP18ElM9iGQv4olP0pOB1DAN2oRrtEk4GL0uEhELg=;
        b=efoqrlIGKLWg1lv5i74VrVCvtndp3pkKQ7MmAdFHVY+SjPznX5GQhtXpLnkzzcMxmk
         8ux38QV0F4UfHbwjoMVsawsQoq8a5qv0cHaUKrDQqKh6InFkRUsP4CtUDQpN9hu08aJU
         Ih/5GfEVtwDOQqPrvROMFypTLhEjrlUqlMuCwMu8CMCyLz9qBG9fhdH6Tvk3yyxEnSRE
         4qFBNn0RKc/HnipkpDe+VUea5uTQuyxzinbmit9hRPDYmKtuf4BONOCwGbEbRARNFYQt
         fUMBmawO/zPEJ6Of6K4r27+p1cNqqJbaNS3Ic+OlLcvDZ6lqYq2371xP0OJ6ryWFYItm
         FGtQ==
X-Gm-Message-State: APjAAAVLaz0gB/R7Ui52u+qEGcecSPah/zW2XdL82S2uV7+PtgyTmuLT
        p3U+VPInfduNG7sLbyfH2ZdWTQ==
X-Google-Smtp-Source: APXvYqzkwcamwoa1d7Z8HD1hnxyuHpQAATvcOA4Jo91j164N2alX6vLeBu5frBqlmjPNEN0HlFqwiA==
X-Received: by 2002:adf:eb4e:: with SMTP id u14mr10825792wrn.168.1561369861508;
        Mon, 24 Jun 2019 02:51:01 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id y17sm17364483wrg.18.2019.06.24.02.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 02:51:00 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v8 2/2] clocksource: timer-davinci: add support for clocksource
Date:   Mon, 24 Jun 2019 11:50:56 +0200
Message-Id: <20190624095056.21296-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190624095056.21296-1-brgl@bgdev.pl>
References: <20190624095056.21296-1-brgl@bgdev.pl>
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
2.21.0

