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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF44C2D0C6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 08:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D7220718
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 08:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG6H1yvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfL2IGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 03:06:16 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36590 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfL2IGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 03:06:15 -0500
Received: by mail-pj1-f68.google.com with SMTP id n59so6887702pjb.1;
        Sun, 29 Dec 2019 00:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+3pBLd50yZ31QGDnQXQDHmLfpHXmqi0l43iIkO1V9Fk=;
        b=JG6H1yvXtza6zd1BLy2dsQbEIHwG3IcGFnYTmJb+HGx740diEoe5JAn+t24q8VoSuV
         5fbcviVM5CcY0TyjCuQXa6qCbooh7tfB+LrHt3/Ug6YFtCT5k5V2gwou5opqsGC6PwHc
         eurPwx50PDqmxEW1q+ynKJ0KnCQeyzQX7xW2SvY2itaOb+xiBEMYtX6IObjqWLKo9teF
         Q8zj04fwbhQU/UpdXgs6LRdOgn+M5RnZG84uXVM3HPgc9uiEjx0BMuG3GLmG4PD1Qm+A
         hyzMraA1AY+YuWSnreOvwjqLS2dumP9P/mjJBIQS5Ru3J260j9Ci2chSfkQQqO0ydswt
         R3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+3pBLd50yZ31QGDnQXQDHmLfpHXmqi0l43iIkO1V9Fk=;
        b=ly7J9Yy2bNPWqKIg0Jyz2rL8r3bZPycVEZrqQ1GVqjcn9lcw4T2arN1FxrzwjNxi5K
         2M4aKXU7jQlVRkyebKB0wxglbomydqcwYmPPIf4Yc/d4v2hze5asTrOrg/ymVeRHWGy2
         /OtJ9Z6ruI7BEjoMx/nH162RT5cVmws4AP/PveUpajKt4GpDaZztLj6Gp4MpywDsd9Fm
         bBWRctHdTilyN1o84yTbhAMsdw/y+Z5FVNlgBaiRbWKbE+06T/XmavMf38EQKTNmLIN8
         ejJznT8V8Sy7vSRFaki6Ee72bd8Nyx9IAKbzqyvEwyi2mi2g8797oIZzb+Nx1obNdFmC
         U6vA==
X-Gm-Message-State: APjAAAVHxMxzajGZmECzd054BsIS93/E9cpX8FmwVo6G4ZZjWw41USKC
        mp1JWRjpBkKU8DsbofbBJgQ=
X-Google-Smtp-Source: APXvYqxnI5XBWy+NXM/GB41OB70ppiFg3j0a/LZfYu0PTXzqYRRbkm4zUSrtO9fzojgrIm7DOwlwvw==
X-Received: by 2002:a17:902:7296:: with SMTP id d22mr64069643pll.55.1577606774630;
        Sun, 29 Dec 2019 00:06:14 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id f127sm48271863pfa.112.2019.12.29.00.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:13 -0800 (PST)
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
Subject: [PATCH 01/32] pwm: sun4i: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:39 +0000
Message-Id: <20191229080610.7597-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 581d23287333..f2afd312f77c 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -344,7 +344,6 @@ MODULE_DEVICE_TABLE(of, sun4i_pwm_dt_ids);
 static int sun4i_pwm_probe(struct platform_device *pdev)
 {
 	struct sun4i_pwm_chip *pwm;
-	struct resource *res;
 	int ret;
 
 	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
@@ -355,8 +354,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	if (!pwm->data)
 		return -ENODEV;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pwm->base = devm_ioremap_resource(&pdev->dev, res);
+	pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pwm->base))
 		return PTR_ERR(pwm->base);
 
-- 
2.17.1

