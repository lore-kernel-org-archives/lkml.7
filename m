Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59675C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35942206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfCKS5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:57:34 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:50127 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbfCKS4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:56:04 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1ML9i0-1hKXGY0APC-00IADU; Mon, 11 Mar 2019 19:55:48 +0100
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
Subject: [PATCH 29/42] drivers: gpio: sprd: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:08 +0100
Message-Id: <1552330521-4276-29-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:jIepoEF32Vhg1X68EZZoNEc5g0QVI+9VwUKDeGu6UjkyRGqYNJW
 4pEoBkT2nILhBBtzpTIFsU9kq2ep+TF/B9SxfzJ+gQ5A4RgQULbjKyy1jAeDc+mYNQxZgP7
 gU12WzBldGBXx4sXeOhZIi5ayIu7n9yW59/oALt97Hytc2il/teHCk85p+GhB9HZGp++lsa
 A12eI3GJKfl3WSnqxgkMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cq+q8ILWueQ=:Jp4DNGDx0aVThHxxX5/GZY
 5cl2aIBzvCAsnfBcgN+kS5rg8xyRjJyUjfB6+sBJw96fq5laG/KU70Q7c+5H6ydbbF1rfWd/S
 BSYc1G8Tx1cB5182Gimz+CUtjqMQf5YKnkXgSoblKc937FzojRMndHZd7YiKxTWY/GxNRm+2m
 iMypLkcSukHqlEjD5Y93tsRL4AF1yrMVlXiVlvmJTpv0m094CWy33r0sEJrI/gbmKennSsj9q
 S97V25qcuAnb/pefM9gfKWpwdfs2JbeER6hHPfkj1AdrxzqSbAQefukNNKnHFPK5AxFVUvjGo
 wKb1CxiG9DAe6XveI2vlCoVJC93vPrQjZCkG8bsEZZSx1dDxTM8UHScbKLF66GHej1ZySEw+q
 ScBA437R2wRUcdU8KK7IvlgOs3pKbmJJ2CG5GA0tWDiBkOjNEnetCjUeKu14oaF2u7I+fODZH
 +bT50qaUJzXnBKIt+U1rYc/17X0hLRSRCvqf82v2f0PssikI7m2L0cPTA6E6bsTqlQAtT483S
 3N15cDBqReKizADsFHwq0oSm/K0o2ub9Ju+iXNb/X0jt5Vtxw5IMCPmotXAFadfacPxV5XJBL
 vhqDaGJutlKYJ7xb+qEidW9lyoOb0GxYlIf43vfX2icckzbrjYcQb+n6S8lvH3jJIlt4+iplc
 NtIedg9Cfc3GaaG0vEZp7MHB4xANAFBVKIa7P4VGFVWoyE1pYLNFIwuEE8R+7P9/7BmkhCFU5
 R2DPl3B+koCuw4WjUCtuI2aYGWq3Ww4VM+XvIQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-sprd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
index 55072d2..f5c8b3a 100644
--- a/drivers/gpio/gpio-sprd.c
+++ b/drivers/gpio/gpio-sprd.c
@@ -219,7 +219,6 @@ static int sprd_gpio_probe(struct platform_device *pdev)
 {
 	struct gpio_irq_chip *irq;
 	struct sprd_gpio *sprd_gpio;
-	struct resource *res;
 	int ret;
 
 	sprd_gpio = devm_kzalloc(&pdev->dev, sizeof(*sprd_gpio), GFP_KERNEL);
@@ -232,8 +231,7 @@ static int sprd_gpio_probe(struct platform_device *pdev)
 		return sprd_gpio->irq;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sprd_gpio->base = devm_ioremap_resource(&pdev->dev, res);
+	sprd_gpio->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sprd_gpio->base))
 		return PTR_ERR(sprd_gpio->base);
 
-- 
1.9.1

