Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA694C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C3A20727
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfKRJ0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:26:17 -0500
Received: from smtp2.axis.com ([195.60.68.18]:33902 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfKRJ0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 04:26:17 -0500
IronPort-SDR: /ZR5xX+73d/C8ro/l/i8tfrG/O4pT9ZCbVHflRFTpnylxq8+Qpgra+nV9eGfx1ngB/G5XziGfW
 +HcDcr3mGC5AwP3aDQLe3IE6pC+5SPJIqljZAymuL5qPdRWDxsJYfK2iuza5RBkvUwQM0jog6Q
 oj0/Bk42qrkA63XsowN8VcCTyFatGZhwP3Ro6O6+RvOcw99SEec6Vi9eRmVRRwUPTfYwkTSGdC
 Aqtwk9d7ETdnLJOaXRMasCWFNUeLgn058RHzk2qwwl2dtKQzxjOqkUN4S417VKPaVuLdtHg+F3
 ccU=
X-IronPort-AV: E=Sophos;i="5.68,319,1569276000"; 
   d="scan'208";a="2531062"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     linux@armlinux.org.uk, gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH] serial: pl011: Fix DMA ->flush_buffer()
Date:   Mon, 18 Nov 2019 10:25:47 +0100
Message-Id: <20191118092547.32135-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PL011's ->flush_buffer() implementation releases and reacquires the port
lock.  Due to a race condition here, data can end up being added to the
circular buffer but neither being discarded nor being sent out.  This
leads to, for example, tcdrain(2) waiting indefinitely.

Process A                       Process B

uart_flush_buffer()
 - acquire lock
 - circ_clear
 - pl011_flush_buffer()
 -- release lock
 -- dmaengine_terminate_all()

                                uart_write()
                                - acquire lock
                                - add chars to circ buffer
                                - start_tx()
                                -- start DMA
                                - release lock

 -- acquire lock
 -- turn off DMA
 -- release lock

                                // Data in circ buffer but DMA is off

According to the comment in the code, the releasing of the lock around
dmaengine_terminate_all() is to avoid a deadlock with the DMA engine
callback.  However, since the time this code was written, the DMA engine
API documentation seems to have been clarified to say that
dmaengine_terminate_all() (in the identically implemented but
differently named dmaengine_terminate_async() variant) does not wait for
any running complete callback to be completed and can even be called
from a complete callback.  So there is no possibility of deadlock if the
DMA engine driver implements this API correctly.

So we should be able to just remove this release and reacquire of the
lock to prevent the aforementioned race condition.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/tty/serial/amba-pl011.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 3a7d1a66f79c..b0b689546395 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -813,10 +813,8 @@ __acquires(&uap->port.lock)
 	if (!uap->using_tx_dma)
 		return;
 
-	/* Avoid deadlock with the DMA engine callback */
-	spin_unlock(&uap->port.lock);
-	dmaengine_terminate_all(uap->dmatx.chan);
-	spin_lock(&uap->port.lock);
+	dmaengine_terminate_async(uap->dmatx.chan);
+
 	if (uap->dmatx.queued) {
 		dma_unmap_sg(uap->dmatx.chan->device->dev, &uap->dmatx.sg, 1,
 			     DMA_TO_DEVICE);
-- 
2.20.0

