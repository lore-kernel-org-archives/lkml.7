Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF654C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF0A20811
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xR8dFHAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbfDXMhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:37:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50017 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDXMhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:37:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3OCbCHR2575778
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 24 Apr 2019 05:37:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3OCbCHR2575778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556109433;
        bh=OkKNE/23CUqLfyAj2OmYKOHd7LrveL5MdPSWTBhj6Lc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=xR8dFHAa9Uq0qURusvYxWskLVf3Ivaoywra1+4AP1DqFG6I3E+RfrpQHjkxHXr3PT
         TTEXlpS0GWlFh3WFPxCrrN++q8bKdRwe/4uAhIWtI6Lzm0iABPdQnc7jaIaVjJ9xWg
         KyJMfjMcz2ba+/+wUU1SfVRJd/iDtAYIZ/LUA1BAkBc0oeIXRyHEqnd2SH+uegwcPL
         kjDZxKdS64JnPBfz8d80PT68bUhnaFd8RQF1ZdsgMA9T6CxNtmHOdXYNRAR4DjsjmG
         mKoWP4X33K5Q9wD2uUDXuWL9rMjSJ516C2Y6sAul6kYcGQq4ZdQNJ+VLf/0/S3HZaY
         eJGvnWCREbIrg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3OCbCfM2575775;
        Wed, 24 Apr 2019 05:37:12 -0700
Date:   Wed, 24 Apr 2019 05:37:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-15854edd193ae5d9daf8f50ce5f9f1724cebe344@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, bhelgaas@google.com,
        bp@alien8.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, hch@lst.de, hpa@zytor.com,
        peterz@infradead.org
Reply-To: hpa@zytor.com, peterz@infradead.org, hch@lst.de,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          mingo@kernel.org, bhelgaas@google.com, tglx@linutronix.de,
          bp@alien8.de
In-Reply-To: <20190410080220.21705-3-hch@lst.de>
References: <20190410080220.21705-3-hch@lst.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/pci: Clean up usage of X86_DEV_DMA_OPS
Git-Commit-ID: 15854edd193ae5d9daf8f50ce5f9f1724cebe344
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  15854edd193ae5d9daf8f50ce5f9f1724cebe344
Gitweb:     https://git.kernel.org/tip/15854edd193ae5d9daf8f50ce5f9f1724cebe344
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Wed, 10 Apr 2019 10:02:20 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 24 Apr 2019 13:12:05 +0200

x86/pci: Clean up usage of X86_DEV_DMA_OPS

We have supported per-device dma_map_ops in generic code for a long
time, and this symbol just guards the inclusion of the dma_map_ops
registry used for vmd.  Stop enabling it for anything but vmd.

No change in functionality intended.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190410080220.21705-3-hch@lst.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig               | 3 ---
 drivers/misc/mic/Kconfig       | 4 ++--
 drivers/pci/controller/Kconfig | 1 +
 drivers/pci/controller/vmd.c   | 7 -------
 4 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7f93e013e6db..60f6459344bc 100644
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
@@ -2883,7 +2881,6 @@ config HAVE_ATOMIC_IOMAP
 
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
