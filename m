Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D489C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479EA26DF6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZ93Ail9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfFCTEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:04:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44468 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfFCTEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:04:21 -0400
Received: by mail-lf1-f67.google.com with SMTP id r15so14439469lfm.11;
        Mon, 03 Jun 2019 12:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FVedIOrmGpOcaFRJmHXTB7UeLVU4DsMUhFHAazuTakE=;
        b=kZ93Ail9+7vDuf/EP+z/Uk5Zc5nCngrmdm3PerDt+ORY1Bt3tlBRhNNWOPcfSwp3DS
         SISLTt9v3b06b4mgHNwLSBcCKh4xelPKDyFy44NPgZ6Tzlq/ZN3gVXKiLkPqJbJ7l4Ke
         Nz+U/CNv0HMP9Pi4CYrZkRLqZASmnRM9rG6VOsbzJcmKTlZMjaVN2bzZoXFa2lvEVwML
         8knF+J/+pQROQzZkZ12Upx+2MCN82P7JRgu9cvndPWEPz2jkgvQNAHBff9ulwMOQlHlg
         ZHeUZTgk1jS9D4fmvGhivvdw74f1ChGrTmqhmilvrlrIc4lOOvbvVPxpCEfF6Zcp7IiX
         tGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FVedIOrmGpOcaFRJmHXTB7UeLVU4DsMUhFHAazuTakE=;
        b=efK0DpdTMVTLfh/+IumbSBe+rg8VEwDBveMn0W7s8B/k4qgIKNbnpVpOuDJAj9eYX7
         LVGrhGrqupoqB1Gk4k9hpjmoxauMH0ROJ7vHAecciz3QLGWXLwk06HFo+bVGVYQPdr6U
         sEeao0ozXzZb966Da3Bso5lAxNYLke2pN918rjChM8dKek/w+BP0xr/MrjQQVZtfwoj6
         fByldXFKxQvwonXhezfpbxis6zjufnGTDmQscnu+TZM4m9NWP/S4JqAm9RTY58Fk8I5v
         l7TvuNoHTS72FjqUZAYqdjCrrPXX/ahV48JC7OXy+nFHjnAuCpiqLjeTejFlZSTKMe7Q
         geLA==
X-Gm-Message-State: APjAAAXHu6uN2Z3Zgr0Xumnk90U7pZNV8SMxprVF4jwFw5lFxvQymDuX
        DoWDMY5MnhMIqYSl3gMk1b4=
X-Google-Smtp-Source: APXvYqxdEv2Vn5T6ahWoa48i7Ub6eHb9RjI+J50YkgWmeZtzMHxY4+1+NkxtFb+4L4CNy54kOrA9uQ==
X-Received: by 2002:a19:e34e:: with SMTP id c14mr14279884lfk.47.1559588658239;
        Mon, 03 Jun 2019 12:04:18 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id l22sm2768805ljb.39.2019.06.03.12.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 12:04:17 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/10] clocksource/drivers/tegra: Minor code clean up
Date:   Mon,  3 Jun 2019 21:59:44 +0300
Message-Id: <20190603185948.30438-7-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603185948.30438-1-digetx@gmail.com>
References: <20190603185948.30438-1-digetx@gmail.com>
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
 drivers/clocksource/timer-tegra20.c | 43 ++++++++++++++++-------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index 18b81d814b3b..12784a82fd57 100644
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
@@ -57,7 +59,7 @@ static u32 usec_config;
 static void __iomem *timer_reg_base;
 
 static int tegra_timer_set_next_event(unsigned long cycles,
-					 struct clock_event_device *evt)
+				      struct clock_event_device *evt)
 {
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
@@ -178,15 +180,17 @@ static struct timer_of suspend_rtc_to = {
 
 /*
  * tegra_rtc_read - Reads the Tegra RTC registers
- * Care must be taken that this funciton is not called while the
+ * Care must be taken that this function is not called while the
  * tegra_rtc driver could be executing to avoid race conditions
  * on the RTC shadow register
  */
 static u64 tegra_rtc_read_ms(struct clocksource *cs)
 {
 	void __iomem *reg_base = timer_of_base(&suspend_rtc_to);
+
 	u32 ms = readl_relaxed(reg_base + RTC_MILLISECONDS);
 	u32 s = readl_relaxed(reg_base + RTC_SHADOW_SECONDS);
+
 	return (u64)s * MSEC_PER_SEC + ms;
 }
 
@@ -231,7 +235,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
 
 	to = this_cpu_ptr(&tegra_to);
 	ret = timer_of_init(np, to);
-	if (ret < 0)
+	if (ret)
 		goto out;
 
 	timer_reg_base = timer_of_base(to);
@@ -290,8 +294,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
 		cpu_to->clkevt.cpumask = cpumask_of(cpu);
 		cpu_to->clkevt.irq = irq_of_parse_and_map(np, idx);
 		if (!cpu_to->clkevt.irq) {
-			pr_err("%s: can't map IRQ for CPU%d\n",
-			       __func__, cpu);
+			pr_err("failed to map irq for cpu%d\n", cpu);
 			ret = -EINVAL;
 			goto out_irq;
 		}
@@ -301,8 +304,8 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
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
@@ -321,11 +324,14 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
 	register_current_timer_delay(&tegra_delay_timer);
 #endif
 
-	cpuhp_setup_state(CPUHP_AP_TEGRA_TIMER_STARTING,
-			  "AP_TEGRA_TIMER_STARTING", tegra_timer_setup,
-			  tegra_timer_stop);
+	ret = cpuhp_setup_state(CPUHP_AP_TEGRA_TIMER_STARTING,
+				"AP_TEGRA_TIMER_STARTING", tegra_timer_setup,
+				tegra_timer_stop);
+	if (ret)
+		pr_err("failed to set up cpu hp state: %d\n", ret);
 
 	return ret;
+
 out_irq:
 	for_each_possible_cpu(cpu) {
 		struct timer_of *cpu_to;
@@ -338,6 +344,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20)
 	}
 out:
 	timer_of_cleanup(to);
+
 	return ret;
 }
 
@@ -361,8 +368,6 @@ static int __init tegra20_init_rtc(struct device_node *np)
 	if (ret)
 		return ret;
 
-	clocksource_register_hz(&suspend_rtc_clocksource, 1000);
-
-	return 0;
+	return clocksource_register_hz(&suspend_rtc_clocksource, 1000);
 }
 TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
-- 
2.21.0

