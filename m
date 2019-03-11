Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F88BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF442087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfCKTAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:00:47 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:53079 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfCKSzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:47 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MjSwu-1geUOj472o-00kze0; Mon, 11 Mar 2019 19:55:28 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com,
        orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com,
        thierry.reding@gmail.com, grygorii.strashko@ti.com,
        ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr,
        yamada.masahiro@socionext.com, jun.nie@linaro.org,
        shawnguo@kernel.org, linux-gpio@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 04/42] drivers: gpio: aspeed: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:54:43 +0100
Message-Id: <1552330521-4276-4-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:FLe3yu2Bl0wbdNdOJuuqe8+TNM+1Str3Ql1HFBkfH0UTHA3qqRR
 AzrY8RF7w4CDwUVX9oEThB85YGOG/3Zz1ft2P0QwAwHoNmUV5grJtH35Dj/cgQ89W+yJgEj
 Lm9ASyGvJSq0NNat820BP+YDvjYyneenQrOpBec+nYKrQP0MSHWjcExLJfSuUs/W8SCm7uZ
 UPnDWliyVlR952H7tZTqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/5hx0x+zooM=:Zaz4VikhmAr3NXcMxa3YKL
 woADYe1Cf1xbzl7F1Uunp1iNURs7I3swqmqSQtLRZwN0WtRPOAZXIz7w4zZev29baED2OeBdT
 DtfZua42xQBRhM1Sq89iVprrPSYrpLrPBOa496QG9cvT1hUpGBh1p40QTSohsNOsUq+lpwbtI
 wuxsPG3cqpZNT2He+kcJBECxodHD2GzBw1AtY0AUZc3U4lFhieKo1rPLZcSgXrTI/RBtmtV90
 k8MJkl4jAzmowd5ayxZLfCLv8b3VpMkm0DXLLw13PJmFKv2PeqOJlJ4CcXlZEJ0el9lKV6ccC
 gFWk9NBM0Hj7g/4faFZsvFGrxKKU4dAR5hGyIFjjveaJMf0YRSAWiHlbApdTKFG6b9IM6ktNY
 vbFZaYC4pLRoEcmFdQXAr05UxJ1F9NTlGn8UvwFcZ/dDZVDGbG/QKCfqGJSCcso+urduxJh6V
 i524lXqjbQ+nsUyC5cHQDCwcVov3nv2VaayeK9CZS3rFF1UCkntD+Pp6aikA1GK9YN20PFz82
 PzH0V3nf1t9r2CRNxw/LJniA6vwHXbQlML6O/xFrwZT26BD4KS3ZVm7UQlcHoZ0q+yYP6Ll2m
 SqQoxdqEQqxA1BJhAPys8o/rQSNi1dXu2vVj0FEbTDNrCUL2SPVrVGzS91u8vlnfG0BrlaIZu
 fZCWMhLFCpbhMzgZ7nFFFzaqo4ijOxhpDdtUeAAHvwQtAbSh/6xNAofFohjuTih2K+xV5YnJo
 GtcjT0Za7/+bCrGstECQK05eEqjlDB+qY2mHsw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-aspeed.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 854bce4..44aa843 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1156,15 +1156,13 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *gpio_id;
 	struct aspeed_gpio *gpio;
-	struct resource *res;
 	int rc, i, banks;
 
 	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
 	if (!gpio)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	gpio->base = devm_ioremap_resource(&pdev->dev, res);
+	gpio->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(gpio->base))
 		return PTR_ERR(gpio->base);
 
-- 
1.9.1

