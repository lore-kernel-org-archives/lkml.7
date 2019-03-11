Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB4AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B37020643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfCKS7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:59:15 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:55979 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbfCKSzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:55 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MaIGB-1hXRIF1bzZ-00WEZv; Mon, 11 Mar 2019 19:55:38 +0100
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
Subject: [PATCH 17/42] drivers: gpio: loongon1: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:54:56 +0100
Message-Id: <1552330521-4276-17-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:GYCjApWXM9X6oomqeco3SxjEqexphqgfJRxJb4zuI3F7kytdaLT
 sWgkfZKB+674kMJIXjS2HCUyjI+xiWZEPjI4t9L/PLvv2LNPJqAL6Z64yhGGMV9y8Qgvnw5
 umKQVfo2oOcSnfIAgQ13+BxAsYz0Nlqx5+RKXRyr2P49U3ml/n+sbJfH7R+QxWTn5InWWVu
 4sxQxIVFxIvh9zIkEDZ3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ImiAVr0YANA=:UjDYkpismkxisr0fv5Lm6d
 YeUHiZHlTcVJ4l/864P9dI/SbFPZBhVP6fN/d/6VBSsHcQITVTCbVJ09OPpU7zEK7zBCNux0u
 A2N30PmVXKNT2ogrQp5xl9YHzi7yW1T6d5ur5ziffu0kELxsRUBIScPwNLPhfBQAtjT1YAL5s
 snddDuIhW4e22yFSMaFJfuzjnDx2s6y7vNPQWETkDq2iDX0LsmNv9deozPelooiEzSo6hHME7
 4IwuiShjCU4QmpiViZZKl15u+nwIdyArxFZlPi+YqStbcKBBKhp2lmKiNKVDprgDhnUPSE4N6
 czL85GVEn5FDp/b8cORUk10OrTEUlOVTXk/wcYDbomR4uGnkmK6aQswcDkvkTDxxxFNm4bTsn
 5Y1HOJt3C2LquPLouPjmh3tlg7Ps8e3E1Ti0d++83SidVSkBsAEJk3Jv/lBUliIzVCspqRFsE
 1oKnDgYI3fUrIn0JGni2bUDVbjHwVGbP4w0jjAczWyCBejJKKzPw1jCpHsCDVZbIroN/I6/mD
 EY7Gr23Ix+a2DQW6VKsTetc5105eoCfpeA5Tx1KGStTq8Y4DFdS08jQ44mob5K5hursrACVsU
 t/dpA7GXwB8d/oEcqarjqJ66wbKKlwVadHNUMRzW6UIt+w9r2UGXMF8mdWJ+WW9y3QLE5LXp+
 Lhi8UabIdhQL7GygQo5/ohEG+XGBipJKzf1azehLLMTHLuClCsmhW0GjQlSdQxHjO4ORMsoqu
 DV7WA1l19NDnn2FAtNvuMWFWaRb2cLibQQiuxg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-loongson1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson1.c
index fca84cc..1b1ee94 100644
--- a/drivers/gpio/gpio-loongson1.c
+++ b/drivers/gpio/gpio-loongson1.c
@@ -47,15 +47,13 @@ static int ls1x_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct gpio_chip *gc;
-	struct resource *res;
 	int ret;
 
 	gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
 	if (!gc)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	gpio_reg_base = devm_ioremap_resource(dev, res);
+	gpio_reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(gpio_reg_base))
 		return PTR_ERR(gpio_reg_base);
 
-- 
1.9.1

