Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E39AC74A54
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136E3216B7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qtcfa93P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfGKN5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 09:57:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfGKN5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 09:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0TdTTvv9gzZPCqHVN09rsHZfcgoPwm7Gi1QT/oQm0qY=; b=qtcfa93Pmpg0IzzyXiBu0TpI7g
        FlOPh39+Gsq5ONektm3WTqhDZYvBvRZat5iuAfWVWapUnx+gChRjB/4LL9cyKLBd4epmlFjmwzJEN
        su1bngdlgE9OINFndq1VKV/dHzZg5DBhqRaclSI4UXci8KQQ+dB1U8stEkDCuSnJvxB+BVoeY8v+F
        Wq/G5MnIWO/ZLLF90OzoOnzovyg0aqBX6zKxWHvP+xRJrrHtQArW3E5XIZYJjs+QswqPH41Gr4H3S
        1uZlSt25IhO+u8VtMrXnG87GY6LjnPKT5sWNzMDx8BGOXRw5W8WkopRoRWhNbFmvxqDR1XUsLXYO+
        6Qqs9yuQ==;
Received: from [38.98.37.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlZZD-0004uL-J9; Thu, 11 Jul 2019 13:57:00 +0000
Date:   Thu, 11 Jul 2019 15:56:54 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping updates for 5.3
Message-ID: <20190711135654.GA15312@infradead.org>
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

please pull the dma-mapping update below.  Note that the tree is based
on an branch from Joergs iommu tree that you have pulled earlier this
week.

There are a few of the usual Kconfig conflicts where different trees
touch the same area, but not the same symbols, just take the changes
from both tree in that case (none of them is in your tree yet as of
this time).

In addition there is a conflict in genalloc.h against mainline where
late patches in the 5.2 cycle added a new gen_pool_free_owner function
and made gen_pool_free a wrapper around it.  This tree adds new
helpers right next to it, the fix is again to take both changes
manually.  Bonous points for keeping all the alloc functions above
the free ones to keep the file ordering, unlike the default git
presentation.


The following changes since commit 1b961423158caaae49d3900b7c9c37477bbfa9b3:

  iommu/dma: Fix condition check in iommu_dma_unmap_sg (2019-06-03 12:14:51 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.3

for you to fetch changes up to 15ffe5e1acf5fe1512e98b20702e46ce9f25e2f7:

  dma-mapping: mark dma_alloc_need_uncached as __always_inline (2019-07-08 14:19:33 -0700)

----------------------------------------------------------------
dma-mapping updates for Linux 5.3

 - move the USB special case that bounced DMA through a device
   bar into the USB code instead of handling it in the common
   DMA code (Laurentiu Tudor and Fredrik Noring)
 - don't dip into the global CMA pool for single page allocations
   (Nicolin Chen)
 - fix a crash when allocating memory for the atomic pool failed
   during boot (Florian Fainelli)
 - move support for MIPS-style uncached segments to the common
   code and use that for MIPS and nios2 (me)
 - make support for DMA_ATTR_NON_CONSISTENT and
   DMA_ATTR_NO_KERNEL_MAPPING generic (me)
 - convert nds32 to the generic remapping allocator (me)

----------------------------------------------------------------
Christoph Hellwig (17):
      MIPS: remove the _dma_cache_wback_inv export
      au1100fb: fix DMA API abuse
      dma-direct: provide generic support for uncached kernel segments
      MIPS: use the generic uncached segment support in dma-direct
      dma-mapping: truncate dma masks to what dma_addr_t can hold
      ARM: dma-mapping: allow larger DMA mask than supported
      arm-nommu: remove the partial DMA_ATTR_NON_CONSISTENT support
      arc: remove the partial DMA_ATTR_NON_CONSISTENT support
      openrisc: remove the partial DMA_ATTR_NON_CONSISTENT support
      dma-mapping: add a dma_alloc_need_uncached helper
      dma-direct: handle DMA_ATTR_NON_CONSISTENT in common code
      dma-direct: handle DMA_ATTR_NO_KERNEL_MAPPING in common code
      arc: use the generic remapping allocator for coherent DMA allocations
      nds32: use the generic remapping allocator for coherent DMA allocations
      nios2: use the generic uncached segment support in dma-direct
      MIPS: only select ARCH_HAS_UNCACHED_SEGMENT for non-coherent platforms
      dma-mapping: mark dma_alloc_need_uncached as __always_inline

Florian Fainelli (1):
      dma-remap: Avoid de-referencing NULL atomic_pool

Fredrik Noring (3):
      lib/genalloc: add gen_pool_dma_zalloc() for zeroed DMA allocations
      lib/genalloc.c: Add algorithm, align and zeroed family of DMA allocators
      usb: host: Fix excessive alignment restriction for local memory allocations

Laurentiu Tudor (4):
      USB: use genalloc for USB HCs with local memory
      usb: host: ohci-sm501: init genalloc for local memory
      usb: host: ohci-tmio: init genalloc for local memory
      USB: drop HCD_LOCAL_MEM flag

Nicolin Chen (4):
      dma-contiguous: add dma_{alloc,free}_contiguous() helpers
      dma-contiguous: use fallback alloc_pages for single pages
      dma-contiguous: fix !CONFIG_DMA_CMA version of dma_{alloc, free}_contiguous()
      iommu/dma: Apply dma_{alloc,free}_contiguous functions

 arch/Kconfig                    |   8 +
 arch/arc/Kconfig                |   2 +
 arch/arc/mm/dma.c               |  71 ++-------
 arch/arm/mm/dma-mapping-nommu.c |  24 +--
 arch/arm/mm/dma-mapping.c       |  20 +--
 arch/mips/Kconfig               |   1 +
 arch/mips/include/asm/page.h    |   3 -
 arch/mips/jazz/jazzdma.c        |   6 -
 arch/mips/mm/cache.c            |   2 -
 arch/mips/mm/dma-noncoherent.c  |  26 ++--
 arch/nds32/Kconfig              |   2 +
 arch/nds32/kernel/dma.c         | 325 ++--------------------------------------
 arch/nios2/Kconfig              |   1 +
 arch/nios2/include/asm/page.h   |   6 -
 arch/nios2/mm/dma-mapping.c     |  34 ++---
 arch/openrisc/kernel/dma.c      |  22 ++-
 arch/parisc/kernel/pci-dma.c    |  48 ++----
 arch/xtensa/kernel/pci-dma.c    |   8 +-
 drivers/iommu/dma-iommu.c       |  14 +-
 drivers/usb/Kconfig             |   1 +
 drivers/usb/core/buffer.c       |  17 ++-
 drivers/usb/core/hcd.c          |  51 +++++--
 drivers/usb/host/ehci-hcd.c     |   2 +-
 drivers/usb/host/fotg210-hcd.c  |   2 +-
 drivers/usb/host/ohci-hcd.c     |  25 +++-
 drivers/usb/host/ohci-mem.c     |  37 ++++-
 drivers/usb/host/ohci-sm501.c   |  50 +++----
 drivers/usb/host/ohci-tmio.c    |  15 +-
 drivers/usb/host/ohci.h         |   2 +
 drivers/usb/host/uhci-hcd.c     |   2 +-
 drivers/video/fbdev/au1100fb.c  |  24 +--
 drivers/video/fbdev/au1100fb.h  |   1 +
 include/linux/dma-contiguous.h  |  19 +++
 include/linux/dma-noncoherent.h |  19 +++
 include/linux/genalloc.h        |   9 ++
 include/linux/usb/hcd.h         |   6 +-
 kernel/dma/contiguous.c         |  56 +++++++
 kernel/dma/direct.c             |  55 ++++---
 kernel/dma/mapping.c            |  12 ++
 kernel/dma/remap.c              |  16 +-
 lib/genalloc.c                  | 125 +++++++++++++++-
 41 files changed, 515 insertions(+), 654 deletions(-)
