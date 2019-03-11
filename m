Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3065FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC8320643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfCKSz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:55:58 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56969 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbfCKSzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:46 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MI4cT-1hFDeP1WmV-00FFvN; Mon, 11 Mar 2019 19:55:30 +0100
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
Subject: [PATCH 07/42] drivers: gpio: clps711x: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:54:46 +0100
Message-Id: <1552330521-4276-7-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:/RF4+Rqgwp3EesiMym7nA5aKa7MbwCv2FVWOK5zXCDf4K1LG8S1
 Oc4U2uxxjfsgBLRUedR1evw1MShNKZOCv3vTACVu1PAZH1LDP23rFRXTkUR7qU+CSHtro2j
 t+DR9CHLHmdCMlMuZD6cj+uwpXWap3heuqju3RFq6fKgIuETYlwgQdmlYgJ/+rT3sj5+IhR
 D+JcPNjBYP4CKwa3gdlNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3fLAYJCxLzo=:zkKas7Ex3kcKsSg48vlMcC
 9Uj0T4jp1tnk7NG2974/HskwKeD82TyUF89bHFBHtVYuLVrN5iEiCdcEHh/xh3cJATKRQFb/5
 6gxGsQBaNcXKbM4y/Xgyd6Ug5q8MbqOh8K/Kjohfrps/gDoXTfNedfM/2SQbziHiWiwPoenk/
 drzgWHLjxXVRwve0W6Ka2ClFBUp0weLzZuL6PdQTifkjxMyj3gvp9h7VDgjkSECC4FiZu4J07
 WjXX28F4EIsXC/7dyaVJkt/he3UFTgOtQ7LmsNcxrI77ExVnmio0w9CK8nsJQ3u4XOxLba6kC
 VXSRdda0T5fat18VnoEJgLo2aPb94YckNYHpASB+w6OW8ZtHV2yWaE0XfPBzyYuwK5+gBbGIC
 6tkHijCKQJKt9+BhBWHKaukNH4bAmIZPCNzXcCIcIGhjfozIs1t4+hDKjRMVwbzyA1XZauRI/
 EwXVUTaAFUuWAusMacBQ65GiphgGhpPSwGfoS3X+mftw2Jt3Yf7I6KrXa9lB4J2kUnIP/ats8
 Aqgu+GA1Zuu9CikQ9HWbw3CDZ7KBiKL1rD4yjcMqomv6fL6en02CXyrTByz+CXQtTINHVXgZz
 V9nb3F1otONzOUEpJXISQlc/c5KLuPAAt11CfWx0U7Ik1H3q/lG8ZHdSCx6Ig+5BbbRaCoLR8
 9wE+SSGLXjZlKhhAl/0L2hLOy4uXN1VP2cU6mzbvPrB44vgNvShqNLmFJPWir7pioFwTprO4Q
 Uipi8g4y/oO7IOsj3ECw22JjuKyntRRFgAd6CQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-clps711x.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-clps711x.c b/drivers/gpio/gpio-clps711x.c
index 52fd63f..0fbbb0e 100644
--- a/drivers/gpio/gpio-clps711x.c
+++ b/drivers/gpio/gpio-clps711x.c
@@ -19,7 +19,6 @@ static int clps711x_gpio_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	void __iomem *dat, *dir;
 	struct gpio_chip *gc;
-	struct resource *res;
 	int err, id;
 
 	if (!np)
@@ -33,13 +32,11 @@ static int clps711x_gpio_probe(struct platform_device *pdev)
 	if (!gc)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dat = devm_ioremap_resource(&pdev->dev, res);
+	dat = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dat))
 		return PTR_ERR(dat);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	dir = devm_ioremap_resource(&pdev->dev, res);
+	dir = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(dir))
 		return PTR_ERR(dir);
 
-- 
1.9.1

