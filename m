Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6A2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB6F206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfCKSzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:55:49 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:46561 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfCKSzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:46 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MCsDe-1hCBWX2BX6-008uo2; Mon, 11 Mar 2019 19:55:25 +0100
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
Subject: [PATCH 01/42] drivers: gpio: 74xx-mmio: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:54:40 +0100
Message-Id: <1552330521-4276-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:Dld4P4mlkxZ+cBRgi7FSkT2DwKwul+OTLykV4/ZhcQxXvx4Owm8
 F0iXLS7/PspPvHxdnr6AErTwi3C17VO00ke7gz+hDKaGNPcZzbVwkVhbPD9ODBC12hqIit3
 7vboIKFfCNLy1XJeGlCV/gtwLlJRE46i2qsrkZWfWLBEDM/p1xbK7am+40sh8zTFTv1dTW0
 aw/i+8u5V5orE0/9gX+ow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5NjyARZWbNs=:n8WdFqBYCaSCOzask13+Va
 dLMwr3EFjBBZw6HLHSTj0DIfJk7U/9SEzWE1uPF2fiN4+Jt90qXvkm+OKeYemclCxbIeAZRnq
 EshhGpDcqgHforEzuKdz/g3HFazt7oubDPYukBw8gT7m1XItJnEjwVOPHDrHaCWmgbjOVjGNk
 Yn1k+JI1aEhPgfPUgLU4SP5J3OmNmvaecFxkP89tRoBlecJqgqy5NaVDpdwFP3eOYyB7YC5Yx
 ECV0YqlDO1Yk3Dexl5AdeCVymFqrpwOj+sI3nxqrj40vsfLOWBBGyfNPfz3QsbSn6kowgvSL7
 tqKNLgD6cpXlXZ4xjUMl10HU5Dn6LsKUyluXKDi7VZvt6GV5SUWLictutbl9dMQgGnJkhlsPu
 3xacwFwbMbZr/kB8QYC2WCUzV0VnFjfXZ/vprYlVLaz5y/9W+FA/r0oj0b04/kY89A8RKZIvt
 fUpJo5+sn2ac9SU/FVZactwvt1P6jbrZn14Ns9N//n2gGpNs5eejQIe+Dl04g56CR+vMi7Ztc
 OAxzgv2GlZwGOmSjmQ8N+IHifHXknLNli/pP0AYl+g0oa/vMe78GagIEvV55iqO76hPTFKMjs
 C6H3uFbWHf6JCvoe0LPPj7JE9hajVL+SJLPRJCSkoYhdaVgr/DV2htsB/q/LuBdD3nzabj3R+
 yaqDZh2oU3nhf8i5pgtDUi9TyyRu63s0+j2CUcYoAIdG1JbaU6H8Pj0HD286ihy2duY7v6OB/
 Mf+axXdaB//16z9CBgOTR+McGF3BmxV0hQeBdg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-74xx-mmio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-74xx-mmio.c b/drivers/gpio/gpio-74xx-mmio.c
index 49616ec..0424707 100644
--- a/drivers/gpio/gpio-74xx-mmio.c
+++ b/drivers/gpio/gpio-74xx-mmio.c
@@ -106,7 +106,6 @@ static int mmio_74xx_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 static int mmio_74xx_gpio_probe(struct platform_device *pdev)
 {
 	struct mmio_74xx_gpio_priv *priv;
-	struct resource *res;
 	void __iomem *dat;
 	int err;
 
@@ -116,8 +115,7 @@ static int mmio_74xx_gpio_probe(struct platform_device *pdev)
 
 	priv->flags = (uintptr_t)of_device_get_match_data(&pdev->dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dat = devm_ioremap_resource(&pdev->dev, res);
+	dat = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dat))
 		return PTR_ERR(dat);
 
-- 
1.9.1

