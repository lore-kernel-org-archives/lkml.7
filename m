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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF77AC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 15:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C376320726
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 15:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQz4ElsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfLOPRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 10:17:15 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37336 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfLOPRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 10:17:13 -0500
Received: by mail-pj1-f66.google.com with SMTP id ep17so1886755pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 07:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PkxNf1eXBs+SXb7siWnfIYMiYGHTBezsZMqgWgwOcf0=;
        b=iQz4ElsNqBBco2/wYm/g6BLtEQuvgbCV6D0g8dxGB3D5RiLFVMAO3ZJu5wWOscWjYM
         4748Q3oc4dnH1qGCP7M6qQ2rYC8RogvrK2kBB5O10Qoa08t4bYbUWLhJynVotaKdtMTw
         Van1lVX+jtmwKLUUmJASHuOG46rIyxqXyseugVTNCVjPcDQmXzNTxE+XP+8wvGmBzoFH
         rL/wQnAo786T3sqX4TL/IoB8ILzV1lgfZlqxMFSHtkwBVrfBllTL6nq3PjkuL/OjdR0v
         W6OPJkUUHbME2ZF92febKeDG0QzqWGD08hSiqecPZ80weyjOxff32gVqitVvaaMTS+ei
         EmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PkxNf1eXBs+SXb7siWnfIYMiYGHTBezsZMqgWgwOcf0=;
        b=rnvwpjNo5iOuqXyrpxlSWBA68wnHGpxw3F9xG1R1IWV5LYqgFI0OKkHoPmoZ2ZDG4V
         DrQPtV8uFGal2FA3hEuyvf4D/CsgOBDxuuAvV1iy+urG1rjEMgzx51ogB7VXiFuIxOfu
         DMQ0gS3nblZxGIGYUF9rhar7wkmS5zv9/ILNZpAWfDArXZHo3gsfBAQrP6gMq2vujrGw
         MeCuyJV8WhoS5B0Z3CLRDJQ1k3PNh4URMgF2z6LKOLrdC7tZxiFzt7VGyjjNv0ZxAUMu
         /QwLn2wq15P+oy0Noie1F1TW+PgLSzAQsUpyeDp+FXPsVTPE2pT3xaT8bJ2o+IiKGjwZ
         tvRQ==
X-Gm-Message-State: APjAAAWXwR/wMQ6sh4yli+adHMQ0cXob+CCexUVFq2cJ0aDf4bcTgZU9
        wKO9iQcEqZ7dyDkRWQ8WlyM=
X-Google-Smtp-Source: APXvYqx/4r9uEYKr7KyvTmpSnAIk/eMkPJcwFe7cgbHScqZLf/+nEnbN9kEExu1Wk7of+aYr6LxHkA==
X-Received: by 2002:a17:90a:fb4f:: with SMTP id iq15mr12702027pjb.86.1576423032699;
        Sun, 15 Dec 2019 07:17:12 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id 133sm18588966pfy.14.2019.12.15.07.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Dec 2019 07:17:12 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/3] clocksource: timer-ti-dm: convert to devm_platform_ioremap_resource
Date:   Sun, 15 Dec 2019 15:17:06 +0000
Message-Id: <20191215151707.31264-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191215151707.31264-1-tiny.windzz@gmail.com>
References: <20191215151707.31264-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clocksource/timer-ti-dm.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 5394d9dbdfbc..aa2ede266edf 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -780,7 +780,7 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 {
 	unsigned long flags;
 	struct omap_dm_timer *timer;
-	struct resource *mem, *irq;
+	struct resource *irq;
 	struct device *dev = &pdev->dev;
 	const struct dmtimer_platform_data *pdata;
 	int ret;
@@ -802,18 +802,12 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (unlikely(!mem)) {
-		dev_err(dev, "%s: no memory resource.\n", __func__);
-		return -ENODEV;
-	}
-
 	timer = devm_kzalloc(dev, sizeof(*timer), GFP_KERNEL);
 	if (!timer)
 		return  -ENOMEM;
 
 	timer->fclk = ERR_PTR(-ENODEV);
-	timer->io_base = devm_ioremap_resource(dev, mem);
+	timer->io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(timer->io_base))
 		return PTR_ERR(timer->io_base);
 
-- 
2.17.1

