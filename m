Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE8EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1522085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ToYSnhib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfCRML3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:11:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45541 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbfCRML0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:11:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so1391396wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 05:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bK5pfEUqcjE/r0JENwN9BcU/JSZzzMAgebOVzPlDfQ8=;
        b=ToYSnhib7EXcQ2PSU4Yo/ZHfoGBz84jFDIScP+Wf6rDk/YwpABlVl+3zVEYQiJU3v/
         WcaCZXiDYZGNdRU/tuul8NpikARCwr1qTl7IfsvsTyCCXSyXWIfkZZn4mZ77PWIoTGsq
         oMgVhOjNiCCQ6CbfSup76NrgQkvnSM1+6t6g71ErvmnjhDt5VIMb+CsK+uROpSUPwAZS
         /8BlecD1vE4/IWqon9boygmg01ooLINc83n+hWEt1rQjmG+ybnr8wuloTAdp7OX9H7Wd
         ueIb3Y5viehJMidXIYRT2IlzrVNQPYnfXgn3JxhAnlGNY6EJyvULSQlCAtbbF6Ew4AyX
         RB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bK5pfEUqcjE/r0JENwN9BcU/JSZzzMAgebOVzPlDfQ8=;
        b=mpArSX9eI1UScrYCZRIx+/+cHJx06L3tmg8q9aRv1vHUIb8jdMQRxw3fxBc1MQNo5X
         V7q2648GJNC9ft/7LrVXkoY+BFoi5WmsVCIWorEh60yAFdATUsp18XznZujgzl2RPk+J
         8RUrKO2UQclpE2vppscWN74ETxND/dJRQSnxNmXIAuNjOSjES/hlHAqa38YfvCDVc+3n
         /zuKNyi9uOiD7DfjwSiMAWpbS8cEzltjyI8YiR49+SzXOme1ZnFTEi7kwfEjbNGU9OcC
         GZnzJV7rDM+f5rLLl+TQSEsSQDcrwmfI8gud1Mo14tysQSaW9XeHM3GlxyHYbUTAyLRp
         3S9A==
X-Gm-Message-State: APjAAAWgJXjoQsska8pepzrkKMhy2PtfOZimUb27RtcH2d8HBQCV4Whv
        EwU/bBGmEl2gUh2+C4eiaGgUfw==
X-Google-Smtp-Source: APXvYqzLmvLMb2MO25FAN0hO22IEA8JSy3X5uBSDGvA+L5DZHo7oLRQZb+GiwiAjEHl62n4XVaypUw==
X-Received: by 2002:adf:f089:: with SMTP id n9mr11345446wro.313.1552911084988;
        Mon, 18 Mar 2019 05:11:24 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id n13sm8220132wrw.67.2019.03.18.05.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 05:11:23 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 08/11] ARM: davinci: dm365: switch to using the clocksource driver
Date:   Mon, 18 Mar 2019 13:10:57 +0100
Message-Id: <20190318121100.28132-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318121100.28132-1-brgl@bgdev.pl>
References: <20190318121100.28132-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now have a proper clocksource driver for davinci. Switch the dm365
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/dm365.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 1d82bb630d11..5e93e0b6410b 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -34,7 +34,8 @@
 #include <mach/cputype.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -659,10 +660,16 @@ static struct davinci_id dm365_ids[] = {
 	},
 };
 
-static struct davinci_timer_info dm365_timer_info = {
-	.timers		= davinci_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+/*
+ * Bottom half of timer0 is used for clockevent, top half is used for
+ * clocksource.
+ */
+static const struct davinci_timer_cfg dm365_timer_cfg = {
+	.reg = DEFINE_RES_IO(DAVINCI_TIMER0_BASE, SZ_4K),
+	.irq = {
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT12)),
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT34)),
+	},
 };
 
 #define DM365_UART1_BASE	(IO_PHYS + 0x106000)
@@ -722,7 +729,6 @@ static const struct davinci_soc_info davinci_soc_info_dm365 = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm365_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm365_pins),
-	.timer_info		= &dm365_timer_info,
 	.emac_pdata		= &dm365_emac_pdata,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
@@ -770,6 +776,7 @@ void __init dm365_init_time(void)
 {
 	void __iomem *pll1, *pll2, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM365_REF_FREQ);
 
@@ -788,7 +795,8 @@ void __init dm365_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm365_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 void __init dm365_register_clocks(void)
-- 
2.20.1

