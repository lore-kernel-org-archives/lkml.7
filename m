Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9549DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77702206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbfGaPsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:48:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:49972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727349AbfGaPsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:48:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D13F2AF9A;
        Wed, 31 Jul 2019 15:48:00 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
        marc.zyngier@arm.com, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org
Cc:     phill@raspberryi.org, f.fainelli@gmail.com, will@kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, eric@anholt.net,
        mbrugger@suse.com, nsaenzjulienne@suse.de,
        akpm@linux-foundation.org, frowand.list@gmail.com,
        m.szyprowski@samsung.com, linux-rpi-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/8] Raspberry Pi 4 DMA addressing support
Date:   Wed, 31 Jul 2019 17:47:43 +0200
Message-Id: <20190731154752.16557-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
this series attempts to address some issues we found while bringing up
the new Raspberry Pi 4 in arm64 and it's intended to serve as a follow
up of this discussion:
https://lkml.org/lkml/2019/7/17/476

The new Raspberry Pi 4 has up to 4GB of memory but most peripherals can
only address the first GB: their DMA address range is
0xc0000000-0xfc000000 which is aliased to the first GB of physical
memory 0x00000000-0x3c000000. Note that only some peripherals have these
limitations: the ARM cores, PCIe, V3D, GENET, and 40-bit DMA channels
have a wider view of the address space.

Part of this is solved in arm32 by setting up the machine specific
'.dma_zone_size = SZ_1G', which takes care of the allocating the
coherent memory area at the right spot. Yet no buffer bouncing (needed
for dma streaming) is available at the moment, but that's a story for
another series.

Unfortunately there is no such thing as '.dma_zone_size' in arm64 also
only ZONE_DMA32 is created which is interpreted by dma-direct and the
arm64 code as if all peripherals where be able to address the first 4GB
of memory.

In the light of this, the series implements the following changes:

- Add code that parses the device-tree in oder to find the SoC's common
  DMA area.

- Create a ZONE_DMA whenever that area is needed and add the rest of the
  lower 4 GB of memory to ZONE_DMA32*.

- Create the CMA area in a place suitable for all peripherals.

- Inform dma-direct of the new runtime calculated min_mask*.

That's all.

Regards,
Nicolas

* These solutions where already discussed on the previous RFC (see link
above).

---

Nicolas Saenz Julienne (8):
  arm64: mm: use arm64_dma_phys_limit instead of calling
    max_zone_dma_phys()
  arm64: rename variables used to calculate ZONE_DMA32's size
  of/fdt: add function to get the SoC wide DMA addressable memory size
  arm64: re-introduce max_zone_dma_phys()
  arm64: use ZONE_DMA on DMA addressing limited devices
  dma-direct: turn ARCH_ZONE_DMA_BITS into a variable
  arm64: update arch_zone_dma_bits to fine tune dma-direct min mask
  mm: comment arm64's usage of 'enum zone_type'

 arch/arm64/Kconfig              |  4 ++
 arch/arm64/mm/init.c            | 78 ++++++++++++++++++++++++++-------
 arch/powerpc/include/asm/page.h |  9 ----
 arch/powerpc/mm/mem.c           | 14 +++++-
 arch/s390/include/asm/page.h    |  2 -
 arch/s390/mm/init.c             |  1 +
 drivers/of/fdt.c                | 72 ++++++++++++++++++++++++++++++
 include/linux/dma-direct.h      |  2 +
 include/linux/mmzone.h          | 21 ++++-----
 include/linux/of_fdt.h          |  2 +
 kernel/dma/direct.c             |  8 ++--
 11 files changed, 168 insertions(+), 45 deletions(-)

-- 
2.22.0

