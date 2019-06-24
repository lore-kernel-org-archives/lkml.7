Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD3FC48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2923214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tctRPNjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbfFXNOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:14:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37384 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730836AbfFXNOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:14:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so13346737wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 06:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4D3o5SEJKsvVBksV7qKTIddf2rG+0VEDDDbyrl2Tbrs=;
        b=tctRPNjWrC2Vt84gqwVrLJlyUXsOUtGoAseuFGx4UAAS4tI2v37ZBitD/0A73cllC0
         HU1E+DYtpMe8p2E7KijS3JKjI7jMsjvzcB6EuRgaG0NrcNS2Yhzs/NXa5W7El3nJBwC/
         xC0OJcieyCLFNNtB36ffVb9NZxu0wOd34S39IZL1hs6B+IFlR98/oVeBbphjxDNPGguT
         j/s87zbGUN9E3zHokCDjT6mTXMw7w0zoST6/kCfpj6K0CMri9sLs5gwRdtYzh2UmsOmS
         vJhKkM6HD9/hQjhHXiiIyEeeup3cbREjdbNv+k5AVjKlHbRe0NfSTbuVZqYUi2dZuQnP
         jZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4D3o5SEJKsvVBksV7qKTIddf2rG+0VEDDDbyrl2Tbrs=;
        b=mVj08LpMM7h2Fkb5gNeFyIN5ciZV6+B4uGEoWMZ3qtNTh73lzEu6Dypix1tpc74U/h
         1QKxDMsd+0GNqS2dSow8cKaDx1ImXkmL/bKgbzD4KPyHWmJYXD0eXviRjWev7FiYhgeL
         e+Qq+8qilfpHxu5yEtjvXzx6GZXmtIOP8ixLE1j2uG4HT6Ikf02Tii3bX7Y69AdRGYK6
         XBVg8GrZHV6cNovM4lcBjCFKzx35W26oA8JYJaF8o77siJoUt/BOua7qDfhWWk2eLUq5
         UH6DeMLa7O+Nj4zFsDxsyZ1QO/O7JTPbAtQsMEq03e34kkWqJQseFuyWftxm2cEn6JZV
         8mrA==
X-Gm-Message-State: APjAAAWizjFU0ZMBE0aRAiXZQXzhyCYmN1FFcAicXFIzyQ2gDui1qQiK
        2WzPEvySi3wkEwFBsJ5ynbCJig==
X-Google-Smtp-Source: APXvYqwbRHzkbzEasV7zXLRLlOukqtmx2riVNvJZJOvWanztVmt5mbXS4yH2Y7UyFN3oIUMg2jYf5Q==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr15926991wmc.159.1561382050517;
        Mon, 24 Jun 2019 06:14:10 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id y2sm9535526wrl.4.2019.06.24.06.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:14:10 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 09/10] ARM: davinci: dm646x: switch to using the clocksource driver
Date:   Mon, 24 Jun 2019 15:13:50 +0200
Message-Id: <20190624131351.3732-10-brgl@bgdev.pl>
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

We now have a proper clocksource driver for davinci. Switch the dm646x
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/dm646x.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 97fe533726e9..2b628c31aef4 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -28,7 +28,8 @@
 #include <mach/cputype.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -501,15 +502,15 @@ static struct davinci_id dm646x_ids[] = {
 };
 
 /*
- * T0_BOT: Timer 0, bottom:  clockevent source for hrtimers
- * T0_TOP: Timer 0, top   :  clocksource for generic timekeeping
- * T1_BOT: Timer 1, bottom:  (used by DSP in TI DSPLink code)
- * T1_TOP: Timer 1, top   :  <unused>
+ * Bottom half of timer0 is used for clockevent, top half is used for
+ * clocksource.
  */
-static struct davinci_timer_info dm646x_timer_info = {
-	.timers		= davinci_timer_instance,
-	.clockevent_id	= T0_BOT,
-	.clocksource_id	= T0_TOP,
+static const struct davinci_timer_cfg dm646x_timer_cfg = {
+	.reg = DEFINE_RES_IO(DAVINCI_TIMER0_BASE, SZ_4K),
+	.irq = {
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT12)),
+		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_TINT0_TINT34)),
+	},
 };
 
 static struct plat_serial8250_port dm646x_serial0_platform_data[] = {
@@ -587,7 +588,6 @@ static const struct davinci_soc_info davinci_soc_info_dm646x = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm646x_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm646x_pins),
-	.timer_info		= &dm646x_timer_info,
 	.emac_pdata		= &dm646x_emac_pdata,
 	.sram_dma		= 0x10010000,
 	.sram_len		= SZ_32K,
@@ -652,6 +652,7 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 {
 	void __iomem *pll1, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, ref_clk_rate);
 	clk_register_fixed_rate(NULL, "aux_clkin", NULL, 0, aux_clkin_rate);
@@ -668,7 +669,8 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm646x_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm646x_pll2_resources[] = {
-- 
2.21.0

