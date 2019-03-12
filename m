Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B2AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D4C214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfCLJT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:19:58 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:33347 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfCLJTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:19:49 -0400
Received: from orion.localdomain ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MFsAJ-1hH3Z60UaF-00HPDp; Tue, 12 Mar 2019 10:19:39 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 7/9] drivers: ata: sata_dwc_460ex: use devm_platform_ioremap_resource()
Date:   Tue, 12 Mar 2019 10:19:32 +0100
Message-Id: <1552382374-28789-7-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552382374-28789-1-git-send-email-info@metux.net>
References: <1552382374-28789-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:phuCYVCNtu/vOFKX6Wlrf/mgYQs3AWJQXpB1qR71og5qJlTap/1
 8ZVZ1rawx1c5dofLfbhM66wzAn4waqTQkeY7WxUsC06KayrSl94lpWKrfRiBhd1ieG1JpPO
 v6hr8o1mvWqWjYL60TzkDxBhNjy3cXYQ/iZadZnaNCYDKw6NpvawVSVri9lb2ka2SyWKqyR
 tit2iqmC6V0qAXPKSWtZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BKkw22+VAY0=:0Tdbof+Lj3M4cAfBhkipnN
 KZnwOtIQ5ISSEhUPANSsThihqwwtsFECwa3u6P4cs+f9UcGYDlA0ndAljT3tuBeyqbeHZ1Cyg
 n8XKNlGiEzWf1ZttgqhDmQjc1+7jVZL/SlQ6XaQbuwfhcsleuQrJMkaL9RQlznLUZnx3336nE
 LXrH2epO8FUiCMRmiIGgR9nLr3tTF9PFLtDo+2cFOHf3tvORkczUpYCwfYKolg7wK/3IJrXKt
 qB027WHiPXDawySexlAj6Iyep+XWNnFNNx7arvtk51WZ3W6mwGvqA4qMdLRBfOPzyRtpsmeNu
 jSaxK3pJ2ILlxJ5weIDCfeLzzrfFpWF4m/d6Gbe8mcvz3qLHapTyk/smSi7nGHJrO81TX6Hb8
 JX+ml2g1eA7WQFfctN0m7zeJmNJRCIwCMlH/X+4Sqhsw4W3+TfXsgqts9/wwPDt0d1UVzWor2
 Qr/5uZwPqzsczB1JwP+VzRXhqns0FE4INTsf6aAg7XJ14VFdBHxcnsuDaPyx63sWWpc8CiReq
 ytLEz+y8cwLgK9iHC+dc9mkfCHQ1LCHMaZMxSh/13SUJHIU3yifxlXvUaMJ8sPSitLM6GP1GL
 IYdmgNgumaVOGomhEYiKJhX2DdidzAaQIMmLx6A/Uc8YN6k5nhhSvIfF7xVSVIkpZXvKQZSAH
 f7KRPeJxYJD4dzWDHwdrsLyzHuIA1PkqV2AWiTAPaHJDMbB80ZCGoq7SV5kmucVJdlw04ay+0
 eJmmnC9P8lVG7fHds93hKfd6K4Kee9fdlmAHBg==
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
index 6f142aa..c57b348 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -241,7 +241,6 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
 				 struct sata_dwc_device *hsdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct resource *res;
 
 	hsdev->dma = devm_kzalloc(&pdev->dev, sizeof(*hsdev->dma), GFP_KERNEL);
 	if (!hsdev->dma)
@@ -258,8 +257,7 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
 	}
 
 	/* Get physical SATA DMA register base address */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	hsdev->dma->regs = devm_ioremap_resource(&pdev->dev, res);
+	hsdev->dma->regs = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(hsdev->dma->regs))
 		return PTR_ERR(hsdev->dma->regs);
 
-- 
1.9.1

