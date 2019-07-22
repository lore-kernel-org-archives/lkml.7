Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3913EC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DE621993
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DsDrdUqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbfGVNS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:18:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34993 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729744AbfGVNSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:18:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id y4so39414874wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=19fYL7Z8mI6tfJg545F0VQ6RS/+NjmhdJgfi1UhO5UU=;
        b=DsDrdUquw3YNnBzyEWqWdI+Cnfy6Fuvtlxefcq7vLIqQu9bYaNFyXVPtdG0VhmtOt1
         jPjkrCH4S9jJwJIUfomAlL35Jg+buseKoulSgicwy7YtYH0aLc5gMNd5buv6y7ufo5fP
         /jM319NAu7NqGRg5qnv+LPCISXZ2vCD8SP5JNc/Gszn3x2SI0qBV2aQ4LdoM6GpHnybs
         Iy8jYLrMqWUDEOQ5miMz5tfL1PBoX9GCwLOozl9sqv7rRhgBS0BueM0N+t4lR0YqqXlo
         mbkfrhlSdzEW47X2cvAz20UX0YtCRcafjiQmVcUbseybZ7AU02C+j/4igUBBI/Gbmens
         HP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=19fYL7Z8mI6tfJg545F0VQ6RS/+NjmhdJgfi1UhO5UU=;
        b=sFERAiZvrjjgmfsXkomrJipkXuEMrVEGuKxj4zw7r19mCh7c2QbsEh50xPTAvIOQNi
         lssZTVOwo2nAtULKIlIXv4bZe2QfeLpB+39AcD+3LCNmztiUxJFCeyViruw2XFipssdd
         FkFePh/cpGkEelsfdi2FqncqngIQEVyPMvAWjBnODtNTUYcSs6BXtjpSkXhpCEXIh9sd
         7nFzwDD41uRM77XXx3dUU6/TeR5zm3A4i6cMRidOXIuxjffRNGYCA6oYH/H4sx/+aGVr
         vb8C1eJz6VpNGE7LLHb9YnGmrd2Wr+H3PRilTM0JGTUH188pnZbbQLspKJy2aRKHOFVh
         EUag==
X-Gm-Message-State: APjAAAVTtjxUOk2Bn7AsQjZ7w1JXZVWgOoJXupZPYB07ad0Y/E/AADCN
        k48mMWgp6Cl29xNycKCw+5o=
X-Google-Smtp-Source: APXvYqx03dcJEB7dW7BRLPq2VnDhGkGWV+spKrTYqsXZx5pmb7YimlWrjM6/E+UJDvKDOeIoVr/LYA==
X-Received: by 2002:adf:f348:: with SMTP id e8mr77592071wrp.76.1563801478939;
        Mon, 22 Jul 2019 06:17:58 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id z6sm34156657wrw.2.2019.07.22.06.17.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:17:58 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        David Lechner <david@lechnology.com>
Subject: [RESEND PATCH 07/10] ARM: davinci: dm365: switch to using the clocksource driver
Date:   Mon, 22 Jul 2019 15:17:45 +0200
Message-Id: <20190722131748.30319-8-brgl@bgdev.pl>
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

We now have a proper clocksource driver for davinci. Switch the dm365
platform to using it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/dm365.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 8062412be70f..2299ca445c0e 100644
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
+	.reg = DEFINE_RES_IO(DAVINCI_TIMER0_BASE, SZ_4K),
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
2.21.0

