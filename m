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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96745C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 08:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A4A22522
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 08:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0R5ZbYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfL2IGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 03:06:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43840 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfL2IGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 03:06:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id p27so13495811pli.10;
        Sun, 29 Dec 2019 00:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kZ3gmHLUn932Pv1n9lSS5iGXVKswSoxR5qJ685cV264=;
        b=m0R5ZbYCE1rG+sD3REAsSdJJL8DRTOORWN1u8isuPUFHT6tlqKeKggD5nojJvcFeBW
         1Qu/2GPoQHU+fY4k0k2Gk+9/uiPU+ftFNHS1jdmTSeWon3aGBQMOw97pxWDhx2JGl6oL
         cGd39h70HMWU76jCNBM15zRMxSjk3FQM93x7tBOe2+aehplSX/we2SB60+idhNEfSU6F
         bl7rDhk8OkNWeYnMwtw2nY6ektkLJzpUCXjLIBOwHJNN8SeSKjTZ/3ATuYPNrnc2Bqdd
         nLfTfEo+A2FeL+QicRgv/WBt8JOVlBSGVNNlRj7dBSK4ZMXkpUleuxvWigumpFjy3Eu6
         5knA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kZ3gmHLUn932Pv1n9lSS5iGXVKswSoxR5qJ685cV264=;
        b=Ti5j8c87Zn0KbQVi6iuChwLG7b7hXVH+y6mzybim7AdU2sNT0Re2N/C3TmjdYf1EXQ
         FOLRqOImL++RJ2V0XuKLTHt1Kqh85RMr0LvV/PcxFL7EnAW0LpXf7ObodoPGoNaE/WXo
         L+Y7RG7NdUm9lddTvHeTxGc9we8EkHdYXhbN33BlPC+M682ONUejqlhx9wmqyn5k6d6L
         YC8cYG9klx3wuCLA8pHLLtDZKIj1kizpXFoxvu6yM/Qdn3uZrwGkUsqg+xdAyeN1oB6r
         6OplfFl2TvtpbSkYS6dM3V5bo/r85fQ2u7qrxIQXye4lI6CG/I0n5dN4T3WjHc7RGDcx
         z9jA==
X-Gm-Message-State: APjAAAUQXCYRhELXypIZSyFGEzxFWsWpiaib2ZP/WAH44R5rHsi3XiBa
        vRv7wsqpB77P8MF7XoUJ9jc=
X-Google-Smtp-Source: APXvYqwa7GnQSwppTBhuTNZ+erZiDBVrdnZa+AqBJPOHWUFyiar+lBUxG2VdqlQ3rau3CwmRIvIfQQ==
X-Received: by 2002:a17:90a:f314:: with SMTP id ca20mr36411362pjb.112.1577606794577;
        Sun, 29 Dec 2019 00:06:34 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id c18sm22189390pfr.40.2019.12.29.00.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:34 -0800 (PST)
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
Subject: [PATCH 17/32] pwm: samsung: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:55 +0000
Message-Id: <20191229080610.7597-17-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-samsung.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 87a886f7dc2f..645d0066ff0a 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -510,7 +510,6 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct samsung_pwm_chip *chip;
-	struct resource *res;
 	unsigned int chan;
 	int ret;
 
@@ -541,8 +540,7 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 							sizeof(chip->variant));
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	chip->base = devm_ioremap_resource(&pdev->dev, res);
+	chip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(chip->base))
 		return PTR_ERR(chip->base);
 
-- 
2.17.1

