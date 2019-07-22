Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D973CC76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBB621901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="GSo6+MOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbfGVNSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:18:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42413 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfGVNSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:18:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so24399522wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=550rdQvPEpXRICt57j9lxMM5hxSHkZtM5UQc6a6drbE=;
        b=GSo6+MOVPcgHTb7xbyvoyhWlDXlsu4/zI6ivXXcgl85lYOIGmZx2/jvT8mhZUACRiT
         h3ZZfHoiSds/60N6vj96oXVCSZ0TOeBDEU2W78+W2lJUrIdeAfjKaGWhYKxlHciGYV03
         gG1in5QvaGNEypqRhOBeWWr6Wbqy1bmZmm/x7BsW6PM68SeKiX4mnhADT+mmFwdxroE4
         YsLaJJIleuAv+2C+jrQsg/Ymg8xobbI/i//FGAHpYX5re5/+4QjO9vYzT0c7L4RBaigH
         RUks7rJF6oRgx68nqVpOmg2+EoBFQFfIPsWj4tqtbKLjCXG2mOKSjJy7VTIijAxazQDJ
         /uIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=550rdQvPEpXRICt57j9lxMM5hxSHkZtM5UQc6a6drbE=;
        b=cu7Evt/OwQcAuXMSoT7CbggnaL0kVPsDx3HNivlNB8/n2oi0fI29O+NKtyqLCYdNBA
         v/t4xj531YMRf+Kw53Bzd7nR/vL3MeippZPamZEDWmVsDlZ+AAxpp3P3/5D9FNso4hmS
         C4gfSBvk3r4OmUr8tlH3fp16FhkW1VcKvlmLkM7NKTsuqzH6/TRAGCCyEkAKbzquj6X8
         +Y4VdE2rNniFECtEbgsmapbDSdXY1q8/t+L+TES44HlKmkld7BA7zp34by/7ihRyLAAT
         nQjn4AKosEW7KJ/3Lr4vm/WqORFpVKBEvNWIK1Q+I2p3DSVq3Iwf8K+Wl/sne0E1dGWr
         NC/Q==
X-Gm-Message-State: APjAAAWrKRsJ5KsbP02qAeCJ28yHKrCmztr4aVPRpoCovPdCytOc1im/
        +JW5qqxQIQiDWrq0tbek1r0=
X-Google-Smtp-Source: APXvYqzXZRF64uLK/Lk8tIovJHppdfZWIS3sBB241bHdwb7Mo3MMlQp00WuciSsyOrKeoxESAqltuA==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr24072931wrm.230.1563801479923;
        Mon, 22 Jul 2019 06:17:59 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id z6sm34156657wrw.2.2019.07.22.06.17.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:17:59 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        David Lechner <david@lechnology.com>
Subject: [RESEND PATCH 08/10] ARM: davinci: dm644x: switch to using the clocksource driver
Date:   Mon, 22 Jul 2019 15:17:46 +0200
Message-Id: <20190722131748.30319-9-brgl@bgdev.pl>
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

