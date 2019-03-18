Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B6EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9C02085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="BV2MogTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfCRML0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:11:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43580 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbfCRMLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:11:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id d17so16744847wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 05:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=My9LHziBy8/8cThZJLjlKfs+y6Rl5hus9fQgALTPzvc=;
        b=BV2MogTceJW3CPJWlYVMpJ28K4y8Y54L7LGYa+egT3Rdm360eNcvTPHk+SGVH08n8n
         g2C1URkqgCdRvG4AByidK3b72rKB2yIjdd87SPCile2EBiQSSVpIxumcAoFWMgV+moee
         ioGrGk5pxYrU7K3Hiia0Ufux5VRPynp6sDysnCs+p37O3agSAbQb+nZBa3JseYrIITtY
         hODJCm84tWoFluhWkmsrxlphvCXmQwNhh6dPcdOFgoYLC/fpG0RPqMyqYY3Cuyuez6JO
         Ryk4wcKrADGaEe8NwOw+Iz64YJSwdZTosabSPqa95xdZ1P29CX8wqP68eswlK5VZk3j9
         /Pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=My9LHziBy8/8cThZJLjlKfs+y6Rl5hus9fQgALTPzvc=;
        b=NukYNAAQwAhtE3qyLM9RzhhM7tWrYjcbde4WgK3Kppy5cEOIp7PcHVLrxszSBpVY4p
         537kWxyC50oK4rUNE6yJ3hqkxbZJtgPFqLNXVrhpu4bs+tstWTJZQOTPpP3Lv11Xjkzl
         HrvjW3WiiRmlItw90dCnrJbnDcw5ipoqTvUTjcu58bqL9Vt/QUjuyiwMJ+LfdV6SyDaH
         C7lEpbrILsk/OQ8aDkzhH/3LsmZb483+bJ62gdzxVI3Y60+arZS+z48iWYpL1iCquhRF
         wyg40tfb6k82YW2qOXcODU3ffe0cjzZyvHCvj0+GzK37f4Le989MUV23Y2GIMhbFs6t+
         u5BQ==
X-Gm-Message-State: APjAAAWIRPObhgYDazoVIDOrNEuuFJHokUQMKpUOSQScKHKR6TrEEo35
        E8vetuy6gkZIhA+E8BLTRQBkVA==
X-Google-Smtp-Source: APXvYqxc7DsoYNtDAc0coBedu10uStAcaSgOc5GpxZl/y+y61VYA7FIwzPSZrajFaq8I8j3ucZvfkQ==
X-Received: by 2002:adf:f089:: with SMTP id n9mr11345166wro.313.1552911080099;
        Mon, 18 Mar 2019 05:11:20 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id n13sm8220132wrw.67.2019.03.18.05.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 05:11:19 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 05/11] ARM: davinci: da830: switch to using the clocksource driver
Date:   Mon, 18 Mar 2019 13:10:54 +0100
Message-Id: <20190318121100.28132-6-brgl@bgdev.pl>
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

We now have a proper clocksource driver for davinci. Switch the da830
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/da830.c | 41 ++++++++++++-----------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index d242ce06f7e5..3b2c9454828c 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -20,7 +20,8 @@
 #include <mach/common.h>
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "irqs.h"
 #include "mux.h"
@@ -675,32 +676,17 @@ int __init da830_register_gpio(void)
 	return da8xx_register_gpio(&da830_gpio_platform_data);
 }
 
-static struct davinci_timer_instance da830_timer_instance[2] = {
-	{
-		.base		= DA8XX_TIMER64P0_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_0),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_0),
-		.cmp_off	= DA830_CMP12_0,
-		.cmp_irq	= DAVINCI_INTC_IRQ(IRQ_DA830_T12CMPINT0_0),
-	},
-	{
-		.base		= DA8XX_TIMER64P1_BASE,
-		.bottom_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_1),
-		.top_irq	= DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_1),
-		.cmp_off	= DA830_CMP12_0,
-		.cmp_irq	= DAVINCI_INTC_IRQ(IRQ_DA830_T12CMPINT0_1),
-	},
-};
-
 /*
- * T0_BOT: Timer 0, bottom		: Used for clock_event & clocksource
- * T0_TOP: Timer 0, top			: Used by DSP
- * T1_BOT, T1_TOP: Timer 1, bottom & top: Used for watchdog timer
+ * Bottom half of timer0 is used both for clock even and clocksource.
+ * Top half is used by DSP.
  */
-static struct davinci_timer_info da830_timer_info = {
-	.timers		= da830_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_BOT,
+static const struct davinci_timer_cfg da830_timer_cfg = {
+	.reg = DEFINE_RES_IO(DA8XX_TIMER64P0_BASE, SZ_4K),
+	.irq = {
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_DA830_T12CMPINT0_0)),
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_0)),
+	},
+	.cmp_off = DA830_CMP12_0,
 };
 
 static const struct davinci_soc_info davinci_soc_info_da830 = {
@@ -712,7 +698,6 @@ static const struct davinci_soc_info davinci_soc_info_da830 = {
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
 	.pinmux_pins		= da830_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da830_pins),
-	.timer_info		= &da830_timer_info,
 	.emac_pdata		= &da8xx_emac_pdata,
 };
 
@@ -742,6 +727,7 @@ void __init da830_init_time(void)
 {
 	void __iomem *pll;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA830_REF_FREQ);
 
@@ -755,7 +741,8 @@ void __init da830_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &da830_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource da830_psc0_resources[] = {
-- 
2.20.1

