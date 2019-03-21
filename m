Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C5CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6045A21916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m3Qh2Dgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfCUWxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:53:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40000 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfCUWxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pU0HGVd2mqMY96Sg+NjMcR2p0eV/+Kyy5J3jOlZeRfA=; b=m3Qh2DgtKUHbRBqWhI2F/vLKKN
        FfbGCgg9BYJNHKAxAyhNo/iz/NuMhgkC4PVMCVMW6FFs0KFZoQG4ZsyxbOn5bPE4QU9c2Aac1pESO
        pgB6zCbebubmEyYQxUNxyUOWB/9zm6owPKeMglPxF6fP+oHe9/svSgEUvfzA6TSEachHLk97KJbgS
        MdQQth6bJFrFTOzJRN4Cr5ZucDE/Nfu2fZ7tKR6DupZk2y/zkJsV8XgcD1mVznXBb4ZaDsyue2Tyb
        4+0GY3+0/4Dr3o2aX8TRL1k0PX4V2Zr5U21MhThs33MgyTcWTWvynjKhKteqx4NgvaklfwFQqXMub
        OQfirbCg==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76YV-0007lg-W0; Thu, 21 Mar 2019 22:53:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] parport_ip32: pass struct device to DMA API functions
Date:   Thu, 21 Mar 2019 15:52:29 -0700
Message-Id: <20190321225235.30648-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321225235.30648-1-hch@lst.de>
References: <20190321225235.30648-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA API generally relies on a struct device to work properly, and
only barely works without one for legacy reasons.  Pass the easily
available struct device from the platform_device to remedy this.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/parport/parport_ip32.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/parport/parport_ip32.c b/drivers/parport/parport_ip32.c
index 62873070f988..b7a892791c3e 100644
--- a/drivers/parport/parport_ip32.c
+++ b/drivers/parport/parport_ip32.c
@@ -568,6 +568,7 @@ static irqreturn_t parport_ip32_merr_interrupt(int irq, void *dev_id)
 
 /**
  * parport_ip32_dma_start - begins a DMA transfer
+ * @p:		partport to work on
  * @dir:	DMA direction: DMA_TO_DEVICE or DMA_FROM_DEVICE
  * @addr:	pointer to data buffer
  * @count:	buffer size
@@ -575,8 +576,8 @@ static irqreturn_t parport_ip32_merr_interrupt(int irq, void *dev_id)
  * Calls to parport_ip32_dma_start() and parport_ip32_dma_stop() must be
  * correctly balanced.
  */
-static int parport_ip32_dma_start(enum dma_data_direction dir,
-				  void *addr, size_t count)
+static int parport_ip32_dma_start(struct parport *p,
+		enum dma_data_direction dir, void *addr, size_t count)
 {
 	unsigned int limit;
 	u64 ctrl;
@@ -601,7 +602,7 @@ static int parport_ip32_dma_start(enum dma_data_direction dir,
 
 	/* Prepare DMA pointers */
 	parport_ip32_dma.dir = dir;
-	parport_ip32_dma.buf = dma_map_single(NULL, addr, count, dir);
+	parport_ip32_dma.buf = dma_map_single(&p->bus_dev, addr, count, dir);
 	parport_ip32_dma.len = count;
 	parport_ip32_dma.next = parport_ip32_dma.buf;
 	parport_ip32_dma.left = parport_ip32_dma.len;
@@ -625,11 +626,12 @@ static int parport_ip32_dma_start(enum dma_data_direction dir,
 
 /**
  * parport_ip32_dma_stop - ends a running DMA transfer
+ * @p:		partport to work on
  *
  * Calls to parport_ip32_dma_start() and parport_ip32_dma_stop() must be
  * correctly balanced.
  */
-static void parport_ip32_dma_stop(void)
+static void parport_ip32_dma_stop(struct parport *p)
 {
 	u64 ctx_a;
 	u64 ctx_b;
@@ -685,8 +687,8 @@ static void parport_ip32_dma_stop(void)
 	enable_irq(MACEISA_PAR_CTXB_IRQ);
 	parport_ip32_dma.irq_on = 1;
 
-	dma_unmap_single(NULL, parport_ip32_dma.buf, parport_ip32_dma.len,
-			 parport_ip32_dma.dir);
+	dma_unmap_single(&p->bus_dev, parport_ip32_dma.buf,
+			 parport_ip32_dma.len, parport_ip32_dma.dir);
 }
 
 /**
@@ -1445,7 +1447,7 @@ static size_t parport_ip32_fifo_write_block_dma(struct parport *p,
 
 	priv->irq_mode = PARPORT_IP32_IRQ_HERE;
 
-	parport_ip32_dma_start(DMA_TO_DEVICE, (void *)buf, len);
+	parport_ip32_dma_start(p, DMA_TO_DEVICE, (void *)buf, len);
 	reinit_completion(&priv->irq_complete);
 	parport_ip32_frob_econtrol(p, ECR_DMAEN | ECR_SERVINTR, ECR_DMAEN);
 
@@ -1461,7 +1463,7 @@ static size_t parport_ip32_fifo_write_block_dma(struct parport *p,
 		if (ecr & ECR_SERVINTR)
 			break;	/* DMA transfer just finished */
 	}
-	parport_ip32_dma_stop();
+	parport_ip32_dma_stop(p);
 	written = len - parport_ip32_dma_get_residue();
 
 	priv->irq_mode = PARPORT_IP32_IRQ_FWD;
-- 
2.20.1

