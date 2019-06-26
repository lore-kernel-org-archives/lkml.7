Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533ADC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214AD2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o/YR4KLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfFZOrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:47:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56311 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbfFZOrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:47:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so2399448wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WDX9H0FW6Px0pSdZdykt6dt3zN2IzeMqp5Ci6/xL3gc=;
        b=o/YR4KLnGSN3XUxQDXbXMNiN2apYzQh8iQpRdw2hWfZn6ibwTDytmy8ySv9X0XN8FU
         +LS8SiO/GwArWQ8izxACyxv2edQ7fsNFHq/3jMVw3a7/y4xXDuaqdGpw7y8+gJ6n/jcT
         +0qZqrHr2gBXh+GcBeOq9MA7CO1QMmbk1PE5hZ84ZVQ+GNQiGXjlAWZ4GRi+ZVlPp8z5
         acviqjJXy1lGHttwxdHqLJjOz6Cpkh0RsqsL3HYJnj/P7El4cFSDSFWXFSoZ1f4fUJx7
         lC6G2j/EYzugzUw3Yv+OPQxVbrELyk5B2zU/4L+l8PugvYFso3ffrf3OpGjp9cxXlTke
         e/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WDX9H0FW6Px0pSdZdykt6dt3zN2IzeMqp5Ci6/xL3gc=;
        b=eP483N0pSvZj2OpDgIUC0xhsh80JOGLZpvpPEogqCJfwzxgnVEW9qgXNBR2wr5jwYZ
         9xOIKdwIkMBMegTMwVpdSzpOLDfz1Nuca1TIElUXCDtefcnYh3g+JlVaCWzKiTbtlXjg
         037UIvPtvJj2WBB5D05XcYGseoNUP/dmLiFJwiDm9Cpr5975ER/evgLYGfx1oKstgo9K
         Gtr4xhQBDgpNusqFQPUAWUw/yc0n7oxuPOjHJum2HPu69eOwpcjj9Cj964uz4aruPEjQ
         N9mWTkD2wnGL4qbpggDuOVcLI1aXg7w1hke6XEIyRs7qjzVuAe9ZH/WfPKQO3zT0kruz
         /TfA==
X-Gm-Message-State: APjAAAUubvuuHVOIrh2o1Rs0aoApwukYg7JtefJ4bTOVLD78XswCj9XL
        D7kaczTjuit8FfaVpo94lMcs3w==
X-Google-Smtp-Source: APXvYqyr2ZM+AvozOpHLwYocqUFpcS89XTwzgRSRq5c60tOhxeGy5YHRwQyU8KfMMZ3h3QRq4y0oKQ==
X-Received: by 2002:a05:600c:1150:: with SMTP id z16mr2907355wmz.168.1561560433845;
        Wed, 26 Jun 2019 07:47:13 -0700 (PDT)
Received: from mai.imgcgcw.net (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.gmail.com with ESMTPSA id h84sm2718557wmf.43.2019.06.26.07.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:47:13 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/INTEL IXP4XX
        ARM ARCHITECTURE)
Subject: [PATCH 02/25] clocksource/drivers/ixp4xx: Implement delay timer
Date:   Wed, 26 Jun 2019 16:46:28 +0200
Message-Id: <20190626144651.16742-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626144651.16742-1-daniel.lezcano@linaro.org>
References: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
 <20190626144651.16742-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

This adds delay timer functionality to the IXP4xx
timer driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-ixp4xx.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-ixp4xx.c b/drivers/clocksource/timer-ixp4xx.c
index 5c2190b654cd..9396745e1c17 100644
--- a/drivers/clocksource/timer-ixp4xx.c
+++ b/drivers/clocksource/timer-ixp4xx.c
@@ -75,14 +75,19 @@ to_ixp4xx_timer(struct clock_event_device *evt)
 	return container_of(evt, struct ixp4xx_timer, clkevt);
 }
 
-static u64 notrace ixp4xx_read_sched_clock(void)
+static unsigned long ixp4xx_read_timer(void)
 {
 	return __raw_readl(local_ixp4xx_timer->base + IXP4XX_OSTS_OFFSET);
 }
 
+static u64 notrace ixp4xx_read_sched_clock(void)
+{
+	return ixp4xx_read_timer();
+}
+
 static u64 ixp4xx_clocksource_read(struct clocksource *c)
 {
-	return __raw_readl(local_ixp4xx_timer->base + IXP4XX_OSTS_OFFSET);
+	return ixp4xx_read_timer();
 }
 
 static irqreturn_t ixp4xx_timer_interrupt(int irq, void *dev_id)
@@ -224,6 +229,13 @@ static __init int ixp4xx_timer_register(void __iomem *base,
 
 	sched_clock_register(ixp4xx_read_sched_clock, 32, timer_freq);
 
+#ifdef CONFIG_ARM
+	/* Also use this timer for delays */
+	tmr->delay_timer.read_current_timer = ixp4xx_read_timer;
+	tmr->delay_timer.freq = timer_freq;
+	register_current_timer_delay(&tmr->delay_timer);
+#endif
+
 	return 0;
 }
 
-- 
2.17.1

