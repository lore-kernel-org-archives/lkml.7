Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0BAC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F89221850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfDEMka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:40:30 -0400
Received: from smtp.asem.it ([151.1.184.197]:56361 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfDEMka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:40:30 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003794723.MSG 
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 14:40:25 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Fri, 5
 Apr 2019 14:40:24 +0200
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1261.35 via Frontend
 Transport; Fri, 5 Apr 2019 14:40:24 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 1/1] spi: pxa2xxx: change "no DMA channels..." msg from debug to warning
Date:   Fri, 5 Apr 2019 14:40:22 +0200
Message-ID: <1554468022-17416-1-git-send-email-f.suligoi@asem.it>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A0B0210.5CA74CB9.000D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the type of the diagnostic message:

"no DMA channels available, using PIO"

from debug to warning.

The lack of an available DMA channel is very important regard the
spi-pxa2xx performance. The transfer speed can be reduced more than 50%.

So it is very important to warn the user about this, without enabling
the full SPI debug with CONFIG_SPI_DEBUG.

Moreover, enabling the full SPI debug only to enable this specific
debug message, the dmesg buffer fills quickly with a lot of
repetitive information during the SPI data transfer.
This cause the loss of all the first important messages
written during the initialization.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/spi/spi-pxa2xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6160fe0..f7068cc 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1696,7 +1696,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	if (platform_info->enable_dma) {
 		status = pxa2xx_spi_dma_setup(drv_data);
 		if (status) {
-			dev_dbg(dev, "no DMA channels available, using PIO\n");
+			dev_warn(dev, "no DMA channels available, using PIO\n");
 			platform_info->enable_dma = false;
 		} else {
 			controller->can_dma = pxa2xx_spi_can_dma;
-- 
2.7.4

