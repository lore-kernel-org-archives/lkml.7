Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2D2FA3739
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4A021835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502918AbfJQMts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:49:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2502830AbfJQMtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:49:19 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 34A8B769474F2EBF411E;
        Thu, 17 Oct 2019 20:49:17 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 17 Oct 2019
 20:49:08 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linus.walleij@linaro.org>, <manivannan.sadhasivam@linaro.org>,
        <afaerber@suse.de>, <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <jesper.nilsson@axis.com>, <lars.persson@axis.com>,
        <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <baruch@tkos.co.il>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@axis.com>, <linux-oxnas@groups.io>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <vz@mleia.com>, <narmstrong@baylibre.com>,
        <geert+renesas@glider.be>, <daniel@zonque.org>,
        <haojian.zhuang@gmail.com>, <wens@csie.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <agross@kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next 27/30] pinctrl: artpec6: use devm_platform_ioremap_resource() to simplify code
Date:   Thu, 17 Oct 2019 20:26:37 +0800
Message-ID: <20191017122640.22976-28-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20191017122640.22976-1-yuehaibing@huawei.com>
References: <20191017122640.22976-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/pinctrl/pinctrl-artpec6.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-artpec6.c b/drivers/pinctrl/pinctrl-artpec6.c
index e3239cf..986e04a 100644
--- a/drivers/pinctrl/pinctrl-artpec6.c
+++ b/drivers/pinctrl/pinctrl-artpec6.c
@@ -936,7 +936,6 @@ static void artpec6_pmx_reset(struct artpec6_pmx *pmx)
 static int artpec6_pmx_probe(struct platform_device *pdev)
 {
 	struct artpec6_pmx *pmx;
-	struct resource *res;
 
 	pmx = devm_kzalloc(&pdev->dev, sizeof(*pmx), GFP_KERNEL);
 	if (!pmx)
@@ -944,8 +943,7 @@ static int artpec6_pmx_probe(struct platform_device *pdev)
 
 	pmx->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pmx->base = devm_ioremap_resource(&pdev->dev, res);
+	pmx->base = devm_platform_ioremap_resource(pdev, 0);
 
 	if (IS_ERR(pmx->base))
 		return PTR_ERR(pmx->base);
-- 
2.7.4


