Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA08C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2FB2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfCKS4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:56:00 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:60591 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfCKSzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:46 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MauFB-1gVzwD1NoR-00cR3V; Mon, 11 Mar 2019 19:55:26 +0100
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
Subject: [PATCH 02/42] drivers: gpio: amdpt: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:54:41 +0100
Message-Id: <1552330521-4276-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:t7CtsQ6196NUwn5AFANedHt5v9gF4mlhPz7HwxccuT62LP/FYC6
 R6DbwjnsyOAR53nEwDDOtCynB44mzcscN8kUf4o2M58AE5n1AghFS4Sc/Ft4tZlt+4eZCvo
 aSofRSDj3JREBpin32lQt3cN+fIT/VUAdyBoVRbQBZBMJV1e4J6aAbgbVJIsx4261NhTT+3
 SD39WRbgYcMUJmnrDnBmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bUfE33xEpxs=:pTsoENNS7szHsdIGMkPYSI
 pQm7fewthpFAWB1DJWYebJfjXEoJb/cDcaDUnhN5VlkX/D23gUn0JBvrjZgUK24bxNAgPwNoj
 PsUgP+4Vzio6UmXXIGsSfKGo9shyQW9Ah7RvtTvOJLiRy7tVtGJX9wK3vUB4NvTKT+htGmqxu
 kzuyKFZYUhXduD2mlcwMdfwG3Ye7EAZvFIrGdhqjCSAaupf4cQGS4w9OnrmMp2mMfAtpYfsXT
 YhWH+lwKIpVeuo5yKaSBryOom96+Pd/34ECqxVxkiXMCr1OrF9+tt85zzhLoJubLwsIbweAAt
 kiTHABS4GpZZhZCxbUZ7zCNflvXiem3ap997Jq9xJS5ZdtU4TTbg/ZjdvhVKObToViGiNZqyP
 /H4TyZYl0+35AQe88Y4dX1cEtKIjVAFT2BtD2yZY+Chn1rE+ITDa7MHkYtPlhykMwroCRBKfp
 Yh5bvW39ImG70gVmiuQyRqSAVmtkZVD0YKCwdUG3sQsVfaRwMAiye2L/j3x0iabfZNKFD8YcK
 gcOkWEIUlkPf5QFVh/qJJ1psrfvkQopb/sJE8Zs6jVqqCZOyf/md0rbM0KaFD0tXc8O4qRj+J
 Z64Ls5HV5XGFiElfPf8cmanEQz0SIm9YR6nN3e3PcFwQ4nTcEUjp6nXDH4bDvC0QuvNoiBGYO
 JvSnVbdtm9wuOCsWcZmpG9/Vb9nefJBSa5/g3el26qDbkw1RgkVSdUdHETcKDEmFylncXByc0
 YJhpi5ZsGUyPGrpoTQVWboScA2C2zMig6Y9FxA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-amdpt.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-amdpt.c b/drivers/gpio/gpio-amdpt.c
index 9b78dc8..1ffd7c2 100644
--- a/drivers/gpio/gpio-amdpt.c
+++ b/drivers/gpio/gpio-amdpt.c
@@ -78,7 +78,6 @@ static int pt_gpio_probe(struct platform_device *pdev)
 	struct acpi_device *acpi_dev;
 	acpi_handle handle = ACPI_HANDLE(dev);
 	struct pt_gpio_chip *pt_gpio;
-	struct resource *res_mem;
 	int ret = 0;
 
 	if (acpi_bus_get_device(handle, &acpi_dev)) {
@@ -90,12 +89,7 @@ static int pt_gpio_probe(struct platform_device *pdev)
 	if (!pt_gpio)
 		return -ENOMEM;
 
-	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res_mem) {
-		dev_err(&pdev->dev, "Failed to get MMIO resource for PT GPIO.\n");
-		return -EINVAL;
-	}
-	pt_gpio->reg_base = devm_ioremap_resource(dev, res_mem);
+	pt_gpio->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pt_gpio->reg_base)) {
 		dev_err(&pdev->dev, "Failed to map MMIO resource for PT GPIO.\n");
 		return PTR_ERR(pt_gpio->reg_base);
-- 
1.9.1

