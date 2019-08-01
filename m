Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5DAC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC14214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbfHAIyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 04:54:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50582 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730482AbfHAIyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:54:12 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 941681A02C1;
        Thu,  1 Aug 2019 10:54:10 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 839C71A02D9;
        Thu,  1 Aug 2019 10:54:07 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5D57E402D7;
        Thu,  1 Aug 2019 16:54:03 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] gpio: mxc: Use devm_clk_get_optional instead of devm_clk_get
Date:   Thu,  1 Aug 2019 16:44:39 +0800
Message-Id: <20190801084439.36487-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

i.MX SoC's GPIO clock is optional, so it is better to use
devm_clk_get_optional instead of devm_clk_get.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/gpio/gpio-mxc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index b281358..7907a87 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -435,12 +435,9 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 		return port->irq;
 
 	/* the controller clock is optional */
-	port->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(port->clk)) {
-		if (PTR_ERR(port->clk) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		port->clk = NULL;
-	}
+	port->clk = devm_clk_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(port->clk))
+		return PTR_ERR(port->clk);
 
 	err = clk_prepare_enable(port->clk);
 	if (err) {
-- 
2.7.4

