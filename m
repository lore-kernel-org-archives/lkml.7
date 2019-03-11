Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCC3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D182087F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfCKS45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:56:57 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:55205 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbfCKS4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:56:10 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N64JK-1h17sA22Ke-016O8s; Mon, 11 Mar 2019 19:55:54 +0100
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
Subject: [PATCH 37/42] drivers: gpio: vf610: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:16 +0100
Message-Id: <1552330521-4276-37-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Ucrc1rIZnt/p8T36RAg8ZJhwLTig6Ec+rVO+L0FTiXne/Om1/65
 6b60/8QyWOqDdAfOAiDUYkHIa72Hzq9OGx1WD3DsxvdGjve85qnjdqtkhscew1ojBbKh5Qv
 iJBiGzS+Vix1eeimkxP9xPQqoJtfJx+L8d3ETxbNfw2YDI5+zuXnIkkRhCXfvUJdHkZweDC
 2O3sTGIkZMnHqPfjVE5kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vJV42iPBVX0=:Ick/bR1C4rhZKtcuiYMB2H
 vxIetXYMKfLIX+83l4yZ7IhdaSxKemJuk5EgQC/RQtrunyCCaT1AVVOoieqgdJUGRETsN+hk6
 OrnZx/tTxyjXbzXxr0xw+tLQ1Rnev6IyAChaj6nE+poxEqHsvD3PxMiZRJCxF5QXc2Ff2BvXd
 svvkwqMTwr1QHKqVdP0HOXfPfUr46+m2wBsB2+Ll7M4Wlzl85benhxKXRVb3i2Yzr4xMTOvfQ
 ZvsNNooP7O4JhS7FXrj/YgBM1LAJLO8Ws6RrLKH18XpBqOGqCK1IuSaOeIzDsBh1b+poCKCIy
 OL4Y9wowWuFEajPD7SjUt7+SDVQpyKAzNmf4LD8fDTfsevteTj3DTrDROJXeupUcK1eFVg1GD
 J7IqhsKsbilfY99v5W/l5JMoMfOF7RyH5pEh4eOGA/yu1Ii/pJQmvUUdmj+7UZ1c+ZQ1PDHYo
 l18VU7nDQP1phv43RS/yDvEDbokCqXkOzF5SEYo9ip5HgTY3R5mxjEcrJNDJG74/ZPl85L/pP
 begw4+MnO/L4X58MnhrJTzxN88rH6tpnKqL/6jOjK8R9/piucnbdTNlJ38e6332xFNU3JInMb
 /OyNpfLT9dHK3bWkdpmI9QuvPXVtBikWEzAbPB3HrVHkwlQAvdU8/gBFliTCK9zxqeEE0YRUW
 jSJBFWxra3mKbRaqYkEY8y7PIg/zhGQysq7ZqxKzl/LXEd4cvZy1vp9ZtYuT/QCkS69gfdBD/
 //m+aDWMt6jQ0m2CMVJp3E3/VU4F3ZPKOQpx3w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-vf610.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 541fa6a..4b86a2d 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -251,7 +251,6 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct vf610_gpio_port *port;
-	struct resource *iores;
 	struct gpio_chip *gc;
 	int i;
 	int ret;
@@ -261,13 +260,11 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	port->sdata = of_device_get_match_data(dev);
-	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	port->base = devm_ioremap_resource(dev, iores);
+	port->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(port->base))
 		return PTR_ERR(port->base);
 
-	iores = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	port->gpio_base = devm_ioremap_resource(dev, iores);
+	port->gpio_base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(port->gpio_base))
 		return PTR_ERR(port->gpio_base);
 
-- 
1.9.1

