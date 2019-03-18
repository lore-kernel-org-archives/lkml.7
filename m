Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC39EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D402085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="NLjdAuvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfCRMLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:11:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38723 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfCRMLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:11:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so16764197wrm.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 05:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zq6XZJXRCWci+70vqpBSI69wjDreXbC4SvXP2HM1Bqw=;
        b=NLjdAuvqb6wVXYAyL6AA0Y4JpqO9msZ5J6BsB/iZtj5MSq/MpZ2hqIjSDi3H/JPwFw
         h0bBZwXKZX970Qh6De7ZVvrTpwhSscRgMrsQcTRZTmbZXolv9+quABDtW8QuAs9e4XAg
         gYGP8RHydUpbUpwj8TR1cJ5DKT/9dWeuALuXWk1ifQepbm3R2kn01CANSuSmXrofgVV+
         iK0qYm0pqyEnYNBZAAFy0ZQ8Py3M61HZY2fcmzmTO2nOn6Kjp0yDHnNmDj64YgAZpdc8
         oPGHpEPddLAcw4Z605So2R40ZKhSY2pSS1qvN67AD3TyHrVH2tuVxZKvazNZ2sRGAF4c
         CbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zq6XZJXRCWci+70vqpBSI69wjDreXbC4SvXP2HM1Bqw=;
        b=H/wUaW9yyZLcLp7MQO6v05qN/qwUNxffhVjzBB7/3e9zhL8anRI+7x+pQ7qf9aH+Ic
         YPoJNZ+CCTIVTK+vhnTFqSBldQFLAxs7jSKJT4RyD6r7CQOpabWesDQTH73J1g/kHaX3
         L2txrFj3GbUR1/Rc+WQXVjSJwRoSWTV+vPnIDzr+7CgV84hOO+6iUEO5bpBiamwAxYNw
         pSY03WY+T+sOqfWuOI2pAvZPA/A1MFZtaydCz9orLtQVu4MLGhCK1FMBW7T8EPqMQNGW
         GCPHH+dYtcoy6Od15pQbJ36hEzd2JDbeu84R/EIx8S0NiDctsoXyPoKrHllaLEqj2MeK
         eTJw==
X-Gm-Message-State: APjAAAWzHKyIk/EWS82jqXrGRgqkxSyGvmSLiLorTIUb2q1MgKbtZZpK
        gBDRHI+oyp47lSCzrfqJ9t4g5A==
X-Google-Smtp-Source: APXvYqyn3h+4oR12e1/M4euquj8Imo2TAYwfIo3ASXtVBUrPgwdR8OJHo9hMZXHH78AEs5a4LiT5aA==
X-Received: by 2002:adf:f543:: with SMTP id j3mr11378081wrp.220.1552911082622;
        Mon, 18 Mar 2019 05:11:22 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id n13sm8220132wrw.67.2019.03.18.05.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 05:11:21 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 07/11] ARM: davinci: dm355: switch to using the clocksource driver
Date:   Mon, 18 Mar 2019 13:10:56 +0100
Message-Id: <20190318121100.28132-8-brgl@bgdev.pl>
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

We now have a proper clocksource driver for davinci. Switch the dm355
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/dm355.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 57c5a660758e..d871172f74c2 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -29,7 +29,8 @@
 #include <mach/cputype.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -619,15 +620,15 @@ static struct davinci_id dm355_ids[] = {
 };
 
 /*
- * T0_BOT: Timer 0, bottom:  clockevent source for hrtimers
- * T0_TOP: Timer 0, top   :  clocksource for generic timekeeping
- * T1_BOT: Timer 1, bottom:  (used by DSP in TI DSPLink code)
- * T1_TOP: Timer 1, top   :  <unused>
+ * Bottom half of timer0 is used for clockevent, top half is used for
+ * clocksource.
  */
-static struct davinci_timer_info dm355_timer_info = {
-	.timers		= davinci_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+static const struct davinci_timer_cfg dm355_timer_cfg = {
+	.reg = DEFINE_RES_IO(DAVINCI_TIMER0_BASE, SZ_4K),
+	.irq = {
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT12)),
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT34)),
+	},
 };
 
 static struct plat_serial8250_port dm355_serial0_platform_data[] = {
@@ -705,7 +706,6 @@ static const struct davinci_soc_info davinci_soc_info_dm355 = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm355_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm355_pins),
-	.timer_info		= &dm355_timer_info,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
 };
@@ -732,6 +732,7 @@ void __init dm355_init_time(void)
 {
 	void __iomem *pll1, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM355_REF_FREQ);
 
@@ -747,7 +748,8 @@ void __init dm355_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm355_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm355_pll2_resources[] = {
-- 
2.20.1

