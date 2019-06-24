Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE11C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96EF2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="l8J08YKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfFXNOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:14:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55270 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbfFXNOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:14:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id g135so12741506wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 06:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1TfWHxtQiNmrkXujZYAI0hTn+BhOSphr+TltX20vVaQ=;
        b=l8J08YKOJwmACjfUIJ6uTeyI84leHPXXrAsSJdkYuXh/C0wYpl1bSyZY5J24slwT26
         txxLOJB5wXk8R18kMLgB+YMGCzMUekRAHFhwZG6KrXx476j0BDbMlxTNzrVMU9PjRtf+
         85d8a+7N+KD4mbGVVA91GaMKU/HaJuBOgbtTq4lZTRUynKqvlILjx/MpkHQKy71FBAJu
         ukiYVQ8lxIXkjfnHzo0myBt5MviE26zfaoSD22gy3ACl5P1u+zQQNz6QWu8FlWmHgQgR
         8Lia1aJtVCdXCuAa7/Zp5pxkkgYnvFOHUJ/2y0xXIRVj9gvRH7R3H0OmUtpclSFxuC9T
         kT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1TfWHxtQiNmrkXujZYAI0hTn+BhOSphr+TltX20vVaQ=;
        b=fz7KEZrRSGllt4+y0yWZmqt5F57ZRKgmZdnmqlkrFbTeMGQVIAUkF8f7lrtZwpC/YJ
         t4kQ1t7EKxYrdJIVJB19p9CjkGWPVWIX5Wy8wdcJ7/TeP5SzK+p2hWyIytgQrwlf9pmq
         wEc16SuKEVFCNdez2nVrqa/aPt33D8Pi1/2HmVZbASbUNXDHzmP9sqoMTdbwoQvLPiOP
         ONPt1e6uXWLwg/eXWTQJ6LHIJ8jtz1DHHJ/EHdEpkLsSVHss1mESuv5GwekmpEvHBTLG
         vREanWDvp4+k1VizQPb2+hmOvs8HpJqiw5hCWErcGk2wZK0PjV64wWwkvODzNwuXYBoa
         Fcsw==
X-Gm-Message-State: APjAAAUCuvoabTS6PoAfGLB78DtnhZGfkpiFpYf79XdPC3kbFbNBqrh5
        6ZBkFGQ3GPUIK2+RtB9ehLseog==
X-Google-Smtp-Source: APXvYqyRnmxp6bUCbPDH2fq2z5NQMTVyYIuWTnDzzhr051yMPH4j4YLQm/OSpS6v4oJlyS2ycgd+vQ==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr16593611wmf.7.1561382044414;
        Mon, 24 Jun 2019 06:14:04 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id y2sm9535526wrl.4.2019.06.24.06.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:14:03 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 03/10] ARM: davinci: da850: switch to using the clocksource driver
Date:   Mon, 24 Jun 2019 15:13:44 +0200
Message-Id: <20190624131351.3732-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190624131351.3732-1-brgl@bgdev.pl>
References: <20190624131351.3732-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now have a proper clocksource driver for davinci. Switch the da850
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/da850.c | 46 ++++++++++-------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index dcf3536c46bc..73b7cc53f966 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -35,7 +35,8 @@
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
 #include <mach/pm.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "irqs.h"
 #include "mux.h"
@@ -333,38 +334,16 @@ static struct davinci_id da850_ids[] = {
 	},
 };
 
-static struct davinci_timer_instance da850_timer_instance[4] = {
-	{
-		.base		= DA8XX_TIMER64P0_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_0),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_0),
-	},
-	{
-		.base		= DA8XX_TIMER64P1_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_1),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_1),
-	},
-	{
-		.base		= DA850_TIMER64P2_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA850_TINT12_2),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA850_TINT34_2),
-	},
-	{
-		.base		= DA850_TIMER64P3_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA850_TINT12_3),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA850_TINT34_3),
-	},
-};
-
 /*
- * T0_BOT: Timer 0, bottom		: Used for clock_event
- * T0_TOP: Timer 0, top			: Used for clocksource
- * T1_BOT, T1_TOP: Timer 1, bottom & top: Used for watchdog timer
+ * Bottom half of timer 0 is used for clock_event, top half for
+ * clocksource.
  */
-static struct davinci_timer_info da850_timer_info = {
-	.timers		= da850_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+static const struct davinci_timer_cfg da850_timer_cfg = {
+	.reg = DEFINE_RES_IO(DA8XX_TIMER64P0_BASE, SZ_4K),
+	.irq = {
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_0)),
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_0)),
+	},
 };
 
 #ifdef CONFIG_CPU_FREQ
@@ -635,7 +614,6 @@ static const struct davinci_soc_info davinci_soc_info_da850 = {
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
 	.pinmux_pins		= da850_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da850_pins),
-	.timer_info		= &da850_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
 	.sram_dma		= DA8XX_SHARED_RAM_BASE,
 	.sram_len		= SZ_128K,
@@ -672,6 +650,7 @@ void __init da850_init_time(void)
 	void __iomem *pll0;
 	struct regmap *cfgchip;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA850_REF_FREQ);
 
@@ -686,7 +665,8 @@ void __init da850_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &da850_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource da850_pll1_resources[] = {
-- 
2.21.0

