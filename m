Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6106C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 10:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C397206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 10:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="a9IhZppL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfLXKDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 05:03:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40749 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfLXKDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 05:03:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so19363415wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 02:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IOU/3rF9+fuzA5asqkKAmzkuulu7zyIHvx1EjERPIsc=;
        b=a9IhZppL5a8/+KLGjQ8Z/Hg37A+/pBB0A5pgOJ2JSDBsBCYTY6cmA0C2xu/OrvI57M
         MXEu9cJ8opTXxf+4OeOlK2PEtD/iglKIw0DmL3dLwXCc0k1z0KTYrOhDXlG2WA3WsHX/
         XcJVf9oWdXi515QH0//c5j0Hn8M9Sqqu+yKHIwuQBHSUceG3lhDE8RkMl/4WIPGm73cA
         /Lrwv5V39LeG6yjbE4iq8kBCKMvPNykT5DGCE6feHnkNcgc4j9FORJ+pL7FcGjDXWBij
         4vt0URC1rMSQx/up8KKB4XA5euN/zOxiMaWJ1gBKszClbhz2PuB/RCImS5d1JRqg3lnj
         x/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IOU/3rF9+fuzA5asqkKAmzkuulu7zyIHvx1EjERPIsc=;
        b=pHd6jvgJoDWRebDPUfXrK/DP3OPdR+YuDWJ+SlV3Tu47I1i2o121fE7+QlumvWb80K
         V5wcey42USD39k6Uxlv2aUrdEHqNurhtllGT9RW0shETK4c6tLuA48e+3wT9MOVeke3z
         FJcivSChBuVg9SqoVC+EfL6vbsNiMQ4NdWy6rTtnzZEgy0KULqLtB94qHp89n7GIexc4
         jYO9lml4vFcdkeni16kIdQIlAf4+ehghBFolZq/Yg/hujAzV9tCrzPL/Djb/oRC6LByj
         C0NEOkzRZfeAfQYYCjUObDPE1EXCgk86Qzenf9oC3wDWRhFvUCo6JXs/xq2tpRdGPdNE
         w6zg==
X-Gm-Message-State: APjAAAVRxr4LMRxK2JREfUdQ2jjddFrvu1H150dDWi2PIm87r+xgEDpe
        8oxoR1F4vcCGELJ50dNstV4d1oCybCc=
X-Google-Smtp-Source: APXvYqz/w1dmLmweJHLlEnDCKSnJsQ2/Bj2X/bPyXS+HazNTW+SKi+yFKfSZtSIJaG7d9Y1kufjboQ==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr34681699wru.220.1577181813740;
        Tue, 24 Dec 2019 02:03:33 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a184sm2164048wmf.29.2019.12.24.02.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 02:03:33 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/3] clocksource: davinci: only enable tim34 in periodic mode once it's initialized
Date:   Tue, 24 Dec 2019 11:03:26 +0100
Message-Id: <20191224100328.13608-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191224100328.13608-1-brgl@bgdev.pl>
References: <20191224100328.13608-1-brgl@bgdev.pl>
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
is straightforward - don't enable the tim34 timer in periodic mode until
it's properly initialized.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clocksource/timer-davinci.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index 62745c962049..2801f21bb0e2 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -62,6 +62,7 @@ static struct {
 	struct clocksource dev;
 	void __iomem *base;
 	unsigned int tim_off;
+	bool initialized;
 } davinci_clocksource;
 
 static struct davinci_clockevent *
@@ -94,8 +95,9 @@ static void davinci_tim12_shutdown(void __iomem *base)
 	 * halves. In this case TIM34 runs in periodic mode and we must
 	 * not modify it.
 	 */
-	tcr |= DAVINCI_TIMER_ENAMODE_PERIODIC <<
-		DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;
+	if (likely(davinci_clocksource.initialized))
+		tcr |= DAVINCI_TIMER_ENAMODE_PERIODIC <<
+		       DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;
 
 	writel_relaxed(tcr, base + DAVINCI_TIMER_REG_TCR);
 }
@@ -107,8 +109,9 @@ static void davinci_tim12_set_oneshot(void __iomem *base)
 	tcr = DAVINCI_TIMER_ENAMODE_ONESHOT <<
 		DAVINCI_TIMER_ENAMODE_SHIFT_TIM12;
 	/* Same as above. */
-	tcr |= DAVINCI_TIMER_ENAMODE_PERIODIC <<
-		DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;
+	if (likely(davinci_clocksource.initialized))
+		tcr |= DAVINCI_TIMER_ENAMODE_PERIODIC <<
+		       DAVINCI_TIMER_ENAMODE_SHIFT_TIM34;
 
 	writel_relaxed(tcr, base + DAVINCI_TIMER_REG_TCR);
 }
@@ -206,6 +209,8 @@ static void davinci_clocksource_init_tim34(void __iomem *base)
 	writel_relaxed(0x0, base + DAVINCI_TIMER_REG_TIM34);
 	writel_relaxed(UINT_MAX, base + DAVINCI_TIMER_REG_PRD34);
 	writel_relaxed(tcr, base + DAVINCI_TIMER_REG_TCR);
+
+	davinci_clocksource.initialized = true;
 }
 
 /*
-- 
2.23.0

