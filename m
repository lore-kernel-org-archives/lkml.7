Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AE5C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C40208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfFQQt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:49:26 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:41503 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbfFQQtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:49:24 -0400
Received: from orion.localdomain ([77.2.173.233]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mi23L-1iG7No45uD-00e52D; Mon, 17 Jun 2019 18:49:22 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-gpio@vger.kernel.org
Subject: [PATCH 3/7] drivers: gpio: eic-sprd: use devm_platform_ioremap_resource()
Date:   Mon, 17 Jun 2019 18:49:16 +0200
Message-Id: <1560790160-3372-3-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560790160-3372-1-git-send-email-info@metux.net>
References: <1560790160-3372-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:9Jlp9rHiItV3zqKzDwaWVBFkDeX7gjjyObSukf3rIXhuONjebUQ
 ZYl1jTOOEBWEPasLxvfcp6lvcVoJieD/5zCltzryi0HxWqabeTpHiI5eMLwqxjMBWvQ96K7
 PAnrCBYF+Vv0JmjJrO8R1rjR1OcJNBnUAaOy342pFeyUgBhjPrdu8npOt6QW34kURcLHUKz
 g08VtqaX1ArHJHny9oZpg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PE9+bm3ZAZs=:RxCy8vZlMN0lEU3XeOwMnE
 xlP7Ie4LoSPgLSa7TQXnr13nZi143W+uCLF8PCur7Rp/aYst41eeXTbInRPLxyABphzhQjJph
 TGYiJMAplHg8uawDU27OJlaS7oA+hhue5d0tYAqAzwkB/JPhpNhkDsMsL6jgShLpgujf6+xeO
 8OGstXgtQgYacvA7hev/mIzgJeai30Zbi5tte4oekMp37dyx3TPSwBD8tBtWJ67lL/N7RY+dc
 Fn3pEgscFJIm9SSaliRKWoMUuA28Ibfn/gsFDGCvwEkkHlvT9yNtYTr4oNVNQ3e5GEtNnsOa2
 RWukKF5+fTzyJOs1IsbZXRDOMQ8KVlz7KEXK8vz8/wiwYU1ZMhytWtF8HL6C1I1tnPrK5cn0p
 s/3WUb4lM7LR3KS3P8tzk+eJF6VzOv3N9ab149emDtHXplwK4IMhVjYg2fDUN5FSEuP005KT0
 hi5so8QDsMJDHzWfkPhIJPaUxmb0YUOr9FoN8QCzcqXg1JrBf6BZdVbRSus+oRvA6ug6tJq+1
 dsKhf2vsnBLjf3C75Oxf/wswIugIMhusT1OI2wvPkdbHkAa4p8IoMcE6of8cQDRr25fbZRo/l
 Umpe52UxLDp52rQ12Hr6n7gisK2ByVPkzfxRewskGbgmpgq2K6ULMCYBgJbx6NsPfTNBlEvIC
 FjP8Zjiwu/JaAOpwJNSOpD9rJoOKPmzJ+ULjHJPPvu/ulW3gxWCBmCvbsFrnfaZX/h2pZu03I
 fqm0AcYMQcF8OzvDPNxBaggG/OnrUJC1gAAMKA==
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
index 7709226..7b9ac4a 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -568,7 +568,6 @@ static int sprd_eic_probe(struct platform_device *pdev)
 	const struct sprd_eic_variant_data *pdata;
 	struct gpio_irq_chip *irq;
 	struct sprd_eic *sprd_eic;
-	struct resource *res;
 	int ret, i;
 
 	pdata = of_device_get_match_data(&pdev->dev);
@@ -597,13 +596,9 @@ static int sprd_eic_probe(struct platform_device *pdev)
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

