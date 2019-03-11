Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09633C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09812087F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfCKSzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:55:48 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:55781 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfCKSzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:46 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MGA0o-1hHglD43Ho-00GcR0; Mon, 11 Mar 2019 19:55:32 +0100
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
Subject: [PATCH 09/42] drivers: gpio: sprd: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:54:48 +0100
Message-Id: <1552330521-4276-9-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:AJj9UQ36ZRPYaJj/cNVlFIAl0ioap3o00Av+q2urgkBgCRKVh/Q
 kfZC/XmZS+MgWjzlqujo7UVqi4ORrEIDRai/9rYJ5MID4xoRfHFgYllx0sCVvFATF7DTFo/
 MW9ALZ1D4J1q22J3A3msbPK7NPercuiAOJBKqeX9WeCb0y1coewWU7HeStFM8rlTFOsW5tu
 bIa9WNBsbWos3Rwuhj7Gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D5Tp24xLAsY=:YEqb712ctBBfaqRu8uWF8+
 qRkSSl0bILKe75Cbz44gMiyBXpaYDH30BCj4mnqyVaA10nT9zNmk43zqJvv+StSPHZKKvGOKe
 5oI272hfcI2tH4lgRJYf5CiFt9ow7kiehG6R/1cbQCYOj5dD87YskJVaAkzLTi2AhRIhtXBrv
 bo5+DrVVyzwAlhirlWekdmVA0kTxuHybBQMIRf6YXFkLhDpzhgMnjlj10TlpYoKvNUQuNa7xk
 0fA++AVX5Yhmis90ybB8S9YMMTOY//hIiaQEzbJU+s89m4M8S+Y/CHLb6lwYYoHOYnPx08X57
 hKvOE5RGztWSFjw8AogPy92YxzWbQowSwQuouffJzXO8J0nhvaUuHN2hRntwe+aJm+eA0516K
 qCwsEee0rciOQ1Sc21EO+VemrHD7aigrd7Qut0zHecoMJdIbRpulSsv+CXAq/0Rucx3OJEmQH
 0QXsOzQw4WSCZzZCkeDMiKSmMO5dnNzlBrYZH/UCVDLXW3om6f9inrqVWTe4vr/X8WpEutW7d
 F54s4EpyKj6ZViHgmeyQJG7WzCQJdFSAnfs2fxNcaoQRVu2llk4k9RVTmMyfPHupv/NF2x0Nr
 80T9+GXlzOLff8vbDEe721L/CjlU1p+SecjEb1hTENrcrhwl22E7M9wY0pWoZEeMUx6k5i7vt
 xJrEjFOX8e7ZrL2SmyKrcRXk9KKfHWdf54hQJfJdGh6i35XDSdgZ5J7Kzgs+YbsiG0AsUStED
 YtkAhSHdYPEULyAXjWs0GxW4Q+xIXLr2rqfuuQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-eic-sprd.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index f0223ce..c12de87 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -567,7 +567,6 @@ static int sprd_eic_probe(struct platform_device *pdev)
 	const struct sprd_eic_variant_data *pdata;
 	struct gpio_irq_chip *irq;
 	struct sprd_eic *sprd_eic;
-	struct resource *res;
 	int ret, i;
 
 	pdata = of_device_get_match_data(&pdev->dev);
@@ -596,13 +595,9 @@ static int sprd_eic_probe(struct platform_device *pdev)
 		 * have one bank EIC, thus base[1] and base[2] can be
 		 * optional.
 		 */
-		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
-		if (!res)
-			continue;
-
-		sprd_eic->base[i] = devm_ioremap_resource(&pdev->dev, res);
+		sprd_eic->base[i] = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(sprd_eic->base[i]))
-			return PTR_ERR(sprd_eic->base[i]);
+			continue;
 	}
 
 	sprd_eic->chip.label = sprd_eic_label_name[sprd_eic->type];
-- 
1.9.1

