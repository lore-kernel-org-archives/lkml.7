Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D392AC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7B02087E
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 10:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfJFKdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 06:33:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727148AbfJFKdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 06:33:43 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0B205CD56ED0AE8C27BA;
        Sun,  6 Oct 2019 18:33:41 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Sun, 6 Oct 2019
 18:33:32 +0800
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
Subject: [PATCH -next 26/34] rtc: ds1286: use devm_platform_ioremap_resource() to simplify code
Date:   Sun, 6 Oct 2019 18:29:45 +0800
Message-ID: <20191006102953.57536-27-yuehaibing@huawei.com>
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
 drivers/rtc/rtc-ds1286.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1286.c b/drivers/rtc/rtc-ds1286.c
index a06508b..7acf849 100644
--- a/drivers/rtc/rtc-ds1286.c
+++ b/drivers/rtc/rtc-ds1286.c
@@ -323,15 +323,13 @@ static const struct rtc_class_ops ds1286_ops = {
 static int ds1286_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
-	struct resource *res;
 	struct ds1286_priv *priv;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct ds1286_priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->rtcregs = devm_ioremap_resource(&pdev->dev, res);
+	priv->rtcregs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->rtcregs))
 		return PTR_ERR(priv->rtcregs);
 
-- 
2.7.4


