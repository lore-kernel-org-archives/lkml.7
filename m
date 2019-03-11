Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C0AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4BC20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfCKS6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:58:13 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:38471 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbfCKS4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:56:00 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MFL4B-1hJ4Cc40M5-00Fncd; Mon, 11 Mar 2019 19:55:44 +0100
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
Subject: [PATCH 24/42] drivers: gpio: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:03 +0100
Message-Id: <1552330521-4276-24-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:TVkl97ouCD1e5W7IZWyHVMepLQL2TZ4C+8hLq+3idw90AiUAKM2
 tCZJoP9CKGTBTfKhxhLwv+TDiM1dyuv75r1wztoytt+8A+QNzNWhGHNPGo2qLUOSQlLKLS7
 lwF/1P5ig5yLjKTK11Y5O8A70hDUS9MHRMDehzxgP8Qu3PepO8VQgfLhcjYCwqo27GSHBon
 r+Smrm1XTcPNDhhA0i3Vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mj9DAC+H0kk=:jHdAin9PqtChtVxyUsoP0M
 FQFayoY01LhYyBt7O4PCgLkcF9FLgGZ5WVPGQIEfki6Sc/pb46ysCPLtB4hkzjrZ/T8cBr5Wp
 mT0fLCaUnae21M/KZzHyi6ier2TyNg3/vkk4nAScZ2S2Nsn4n6svpV4KNO10cvg+7Tnu5Fy7K
 pjnYf6oW/rNjE8Jp4nPxCA3baPEsFcxZzKaqbwe2XxIy2W43+/Q5P5FXK7wMMtKGGyEQ18hiV
 Sj5EdKnNTN+IXVymx7h6ACq3vI7VQQJIPXiRt7udPxb3YTDbzZH1kJBwbD+55qlfgbSBzIL1t
 Lm/0YXszzHXMovE8Ua1d9odQVYfRXDoPovLKdcruTsTAe9HzmjIWhJgpPXEH7uSNuDe2a+lNE
 f2L6tqW4ocHf8pylSTl6zCbZ+Wtl8dcE6UdY/NMfs0aMIi9CXEoE3sXi+hcRUlh8ZhelXIhgG
 ulCRRNEEHzGS5iHFSDLz/iRbDo5FMAk/RQ6QLGyQA7mwqCLtsHGa+4kAihu+BscMT8wELgEYp
 Mta2PaXKFlovRJcg4zZnkZPj5QfdN4I9u4eNfDyJOa1a6eFCGDOWwyuMqPLr0Zlo1Z18jTU1M
 I/lygBTtfVL/qbiR9F7tW8wxoCSLYA+/42dp/Ys6Y7ENH6xoVn1u/wHm9CAclE+kpQbE4o3LK
 p9qCxpSudFfVZwUueM5wIzYAU5VZ+C1gWkXsQAtb+N+sQUErAcCPYsf0aKEILxhQBti+hrf3O
 Kas7bCGW6oBIOAHB3xHTsQbZbbbyWzsuLGiXzg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-omap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 7f33024..ce6e67a 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1289,7 +1289,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node;
 	const struct of_device_id *match;
 	const struct omap_gpio_platform_data *pdata;
-	struct resource *res;
 	struct gpio_bank *bank;
 	struct irq_chip *irqc;
 	int ret;
@@ -1375,8 +1374,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	raw_spin_lock_init(&bank->wa_lock);
 
 	/* Static mapping, never released */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	bank->base = devm_ioremap_resource(dev, res);
+	bank->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bank->base)) {
 		return PTR_ERR(bank->base);
 	}
-- 
1.9.1

