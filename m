Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55431C2D0C6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 08:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F0C22522
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 08:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRiIae4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfL2IGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 03:06:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37598 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfL2IGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 03:06:41 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so16624877pga.4;
        Sun, 29 Dec 2019 00:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QqO5VBiXqI5R/AkeosruSZfCprSjGDAM7LFQWexsUTE=;
        b=bRiIae4rFd4anfrYHa2h573t4PCyijpCdCIzqXN4J00te79dFDRkflXiaVWf9P/axv
         z+DsmrszTYuySWTdB6ULOta5nuNYsyR3uMXjYa/TrpX20GJDeDxZV9D6gFgpC5aB9jED
         elc3AbtukjTYhep55znmAuIrGhh5OuVF090UIpJaVxMb13YlyHeqcOpePr0Qxa5AGotr
         4mF1TMGUApsiYzXwC/OaIiKBB1yekSF9awgj4zKaIbT+7CGKAl7wqGu+s0RL+WlyRNlU
         bWuTj6WuXh846VITN/gmh9GRqv1SUvbd9Svau0W5uLjTjE4taI9XKDEZRS0H9L/nSooN
         ZLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QqO5VBiXqI5R/AkeosruSZfCprSjGDAM7LFQWexsUTE=;
        b=ZHNqiQzlCEFEfa3NpV8UFVMWdrjNSM5yeRfRRbesUXBkOkzqEhMwM6JVOcUiNidG47
         42TcFF1uVlxeHODFjkB7o84XCReIieBuQv7XC39tdZUNvtQRho968HuUR8Oxss9y+iZc
         kLoy2ZYRdmAHjxnXSQ+NoIEab/OjFaq074/on6Cba4yXqCtHBihQDnGZmuIVwZW7guwj
         ItrG4mK+kBWKF8Gu44fEL/RHMTHTKp1eVFw3ysefX/lvlpsi84NY35WQVY/a2Mg5IteE
         DPXBQoA/b7PqLx0VehUZB6aC6IvsBd4szX1O9I1dntW57Nzq33Sd6bHWbAFVHROF02rS
         ZMwA==
X-Gm-Message-State: APjAAAWPxTag/wGf+bC0Ju+z3SSaMKP+O0yWzO4mN32+PzcDfZ+hPx1E
        pe782oyY7aojXE6uHRQ8CKE=
X-Google-Smtp-Source: APXvYqwFZI+a++Hr3wqoZg0IjafXaKUi175/ltviuoWC/h18dtap63vpF4U0J7a3SLRMilBNfyFKcg==
X-Received: by 2002:a65:5a8f:: with SMTP id c15mr56634028pgt.259.1577606800818;
        Sun, 29 Dec 2019 00:06:40 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id z6sm32913761pfa.155.2019.12.29.00.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:40 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     claudiu.beznea@microchip.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        nsaenzjulienne@suse.de, shc_work@mail.ru, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, vz@mleia.com, slemieux.tyco@gmail.com,
        khilman@baylibre.com, matthias.bgg@gmail.com, heiko@sntech.de,
        palmer@dabbelt.com, paul.walmsley@sifive.com, mripard@kernel.org,
        wens@csie.org, jonathanh@nvidia.com, linux@prisktech.co.nz,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 22/32] pwm: bcm2835: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:06:00 +0000
Message-Id: <20191229080610.7597-22-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191229080610.7597-1-tiny.windzz@gmail.com>
References: <20191229080610.7597-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/pwm/pwm-bcm2835.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 91e24f01b54e..9923cd2f069e 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -137,7 +137,6 @@ static const struct pwm_ops bcm2835_pwm_ops = {
 static int bcm2835_pwm_probe(struct platform_device *pdev)
 {
 	struct bcm2835_pwm *pc;
-	struct resource *res;
 	int ret;
 
 	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
@@ -146,8 +145,7 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 
 	pc->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pc->base = devm_ioremap_resource(&pdev->dev, res);
+	pc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->base))
 		return PTR_ERR(pc->base);
 
-- 
2.17.1

