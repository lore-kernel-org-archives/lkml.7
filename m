Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD08C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FF1213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MApm63Q5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbfFXNOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:14:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38117 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730825AbfFXNOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:14:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so13320137wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 06:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=550rdQvPEpXRICt57j9lxMM5hxSHkZtM5UQc6a6drbE=;
        b=MApm63Q5KkYtQWv/PSQalezO2BBDnpIijPrWRFHKBj7SA+98UuiveTqEwQtX429kTE
         Nf5ie8av3/38lXA6GiaCdQoqNn1nhPThbBpKeSbS0gJ9oKhj0TfcF3c73PhbniIu3iiL
         wSqHRqM90R7kZrCD3hMnkEt7pJt/C4kz7lLcogQApq6BssveU4OWFnMOvCKXttEx2aId
         a6oB6n+4nGRsC214G3Ew24iYriZRk9MJ6wteIrMfHEwlzsmUS++7I6I6Z0clRTAvb4Q3
         6MKkmgxi8rE+tRwcmRiGOzxjyTXuM/W/94DZWp30FHmjqs6ds0KGDEs7a8d3CUNILFt5
         KF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=550rdQvPEpXRICt57j9lxMM5hxSHkZtM5UQc6a6drbE=;
        b=O6r7ngXqdFlJqMopWNhXkKW526ob4uNgQz7LNILXUCzUJEi+qe9ehO2F6W3y8CRap9
         kvpH5OCn5ycZ6ubDfEOTluG1f9A/+tKimpNWLE679kDFTviUJ2ikbSgUilFpEQnP1AvX
         zEUtCJgmIIvo2moGEON7Swje6lwTg9kF+6SXVSQrX3+iHubmKLY8q7oI596kevI+t6Oh
         YmS17h8cymwUPCBoQA5md1khejAjQapP8PaLXsIoC+5bQxDBlbcvWoyZWM4pEVYKFGYu
         0yQlz3U/bek7zkqAyMRszOYo/wtTdKsWrYbOPCMs2/DbsL1N5ogHlAUMqBW4Sj+8in1/
         zj3A==
X-Gm-Message-State: APjAAAVENnFisvDWGX2/lfMovkN5mUP0S5tKEJSFcP2zRRkQXZP0cyNX
        MTFWmorqYV+KHRBPvtE4V0tOFA==
X-Google-Smtp-Source: APXvYqxMfoGiYVcKiwFRikncCa+qI0TnCVmdSIl2dnveLE/Y9e5L/NveSMlQa58p67RnT6Ou8Hsfsw==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr15519108wml.97.1561382049688;
        Mon, 24 Jun 2019 06:14:09 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id y2sm9535526wrl.4.2019.06.24.06.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:14:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 08/10] ARM: davinci: dm644x: switch to using the clocksource driver
Date:   Mon, 24 Jun 2019 15:13:49 +0200
Message-Id: <20190624131351.3732-9-brgl@bgdev.pl>
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

We now have a proper clocksource driver for davinci. Switch the dm644x
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/dm644x.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 7a6b5a48cae5..24988939ae46 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -27,7 +27,8 @@
 #include <mach/cputype.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -561,15 +562,15 @@ static struct davinci_id dm644x_ids[] = {
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
@@ -647,7 +648,6 @@ static const struct davinci_soc_info davinci_soc_info_dm644x = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm644x_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm644x_pins),
-	.timer_info		= &dm644x_timer_info,
 	.emac_pdata		= &dm644x_emac_pdata,
 	.sram_dma		= 0x00008000,
 	.sram_len		= SZ_16K,
@@ -669,6 +669,7 @@ void __init dm644x_init_time(void)
 {
 	void __iomem *pll1, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM644X_REF_FREQ);
 
@@ -684,7 +685,8 @@ void __init dm644x_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm644x_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm644x_pll2_resources[] = {
-- 
2.21.0

