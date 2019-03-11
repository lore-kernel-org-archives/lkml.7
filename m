Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499EBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A2F2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfCKS4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:56:15 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:54251 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbfCKS4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:56:08 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MyKYE-1grFzB2kc0-00yeMk; Mon, 11 Mar 2019 19:55:53 +0100
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
Subject: [PATCH 36/42] drivers: gpio: uniphier: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:15 +0100
Message-Id: <1552330521-4276-36-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Gd7zzEp1xO8auchj5+n7PPhBNUDPcj7chsxhBpBSRuzOEHXWE4o
 URkq4gPAYkhTVAoLZXHCnsXjSp3NphDuuiZHO8wXNrXP5jUkoUvQ4dUcSxjbyVAG49RGj8z
 oz47hhKVUKBOrt+nnThkwXGHusI/R6X/8nTNMCocxOCo9YGXYbd97B4OGKQu5GCa+Me3o/S
 frOetujcVSt+F1LDexWbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fshggu8wgmo=:oQh9pPPBJtdV8jRbvzOq6r
 Km+0flqOhr1ehqdYvfMYV+g3GiFKmnU1w18qqkA/6BSGAFBULtCey/FXW85OwHmqKclaW8+NZ
 RWfQcAHyz6l+fE7Z6rduBy7bR020NxUHDhSjGoGPumo3C7DYPfnLBCmmhxkKJM88Q0ADagfnO
 YesANAgvLZHElnUIQCfp7vPufQNuLRYK4qa/CSVOL0VEtrGbIIji8XOaVrTFwWzbd+yYLtnMi
 +oOFjNtnxl3V40xJOlvYCplCZ0OSBQgEOv3HSEvMcrPQAcBnrFQVLYsuuukoouVjhAfz4U/sl
 BFU6XCbO/X/HfVdairUJk7T8G9MiTohwwo11qkqkcrzv/WFjWnLc72WAFYTmz3bkNun3kajH0
 hfW/RhFs1zk/yQ/Afmdxq7ost/EKR9OrnIpO60sNPBMzLwQhLgwJkAdX9LfNCoWxOGb/utwRk
 k2JpxCGTlOBovK32KLD9xfJ495BVELZT5Bk4xmYuxiZPeBZwu1mi4zYqUh4g47bX2KcGnT2O7
 tQMj+RqepBJh/qsnTSkLKnwv0l6cj3K+T2UIUYyF75W0ee2v2rFhRBtPcyreb5rXgSZ/CRyTP
 rLLW5aqM6UOeyPUHIYDbiE/8rTxg774+lcmCncNEliAXRF0f4LJ6XGrUWCrnypbDkeaDJokE8
 q0heuqAHbmEZ7vlQXXsZY6YOIerF1HqBlmEW3+JUPauss9LXpOe/mfDYw3QJhcAu+SIF8h9UR
 3sS/4taHO+59fN4x96N8E+iXcNrnPB7aVOZCQA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-uniphier.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
index 0f662b2..93cdcc4 100644
--- a/drivers/gpio/gpio-uniphier.c
+++ b/drivers/gpio/gpio-uniphier.c
@@ -346,7 +346,6 @@ static int uniphier_gpio_probe(struct platform_device *pdev)
 	struct uniphier_gpio_priv *priv;
 	struct gpio_chip *chip;
 	struct irq_chip *irq_chip;
-	struct resource *regs;
 	unsigned int nregs;
 	u32 ngpios;
 	int ret;
@@ -370,8 +369,7 @@ static int uniphier_gpio_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->regs = devm_ioremap_resource(dev, regs);
+	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->regs))
 		return PTR_ERR(priv->regs);
 
-- 
1.9.1

