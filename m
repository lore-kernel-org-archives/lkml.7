Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5C1C2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 17:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6022F2070C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 17:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTWS5PgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfLURav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 12:30:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33328 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfLURat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 12:30:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id c13so5476585pls.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 09:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cgeux89StShXJh8dmuY3cXfyzAPtyCbzeT+l+n/I4aQ=;
        b=TTWS5PgWFz+PR/jqvWd30aA91+6/RUItnO7I36bamDyvrnxRom5eyCAERuzSUGWl5Y
         e3wLAPEid0qyD/0x3GmwttPz/r4c0tRKGKJ5yZ28qTSZcO5Ns0i9aKOm6oHvLkZ4O9l3
         4HhH0h2BUxeBEiomjXOC/Yjwxm89j/W9MkBKDJuA90iJpFM9FblzEA0JolA+JoJolG/+
         1ANjk6t4KwAApYBOdVO+dVY3hC6cRKd+hfCCSqxaqBTwEVHgYcPGOGSecPV7WEZiFZ+Q
         kzC1FkvDOnHpj+7bfP1+fyU9zDevurGbl9G9AdyNeUBWnEfDeM0ooVfLJiN9BLHfy4rM
         rABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cgeux89StShXJh8dmuY3cXfyzAPtyCbzeT+l+n/I4aQ=;
        b=Xwtz2nPWBt2hduQbym7jfpuLw+kuW+/iXvFLGoLjH/DD5itnTnS77xIl8qgRlDxEnF
         KLpExmcCEbZNdyWiZ0M9cVDpI5dumnSo2UMcGWGE7NqbgsuAs6eyLeK5h5hrhvmxdtzG
         aBUMthkOUSTGebRz8hAptioDTqF/w8ThLZz7MKXBZKRV4CdI1dFIFBM6JMCQXBcjGHQW
         btraCV+BZ9v0HcqPE8ti/k0J6RcBxE2YAn7bjtE95nUJtGUSr7TyjKb8RLBWO0WJ07dU
         iHGg/r1RtaQiz0NNYWLqU+0gTIUtddtaJiud65GMLElKtGcPp90TV+3L0iEUWj/4XCQG
         PYlQ==
X-Gm-Message-State: APjAAAUZWc+4hol1ykaqLdjSSQSx4Ts7+jtkJNWKxOYAGJ9wqUOdW/TY
        g4b4q9uQcLsUgeGhjFNOS0M=
X-Google-Smtp-Source: APXvYqxuhzrJMSqw1xMDQGwUP/cDADBElC6f8elJ3Fi4fKrA0aI43w4AaDSjxdKUBMinGo0uD/aSVQ==
X-Received: by 2002:a17:902:6b06:: with SMTP id o6mr1229722plk.138.1576949448397;
        Sat, 21 Dec 2019 09:30:48 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id r28sm15698211pgk.39.2019.12.21.09.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Dec 2019 09:30:48 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2 4/4] clocksource: timer-ti-dm: switch to platform_get_irq
Date:   Sat, 21 Dec 2019 17:30:27 +0000
Message-Id: <20191221173027.30716-5-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191221173027.30716-1-tiny.windzz@gmail.com>
References: <20191221173027.30716-1-tiny.windzz@gmail.com>
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

