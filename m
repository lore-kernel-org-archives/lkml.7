Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D17C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A00206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfCKS7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:59:33 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:46881 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbfCKSzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:52 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MXpQA-1hZMAT2LkK-00Y9Jq; Mon, 11 Mar 2019 19:55:33 +0100
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
Subject: [PATCH 11/42] drivers: gpio: ftgpio010: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:54:50 +0100
Message-Id: <1552330521-4276-11-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:IF4aRbk+3A0wj1tjs1c625xoyYIRxtMqNhxJ+UzO+XrC4X/MPKO
 pUUVJhjvTnnD1H1qlM2mU6F1MruHwUJR0nQrd/NpqvzvVpsA9LLuLY24YEIucnvYCh6wCHG
 t1pMLcd5dpXpH3bx6duS9yDil1vdlqCetD4G/kt9kSWyeZGAT+WsZWPtTe+O6u2qM2F9/6k
 1x1erEkR5MH5zwSOV4W1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jgzx7diTwuY=:Nt3ZNiDvI2PGiVH7YJcRYZ
 irUDJVJTwCqHcaSV4IylWkivz4M54Ug+qzgMeuP+MPjfYkGH5lL6Ijkmq2eVi+cTlcNfioNW/
 3vlpRcIdnVAa6UaXxk2UHpjpLY+fBtrpuWknnS208omRyL3UYK3KlVtPyyuvQtGOxd8HPPnCB
 ydvIOGOtkWoFlp/WmlnYPt39Z+wBjFf1GB7xmoCZxE+Fhn/e//fC3wdczb3LKa6KrrvhgtQ1p
 rzPpnjAUDgSVGeNJEbZGGvJSiDiW6tcZN9Pvvrr3wSKMhAtd+OM7W3FQBWEg3FFQ+AdfOSHrZ
 6NEpck99EiI7ZW5PGs8pkwvZ5bzMZQQF25UZvIy2PTX0TBvChdtKm8gxn08PISDZUtrVV3giK
 5nrlNRg46pgewJ4X/Ap+hnK4YbMyenmLZDmFAF7VDbwPf5WDG8ho+YTIzconQVQOHDrRLJEFf
 o0CG7yRYQ+UYjdEPtnj8gwxgKi9HJ2fn94ejlYTUN2leaa2I5e0qKcWqezXQ/3mKsWZwtOfY1
 FsfJEuYtK04TsShyip8he4CFfvBxx84NvhPZqldziVi8sMeLo/tksiBesb+q7TC8zEv+Z2fF5
 EMq/LDEezbxbiRzdjea+B5iczBP/lHAdcRX6OTcsKDkS178Naq5Jeh4VrlaIFEIev8Ck1aW9t
 eu2wq0AcaJ4JFbPY1ngDAHlhxpW/4uKMf5I6S6HqxsYJS6/s27mYsJipHa56yxh5XYtN9KDpJ
 d4UBAkw3fdBLEYN5OcRJ8v/IRws/zWu+a9/dTQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-ftgpio010.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-ftgpio010.c b/drivers/gpio/gpio-ftgpio010.c
index 45fe125..8ff8ce2 100644
--- a/drivers/gpio/gpio-ftgpio010.c
+++ b/drivers/gpio/gpio-ftgpio010.c
@@ -225,7 +225,6 @@ static int ftgpio_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 static int ftgpio_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct ftgpio_gpio *g;
 	int irq;
 	int ret;
@@ -236,8 +235,7 @@ static int ftgpio_gpio_probe(struct platform_device *pdev)
 
 	g->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	g->base = devm_ioremap_resource(dev, res);
+	g->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(g->base))
 		return PTR_ERR(g->base);
 
-- 
1.9.1

