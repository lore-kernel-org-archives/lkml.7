Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74581C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4326C22CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LADrTaIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfICIqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:46:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34442 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbfICIqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=S41OOqXxO8zPAzI3PpNlItfxZvwx3OC+HSMNXC+BXd4=; b=LADrTaILYjCGBociB7xwvS3l3z
        9aQEf6LUDeSPx50ISGXOdKxmBQ2sfAI10cDPmt6uwKlRQN44oGB3M53gcTMWpHPgn9xDct+d0Gwaa
        sRH8t3AeVUHX+14+zLPIGOMR0SJTQmX/0DMhgUDJ2Si2YkUTylL7rDzSf8kdTRkECUGtx5TOklB2Z
        APuUvWW5wtESDG6ZoojrhXsBlRMEU+aYhOaxXTaiObjHFtjLOV5S9hTg7I3K2sB57HoMc40ej6W2i
        dctZDqMuEVFQUR+qJG2FKQRV7lhvCI0ex55Qpt41aRxur3FxpK+hFY/mQGS2rQ9gF4bmPSO3ygaAZ
        q3khfkYQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i54SM-0003sq-2e; Tue, 03 Sep 2019 08:46:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] usb: remove commented out dma wrappers
Date:   Tue,  3 Sep 2019 10:46:14 +0200
Message-Id: <20190903084615.19161-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903084615.19161-1-hch@lst.de>
References: <20190903084615.19161-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These wrappers have never seen use and have been commented out
for a long time.  Remove them for good.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/core/usb.c | 222 -----------------------------------------
 1 file changed, 222 deletions(-)

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 0ab8738047da..f16c26dc079d 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -933,228 +933,6 @@ void usb_free_coherent(struct usb_device *dev, size_t size, void *addr,
 }
 EXPORT_SYMBOL_GPL(usb_free_coherent);
 
-/**
- * usb_buffer_map - create DMA mapping(s) for an urb
- * @urb: urb whose transfer_buffer/setup_packet will be mapped
- *
- * URB_NO_TRANSFER_DMA_MAP is added to urb->transfer_flags if the operation
- * succeeds. If the device is connected to this system through a non-DMA
- * controller, this operation always succeeds.
- *
- * This call would normally be used for an urb which is reused, perhaps
- * as the target of a large periodic transfer, with usb_buffer_dmasync()
- * calls to synchronize memory and dma state.
- *
- * Reverse the effect of this call with usb_buffer_unmap().
- *
- * Return: Either %NULL (indicating no buffer could be mapped), or @urb.
- *
- */
-#if 0
-struct urb *usb_buffer_map(struct urb *urb)
-{
-	struct usb_bus		*bus;
-	struct device		*controller;
-
-	if (!urb
-			|| !urb->dev
-			|| !(bus = urb->dev->bus)
-			|| !(controller = bus->sysdev))
-		return NULL;
-
-	if (controller->dma_mask) {
-		urb->transfer_dma = dma_map_single(controller,
-			urb->transfer_buffer, urb->transfer_buffer_length,
-			usb_pipein(urb->pipe)
-				? DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	/* FIXME generic api broken like pci, can't report errors */
-	/* if (urb->transfer_dma == DMA_ADDR_INVALID) return 0; */
-	} else
-		urb->transfer_dma = ~0;
-	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
-	return urb;
-}
-EXPORT_SYMBOL_GPL(usb_buffer_map);
-#endif  /*  0  */
-
-/* XXX DISABLED, no users currently.  If you wish to re-enable this
- * XXX please determine whether the sync is to transfer ownership of
- * XXX the buffer from device to cpu or vice verse, and thusly use the
- * XXX appropriate _for_{cpu,device}() method.  -DaveM
- */
-#if 0
-
-/**
- * usb_buffer_dmasync - synchronize DMA and CPU view of buffer(s)
- * @urb: urb whose transfer_buffer/setup_packet will be synchronized
- */
-void usb_buffer_dmasync(struct urb *urb)
-{
-	struct usb_bus		*bus;
-	struct device		*controller;
-
-	if (!urb
-			|| !(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)
-			|| !urb->dev
-			|| !(bus = urb->dev->bus)
-			|| !(controller = bus->sysdev))
-		return;
-
-	if (controller->dma_mask) {
-		dma_sync_single_for_cpu(controller,
-			urb->transfer_dma, urb->transfer_buffer_length,
-			usb_pipein(urb->pipe)
-				? DMA_FROM_DEVICE : DMA_TO_DEVICE);
-		if (usb_pipecontrol(urb->pipe))
-			dma_sync_single_for_cpu(controller,
-					urb->setup_dma,
-					sizeof(struct usb_ctrlrequest),
-					DMA_TO_DEVICE);
-	}
-}
-EXPORT_SYMBOL_GPL(usb_buffer_dmasync);
-#endif
-
-/**
- * usb_buffer_unmap - free DMA mapping(s) for an urb
- * @urb: urb whose transfer_buffer will be unmapped
- *
- * Reverses the effect of usb_buffer_map().
- */
-#if 0
-void usb_buffer_unmap(struct urb *urb)
-{
-	struct usb_bus		*bus;
-	struct device		*controller;
-
-	if (!urb
-			|| !(urb->transfer_flags & URB_NO_TRANSFER_DMA_MAP)
-			|| !urb->dev
-			|| !(bus = urb->dev->bus)
-			|| !(controller = bus->sysdev))
-		return;
-
-	if (controller->dma_mask) {
-		dma_unmap_single(controller,
-			urb->transfer_dma, urb->transfer_buffer_length,
-			usb_pipein(urb->pipe)
-				? DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	}
-	urb->transfer_flags &= ~URB_NO_TRANSFER_DMA_MAP;
-}
-EXPORT_SYMBOL_GPL(usb_buffer_unmap);
-#endif  /*  0  */
-
-#if 0
-/**
- * usb_buffer_map_sg - create scatterlist DMA mapping(s) for an endpoint
- * @dev: device to which the scatterlist will be mapped
- * @is_in: mapping transfer direction
- * @sg: the scatterlist to map
- * @nents: the number of entries in the scatterlist
- *
- * Return: Either < 0 (indicating no buffers could be mapped), or the
- * number of DMA mapping array entries in the scatterlist.
- *
- * Note:
- * The caller is responsible for placing the resulting DMA addresses from
- * the scatterlist into URB transfer buffer pointers, and for setting the
- * URB_NO_TRANSFER_DMA_MAP transfer flag in each of those URBs.
- *
- * Top I/O rates come from queuing URBs, instead of waiting for each one
- * to complete before starting the next I/O.   This is particularly easy
- * to do with scatterlists.  Just allocate and submit one URB for each DMA
- * mapping entry returned, stopping on the first error or when all succeed.
- * Better yet, use the usb_sg_*() calls, which do that (and more) for you.
- *
- * This call would normally be used when translating scatterlist requests,
- * rather than usb_buffer_map(), since on some hardware (with IOMMUs) it
- * may be able to coalesce mappings for improved I/O efficiency.
- *
- * Reverse the effect of this call with usb_buffer_unmap_sg().
- */
-int usb_buffer_map_sg(const struct usb_device *dev, int is_in,
-		      struct scatterlist *sg, int nents)
-{
-	struct usb_bus		*bus;
-	struct device		*controller;
-
-	if (!dev
-			|| !(bus = dev->bus)
-			|| !(controller = bus->sysdev)
-			|| !controller->dma_mask)
-		return -EINVAL;
-
-	/* FIXME generic api broken like pci, can't report errors */
-	return dma_map_sg(controller, sg, nents,
-			is_in ? DMA_FROM_DEVICE : DMA_TO_DEVICE) ? : -ENOMEM;
-}
-EXPORT_SYMBOL_GPL(usb_buffer_map_sg);
-#endif
-
-/* XXX DISABLED, no users currently.  If you wish to re-enable this
- * XXX please determine whether the sync is to transfer ownership of
- * XXX the buffer from device to cpu or vice verse, and thusly use the
- * XXX appropriate _for_{cpu,device}() method.  -DaveM
- */
-#if 0
-
-/**
- * usb_buffer_dmasync_sg - synchronize DMA and CPU view of scatterlist buffer(s)
- * @dev: device to which the scatterlist will be mapped
- * @is_in: mapping transfer direction
- * @sg: the scatterlist to synchronize
- * @n_hw_ents: the positive return value from usb_buffer_map_sg
- *
- * Use this when you are re-using a scatterlist's data buffers for
- * another USB request.
- */
-void usb_buffer_dmasync_sg(const struct usb_device *dev, int is_in,
-			   struct scatterlist *sg, int n_hw_ents)
-{
-	struct usb_bus		*bus;
-	struct device		*controller;
-
-	if (!dev
-			|| !(bus = dev->bus)
-			|| !(controller = bus->sysdev)
-			|| !controller->dma_mask)
-		return;
-
-	dma_sync_sg_for_cpu(controller, sg, n_hw_ents,
-			    is_in ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
-}
-EXPORT_SYMBOL_GPL(usb_buffer_dmasync_sg);
-#endif
-
-#if 0
-/**
- * usb_buffer_unmap_sg - free DMA mapping(s) for a scatterlist
- * @dev: device to which the scatterlist will be mapped
- * @is_in: mapping transfer direction
- * @sg: the scatterlist to unmap
- * @n_hw_ents: the positive return value from usb_buffer_map_sg
- *
- * Reverses the effect of usb_buffer_map_sg().
- */
-void usb_buffer_unmap_sg(const struct usb_device *dev, int is_in,
-			 struct scatterlist *sg, int n_hw_ents)
-{
-	struct usb_bus		*bus;
-	struct device		*controller;
-
-	if (!dev
-			|| !(bus = dev->bus)
-			|| !(controller = bus->sysdev)
-			|| !controller->dma_mask)
-		return;
-
-	dma_unmap_sg(controller, sg, n_hw_ents,
-			is_in ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
-}
-EXPORT_SYMBOL_GPL(usb_buffer_unmap_sg);
-#endif
-
 /*
  * Notifications of device and interface registration
  */
-- 
2.20.1

