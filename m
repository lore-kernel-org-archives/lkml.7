Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11250C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC7B216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HGip8iRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfK1QtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:49:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52366 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfK1QtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OKUh+j5PvFxuowonI6NCUIxvddU58kroCLY7Dyzz66s=; b=HGip8iRiBQPsB6NFPKRdGrYUBJ
        Jao40COIdH3hKYYyb1v+rUOG3z/plPJqR4iYO+j81i1H0wPrpcTVSxVXi27hROrbmp4IrTC+h3Nbw
        DWmJbtv5xRy7AZvQnvA+FgWRoTz6OJrYv+T5FomGQFs3hNZjx0RrJTqV8kzLqAZlgvXw10wwO6Vfu
        om3xSAdEgcM37A6g/FGgh09PGWBjQTL0eodM0trTA1jJQU+1LILU2th0vw0tOX4mF5ns6pvy/N0t2
        F0ekKDjQ5Qjyb1v3Lmkx9IlWfaizMlbByNkfWavwObfTNHWYms0viG983a8T/+yA2lcv94IdHV3Uc
        7+JybAOQ==;
Received: from [91.112.188.190] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iaMyY-0003Gu-En; Thu, 28 Nov 2019 16:49:06 +0000
Date:   Thu, 28 Nov 2019 17:49:04 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping updates for 5.5
Message-ID: <20191128164904.GA20771@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the dma-mapping updates for Linux 5.5.  Before the last commit
I had to pull in a branch from the arm64 tree (which has already been
merged in master) as we'd otherwise generate some horribly to resolve
merge conflicts as both changed the area in different ways.  Except for
that there should be not merge conflicts at all, which might be a first
for this tree.

The following changes since commit 320000e72ec0613e164ce9608d865396fb2da278:

  Merge tag 'iommu-fixes-v5.4-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu (2019-10-30 14:17:18 +0100)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.5

for you to fetch changes up to a7ba70f1787f977f970cd116076c6fce4b9e01cc:

  dma-mapping: treat dev->bus_dma_mask as a DMA limit (2019-11-21 18:14:35 +0100)

----------------------------------------------------------------
dma-mapping updates for 5.5-rc1

 - improve dma-debug scalability (Eric Dumazet)
 - tiny dma-debug cleanup (Dan Carpenter)
 - check for vmap memory in dma_map_single (Kees Cook)
 - check for dma_addr_t overflows in dma-direct when using
   DMA offsets (Nicolas Saenz Julienne)
 - switch the x86 sta2x11 SOC to use more generic DMA code
   (Nicolas Saenz Julienne)
 - fix arm-nommu dma-ranges handling (Vladimir Murzin)
 - use __initdata in CMA (Shyam Saini)
 - replace the bus dma mask with a limit (Nicolas Saenz Julienne)
 - merge the remapping helpers into the main dma-direct flow (me)
 - switch xtensa to the generic dma remap handling (me)
 - various cleanups around dma_capable (me)
 - remove unused dev arguments to various dma-noncoherent helpers (me)

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: Make arm64_dma32_phys_limit static

Christoph Hellwig (12):
      dma-direct: remove __dma_direct_free_pages
      dma-direct: remove the dma_handle argument to __dma_direct_alloc_pages
      dma-direct: provide mmap and get_sgtable method overrides
      dma-mapping: merge the generic remapping helpers into dma-direct
      xtensa: use the generic uncached segment support
      dma-mapping: drop the dev argument to arch_sync_dma_for_*
      dma-direct: unify the dma_capable definitions
      dma-direct: avoid a forward declaration for phys_to_dma
      powerpc: remove support for NULL dev in __phys_to_dma / __dma_to_phys
      dma-direct: don't check swiotlb=force in dma_direct_map_resource
      dma-direct: exclude dma_direct_map_resource from the min_low_pfn check
      Merge branch 'for-next/zone-dma' of git://git.kernel.org/.../arm64/linux into dma-mapping-for-next

Dan Carpenter (1):
      dma-debug: clean up put_hash_bucket()

Eric Dumazet (3):
      dma-debug: add a schedule point in debug_dma_dump_mappings()
      dma-debug: reorder struct dma_debug_entry fields
      dma-debug: increase HASH_SIZE

Kees Cook (2):
      dma-mapping: Add vmap checks to dma_map_single()
      usb: core: Remove redundant vmap checks

Nathan Chancellor (1):
      arm64: mm: Fix unused variable warning in zone_sizes_init

Nicolas Saenz Julienne (9):
      arm64: mm: use arm64_dma_phys_limit instead of calling max_zone_dma_phys()
      arm64: rename variables used to calculate ZONE_DMA32's size
      arm64: use both ZONE_DMA and ZONE_DMA32
      mm: refresh ZONE_DMA and ZONE_DMA32 comments in 'enum zone_type'
      dma/direct: turn ARCH_ZONE_DMA_BITS into a variable
      arm64: mm: reserve CMA and crashkernel in ZONE_DMA32
      dma-direct: check for overflows on 32 bit DMA addresses
      x86/PCI: sta2x11: use default DMA address translation
      dma-mapping: treat dev->bus_dma_mask as a DMA limit

Shyam Saini (1):
      kernel: dma-contiguous: mark CMA parameters __initdata/__initconst

Vladimir Murzin (1):
      dma-mapping: fix handling of dma-ranges for reserved memory (again)

 arch/arc/Kconfig                       |   1 -
 arch/arc/mm/dma.c                      |   8 +-
 arch/arm/Kconfig                       |   1 -
 arch/arm/include/asm/dma-direct.h      |  19 ----
 arch/arm/mm/dma-mapping-nommu.c        |   2 +-
 arch/arm/mm/dma-mapping.c              |  14 +--
 arch/arm/xen/mm.c                      |  12 +--
 arch/arm64/Kconfig                     |   5 +-
 arch/arm64/mm/dma-mapping.c            |   8 +-
 arch/arm64/mm/init.c                   |  77 +++++++++-----
 arch/c6x/mm/dma-coherent.c             |  14 +--
 arch/csky/mm/dma-mapping.c             |   8 +-
 arch/hexagon/kernel/dma.c              |   4 +-
 arch/ia64/Kconfig                      |   2 +-
 arch/ia64/kernel/dma-mapping.c         |   6 --
 arch/ia64/mm/init.c                    |   4 +-
 arch/m68k/kernel/dma.c                 |   4 +-
 arch/microblaze/Kconfig                |   1 -
 arch/microblaze/kernel/dma.c           |  14 +--
 arch/mips/Kconfig                      |   4 +-
 arch/mips/bmips/dma.c                  |   2 +-
 arch/mips/include/asm/dma-direct.h     |   8 --
 arch/mips/jazz/jazzdma.c               |  17 ++-
 arch/mips/mm/dma-noncoherent.c         |  18 ++--
 arch/mips/pci/fixup-sb1250.c           |  16 +--
 arch/nds32/kernel/dma.c                |   8 +-
 arch/nios2/mm/dma-mapping.c            |   8 +-
 arch/openrisc/kernel/dma.c             |   2 +-
 arch/parisc/kernel/pci-dma.c           |   8 +-
 arch/powerpc/include/asm/dma-direct.h  |  13 ---
 arch/powerpc/include/asm/page.h        |   9 --
 arch/powerpc/mm/dma-noncoherent.c      |   8 +-
 arch/powerpc/mm/mem.c                  |  20 +++-
 arch/powerpc/platforms/Kconfig.cputype |   1 -
 arch/powerpc/sysdev/fsl_pci.c          |   6 +-
 arch/s390/include/asm/page.h           |   2 -
 arch/s390/mm/init.c                    |   1 +
 arch/sh/kernel/dma-coherent.c          |   6 +-
 arch/sparc/kernel/ioport.c             |   4 +-
 arch/x86/Kconfig                       |   1 -
 arch/x86/include/asm/device.h          |   3 -
 arch/x86/include/asm/dma-direct.h      |   9 --
 arch/x86/kernel/amd_gart_64.c          |   4 +-
 arch/x86/kernel/pci-dma.c              |   2 +-
 arch/x86/mm/mem_encrypt.c              |   2 +-
 arch/x86/pci/sta2x11-fixup.c           | 135 +++++------------------
 arch/xtensa/Kconfig                    |   6 +-
 arch/xtensa/include/asm/platform.h     |  27 -----
 arch/xtensa/kernel/Makefile            |   3 +-
 arch/xtensa/kernel/pci-dma.c           | 129 +++-------------------
 drivers/acpi/arm64/iort.c              |  20 ++--
 drivers/ata/ahci.c                     |   2 +-
 drivers/iommu/dma-iommu.c              |  13 ++-
 drivers/of/device.c                    |   9 +-
 drivers/usb/core/hcd.c                 |   8 +-
 drivers/xen/swiotlb-xen.c              |  12 +--
 include/linux/device.h                 |   6 +-
 include/linux/dma-direct.h             |  37 +++++--
 include/linux/dma-mapping.h            |  10 +-
 include/linux/dma-noncoherent.h        |  22 ++--
 include/linux/mmzone.h                 |  45 ++++----
 include/xen/swiotlb-xen.h              |   8 +-
 kernel/dma/Kconfig                     |  12 ++-
 kernel/dma/coherent.c                  |  16 +--
 kernel/dma/contiguous.c                |   9 +-
 kernel/dma/debug.c                     |  39 ++++---
 kernel/dma/direct.c                    | 188 ++++++++++++++++++++++++---------
 kernel/dma/mapping.c                   |  45 ++------
 kernel/dma/remap.c                     |  55 ----------
 kernel/dma/swiotlb.c                   |   2 +-
 70 files changed, 509 insertions(+), 735 deletions(-)
 delete mode 100644 arch/x86/include/asm/dma-direct.h
