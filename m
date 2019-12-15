Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB80C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 15:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9076220726
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 15:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH+8QXaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfLOPRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 10:17:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45863 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfLOPRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 10:17:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so431787pls.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 07:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cgeux89StShXJh8dmuY3cXfyzAPtyCbzeT+l+n/I4aQ=;
        b=PH+8QXaGg1CmOrKnf9xVh5kAZvPBRL9RLTCmut99SHceJkqmHKCqPNmqPRgq3G4mSI
         VEfeg5OnAcV4mLXB4buYh+fatcEtkEm3k4TujpGpFEkUhc5gJsPBmTs7TQlEPaMsu7Ow
         Mv52uiQFopKlnQkPSYLV/yDxP6LXqjq8ZAANwTr8F9OS6LNufcUMBmSqXVrqsiluvBBA
         W5gh6IhYEHhPvwVXfKGxk6v2LDFAKPYXgzIhhOBosxVSaEgwtBcb9SRV3mlalO5032rV
         guqQJbyiEwxF9VsYcFf/efXrxPPeUoNb549lxK4xEQQq8OIsTy7M6hlTT41+PFVx8yX3
         3U0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cgeux89StShXJh8dmuY3cXfyzAPtyCbzeT+l+n/I4aQ=;
        b=Xp4UchIj8EdZNwTFZK2Xm+8jyBo9PB4yYT9z3A2gzqlooNJpD3CsgCg7TprRSA5C6e
         rdyoGjqTtJj51RXJIoPL7DA9BIYMyaoIB0QlU1dSnwUqFRtdpA7X37/Ne3qFe7lOw5QJ
         wVsaJwD41wSTtZ4lBoE/1l3tAs4j4uWz7alm11GoXdKzajilZGBQaZ2q7NPvxYm3kKdO
         qkbzzZlpcYqKQA+fg/EOCiNkxkXOXmyntHJ9HW9205zgs387j8Gxfvvp8JK3IPppJiee
         Yphc8BrksmiTDpSzXzOUxqgSU+ELVjwfPPbQyegsknkh0OyOjZ9OQCI04LsQGbEF/bGz
         hJGw==
X-Gm-Message-State: APjAAAXzTBgchTeWMsInxCgpdacJT1dma3X1dNhsr5Q3+6pyBpGOGw4v
        eTZJWLn42KMR9KXMnPIQQVs=
X-Google-Smtp-Source: APXvYqx5ivf8PH6sJbH9Il39DjWUp8XY+bfu7lJcqcxb/m1ELZ1+sZNMXMQ/aNuy03A3wHnEh8VnNA==
X-Received: by 2002:a17:902:6805:: with SMTP id h5mr10488482plk.275.1576423034523;
        Sun, 15 Dec 2019 07:17:14 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id i4sm19031621pgc.51.2019.12.15.07.17.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Dec 2019 07:17:14 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 3/3] clocksource: timer-ti-dm: switch to platform_get_irq
Date:   Sun, 15 Dec 2019 15:17:07 +0000
Message-Id: <20191215151707.31264-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191215151707.31264-1-tiny.windzz@gmail.com>
References: <20191215151707.31264-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ) is not recommended for
requesting IRQ's resources, as they can be not ready yet. Using
platform_get_irq() instead is preferred for getting IRQ even if it
was not retrieved earlier.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clocksource/timer-ti-dm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index aa2ede266edf..bd16efb2740b 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -780,7 +780,6 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 {
 	unsigned long flags;
 	struct omap_dm_timer *timer;
-	struct resource *irq;
 	struct device *dev = &pdev->dev;
 	const struct dmtimer_platform_data *pdata;
 	int ret;
@@ -796,11 +795,9 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (unlikely(!irq)) {
-		dev_err(dev, "%s: no IRQ resource.\n", __func__);
-		return -ENODEV;
-	}
+	timer->irq = platform_get_irq(pdev, 0);
+	if (timer->irq < 0)
+		return timer->irq;
 
 	timer = devm_kzalloc(dev, sizeof(*timer), GFP_KERNEL);
 	if (!timer)
@@ -830,7 +827,6 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	if (pdata)
 		timer->errata = pdata->timer_errata;
 
-	timer->irq = irq->start;
 	timer->pdev = pdev;
 
 	pm_runtime_enable(dev);
-- 
2.17.1

