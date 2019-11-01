Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93380CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCA720656
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbfKALUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:20:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5681 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728901AbfKALUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:20:37 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ADFF87F0E42333B65E03;
        Fri,  1 Nov 2019 19:20:34 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Fri, 1 Nov 2019 19:20:24 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <jacmet@sunsite.dk>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <shubhrajyoti.datta@xilinx.com>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Mao Wenan <maowenan@huawei.com>
Subject: [PATCH -next] serial: uartlite: Missing uart_unregister_driver() on error in ulite_probe()
Date:   Fri, 1 Nov 2019 19:19:50 +0800
Message-ID: <20191101111950.47817-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If uart_register_driver(&ulite_uart_driver) is success,
but followed function is failed in ulite_probe, it needs to call
uart_unregister_driver to unregister.

Fixes: f33cf776617b ("serial-uartlite: Move the uart register")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 drivers/tty/serial/uartlite.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 06e79c1..2edae76 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -813,21 +813,29 @@ static int ulite_probe(struct platform_device *pdev)
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(struct uartlite_data),
 			     GFP_KERNEL);
-	if (!pdata)
+	if (!pdata) {
+		uart_unregister_driver(&ulite_uart_driver);
 		return -ENOMEM;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
+	if (!res) {
+		uart_unregister_driver(&ulite_uart_driver);
 		return -ENODEV;
+	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
+	if (irq <= 0) {
+		uart_unregister_driver(&ulite_uart_driver);
 		return -ENXIO;
+	}
 
 	pdata->clk = devm_clk_get(&pdev->dev, "s_axi_aclk");
 	if (IS_ERR(pdata->clk)) {
-		if (PTR_ERR(pdata->clk) != -ENOENT)
+		if (PTR_ERR(pdata->clk) != -ENOENT) {
+			uart_unregister_driver(&ulite_uart_driver);
 			return PTR_ERR(pdata->clk);
+		}
 
 		/*
 		 * Clock framework support is optional, continue on
@@ -840,6 +848,7 @@ static int ulite_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(pdata->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to prepare clock\n");
+		uart_unregister_driver(&ulite_uart_driver);
 		return ret;
 	}
 
-- 
2.7.4

