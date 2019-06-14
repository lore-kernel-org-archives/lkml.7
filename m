Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70901C31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE3520665
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EW/OF1BD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfFNKVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:21:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54916 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbfFNKVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=G1EKyROpAQVEYGtm5ijQO3cKjBjFMreGSE5rh5ys5ng=; b=EW/OF1BDc7NqRaJ4XThECARCHp
        02oQWMr0930A918uYZftAfLmPDh6BT81/ISlK1O+dhZIFeL1nGmuGBTrwk7JNvP0TaEjg9O+3pOPW
        Ptzh70Ll7wr0p/2GTuccJ2QkG3EfKrm8ngqzhtDlqBBpqGRjzO5hBVcfZwHrUbJPTrf/zOaWHfIt/
        TKo11YxzmFETo9BNEK9aJWDFrBAxNcdk2hHKDDOnrKsAHe4HLxVk79T7GjoKXjhnjUYa1cQi/kIu1
        wgomWQX3OQdQ4RxxZ16BR+jaHpNEIRae5oRXIU4TSC0AQJSUXnJRa4mvgzBt9lfYUDI1gu+r2AMl6
        Itwfsitw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbjKw-0005Nu-1s; Fri, 14 Jun 2019 10:21:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] m68k: implement arch_dma_prep_coherent
Date:   Fri, 14 Jun 2019 12:21:26 +0200
Message-Id: <20190614102126.8402-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614102126.8402-1-hch@lst.de>
References: <20190614102126.8402-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we remap memory as non-cached to be used as a DMA coherent buffer
we should writeback all cache and invalidate the cache lines so that
we make sure we have a clean slate.  Implement this using the
cache_push() helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/Kconfig      | 1 +
 arch/m68k/kernel/dma.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 2571a8fba4b0..64b122595896 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -4,6 +4,7 @@ config M68K
 	default y
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_DMA_MMAP_PGPROT if MMU && !COLDFIRE
+	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index 9c6a350a16d8..e720e6eed838 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -18,6 +18,11 @@
 #include <asm/pgalloc.h>
 
 #if defined(CONFIG_MMU) && !defined(CONFIG_COLDFIRE)
+void arch_dma_prep_coherent(struct page *page, size_t size)
+{
+	cache_push(page_to_phys(page), size);
+}
+
 pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
 		unsigned long attrs)
 {
-- 
2.20.1

