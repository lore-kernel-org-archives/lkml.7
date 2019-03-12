Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00ABC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89899214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfCLII6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:08:58 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:49959 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfCLII5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:08:57 -0400
Received: from orion.localdomain ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mj831-1gXbYw25pt-00fArl; Tue, 12 Mar 2019 09:08:55 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-gpio@vger.kernel.org
Subject: [PATCH v2] drivers: gpio: sprd: use devm_platform_ioremap_resource()
Date:   Tue, 12 Mar 2019 09:08:54 +0100
Message-Id: <1552378134-3678-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <AMz4kuKC5haGbhyVJ4gQ6nMRzdaxJnd3SmeCSM-096p7TAp8cA@mail.gmail.com>
References: <AMz4kuKC5haGbhyVJ4gQ6nMRzdaxJnd3SmeCSM-096p7TAp8cA@mail.gmail.com>
X-Provags-ID: V03:K1:RP2TnKo1b4/3Y2AmPuibjaShmun8RDi3BKj6ms70NhcaTkZGUfL
 FqgI1Q4gPX1Te2afPwHVLfIhOWULNqryGVNcxxNkWrtxVTkrGY5VpN3E6Zl74/lIfYEJcdW
 YyHNRO34AZy0SOAoV+mA8lGneVrE09NRUo4l5pE8DS2GNfC8IJj5BjmvotvcHDv1wZN9KJ7
 5DSq7lOSufHgzlEBrMl2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JhJ71fcJqRs=:1PCslwbUVns2eHL+7BGXGU
 4lk21GjP8UXXE1DZbTY79w8/Yg1EI8kO+IzUT3//wbz72RBqymlYvQkuPKuYfjMYc2Qg82qXx
 PHw231mV/FVCO+/ibMHgaJFoSm5vL3FIC/C+0fTXbqxdKwVsVCR5vPuajm01cC0z5NEcE2XPT
 VOK002s67Yc9bIhi1XSB+hdxmcpS77W+84a1WAef1IpHPw6LnIcEGVs3BuwKhIgmdPi0Ezkn/
 jG1Wgtq3qFpuHcQ4JCOySdgSxWUSbol3ldxMCibqZIrxExHoBJ5PdvJkT5ZXMfsqLD90/Okf5
 adhTPDiTU3z8wmvpUW+DFDCWxt7yr4bCOFGG7jsgvpvKu/b6lMF4KgU8DxkXbmt107R8gORWn
 blAfD0a9m8W9ipsFGe2ZSwPwVJfPuUB/C5NMUqemW3MZwlcpJKe58pgtN5fgjBq8+lXt6dCXq
 WrDbVLcfU8TyhQRYXG5dMnXTspC2tQAd8BFNm8ayKoX1LVQvvvk1Uwme5ldWdun4voBJskxWZ
 MuyrZvGuzM0mbA+lQWdRKqmvWwQx2B1SQ23BdIddBgjGilFuIVWDTqN32ukxvQOm7nf9ebG5a
 UKiLEFThMyCBepUtcd91zKc4j8lO8cffpepsX/g02xjgs6uJ6XIRuU/H1hN3/J65nCwJZ2lSw
 oAoiUNH3agrYu5Fd8KQB0AW0AL0asClJnii0SruzD1SdXNX/YUVZIHrRnXhLrMWhQsK3LtJ71
 gDfqXskhHUSqgacpeMMmreUGwYBTAAFa7TYiNg==
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
index f0223ce..462cdf4 100644
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
+		sprd_eic->base[i] = devm_platform_ioremap_resource(pdev, i);
 		if (IS_ERR(sprd_eic->base[i]))
-			return PTR_ERR(sprd_eic->base[i]);
+			continue;
 	}
 
 	sprd_eic->chip.label = sprd_eic_label_name[sprd_eic->type];
-- 
1.9.1

