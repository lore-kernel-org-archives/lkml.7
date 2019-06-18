Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F2AC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179D520B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oev9jiOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbfFROEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:04:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33237 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729496AbfFROEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:04:44 -0400
Received: by mail-lj1-f194.google.com with SMTP id h10so13281877ljg.0;
        Tue, 18 Jun 2019 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=up9rfJN2yTf53TU5ASdE2UZxjubVaBIyfo3rdkQL5fQ=;
        b=Oev9jiOTJ9iv4s5dh7zAiRV6UezxI2Nb5SFR8aeYakZe1OPEZ9UVfva2dkgwiiINnA
         KRFxHLuv/OUhHthdOgVoW7NNJcF3RDeyuYDWf+uOyfYz8Q/g706Ne+Tc2vPunJzTmv5h
         uwBblDUswVf01U0YzhR7FkAmD0+NAWjUzy/QRNWnpij+eIu3KsqlB9jTlidC9EWVvVyD
         B2cBWQ00VWd3PWGZUE+7J/gyHHUDF2enkpH+fauh8Qy0mLbobnTy6t2CYVd0IobZTHRi
         R34GHjG7VvbzXy9siVwNhmpa9LRFBukbJREl/sVSuCb+MxuMmQC2GW/y3tX0clR06a+U
         UkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=up9rfJN2yTf53TU5ASdE2UZxjubVaBIyfo3rdkQL5fQ=;
        b=XUSx5dzPxz4eNS7SigX4Nh+qK+yAWinpvbH4VJROB+y6kop5N8mOFG63ObIIpJzUyI
         8Plvv0oNHX6/vJwZ5TtESBZr/e+LVYqQeonH70nUKp86JPSNhmullM0BvjDVUphr3XtC
         eFEOC4PTFRlCS2uvbOZM0G+oWmJ0fTsGzrHFtBz7wkxIQ1DiWzpIvXPU2lzc+fTR3v9D
         4Dve0ILhb2wzMuodu4ECuifvUlM2MqE3NIA9U7U+wbidN8DEMSZOuKmlf6YTNjvRZp7m
         jbahbjR+sjE9DYiWi7dKiiTTu28qbxA7RdDbgdS0SP/i1GD3w1hvGKTIGLLcLhZ9mheE
         8OEA==
X-Gm-Message-State: APjAAAWpcLBjnUJTlyq4ztpusaHk12rjGwqqzOc/ttp1PfLazQ/SB5my
        vMqgQFzwzYGfSEj9aYc5jLQiqXgj
X-Google-Smtp-Source: APXvYqzvtcWHxdI4ySb5pNRYa8AAfy9FenvmNtDMcrDwM7AKThvvoGDKCBKPSRy7a6jvDewlTDDN/g==
X-Received: by 2002:a2e:980e:: with SMTP id a14mr53670259ljj.60.1560866682561;
        Tue, 18 Jun 2019 07:04:42 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id q6sm2650538lji.70.2019.06.18.07.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 07:04:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] clocksource/drivers/tegra: Cycles can't be 0
Date:   Tue, 18 Jun 2019 17:03:57 +0300
Message-Id: <20190618140358.13148-8-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190618140358.13148-1-digetx@gmail.com>
References: <20190618140358.13148-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra's timer uses n+1 scheme for the counter, i.e. timer will fire after
one tick if 0 is loaded. The minimum and maximum numbers of oneshot ticks
are defined by clockevents_config_and_register(min, max) invocation and
the min value is set to 1 tick. Hence "cycles" value can't ever be 0,
unless it's a bug in clocksource core.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index 2673b6e0caa8..b84324288749 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -54,9 +54,16 @@ static int tegra_timer_set_next_event(unsigned long cycles,
 {
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
-	writel_relaxed(TIMER_PTV_EN |
-		       ((cycles > 1) ? (cycles - 1) : 0), /* n+1 scheme */
-		       reg_base + TIMER_PTV);
+	/*
+	 * Tegra's timer uses n+1 scheme for the counter, i.e. timer will
+	 * fire after one tick if 0 is loaded.
+	 *
+	 * The minimum and maximum numbers of oneshot ticks are defined
+	 * by clockevents_config_and_register(1, 0x1fffffff + 1) invocation
+	 * below in the code. Hence the cycles (ticks) can't be outside of
+	 * a range supportable by hardware.
+	 */
+	writel_relaxed(TIMER_PTV_EN | (cycles - 1), reg_base + TIMER_PTV);
 
 	return 0;
 }
-- 
2.22.0

