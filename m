Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82F9C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3732072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FBjDPNTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfLQKm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:42:28 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49430 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfLQKm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:42:28 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHAgN2h079889;
        Tue, 17 Dec 2019 04:42:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576579343;
        bh=fDofURBq9Eb9DDOYst82dcthleb8beiEcdL2epzCLQg=;
        h=From:To:CC:Subject:Date;
        b=FBjDPNTif+F8tDWkOYsZPsriiNAnieZ69EQRm7zHCgAtcN1dPUrH8dIwdV0RFpOSx
         DE0JqI7O8iA5MgLBRkq3T8J0dxbg+Z9JilFH8dsJsbNQOTWsFHcHSM50DRRzruz5uv
         zluHZ6UFzdU9lF2zaS58yc6rnTupVwjEaibf79/Y=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBHAgN9g054058
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 04:42:23 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 04:42:23 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 04:42:22 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHAgKPU005635;
        Tue, 17 Dec 2019 04:42:20 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <mchehab@kernel.org>, <hyun.kwon@xilinx.com>,
        <laurent.pinchart@ideasonboard.com>
CC:     <vkoul@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] media: xilinx: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Tue, 17 Dec 2019 12:42:35 +0200
Message-ID: <20191217104235.23771-1-peter.ujfalusi@ti.com>
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
 drivers/media/platform/xilinx/xilinx-dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/xilinx/xilinx-dma.c b/drivers/media/platform/xilinx/xilinx-dma.c
index b211380a11f2..9ce515ff9c0a 100644
--- a/drivers/media/platform/xilinx/xilinx-dma.c
+++ b/drivers/media/platform/xilinx/xilinx-dma.c
@@ -725,10 +725,10 @@ int xvip_dma_init(struct xvip_composite_device *xdev, struct xvip_dma *dma,
 
 	/* ... and the DMA channel. */
 	snprintf(name, sizeof(name), "port%u", port);
-	dma->dma = dma_request_slave_channel(dma->xdev->dev, name);
-	if (dma->dma == NULL) {
+	dma->dma = dma_request_chan(dma->xdev->dev, name);
+	if (IS_ERR(dma->dma)) {
 		dev_err(dma->xdev->dev, "no VDMA channel found\n");
-		ret = -ENODEV;
+		ret = PTR_ERR(dma->dma);
 		goto error;
 	}
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

