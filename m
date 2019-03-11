Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08FDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8212087F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfCKSzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:55:52 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45351 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfCKSzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:47 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MQdMG-1hNqeU3IH8-00NfzM; Mon, 11 Mar 2019 19:55:28 +0100
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
Subject: [PATCH 05/42] drivers: gpio: bcm-kona: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:54:44 +0100
Message-Id: <1552330521-4276-5-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:OB0ffSwb9cqcismUWwuro9j4foAvRX/l65FhOCmatdGPADLga0N
 qHaYaFGB+adX/Z4VICQHcps8Zg3xu8gTiVlaFv+nUpc4ca6x4SR15SuhRl8rqmul7g6tRqy
 hLUCjJmc8PQk+qZupPrGaXnBtXYNzT8JVvly6YlxjzfVwLI/+9aXJ9qYxEjjL1zkzUdlMrX
 iEnQ8bwLPRJrywqG+CDPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8x7KWS/rdBA=:0R8pQi/f6aM8S+aO5taeKn
 ADgVwh+cWiH+HsmFLbVKf/bEKIa1HQopj0Xv/6dbrU06Q8JoLyxEcRauB7wxLoxfoml+pkF1X
 3FqVMou+YjwPwk2KWph2V0y24EsurGRfLNYZQsiVYZCEJaylJ+eiRT9CmU5ylZX3I/037bbQB
 UGHgex/kC7hH8OapGvYTpUplL59ODsmueSuZaNY8dxGFZ6rpfkwdogS2O70J9O2ysk1fUQpL2
 4TcGCWzdbJpeYLArtmaaK9uTh8NhuFhaZ8PQoqT57f30BELHFz8MRdwDQvPIBf6lzQSZBqyja
 xBf+9ZF9YRT2DqrZf4PZr0aLrvwYbXVOMPLEXqiRTYYIIMsDCI1g4nCQPWeJVH48WJInPga5A
 kgz46ovOUYAVwx5p37Se9virCj598xiqSFDM/84PrwBgDM9H2iUwpwMZOLqBZLG/ZIBqU0pxe
 ASVmgNQ1Ap6h5HW5nMOb70qXsx7thBICAQvW+d4d4a/qSlWXUTW98015/zxE4nzGYqRY9yy1F
 alAsTcGdFviVn2NdFSmkzjZinS14M/WUpgmZTVzwIgu9cjvC4lAO4g8xaTpD/urBRQAIL2qrf
 7d/MPr+fizC5u1BTrRivUE9Hp9Zk7qDl/8zTWu2HG5gdMquTnWHIqhFOi2GRF8jPT+c119Cvb
 N59uHYdJMz9Wr4VjPFUyQWViLqzs4bzwUo8K9But1mu7QDEEZBMBGZRn2H2tkHkvOyUUSQoCn
 nylilsynOSnjz+JSzYRAkiQhG/U8rKCOUsU4NA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-bcm-kona.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index c5536a5..9fa6d3a 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -568,7 +568,6 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
-	struct resource *res;
 	struct bcm_kona_gpio_bank *bank;
 	struct bcm_kona_gpio *kona_gpio;
 	struct gpio_chip *chip;
@@ -618,8 +617,7 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	kona_gpio->reg_base = devm_ioremap_resource(dev, res);
+	kona_gpio->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(kona_gpio->reg_base)) {
 		ret = -ENXIO;
 		goto err_irq_domain;
-- 
1.9.1

