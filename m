Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B249EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA3A214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfCKTuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:50:13 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:45917 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbfCKTuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:50:13 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M7ehh-1h9BZ40QmL-0085cE; Mon, 11 Mar 2019 20:50:07 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH] drivers: gpio: omap: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 20:50:05 +0100
Message-Id: <1552333805-23235-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <d3b12ed4-67e6-2993-4f56-80b1be572a24@gmail.com>
References: <d3b12ed4-67e6-2993-4f56-80b1be572a24@gmail.com>
X-Provags-ID: V03:K1:UOLgKaQ4hC7p6VlbeF2/EGm6uS9JICB5QtHJDTckcYTIO2u3hoP
 tzuldZ8GqmLa4aQkDKcotrX4YvcR0pxuJ9Kxr8keTLGMRc4APqaU/0I0RKaJFZ3j3mHZ8+9
 KbLB+5isuvTFGkDM8Ybs17R47PnhmpGzZgfbwC/NaYYDS9Imx13UwU9EVoQT/LblP89gYmX
 BCwIoJ2AjsQF8iHRC5FNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DMq2/qe6GFI=:Z9noEBtHa6RFqR3sHElB0V
 TmCZf6FmpI4d0Aou0nioTQTj6Wh1KF/CZck1kJ+OQwN3vuXshw3XAjEedboZems3BvPlA9jyR
 01jvsxEs5wetFCjcI94DYGOJmnKN1SwwGjrS+mnq7kRy7WtS4h3HCV0dY+VlNDVuD6uz9XGLQ
 4diPwAvLN4Ji3xkz6In3dbaKOokKLUqxDCTVgxicvlxe74idf3l5QBUxd8MvoY2FpKsL77Fln
 7gg1cpdP2vDIQUAeFP/vM6PCbytThC7pErXzC7KKg1W0oTGWe2NSnWJtP6ldGge3VjQE7cyro
 HDx/Zs3e13vOXxTk8ZnNARwMnTb3mFdqCuIEP/NMCUpSbiTmXJ+uxbvod5GzWMfgreSn5kcDi
 BoRypTqYeb4ZCTCB/qQ+c+wKOOOH4gFwdXLklVZCd0aNKnCbbDyGPHbVfx50VhJi8KxeHkQcA
 wAYsCkkp722IlLv7E9gL6blEEDOOzKeNKqS/2P1zGmcrbSMqOHLV9L+2Gfd1dwGtuXggJwA14
 ctOU4EYgiLvUORDmBRcDjB/yrYykSG24v7LdjYYOaM8GoOgE7OJadGxjxNGuLoaZncuIc/3Uu
 RvwauXOJgTRz38swDYcn15JVQ6NEP8pFL4LoYX9y8gD2t3vu88574fHhYNh0LpEKMkfOV1JvD
 2aigyANEgwTXn49sGmndwO43UnhigEO46swA2iowKHuZdIp9HP5wYyQU9QpRIU/dvNM22PNIl
 jyRU+bD5TWVPRKujGpXnmKhaNXUoNCNHntRCxdAMuWk1k+G71Wzn/OPqVMlo9iiWAYkZM87jv
 py9VAsRhpkyVVDmHUsCwDphMMiGgsFWSpZxRUjxNX08dwwa90TuK+a12tVdBELRcrCRZA0ifi
 nYRMMA7rP6sl9an/zPiHZHVcfZov+p4wffYwQlXNGoKeORU9LYqlp9WwHaWF/Bltk6Qg2RftC
 fNmifc7ls8w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-omap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 7f33024..ce6e67a 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1289,7 +1289,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node;
 	const struct of_device_id *match;
 	const struct omap_gpio_platform_data *pdata;
-	struct resource *res;
 	struct gpio_bank *bank;
 	struct irq_chip *irqc;
 	int ret;
@@ -1375,8 +1374,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	raw_spin_lock_init(&bank->wa_lock);
 
 	/* Static mapping, never released */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	bank->base = devm_ioremap_resource(dev, res);
+	bank->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bank->base)) {
 		return PTR_ERR(bank->base);
 	}
-- 
1.9.1

