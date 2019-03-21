Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2F9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD3A21916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ntvwk3rf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfCUWxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:53:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41514 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfCUWxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=A5xmKzo+3eYNNUc1oQhJ9CTFYQ7IubCceXEDOPqtJa8=; b=ntvwk3rfU/7cOzHhrbebJIAuOs
        B75r4Afik/Um3yWXh7dqXvkG6qs45ksusQ9yYM9SahlSGJ/J3ixd7O0ia1Me9xiqK7fJFrzOKJgRF
        bNQiD+d3hqh+RN7PUqFKg4q4CDFeAlgP+Zxh5+cep0bXThffOZS34ZJiCa6nQ8tiqU/8L25eoikM/
        K77kIZ9NFNy1KQg8XTtTqeM5oaXatdRZEIhwuPJQlACGjFpqrNiyqDDNnRf14B4fPUaT2osUWgiOI
        hkzNX6DzWrsETe5oGNPIeAmQ/ZwVn5qBg+R+GgCsuKPR1auhvVLvkzVvJhPfeOO5WHKrh7nhxThVT
        +yrDzgwQ==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76Yg-000801-QL; Thu, 21 Mar 2019 22:53:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] gbefb: switch to managed version of the DMA allocator
Date:   Thu, 21 Mar 2019 15:52:31 -0700
Message-Id: <20190321225235.30648-4-hch@lst.de>
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

gbefb uses managed resources, so it should do the same for DMA
allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/video/fbdev/gbefb.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
index 1a242b1338e9..3fcb33232ba3 100644
--- a/drivers/video/fbdev/gbefb.c
+++ b/drivers/video/fbdev/gbefb.c
@@ -1162,9 +1162,9 @@ static int gbefb_probe(struct platform_device *p_dev)
 	}
 	gbe_revision = gbe->ctrlstat & 15;
 
-	gbe_tiles.cpu =
-		dma_alloc_coherent(NULL, GBE_TLB_SIZE * sizeof(uint16_t),
-				   &gbe_tiles.dma, GFP_KERNEL);
+	gbe_tiles.cpu = dmam_alloc_coherent(&p_dev->dev,
+				GBE_TLB_SIZE * sizeof(uint16_t),
+				&gbe_tiles.dma, GFP_KERNEL);
 	if (!gbe_tiles.cpu) {
 		printk(KERN_ERR "gbefb: couldn't allocate tiles table\n");
 		ret = -ENOMEM;
@@ -1178,19 +1178,20 @@ static int gbefb_probe(struct platform_device *p_dev)
 		if (!gbe_mem) {
 			printk(KERN_ERR "gbefb: couldn't map framebuffer\n");
 			ret = -ENOMEM;
-			goto out_tiles_free;
+			goto out_release_mem_region;
 		}
 
 		gbe_dma_addr = 0;
 	} else {
 		/* try to allocate memory with the classical allocator
 		 * this has high chance to fail on low memory machines */
-		gbe_mem = dma_alloc_wc(NULL, gbe_mem_size, &gbe_dma_addr,
-				       GFP_KERNEL);
+		gbe_mem = dmam_alloc_attrs(&p_dev->dev, gbe_mem_size,
+				&gbe_dma_addr, GFP_KERNEL,
+				DMA_ATTR_WRITE_COMBINE);
 		if (!gbe_mem) {
 			printk(KERN_ERR "gbefb: couldn't allocate framebuffer memory\n");
 			ret = -ENOMEM;
-			goto out_tiles_free;
+			goto out_release_mem_region;
 		}
 
 		gbe_mem_phys = (unsigned long) gbe_dma_addr;
@@ -1237,11 +1238,6 @@ static int gbefb_probe(struct platform_device *p_dev)
 
 out_gbe_unmap:
 	arch_phys_wc_del(par->wc_cookie);
-	if (gbe_dma_addr)
-		dma_free_wc(NULL, gbe_mem_size, gbe_mem, gbe_mem_phys);
-out_tiles_free:
-	dma_free_coherent(NULL, GBE_TLB_SIZE * sizeof(uint16_t),
-			  (void *)gbe_tiles.cpu, gbe_tiles.dma);
 out_release_mem_region:
 	release_mem_region(GBE_BASE, sizeof(struct sgi_gbe));
 out_release_framebuffer:
@@ -1258,10 +1254,6 @@ static int gbefb_remove(struct platform_device* p_dev)
 	unregister_framebuffer(info);
 	gbe_turn_off();
 	arch_phys_wc_del(par->wc_cookie);
-	if (gbe_dma_addr)
-		dma_free_wc(NULL, gbe_mem_size, gbe_mem, gbe_mem_phys);
-	dma_free_coherent(NULL, GBE_TLB_SIZE * sizeof(uint16_t),
-			  (void *)gbe_tiles.cpu, gbe_tiles.dma);
 	release_mem_region(GBE_BASE, sizeof(struct sgi_gbe));
 	gbefb_remove_sysfs(&p_dev->dev);
 	framebuffer_release(info);
-- 
2.20.1

