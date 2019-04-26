Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FD5C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFCC206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfDZVrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:47:32 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:39535 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfDZVr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:47:29 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 6B69B40006;
        Fri, 26 Apr 2019 21:47:25 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Romain Izard <romain.izard.pro@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 1/9] ARM: at91: move SoC specific definitions to SoC folder
Date:   Fri, 26 Apr 2019 23:47:10 +0200
Message-Id: <20190426214718.13470-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426214718.13470-1-alexandre.belloni@bootlin.com>
References: <20190426214718.13470-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move linux/atmel_tc.h to the SoC specific folder include/soc/at91.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clocksource/tcb_clksrc.c                   | 2 +-
 drivers/misc/atmel_tclib.c                         | 2 +-
 drivers/pwm/pwm-atmel-tcb.c                        | 2 +-
 include/{linux/atmel_tc.h => soc/at91/atmel_tcb.h} | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)
 rename include/{linux/atmel_tc.h => soc/at91/atmel_tcb.h} (99%)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 43f4d5c4d6fa..138a12090149 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -11,7 +11,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/syscore_ops.h>
-#include <linux/atmel_tc.h>
+#include <soc/at91/atmel_tcb.h>
 
 
 /*
diff --git a/drivers/misc/atmel_tclib.c b/drivers/misc/atmel_tclib.c
index ac24a4bd63f7..194f774ab3a1 100644
--- a/drivers/misc/atmel_tclib.c
+++ b/drivers/misc/atmel_tclib.c
@@ -1,4 +1,3 @@
-#include <linux/atmel_tc.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -10,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/of.h>
+#include <soc/at91/atmel_tcb.h>
 
 /*
  * This is a thin library to solve the problem of how to portably allocate
diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 0d0f8376bc35..7da1fdb4d269 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -17,10 +17,10 @@
 #include <linux/ioport.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
-#include <linux/atmel_tc.h>
 #include <linux/pwm.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
+#include <soc/at91/atmel_tcb.h>
 
 #define NPWM	6
 
diff --git a/include/linux/atmel_tc.h b/include/soc/at91/atmel_tcb.h
similarity index 99%
rename from include/linux/atmel_tc.h
rename to include/soc/at91/atmel_tcb.h
index 468fdfa643f0..c3c7200ce151 100644
--- a/include/linux/atmel_tc.h
+++ b/include/soc/at91/atmel_tcb.h
@@ -7,8 +7,8 @@
  * (at your option) any later version.
  */
 
-#ifndef ATMEL_TC_H
-#define ATMEL_TC_H
+#ifndef __SOC_ATMEL_TCB_H
+#define __SOC_ATMEL_TCB_H
 
 #include <linux/compiler.h>
 #include <linux/list.h>
-- 
2.20.1

