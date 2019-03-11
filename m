Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E7DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E6B20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfCKS6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:58:35 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:32977 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbfCKSz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:58 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MSckp-1hWJl91b3Z-00Suf9; Mon, 11 Mar 2019 19:55:42 +0100
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
Subject: [PATCH 22/42] drivers: gpio: mxc: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:01 +0100
Message-Id: <1552330521-4276-22-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Qm2300WtvIG8jpOwQ2dOoknWJDwlukNYlP/V1FHhyIv8GvZQlfp
 czKBLzx/payXcZezcI1rIrFwhMQQc09DfO0u7kXM685jbkORbAGk8/dSUAVVvBv3U2iSGyV
 xV8mDUyx6TnsK9gcHym6a1AeeOzs/F8MEgPXe43XTUKtibagJ3hIjOIQYrHHLHCwmc71yvY
 7VkKhu7zg0AijFz1SmJEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N0wF0C6Ywiw=:g7aE4UxttlkTfp265hrhw0
 DgO/OcHsYvKAQN5EWGQxjj90E0qKGk5fYdToDsWpHOCh1yG3MYHnrqDCBMsD3LZmk+s+Zo1hv
 1MmWCNuZuvPSVmkCP84vAq4jE3sbb3SF12Bq9KqgjNGbOkRYI5CMrHYRa7qE5oQWlTQcLhpHf
 j4TKP7bP6uyXLOKgQkqkibG8T4PGvfoLTflDWWiLz5LBuUuXYiRPrzD/3G068YzATg6heOeRu
 Bdkrf3Pjy/ffrj9Ovmb8J+okui24BrYzfO/URYv+a5JPD/FY5OX3Kd/bv6Ri2VVHQ0bh7QLcn
 M5uwaTazP/3QFXqFMFYcFWmpEDpQKi+U95YmuoznFgdGNBCglH4HTrXI63DqUyc3ggaOorigS
 6C4pqdLR6eE1j2SqMeubTujCUFrh0mmPgUvuqE3tywE9/grJM/Sek2es0kk7rCvqPwTslXWEf
 NPPnb+nKZOXSlpl88M8bNhAyaR/OezMfNtPrv6qv2u5J7H2uWY1MSOHClfMSu42bMXO03xeJn
 gZHMWCgrqA1JvHE8TYTnUIFqO118fkPrhaEX2+U7QufG02fGOj94dV+RLmecZIhQ7BvbA+aFr
 S1yYlTnME3tZFiPBI/UYJ4qaZyiUrritigsjZWx3DEExJCK6M4xq8y/WjwYzQuiIgMneFtFC2
 W4egBwD7E7BRQ+kwtKaJWl5NaUk3kkSQgHMfKf6ipgm35zgjWGoyRJ/XXlXxRr8J62dCEXk3U
 BYkaSz/uf4gP7pOUjfJESKzOYBux4cNAtCw+pg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-mxc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index e86e61d..b281358 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -411,7 +411,6 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct mxc_gpio_port *port;
-	struct resource *iores;
 	int irq_base;
 	int err;
 
@@ -423,8 +422,7 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 
 	port->dev = &pdev->dev;
 
-	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	port->base = devm_ioremap_resource(&pdev->dev, iores);
+	port->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(port->base))
 		return PTR_ERR(port->base);
 
-- 
1.9.1

