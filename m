Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B5AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460A320643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfCKS4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:56:01 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:51787 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbfCKSzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:50 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mc0Aj-1gUtTv38Mp-00dWz3; Mon, 11 Mar 2019 19:55:32 +0100
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
Subject: [PATCH 10/42] drivers: gpio: ep93xx: devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:54:49 +0100
Message-Id: <1552330521-4276-10-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:j8KA/RQH12SWfiyQaOsU0v/qysGKz1aokrGDRUNjcHYUWQXncQW
 QHQ0rKBC+qB/lirD/U0vETMbCKULs+rBGvdDCb8nw6jYZujZ8deitfBJvX2FQa+/M6b4dpc
 aLU+VoZks1bheGjJT1dWceOaN8lT+Vgu8OSDbIGRQZlhunRgkMwYqycxpsQReBvvWQ+JJVh
 Qi8cHUd/u6yvMMGER29dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6FQpd0Xlx0c=:PA7OMQRzE0jDOJvfk+liya
 0/yYVRkfV/VoTfKW7kQyCLUEKCSr+YJxqsc2FWdxLsrmSUWbNNrpPmIbk+SUao5ilS5xhCaa4
 sWwKacCh1oMBGri0wj/TeI6njNSunI0MTPmODvNjGEJfEmC9gjZxGSY9sK90iNMY6th6lTc9u
 2Uqwl8vq52lQfzKJ6XRjLSKSfsph731D35lzMcNFajb3KSwbNOFOJhf0qQyohqJQ3CaQfm9u5
 jRE0Ob4KEe6do2HQWXEKjleSZMbuRnLBUhZ2vJvwEXR9cSO1gGXdubpF2gsz/uzYSw5qJmWWe
 IrHXX2mKZYChxYbnSA6DK9YFQ9HK143dtxBQ7gWgY8POTbMmIigRWcwOj2JCJKQVQK1CYUr7Y
 000y3KB760ST3z9NUlSyc80du28OSEHyOG8RVp3+B7yJ4eWwNDMi1Vjgy4ILYKUmSFo+i0GpH
 En6hkjq/HXCxsa1KbGA/rlbBP37IQ7kcKv4JncbWrg3nDCtWtzhYml2xU7ZPv27yDQO1e0Jxy
 BxIwQoyluGPLrEYbDzgfdLy4ht2DF4vXKxqCi1kqJ83y4QgoTMYTOmoeqN7fqkughj78iEnw7
 Iu9kUXeLYjsIQfDUfbq8WyuqBpCAJwODwwBUHviggErvK8tJFjTTuNPb31grfM1MBJhwmj/va
 64aVMiYyiTi0XI3MZaSCf336yw6lhHVqhngT6ngno+uGJ/9yuDYSIUnIMM3P6X+Fbaol+jIpp
 luTKlLpulTCyxao4UKKKefS0l8XNlLcIaeEn8g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-ep93xx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index 71728d6..52e9a7b2 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -393,16 +393,13 @@ static int ep93xx_gpio_add_bank(struct gpio_chip *gc, struct device *dev,
 static int ep93xx_gpio_probe(struct platform_device *pdev)
 {
 	struct ep93xx_gpio *epg;
-	struct resource *res;
 	int i;
-	struct device *dev = &pdev->dev;
 
-	epg = devm_kzalloc(dev, sizeof(*epg), GFP_KERNEL);
+	epg = devm_kzalloc(&odev->dev, sizeof(*epg), GFP_KERNEL);
 	if (!epg)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	epg->base = devm_ioremap_resource(dev, res);
+	epg->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(epg->base))
 		return PTR_ERR(epg->base);
 
-- 
1.9.1

