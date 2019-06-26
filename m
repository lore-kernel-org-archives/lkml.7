Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5A0C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFF3205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xiqkyqpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfFZOry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:47:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55363 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfFZOrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:47:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so2401249wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DAchjLoGp53ThJdxxXYtoXfJ80Q4DYb4SAa6+caQEjY=;
        b=xiqkyqpUMCyhR970FBfcZF49AhwK/SFedKuJ5FRBVxNPZjGphDLf8ZqY5lwbop6ozN
         oY3nkTgayC/91n0TSa61b4ZfKWmnist6N8thv5t4eXM1AEpYGTyiyCdsizlz4O9VBAS+
         Hj+B1iw81OiFPzqLulhTnWzCm3f/PCMn+18KJzjQ3Y635qkmdvYgUEgG76MGg5Y7n4hS
         T0XeUfLyfUCYeVnDa9QlbkB8aoQVnDUmm+p36MizQpshTQBEQqDBozwd1wJMErJlIIba
         ozkF63/2/PzsdhCQQw0UGUPLWt51AWcYhblfhm90HgYMIcB5bv+AhXd+OMCfcE5I5UW0
         hJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DAchjLoGp53ThJdxxXYtoXfJ80Q4DYb4SAa6+caQEjY=;
        b=peKbrLP1w/VeUrrzzCqHvvNSWNwN2tV5P//GjirRGy0VRXgYyaYd/gseX3X++3UYX4
         +oeerAbC9xZQdAS+6s8KD75wascUkGPGBBFn4jO55Glmw/5YxxlZLrPM50/zmpIlFpI0
         aduZl399sTYD0zl7qUOLyaozfnLLCQdUj8ydCGV+2Ct7gf0Y2NVTt7pZriI0zZQ9n0Nk
         YcCPOr67PdrpQ+VoJXEE3Hygf+2Sl1re+Fl8UjzkuCXUqQB2I7zGQr34X9E8lNFgGSaR
         j7y8ucQDrpRBvvSQHQJHqeI5rSz6SZ3tuwXZHOmbqcFsVMqBw4Hyfzj3l7bRIjo27ZHh
         +RHA==
X-Gm-Message-State: APjAAAU0sMW6MZlzuzg/JldqI9IwXdsuX84/u61pNRz3NhTTPYeZ18BR
        Kud97MOEszWHbno/Ho9exSPx+A==
X-Google-Smtp-Source: APXvYqz6sc/3QmZZznQnarPJoaco5wIiNAyu1Ktb9fX4GSZIy5IQZ+V+MKhTTcgjM221UKbgx9UA1A==
X-Received: by 2002:a05:600c:2388:: with SMTP id m8mr2884140wma.23.1561560464072;
        Wed, 26 Jun 2019 07:47:44 -0700 (PDT)
Received: from mai.imgcgcw.net (26.92.130.77.rev.sfr.net. [77.130.92.26])
        by smtp.gmail.com with ESMTPSA id h84sm2718557wmf.43.2019.06.26.07.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 07:47:43 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH 19/25] clocksource/drivers/tegra: Drop unneeded typecasting in one place
Date:   Wed, 26 Jun 2019 16:46:45 +0200
Message-Id: <20190626144651.16742-19-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626144651.16742-1-daniel.lezcano@linaro.org>
References: <adba7d03-e9bd-9542-60bc-0f2d4874a40e@linaro.org>
 <20190626144651.16742-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

There is no need to cast void because kernel allows to do that without
a warning message from a compiler.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index 41257f89a216..f7a09d88dacb 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -83,7 +83,7 @@ static int tegra_timer_set_periodic(struct clock_event_device *evt)
 
 static irqreturn_t tegra_timer_isr(int irq, void *dev_id)
 {
-	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
+	struct clock_event_device *evt = dev_id;
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
 	writel_relaxed(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
-- 
2.17.1

