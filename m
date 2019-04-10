Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2B1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A601217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X9gjDVNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfDJICz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:02:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51344 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfDJICw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jL0u+18HemMcx2+am6h8uPMUQVOHlWiofxUQnzpG0b0=; b=X9gjDVNQP/SsUy7Yrtozf7Hsy8
        5gTGxCah6PHW+xbrGmtdBb5kgafaszAHoXdqUUkwNpT/0Oz4cVvog04bx///zUcIy8GoxkpLYV0dI
        +0D7Xjba2B5qS5Y3u9klrOrJAkqWIm0h0oGGBZkXbQQuRkrIYUlFb9LXVyujSyr04j3/WYpipsmDF
        GSZBcL5P5/ExwRnhZV4oWzNTwa3iT75abbd/CNvOOQKesT83YT+iwc6Jp8whtKe9bzgY67SxjHWPw
        dT8SBLORmBjycQ2O1DC08/WviocihmcnQS72rICSQNde+0z18GfVFPXRuVXC0Q/YCg0SwOxkOiuY+
        uhpsgz0Q==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hE8C3-0007Xf-Hz; Wed, 10 Apr 2019 08:02:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/pci: Clean up usage of X86_DEV_DMA_OPS
Date:   Wed, 10 Apr 2019 10:02:20 +0200
Message-Id: <20190410080220.21705-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410080220.21705-1-hch@lst.de>
References: <20190410080220.21705-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have supported per-device dma_map_ops in generic code for a long
time, and this symbol just guards the inclusion of the dma_map_ops
registry used for vmd.  Stop enabling it for anything but vmd.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/Kconfig               | 3 ---
 drivers/misc/mic/Kconfig       | 4 ++--
 drivers/pci/controller/Kconfig | 1 +
 drivers/pci/controller/vmd.c   | 7 -------
 4 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 38c62ff8a3f0..d8e2e6519a61 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -28,7 +28,6 @@ config X86_64
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
 	select SWIOTLB
-	select X86_DEV_DMA_OPS
 	select ARCH_HAS_SYSCALL_WRAPPER
 
 #
@@ -703,7 +702,6 @@ config STA2X11
 	bool "STA2X11 Companion Chip Support"
 	depends on X86_32_NON_STANDARD && PCI
 	select ARCH_HAS_PHYS_TO_DMA
-	select X86_DEV_DMA_OPS
 	select SWIOTLB
 	select MFD_STA2X11
 	select GPIOLIB
@@ -2877,7 +2875,6 @@ config HAVE_ATOMIC_IOMAP
 
 config X86_DEV_DMA_OPS
 	bool
-	depends on X86_64 || STA2X11
 
 config HAVE_GENERIC_GUP
 	def_bool y
diff --git a/drivers/misc/mic/Kconfig b/drivers/misc/mic/Kconfig
index 242dcee14689..6736f72cc14a 100644
--- a/drivers/misc/mic/Kconfig
+++ b/drivers/misc/mic/Kconfig
@@ -4,7 +4,7 @@ comment "Intel MIC Bus Driver"
 
 config INTEL_MIC_BUS
 	tristate "Intel MIC Bus Driver"
-	depends on 64BIT && PCI && X86 && X86_DEV_DMA_OPS
+	depends on 64BIT && PCI && X86
 	help
 	  This option is selected by any driver which registers a
 	  device or driver on the MIC Bus, such as CONFIG_INTEL_MIC_HOST,
@@ -21,7 +21,7 @@ comment "SCIF Bus Driver"
 
 config SCIF_BUS
 	tristate "SCIF Bus Driver"
-	depends on 64BIT && PCI && X86 && X86_DEV_DMA_OPS
+	depends on 64BIT && PCI && X86
 	help
 	  This option is selected by any driver which registers a
 	  device or driver on the SCIF Bus, such as CONFIG_INTEL_MIC_HOST
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 6012f3059acd..011c57cae4b0 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -267,6 +267,7 @@ config PCIE_TANGO_SMP8759
 
 config VMD
 	depends on PCI_MSI && X86_64 && SRCU
+	select X86_DEV_DMA_OPS
 	tristate "Intel Volume Management Device Driver"
 	---help---
 	  Adds support for the Intel Volume Management Device (VMD). VMD is a
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index cf6816b55b5e..999a5509e57e 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -95,10 +95,8 @@ struct vmd_dev {
 	struct irq_domain	*irq_domain;
 	struct pci_bus		*bus;
 
-#ifdef CONFIG_X86_DEV_DMA_OPS
 	struct dma_map_ops	dma_ops;
 	struct dma_domain	dma_domain;
-#endif
 };
 
 static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
@@ -293,7 +291,6 @@ static struct msi_domain_info vmd_msi_domain_info = {
 	.chip		= &vmd_msi_controller,
 };
 
-#ifdef CONFIG_X86_DEV_DMA_OPS
 /*
  * VMD replaces the requester ID with its own.  DMA mappings for devices in a
  * VMD domain need to be mapped for the VMD, not the device requiring
@@ -438,10 +435,6 @@ static void vmd_setup_dma_ops(struct vmd_dev *vmd)
 	add_dma_domain(domain);
 }
 #undef ASSIGN_VMD_DMA_OPS
-#else
-static void vmd_teardown_dma_ops(struct vmd_dev *vmd) {}
-static void vmd_setup_dma_ops(struct vmd_dev *vmd) {}
-#endif
 
 static char __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
 				  unsigned int devfn, int reg, int len)
-- 
2.20.1

