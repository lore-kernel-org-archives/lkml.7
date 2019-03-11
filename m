Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EFCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743312147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfCKS4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:56:18 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:45311 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbfCKS4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:56:10 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MwPfX-1gkvGg17Vl-00sJmV; Mon, 11 Mar 2019 19:55:55 +0100
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
Subject: [PATCH 38/42] drivers: gpio: vr41xx: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:17 +0100
Message-Id: <1552330521-4276-38-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:DG9xd4w78nDQtbs+l6FzqbTkshUULjHcBsVfKq75l3XSAowmCl+
 mlQm2OMp6vMjShMW8FxGRsgmxlLNV7YSgyk1K4+wcebz0/HyHdvHozvBVUmtDEVtRXatibE
 hosJNNS7B7UX7yj2wTj9tiNiD/xvwy/3vML5YI97UWgbC+1RJC7BoODvlzXbJIVsSQyQIAF
 TlzDfi9382kNnR86rltrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8GOfLAp7os4=:xeOyugLL9fjRyb0RFGDg08
 z9uQ4GJpPS0Gzna8vF6guAw2cSOABaUVtU58nOSrUYO5ePmxpIwr33q9R2mC/GMz13myq/NN0
 x0HbfF4BPBEGLt7teEnM2stEFSAkbg4bodThzGzdhxaDz2czVn5HTk97na7h4pfQQts78gIQQ
 yztIzxGaJQZd+JzlYuLE9vmGln/FkxDKF+a83AtgPDxCJdVe5eJY7Tnsw8O8oYXy6F/kI/F5H
 4ecocinAQPy89zHqRoLYSgCS1cTdBHWcysKr8VBmSaR8diXHn+JaSK75G4W7v+Ot2NDkJfiiM
 Gewqid4AFzYfgTS4jJleaAwkALRvSxQIsBGmthrcADX/BFFFz6vWB4tLH7/nS+yLCXzy62z61
 1aHuWpr8sD9pQRZW42xbg0P2oGY5f2BM9MUXEkR3Z9FRmV/lH0BI0lY8Z7bS1O/0mrSLyC+ev
 h7XN8tP6f8UnlzzXzKX0YNKvJ4fSMvdp02zRrt/+vNQCPyilE9mQ9IkFtucXcq0GT5DlBiqz5
 3+FLK9JBu74ZKwlZxSbRZCCxo1TDAljXPgMdXZ5KDilfTMisc+8Fm5XrUaQfwoKuUQJZRzAIc
 Fr5TBkeCZNpNEGDHCpM8rR0npUmgEq6cRVoGRrEF5c/+Bh/Z+yrMXv24yIKE0z0QkRbrIsKS8
 r4mRKcSBE7jJPQQuS6j1P9S9cRzRBRE21ZZJx56b18HvjSn3Lok7e/Ct7JxXZKBrrKnACoHsG
 Lbf9WyItsbUT/3fnRHk6M04G8633ADFg7fK9lQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

this driver deserves a bit more cleanup, to get rid of the global
variable giu_base, which makes it single-instance-only.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-vr41xx.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-vr41xx.c b/drivers/gpio/gpio-vr41xx.c
index b13a49c..98cd715 100644
--- a/drivers/gpio/gpio-vr41xx.c
+++ b/drivers/gpio/gpio-vr41xx.c
@@ -467,10 +467,9 @@ static int vr41xx_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 
 static int giu_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	unsigned int trigger, i, pin;
 	struct irq_chip *chip;
-	int irq, ret;
+	int irq;
 
 	switch (pdev->id) {
 	case GPIO_50PINS_PULLUPDOWN:
@@ -489,21 +488,14 @@ static int giu_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EBUSY;
-
-	giu_base = ioremap(res->start, resource_size(res));
-	if (!giu_base)
-		return -ENOMEM;
+	giu_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(giu_base))
+		return PTR_ERR(giu_base);
 
 	vr41xx_gpio_chip.parent = &pdev->dev;
 
-	ret = gpiochip_add_data(&vr41xx_gpio_chip, NULL);
-	if (!ret) {
-		iounmap(giu_base);
+	if (gpiochip_add_data(&vr41xx_gpio_chip, NULL))
 		return -ENODEV;
-	}
 
 	giu_write(GIUINTENL, 0);
 	giu_write(GIUINTENH, 0);
@@ -534,7 +526,6 @@ static int giu_probe(struct platform_device *pdev)
 static int giu_remove(struct platform_device *pdev)
 {
 	if (giu_base) {
-		iounmap(giu_base);
 		giu_base = NULL;
 	}
 
-- 
1.9.1

