Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEB6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E825C214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfCLJTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:19:54 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:42047 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfCLJTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:19:49 -0400
Received: from orion.localdomain ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M4skB-1h1iYu1cQh-00238X; Tue, 12 Mar 2019 10:19:39 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 8/9] drivers: ata: sata_gemini: use devm_platform_ioremap_resource()
Date:   Tue, 12 Mar 2019 10:19:33 +0100
Message-Id: <1552382374-28789-8-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552382374-28789-1-git-send-email-info@metux.net>
References: <1552382374-28789-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:ygMbOZY5Dt4reBEHFx2mw1Or0kbEPtlHK7viHyATw/DwO2V5G3r
 H+XgVQy0FiHfog0eferi/wQ1yIAXLqxIUOBrw4MzC7Opi/IgUwlmLrfXIzyCw59SR0RXOTG
 RQLa5oaAy4+TfBxBGIijHwV1mSFHPrxythtae5Ki90SgNEbtuZ6KKNNuQlV2ziDR+SLSETw
 KHnyrBhGOlutsxxqNoJtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sDl3EPrjjAA=:c2I4RDmB8GXosA489J3GzA
 aze3BmBjpKkaM9I1xFrFkJb3GbwN20LYjhB9DcM/OOQmeHydMmdtEfBGgPcpqFynK5zt8qk7X
 v/dSTXzCXOgQghAhEecL6hd8J85/rjVLHe8z875SZpdXwVarpw2Ub0hIdtX4R/DRee1EvXcVc
 O7Phj0QBLKuFQG9SlHWLYr58XKOg1VVCslevhSUAMohz6NariB15c7suO3QFjI2ueHjfTANkA
 O8SI2HjJ+NBn1SwymR+p53oLtPpC+6pPdP4+7mP4jw/1xNReUSQvNUzsRN4r0pCAlKOCnigRR
 OyWEbUXaAGoDnaZambqbzYMFQPr2KfoGvMWnkNwnx8dwyGGMVDoymQf6t7Z89DgOQitg1x5Zy
 +8YpgPup0xOssnmLkWRDqhd39bPSR8dJM6B3C6j/cBLt3DcXma2zpUwSSm7WIUnCFO9g2jivb
 w18fkdxeTGmhloBWuWet79LV3lm02kJIZsQrlyHChApiul9b8YdRjb6xfplgjiRvtAX36eOZr
 kfy7cN2znpmxkhVWGMLJzNV6k14xO8g1r8jyzR94S094B/2g+ejw9ZYvFNsIpMTd8ATtKfIi6
 a8rc/X/pJt5idcCuspcdrFTBJhTwghGCkjFG9Tc3mvISZXuywI+MAXvh9xE0GM2TM8yF6TGkk
 YhxKA0KF79hYkKw1Hzc3M5ChboNuuh9WNDHBI1Vm61+AmedheojE23rPLjqzOeAnNg4Xl02at
 m4rTsVzVl2nldngiMHJ0Mg6jCihIToLVvze/kw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/sata_gemini.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index 46950e0..96cca96 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -317,7 +317,6 @@ static int gemini_sata_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct sata_gemini *sg;
 	struct regmap *map;
-	struct resource *res;
 	enum gemini_muxmode muxmode;
 	u32 gmode;
 	u32 gmask;
@@ -328,11 +327,7 @@ static int gemini_sata_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	sg->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	sg->base = devm_ioremap_resource(dev, res);
+	sg->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sg->base))
 		return PTR_ERR(sg->base);
 
-- 
1.9.1

