Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33FBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8328020643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfCKS5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:57:14 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:48105 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbfCKS4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:56:07 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MOzjW-1hQajr0wxg-00PJcA; Mon, 11 Mar 2019 19:55:51 +0100
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
Subject: [PATCH 33/42] drivers: gpio: tegra: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:12 +0100
Message-Id: <1552330521-4276-33-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:AzJtMxIcpK5L9lDHlHkZc67QygWDWhG+SlVRwbIsXUDxSbetHPO
 rhSK9Bh/XY7yeCK86iiJm2oWB1qqeWyeOw7QdUW7AjpTEnnthd+KmujiBKNlrNrPitDjVKj
 bTtVzyj7yHvWkmySQ2c/IIIMPTswDMjLlGRRg5D0nYdP1C14af02PQRjvaFp9kqcfaImRn1
 LBFve/K0+YQfkLHXpvXig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c4pHt85+Owg=:/fi2spomNyje5e6mvNN8oW
 wnSwiRvUmGY3/dMFSQ4qAIVuuipAvYpgryZ0Q7Us3UaisUQg10w2jFECgrawR/M97SEUeaDvo
 ew9W5d6aAoOG1G7vPFIt0NxltrOxj0sHmkD6OOGbpocCRI7vIDv9DZdaNJiEXOY3nPAKdgbCZ
 yGLKaO0Iad5NvidDTGHegYEQvMzpaMwFZBMgVWQVZAnAh8dwvga+duAmw4fdexCO+Fw1HWiKD
 Oo0mGwE2ffs+EDxa1DzZJEi9N8lqUhxbVcMIUiZh7fz8IdnYvY4m6W9PJ8Nklt89yaPzxc/PS
 Y0FzegKm6BF5itQdtQaLylQYhBh3PzI0cKSBK+77nMPo/4kfYhy9KPq83yCZl4JwzHe5Ok3s9
 i699//f6zzC9P4AMULys+y/AnqmLQJPimMlYGyl/7V/nq14NOx3wi6nTuxGtkDiLvxxrmfdFM
 B+/PBXBcY8rx/Jm4vzwFZRb/Uk7UAxHYTbJMyzd50JeB3qjy/Uex3s8FGG7iL4KG8cWnB97Hq
 nBLZTRW9W2jGMGqb96RtYMWjEAtlP7un7/25mus1+t/PABGqO6700w/f6Fb4e1f+8Fw8CTcwB
 kGO5yYUjOd5LgT+Su5pjpisJFrFLSi/ALUgWXzQDTY4Z7HTommlZHfPB3S4Y3J70HE6WqXk7Z
 IorIxY/T9LYsDOIE9/CN+bayrpj/e4sEBejjqPhPekDUfBDL2/Prt4cNryEe2PbLGlQEy2C+c
 Sgk2OaK3agNKLpUBDm+mIM0/bvT2wGjhJOl7qQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-tegra.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 1ececf2..6d9b690 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -569,7 +569,6 @@ static inline void tegra_gpio_debuginit(struct tegra_gpio_info *tgi)
 static int tegra_gpio_probe(struct platform_device *pdev)
 {
 	struct tegra_gpio_info *tgi;
-	struct resource *res;
 	struct tegra_gpio_bank *bank;
 	unsigned int gpio, i, j;
 	int ret;
@@ -645,8 +644,7 @@ static int tegra_gpio_probe(struct platform_device *pdev)
 		bank->tgi = tgi;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tgi->regs = devm_ioremap_resource(&pdev->dev, res);
+	tgi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tgi->regs))
 		return PTR_ERR(tgi->regs);
 
-- 
1.9.1

