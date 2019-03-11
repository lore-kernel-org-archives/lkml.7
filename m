Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5612C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F4E206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfCKS5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:57:21 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:45853 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbfCKS4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:56:05 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MuUWi-1glCW23cHa-00rUy4; Mon, 11 Mar 2019 19:55:53 +0100
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
Subject: [PATCH 35/42] drivers: gpio: ts4800: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:14 +0100
Message-Id: <1552330521-4276-35-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:ZLM0qTB4BbBAGFjOCu5dGMzkJwXWbu1LQzcdjtjvs/hDoHbW2Y/
 AKskx/phDVN/mm/Uy6oZmPuKBgch57lgAoKeJvSA/xbGUXak+WUZENy/1sb4riKpxTnEMcz
 33wtxslOv0V1AToQlvRvOpaNafzUEOBgLhDJbfqSE77XL8aO48CCcG4MZUI9gsEMXSJyz8X
 e/XuDb7OFKqKLauWQnhWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ks12aLW2P8g=:26zFSIwCHWwy6UKT2aapED
 VWpkH8q2XBLueI2iW0aP8l4IccGWAAZtOCnbvRZ4HcVssBP6xoeGex8eqXXTpuHxETnibolcA
 dLOYsh2XJpFpVSk7EYgSGvNPPX/kSNwe8XwCiPNeFgVFYHdxT0hMm9OmVbn9TDxD3fuMlXngO
 ZrdZv90J+k48bHodaykfU654kKn7RP977srXASym+zX31blqhdKd0duG0JI99fnBqz9RIzYgs
 DHoqGmFPEhy76Vsuzo6HPccXdYsXEiYV6A8nd7c/mOBLvcYw3xz6eYKYYQnP3o3jm3eAMkvP5
 uAc/WY311sk88bQ6Z9W+2uyQJkE7R9+wtPQWdFXUybTVpBpUdnEyH3fPquHQhNw8fdGT5n7u1
 vsub6Ch9VOIo9vhRRGOCwJU6Ovluykdpkcd8OiZT081C+YKeGiHvEZlxkFQBxLDyNIq9yYrd9
 UaFvG63WdAilReD238vroNSg6kNr3Tp7ZtHct8HNFdtvbJiheYZHIhJpGp0/Ope5aJqldkVdS
 0ROKbE0m1I0hQbArQyRDcDbKFTWZbMdfUHhX6oMTXDiblFyv98SHRwH/b5IZM0LeXb6DIoxLj
 6QKhVIwtYoR13DJdd4Gi7c7BkrN2vFSOhNSwhudWC5XtidnfxRsBs4xqkQGe+EvVxH+OOrr9V
 nW6B4qeo+3k4ECl+4OtEwoHMhNRxRihY0nPmooTlB1ESwVN6kK0Id5oRiTAe/xPt353zsmZd8
 wLkJuAmNsK66Rr257Nyq9tOM7KpVbCB01XAc2Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-ts4800.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-ts4800.c b/drivers/gpio/gpio-ts4800.c
index c2a80b4..8c0d82d 100644
--- a/drivers/gpio/gpio-ts4800.c
+++ b/drivers/gpio/gpio-ts4800.c
@@ -23,7 +23,6 @@ static int ts4800_gpio_probe(struct platform_device *pdev)
 {
 	struct device_node *node;
 	struct gpio_chip *chip;
-	struct resource *res;
 	void __iomem *base_addr;
 	int retval;
 	u32 ngpios;
@@ -32,8 +31,7 @@ static int ts4800_gpio_probe(struct platform_device *pdev)
 	if (!chip)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base_addr = devm_ioremap_resource(&pdev->dev, res);
+	base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base_addr))
 		return PTR_ERR(base_addr);
 
-- 
1.9.1

