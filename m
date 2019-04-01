Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C1CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA362084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDAKPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:15:20 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41882 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfDAKPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:15:20 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A6FB81A00AD;
        Mon,  1 Apr 2019 12:15:18 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9A3661A001C;
        Mon,  1 Apr 2019 12:15:18 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.74.120])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 16FB420618;
        Mon,  1 Apr 2019 12:15:18 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     u.kleine-koenig@pengutronix.de, mojha@codeaurora.org,
        linux-i2c@vger.kernel.org, wsa+renesas@sang-engineering.com
Cc:     linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        leoyang.li@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2] i2c: imx: don't leak the i2c adapter on error
Date:   Mon,  1 Apr 2019 13:14:37 +0300
Message-Id: <20190401101437.9626-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Make sure to free the i2c adapter on the error exit path.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Reviewed-by: Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Fixes: e1ab9a468e3b ("i2c: imx: improve the error handling in i2c_imx_dma_request()")
---
Changes in v2:
 - fixed formatting glitch

 drivers/i2c/busses/i2c-imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 42fed40198a0..c0c3043b5d61 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1169,11 +1169,13 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	/* Init DMA config if supported */
 	ret = i2c_imx_dma_request(i2c_imx, phy_addr);
 	if (ret < 0)
-		goto clk_notifier_unregister;
+		goto del_adapter;
 
 	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
 	return 0;   /* Return OK */
 
+del_adapter:
+	i2c_del_adapter(&i2c_imx->adapter);
 clk_notifier_unregister:
 	clk_notifier_unregister(i2c_imx->clk, &i2c_imx->clk_change_nb);
 rpm_disable:
-- 
2.17.1

