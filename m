Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64C3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8310420830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfDJJrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:47:16 -0400
Received: from smtp.asem.it ([151.1.184.197]:60385 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729737AbfDJJrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:47:16 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003803861.MSG 
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 11:47:11 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Wed, 10
 Apr 2019 11:47:10 +0200
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1261.35 via Frontend
 Transport; Wed, 10 Apr 2019 11:47:10 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <f.suligoi@asem.it>
Subject: [PATCH v2 1/1] spi: pxa2xx: add driver enabling message
Date:   Wed, 10 Apr 2019 11:47:04 +0200
Message-ID: <1554889624-25000-1-git-send-email-f.suligoi@asem.it>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <358f26bc47bd4aa289971f0a763b27cb@asem.it>
References: <358f26bc47bd4aa289971f0a763b27cb@asem.it>
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: hardfail smtp.helo=webmail.asem.it (does not match 172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A0B0201.5CADBB9E.0077,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an info message for the PXA2xx device driver start-up,
with the indication of:

- mode (slave device or master controller)
- transfer mode (DMA or GPIO)

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---

v1:	- first version
v2:	- remove warning message "no DMA channels available, using PIO"
	- add "slave device"/"master controller" indication message

 drivers/spi/spi-pxa2xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index f7068cc..b9e04e2 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1696,7 +1696,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	if (platform_info->enable_dma) {
 		status = pxa2xx_spi_dma_setup(drv_data);
 		if (status) {
-			dev_warn(dev, "no DMA channels available, using PIO\n");
 			platform_info->enable_dma = false;
 		} else {
 			controller->can_dma = pxa2xx_spi_can_dma;
@@ -1818,6 +1817,10 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
+	dev_info(dev, "PXA2xx SPI %s (%s mode)\n",
+		platform_info->is_slave ? "slave device" : "master controller",
+		platform_info->enable_dma ? "DMA" : "PIO");
+
 	/* Register with the SPI framework */
 	platform_set_drvdata(pdev, drv_data);
 	status = devm_spi_register_controller(&pdev->dev, controller);
-- 
2.7.4

