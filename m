Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2E7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3F520643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfCKS7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:59:03 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:56915 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfCKSz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:57 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MuDoR-1gn77W0eHF-00uVdb; Mon, 11 Mar 2019 19:55:39 +0100
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
Subject: [PATCH 18/42] drivers: gpio: lpc18xx: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:54:57 +0100
Message-Id: <1552330521-4276-18-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:wij22z1GSFaPLeAiUmWKI/2f6sytehPWk/kcanryAl92PLHG+yw
 B7h3RdTcmBOuFE/G6wDoHE/1wLSBv010NNI0LIzzHVHRfwWvBejNu9mA6YhML/zWQQLzbgK
 fLgCEu/4x044Ne/1fB3hI6imDRDBsMG3NTcRE8Y2Zq3HsTubmhElYlH5cyXby6gsMtpMWU3
 KnC1/uGKzYgonN9YhY9kg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GiD962D/Tr8=:8JY3Iz6vTCCFmvdSWgFZDF
 LnBUC8wKOXVs0gM2oLh4jWy/wvBr8aMetvIvS20HNDihx33ZsXdFf2O6rKB1fo/R5jLSe/A9Q
 7dNuCq2f25anEBQjz3Lkk9mxPXIDME2ZwPSbgi+uVjXu58TbhqV7H4DnWg0czwochQfidOHfs
 yeJyhNsWgL6OokTMVGW9K0+BtLL4LGyt7bX4CaHIST9kjvzmMIlHo0IXhbor2w476vTcx3a5c
 dRrnqmTEmz/tjS2qpIAN+MAxUfRnf9RSdDEujVk71p+FAPVhzNpDaWth/aX+HCsT0VFreWFe/
 Lm4HTCtoLxhHK1j0b1n8cKgFjcP6Z5zQZAcvUfaXU1ZMqgJXG34rkRab/0BP14OvBGYwL3UKW
 n9D7FF7KZZZUCJCO5SGGxdM4ad7lc+fHhIYJzxL2XIiZXmKF4C/xzIj0Kj5X9JRo0ymbe6Xxb
 3Q674BJyOTmjHB6+9MwIngPYe5ON1be5kGkznuBpYQIPR//tky6Jq5lWVu8KZLUl1cHptWLPB
 v1V7vkbm68H1Japq8TVIX0NSEVBsjznxJ+chI5g/qj0krL0lYcFUES6A7CFQvOHnbsjpLg6SN
 ZVJ0t05lKfFTrZNu1fPrldhPnAItHhBItNR92dVn5mH3KecT3kvYRbPf69xk2e0k4NMz6ObfC
 uYGRpIs6gohv9EH9n9mb41tIagFYUd08Aa4H4CwoRzI4bNTFfMfrlizHyyQkfye+QbMgJXbrY
 yHzp0d889Z5cZags02c9LmmH7ICpIak2K9k+CA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-lpc18xx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-lpc18xx.c b/drivers/gpio/gpio-lpc18xx.c
index d441dba..d711ae0 100644
--- a/drivers/gpio/gpio-lpc18xx.c
+++ b/drivers/gpio/gpio-lpc18xx.c
@@ -340,10 +340,7 @@ static int lpc18xx_gpio_probe(struct platform_device *pdev)
 	index = of_property_match_string(dev->of_node, "reg-names", "gpio");
 	if (index < 0) {
 		/* To support backward compatibility take the first resource */
-		struct resource *res;
-
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		gc->base = devm_ioremap_resource(dev, res);
+		gc->base = devm_platform_ioremap_resource(pdev, 0);
 	} else {
 		struct resource res;
 
-- 
1.9.1

