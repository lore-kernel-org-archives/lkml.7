Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112F3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8875E20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfCKS6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:58:25 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:45267 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbfCKSz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:59 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MK3mS-1hLcep2SSc-00LS08; Mon, 11 Mar 2019 19:55:41 +0100
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
Subject: [PATCH 21/42] drivers: gpio: mvebu: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:55:00 +0100
Message-Id: <1552330521-4276-21-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:SGm2ZbECA44L33KcX8rBO9k7hiFzz8m04hhXgYnyrBzPpIrUgVs
 6HV059efC+XOYPWqi8+NbSgPVq1aMCwTylqQ6IT+r2Wx1Zc0uZvcWcZylzjq7wX7vJjGiVI
 qgPN/qGWc6p2nfUvs9PatfcQYoNWSb9VnUqq7G75xVWuxuand8WaNLkAIMZ805vrG19iWuN
 FCDwcKUXaglHZutXAadrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lji/lNLv2Gs=:vckOvkN1jcUVfj09yUZeGD
 2uKHJlWbKpdOQiQKafRMGbHjuMyUqdbk5R7eUCTW4t+TU8MksM+gdX1RtJnGpitb5wCavp8gw
 eGa9vauVj/0mD0R8epMag1+wFPwgfR6IU9m1edUahpUJ6sJMDUgDoD3/uMpGj0P7qSTmJHRvj
 bROD1crbndL8T/5RnkNwpq7mCRO/E+2uFdQhRN44bOYvLEK9/ZozGr+LtdhCK8sidVOQsag9a
 dyzr94RqQO7JuHQvgEJXdib1e7QJVAHs8ACEYEeKvavdzGA3VlJRHp3YgDOEe40xd5neS1osC
 rhHqKDxBlSB7ta3zsBPjYa8K0PbUgzP/kcApXb3hR23w/AjCvIPJT0xf33eU82VgQDLaQnv6B
 S+Pb/+/3Uzjt8K03lNX1NrVUGGmDmjtin7+1Bp0C/tJe2Iral/ys3NJlRBEHzHExxVrna8AoO
 StEOIlIfGnn8TdTRmpcC4nQ2KvwmJeMa+u0AT3DW4xlFotp3vR6suLdRZcNTIc58vuM7A+3RV
 WzsN5Lv2CIv9ZfGYyb5BmPtSUGuOh1onCJMz07EkK7v5LyC0fxfQxgleuY9rcf/T4bDD6d0yV
 LS8xiMDu5eL4qXBlrhnHup8gqMMnaoSoKZP6X7QtCJzuMypOVAMtOw8Cu7xlPv8RilLEN3Gph
 3Gvv6hbHP8F2uwXQWEVWaB7rQjNkdpZ3gDEoflb1Ls3A180Tjo7hN1066kexSAAOvoxomHlHd
 rD3aAGSa7i4jxyYXg/T9JtkqCsfS21Q2fr8g9g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-mvebu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index f97ed32..059094a 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -1038,11 +1038,9 @@ static int mvebu_gpio_resume(struct platform_device *pdev)
 static int mvebu_gpio_probe_raw(struct platform_device *pdev,
 				struct mvebu_gpio_chip *mvchip)
 {
-	struct resource *res;
 	void __iomem *base;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
@@ -1062,8 +1060,7 @@ static int mvebu_gpio_probe_raw(struct platform_device *pdev,
 	 * per-CPU registers
 	 */
 	if (mvchip->soc_variant == MVEBU_GPIO_SOC_VARIANT_ARMADAXP) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		base = devm_ioremap_resource(&pdev->dev, res);
+		base = devm_platform_ioremap_resource(pdev, 1);
 		if (IS_ERR(base))
 			return PTR_ERR(base);
 
-- 
1.9.1

