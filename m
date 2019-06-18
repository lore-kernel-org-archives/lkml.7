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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDF3C46477
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68522214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u73BmwL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfFROFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:05:08 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46994 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbfFROEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:04:40 -0400
Received: by mail-lf1-f67.google.com with SMTP id z15so9354290lfh.13;
        Tue, 18 Jun 2019 07:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5sDx0TIkIdgU++tFYOdzDBd1TkEZ4EvtendbdVPaP5I=;
        b=u73BmwL+yUCKRQVATtRS0baorED7GOtey9tCPMU6dZouIB8hVA/pD6WTJOaTwmZ20W
         jwLiQJzU3nTFDvKB53i7a22JaBK9mWpC6tXLY4AIkwg7Cs144yBoMzHvJJB4SDoJdxgE
         7EaekPQFikicPtV0SzLJc4zRUATVJ6KEhvRH53/cgECUPOjcxmJtUJ0FeDy1S5V8RQXO
         Gn1KxSY2ByrSLCQ2bSXi4271HL6LBg41PXtprxJw993pfk+nqIh0B1NrVI2kShI8sEM0
         CJCHN2lD3/HTZL2l0Fv9v6j5NsSIcz7t8u22SJZ31VKSSrws6xJS/vI0i5HdXE6AzboI
         Jl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5sDx0TIkIdgU++tFYOdzDBd1TkEZ4EvtendbdVPaP5I=;
        b=SgvEcjvmMH8QKb0ru/to4v3rM0SqDPlm2ClGp/f5XHd5kLIXjPz3N7FP4XzI4pSqGN
         rcGwJsQsHla1EyV3U0LtQTc5KXuoaApv87k+pwzA2zulInclfIJxppI9xrgf7zDV8M/c
         oFNBL50Q88+5UtnJ3giF7NFF3yblFnMg7MjR6bXS2UCatMlkW3XWSSdKpzCCOcqcdI0o
         T6IOh4rnE1J7CebyTAY5B2cJklitAA8CJJFvPNvaddySnMEnSWgdqSsL6gSta+h7g4Ac
         8pwSfGrhBIpRcWUr+kBkk5cJONinXmTuF2Br6jM7y1mGgMNLeTpuur7stGfHK28r3QrH
         8wGw==
X-Gm-Message-State: APjAAAWJaX4j5PV/1S3c98LgzzR0+SVaNVudjtHu5jFIb79gO/D+MGAz
        wTaq2yi1Cn9gJedO8/mriL6RVGJo
X-Google-Smtp-Source: APXvYqx6BOKM1JAtSIUSdX0uTODX3quVH0Dn332OewG+w7hTe67Tufum+pgUTKfqL6kcAZ1jaqf5nQ==
X-Received: by 2002:ac2:41d3:: with SMTP id d19mr30401737lfi.127.1560866678578;
        Tue, 18 Jun 2019 07:04:38 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id q6sm2650538lji.70.2019.06.18.07.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 07:04:38 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/8] clocksource/drivers/tegra: Set and use timer's period
Date:   Tue, 18 Jun 2019 17:03:53 +0300
Message-Id: <20190618140358.13148-4-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190618140358.13148-1-digetx@gmail.com>
References: <20190618140358.13148-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_clk structure has a period field that is set up initially by
timer_of_clk_init(), that period value need to be adjusted for a case of
TIMER1-9 that are running at a fixed rate that doesn't match the clock's
rate. Note that the period value is currently used only by some of the
clocksource drivers internally and hence this is just a minor cleanup
change that doesn't fix anything.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index ff5a4ccb5d52..e6221e070499 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -71,9 +71,9 @@ static int tegra_timer_shutdown(struct clock_event_device *evt)
 static int tegra_timer_set_periodic(struct clock_event_device *evt)
 {
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
+	unsigned long period = timer_of_period(to_timer_of(evt));
 
-	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER |
-		       ((timer_of_rate(to_timer_of(evt)) / HZ) - 1),
+	writel_relaxed(TIMER_PTV_EN | TIMER_PTV_PER | (period - 1),
 		       reg_base + TIMER_PTV);
 
 	return 0;
@@ -297,6 +297,7 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
 		cpu_to->clkevt.rating = rating;
 		cpu_to->clkevt.cpumask = cpumask_of(cpu);
 		cpu_to->of_base.base = timer_reg_base + base;
+		cpu_to->of_clk.period = rate / HZ;
 		cpu_to->of_clk.rate = rate;
 
 		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
-- 
2.22.0

