Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6261EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2384621773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1x+D77m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfDXXPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:15:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36100 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbfDXXPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:15:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id l6so3638289ljb.3;
        Wed, 24 Apr 2019 16:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yoEiSbSdJQLYeim2uLzgko9tpVAw+Ke4PMk2KimoBv4=;
        b=V1x+D77mFTHBbU9LSCyD3cY4WD02HHChuetj+6qn2bihjFESh222fHWZJz77qLe3hV
         meGN8qn7EO4ZVVH3+ngtsS4ojg4lnLvBysCGUBSg3tyunGqVBpSxq47EEF87sgy+Uc3/
         XVV/MiFFouAqkkwPhWi0uY/xvzwwEEdR87GCk2gg9G7vD16DYAcjdlV+k2rqTOGk7zeL
         KIOe8ZDFFEnDDqi3Ld4G4CE55uUp4KuHv443QMIRUPYYFVKAelQ5X0n8kQxs8vkvsIyr
         bqp8/NbpXdYQHhPuYYVzI+SOtEFPFMEOJdUnd5tzSGRNIU+WWbr3whFbHVY1GeKanH5S
         1oDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yoEiSbSdJQLYeim2uLzgko9tpVAw+Ke4PMk2KimoBv4=;
        b=egDFHdveZjIJ1aQ669SHHyaR04ASd0rHMcmbIIlvEvJrfbO2dJc9Tzun9fjKdlHTVK
         ILQcbeeAUvYwNWLpn69m0Wmq9YOubu/ub+S4Rwn09xR1P0iJ1Ltty19Iku1NDSANZ3n6
         1yAEj6rbiv+SzO2TI7fdJLttFGl5vjWQQoJM/l85R0cdkCiIaUnD53tfwRb9m9rStgqA
         BhHftXTUX9cCMwepiQJIin4Ror6kAqLECQEPRBVupZEakAG3761xocWwCFBI55vUodR2
         9ZhOsHGBNlILAwW8ejD2pTz4MGB+FfdgVoTSLxfEXt9T34Q+vUOsflm/kTXeKweASVSf
         4FXw==
X-Gm-Message-State: APjAAAXkaushI5dkduxiH0iTE8AbOLyK4UwVCMzk5CDaYFhZibt7KfWU
        2fWvKUKnHOFsS/EZxP10kyc=
X-Google-Smtp-Source: APXvYqx6CE64Uv1NVojg+Nv50dhjt3UF+34HVtlu/PKF0pebwsviUT6K8JYJEtDoImVPojpUI8adNQ==
X-Received: by 2002:a2e:9941:: with SMTP id r1mr3654801ljj.168.1556147713717;
        Wed, 24 Apr 2019 16:15:13 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id j13sm830192lfb.34.2019.04.24.16.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:15:13 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/7] clocksource/drivers/tegra: Minor code clean up
Date:   Thu, 25 Apr 2019 02:14:43 +0300
Message-Id: <20190424231444.20876-7-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424231444.20876-1-digetx@gmail.com>
References: <20190424231444.20876-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct typo and use proper upper casing for acronyms in the comments,
use common style for error messages, prepend error messages with
"tegra-timer:", add error message for cpuhp_setup_state() failure and
clean up whitespaces in the code to fix checkpatch warnings.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra20.c | 42 ++++++++++++++++-------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index df3139ed7157..e87fa5719d4b 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -15,6 +15,8 @@
  *
  */
 
+#define pr_fmt(fmt)	"tegra-timer: " fmt
+
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
@@ -30,13 +32,13 @@
 
 #include "timer-of.h"
 
-#define RTC_SECONDS            0x08
-#define RTC_SHADOW_SECONDS     0x0c
-#define RTC_MILLISECONDS       0x10
+#define RTC_SECONDS		0x08
+#define RTC_SHADOW_SECONDS	0x0c
+#define RTC_MILLISECONDS	0x10
 
-#define TIMERUS_CNTR_1US 0x10
-#define TIMERUS_USEC_CFG 0x14
-#define TIMERUS_CNTR_FREEZE 0x4c
+#define TIMERUS_CNTR_1US	0x10
+#define TIMERUS_USEC_CFG	0x14
+#define TIMERUS_CNTR_FREEZE	0x4c
 
 #define TIMER_PTV		0x0
 #define TIMER_PTV_EN		BIT(31)
@@ -60,7 +62,7 @@ static struct timespec64 persistent_ts;
 static u64 persistent_ms, last_persistent_ms;
 
 static int tegra_timer_set_next_event(unsigned long cycles,
-					 struct clock_event_device *evt)
+				      struct clock_event_device *evt)
 {
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
@@ -185,7 +187,7 @@ static struct delay_timer tegra_delay_timer = {
 
 /*
  * tegra_rtc_read - Reads the Tegra RTC registers
- * Care must be taken that this funciton is not called while the
+ * Care must be taken that this function is not called while the
  * tegra_rtc driver could be executing to avoid race conditions
  * on the RTC shadow register
  */
@@ -193,6 +195,7 @@ static u64 tegra_rtc_read_ms(void)
 {
 	u32 ms = readl_relaxed(rtc_base + RTC_MILLISECONDS);
 	u32 s = readl_relaxed(rtc_base + RTC_SHADOW_SECONDS);
+
 	return (u64)s * MSEC_PER_SEC + ms;
 }
 
@@ -202,7 +205,7 @@ static u64 tegra_rtc_read_ms(void)
  * Reads the time from a source which isn't disabled during PM, the
  * 32k sync timer.  Convert the cycles elapsed since last read into
  * nsecs and adds to a monotonically increasing timespec64.
- * Care must be taken that this funciton is not called while the
+ * Care must be taken that this function is not called while the
  * tegra_rtc driver could be executing to avoid race conditions
  * on the RTC shadow register
  */
@@ -313,8 +316,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
 		cpu_to->clkevt.cpumask = cpumask_of(cpu);
 		cpu_to->clkevt.irq = irq_of_parse_and_map(np, idx);
 		if (!cpu_to->clkevt.irq) {
-			pr_err("%s: can't map IRQ for CPU%d\n",
-			       __func__, cpu);
+			pr_err("failed to map irq for cpu%d\n", cpu);
 			ret = -EINVAL;
 			goto out_irq;
 		}
@@ -324,8 +326,8 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
 				  IRQF_TIMER | IRQF_NOBALANCING,
 				  cpu_to->clkevt.name, &cpu_to->clkevt);
 		if (ret) {
-			pr_err("%s: cannot setup irq %d for CPU%d\n",
-				__func__, cpu_to->clkevt.irq, cpu);
+			pr_err("failed to set up irq for cpu%d: %d\n",
+			       cpu, ret);
 			irq_dispose_mapping(cpu_to->clkevt.irq);
 			cpu_to->clkevt.irq = 0;
 			goto out_irq;
@@ -342,9 +344,11 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
 
 	register_current_timer_delay(&tegra_delay_timer);
 
-	cpuhp_setup_state(CPUHP_AP_TEGRA_TIMER_STARTING,
-			  "AP_TEGRA_TIMER_STARTING", tegra_timer_setup,
-			  tegra_timer_stop);
+	ret = cpuhp_setup_state(CPUHP_AP_TEGRA_TIMER_STARTING,
+				"AP_TEGRA_TIMER_STARTING", tegra_timer_setup,
+				tegra_timer_stop);
+	if (ret)
+		pr_err("failed to set up cpu hp state: %d\n", ret);
 
 	return ret;
 out_irq:
@@ -383,17 +387,17 @@ static int __init tegra20_init_rtc(struct device_node *np)
 
 	rtc_base = of_iomap(np, 0);
 	if (!rtc_base) {
-		pr_err("Can't map RTC registers\n");
+		pr_err("failed to map rtc registers\n");
 		return -ENXIO;
 	}
 
 	/*
-	 * rtc registers are used by read_persistent_clock, keep the rtc clock
+	 * RTC registers are used by read_persistent_clock, keep the RTC clock
 	 * enabled
 	 */
 	clk = of_clk_get(np, 0);
 	if (IS_ERR(clk))
-		pr_warn("Unable to get rtc-tegra clock\n");
+		pr_warn("failed to get rtc-tegra clock\n");
 	else
 		clk_prepare_enable(clk);
 
-- 
2.21.0

