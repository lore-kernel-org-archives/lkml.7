Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A237C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE272087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfCKS5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:57:06 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:41457 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbfCKS4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:56:09 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MowbA-1ghnlu09lu-00qVPs; Mon, 11 Mar 2019 19:55:52 +0100
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
Subject: [PATCH 34/42] drivers: gpio: timberdale: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:13 +0100
Message-Id: <1552330521-4276-34-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:QoZ9+Bdn0zvLNC9Ul5vk/lW9WVObrOgmx9XHGg7C6l741oHBY5l
 JpGeCdCLJSbGspSbLsmwu0klWidoukkWM0jLPacPwy3JC5j2r7qvF4yFKhMyOHTucUjvQ4P
 wSz1pEqNDZTQf4zliMzPirbz9hj1rddwpwrz++PuTx4dLfE9XsDcX7C59oJX9BTjk2kyqrQ
 qy9WCueExCKcH6yyzJDJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yr3BOJgbBdQ=:gSjSDRerZcy8sdvUDH3BGW
 GrXVTr1BDSA+MDb7pTHEwllzioDpqqe4tb5jWMyHL8zRop7oePHvMmQuQk+xBof7bNPb3b8Cd
 Ic4p1gt6RUzwHkqMOG+i3cCrIV5eDyAoFixDBOrWd9JNdBsb3OMr3UeKr7kCvhZM3VqVYPOjT
 hkUEueB/Al50cuj4UatLPc6gAzegRtB5AE0oTih0HZwW2uaG9rcBndWUDIZfHspc1c9XmNupx
 GrQZ9tBwbNHT6AWKcnO5jmTYVc7IJY3EUsRKJ7iQf/Egy0FTuxu/kiF83agAblA3ROjhB46CF
 ROY21gn8dHj3oKCRH2LW3vw2G6XHL/xcFZI1Yuc6D+LLGeO4iYWJ6NCAyVhhRdDt5m/W31NHR
 Aswdyfhy096y224/mLOawtOjTnchZIE3DnW9VaP0Lo3RFgb8wgZYqWOAbmb8Q3jJGj+5rZ19E
 Lg05IZYBD9ulS7tH6q1joXspMxt5vcptCqrPWKg8lLbLFN1vL7EPF+q5sAI31eHuu10ALST3M
 9CZxphw8bpp1owCnZO7t+vinjD4j0gbEUr4eGLacisdgjgJq6nSHrXg6jBOnMCSsfBGQ8wfFP
 9evgdZu1u2szISbFzoYgS3sQTcIvKnpj92mSiJhVoUjL933yKYHAhL3G91+PNUERzHx0/GxyB
 52lv76iojaNoONQG+Nf+YGS1RZCxNlQx9mJF1wdUaYng1J0lS3X3O44JJKju+wIc75Ddm2bDL
 LfOYSkM9SztS1GxnDR7WtjcyGVLDz03YttqKCQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-timberdale.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-timberdale.c b/drivers/gpio/gpio-timberdale.c
index 314e300..1c70e83 100644
--- a/drivers/gpio/gpio-timberdale.c
+++ b/drivers/gpio/gpio-timberdale.c
@@ -229,7 +229,6 @@ static int timbgpio_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct gpio_chip *gc;
 	struct timbgpio *tgpio;
-	struct resource *iomem;
 	struct timbgpio_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	int irq = platform_get_irq(pdev, 0);
 
@@ -246,8 +245,7 @@ static int timbgpio_probe(struct platform_device *pdev)
 
 	spin_lock_init(&tgpio->lock);
 
-	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tgpio->membase = devm_ioremap_resource(dev, iomem);
+	tgpio->membase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tgpio->membase))
 		return PTR_ERR(tgpio->membase);
 
-- 
1.9.1

