Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA35C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F6C22DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfHTMgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:36:03 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:36057 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730091AbfHTMgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:36:01 -0400
Received: from orion.localdomain ([95.117.23.32]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mbj7g-1iXSht3wqc-00dBq3; Tue, 20 Aug 2019 14:35:52 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 7/9] drivers: ata: sata_dwc_460ex: use devm_platform_ioremap_resource()
Date:   Tue, 20 Aug 2019 14:35:46 +0200
Message-Id: <1566304548-19972-7-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566304548-19972-1-git-send-email-info@metux.net>
References: <1566304548-19972-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:WhHDhrUh+A6TDsinQAj2garKIQ/Ta1t5vveiFsAMmbsXap4bHbM
 AX3795s5AjHe5+h8t22FJw9hQgNXzcrXFm5XpJHaNr+A6VKyFFfMuMQ8V2WyV4w157e+4Wl
 6tBjD11lgCOW3LuVGCRTqkAtoNlSXktEmkKqpwHgaQHlAesgAIdQ4RgpBwWrMwB3nHy0ihC
 iWIgFxib0J1CSHH4JwbBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+Dn2jZWxmis=:M4QV+GCuPIdHv54b7IbCnw
 d/n4WkFgpOiNg1OyG1Lzm1M0jQLQNGy1b/C42bP5GoVNj8Sf4haEDt4h1z8n5ONO4GjoiALfu
 YqetGaJ1kttD9uIs/68DsvIqu0ll0eNYjW1PASPbCVs1mhFRGkXfjTLY8GBaH+7Ax+kO3akME
 q7ZyyuPVLcQujUXqXEBwejF/39EsqtG9ltCOCtGQmpPDDBZNQ8IaDFo4He1V6PdOclKJlo0Kn
 ivjSPLleBmCHsN7/CNO0c49t/xNwoaTbTAEvQuLCNsAkz68OTzFgwT6QctjOtLJOeWOPW9tYd
 pY1M3pYFZnCLwokcQsigsRuQD3mYUM9fn5C/mrisNcFllTHp2XeDvDEjW/6/PoHvrsplfCXZ8
 wV/tGHWjRAQfkqk9Yu1oanvKTYBXwE9U4Qv8ACAs+HtTmXzCnyExt4eJpWsAtPE4wmFWZO7np
 AmxT3mVI/lnM0yoGUlK2V0Bu3MG3QB0IkPy2f/PJQlncaemrZcO99zykHsekx2r90cOsPGfO2
 HahEc+eaDdoAFWPyX/Ig0W8bKnBDAmPyq5Pdi1Xfeq3PUdQKn8Iapy1jCp5Mnrq+Mr9wFvVyM
 qYLtIIsLovPn/shZm1TaCCggxcm6AScNp3m02IsM5Soyf0OqkKcgl9tPBvPOu2i3UC0VkOgTF
 kYgkO2CPVuiEtxS/tY520GlK4Ykl58+K+sXcQTj+nbJckFXvuPHWz/LFTqpi7iFs/g719cvDr
 lpgN44KScm0F7IH5Z1GlMP0wVkskRPJwQhZBvg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/sata_dwc_460ex.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 9dcef6a..de248fa 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -237,7 +237,6 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
 				 struct sata_dwc_device *hsdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct resource *res;
 
 	hsdev->dma = devm_kzalloc(&pdev->dev, sizeof(*hsdev->dma), GFP_KERNEL);
 	if (!hsdev->dma)
@@ -254,8 +253,7 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
 	}
 
 	/* Get physical SATA DMA register base address */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	hsdev->dma->regs = devm_ioremap_resource(&pdev->dev, res);
+	hsdev->dma->regs = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(hsdev->dma->regs))
 		return PTR_ERR(hsdev->dma->regs);
 
-- 
1.9.1

