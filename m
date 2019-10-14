Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BEEC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F18E21848
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388788AbfJNSbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 14:31:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:42640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730828AbfJNSbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 14:31:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E5637BB6A;
        Mon, 14 Oct 2019 18:31:46 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Cc:     hch@infradead.org, mbrugger@suse.com, f.fainelli@gmail.com,
        wahrenst@gmx.net, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
Subject: [PATCH RFC 0/5] ARM: Raspberry Pi 4 DMA support
Date:   Mon, 14 Oct 2019 20:31:02 +0200
Message-Id: <20191014183108.24804-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
the Raspberry Pi 4 offers up to 4GB of memory, of which only the first
is DMA capable device wide. This forces us to use of bounce buffers,
which are currently not very well supported by ARM's custom DMA ops.
Among other things the current mechanism (see dmabounce.c) isn't
suitable for high memory. Instead of fixing it, this series introduces a
way of selecting dma-direct as the default DMA ops provider which allows
for the Raspberry Pi to make use of swiotlb.

Regards,
Nicolas

---

Nicolas Saenz Julienne (5):
  dma/direct: turn ARCH_ZONE_DMA_BITS into a variable
  ARM: introduce arm_dma_direct
  ARM: let machines select dma-direct over arch's DMA implementation
  dma/direct: check for overflows in ARM's dma_capable()
  ARM: bcm2711: use dma-direct

 arch/arm/include/asm/dma-direct.h  |  6 ++++++
 arch/arm/include/asm/dma-mapping.h |  3 ++-
 arch/arm/include/asm/dma.h         |  2 ++
 arch/arm/include/asm/mach/arch.h   |  1 +
 arch/arm/mach-bcm/Kconfig          |  1 +
 arch/arm/mach-bcm/bcm2711.c        |  1 +
 arch/arm/mm/dma-mapping.c          | 10 ++--------
 arch/arm/mm/init.c                 | 21 ++++++++++++++++++++-
 arch/arm64/include/asm/page.h      |  2 --
 arch/arm64/mm/init.c               |  9 +++++++--
 arch/powerpc/include/asm/page.h    |  9 ---------
 arch/powerpc/mm/mem.c              | 20 +++++++++++++++-----
 arch/s390/include/asm/page.h       |  2 --
 arch/s390/mm/init.c                |  1 +
 include/linux/dma-direct.h         |  2 ++
 kernel/dma/direct.c                | 13 ++++++-------
 16 files changed, 66 insertions(+), 37 deletions(-)

-- 
2.23.0

