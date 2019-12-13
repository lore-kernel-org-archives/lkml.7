Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F994C4BA0D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A516C246F5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="NXXw8HE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfLMQZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:25:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41186 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbfLMQZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:25:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so33851wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 08:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EcTch/EIkIolmThjjfl6zE4yda6WGySYg3PDvCnto3E=;
        b=NXXw8HE7mg0jRivRwjGhCSh1VgLhxcoWn6OtiAErL4YEF0RAL0AHHvcSaaCruxyyi/
         woJdaICHqRvKCC0hh327fcS6CIuZq5F3F0w9kf+++rQMgRof1Bmz0xOqWcmiUXO9qvoz
         yOHVS1sQCfiFhK1ItXhdBPrwEDyky5R9qEtPgSH35K1o7NHaf9RTaZ7jHhKrypMV4IgE
         L/kJT5BEjGgpupRxlve+S3HVdxo7vk1k6ceE9tcTvWb8OruFepNFRhfuzZ+4zFO9eIOw
         3AuYMuR+SK0yBn53HmDZORGoHPn2/babeFTT9ozj4HQUEJwjU8oWs1dxrDpD7qbGU50E
         Nt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EcTch/EIkIolmThjjfl6zE4yda6WGySYg3PDvCnto3E=;
        b=A+vL/nGLvEiU3B2zdXLra0ZEqJxrpfhVsdwiWf1zE8+HKCzqSuDUsG/fZ7qyoRKYr7
         +scNRQvBtioTcW0QHAOXT+FrtCmpcjo5TOCEq5GhQ9am7bFJvW9AM2+DpVJ8W+/3XJHX
         72fb3Z4XmQMHauww31pMblbuMBWbw0AapRi8nw7bIH0bhuWDkXtO5A7+yDYZscwK6yyf
         8+kEkHP7VbxyzNTQeLqpvt3RtQb2G2LhwsNwRQlW+l17Vmrj6aKHXMuaz93oqfzaI/tw
         62N2JFLGPzB6TkRjcuPSDiwZpKM4/1jbifuU+xf9IBtC2vsk0Pw+0rTCo7hbyyUGumWi
         uVNw==
X-Gm-Message-State: APjAAAX0s3CQJnwOMy3KOtiIDboFSmPOI31KD082z+pvvJQLdg//lk52
        aQcGGksv3qZq3J4nj5yPhkj63Q==
X-Google-Smtp-Source: APXvYqy4DODPLOmqcXekbJRCf0m9ORveR71Qo5kLQgcGlDibqDyMSLStnwpOd7kDPDBP5ZV9ezD1JA==
X-Received: by 2002:a5d:630c:: with SMTP id i12mr13511596wru.350.1576254307421;
        Fri, 13 Dec 2019 08:25:07 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:3d17:b245:8f4:3043])
        by smtp.gmail.com with ESMTPSA id h8sm11139330wrx.63.2019.12.13.08.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 08:25:06 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/3] clocksource: davinci: work around a clocksource problem on dm365 SoC
Date:   Fri, 13 Dec 2019 17:24:51 +0100
Message-Id: <20191213162453.15691-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191213162453.15691-1-brgl@bgdev.pl>
References: <20191213162453.15691-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The DM365 platform has a strange quirk (only present when using ancient
u-boot - mainline u-boot v2013.01 and later works fine) where if we
enable the second half of the timer in periodic mode before we do its
initialization - the time won't start flowing and we can't boot.

When using more recent u-boot, we can enable the timer, then reinitialize
it and all works fine.

I've been unable to figure out why that is, but a workaround for this
is straightforward - just cache the enable bits for tim34.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clocksource/timer-davinci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index 62745c962049..1c22443acaeb 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -64,6 +64,8 @@ static struct {
 	unsigned int tim_off;
 } davinci_clocksource;
 
+static unsigned int davinci_clocksource_tim32_mode;
+
 static struct davinci_clockevent *
 to_davinci_clockevent(struct clock_event_device *clockevent)
 {
@@ -94,7 +96,7 @@ static void davinci_tim12_shutdown(void __iomem *base)
 	 * halves. In this case TIM34 runs in periodic mode and we must
 	 * not modify it.
 	 */
-	tcr |= DAVINCI_TIMER_ENAMODE_PERIODIC <<
+	tcr |= davinci_clocksource_tim32_mode <<
 		DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;
 
 	writel_relaxed(tcr, base + DAVINCI_TIMER_REG_TCR);
@@ -107,7 +109,7 @@ static void davinci_tim12_set_oneshot(void __iomem *base)
 	tcr = DAVINCI_TIMER_ENAMODE_ONESHOT <<
 		DAVINCI_TIMER_ENAMODE_SHIFT_TIM12;
 	/* Same as above. */
-	tcr |= DAVINCI_TIMER_ENAMODE_PERIODIC <<
+	tcr |= davinci_clocksource_tim32_mode <<
 		DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;
 
 	writel_relaxed(tcr, base + DAVINCI_TIMER_REG_TCR);
@@ -206,6 +208,8 @@ static void davinci_clocksource_init_tim34(void __iomem *base)
 	writel_relaxed(0x0, base + DAVINCI_TIMER_REG_TIM34);
 	writel_relaxed(UINT_MAX, base + DAVINCI_TIMER_REG_PRD34);
 	writel_relaxed(tcr, base + DAVINCI_TIMER_REG_TCR);
+
+	davinci_clocksource_tim32_mode = DAVINCI_TIMER_ENAMODE_PERIODIC;
 }
 
 /*
-- 
2.23.0

