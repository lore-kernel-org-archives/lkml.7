Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499DEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2845120643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfCKS6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:58:14 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:36483 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbfCKS4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:56:00 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MXYAj-1hZ4uu0g3T-00YyfJ; Mon, 11 Mar 2019 19:55:43 +0100
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
Subject: [PATCH 23/42] drivers: gpio: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:02 +0100
Message-Id: <1552330521-4276-23-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:FaTYPPPBKVwpl1KxMJTWoMfkz00Phi7ejKbzHEvqNYo5P4wpdaw
 vf1/WxhAn89NlVXGVQ2qO8EyFFHCoZ5rg41A3mMl/hztqbDBsj3wZanpH1gj13hzifAKnkH
 B0j2znYEk340nJ8EnORDyWlBIOfrAzB1yoCpBgD8Ca4b0q/j3819ofGzG7EDqtofZz1V/OH
 3b4Gdxycxg/AMXKHz/iNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CSXdmVgOZuc=:BVJFBTRbrZG1F26vArh1no
 oief7n8RLS435IaI8xZBw474Y5dVjF40SzIwFYmH/IHFibfdfNCd5g1pxtWGq2D3CXEZWJHHc
 /Mew0hzvrSBQu3q8OUjSStoXX2MxvehwbD/MN+ME6YhqX4EFJxPqWMyt+jsd2pa9K6U8Rw5Nr
 D5LKiooBR1stVgARnsXSOO4HjY+mYpgu1BGcWcJJXiqheuUsFBkhEJg8BcmnLik9gEJrJS6qQ
 K+MBJ3IuBoVv3Q+CYdBG0J5/vWkjUmzpYMeFAtE/iN2Y8FNClufqnOOGLRvm1ajXBZAIwjZs9
 lGLWX6NPFzJhw0kmsxx0HsU9iaRpRTctMjKu8pa0iIHIcTHH8OusF72KKxaqFy4lRs0+7cFyj
 MhWvd/vUDu8ko0od8sPan9pzj6gLDtQeBCMNq2zeL/YBzu6iydyU2gizxR3Nqsv2jcri3reUd
 MSMfIG54k7/BzEJ4PEsilhYV5vvqrEl4ErDB9tbc5iMizuxDYJrJig2Jv9b8FU5y7zZUxjV3X
 kx8ji9j49+bDFK1aEA7kBLt4kMAV4nT77Wj3mL8dmnX8PJl3gnxfieCfzJwaTlVjR+RNjqwKj
 ZG5qDnYz4W1/YVV7g3m/3Dk77o+IQDYcuxSS57y8294FhQ6FG95/5y4twVoZrzgbcbyQcA2O0
 UJ1bdGcPoE9diwLzTNB1aom7g0k3lX14DsfiM8Q08DhYG7BuFJ9vc74r02I/FKILtfpQYhHw/
 7Fzb+jWD94MgFpuxiFkZJyrJ05AoGYiS8OcLAw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-octeon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-octeon.c b/drivers/gpio/gpio-octeon.c
index 1b19c88..afb0e8a 100644
--- a/drivers/gpio/gpio-octeon.c
+++ b/drivers/gpio/gpio-octeon.c
@@ -82,7 +82,6 @@ static int octeon_gpio_probe(struct platform_device *pdev)
 {
 	struct octeon_gpio *gpio;
 	struct gpio_chip *chip;
-	struct resource *res_mem;
 	void __iomem *reg_base;
 	int err = 0;
 
@@ -91,8 +90,7 @@ static int octeon_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	chip = &gpio->chip;
 
-	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	reg_base = devm_ioremap_resource(&pdev->dev, res_mem);
+	reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg_base))
 		return PTR_ERR(reg_base);
 
-- 
1.9.1

