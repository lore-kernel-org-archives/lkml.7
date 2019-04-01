Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE9FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB4D20880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554142026;
	bh=LW/2QxVuGiHS6B6Kj6U25r0wcM1B1ocPE+i6bxYnHZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nHxRFGlHxroQ6o5RU0TML6QKbKxGb5w7mnZvP8/v/HGlBivb7Vsl+AoZ/jEmIT13C
	 b69MIzLFRS1ANmasgRzFYRgbOy1PBySWintPen8eflmFhuRgSk9hjN0p5yBJzJq8Q3
	 z7Ce34+2OPYj2yRWwedi1u9IEqMl4EI2YfT6xjSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbfDASHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:07:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:32928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730284AbfDARL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:11:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16F3C21925;
        Mon,  1 Apr 2019 17:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138716;
        bh=LW/2QxVuGiHS6B6Kj6U25r0wcM1B1ocPE+i6bxYnHZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hdD834FiXH6TyUVxH1veKY1R7KG7ZP+xcA3l2LhVVJIrUdzVkWzdFJi1nY7cOxQ6P
         dn5tOkDewUIzio799hJ67S5N7UBsIa3SfLcx2O8DSUM55SmwDFXpy2Mmmn7EvgTiuT
         Y3CYWy58KzHumyqk5w5DZUtInhQeEWK0G7JPSWWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Joerg Roedel <joro@8bytes.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Tomasz Figa <tfiga@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.0 127/146] iommu/io-pgtable-arm-v7s: request DMA32 memory, and improve debugging
Date:   Mon,  1 Apr 2019 19:02:19 +0200
Message-Id: <20190401170059.016458892@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Boichat <drinkcat@chromium.org>

commit 0a352554da69b02f75ca3389c885c741f1f63235 upstream.

IOMMUs using ARMv7 short-descriptor format require page tables (level 1
and 2) to be allocated within the first 4GB of RAM, even on 64-bit
systems.

For level 1/2 pages, ensure GFP_DMA32 is used if CONFIG_ZONE_DMA32 is
defined (e.g.  on arm64 platforms).

For level 2 pages, allocate a slab cache in SLAB_CACHE_DMA32.  Note that
we do not explicitly pass GFP_DMA[32] to kmem_cache_zalloc, as this is
not strictly necessary, and would cause a warning in mm/sl*b.c, as we
did not update GFP_SLAB_BUG_MASK.

Also, print an error when the physical address does not fit in
32-bit, to make debugging easier in the future.

Link: http://lkml.kernel.org/r/20181210011504.122604-3-drinkcat@chromium.org
Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Huaisheng Ye <yehs1@lenovo.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Tomasz Figa <tfiga@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc: Yong Wu <yong.wu@mediatek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/io-pgtable-arm-v7s.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -161,6 +161,14 @@
 
 #define ARM_V7S_TCR_PD1			BIT(5)
 
+#ifdef CONFIG_ZONE_DMA32
+#define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
+#define ARM_V7S_TABLE_SLAB_FLAGS SLAB_CACHE_DMA32
+#else
+#define ARM_V7S_TABLE_GFP_DMA GFP_DMA
+#define ARM_V7S_TABLE_SLAB_FLAGS SLAB_CACHE_DMA
+#endif
+
 typedef u32 arm_v7s_iopte;
 
 static bool selftest_running;
@@ -198,13 +206,16 @@ static void *__arm_v7s_alloc_table(int l
 	void *table = NULL;
 
 	if (lvl == 1)
-		table = (void *)__get_dma_pages(__GFP_ZERO, get_order(size));
+		table = (void *)__get_free_pages(
+			__GFP_ZERO | ARM_V7S_TABLE_GFP_DMA, get_order(size));
 	else if (lvl == 2)
-		table = kmem_cache_zalloc(data->l2_tables, gfp | GFP_DMA);
+		table = kmem_cache_zalloc(data->l2_tables, gfp);
 	phys = virt_to_phys(table);
-	if (phys != (arm_v7s_iopte)phys)
+	if (phys != (arm_v7s_iopte)phys) {
 		/* Doesn't fit in PTE */
+		dev_err(dev, "Page table does not fit in PTE: %pa", &phys);
 		goto out_free;
+	}
 	if (table && !(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA)) {
 		dma = dma_map_single(dev, table, size, DMA_TO_DEVICE);
 		if (dma_mapping_error(dev, dma))
@@ -733,7 +744,7 @@ static struct io_pgtable *arm_v7s_alloc_
 	data->l2_tables = kmem_cache_create("io-pgtable_armv7s_l2",
 					    ARM_V7S_TABLE_SIZE(2),
 					    ARM_V7S_TABLE_SIZE(2),
-					    SLAB_CACHE_DMA, NULL);
+					    ARM_V7S_TABLE_SLAB_FLAGS, NULL);
 	if (!data->l2_tables)
 		goto out_free_data;
 


