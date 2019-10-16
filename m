Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB791FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF970207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393844AbfJPOLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:11:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4221 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731923AbfJPOLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:11:11 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7AE5E44B1A4198CB7B45;
        Wed, 16 Oct 2019 22:11:08 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 22:10:57 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <sean.wang@kernel.org>, <linus.walleij@linaro.org>,
        <matthias.bgg@gmail.com>
CC:     <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] pinctrl: mediatek: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 16 Oct 2019 22:10:53 +0800
Message-ID: <20191016141053.23740-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
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
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 53f52b9..67f8444 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -982,7 +982,6 @@ static const struct mtk_eint_xt mtk_eint_xt = {
 static int mtk_eint_init(struct mtk_pinctrl *pctl, struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct resource *res;
 
 	if (!of_property_read_bool(np, "interrupt-controller"))
 		return -ENODEV;
@@ -991,8 +990,7 @@ static int mtk_eint_init(struct mtk_pinctrl *pctl, struct platform_device *pdev)
 	if (!pctl->eint)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pctl->eint->base = devm_ioremap_resource(&pdev->dev, res);
+	pctl->eint->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pctl->eint->base))
 		return PTR_ERR(pctl->eint->base);
 
-- 
2.7.4


