Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A0FC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CC620644
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dDaPI9k3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfEILLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:11:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40892 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfEILLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:11:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so2458343wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 04:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OrI1DkG8hXh5qOzNYuZ9U1o4Js7uyFKM86UkARAQjFU=;
        b=dDaPI9k3tcMtll47Djpz/rdtUGEzwzvLyyL0l//cu8cVR2Rt99lGVVkca4bXCWy+bF
         6cA0oko1TzN6KJydKoxqLaE6azX6lRuedbrSJPew3NWRjR7BLke3Fqi8giw2uDhne1qD
         qKVThZQ/j3dwNLYKXGIjM4SUk48jDT86z07FLXGIg3JuxV1uIUCtgXMDgPR09ZZMfZr+
         TNHzhK3fyYN/vr3k/3/WP6pHTR+hO1AntaTqGiyZ0TU+Wlnzh8TPRxANcXf0ShFml+vx
         o70PgJlW2nxCNS2TKkr488HT9y5XauThy5EedX37kOz98RiqhvvRoUuaPW9l7sXT3Nbm
         Qhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OrI1DkG8hXh5qOzNYuZ9U1o4Js7uyFKM86UkARAQjFU=;
        b=eWpGnFrnW5nweBXx0TNnNMK3ELKL91Vww5U1vEfG0l0tpWF/Rq2ha7BcQuOddLV2cM
         SPh+SYCzGV+v4QuoLoF4mVQaCqCCUCB32UOrlqfLa/sQHmL/U23qfCHE01uw5MF7usxX
         nrBL2n0qXUPE56oKHGhUz5dg6qDNJZw0fsKw3MFEO20gudOOuh37oFUyx2auf6HeBsZR
         0p0oN8nKsGsFBh7AIckIfFYCFEqE08JIwE5/PqisGcLYioMSjOUK/AjW408c9GzcKgh/
         +k4Ey9HNBW4SN0Pix/dc8YDpTqmv2Gw9ES/s/I2EU6kb7QNR1/5fivG8sQK3/PtLpL61
         4Vmg==
X-Gm-Message-State: APjAAAX4jDUVOJPMEU5DcvirQ00BXQeMn892wzWL2DMPWIRHwDa75Vx/
        HP6TnZbLsjkDCdKV6OyWhSMRng==
X-Google-Smtp-Source: APXvYqzkFCRg/4jV4ymjIhFIzAV05l1GgTMsLu+5AiktxlCAcReCeZs1b3mYSzdsAI2AeT9bdLmVAw==
X-Received: by 2002:adf:9c87:: with SMTP id d7mr2643806wre.68.1557400295729;
        Thu, 09 May 2019 04:11:35 -0700 (PDT)
Received: from mai.irit.fr ([141.115.39.235])
        by smtp.gmail.com with ESMTPSA id z7sm2299778wme.26.2019.05.09.04.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:11:35 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Chas Williams <3chas3@gmail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:MICROCHIP TIMER
        COUNTER (TC) AND CLOCKSOURCE DR...),
        linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
        linux-atm-general@lists.sourceforge.net (moderated list:ATM),
        netdev@vger.kernel.org (open list:ATM)
Subject: [PATCH 07/15] ARM: at91: move SoC specific definitions to SoC folder
Date:   Thu,  9 May 2019 13:10:40 +0200
Message-Id: <20190509111048.11151-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509111048.11151-1-daniel.lezcano@linaro.org>
References: <7e786ba3-a664-8fd9-dd17-6a5be996a712@linaro.org>
 <20190509111048.11151-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Move linux/atmel_tc.h to the SoC specific folder include/soc/at91.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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
2.17.1

