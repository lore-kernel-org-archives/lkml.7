Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8178C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89602206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfCKS5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:57:36 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:33805 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfCKS4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:56:04 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N2VGj-1gvKJz3OF5-013tZZ; Mon, 11 Mar 2019 19:55:44 +0100
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
Subject: [PATCH 25/42] drivers: gpio: pxa: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:04 +0100
Message-Id: <1552330521-4276-25-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:dpXDL7pyvZOBfnJSyM3yHMQtTGOjibUjfyZJaO5v4f+pFvC2ygA
 PxKs6EF7qrHTskOsmprUrUJfO9zIcvZ7bBg0dmz/BS0vWp1afQ6W6JBA6I6tfRa9TgQrRRb
 TUFRBCz0R7f1eCZf2Q+ozn54AxO/lPiPvwkhl/F/qFTzjAtX/wJ+2pIQmPLbtp7f8+Bn9E+
 c0ad1ASELAGMdzwTskzIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3QD6+ydyXP8=:vhH6Zf71LWU0zmYJJ+3pi4
 GVA1Dyb1rXVJfkXJ9pt2EJRBUnXERfHUOV79HrtA383lIoa74JQMFAbkWHwmYHJGrNHVsKglw
 GS1ObS2TDfM4u6T0JBe2imaxESOQI0z3wzWe9Tss6UraXWWIr4JuIxXS9cpmBKCISFt8jpz/B
 cUsXDNd4PdzPiXnHD261Tefbz2kX2iQc1KruZ7FB0fTTFYElThgNNJsZGf9IgdHmGxLdjiQWQ
 d/NPR3lLW4KI8jg2PztKj7SDEu3RZxne8sm1KAyCImWdIdcXrh71rdx/3YJiMtbgRWGqRrxg+
 MHfcvVHtCTae75fmmdDF2bC5S9DjLjElkgDbfX4EwpxCqJGZ+1y70tMxzDlSbnEzRuw6Zp1Pm
 o2hQwBXGgzPnOz7+HfLjj7npMXYFoFMDtaNKXBeFy1owkNBBHsbUQB7tmBCwcLAYvjwPgKzKH
 DAF8XT3NmGZgVRlTEmjfEN+mhnjaXKtOzi7FUCY9XwaXfZXpA5rM/sX5lpnUPdjE6C/l5ScNT
 cX2V+/mfiVK+XwTzuxl20KJMeKZi6BXXJ+1AEbJNermORypmi2YHScU1OzO5eNh4GzhJoy78y
 ryctHpgajPc01igLsWk7/Cp/UMw23Lw/tkcbzPnfzZx5Qwh32G5GXG6vkQAjlytd8WWinlAGh
 Ly5L33+NMM3fEsO7GiAVWvMNGUy41+aev/fEpSRF8DS/bW8C1K/P59pjNzNTNQFZA9k0rY4D+
 5PtDS4dlmxNeoBRSQDICIzWtyCeL14lQL1Mk6A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-pxa.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index bcc6be4..dd47960 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -622,7 +622,6 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 {
 	struct pxa_gpio_chip *pchip;
 	struct pxa_gpio_bank *c;
-	struct resource *res;
 	struct clk *clk;
 	struct pxa_gpio_platform_data *info;
 	void __iomem *gpio_reg_base;
@@ -665,11 +664,8 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 
 	pchip->irq0 = irq0;
 	pchip->irq1 = irq1;
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
-	gpio_reg_base = devm_ioremap(&pdev->dev, res->start,
-				     resource_size(res));
+
+	gpio_reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (!gpio_reg_base)
 		return -EINVAL;
 
-- 
1.9.1

