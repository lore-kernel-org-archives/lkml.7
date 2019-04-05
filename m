Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF8DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39D521738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbfDEJme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:42:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44744 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730243AbfDEJme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:42:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 767C8168F;
        Fri,  5 Apr 2019 02:42:33 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8156F3F721;
        Fri,  5 Apr 2019 02:42:31 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v3 1/3] iommu: io-pgtable: Add ARM Mali midgard MMU page
 table format
To:     Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org
Cc:     Sean Paul <sean@poorly.run>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        iommu@lists.linux-foundation.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-2-robh@kernel.org>
Message-ID: <4ab58561-17e8-364c-a315-e55955ffdd49@arm.com>
Date:   Fri, 5 Apr 2019 10:42:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190401074730.12241-2-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First let me say congratulations to everyone working on Panfrost - it's
an impressive achievement!

Full disclosure: I used to work on the Mali kbase driver. And have been
playing around with running the Mali user-space blob with the Panfrost
kernel driver.

On 01/04/2019 08:47, Rob Herring wrote:
> ARM Mali midgard GPU is similar to standard 64-bit stage 1 page tables, but
> have a few differences. Add a new format type to represent the format. The
> input address size is 48-bits and the output address size is 40-bits (and
> possibly less?). Note that the later bifrost GPUs follow the standard
> 64-bit stage 1 format.
> 
> The differences in the format compared to 64-bit stage 1 format are:
> 
> The 3rd level page entry bits are 0x1 instead of 0x3 for page entries.
> 
> The access flags are not read-only and unprivileged, but read and write.
> This is similar to stage 2 entries, but the memory attributes field matches
> stage 1 being an index.
> 
> The nG bit is not set by the vendor driver. This one didn't seem to matter,
> but we'll keep it aligned to the vendor driver.

The nG bit should be ignored by the hardware.

The MMU in Midgard/Bifrost has a quirk similar to
IO_PGTABLE_QUIRK_TLBI_ON_MAP - you must perform a cache flush for the
GPU to (reliably) pick up new page table mappings.

You may not have seen this because of the use of the JS_CONFIG_START_MMU
bit - this effectively performs a cache flush and TLB invalidate before
starting a job, however when using a GPU like T760 (e.g. on the Firefly
RK3288) this bit isn't being set. In my testing on the Firefly board I
saw GPU page faults because of this.

There's two options for fixing this - a patch like below adds the quirk
mode to the MMU. Or alternatively always set JS_CONFIG_START_MMU on
jobs. In my testing both options solve the page faults.

To be honest I don't know the reasoning behind kbase making the
JS_CONFIG_START_MMU bit conditional - I'm not aware of any reason why it
can't always be set. My guess is performance, but I haven't benchmarked
the difference between this and JS_CONFIG_START_MMU.

-----8<----------
From e3f75c7f04e43238dfc579029b8c11fb6b4a0c18 Mon Sep 17 00:00:00 2001
From: Steven Price <steven.price@arm.com>
Date: Thu, 4 Apr 2019 15:53:17 +0100
Subject: [PATCH] iommu: io-pgtable: IO_PGTABLE_QUIRK_TLBI_ON_MAP for LPAE

Midgard/Bifrost GPUs require a TLB invalidation when mapping pages,
implement IO_PGTABLE_QUIRK_TLBI_ON_MAP for LPAE iommu page table
formats and add the quirk bit to Panfrost.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c |  1 +
 drivers/iommu/io-pgtable-arm.c          | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c
b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index f3aad8591cf4..094312074d66 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -343,6 +343,7 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
 	mmu_write(pfdev, MMU_INT_MASK, ~0);

 	pfdev->mmu->pgtbl_cfg = (struct io_pgtable_cfg) {
+		.quirks		= IO_PGTABLE_QUIRK_TLBI_ON_MAP,
 		.pgsize_bitmap	= SZ_4K, // | SZ_2M | SZ_1G),
 		.ias		= 48,
 		.oas		= 40,	/* Should come from dma mask? */
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 84beea1f47a7..45fd7bbdf9aa 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -505,7 +505,13 @@ static int arm_lpae_map(struct io_pgtable_ops *ops,
unsigned long iova,
 	 * Synchronise all PTE updates for the new mapping before there's
 	 * a chance for anything to kick off a table walk for the new iova.
 	 */
-	wmb();
+	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_TLBI_ON_MAP) {
+		io_pgtable_tlb_add_flush(&data->iop, iova, size,
+					 ARM_LPAE_BLOCK_SIZE(2, data), false);
+		io_pgtable_tlb_sync(&data->iop);
+	} else {
+		wmb();
+	}

 	return ret;
 }
@@ -800,7 +806,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg
*cfg, void *cookie)
 	struct arm_lpae_io_pgtable *data;

 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS | IO_PGTABLE_QUIRK_NO_DMA |
-			    IO_PGTABLE_QUIRK_NON_STRICT))
+			    IO_PGTABLE_QUIRK_NON_STRICT |
+			    IO_PGTABLE_QUIRK_TLBI_ON_MAP))
 		return NULL;

 	data = arm_lpae_alloc_pgtable(cfg);
-- 
2.20.1

