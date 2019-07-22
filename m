Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7FBC76198
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C915821901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="PQw+pP1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbfGVNSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:18:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37749 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbfGVNSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:18:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so14323369wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zOhvfud1UplL6dXW+3V5RKRSj+/QqrgOZPNk1aW9k94=;
        b=PQw+pP1iXX72GVQ9kohjgqtP+wTw65TQAgRYVrUlgLjAVsRxK4c4+l/lntTh00Q9M3
         8teC3SYE0xetvNP5nkU6e4YBh4V4GrB3q+Lq0BP4EqB2/wLVtArQllQ+r4GMx1RlKBBd
         puuo7oASjqffQkBoxzRoQkZtvjPdz2ZeysMOf+8UE5BM202tQ3SVxz7nl+GUjon+AEbI
         cUMLG2f1a00E9Hp4Szm87vNMnwxnJanc041SLIt4+l+9rU/XP4mOI5RDFmWLjEjorkPe
         pMLYh8h/tOOkwTzFMwBXpg9yuYlnTB00OPzHStXOCmQrEbb/lLFLR4Fx9+lPAKaV+zQX
         t9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zOhvfud1UplL6dXW+3V5RKRSj+/QqrgOZPNk1aW9k94=;
        b=rN5o05B+bCx3d5BF7MOTMzXmH6u8ps+fENUQKut/p8WdDMGb+8CZ9nt7Uz3mnveWXk
         Ax4wE7BXoQBy5TthneksF3DocbsZtb19r9I9XVAWeBCuHvnHDL0e4xXgIGDBTZpm7jjb
         T8rXKa+OQ2wBuASoPsFRdVvVd3WAeV2PjwWZG78O+833uT31yD2301z9Ezcbg5s2H4v5
         8gZh1ON9gMq0sS2VBs1QGYP/0caBn44PIQg/iLlJR0ySpRXrdOfV7zwcqY9X8P0xgrYT
         pY36l5Y98wrOtqjxVWCHh+zs0bGIddwWlv5xYbo1qgQL6KwYEW0nyKaa5CpIJb6UUoMH
         t+Ng==
X-Gm-Message-State: APjAAAUCxHEf1ICp7poy1h9XHc1RC6NxdqMVPT9WRVrcf/Tjn5KTQ9hR
        8AQM+Ir7BxRtxuCqE0vZ8Ts=
X-Google-Smtp-Source: APXvYqw5kSAQACR7OW4MuKFZ+QqrkrmM83HBxycXSdQYRQePn0m/CpYbJW8RlJw372HR07CxxdrZxQ==
X-Received: by 2002:a5d:6709:: with SMTP id o9mr19402007wru.301.1563801477974;
        Mon, 22 Jul 2019 06:17:57 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id z6sm34156657wrw.2.2019.07.22.06.17.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:17:57 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        David Lechner <david@lechnology.com>
Subject: [RESEND PATCH 06/10] ARM: davinci: dm355: switch to using the clocksource driver
Date:   Mon, 22 Jul 2019 15:17:44 +0200
Message-Id: <20190722131748.30319-7-brgl@bgdev.pl>
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

