Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3708CC17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E45B2196E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hJZjT9u0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfKMJf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 04:35:27 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56310 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfKMJfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:35:25 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAD9Z6mq061805;
        Wed, 13 Nov 2019 03:35:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573637706;
        bh=2QIKelmDaXX54OyPocUNCuVYJ6+os6iRrZK4Yb9LT3A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hJZjT9u0PRgW38yl6FFRtvC1klWTMZvOiLB457Ud6XeRuZGnTZ+leyldFSFCI/IOd
         BDsH7t0AKEc14CPo9vtdjzW7qdqU8VYo39gnXdGoLH5r7Y5jlSyjWE0D2dnK1wIhCc
         6EwuAQVLQQrfQkZoZNriXEqbzsObrjPhkhp+7s+w=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAD9Z6Dw073704
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Nov 2019 03:35:06 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 13
 Nov 2019 03:34:48 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 13 Nov 2019 03:34:48 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD9Z0hU086866;
        Wed, 13 Nov 2019 03:35:03 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <ulf.hansson@linaro.org>, <ludovic.desroches@microchip.com>
CC:     <vkoul@kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] mmc: atmel-mci: Use dma_request_chan() directly for channel request
Date:   Wed, 13 Nov 2019 11:36:15 +0200
Message-ID: <20191113093616.32474-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113093616.32474-1-peter.ujfalusi@ti.com>
References: <20191113093616.32474-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_request_slave_channel_reason() is:
#define dma_request_slave_channel_reason(dev, name) \
	dma_request_chan(dev, name)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mmc/host/atmel-mci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 34c992d87529..6f065bb5c55a 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2347,8 +2347,7 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
 
 static int atmci_configure_dma(struct atmel_mci *host)
 {
-	host->dma.chan = dma_request_slave_channel_reason(&host->pdev->dev,
-							"rxtx");
+	host->dma.chan = dma_request_chan(&host->pdev->dev, "rxtx");
 
 	if (PTR_ERR(host->dma.chan) == -ENODEV) {
 		struct mci_platform_data *pdata = host->pdev->dev.platform_data;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

