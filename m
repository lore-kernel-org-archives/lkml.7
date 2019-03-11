Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D39C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF9121741
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfCKS4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:56:06 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:53489 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbfCKSzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:54 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MbSTX-1gWYAw44dd-00bspD; Mon, 11 Mar 2019 19:55:36 +0100
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
Subject: [PATCH 14/42] drivers: gpio: iop: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:54:53 +0100
Message-Id: <1552330521-4276-14-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:fh3NVv+DDhImpN2P94wWM/OTXPB/27tcdCwhRk2pGUYPKpGhgTo
 2eenWqURDRbwCC5iDgwQwH40x5pwpZJN6odGmoJedyFve2er6kfDSJ0kFUtY0uGUi9lulDu
 ib8XBHjjw1Iav5bzkwEVDE05Xyjkl7br7PJpRYCTIkyZLaCn812NsTPdTn5P0I+qD3qZWqe
 dGBSETcpPDYz56wpaO0SA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dAQe3WHFSOc=:IYuwzhNSPbz4MRHiLo6ZFr
 SifZF0gjHtJvJ38MpUB39SW++KCB7uDadiJ2W43gI7DOa5yUMi5m6i7taFBPMInKVoLJeRJqm
 e0pqXcPDoxi/zLHqAUcu8+TAsaldsYAwQsYw6o3Ax0SJgXXGSfoz89liXFxG3FqqiF/gzsaZh
 tzPOymPtZtTs1h71XXu/vRLQI7Bo/XWItAjhKqHKZ+hLKnbXMXp/1dNW5RVL3yRxtuk6O4fy2
 q7RkHtDae5z5W9PXhXxCoqw0YRFRJPOy+92eRKVfSzbDVlXZOkJrsw/7C5xvAjuf39elSTvpK
 Mg9v6eY65xIpc1DnsUVhSdg76Ldf9uReKEx5oPm+BJsl6QiarGp8ty5cgbtXiteFm2AS0RwQB
 9fXXVuIkQSmRTIkvPC5YnuwPQHqniD9AP770+0tyqWiLLAmHZKxDTxeVu0rUB+SYVQGVr1ueZ
 5VLiGo1h1jSoqTOHkRK09TfS1tSq+D/tY5TZWWm1dgfNOgohocdF1i9LG08qta3ex1QIUawt/
 kPLxoe2CqasAuAS7kHL8vb6pa557Y0T4V3wgDoNNRoorwVxwd8QQjFN6Jqs3/nOna42xuqbYo
 /6EsxflyGe8cD6XzKE0cpEZ07j++u7co3f7Hz9fzM4ghGTerNb/v3p4Cr40Gln5qMassy2YtG
 T8UZVdIaaOrAGJ39BB3cBin6DT+2byWWcpTftiF6FkW/wp7cf1oEvzQQSVHAc4NtSVZehtQVv
 8R8Pp2wmv/a9UYTLZ4NM+1a/Ve6MH2o1Rc0tAQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-iop.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-iop.c b/drivers/gpio/gpio-iop.c
index 8d62db4..11b77d8 100644
--- a/drivers/gpio/gpio-iop.c
+++ b/drivers/gpio/gpio-iop.c
@@ -21,7 +21,6 @@
 
 static int iop3xx_gpio_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct gpio_chip *gc;
 	void __iomem *base;
 	int err;
@@ -30,8 +29,7 @@ static int iop3xx_gpio_probe(struct platform_device *pdev)
 	if (!gc)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
1.9.1

