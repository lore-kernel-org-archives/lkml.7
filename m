Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D5FC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541EE2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfGQPbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 11:31:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:43448 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727803AbfGQPbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:31:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EB414B048;
        Wed, 17 Jul 2019 15:31:46 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, phil@raspberrypi.org,
        stefan.wahren@i2se.com, f.fainelli@gmail.com, mbrugger@suse.com,
        Jisheng.Zhang@synaptics.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [RFC 3/4] dma-direct: add dma_direct_min_mask
Date:   Wed, 17 Jul 2019 17:31:34 +0200
Message-Id: <20190717153135.15507-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190717153135.15507-1-nsaenzjulienne@suse.de>
References: <20190717153135.15507-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Historically devices with ZONE_DMA32 have been assumed to be able to
address at least the lower 4GB of ram for DMA. This is still the defualt
behavior yet the Raspberry Pi 4 is limited to the first GB of memory.
This has been observed to trigger failures in dma_direct_supported() as
the 'min_mask' isn't properly set.

We create 'dma_direct_min_mask' in order for the arch init code to be
able to fine-tune dma direct's 'min_dma' mask.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 kernel/dma/direct.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index b90e1aede743..3c8cd730648b 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -23,6 +23,8 @@
 #define ARCH_ZONE_DMA_BITS 24
 #endif
 
+u64 dma_direct_min_mask __ro_after_init = DMA_BIT_MASK(32);
+
 /*
  * For AMD SEV all DMA must be to unencrypted addresses.
  */
@@ -393,7 +395,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	if (IS_ENABLED(CONFIG_ZONE_DMA))
 		min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
 	else
-		min_mask = DMA_BIT_MASK(32);
+		min_mask = dma_direct_min_mask;
 
 	min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
 
-- 
2.22.0

