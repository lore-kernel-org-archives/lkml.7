Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB91C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638372075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbfC0VhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:37:20 -0400
Received: from ale.deltatee.com ([207.54.116.67]:58638 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfC0Vgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:36:49 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1h9GE3-0006DG-1s; Wed, 27 Mar 2019 15:36:47 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1h9GE1-0006CW-Pm; Wed, 27 Mar 2019 15:36:45 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 27 Mar 2019 15:36:36 -0600
Message-Id: <20190327213643.23789-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, sbates@raithlin.com, palmer@sifive.com, hch@lst.de, aou@eecs.berkeley.edu, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 0/7] RISC-V: Sparsmem, Memory Hotplug and pte_devmap for P2P
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset enables P2P on the RISC-V architecture. To do this on the
current kernel, we only need to be able to back IO memory with struct
pages using devm_memremap_pages(). This requires ARCH_HAS_ZONE_DEVICE,
ARCH_ENABLE_MEMORY_HOTPLUG, and ARCH_ENABLE_MEMORY_HOTREMOVE; which in
turn requires ARCH_SPARSEMEM_ENABLE. We also need to ensure that the
IO memory regions in hardware can be covered by the linear region
so that there is a linear relation ship between the virtual address and
the struct page address in the vmemmap region.

While our reason to do this work is for P2P, these features are all
useful, more generally, and also enable other kernel features.

The first patch in the series implements sparse mem. It was already
submitted and reviewed last cycle, only forgotten. It has been rebased
onto v5.1-rc2.

Patches 2 through 4 rework the architecture's virtual address space
mapping trying to get as much of the IO regions covered by the linear
mapping. With Sv39, we do not have enough address space to cover all the
typical hardware regions but we can get the majority of it.

Patch 5 and 6 implement memory hotplug and remove. These are relatively
straight forward additions similar to other arches.

Patch 7 implements pte_devmap which allows us to set
ARCH_HAS_ZONE_DEVICE.

The patchset was tested in QEMU and on a HiFive Unleashed board.
However, we were unable to actually test P2P transactions with this
exact set because we have been unable to get PCI working with v5.1-rc2.
We were able to get it running on a 4.19 era kernel (with a bunch of
out-of-tree patches for PCI on a Microsemi PolarFire board).

This series is based on v5.1-rc2 and a git tree is available here:

https://github.com/sbates130272/linux-p2pmem riscv-p2p-v1

Thanks,

Logan

--

Logan Gunthorpe (7):
  RISC-V: Implement sparsemem
  RISC-V: doc: Add file describing the virtual memory map
  RISC-V: Rework kernel's virtual address space mapping
  RISC-V: Update page tables to cover the whole linear mapping
  RISC-V: Implement memory hotplug
  RISC-V: Implement memory hot remove
  RISC-V: Implement pte_devmap()

 Documentation/riscv/mm.txt            |  24 +++
 arch/riscv/Kconfig                    |  32 +++-
 arch/riscv/include/asm/page.h         |   2 -
 arch/riscv/include/asm/pgtable-64.h   |   2 +
 arch/riscv/include/asm/pgtable-bits.h |   8 +-
 arch/riscv/include/asm/pgtable.h      |  45 ++++-
 arch/riscv/include/asm/sparsemem.h    |  11 ++
 arch/riscv/kernel/setup.c             |   1 -
 arch/riscv/mm/init.c                  | 251 ++++++++++++++++++++++++--
 9 files changed, 354 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/riscv/mm.txt
 create mode 100644 arch/riscv/include/asm/sparsemem.h

--
2.20.1
