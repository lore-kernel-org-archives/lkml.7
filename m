Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE83EC2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C912067C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bsRuuoIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfLQHkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:40:14 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52202 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfLQHkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:40:14 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBH7e9rZ078256;
        Tue, 17 Dec 2019 01:40:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576568409;
        bh=uq4M6dCHylxyKFwJawgtPdUJOCVELJz3UBxlL6ZzTc4=;
        h=From:To:CC:Subject:Date;
        b=bsRuuoIlTAcTANxTUA93MNeEk6AlrLlacQuZUuuTdAuYflPCeCKQVuCJ2wx9h7/U5
         ZC8YzMvL9xdjrRFq+BssFMK3mHPrB4u6ZXnMlGEwJhyVuxRZDnGwilUyxRoLDaBWSC
         WC4i8K8wrVAnwB4DzS2vU9iY8YT79quJ3CDxpN+M=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBH7e9d4031094
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 01:40:09 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 01:40:06 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 01:40:06 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBH7e4t0093908;
        Tue, 17 Dec 2019 01:40:05 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <b.zolnierkie@samsung.com>, <axboe@kernel.dk>
CC:     <vkoul@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] powerpc/512x: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Tue, 17 Dec 2019 09:40:19 +0200
Message-ID: <20191217074019.21732-1-peter.ujfalusi@ti.com>
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
 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c b/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
index 13631f35cd14..04bf6ecf7d55 100644
--- a/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
+++ b/arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
@@ -434,9 +434,9 @@ static int mpc512x_lpbfifo_probe(struct platform_device *pdev)
 	memset(&lpbfifo, 0, sizeof(struct lpbfifo_data));
 	spin_lock_init(&lpbfifo.lock);
 
-	lpbfifo.chan = dma_request_slave_channel(&pdev->dev, "rx-tx");
-	if (lpbfifo.chan == NULL)
-		return -EPROBE_DEFER;
+	lpbfifo.chan = dma_request_chan(&pdev->dev, "rx-tx");
+	if (IS_ERR(lpbfifo.chan))
+		return PTR_ERR(lpbfifo.chan);
 
 	if (of_address_to_resource(pdev->dev.of_node, 0, &r) != 0) {
 		dev_err(&pdev->dev, "bad 'reg' in 'sclpc' device tree node\n");
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

