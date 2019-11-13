Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649CBC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343AB20818
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oTjqyiq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfKMJra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 04:47:30 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59152 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfKMJr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:47:29 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAD9lPO0084421;
        Wed, 13 Nov 2019 03:47:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573638445;
        bh=eGjBTMj+RQxCssIXFWDGuYzJCRzhhvflhoF8CYxUAQ0=;
        h=From:To:CC:Subject:Date;
        b=oTjqyiq0v57Z/KPHhuwD733ovHJPe9UNw9XADR40XKCNAfXNB4NtRs5CwatiJZVKD
         +85C078VzhYgrRvSkG9xl4buxJG5g4PqL/N9tQJOUtivLAHkxjU6cDfyuqGvbSqwwV
         n791WkyEVv0G1mMGXgG7Ngb9HWbzkDhKZOkvAyCw=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD9lPRg072648;
        Wed, 13 Nov 2019 03:47:25 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 13
 Nov 2019 03:47:07 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 13 Nov 2019 03:47:24 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAD9lMc8083574;
        Wed, 13 Nov 2019 03:47:23 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <gregkh@linuxfoundation.org>, <yoshihiro.shimoda.uh@renesas.com>
CC:     <vkoul@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: renesas_usbhs: Use dma_request_chan() directly for channel request
Date:   Wed, 13 Nov 2019 11:48:38 +0200
Message-ID: <20191113094838.2141-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
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
 drivers/usb/renesas_usbhs/fifo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index 86637cd066cf..01c6a48c41bc 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -1273,11 +1273,11 @@ static void usbhsf_dma_init_dt(struct device *dev, struct usbhs_fifo *fifo,
 	 */
 	snprintf(name, sizeof(name), "ch%d", channel);
 	if (channel & 1) {
-		fifo->tx_chan = dma_request_slave_channel_reason(dev, name);
+		fifo->tx_chan = dma_request_chan(dev, name);
 		if (IS_ERR(fifo->tx_chan))
 			fifo->tx_chan = NULL;
 	} else {
-		fifo->rx_chan = dma_request_slave_channel_reason(dev, name);
+		fifo->rx_chan = dma_request_chan(dev, name);
 		if (IS_ERR(fifo->rx_chan))
 			fifo->rx_chan = NULL;
 	}
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

