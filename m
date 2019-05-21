Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519B6C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325232173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfEUOIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:08:09 -0400
Received: from inva020.nxp.com ([92.121.34.13]:47298 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfEUOH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:07:58 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 91DF21A012D;
        Tue, 21 May 2019 16:07:56 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 853AB1A003B;
        Tue, 21 May 2019 16:07:56 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.13])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0547720612;
        Tue, 21 May 2019 16:07:55 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     hch@lst.de, stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de
Cc:     leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, noring@nocrew.org, JuergenUrban@gmx.de,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v5 4/5] usb: host: ohci-tmio: init genalloc for local memory
Date:   Tue, 21 May 2019 17:07:47 +0300
Message-Id: <20190521140748.20012-5-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521140748.20012-1-laurentiu.tudor@nxp.com>
References: <20190521140748.20012-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

In preparation for dropping the existing "coherent" dma mem declaration
APIs, replace the current dma_declare_coherent_memory() based mechanism
with the creation of a genalloc pool that will be used in the OHCI
subsystem as replacement for the DMA APIs.

For context, see thread here: https://lkml.org/lkml/2019/4/22/357

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/usb/host/ohci-tmio.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
index f88a0370659f..3b84ce0c3f29 100644
--- a/drivers/usb/host/ohci-tmio.c
+++ b/drivers/usb/host/ohci-tmio.c
@@ -224,11 +224,6 @@ static int ohci_hcd_tmio_drv_probe(struct platform_device *dev)
 		goto err_ioremap_regs;
 	}
 
-	ret = dma_declare_coherent_memory(&dev->dev, sram->start, sram->start,
-				resource_size(sram));
-	if (ret)
-		goto err_dma_declare;
-
 	if (cell->enable) {
 		ret = cell->enable(dev);
 		if (ret)
@@ -239,6 +234,11 @@ static int ohci_hcd_tmio_drv_probe(struct platform_device *dev)
 	ohci = hcd_to_ohci(hcd);
 	ohci_hcd_init(ohci);
 
+	ret = usb_hcd_setup_local_mem(hcd, sram->start, sram->start,
+				      resource_size(sram));
+	if (ret < 0)
+		goto err_enable;
+
 	ret = usb_add_hcd(hcd, irq, 0);
 	if (ret)
 		goto err_add_hcd;
@@ -254,8 +254,6 @@ static int ohci_hcd_tmio_drv_probe(struct platform_device *dev)
 	if (cell->disable)
 		cell->disable(dev);
 err_enable:
-	dma_release_declared_memory(&dev->dev);
-err_dma_declare:
 	iounmap(hcd->regs);
 err_ioremap_regs:
 	iounmap(tmio->ccr);
@@ -276,7 +274,6 @@ static int ohci_hcd_tmio_drv_remove(struct platform_device *dev)
 	tmio_stop_hc(dev);
 	if (cell->disable)
 		cell->disable(dev);
-	dma_release_declared_memory(&dev->dev);
 	iounmap(hcd->regs);
 	iounmap(tmio->ccr);
 	usb_put_hcd(hcd);
-- 
2.17.1

