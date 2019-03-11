Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D9FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45072087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfCKSzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:55:50 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:38883 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfCKSzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:46 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N7AEs-1h01Pz0ep2-017U4Q; Mon, 11 Mar 2019 19:55:31 +0100
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
Subject: [PATCH 08/42] drivers: gpio: dwap: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:54:47 +0100
Message-Id: <1552330521-4276-8-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:JvWddtI202isHlhHFCpFpefCyqjWNcBv7uWWKOkSKehm8Axgxcl
 8l495+5KmIKieXvt1R5JXQdZK6bSQDTzgRKSkCdHGzKh2UPoR6HAakdMHrgpYhYDile2SHr
 C0u75A2LFvd+/bEybVlWkgNkKF31eWFiYLqcX9ToCHeP3H/lRxLXkNz+Rtzon90BPmEyqCi
 JQwHCUdJiaaUiKoSz54yQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:siHUzAJZVkU=:Cb4otYxWPv2sPysrrZasOc
 CZYei4/IFo9LFgLPRBdSqhys8DuGM2owvJ+6fsKB+CIVJMzYhAplTJ3BcPkP9WFq1mBfyKHvR
 7XZ8uLsYibXIGt/jv/6YcMh7qwatmHADP1geQl1YToY4aXhKfFDfD7Vlr0GCtKPqOCcqY1z86
 81Ru7ZNbMJX8sabH0ukr62hRXo+r194lH0+U1nVFBf7eKCSb6i7c6wkntJ8hovcRkOl1vZ05L
 DuuMwRglUwBIBLNTPz9FmzPlrL20iB7FZE10jWp/WLniIR22ZRpZSDtdB0s+4IjDMTak2qfY2
 avzIl2VaFhPSrFlskQbPUQuDF58aO4RPAXE5s5uWStptnDeG0nuXeyuxhVktPRUP3gb1LwNES
 PPMRLIUJoa2Vld2fYTvVTJ23rBQaCszxnnM3J+ShIeGStDl8Q+dwfXJ8rzbCQdrfo6F/uYCr5
 rkZt3/zHe8q9z6NMoQAVuv29Sscy4THLcKUnE5Yipdnh6tAJvCi6c11JX9RuD7Oh/+bdB5pFH
 k1+1KVAeOGBLnpbv3oxjjubZju2J6xpTfAiUoLsb10mt0Zgh/KIz+kuZ8Zz4Id5MBxXpYB0wk
 +fAxlMsNYnAu+xApK64eBbB2HAQie0u8c1vfau7y0S95jgdb7mzYBBX2PPue370V6ea0jAzTw
 1F47vFmPFs5wAl+Gj69w4XFObVInafHjpiuNlVnTR6SGlj4auuNcIYybPapmrZ5Gk+eB8ISLm
 LnhRKDgGc71X7debkvERXYtkBSRWN1I8XTYOHw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-dwapb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 84ae044..d3eda65 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -655,7 +655,6 @@ static void dwapb_gpio_unregister(struct dwapb_gpio *gpio)
 static int dwapb_gpio_probe(struct platform_device *pdev)
 {
 	unsigned int i;
-	struct resource *res;
 	struct dwapb_gpio *gpio;
 	int err;
 	struct device *dev = &pdev->dev;
@@ -688,8 +687,7 @@ static int dwapb_gpio_probe(struct platform_device *pdev)
 	if (!gpio->ports)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	gpio->regs = devm_ioremap_resource(&pdev->dev, res);
+	gpio->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(gpio->regs))
 		return PTR_ERR(gpio->regs);
 
-- 
1.9.1

