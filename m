Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C97FC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D7F2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dLt0JBQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfLQKum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:50:42 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:32930 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfLQKum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:50:42 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHAoZOM117616;
        Tue, 17 Dec 2019 04:50:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576579835;
        bh=mNFMFcC05t4v52oPlhk2o6wWbxZw16JxfddIxoRlzLQ=;
        h=From:To:CC:Subject:Date;
        b=dLt0JBQrhwTctsIJomqlhk94hZBf00U4vfjLrTkD2hZT8dsDOVeg5n1KzqkJwVgV2
         BPZLhIo+WrCvly5FIBFBUWTwvAqEn74fVeNclog2EnbqRqO6wADZ6OtvWCO2zr2e+T
         ktWFro6uHeTo4jG8HYhswGbspp24AOOdInn4EVF4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBHAoZTm065630
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 04:50:35 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 04:50:35 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 04:50:35 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHAoX3N044630;
        Tue, 17 Dec 2019 04:50:33 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vireshk@kernel.org>, <b.zolnierkie@samsung.com>, <axboe@kernel.dk>
CC:     <vkoul@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ata: pata_arasam_cf: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Tue, 17 Dec 2019 12:50:48 +0200
Message-ID: <20191217105048.25327-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

By using dma_request_chan() directly the driver can support deferred
probing against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/ata/pata_arasan_cf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 135173c8d138..69b555d83f68 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -526,9 +526,10 @@ static void data_xfer(struct work_struct *work)
 
 	/* request dma channels */
 	/* dma_request_channel may sleep, so calling from process context */
-	acdev->dma_chan = dma_request_slave_channel(acdev->host->dev, "data");
-	if (!acdev->dma_chan) {
+	acdev->dma_chan = dma_request_chan(acdev->host->dev, "data");
+	if (IS_ERR(acdev->dma_chan)) {
 		dev_err(acdev->host->dev, "Unable to get dma_chan\n");
+		acdev->dma_chan = NULL;
 		goto chan_request_fail;
 	}
 
@@ -539,6 +540,7 @@ static void data_xfer(struct work_struct *work)
 	}
 
 	dma_release_channel(acdev->dma_chan);
+	acdev->dma_chan = NULL;
 
 	/* data xferred successfully */
 	if (!ret) {
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

