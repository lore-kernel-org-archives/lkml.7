Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795FFC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F4022DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfHTO7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:59:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:59750 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730216AbfHTO6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:58:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31A5AAFA5;
        Tue, 20 Aug 2019 14:58:38 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net,
        marc.zyngier@arm.com, robh+dt@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     phill@raspberryi.org, f.fainelli@gmail.com, will@kernel.org,
        nsaenzjulienne@suse.de, eric@anholt.net, mbrugger@suse.com,
        linux-rpi-kernel@lists.infradead.org, akpm@linux-foundation.org,
        frowand.list@gmail.com, m.szyprowski@samsung.com
Subject: [PATCH v2 07/11] arm64: re-introduce max_zone_dma_phys()
Date:   Tue, 20 Aug 2019 16:58:15 +0200
Message-Id: <20190820145821.27214-8-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820145821.27214-1-nsaenzjulienne@suse.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices might have multiple interconnects with different DMA
addressing limitations. This function provides the higher physical
address accessible by all peripherals on the SoC. If such limitation
doesn't exist it'll return the maximum physical address of the 32 bit
addressable area.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

Changes in v2:
- Update function's behavior to fit new dma zones split
- Use dma_zone_size
- Take into account devices with a hardcoded DMA offset

 arch/arm64/mm/init.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 8956c22634dd..bc7999020c71 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -174,6 +174,17 @@ static phys_addr_t __init max_zone_dma32_phys(void)
 	return min(offset + (1ULL << 32), memblock_end_of_DRAM());
 }
 
+static phys_addr_t __init max_zone_dma_phys(void)
+
+{
+	phys_addr_t offset = memblock_start_of_DRAM() & GENMASK_ULL(63, 32);
+
+	if (dma_zone_size)
+		return min(offset + dma_zone_size, memblock_end_of_DRAM());
+	else
+		return max_zone_dma32_phys();
+}
+
 #ifdef CONFIG_NUMA
 
 static void __init zone_sizes_init(unsigned long min, unsigned long max)
-- 
2.22.0

