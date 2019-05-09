Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBEDC04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F41E20644
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JseNp/50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfEILLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:11:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51125 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfEILLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:11:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id y17so1799208wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 04:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/WmgvSfXfoUbACWV/y6fHRyMAz3Q73nCkH7XU2xCVsg=;
        b=JseNp/50Kl6x0zRxnuIBNt6ZENsiT1YNUMbrHDI44juGeU4+0J+iOKLLbHuoCGaus+
         5VViG2X7dR05UBYpYMdYXdw/RqVhZyYDHGKYbS6uL/tcxJQzPTI+gb0rpe+5gmTxxroe
         4MJqt52DjlrdkeLlRFqaw9ml50vZ47f9RoeeRcnaqDB9OgJwpxM0TEeZ4a7TkexRrHZ1
         8WLO5KmaxdIm3sdVlh3Thuc6FOBveKoO7nhMvHXIaWhjNtW9mCDCoqrlie6OOJFUFzKT
         rAY2wx/WhyRovOurRqRrDuKTue2BxagZZLeEzX2xz9KLkmT52z/BH5/5t194OZzHQoui
         BYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/WmgvSfXfoUbACWV/y6fHRyMAz3Q73nCkH7XU2xCVsg=;
        b=uOxOQMoAC9/8ikAEi5uWdmCLOWJJluSWrUuyMfl2JoBGLRdcbMXCsaRXnsp20jB8bD
         PwHJHZZkgxOUHpUu/LEHKVvVVobqJXHQX+eZy0NfU/Hq4zQL3X6de0sPIAugWYIM0FMf
         Vc6avpw5/4nBA8EhnXfu7q2e+tfnEYYG3MlQ+zJ1a3VsD/Vd5vcSPhIJ7wqDXBhjo0ww
         9jbBezSBGce+D+IWJ+cIi3dHE0hmzr7iDW622TV6gZWt8clR+xQy80wFLup7kKANuCU5
         R5S2CTpxxl+tE3e8oB9YHAAA6abgUKZ9STumuwu8Su6DblVodwHPRlsSt8intdaaCu8q
         boDA==
X-Gm-Message-State: APjAAAVwrMbGkWVRNj9H8IjGN6Rzi2TV9wh9oRgwT/rtN6yMjxzFRg0+
        UycKWZ8Fx+VLMDviH0TupKQiFA==
X-Google-Smtp-Source: APXvYqxEpjOKnngpvbW6xkQT0otse7mNoyGf52Z6WWLFid+xKARMGhxkjgrzrj4TmWUI6+2h7EygHA==
X-Received: by 2002:a7b:c04b:: with SMTP id u11mr2341301wmc.95.1557400292983;
        Thu, 09 May 2019 04:11:32 -0700 (PDT)
Received: from mai.irit.fr ([141.115.39.235])
        by smtp.gmail.com with ESMTPSA id z7sm2299778wme.26.2019.05.09.04.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:11:32 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH 05/15] clocksource/drivers/timer-milbeaut: Add shutdown function
Date:   Thu,  9 May 2019 13:10:38 +0200
Message-Id: <20190509111048.11151-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509111048.11151-1-daniel.lezcano@linaro.org>
References: <7e786ba3-a664-8fd9-dd17-6a5be996a712@linaro.org>
 <20190509111048.11151-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sugaya Taichi <sugaya.taichi@socionext.com>

Add a shutdown operation to support shutdown timer.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-milbeaut.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clocksource/timer-milbeaut.c b/drivers/clocksource/timer-milbeaut.c
index 9fd5d081fac4..f4780619dbaf 100644
--- a/drivers/clocksource/timer-milbeaut.c
+++ b/drivers/clocksource/timer-milbeaut.c
@@ -85,6 +85,15 @@ static int mlb_set_state_oneshot(struct clock_event_device *clk)
 	return 0;
 }
 
+static int mlb_set_state_shutdown(struct clock_event_device *clk)
+{
+	struct timer_of *to = to_timer_of(clk);
+	u32 val = MLB_TMR_TMCSR_CSL_DIV2;
+
+	writel_relaxed(val, timer_of_base(to) + MLB_TMR_EVT_TMCSR_OFS);
+	return 0;
+}
+
 static int mlb_clkevt_next_event(unsigned long event,
 				   struct clock_event_device *clk)
 {
@@ -125,6 +134,7 @@ static struct timer_of to = {
 		.features = CLOCK_EVT_FEAT_DYNIRQ | CLOCK_EVT_FEAT_ONESHOT,
 		.set_state_oneshot = mlb_set_state_oneshot,
 		.set_state_periodic = mlb_set_state_periodic,
+		.set_state_shutdown = mlb_set_state_shutdown,
 		.set_next_event = mlb_clkevt_next_event,
 	},
 
-- 
2.17.1

