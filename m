Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F917C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0478C2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557137639;
	bh=z/nJ06EXQuIc1mdH0HDPUPQbQrLigxfxK0m9o3UUmxE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=QnhNx2tS0t49K9tekcOV5NkiDemZD0safH/6+vR2lzFjtbaBZXfBFzwIFRGqEpFS9
	 Hq24cIESOZyZgzLUsiKW6p7lY2bpmys9EjfFC3i608lMV/f8l6jt7Npdmaha7Pq/5B
	 fmZYjussBrcsiy2P2JYEN9cHs5rs+qdshiVjgKC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfEFKN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:13:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37622 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfEFKN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:13:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id y5so14486334wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 03:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RZLr3Y0RumTN23W5BBiIG8v9sddFS2KQqG00uMKucYM=;
        b=mx5Gr4WNTUstBri8o0OCBwWxTpoXWPN7jDTD0c/YwuqwNacXqbMR5DLdkUAPkAWEXO
         Ar0pI4BTG8UaNgCXF4VFwG0H7XJyRBWKS7f6RdDZZMaCxZoBCko5f8riGQU9aoK4pDuv
         CqRm6GDBkf0E6RlOda9WmZtd3W6NreqamkO4YfP2Uz3HOQPBW0TkwefKPjgIaXZ1C85q
         UdT5hAhvDyaxEO2wiERaWzEVM91b947tSGjlAZIrJqTLcPQoO7GSiERi1uXS7hdd5dEl
         x6vlGc67koHuby29yDtA4qWpxaIQk7mDkIVhIaBEP327aF6OcDV3cJx18m8Wxl1W0zLq
         WCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=RZLr3Y0RumTN23W5BBiIG8v9sddFS2KQqG00uMKucYM=;
        b=gx3yGsv4pqc2jhbasvbK+5vuvuQetYp9Few4wnJXXI/dlQTqT9H9aS+8wUbOEtZbKf
         ExYQIHW6X9+ZyWeGmPN8jtV3pv7h43jc3TSkmcDkTc2WiYQ32wZSnm70Bjzj5PdaqefL
         DyzyqWEvVnsAqb0HRbIxwu04OoJEHU1yMiWa2UTcLPJFYvq9Px+l8xttPfwbisIoI+M0
         i+A2yKBLG3vYSSqvnmQ62wHlRKSL6nYR8A84IJx3a5uDlHTSJXBwalM5dnmr/sIvcKSA
         37ftu1toktusu/s7jN42vmBGH/0MGktP/hHpJqN4OJIwNhv6DfoBMs9DUnXQa1qP5GRr
         v/Pw==
X-Gm-Message-State: APjAAAX9Dz9tCso8bIeAvnTqxE2EOXGJMe8fTnkvZN6qHf+Z1RW2jOKg
        bB3gpIehvhUdRfmJr+OVCFk=
X-Google-Smtp-Source: APXvYqyWgkV5ULCMychB+H2H0FsGCnw159rt8mfCkr0V+SCGcoMw1JEOi9gELsGqYC/jgLv6x/LpGw==
X-Received: by 2002:a1c:be15:: with SMTP id o21mr3112420wmf.62.1557137634226;
        Mon, 06 May 2019 03:13:54 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r2sm9770501wmh.31.2019.05.06.03.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 03:13:53 -0700 (PDT)
Date:   Mon, 6 May 2019 12:13:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cleanups for v5.2
Message-ID: <20190506101351.GA122275@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-cleanups-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-for-linus

   # HEAD: 15854edd193ae5d9daf8f50ce5f9f1724cebe344 x86/pci: Clean up usage of X86_DEV_DMA_OPS

A handful of cleanups: dma-ops cleanups, missing boot time kcalloc() 
check, a Sparse fix and use struct_size() to simplify a vzalloc() call.


  out-of-topic modifications in x86-cleanups-for-linus:
  -------------------------------------------------------
  drivers/misc/mic/Kconfig           # 15854edd193a: x86/pci: Clean up usage of X
  drivers/pci/controller/Kconfig     # 15854edd193a: x86/pci: Clean up usage of X
  drivers/pci/controller/vmd.c       # 15854edd193a: x86/pci: Clean up usage of X

 Thanks,

	Ingo

------------------>
Christoph Hellwig (2):
      x86/Kconfig: Remove the unused X86_DMA_REMAP KConfig symbol
      x86/pci: Clean up usage of X86_DEV_DMA_OPS

Gustavo A. R. Silva (1):
      x86/kexec/crash: Use struct_size() in vzalloc()

Jann Horn (1):
      x86/mm/tlb: Define LOADED_MM_SWITCHING with pointer-sized number

Kangjie Lu (1):
      x86/platform/uv: Fix missing checks of kcalloc() return values


 arch/x86/Kconfig                | 8 --------
 arch/x86/include/asm/tlbflush.h | 2 +-
 arch/x86/kernel/crash.c         | 3 +--
 arch/x86/platform/uv/tlb_uv.c   | 7 ++++++-
 drivers/misc/mic/Kconfig        | 4 ++--
 drivers/pci/controller/Kconfig  | 1 +
 drivers/pci/controller/vmd.c    | 7 -------
 7 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c1f9b3cf437c..60f6459344bc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -28,7 +28,6 @@ config X86_64
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
 	select SWIOTLB
-	select X86_DEV_DMA_OPS
 	select ARCH_HAS_SYSCALL_WRAPPER
 
 #
@@ -703,8 +702,6 @@ config STA2X11
 	bool "STA2X11 Companion Chip Support"
 	depends on X86_32_NON_STANDARD && PCI
 	select ARCH_HAS_PHYS_TO_DMA
-	select X86_DEV_DMA_OPS
-	select X86_DMA_REMAP
 	select SWIOTLB
 	select MFD_STA2X11
 	select GPIOLIB
@@ -2884,11 +2881,6 @@ config HAVE_ATOMIC_IOMAP
 
 config X86_DEV_DMA_OPS
 	bool
-	depends on X86_64 || STA2X11
-
-config X86_DMA_REMAP
-	bool
-	depends on STA2X11
 
 config HAVE_GENERIC_GUP
 	def_bool y
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index f4204bf377fc..90926e8dd1f8 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -167,7 +167,7 @@ struct tlb_state {
 	 */
 	struct mm_struct *loaded_mm;
 
-#define LOADED_MM_SWITCHING ((struct mm_struct *)1)
+#define LOADED_MM_SWITCHING ((struct mm_struct *)1UL)
 
 	/* Last user mm for optimizing IBPB */
 	union {
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 17ffc869cab8..a96ca8584803 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -204,8 +204,7 @@ static struct crash_mem *fill_up_crash_elf_data(void)
 	 * another range split. So add extra two slots here.
 	 */
 	nr_ranges += 2;
-	cmem = vzalloc(sizeof(struct crash_mem) +
-			sizeof(struct crash_mem_range) * nr_ranges);
+	cmem = vzalloc(struct_size(cmem, ranges, nr_ranges));
 	if (!cmem)
 		return NULL;
 
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index 2c53b0f19329..1297e185b8c8 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -2133,14 +2133,19 @@ static int __init summarize_uvhub_sockets(int nuvhubs,
  */
 static int __init init_per_cpu(int nuvhubs, int base_part_pnode)
 {
-	unsigned char *uvhub_mask;
 	struct uvhub_desc *uvhub_descs;
+	unsigned char *uvhub_mask = NULL;
 
 	if (is_uv3_hub() || is_uv2_hub() || is_uv1_hub())
 		timeout_us = calculate_destination_timeout();
 
 	uvhub_descs = kcalloc(nuvhubs, sizeof(struct uvhub_desc), GFP_KERNEL);
+	if (!uvhub_descs)
+		goto fail;
+
 	uvhub_mask = kzalloc((nuvhubs+7)/8, GFP_KERNEL);
+	if (!uvhub_mask)
+		goto fail;
 
 	if (get_cpu_topology(base_part_pnode, uvhub_descs, uvhub_mask))
 		goto fail;
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
