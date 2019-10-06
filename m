Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6396C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC10E20867
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfJFKeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 06:34:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58794 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbfJFKeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 06:34:05 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 171069924967F1A17DCC;
        Sun,  6 Oct 2019 18:34:03 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Sun, 6 Oct 2019
 18:33:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <nicolas.ferre@microchip.com>,
        <ludovic.desroches@microchip.com>, <computersforpeace@gmail.com>,
        <gregory.0xf0@gmail.com>, <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linus.walleij@linaro.org>, <baruch@tkos.co.il>,
        <paul@crapouillou.net>, <vz@mleia.com>, <slemieux.tyco@gmail.com>,
        <khilman@baylibre.com>, <eddie.huang@mediatek.com>,
        <sean.wang@mediatek.com>, <matthias.bgg@gmail.com>,
        <patrice.chotard@st.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <mripard@kernel.org>, <wens@csie.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux@prisktech.co.nz>, <michal.simek@xilinx.com>
CC:     <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-tegra@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next 31/34] rtc: tx4939: use devm_platform_ioremap_resource() to simplify code
Date:   Sun, 6 Oct 2019 18:29:50 +0800
Message-ID: <20191006102953.57536-32-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20191006102953.57536-1-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
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
 drivers/rtc/rtc-tx4939.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-tx4939.c b/drivers/rtc/rtc-tx4939.c
index 5a29915..715b829 100644
--- a/drivers/rtc/rtc-tx4939.c
+++ b/drivers/rtc/rtc-tx4939.c
@@ -236,7 +236,6 @@ static int __init tx4939_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
 	struct tx4939rtc_plat_data *pdata;
-	struct resource *res;
 	int irq, ret;
 	struct nvmem_config nvmem_cfg = {
 		.name = "tx4939_nvram",
@@ -253,8 +252,7 @@ static int __init tx4939_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, pdata);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pdata->rtcreg = devm_ioremap_resource(&pdev->dev, res);
+	pdata->rtcreg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pdata->rtcreg))
 		return PTR_ERR(pdata->rtcreg);
 
-- 
2.7.4


