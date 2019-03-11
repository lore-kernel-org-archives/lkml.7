Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76332C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560EE20883
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbfCKS4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:56:20 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:58293 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbfCKS4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:56:15 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MRnXY-1hVUY81wdO-00TBmG; Mon, 11 Mar 2019 19:55:58 +0100
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
Subject: [PATCH 42/42] drivers: gpio: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:21 +0100
Message-Id: <1552330521-4276-42-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:2LJDIy+/NTyotb6nvlXwEmN99EPjq0YcVBzQbh4KjRi9rAfmUI1
 C3Y7OdifTOByscUfTFZpIXO1TCLynfnzceMCY5HxiZXgV86Mik8dApa3MjfPWedJV0J2iLq
 7vQ10gnTKbTWpbcqBf4tx01AIDb+m9/LB8DdhnxyM15dcLjD5C+fjbGS2g+pZD7+jJ5N6zJ
 cavweOpA1vp+cMoGqOw2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TWrT11k4J4o=:POyb8WLicxVsIKrHqtlzXs
 4y7ZFYUxXGgZQAEb7Hb3ujZNcJ6k3z5Xa9IzdKIKvTGtF0NMAVNnM5sM2YFcMLUu73Ne/G4TD
 hynb3/JsExeKCjR8nTE7HzxpOp6qdYh0Yh51Yk70FYQY0vNe2leVBDcjhFVOFRq6xscTWxfbq
 r81p2aWg5O2AU7qbqGaJsXUFSnL8pXXSA5NAjDsAQRRhPbutbmp5yRsoT9kAu+fhbpJXNjeEP
 ANWbluKGkxZqMWdEyqUYsnu2CTFfg020BNdMxV4DE2yV37YcC2VRhvzduE2z2LGZxzJHrJH2C
 fKDYm9xCp5ipZX2yqSxJlUSPTbZluuvQSccFtpdaKUIgbMvtHw6kmAxmtFPqXySK7mR3pdali
 Q7bo/zZ1LQkz29dPme0bi1zR4ycpHh/bDnAC1lVSOVrquNpgWXw4ojH8BQzwlNvuKhf/ErTvE
 O/2htmuYY1FmOKSVPcpOpZcKHRCGYXSNuA71gETjpTfgyeirgcgyvMlwlDiA0jN9zyEw0L9ly
 H0Tcq0ZidfR8gMsnbxY9LnJbZ8oqXHCg4DdH+0JuIrtTCW8x3axAmTy/Qjr7bh7fkOUAuWQCJ
 VmGCIlGQbVPVDYuqopv5KicFkt+WbHeUUPG98PgP96Hrr/tHBGTfSFGOXZ9tN59EqGRTyD3RS
 CfCb/BhMOmY3pyjjVjkZSoauSD7Qyxm/CHxu/4icbhsz6Cij0sAPOKgKhWF1/4MpoIgR3gMMP
 O5ajKagKpgt1YXNdSMOf9EYVP3Kw2D5yZI8TXQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-zynq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 00ff7b1..9392eda 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -834,7 +834,6 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 	int ret, bank_num;
 	struct zynq_gpio *gpio;
 	struct gpio_chip *chip;
-	struct resource *res;
 	const struct of_device_id *match;
 
 	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
@@ -849,8 +848,7 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 	gpio->p_data = match->data;
 	platform_set_drvdata(pdev, gpio);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	gpio->base_addr = devm_ioremap_resource(&pdev->dev, res);
+	gpio->base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(gpio->base_addr))
 		return PTR_ERR(gpio->base_addr);
 
-- 
1.9.1

