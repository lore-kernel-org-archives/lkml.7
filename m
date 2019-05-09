Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BDCC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBD120644
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fBGeZQwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfEILLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:11:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35622 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfEILLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:11:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id w12so2495084wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 04:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uXE39cHm/ePcze6cpMzENlQKnSZwc2KOJnys2n77A3I=;
        b=fBGeZQwyL/GXofUWkHPptZvFcDgg6iRQ++N6BG24UZql7XkRmLSIX4wGmFMKMv4h3k
         4A2HvUQ0oG01QZkjGdkGZdsU8wVM0kW1i0xpcdINkL9OTkEysMjKwlfM2f2xjtVkJ5M1
         vyIL7PeHONfja5TfFdesuMUyT5Gf9aeKARGKfnkaCoN040fl1ZhlP57jcMFhfjU1lU8A
         8DOqB1GVLAYA02p2ACgceWtoWXflDkJ/sZTSCWrYUzESvuQDmtVOqvV5iH4SmGNIAhT2
         zpUUUrjdvSIH3exFamyAB5SdEg0+58LvjhYcCwdzvOZ5jOglUzEGuFNYeKHgZtAecmBj
         t3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uXE39cHm/ePcze6cpMzENlQKnSZwc2KOJnys2n77A3I=;
        b=bNN/r6ImfFGajaXAdGC38ESTPNXSiY8CcIzzqEavkRsMYatNK4Bo/NFOjzbx0nqNJs
         WqmStAd8O/sWQzwbZcxLB/0bZvfgWP0OGTFcik+3IuLChmLrWy7qm9hvSSJlaKPYNfGR
         1dvoxDWOelNvQggztkMn8vW/AlM3uIQCOHNcPfxrfZsDMtxhSa3oWSubp1HMUqTDBcPK
         DpyFxptT2WGKKR7W6GuZf06IEmSZwK3toMNiAZgSy7Pi2LyCJaNtIFRS7YKEknZeUwbj
         HEutBX5PkWBIi/mxknpJntJzh+q5G4alnzz0xHh0NRzFnPfhwy7eaf5DHDqX0/YK4FWb
         EKvw==
X-Gm-Message-State: APjAAAWEpGtvO2tp1xqYT6jGW3FemH3YbT52T3O3RnBRou5zf+U0pari
        pzDt79Mo16OdIeeROW2ABZRs6Q==
X-Google-Smtp-Source: APXvYqzUngphJjXPgwCdPMD+HnCjgeFAhWbgsnM6xO7Dgm9TJSdwV6DIRiqVuLArj7eqjF8ScYtSYw==
X-Received: by 2002:a5d:518d:: with SMTP id k13mr889239wrv.285.1557400298313;
        Thu, 09 May 2019 04:11:38 -0700 (PDT)
Received: from mai.irit.fr ([141.115.39.235])
        by smtp.gmail.com with ESMTPSA id z7sm2299778wme.26.2019.05.09.04.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:11:37 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:MICROCHIP TIMER
        COUNTER (TC) AND CLOCKSOURCE DR...)
Subject: [PATCH 09/15] clocksource/drivers/tcb_clksrc: Use tcb as sched_clock
Date:   Thu,  9 May 2019 13:10:42 +0200
Message-Id: <20190509111048.11151-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509111048.11151-1-daniel.lezcano@linaro.org>
References: <7e786ba3-a664-8fd9-dd17-6a5be996a712@linaro.org>
 <20190509111048.11151-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Now that the driver is registered early enough, use the TCB as the
sched_clock which is much more accurate than the jiffies implementation.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/tcb_clksrc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index bf68504da94a..9de8c10ab546 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/sched_clock.h>
 #include <linux/syscore_ops.h>
 #include <soc/at91/atmel_tcb.h>
 
@@ -114,6 +115,16 @@ static struct clocksource clksrc = {
 	.resume		= tc_clksrc_resume,
 };
 
+static u64 notrace tc_sched_clock_read(void)
+{
+	return tc_get_cycles(&clksrc);
+}
+
+static u64 notrace tc_sched_clock_read32(void)
+{
+	return tc_get_cycles32(&clksrc);
+}
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 
 struct tc_clkevt_device {
@@ -335,6 +346,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 	struct atmel_tc tc;
 	struct clk *t0_clk;
 	const struct of_device_id *match;
+	u64 (*tc_sched_clock)(void);
 	u32 rate, divided_rate = 0;
 	int best_divisor_idx = -1;
 	int clk32k_divisor_idx = -1;
@@ -419,6 +431,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		clksrc.read = tc_get_cycles32;
 		/* setup ony channel 0 */
 		tcb_setup_single_chan(&tc, best_divisor_idx);
+		tc_sched_clock = tc_sched_clock_read32;
 	} else {
 		/* we have three clocks no matter what the
 		 * underlying platform supports.
@@ -430,6 +443,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		}
 		/* setup both channel 0 & 1 */
 		tcb_setup_dual_chan(&tc, best_divisor_idx);
+		tc_sched_clock = tc_sched_clock_read;
 	}
 
 	/* and away we go! */
@@ -442,6 +456,8 @@ static int __init tcb_clksrc_init(struct device_node *node)
 	if (ret)
 		goto err_unregister_clksrc;
 
+	sched_clock_register(tc_sched_clock, 32, divided_rate);
+
 	return 0;
 
 err_unregister_clksrc:
-- 
2.17.1

