Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3925BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9DC20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfCKS4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:56:14 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:41749 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbfCKS4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:56:04 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MEF87-1hBM253V37-00AHql; Mon, 11 Mar 2019 19:55:48 +0100
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
Subject: [PATCH 30/42] drivers: gpio: sta2x11: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:09 +0100
Message-Id: <1552330521-4276-30-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:LDHwn7aiSY3DM01M3mP3F+2VrDepwP8XINcvNOEBoGf8iFZCD51
 2OFbylwjrSS0YmJCmXtun14lQtU7xHcS1o8rTd3CMO6wT/eUQUZml7JyDYOZ2u3wwQ3+/7q
 xAeOSXRF+r0g8ht5N3b5MNUUAAAKbi+clmsIGGnWQEOWhijbfoButnb+BPZrN7fwRkr8gqI
 kRwmTn2p8pSXREB0X/loQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rMOXy8SLZmM=:OciIml2ix60N8uB4aaFfKB
 ffu400N6fwstVgeYYGOKnOtAqdHm8HXIenVYhNZkgF3+iA/Lg8kLEZTkXokXrELLvadAHqa+t
 QGJJ/wKYyWZnUy1/F3YBI9i721pxIB5wrgh47YU8KO3pnvisna1VAa2C1UgiGhsSr9AzrMMoV
 OQQVtB4MTkqvhgUnRdwe+FFcqoSYQh3rDsnuS0P31ceilKLfZo3x3zGAeo1G2B69ttSUAHxIU
 +N+g3o8eBHTwkwP7+NeZePlroopXDT//Oo7q3dkzvzYN7S+ivA8W4xZPmMFth0APN0zPJPaJ9
 ZtH8ALIawPI/74mxT5n4GeaiQ8M3Jv42x4To1LBv1yG/+53tMxZKTL+agUFoU8PJnR7VZycfn
 HGn/ZH32eDaG5Z9957bNW6rs5yyh0JFQZ7MG6F3Zduw1HLCv/4c4oEUyytfYjBnkanLCynBK9
 Ii5SZaE2ohQponjQuQ6dEniz5NjEXtnRs6IxYI478GnhxJiWvkuwhfJap1jfVjDPSLGFal3nL
 GbXObh8toKL324ZWK8qt3W0haMSSsHTdJlyQhFiCr6uAk+ItxXAuvKGU9/qrwHSgpS8OKVecO
 nWPh0mbdHCrUqBwYJ8SvTLSB0b6ByagJJiq++1JwYfhmueey2OYtI4i0E5+npAubLebjjxECE
 F6ADQCDLTQTh2iQjl0iVDZx9xPMk42L1nmWsTwOWpnF0Y3F+JBP+yjaRDTDZCjWdbxEQqwrGt
 oGCl03mdopzakMqYNpsCF7LtjkyGCRC2gNihZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-sta2x11.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-sta2x11.c b/drivers/gpio/gpio-sta2x11.c
index 2283c86..a51c310 100644
--- a/drivers/gpio/gpio-sta2x11.c
+++ b/drivers/gpio/gpio-sta2x11.c
@@ -360,7 +360,6 @@ static int gsta_probe(struct platform_device *dev)
 	struct pci_dev *pdev;
 	struct sta2x11_gpio_pdata *gpio_pdata;
 	struct gsta_gpio *chip;
-	struct resource *res;
 
 	pdev = *(struct pci_dev **)dev_get_platdata(&dev->dev);
 	gpio_pdata = dev_get_platdata(&pdev->dev);
@@ -369,13 +368,11 @@ static int gsta_probe(struct platform_device *dev)
 		dev_err(&dev->dev, "no gpio config\n");
 	pr_debug("gpio config: %p\n", gpio_pdata);
 
-	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-
 	chip = devm_kzalloc(&dev->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 	chip->dev = &dev->dev;
-	chip->reg_base = devm_ioremap_resource(&dev->dev, res);
+	chip->reg_base = devm_platform_ioremap_resource(dev, 0);
 	if (IS_ERR(chip->reg_base))
 		return PTR_ERR(chip->reg_base);
 
-- 
1.9.1

