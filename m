Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C48C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E8D2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="boFR526H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfCRMLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:11:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41728 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfCRML3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:11:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id p1so16743990wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 05:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p/RL9iQ2NS2E2PHvUt/6SF66kDhBpCeVr4z3seHiKxc=;
        b=boFR526H1NtqYO4Xhgqx2ssi9nWJ6jXepzHDIttGVIneOflS7gp27/3F3EJQbj1IEZ
         11/ATJXbohHSaC++Ni7LFwrcd2CqA2Uf15vdKgKs4COQdVWC80FC8fUZzeP7441e3M99
         QVO0yZP4/H9qsLw3qxj9WSvLNFJbZwKnRhJCmFG7tPhslN/+GAX+DnHjfOpuQf5YWIgX
         HqPIDt2rJrZ+utZnPxSPW5gBSdt3h1zqew5b81iLL5olfls9pJAL2U0x+XBUJkapLPiO
         0SB1ac7TZKRShsxwbSuaF2xkoanK/KpEemD6Ju+79QOtAyD09iG43bbZjfL0h+Bikflz
         qRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p/RL9iQ2NS2E2PHvUt/6SF66kDhBpCeVr4z3seHiKxc=;
        b=KNoDRWuntCeSSfUyu+NIsZdrFqgG9PVwotV8mA5o7eqd49jzYNUA09bOEZydnZpCxK
         a19UG3KGsmV5vxvcEDV+9tenrjTZIrAUYT6udkQVIVXO9RPH+cWS2LxfWRvkGIThqXhc
         M0d9sNiLl27IipIojp3Iihgt0kDNRBhS5XmgkB4FuqOLhjGYk1F4huZ7R9wmGv6eKYkZ
         rcCGn+n0JF1xhhTB0dFiQUbvrAK5XM92Q1u5qgpqLhq9x6UwbXUoFZCTnO2rHIjHQC4M
         3/wVbO/8BxHKFn0gvCxiziuFLgZFYXEDETd4iW+d+o54PLbn1MpN+yT3chsRtMdnTacW
         7miQ==
X-Gm-Message-State: APjAAAXmKB+CA4CGgAMOJo/D3YDH0SCJkNqpsySVO03LcB1fmKa+nb79
        5WR2Uh9ILsqYIXV2zGeZ1o12eA==
X-Google-Smtp-Source: APXvYqyzDDGHbhNqjXluluMdGNeCDOPmxCxbt7Pd3E2YWwmVOsG21Te6qRNJnMMQ9mhIfbbSHX+pOg==
X-Received: by 2002:adf:dc4d:: with SMTP id m13mr12422592wrj.330.1552911087619;
        Mon, 18 Mar 2019 05:11:27 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id n13sm8220132wrw.67.2019.03.18.05.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 05:11:26 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 10/11] ARM: davinci: dm646x: switch to using the clocksource driver
Date:   Mon, 18 Mar 2019 13:10:59 +0100
Message-Id: <20190318121100.28132-11-brgl@bgdev.pl>
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

We now have a proper clocksource driver for davinci. Switch the dm646x
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/dm646x.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 7e5af984ed9f..281e778ba19e 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -27,7 +27,8 @@
 #include <mach/cputype.h>
 #include <mach/mux.h>
 #include <mach/serial.h>
-#include <mach/time.h>
+
+#include <clocksource/timer-davinci.h>
 
 #include "asp.h"
 #include "davinci.h"
@@ -500,15 +501,15 @@ static struct davinci_id dm646x_ids[] = {
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
@@ -586,7 +587,6 @@ static const struct davinci_soc_info davinci_soc_info_dm646x = {
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm646x_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm646x_pins),
-	.timer_info		= &dm646x_timer_info,
 	.emac_pdata		= &dm646x_emac_pdata,
 	.sram_dma		= 0x10010000,
 	.sram_len		= SZ_32K,
@@ -651,6 +651,7 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 {
 	void __iomem *pll1, *psc;
 	struct clk *clk;
+	int rv;
 
 	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, ref_clk_rate);
 	clk_register_fixed_rate(NULL, "aux_clkin", NULL, 0, aux_clkin_rate);
@@ -667,7 +668,8 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 		return;
 	}
 
-	davinci_timer_init(clk);
+	rv = davinci_timer_register(clk, &dm646x_timer_cfg);
+	WARN(rv, "Unable to register the timer: %d\n", rv);
 }
 
 static struct resource dm646x_pll2_resources[] = {
-- 
2.20.1

