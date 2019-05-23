Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CDEC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7962133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdkfpTzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731432AbfEWSRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 14:17:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34074 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731116AbfEWSRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:17:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id j24so6386021ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 11:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xVLMianANhzmplrg1DNs0WltvutEsn5MSIrShEnvZRs=;
        b=RdkfpTzn1ySwEf5C0dPq9Xu8VAtMSRYp5nqkCifYfl2954qRZjU8S941ZehD0289HL
         58K0W3gbNY0XtItxxEIvZLiwWVn1sLiqtYNd7lQM0vYdx6DkZlVN7jkBwDBf/mXLVycl
         ArBHla/sB4OasDKtIJSLgeX0vxbwwMOtAT4NXn+dcCnsCXH6ZDh0lQRKLsddOWX+WeVk
         +5p0XrrH4ef9bu5LSLyoV6dsW0sRFgsd0HdVh+N1PsV0gaD/UUJIYTRVzPE62b3YlZLH
         e22o8RjJ4D2nPi9Bo8PLaxoUrhy5o31ZHYaGHn+h1ZnjbieCNUdpwUU/m1IEEOHjQx6K
         N/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xVLMianANhzmplrg1DNs0WltvutEsn5MSIrShEnvZRs=;
        b=gu1EPQ4r0CqzD4md6/c7t+8wfwSl47immuUAhHWcnwFIKo26UU10uF7xPucZiKQOlT
         9gHHM3FKd6IZbyWRKMyuJTqGSI9slsANeA+hxgjc4URI7NiHZSo3d5osS2ol1L9uOZeE
         kmDvLlz73oH7RxWjfDsYyl8BDD/Sqh3iRjN2MLW2e4CG4+4sDfbiSceNtHZjFq9bZ3F/
         +REtembdvy3uZVYton84fhy/C7es7xnkBo5jiNKKwJApBfkTE3sP2e4FOZi7RBye+9Jo
         Qv+Uxbekr/JOtleXjlP1ue3TM7NfOOjHYdD47aFtuSbCTeeExKGvZWCrAV+whGBh+GS4
         Y2Kg==
X-Gm-Message-State: APjAAAUFav7fCTl2v9UNMM7q3TgD4xUGYnEF9PyqQheAF1lzOAQfpTAF
        BjCnkqVzBfKCysheylnp8mMV748aqkY=
X-Google-Smtp-Source: APXvYqxOibtzonsAh4V+NOrhPL4OVGZW3bjzOhPFSsQU0m7+fukLbOnsoQ8owCi9RrqtCTA7+i7P+A==
X-Received: by 2002:a2e:9581:: with SMTP id w1mr35368191ljh.88.1558635429076;
        Thu, 23 May 2019 11:17:09 -0700 (PDT)
Received: from linux.local (c-d2cd225c.014-348-6c756e10.bbcust.telenor.se. [92.34.205.210])
        by smtp.gmail.com with ESMTPSA id z9sm52209lfa.25.2019.05.23.11.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 11:17:07 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] clocksource/drivers/ixp4xx: Implement delay timer
Date:   Thu, 23 May 2019 20:16:02 +0200
Message-Id: <20190523181602.3284-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds delay timer functionality to the IXP4xx
timer driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
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
2.20.1

