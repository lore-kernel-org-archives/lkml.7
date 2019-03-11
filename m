Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67038C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E4020643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfCKS7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:59:01 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:41297 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbfCKSz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:58 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mleo0-1gcIWs3IYs-00inmu; Mon, 11 Mar 2019 19:55:40 +0100
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
Subject: [PATCH 20/42] drivers: gpio: mt7621: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:54:59 +0100
Message-Id: <1552330521-4276-20-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:nwyqyqA9VL/K+WhaUHLAmkhPztl9JJ5XmyOE0xfRuw/LBL9XuWH
 5PZzrddYvMHqkth0uOZJDx3ULJLS3fNI9GxBaQ9rizswsiuvOY9e7Qm19lghpf7AuGSqcuR
 PpZUSigDJBCch9qMXLJYX4LNajiNbBU/Oj1LJcQQr36kMKGoRgEmlgQBHcfaYc0YO1SUmNa
 lC0Dp94560sqeaxffxlrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qnqyLbMetcs=:/wtSDYrCdKoqJ9YGH1dVv2
 YzIkT7Q1Y2izn9Mrbu5F5uoTFXUdiSYqqBbxGJmZWGE+o4Va+04b3JTC+38VJOQHjG826t4bh
 obyYmkncBNm5Ln1N1lYQ3AbCjAg3zHzKN3ImfMsdSZUachsXivUa8ZeTh6kWba2LjeBRZ8gcc
 P7zphK67JKETTiC70Hp1azbsek7CcKJfOQsLe2Lu/0b5mWJyFxEstj63NM+s4jUPLbKAe7+xT
 8SfYnMjT3kUclkJBpxkBBgslFO8rqpWlPe2Z9Yrnwbmj8A3Su1/quHt37su/rl5KDfRlpY58d
 Agw/eetqMIA9NZUBUZAPKeHhKRttwiPPoY9MZ/m7zvXoLUcrw2NtbHYmRR5N7ZYA+jaiAU2rP
 hw6EIOTHv3nzoxJkMGHNn9CR/S6nnrbU7rAHCgNKFdEMnqXW25KL4/qVv4A/GlJbGjZ3GSc2n
 dJjWvN4YMBCwjyfk2edde2rJJvrMHLZbOYVHQ9lXg66QrlWmbifJ7i5jGz0BXgHTiNriim7mB
 B/iUdmWXpN1ORhfHVaK+zK7u0HcHE05CKuJFnLPcV/RgRgRqU8G6KjC1sVUBNuVm6i/+5D1OK
 tmOAj/PF4m8XF4cApyKIvqq9FReqp+xwHY37NA4FqUH98LlS5XwAN6Ie9n/65/6eU7Et6q6mW
 sCKuwytpF9YBhxCQ8bjwF1MFYnAR8JLDZpgdsLdQdS0KYkSphHVAFhRMtLVrPygRA/AKQr58y
 Bfjfw+XWhyFLTcMUftdwecoY4HgZxOuqh5EQcg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-mt7621.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index 74401e0..79654fb 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -293,7 +293,6 @@ struct mtk {
 static int
 mediatek_gpio_probe(struct platform_device *pdev)
 {
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct mtk *mtk;
@@ -304,7 +303,7 @@ struct mtk {
 	if (!mtk)
 		return -ENOMEM;
 
-	mtk->base = devm_ioremap_resource(dev, res);
+	mtk->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mtk->base))
 		return PTR_ERR(mtk->base);
 
-- 
1.9.1

