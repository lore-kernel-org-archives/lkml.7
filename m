Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49309C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1622121916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sd8x6YVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfCUWxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:53:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42866 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfCUWx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wNIVp/3PbkEedkhIB8pmA67cLys6VfkT7RY7LY2wi3M=; b=Sd8x6YVC79e9T1/vEsh+EUZ5lK
        kQYtPjS9UCpEhQZ+r7wu4m5eKMRrfFDp/fkdOVcDKrBKctlulMmYpKdkHEygsKhag29a4uuIP9fwS
        EEszP0t9jtTDbzRZa7ceV8tqbM4TcuDPqeDJJkXviFCAx2SOuUDxgiCxjMptf7POlaJUFWSV5DkqQ
        8A4iFtLEtM6NoC1sUbU4TTd1qCSOYoYfxtVZqdOqJ9JZT2MdXEywuZRvzj30A9+o/Ziw4tWqcVKc9
        IzoHXuqgYtdfqQkz7tm+LylrarNSDJH2UEdDtmWVif4zcpYolOcY8qgO89mZE7oXQKpcCzQ9CdklR
        HMdRClcA==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h76Ys-0008Ia-8B; Thu, 21 Mar 2019 22:53:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] arm: use a dummy struct device for ISA DMA use of the DMA API
Date:   Thu, 21 Mar 2019 15:52:33 -0700
Message-Id: <20190321225235.30648-6-hch@lst.de>
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

This gets rid of the last NULL dev argument passed to the DMA API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/kernel/dma-isa.c | 8 +++++++-
 arch/arm/mach-rpc/dma.c   | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/dma-isa.c b/arch/arm/kernel/dma-isa.c
index 84363fe7bad2..10c45cc6b957 100644
--- a/arch/arm/kernel/dma-isa.c
+++ b/arch/arm/kernel/dma-isa.c
@@ -55,6 +55,12 @@ static int isa_get_dma_residue(unsigned int chan, dma_t *dma)
 	return chan < 4 ? count : (count << 1);
 }
 
+static struct device isa_dma_dev = {
+	.init_name		= "fallback device",
+	.coherent_dma_mask	= ~(dma_addr_t)0,
+	.dma_mask		= &isa_dma_dev.coherent_dma_mask,
+};
+
 static void isa_enable_dma(unsigned int chan, dma_t *dma)
 {
 	if (dma->invalid) {
@@ -89,7 +95,7 @@ static void isa_enable_dma(unsigned int chan, dma_t *dma)
 			dma->sg = &dma->buf;
 			dma->sgcount = 1;
 			dma->buf.length = dma->count;
-			dma->buf.dma_address = dma_map_single(NULL,
+			dma->buf.dma_address = dma_map_single(&isa_dma_dev,
 				dma->addr, dma->count,
 				direction);
 		}
diff --git a/arch/arm/mach-rpc/dma.c b/arch/arm/mach-rpc/dma.c
index fb48f3141fb4..f2703ca17954 100644
--- a/arch/arm/mach-rpc/dma.c
+++ b/arch/arm/mach-rpc/dma.c
@@ -151,6 +151,12 @@ static void iomd_free_dma(unsigned int chan, dma_t *dma)
 	free_irq(idma->irq, idma);
 }
 
+static struct device isa_dma_dev = {
+	.init_name		= "fallback device",
+	.coherent_dma_mask	= ~(dma_addr_t)0,
+	.dma_mask		= &isa_dma_dev.coherent_dma_mask,
+};
+
 static void iomd_enable_dma(unsigned int chan, dma_t *dma)
 {
 	struct iomd_dma *idma = container_of(dma, struct iomd_dma, dma);
@@ -168,7 +174,7 @@ static void iomd_enable_dma(unsigned int chan, dma_t *dma)
 			idma->dma.sg = &idma->dma.buf;
 			idma->dma.sgcount = 1;
 			idma->dma.buf.length = idma->dma.count;
-			idma->dma.buf.dma_address = dma_map_single(NULL,
+			idma->dma.buf.dma_address = dma_map_single(&isa_dma_dev,
 				idma->dma.addr, idma->dma.count,
 				idma->dma.dma_mode == DMA_MODE_READ ?
 				DMA_FROM_DEVICE : DMA_TO_DEVICE);
-- 
2.20.1

