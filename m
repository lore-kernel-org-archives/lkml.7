Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FB0C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF3321901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="V4ffy7qa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfGVNR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:17:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34983 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbfGVNR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:17:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so39414625wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1TfWHxtQiNmrkXujZYAI0hTn+BhOSphr+TltX20vVaQ=;
        b=V4ffy7qaldHxXOW637TnRc8jd4OhS2z4gsD5AYpaXcCZESdUK0AfrgWtzRDSSqXGvj
         Of3DZBBCQNX6ZRRLgm/0gVh0JTl2W4itIFUcz9DQpYY13n7LX6WzGDrFdPBGic9LHvIX
         e7T4uYwZes+pCnyj7ZazNJuvCAY6Do29Hvqb10n2baCDFupmi87VZYQofXz4kV2mEDkX
         tppnTIMcm0ZMqz8Ial3dSWWckPYbDxaq5o2I7I4jWIy3Ant+GcZrWvH+fnr3QVoS8XNz
         9YAZp0fz0auVdH7NeHlthaAAsREkkVNAkn/OttSXYFxhRpIe6iVMKJQxyDQs5c+cdfhn
         UyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1TfWHxtQiNmrkXujZYAI0hTn+BhOSphr+TltX20vVaQ=;
        b=BwvD0b0LuyYmnxsyV6FPCrQlg9aBbkSQ2eBPrCrtMA4bLhlkRuSz1673BjZ7s+QZyZ
         DFjv+sgPrQ05qym/RPy/6ddk+l8+9Ny7eUYtMwbuu/07EW5LMkNxP9dsskZLr6koQFvo
         CPkJ2pYGf10w6La5slbHRcoS/GNCkQKohSvCY4790aQ5X5SIXMSe0TkHTOvDU+A6i+mF
         rTm1HRUuzjlQY7HVdJT7T9DvFL6TZln6STEE8Y0xjLCFVOOqUXvLUBruspWjEKWjBl2u
         CgbSIdrWWG4y4ONkJ2a3RxZCo9k93kGeOfcrLjuuD/46QT3pCXfGcRjflPVt7k7V4Yn0
         d04Q==
X-Gm-Message-State: APjAAAW+h08yE46cN65Ra3b7DuuK7zIN3lWBq8mt2fUNNpL60rRb46Tz
        6/QjJrtWU5+EOLJFP3i7Zg0=
X-Google-Smtp-Source: APXvYqzUWqhOPEknMtjGYiPGDW6HTsZ2oiF2bxO9d/89b9+L75EvdD+mPxU4ah2qHmVKGhwRbtcKEg==
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr37194421wrw.178.1563801475117;
        Mon, 22 Jul 2019 06:17:55 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id z6sm34156657wrw.2.2019.07.22.06.17.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:17:54 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        David Lechner <david@lechnology.com>
Subject: [RESEND PATCH 03/10] ARM: davinci: da850: switch to using the clocksource driver
Date:   Mon, 22 Jul 2019 15:17:41 +0200
Message-Id: <20190722131748.30319-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722131748.30319-1-brgl@bgdev.pl>
References: <20190722131748.30319-1-brgl@bgdev.pl>
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

