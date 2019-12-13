Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A733CC4BA0F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCAED246F5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="R1nQf0AV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfLMQZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:25:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55358 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbfLMQZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:25:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so179336wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 08:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eMvYdN33I4+9ymWnbNhZacsLszkk7sr06Cm5LeypaiE=;
        b=R1nQf0AVjMvvp2zRVWlWyB58IbpfrmWg7d+S3IjBsbkVPRZs0PZbS9AUVJ4FYYfsq5
         WQe8o8GDIWftEd2SgUe/TP7Q3Ptn0pzRql+o50QTDjgC/BqrKQ+c47Edle9fyskeVdsu
         5iiIGZncU1EnNHT8THQrL5kVcY9SEukqsEQIZmzW6ZNmUVYOKafrNKNFOk4ISEFx3E5W
         Lto38KTsZy05PRQmD6yOAAazACHSKfKK2M+XcUw7HhVvpeyTC/ESso+e6XH+rUqojaYC
         YPJW1jZ9N7joe/7q8TmpgQIIcIRZcA0dLbvKewAlqiN9H1YMDuaHONeXISxGtQVgmHd2
         nazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eMvYdN33I4+9ymWnbNhZacsLszkk7sr06Cm5LeypaiE=;
        b=mdCeCR6JF35Bco+UeBN6KuAmv6R3YlfaZWu7KfO1xBBvW2XwQtTS7BZunMQk7O5RSV
         FSnU+A3ROglH3zxmaENhAh5FRDi/6dyK2O/XkD9vYmHR7vCHH0y9vodCuXXX0G27DeNa
         7bN94Dm0UgmjzuP11snS8Fd/ef78EJFHiFtW9Xg4QFleYom850Cs5Z6Ff/riHuW1LarS
         yyZAEySiCLtDkjQZUNpqorCgy7qfcqRsaRYTyZ3RbpvxVpf3g0mOgY/00ByFVIqTR7d9
         Ry0kd+etHpUj6ntBVKi840V8fXb1zyRGKKRbaPgdQeTY6XnDDuAkKntluQzFIxsxn2ZW
         7NXw==
X-Gm-Message-State: APjAAAWsUrhmTF6YlZvvUpYP9F9k1AqJlPu/nCuUkg7s3iyxoZcooLE9
        7re9Hl/Jcj+KO8aMRphBFD9JCQ==
X-Google-Smtp-Source: APXvYqyS9N0nuxTqqSdrISq3EoVYfvgKfc1zNAWPw5zKgUqM9n5ItsBPCbpsEWFiPcSedwhdX53/FQ==
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr14576009wmg.38.1576254308455;
        Fri, 13 Dec 2019 08:25:08 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:3d17:b245:8f4:3043])
        by smtp.gmail.com with ESMTPSA id h8sm11139330wrx.63.2019.12.13.08.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 08:25:08 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/3] ARM: davinci: dm365: switch to using the clocksource driver
Date:   Fri, 13 Dec 2019 17:24:52 +0100
Message-Id: <20191213162453.15691-3-brgl@bgdev.pl>
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

