Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04738C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93A920643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfCKS4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:56:31 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:56663 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbfCKS4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:56:15 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mhl4Q-1gYVBN2hSi-00dphG; Mon, 11 Mar 2019 19:55:57 +0100
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
Subject: [PATCH 41/42] drivers: gpio: xlp: devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:20 +0100
Message-Id: <1552330521-4276-41-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Ebl/mDhgO3X+TD45Mmlesnt8aOyo/ItBE1dervu7xKnkqgy9rPl
 ZU8NQt4OyItW5fhyPOcdT32HSrxTH/WUFYoQeE2jcjvhynzGoJUtIuXQHvvE8oW4M4D5MVW
 nhTxzdPfFpCucDxvtiHbGyhO2/D9b7Dq1jqvY2azjJfmX3MZ/mswkXKB0W3PFLdvsy6msor
 Fet53/iryx2U/NRQKq7vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NkUzcETFWxI=:ut3VHH5070qjslAcSn/BxX
 PwyoLovdleZQSvM1uWpAx5OqoaUixmjMDv5jgysJGbPEx+TIMP+0Tfa8q7Gj6rWIdYxALT+Zl
 0LQ3tuQNHdZ1IQ0gOr6oWpycFzL+fxckL1hvd/SmzgUctASyAHMHZqjXt2TgRZz3VC5SFNfki
 sZHmxJJJCI+I9D1Vbo1oJVyKg4VGquA2UleXy57/xylE6WPWpKCYUmUKtZxahj6GxbeMyI1x6
 iNdLEx7z0gprvLJZqGc0rWeWxKqHSnAV0Z/1DHUDTA1TT2cVuc+warzdZG2x5tLmUErp47W5K
 7xNSyLfHlrAnTgORmwYKSOtreYj7EtKlwu/+q8QU8q+uEzXWLIw/QzaqIBDKBOD9A0f5xzCeP
 SdCpa1UcQ/m8biTplb1ZeV1R+SwS1qCHIkrR3tLzg586En19m+jejpkpL9mazccIV8bYa9DEg
 DIJv8kZgMhzvePtlxqUvHfgy2u8KhnoDT1ks3eCpPy0wqoyFDNCjP61vegh2qculXL7bHVw9G
 HgxDvvYO/5hAjzxWF6y2sJUP3NLzJns5A7aSrqHIjGeW+Bk44TWifKHl96QPykkYH8u1YOcJq
 PjZCs14P+Z7YnNnrc0ZxEOwr19vXImtcGfj6GAKVZI6aa+veaL4so/5LkqVCt3a/ohXjsEwP+
 sK3l7VsItNn7UIbfodkXa6tsJ7WaAMe32+eWYRlDjZf4gu2hFqG71jtMVBYGaN+5IIxt+sArH
 UnG0Cw383yr7HDYqAHvqZFBliWobeWvpWlK12A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-xlp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-xlp.c b/drivers/gpio/gpio-xlp.c
index 0a3607f..54d3359 100644
--- a/drivers/gpio/gpio-xlp.c
+++ b/drivers/gpio/gpio-xlp.c
@@ -290,22 +290,17 @@ static void xlp_gpio_set(struct gpio_chip *gc, unsigned gpio, int state)
 static int xlp_gpio_probe(struct platform_device *pdev)
 {
 	struct gpio_chip *gc;
-	struct resource *iores;
 	struct xlp_gpio_priv *priv;
 	void __iomem *gpio_base;
 	int irq_base, irq, err;
 	int ngpio;
 	u32 soc_type;
 
-	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!iores)
-		return -ENODEV;
-
 	priv = devm_kzalloc(&pdev->dev,	sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	gpio_base = devm_ioremap_resource(&pdev->dev, iores);
+	gpio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(gpio_base))
 		return PTR_ERR(gpio_base);
 
-- 
1.9.1

