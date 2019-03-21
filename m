Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48F9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D63121916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B2eR77nN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfCUWx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:53:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCUWxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=it7hgDmLzWc1k/Yz2n7HKXPwU9eNC/NoGZJD3EXx09o=; b=B2eR77nNGty3Ns/sXLjhkZw9sj
        dSjGib2AAFYPoDeBJIDC5I9efGThXkaf722fN1UXGsyOLaId//CoBZJtir64aXnEBGbeFgMizv+W8
        jRydcAOEaQ+fr72qWJY7OV05Tf6jxCqEJpZ+E1KJLgy2BJ7IRf8DHVR0mRlZs237jlMxvMTRHMxq2
        6Gz2WxrBHfakfkNPWoJPvqEig1NRNOvOxqPFaQf2KuHbulolXn7xDwNwT0vg/w7R45s1UCSPjn6j/
        D9QbnCLcpJVbMys4lu2qwcoSaCrnssM3PaMnJGtQwxnBt5xxEfMmgBmXt1aFBDWQpSm4tDZMCEpPO
        QIfy32jA==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76Ym-00089R-Hw; Thu, 21 Mar 2019 22:53:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] pxa3xx-gcu: pass struct device to dma_mmap_coherent
Date:   Thu, 21 Mar 2019 15:52:32 -0700
Message-Id: <20190321225235.30648-5-hch@lst.de>
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

Just like we do for all other DMA operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/video/fbdev/pxa3xx-gcu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 69cfb337c857..047a2fa4b87e 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -96,6 +96,7 @@ struct pxa3xx_gcu_batch {
 };
 
 struct pxa3xx_gcu_priv {
+	struct device		 *dev;
 	void __iomem		 *mmio_base;
 	struct clk		 *clk;
 	struct pxa3xx_gcu_shared *shared;
@@ -493,7 +494,7 @@ pxa3xx_gcu_mmap(struct file *file, struct vm_area_struct *vma)
 		if (size != SHARED_SIZE)
 			return -EINVAL;
 
-		return dma_mmap_coherent(NULL, vma,
+		return dma_mmap_coherent(priv->dev, vma,
 			priv->shared, priv->shared_phys, size);
 
 	case SHARED_SIZE >> PAGE_SHIFT:
@@ -670,6 +671,7 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 	priv->resource_mem = r;
+	priv->dev = dev;
 	pxa3xx_gcu_reset(priv);
 	pxa3xx_gcu_init_debug_timer(priv);
 
-- 
2.20.1

