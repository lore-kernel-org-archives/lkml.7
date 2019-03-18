Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93D9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88352085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bmOsXdyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfCRMLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:11:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54848 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfCRML2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:11:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id f3so12871582wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 05:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2AyPcpkMK2TUdGXpcbzsOcHrovJWMOKUOoUDNgEkKg=;
        b=bmOsXdySusZkb50ndIvDHGO/z46YLKHbbfxI9Ji7KJPyuu3vD1moakF7Jr5v24tRV9
         XIkYN/Rmd/OgT9iZYogRII7KoS9ZQleRMoX9P88lQech/rSIJGLnQh8VfPJCoHekw63O
         1lPdmDvORfncrzu2RbNIlSj8U6QQBNWVoiPSp0pp9MzNJqh2/CgCSF2ovetbhHEZ23Tc
         4Vb++CwrC0bvmq3VX6yWePh4ha+MplwexHl3ptn1C/84Rloa2iIm5HEolo7aehq3GWA3
         nnOFJR/fLpO3VFZsWe3pNW0qj6iSVOiuC/m+xdpkQ8qvpWqJQukNB6S7/o+xRKY4S/fM
         /aIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2AyPcpkMK2TUdGXpcbzsOcHrovJWMOKUOoUDNgEkKg=;
        b=Wl6BmKCttxawwKpNigdDZFGo4TGAGekQ4APbmiEMitA5gucfzEHvbozxnxE6i1IrKU
         Vs9FP9RVRCDVYLP19cyZ86YaAtbNovb+0diMt1x2ZnwwnQu4kNNSWFHJANJEwi1yaWgV
         O/2k8r4JeN5zXGo/ZZMRL5dr98Q+GJWVW0KPjVmc2MRWIF6Ka4fOjIrBXaYfKll/0RsR
         B3f/cnrC4f7rr6AawOmCgbIVDxjZ8xhfv7I7+jzDJRpNbCILEYA7r6ojIwdLyBaYzoLa
         EkIsgTwx9N0Vkz9oYcPyO6NvUycB09GOn53a1wIp62UqfWbq8QHd0yZJRQusQCsrHBWc
         Pb9Q==
X-Gm-Message-State: APjAAAWX7p0H2Q7ylC6GEDFbzgTuiOnVvNjwNyyIL7zi3ZmuCpCD9lOY
        Cv8pPd0fnNUOqYZKX3BcHbTTUw==
X-Google-Smtp-Source: APXvYqyI1rTqMDt6mClmYnjgytNnavXPygYSdJe6dkTw8eCi/XyT564xzWLmEP97wiAlZy0n0KQFvA==
X-Received: by 2002:a7b:c3c5:: with SMTP id t5mr10745333wmj.110.1552911086370;
        Mon, 18 Mar 2019 05:11:26 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id n13sm8220132wrw.67.2019.03.18.05.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 05:11:25 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 09/11] ARM: davinci: dm644x: switch to using the clocksource driver
Date:   Mon, 18 Mar 2019 13:10:58 +0100
Message-Id: <20190318121100.28132-10-brgl@bgdev.pl>
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

We now have a proper clocksource driver for davinci. Switch the dm644x
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/dm644x.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 2b0e921aa755..9f7c348d8efe 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -26,7 +26,8 @@
 #include <mach/cputype.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -560,15 +561,15 @@ static struct davinci_id dm644x_ids[] = {
 };
 
 /*
- * T0_BOT: Timer 0, bottom:  clockevent source for hrtimers
- * T0_TOP: Timer 0, top   :  clocksource for generic timekeeping
- * T1_BOT: Timer 1, bottom:  (used by DSP in TI DSPLink code)
- * T1_TOP: Timer 1, top   :  <unused>
+ * Bottom half of timer0 is used for clockevent, top half is used for
+ * clocksource.
  */
-static struct davinci_timer_info dm644x_timer_info = {
-	.timers		= davinci_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+static const struct davinci_timer_cfg dm644x_timer_cfg = {
+	.reg = DEFINE_RES_IO(DAVINCI_TIMER0_BASE, SZ_4K),
+	.irq = {
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT12)),
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT34)),
+	},
 };
 
 static struct plat_serial8250_port dm644x_serial0_platform_data[] = {
@@ -646,7 +647,6 @@ static const struct davinci_soc_info davinci_soc_info_dm644x = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm644x_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm644x_pins),
-	.timer_info		= &dm644x_timer_info,
 	.emac_pdata		= &dm644x_emac_pdata,
 	.sram_dma		= 0x00008000,
 	.sram_len		= SZ_16K,
@@ -668,6 +668,7 @@ void __init dm644x_init_time(void)
 {
 	void __iomem *pll1, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM644X_REF_FREQ);
 
@@ -683,7 +684,8 @@ void __init dm644x_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm644x_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm644x_pll2_resources[] = {
-- 
2.20.1

