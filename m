Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B29C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C232146F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="sRBYCDtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbfFXNOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:14:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51551 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbfFXNOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:14:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so12779976wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 06:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zOhvfud1UplL6dXW+3V5RKRSj+/QqrgOZPNk1aW9k94=;
        b=sRBYCDtG70BsqOE2cPQ6Yb/vH8Y1K3vBWGkcB24MC4iIGeY7i5yLh2FHRMLBAXOBqr
         98GOJDOVmfzkuTio07OmLzeTtu0vX/3in+w0X1DKMy84oyCuzQqdAT6IQvZtyunkTmdz
         ATSj8Blww2SV7SlLPS70V5e3IB6X6gVf5AR/62cljr5RzLuMOtR5386b28q5mb87nqGl
         hE38amGYMXTld+ZIrRYf5aFg5QiJmCKrbQf8it1GUHIHiwCjDq+8pvBygIEbmTMjA8Z9
         43CJWrxMfaxXSjUGDGNOO0ECeh2L5K3JQ6AAdLGM7OZEsY8wMSAm6fU3szvcXzwUhITb
         zleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zOhvfud1UplL6dXW+3V5RKRSj+/QqrgOZPNk1aW9k94=;
        b=ZpZmCeCyJ8QD02IfMmu6V1O+sVfRO/zBzCT0TVG2pVv4GIiJJzAjOjzw5gsDFykLKk
         /8+o3G/K3/xyXMgImi0p6HWTjwihvo3mnjXe/LgaoDFtDRRzAZ1ICNSxB6P+Wi6LcieX
         ff4Bw1eF2urNrt+kBmCQOIY9xXf+EAZYmkM7BE4iRQS1o0orMxa96vHX+njXeO5U0ewe
         Xax8qIZ4H9w4HWbsuY8b9Yp3/N0lWVdKX74UPynRUKxwBkmtIlg4YDxQn5+ABIYJzEG7
         +COcmSiGISRE2TDhK7EtzzYMuT91wBP+jmVEqe7RL5nVe98hgVUjZg0/4txnfreVMfia
         Of3A==
X-Gm-Message-State: APjAAAVRdh0tIvxcJqedP3P+4GjZ8y3zMO5Q5xk6hUh7Qln2BnyezitO
        aeyJMKz9P4sRenOoli7EtPMZGg==
X-Google-Smtp-Source: APXvYqwvo1iriPD0W/bfOCnyIWRUt6wyAk/QMkGV06b6J0/YPFZFlgm4xFkGNQUKUyarb4J5NZgvKg==
X-Received: by 2002:a7b:c776:: with SMTP id x22mr15710150wmk.55.1561382047666;
        Mon, 24 Jun 2019 06:14:07 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id y2sm9535526wrl.4.2019.06.24.06.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:14:07 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 06/10] ARM: davinci: dm355: switch to using the clocksource driver
Date:   Mon, 24 Jun 2019 15:13:47 +0200
Message-Id: <20190624131351.3732-7-brgl@bgdev.pl>
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

We now have a proper clocksource driver for davinci. Switch the dm355
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/dm355.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index a38a3648345b..5de72d2fa8f0 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -30,7 +30,8 @@
 #include <mach/cputype.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -620,15 +621,15 @@ static struct davinci_id dm355_ids[] = {
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
@@ -706,7 +707,6 @@ static const struct davinci_soc_info davinci_soc_info_dm355 = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm355_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm355_pins),
-	.timer_info		= &dm355_timer_info,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
 };
@@ -733,6 +733,7 @@ void __init dm355_init_time(void)
 {
 	void __iomem *pll1, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM355_REF_FREQ);
 
@@ -748,7 +749,8 @@ void __init dm355_init_time(void)
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm355_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm355_pll2_resources[] = {
-- 
2.21.0

