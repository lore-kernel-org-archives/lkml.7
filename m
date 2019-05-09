Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD41C04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C6A204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tk0VK6es"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfEILMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:12:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36689 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfEILLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:11:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id o4so2474504wra.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 04:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P3ip9Z1kPiurKcUpueirhLQ3VIip1Pisqdmbkd91afc=;
        b=tk0VK6eshbXc6vdh9kh06KVLt040/1a5YvqavcZdlyogvdnIi3Z4HZkhRrNJRUkW84
         xqnY2WsmFfZfGeJbBbR9m3uFHGPMOEER+cg+fqfietDdEX3q2cmAinp1Jo+R0pIxEdVq
         G6L3qpNF4MXaUC3UR0KMADi7lzEcItYMrTSh/SPHPSeeobxMkAWn+V58X8qYKjFnn/0b
         aWOblHDwIRNXcUZkRerNr4YyY6EpXF92AEedpI/t2y2+UgLPzB8YqUOyQ49nB77PuEH2
         Ap9ByMxHDdVNzDOCOF5Zm8sVKdY0dbdu3ANM1dRnFhFqpUZwWcs7GXJsXLhLZRgeZl0E
         SCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P3ip9Z1kPiurKcUpueirhLQ3VIip1Pisqdmbkd91afc=;
        b=saBPHrHFeQdWyDIOW7JU/okfetYYowJ9PjpWjgZTcHhTJW0Tt6vK05Neuf9+Hy0m0J
         0aafSRR/vYIbvpzqHv3HGRw2ywi6MBazv/Wv/Ak8Krzp4Gb4uNjVYCZr9MEmgdrG/dXn
         FvPHtBVLG4MT7euXqeKzvYtOT1cPUiUoQyiARQzJ3P6+MSLe1xL8ePrMik/Q635Flefk
         AJbIqPBi8DCfhlWIYn43RzQ8uSDhXHDE4qPzsWulLUTZJyBGp542y4NhYGAKvpbflJR7
         nlMLcnbnaKcTT8lpcVzqz8PgUJ5yUAw0N3SqaP8a3EpnDAa92VjAZk4tHHrL0OWKS9rD
         rbHA==
X-Gm-Message-State: APjAAAVFPqxLjE7jLhMyG1YKj0OebQHh6CaXrHzPoRpxi7TyszYAWlcU
        BgF19XzCr6zX3U4qDWUHVthMQQ==
X-Google-Smtp-Source: APXvYqyJtAweickuD27QVQKK4yt2nT2qWIP7tcilr3otZCmYGnEEhrOn36D8aMeoZt/GEuoE0dqMdg==
X-Received: by 2002:a5d:400b:: with SMTP id n11mr638415wrp.123.1557400294149;
        Thu, 09 May 2019 04:11:34 -0700 (PDT)
Received: from mai.irit.fr ([141.115.39.235])
        by smtp.gmail.com with ESMTPSA id z7sm2299778wme.26.2019.05.09.04.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:11:33 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH 06/15] clocksource/drivers/timer-milbeaut: Cleanup common register accesses
Date:   Thu,  9 May 2019 13:10:39 +0200
Message-Id: <20190509111048.11151-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509111048.11151-1-daniel.lezcano@linaro.org>
References: <7e786ba3-a664-8fd9-dd17-6a5be996a712@linaro.org>
 <20190509111048.11151-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sugaya Taichi <sugaya.taichi@socionext.com>

Aggregate common register accesses into shared functions for
maintainability.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-milbeaut.c | 62 +++++++++++++++++-----------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/clocksource/timer-milbeaut.c b/drivers/clocksource/timer-milbeaut.c
index f4780619dbaf..fa9fb4eacade 100644
--- a/drivers/clocksource/timer-milbeaut.c
+++ b/drivers/clocksource/timer-milbeaut.c
@@ -26,8 +26,8 @@
 #define MLB_TMR_TMCSR_CSL_DIV2	0
 #define MLB_TMR_DIV_CNT		2
 
-#define MLB_TMR_SRC_CH  (1)
-#define MLB_TMR_EVT_CH  (0)
+#define MLB_TMR_SRC_CH		1
+#define MLB_TMR_EVT_CH		0
 
 #define MLB_TMR_SRC_CH_OFS	(MLB_TMR_REGSZPCH * MLB_TMR_SRC_CH)
 #define MLB_TMR_EVT_CH_OFS	(MLB_TMR_REGSZPCH * MLB_TMR_EVT_CH)
@@ -43,6 +43,8 @@
 #define MLB_TMR_EVT_TMRLR2_OFS	(MLB_TMR_EVT_CH_OFS + MLB_TMR_TMRLR2_OFS)
 
 #define MLB_TIMER_RATING	500
+#define MLB_TIMER_ONESHOT	0
+#define MLB_TIMER_PERIODIC	1
 
 static irqreturn_t mlb_timer_interrupt(int irq, void *dev_id)
 {
@@ -59,38 +61,53 @@ static irqreturn_t mlb_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int mlb_set_state_periodic(struct clock_event_device *clk)
+static void mlb_evt_timer_start(struct timer_of *to, bool periodic)
 {
-	struct timer_of *to = to_timer_of(clk);
 	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
 
+	val |= MLB_TMR_TMCSR_CNTE | MLB_TMR_TMCSR_TRG | MLB_TMR_TMCSR_INTE;
+	if (periodic)
+		val |= MLB_TMR_TMCSR_RELD;
 	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+}
+
+static void mlb_evt_timer_stop(struct timer_of *to)
+{
+	u32 val = readl_relaxed(timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
 
-	writel_relaxed(to->of_clk.period, timer_of_base(to) +
-				MLB_TMR_EVT_TMRLR1_OFS);
-	val |= MLB_TMR_TMCSR_RELD | MLB_TMR_TMCSR_CNTE |
-		MLB_TMR_TMCSR_TRG | MLB_TMR_TMCSR_INTE;
+	val &= ~MLB_TMR_TMCSR_CNTE;
 	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+}
+
+static void mlb_evt_timer_register_count(struct timer_of *to, unsigned long cnt)
+{
+	writel_relaxed(cnt, timer_of_base(to) + MLB_TMR_EVT_TMRLR1_OFS);
+}
+
+static int mlb_set_state_periodic(struct clock_event_device *clk)
+{
+	struct timer_of *to = to_timer_of(clk);
+
+	mlb_evt_timer_stop(to);
+	mlb_evt_timer_register_count(to, to->of_clk.period);
+	mlb_evt_timer_start(to, MLB_TIMER_PERIODIC);
 	return 0;
 }
 
 static int mlb_set_state_oneshot(struct clock_event_device *clk)
 {
 	struct timer_of *to = to_timer_of(clk);
-	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
 
-	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
-	val |= MLB_TMR_TMCSR_CNTE | MLB_TMR_TMCSR_TRG | MLB_TMR_TMCSR_INTE;
-	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+	mlb_evt_timer_stop(to);
+	mlb_evt_timer_start(to, MLB_TIMER_ONESHOT);
 	return 0;
 }
 
 static int mlb_set_state_shutdown(struct clock_event_device *clk)
 {
 	struct timer_of *to = to_timer_of(clk);
-	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
 
-	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+	mlb_evt_timer_stop(to);
 	return 0;
 }
 
@@ -99,22 +116,21 @@ static int mlb_clkevt_next_event(unsigned long event,
 {
 	struct timer_of *to = to_timer_of(clk);
 
-	writel_relaxed(event, timer_of_base(to) + MLB_TMR_EVT_TMRLR1_OFS);
-	writel_relaxed(MLB_TMR_TMCSR_CSL_DIV2 |
-			MLB_TMR_TMCSR_CNTE | MLB_TMR_TMCSR_INTE |
-			MLB_TMR_TMCSR_TRG, timer_of_base(to) +
-			MLB_TMR_EVT_TMCSR_OFS);
+	mlb_evt_timer_stop(to);
+	mlb_evt_timer_register_count(to, event);
+	mlb_evt_timer_start(to, MLB_TIMER_ONESHOT);
 	return 0;
 }
 
 static int mlb_config_clock_source(struct timer_of *to)
 {
-	writel_relaxed(0, timer_of_base(to) + MLB_TMR_SRC_TMCSR_OFS);
-	writel_relaxed(~0, timer_of_base(to) + MLB_TMR_SRC_TMR_OFS);
+	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
+
+	writel_relaxed(val, timer_of_base(to) + MLB_TMR_SRC_TMCSR_OFS);
 	writel_relaxed(~0, timer_of_base(to) + MLB_TMR_SRC_TMRLR1_OFS);
 	writel_relaxed(~0, timer_of_base(to) + MLB_TMR_SRC_TMRLR2_OFS);
-	writel_relaxed(BIT(4) | BIT(1) | BIT(0), timer_of_base(to) +
-		MLB_TMR_SRC_TMCSR_OFS);
+	val |= MLB_TMR_TMCSR_RELD | MLB_TMR_TMCSR_CNTE | MLB_TMR_TMCSR_TRG;
+	writel_relaxed(val, timer_of_base(to) + MLB_TMR_SRC_TMCSR_OFS);
 	return 0;
 }
 
-- 
2.17.1

