Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DE8C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C605020657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfFQNav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:30:51 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44647 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfFQNav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:30:51 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mnq8Y-1iQnn21uzS-00pKbB; Mon, 17 Jun 2019 15:29:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>, xen-devel@lists.xenproject.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] swiotlb: fix phys_addr_t overflow warning
Date:   Mon, 17 Jun 2019 15:28:43 +0200
Message-Id: <20190617132946.2817440-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WxAlzhRk05Boo+/YM4l5i3GHyI9GeBc8OiWCfJusR6LAoI1zMkq
 mI5T09W/WmD7J75VlpcbwtZqQ0SrDUbM08mliK9OyOpw5VGdZN1zx6lKdkmnejKI2IWefXV
 gD87Cuo+tKgxk+8DVFi5MULUIVmtKYjNbQ/mH9PLbLfMO/vz0NadJP8Sg5EQz6l4Rygh/yT
 LeEipTLCyl1mG60QYU9LA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pjHS7vU6GCo=:oYrDoKB2+KgIcpoaYs8GlG
 uTtBiYh+a9NRCMSK/VAmJBtr3OyY50oWkyFrAONPZtPHVNpiF2a8CHfvo5FAn9V1TMPmHj5jF
 NHxQxqMxS1V9M23uTBejYpfbDSjtIH/c0sAcPnkGEJkybimAEup6/oze7uWb2eQBnfEFQoWUQ
 aJy4HSSAKT+4gw0ktzsx3iM6TPn57cocJrG/3j5ZCD/oAdErbgrysiAhEeIY9GWvEVkvjDLUI
 ONy9C26roR2C6uw20//9hHKteelpqgKuxODx/J/UPtPgIMywqCsDLHqOreyPZIamuMa1y+w5G
 VfTKrnXuklvNm0PX7w7uJIDUmjaHUOra43Y5OxASS35FYFrpJFZvxfUiVc8eRpYhueBJoiqeA
 aAO7vgmS0K7aJcv4XsT7yAuXgRNjzO7c8G4uCtniGqhvkCj6f0V3UlfvkLvAEw1olB/EoBZGI
 3UqpKNY5rjoEdLlVgcSXpS2IAI4cwApvlzIwjAAoBu4rrtqwv/aK0yvzchZRHvCzAFXGe8bRe
 +bm04PWiu6yyPZ/yOlveC8euUHfYhoJOdzudhIanL205wpbYyqs+QeylkyGFUUOg3X6Qs5qsa
 RMJUfD0XDSpuNei092sg7J/xfBCHQmIWZmyPvHOtDnOWOGKcu2l7SMGW+i1PFzF9/LL4Vrn18
 3KHw4A+YxFrMfGY9xxypp+kyL9UCU3Vi3s/DYWqc7KuDLjYVMLmoUjW3hGoYprONHKuxNyhn/
 ltfrC74ikaZMsbUQaH/Ka2jk6kCcG4leKkdP+w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On architectures that have a larger dma_addr_t than phys_addr_t,
the swiotlb_tbl_map_single() function truncates its return code
in the failure path, making it impossible to identify the error
later, as we compare to the original value:

kernel/dma/swiotlb.c:551:9: error: implicit conversion from 'dma_addr_t' (aka 'unsigned long long') to 'phys_addr_t' (aka 'unsigned int') changes value from 18446744073709551615 to 4294967295 [-Werror,-Wconstant-conversion]
        return DMA_MAPPING_ERROR;

Use an explicit typecast here to convert it to the narrower type,
and use the same expression in the error handling later.

Fixes: b907e20508d0 ("swiotlb: remove SWIOTLB_MAP_ERROR")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I still think that reverting the original commit would have
provided clearer semantics for this corner case, but at least
this patch restores the correct behavior.
---
 drivers/xen/swiotlb-xen.c | 2 +-
 kernel/dma/swiotlb.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index d53f3493a6b9..cfbe46785a3b 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -402,7 +402,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 
 	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir,
 				     attrs);
-	if (map == DMA_MAPPING_ERROR)
+	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
 	dev_addr = xen_phys_to_bus(map);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e906ef2e6315..a3be651973ad 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -548,7 +548,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
 			 size, io_tlb_nslabs, tmp_io_tlb_used);
-	return DMA_MAPPING_ERROR;
+	return (phys_addr_t)DMA_MAPPING_ERROR;
 found:
 	io_tlb_used += nslots;
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
@@ -666,7 +666,7 @@ bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
 	/* Oh well, have to allocate and map a bounce buffer. */
 	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
 			*phys, size, dir, attrs);
-	if (*phys == DMA_MAPPING_ERROR)
+	if (*phys == (phys_addr_t)DMA_MAPPING_ERROR)
 		return false;
 
 	/* Ensure that the address returned is DMA'ble */
-- 
2.20.0

