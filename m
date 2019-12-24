Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69B2C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 10:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A895206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 10:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="noTPY/cZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLXKDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 05:03:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41659 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfLXKDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 05:03:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so19380422wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 02:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eMvYdN33I4+9ymWnbNhZacsLszkk7sr06Cm5LeypaiE=;
        b=noTPY/cZF1plw/DYzl9uZPadW+jnt0b0HOcqRPd07Sq9VJcJako4Rq2FSlwSsuzNq1
         YGWqa7KDKDf294TAsP7Tgv6TnMW7KjDwd/VFA5EOYJ3gg0AsO5fdzgC2kfKWWA1bCcIO
         82zCWDwa4OkUcYubiSOCJyhzh9PG1nHVdjvkWJvLIP5jWiUxQm6KGCyrFkBsPr16EsOA
         CdGwgTEo0MccOuks4Wx7QmMjPJr3ozAv7fy/ZoUb07QdE28Z4fWtTtzRmXotNtvM8SLG
         72+I0uxRRomVySTndwfPz/l+L1l/bkSpYBdojZtYTbizbWhPCTqbVOrl41tyUAIc6iO3
         xEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eMvYdN33I4+9ymWnbNhZacsLszkk7sr06Cm5LeypaiE=;
        b=F8GCSOKVXKBaOaWA3hY5q0PhPlqlKLnhyQTOy/+AR42b+ZkdwWi3QyXalLz89Ivm2f
         rtMdewMWXaTqXkNTHQ2b4rgxycrfjqIjYr2B6O15SDIc9e8CrsISqjwymBisoiEqYC2s
         t8vcxgZnrZrRZXF/z+Kanmxqeir4b5SwNUeqr76nKGOgJm8y02J7JOUhAMeUY6rSa6CK
         cEKkucYiGE4ozVEOs35BQD+joYPC8VUrbJ5eWR0NvkjFJHEJ7n0emqPeXauDArzYJwB3
         WsE+r5HLouyYYfoNX5TiGLga2E2e2/FeSjdPPr87ZJ6a26rJhzb3OM+Z6MPUsd48O/lJ
         FB9g==
X-Gm-Message-State: APjAAAUtZgPyacGhGoeWbsHLd2gXfTZYbo0U+MLmu+OvxI9aqteiPXH9
        MoSzRly8GMpzlI4UNuQqjKNLPg==
X-Google-Smtp-Source: APXvYqzE3QUnUZM2eeQO+YPO5KkGpArPsDMQy+Kv0ICdc5rnXHjbWygsqLQobKpdJQb1p8nnK5ORUQ==
X-Received: by 2002:a5d:4281:: with SMTP id k1mr35692885wrq.72.1577181814837;
        Tue, 24 Dec 2019 02:03:34 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a184sm2164048wmf.29.2019.12.24.02.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 02:03:34 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 2/3] ARM: davinci: dm365: switch to using the clocksource driver
Date:   Tue, 24 Dec 2019 11:03:27 +0100
Message-Id: <20191224100328.13608-3-brgl@bgdev.pl>
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

We now have a proper clocksource driver for davinci. Switch the dm365
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/dm365.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 9fc5c73cc0be..c1e0d46996e4 100644
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
+	.reg = DEFINE_RES_IO(DAVINCI_TIMER0_BASE, SZ_128),
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
2.23.0

