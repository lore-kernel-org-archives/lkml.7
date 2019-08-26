Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606D0C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300D52184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aU3cka8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbfHZUoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:44:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37903 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730620AbfHZUov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:44:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so16620397wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KPovm7Wqq5ONpgYMzcWE7OA1yW+eFGPyRUwfUI0hUJ0=;
        b=aU3cka8c1AQSVSN8MhAGKFkLRjd0H8XrOtbp/x2/hFD2uq4c0BbiB2QY0ghWInXBGC
         5rN5dd3SqgbzjbMCFWIpScJgDCd1YCPSTxuF2IjR4wG/Jz206l7856QTAku0xz2boFbH
         xDPEUKf1OTt2vpZhFICPjDYkFy2HNrlf5SUg7lcV/G198a9Ci9hsaXQKgnK7yIxTvsZN
         j8P6b6+xsyvAeMr2eSnIYCL/KatF+OXC6YnPNtBUoxOs8U1am6qjXfeiFV7HFp9kGj8V
         Q83XJKPTKHtLU058eb1EFPriPhAR4ZZcPPT6/RTMTC4RwTmmWwAXCem9jCPuF6ZSxK9S
         SOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KPovm7Wqq5ONpgYMzcWE7OA1yW+eFGPyRUwfUI0hUJ0=;
        b=dbb6lUI4bmUHE9f28xuQNLK5It0CDCQvDYyvrCHzEvdF/DvhzrSJCtIPE5ZFipl1yx
         VKxUSY20fSyL2qPIOOnaajJC6dCkD3vfc4tY0HkOMVah7XG0Jm2crMb5QDRwQv42KtoZ
         agJTcXkVYhnCwXNH+hgl4iG/1a0d2A87/3W9XGLygA4rDamMA2YxodX5Zog3q3Lj7LMB
         dJ21Skf24VTlpzM2GXXQJjrOJpn5hpyD5ITNf14H6KSaB25w48o9fOuPnKyRMQN6/o5j
         jblWWQqetZyy/VdvHPMa8SuMzidPpKWp8Wl05U5PTKjWN8vmjs6lH3d0F8Qt5VT8QoIo
         Aq2A==
X-Gm-Message-State: APjAAAWhjkWjEv14nTxkkB80GSZToMa5L7GOsIX1ZbD71PWkMPr2zkam
        9tGnnFhf3ttw+uttllxKN/Ho8w==
X-Google-Smtp-Source: APXvYqx1bP/yZ2ct9gGrw3/PrAY5QgTYxdvm4ozIz6UraMNr+NRuLzZjgbTD62gTCxjLFwLXZDIrog==
X-Received: by 2002:adf:fc03:: with SMTP id i3mr23215781wrr.48.1566852289672;
        Mon, 26 Aug 2019 13:44:49 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.gmail.com with ESMTPSA id 20sm549557wmk.34.2019.08.26.13.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:44:49 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip
        (AT91) SoC support)
Subject: [PATCH 06/20] clocksource/drivers/tcb_clksrc: Register delay timer
Date:   Mon, 26 Aug 2019 22:43:53 +0200
Message-Id: <20190826204407.17759-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826204407.17759-1-daniel.lezcano@linaro.org>
References: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
 <20190826204407.17759-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Implement and register delay timer to allow get_cycles() to work properly.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig           |  2 +-
 drivers/clocksource/timer-atmel-tcb.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5e9317dc3d39..a642c23b2fba 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -429,7 +429,7 @@ config ATMEL_ST
 
 config ATMEL_TCB_CLKSRC
 	bool "Atmel TC Block timer driver" if COMPILE_TEST
-	depends on HAS_IOMEM
+	depends on ARM && HAS_IOMEM
 	select TIMER_OF if OF
 	help
 	  Support for Timer Counter Blocks on Atmel SoCs.
diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 6ed31f9def7e..7427b07495a8 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -6,6 +6,7 @@
 #include <linux/irq.h>
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
@@ -125,6 +126,18 @@ static u64 notrace tc_sched_clock_read32(void)
 	return tc_get_cycles32(&clksrc);
 }
 
+static struct delay_timer tc_delay_timer;
+
+static unsigned long tc_delay_timer_read(void)
+{
+	return tc_get_cycles(&clksrc);
+}
+
+static unsigned long notrace tc_delay_timer_read32(void)
+{
+	return tc_get_cycles32(&clksrc);
+}
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 
 struct tc_clkevt_device {
@@ -432,6 +445,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		/* setup ony channel 0 */
 		tcb_setup_single_chan(&tc, best_divisor_idx);
 		tc_sched_clock = tc_sched_clock_read32;
+		tc_delay_timer.read_current_timer = tc_delay_timer_read32;
 	} else {
 		/* we have three clocks no matter what the
 		 * underlying platform supports.
@@ -444,6 +458,7 @@ static int __init tcb_clksrc_init(struct device_node *node)
 		/* setup both channel 0 & 1 */
 		tcb_setup_dual_chan(&tc, best_divisor_idx);
 		tc_sched_clock = tc_sched_clock_read;
+		tc_delay_timer.read_current_timer = tc_delay_timer_read;
 	}
 
 	/* and away we go! */
@@ -458,6 +473,9 @@ static int __init tcb_clksrc_init(struct device_node *node)
 
 	sched_clock_register(tc_sched_clock, 32, divided_rate);
 
+	tc_delay_timer.freq = divided_rate;
+	register_current_timer_delay(&tc_delay_timer);
+
 	return 0;
 
 err_unregister_clksrc:
-- 
2.17.1

