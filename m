Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AD9C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91A720650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404202AbfJPJ0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:26:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4185 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389885AbfJPJ0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:26:32 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EF505E7907969BC478FD;
        Wed, 16 Oct 2019 17:26:29 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 16 Oct 2019
 17:26:20 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <eli.billauer@gmail.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] char: xillybus: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 16 Oct 2019 17:25:46 +0800
Message-ID: <20191016092546.26332-1-yuehaibing@huawei.com>
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
 drivers/char/xillybus/xillybus_of.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/char/xillybus/xillybus_of.c b/drivers/char/xillybus/xillybus_of.c
index bfafd8f..96b6de8 100644
--- a/drivers/char/xillybus/xillybus_of.c
+++ b/drivers/char/xillybus/xillybus_of.c
@@ -116,7 +116,6 @@ static int xilly_drv_probe(struct platform_device *op)
 	struct xilly_endpoint *endpoint;
 	int rc;
 	int irq;
-	struct resource *res;
 	struct xilly_endpoint_hardware *ephw = &of_hw;
 
 	if (of_property_read_bool(dev->of_node, "dma-coherent"))
@@ -129,9 +128,7 @@ static int xilly_drv_probe(struct platform_device *op)
 
 	dev_set_drvdata(dev, endpoint);
 
-	res = platform_get_resource(op, IORESOURCE_MEM, 0);
-	endpoint->registers = devm_ioremap_resource(dev, res);
-
+	endpoint->registers = devm_platform_ioremap_resource(op, 0);
 	if (IS_ERR(endpoint->registers))
 		return PTR_ERR(endpoint->registers);
 
-- 
2.7.4


