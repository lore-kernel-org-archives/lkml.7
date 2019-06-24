Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00571C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8C9213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jol/3H/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbfFXNOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:14:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34721 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730806AbfFXNOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:14:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so13896166wrl.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 06:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=19fYL7Z8mI6tfJg545F0VQ6RS/+NjmhdJgfi1UhO5UU=;
        b=jol/3H/jyd+n5+UmVJcFYxn4G6XLnGFk58Io6xBdo8IH1KMpFbEeamgPfqCKmX/bSK
         C45pQaBMAxpqQNY+G7gicp0SlMFb0+CbflH6zpD48LuGN1pgNdjG6hvQhSot3SDomYfr
         s2ukWKMW14+JD0j0bqWwZDlbSSrU9wpUwBKdw+KxOAnfoq7araQy1xlKbdiztQvcdvwa
         TRBRmgeANjaMFEsPAIhosDfZp77aeyhrEjfEdaYyVF5FXXUft0NyQSs9hA/sBEftWE1L
         f4MUjkjo4HMgTzFyDoTWfEKOjUC5rdlKwOr+KW00cT0tA2Zi93dJuTSFxRTvUMpiJFE0
         kxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=19fYL7Z8mI6tfJg545F0VQ6RS/+NjmhdJgfi1UhO5UU=;
        b=c/gSHBAtmYnvjcf5SkvhJw/3pF3X8MAzE+SyO2+SO2LZXCiEl18RGYer8ukxEl4MLu
         dkvmM1Wi8vWh3sTP3m5FFlKvl617D0G5YKvEwADVoBvL1paQhfn/zO4uzAEvX8QQst3T
         AkCaw+5aRaOni8GYPlsOaAqUZDje4bQ2qXRNgvpWKsrVY0fLxJ5WVdVBGnXtFeF0O9k2
         4BgXoG0pBviIAfKqMKNCOu60o6Ul6T0YnEAFvbXEgs3ci2zvs2HBkJMNonjIzi1ne9ZV
         2VDffXT/p0XUc/No0/2ViXnuHaQSuEREXIwnhEZC3DV+PV1W7S70Lb+FSGc6HKxUepZz
         21Cw==
X-Gm-Message-State: APjAAAUdr99IdG4bAtD8Y4jjKXIrmMaeWS24+epnrgGYB2je+Q43pv/u
        aNRMGlyRvHRDccUuaFETBPe8rA==
X-Google-Smtp-Source: APXvYqywH596rG5HuH5Z1TME7LtvICvR2+wtjm0DznEwB3khuDIREmwbKdT3WYlktUIicc9QC/rmaQ==
X-Received: by 2002:adf:e910:: with SMTP id f16mr17523944wrm.183.1561382048709;
        Mon, 24 Jun 2019 06:14:08 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id y2sm9535526wrl.4.2019.06.24.06.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:14:08 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 07/10] ARM: davinci: dm365: switch to using the clocksource driver
Date:   Mon, 24 Jun 2019 15:13:48 +0200
Message-Id: <20190624131351.3732-8-brgl@bgdev.pl>
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

We now have a proper clocksource driver for davinci. Switch the dm365
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/dm365.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 8062412be70f..2299ca445c0e 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -35,7 +35,8 @@
 #include <mach/cputype.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -660,10 +661,16 @@ static struct davinci_id dm365_ids[] = {
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
@@ -723,7 +730,6 @@ static const struct davinci_soc_info davinci_soc_info_dm365 = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm365_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm365_pins),
-	.timer_info		= &dm365_timer_info,
 	.emac_pdata		= &dm365_emac_pdata,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
@@ -771,6 +777,7 @@ void __init dm365_init_time(void)
 {
 	void __iomem *pll1, *pll2, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM365_REF_FREQ);
 
@@ -789,7 +796,8 @@ void __init dm365_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm365_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 void __init dm365_register_clocks(void)
-- 
2.21.0

