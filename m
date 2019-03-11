Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC2AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4765620643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfCKS6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:58:36 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:41241 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfCKSz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:58 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MfqCF-1gay1m0jST-00gIfX; Mon, 11 Mar 2019 19:55:35 +0100
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
Subject: [PATCH 13/42] drivers: gpio: hlwd: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:54:52 +0100
Message-Id: <1552330521-4276-13-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:q4YtDZcZH+cI7Jb14ysh8kccHH2aDAoWm0rqkfVG6xg/byB7A4p
 vWshZhMhqhzRJOZTbztKX6iqCdBPceHFFSoGYCA95feqAyK1S2uuCsCfr8lsebYRd6kkReL
 o3nAzhgJ8ykOWM/mYR6chPuG8cMj+CpYDwN9zEb8un4QE/vfSlo7kvNbqQSM5GLygQ/roQW
 dvYWHbsZdveDkQftaeHcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TzOq8Og7p9c=:cO8YXchq43dqG8E2t75SA6
 wuoJc6R2VV1kKt1s7u9zzXnD6E+lSZH6YPb6YXsg5w+IYNQszSaZmDh4kP9LoNn/T5IhGjyqq
 twP5mW/fZBj313krfmmC66gBaNvM4OcU8gQP4RMYB6wmKGim4RpfTVf2BixGpY7SvhrcQEEmC
 5ghUfgrZhrS0Uu6W/6yHcWrL39ZSuu7LShyzMz9IYcArWNF4Evg0QwYTPuV3jE29ddFFybizq
 6p3X/TDgxGHhBQsx8QwhcCHXzGvck0zN7iD3jYVEB0pkKrZ1UxLgjhMHD4PZFFzCL4EofL6xj
 ZJeXVVR//jOSOyDFCwO6A+i6NGhbAfxZgHa3ZGtUNQdQd1yMQgi4LLWo/AqycC+0AOJIv7k8w
 q4RZlgc5TuzbUVpg8lBMCRgw6k0RC+gZMlKyysUyMXLTDW2Vhvy6+u6Fwy138t7X5GWi2iCSw
 0rwnYxB4eIoOvyVVrcZCv23NqvxNOXxnTmKIaX/n6Mv99R2lzUOpRWqDDx2fSIonU6BTl9lRe
 z/QueI7hbDRk4q7RAsua5QnDWD5NvpK55srszR/0zhHN6yORwTrSl2GCMUSmi3RcKXy6Omkxy
 gnoCIj/PwiMcDU0/n/8D0V8UHiN8luYH/xtIJB7NxrHw2+Un5C170aDjQaFgss86nwH8GfpUB
 J3l9ITyqMiixDlW53PrzQIJNEJeBwEyLgEUco6amXSbkDMdje11TkYaOaQWuod3jdJlDCZWkC
 8CUJPhU8Tn69c49gq25Xn1Vo6jhGlrX6Bn6beA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-hlwd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-hlwd.c b/drivers/gpio/gpio-hlwd.c
index a7b1789..e5fa00f 100644
--- a/drivers/gpio/gpio-hlwd.c
+++ b/drivers/gpio/gpio-hlwd.c
@@ -208,7 +208,6 @@ static int hlwd_gpio_irq_set_type(struct irq_data *data, unsigned int flow_type)
 static int hlwd_gpio_probe(struct platform_device *pdev)
 {
 	struct hlwd_gpio *hlwd;
-	struct resource *regs_resource;
 	u32 ngpios;
 	int res;
 
@@ -216,8 +215,7 @@ static int hlwd_gpio_probe(struct platform_device *pdev)
 	if (!hlwd)
 		return -ENOMEM;
 
-	regs_resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hlwd->regs = devm_ioremap_resource(&pdev->dev, regs_resource);
+	hlwd->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hlwd->regs))
 		return PTR_ERR(hlwd->regs);
 
-- 
1.9.1

