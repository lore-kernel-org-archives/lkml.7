Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA2DECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BBC20854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732747AbfJNOkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:40:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3753 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731121AbfJNOkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:40:45 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3AB38DE56214C485899E;
        Mon, 14 Oct 2019 22:40:43 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Mon, 14 Oct 2019
 22:40:34 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <yuehaibing@huawei.com>, <kstewart@linuxfoundation.org>,
        <swinslow@gmail.com>, <opensource@jilayne.com>,
        <allison@lohutok.net>, <tglx@linutronix.de>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] clk: hisilicon: use devm_platform_ioremap_resource() to simplify code
Date:   Mon, 14 Oct 2019 22:40:14 +0800
Message-ID: <20191014144014.20644-1-yuehaibing@huawei.com>
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
 drivers/clk/hisilicon/reset.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/hisilicon/reset.c b/drivers/clk/hisilicon/reset.c
index 2e22fea..93cee17 100644
--- a/drivers/clk/hisilicon/reset.c
+++ b/drivers/clk/hisilicon/reset.c
@@ -90,14 +90,12 @@ static const struct reset_control_ops hisi_reset_ops = {
 struct hisi_reset_controller *hisi_reset_init(struct platform_device *pdev)
 {
 	struct hisi_reset_controller *rstc;
-	struct resource *res;
 
 	rstc = devm_kmalloc(&pdev->dev, sizeof(*rstc), GFP_KERNEL);
 	if (!rstc)
 		return NULL;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rstc->membase = devm_ioremap_resource(&pdev->dev, res);
+	rstc->membase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rstc->membase))
 		return NULL;
 
-- 
2.7.4


