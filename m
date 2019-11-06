Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145DDC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EE92173B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbfKFKAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 05:00:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:51538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731734AbfKFKAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 05:00:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E23FB475;
        Wed,  6 Nov 2019 10:00:02 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Qian Cai <cai@lca.pw>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] arm64: mm: reserve CMA and crashkernel in ZONE_DMA32
Date:   Wed,  6 Nov 2019 10:59:45 +0100
Message-Id: <20191106095945.22933-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106095945.22933-1-nsaenzjulienne@suse.de>
References: <20191106095945.22933-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of ZONE_DMA in arm64 we moved the default CMA and
crashkernel reservation into that area. This caused a regression on big
machines that need big CMA and crashkernel reservations. Note that
ZONE_DMA is only 1GB big.

Restore the previous behavior as the wide majority of devices are OK
with reserving these in ZONE_DMA32. The ones that need them in ZONE_DMA
will configure it explicitly.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm64/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 580d1052ac34..8385d3c0733f 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -88,7 +88,7 @@ static void __init reserve_crashkernel(void)
 
 	if (crash_base == 0) {
 		/* Current arm64 boot protocol requires 2MB alignment */
-		crash_base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
+		crash_base = memblock_find_in_range(0, arm64_dma32_phys_limit,
 				crash_size, SZ_2M);
 		if (crash_base == 0) {
 			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
@@ -454,7 +454,7 @@ void __init arm64_memblock_init(void)
 
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 
-	dma_contiguous_reserve(arm64_dma_phys_limit ? : arm64_dma32_phys_limit);
+	dma_contiguous_reserve(arm64_dma32_phys_limit);
 }
 
 void __init bootmem_init(void)
-- 
2.23.0

