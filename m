Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FADFC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395C621901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yGPiN2mv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbfGVNSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:18:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43868 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbfGVNSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:18:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so39354492wru.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4D3o5SEJKsvVBksV7qKTIddf2rG+0VEDDDbyrl2Tbrs=;
        b=yGPiN2mvApoi3Tmm1BR9ii6bxGVu2gVZidX5Rhf9EF6Ra8xLEiReChUQpbJa/YNy89
         LlpaYNPoJWUZ860/PdyDvr9hA/0guKHAzs8puaHH9mSnCANpjoBP4ZwoCTMJrvjx6xd2
         xXfnXRR+mQIiP2f8OR8NTtHZZ4/VSNbbQ99V3sbC2fuY3Pd/ZahnnYxxst8DgYXCiInB
         vAByCJP+BsDSCso/uvMmd125+kmYV2pMSd6fqssjfS2dVt0al/c7x+G9ek8BNZUUAAlt
         tqksMV6DFPHeR/NlXKkzQTasWOCnQSjdSEyzLrds0S8i079xu2YH9h6bn31UGg/EzRPR
         rl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4D3o5SEJKsvVBksV7qKTIddf2rG+0VEDDDbyrl2Tbrs=;
        b=ikhrrQu+KBRMhdgIhLpyDaV8v8X57UC6mhgIhCnI3qxTAesesP2NdL5N6qX4H864Id
         b50E3RbwlBAj4anHasW4ZdLSdeko1OiMncYUEhkwihVgYKI2dS/gFjUCYespQL+O4qIG
         jS5s2sPujVhDI7Wdwb4ACIIrl17g8RcGghFqLoWd2s5ZCDEEM6d1/P2lZ920QvyBGfpZ
         RMz7h/BcHAA7OlHQlhh70WjDmnYQDoVXpPx0hn0sSg7B53UiQSCczbsZgWWoBjItg/1r
         vqjR4CkwsDINhKgnPsjyBrCRfAht+OpYWhkZVedCPgas966VSRQjfc5AY+8ndp4ZSx1Z
         BxHQ==
X-Gm-Message-State: APjAAAUN+xlOJ3AV+8ulDfFA+7mirAevRA+JM1p69goBQtjcvvAojaGT
        bKrny081GUqre6gcuS6qamc=
X-Google-Smtp-Source: APXvYqxPkVnjlezscaNqpaFxgwBmw/ubpqan5rXFlB+uwyl+qnq0OQHnkDnthoFroLpDcGFM8bUjXQ==
X-Received: by 2002:adf:c594:: with SMTP id m20mr47191662wrg.126.1563801480886;
        Mon, 22 Jul 2019 06:18:00 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id z6sm34156657wrw.2.2019.07.22.06.17.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:18:00 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        David Lechner <david@lechnology.com>
Subject: [RESEND PATCH 09/10] ARM: davinci: dm646x: switch to using the clocksource driver
Date:   Mon, 22 Jul 2019 15:17:47 +0200
Message-Id: <20190722131748.30319-10-brgl@bgdev.pl>
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

