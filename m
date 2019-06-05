Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876DAC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 10:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623C8206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 10:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfFEKG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 06:06:58 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:51559 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727014AbfFEKG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 06:06:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TTUHvuX_1559729202;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0TTUHvuX_1559729202)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Jun 2019 18:06:46 +0800
From:   Hui Zhu <teawaterz@linux.alibaba.com>
To:     ddstreet@ieee.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, sjenning@redhat.com,
        shakeelb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [PATCH V3 2/2] zswap: Use movable memory if zpool support allocate movable memory
Date:   Wed,  5 Jun 2019 18:06:30 +0800
Message-Id: <20190605100630.13293-2-teawaterz@linux.alibaba.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
In-Reply-To: <20190605100630.13293-1-teawaterz@linux.alibaba.com>
References: <20190605100630.13293-1-teawaterz@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third version that was updated according to the comments
from Sergey Senozhatsky https://lkml.org/lkml/2019/5/29/73 and
Shakeel Butt https://lkml.org/lkml/2019/6/4/973

zswap compresses swap pages into a dynamically allocated RAM-based
memory pool.  The memory pool should be zbud, z3fold or zsmalloc.
All of them will allocate unmovable pages.  It will increase the
number of unmovable page blocks that will bad for anti-fragment.

zsmalloc support page migration if request movable page:
        handle = zs_malloc(zram->mem_pool, comp_len,
                GFP_NOIO | __GFP_HIGHMEM |
                __GFP_MOVABLE);

And commit "zpool: Add malloc_support_movable to zpool_driver" add
zpool_malloc_support_movable check malloc_support_movable to make
sure if a zpool support allocate movable memory.

This commit let zswap allocate block with gfp
__GFP_HIGHMEM | __GFP_MOVABLE if zpool support allocate movable memory.

Following part is test log in a pc that has 8G memory and 2G swap.

Without this commit:
~# echo lz4 > /sys/module/zswap/parameters/compressor
~# echo zsmalloc > /sys/module/zswap/parameters/zpool
~# echo 1 > /sys/module/zswap/parameters/enabled
~# swapon /swapfile
~# cd /home/teawater/kernel/vm-scalability/
/home/teawater/kernel/vm-scalability# export unit_size=$((9 * 1024 * 1024 * 1024))
/home/teawater/kernel/vm-scalability# ./case-anon-w-seq
2717908992 bytes / 4826062 usecs = 549973 KB/s
2717908992 bytes / 4864201 usecs = 545661 KB/s
2717908992 bytes / 4867015 usecs = 545346 KB/s
2717908992 bytes / 4915485 usecs = 539968 KB/s
397853 usecs to free memory
357820 usecs to free memory
421333 usecs to free memory
420454 usecs to free memory
/home/teawater/kernel/vm-scalability# cat /proc/pagetypeinfo
Page block order: 9
Pages per block:  512

Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
Node    0, zone      DMA, type    Unmovable      1      1      1      0      2      1      1      0      1      0      0
Node    0, zone      DMA, type      Movable      0      0      0      0      0      0      0      0      0      1      3
Node    0, zone      DMA, type  Reclaimable      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone      DMA, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone      DMA, type          CMA      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone      DMA, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone    DMA32, type    Unmovable      6      5      8      6      6      5      4      1      1      1      0
Node    0, zone    DMA32, type      Movable     25     20     20     19     22     15     14     11     11      5    767
Node    0, zone    DMA32, type  Reclaimable      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone    DMA32, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone    DMA32, type          CMA      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone    DMA32, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone   Normal, type    Unmovable   4753   5588   5159   4613   3712   2520   1448    594    188     11      0
Node    0, zone   Normal, type      Movable     16      3    457   2648   2143   1435    860    459    223    224    296
Node    0, zone   Normal, type  Reclaimable      0      0     44     38     11      2      0      0      0      0      0
Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone   Normal, type          CMA      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone   Normal, type      Isolate      0      0      0      0      0      0      0      0      0      0      0

Number of blocks type     Unmovable      Movable  Reclaimable   HighAtomic          CMA      Isolate
Node 0, zone      DMA            1            7            0            0            0            0
Node 0, zone    DMA32            4         1652            0            0            0            0
Node 0, zone   Normal          931         1485           15            0            0            0

With this commit:
~# echo lz4 > /sys/module/zswap/parameters/compressor
~# echo zsmalloc > /sys/module/zswap/parameters/zpool
~# echo 1 > /sys/module/zswap/parameters/enabled
~# swapon /swapfile
~# cd /home/teawater/kernel/vm-scalability/
/home/teawater/kernel/vm-scalability# export unit_size=$((9 * 1024 * 1024 * 1024))
/home/teawater/kernel/vm-scalability# ./case-anon-w-seq
2717908992 bytes / 4689240 usecs = 566020 KB/s
2717908992 bytes / 4760605 usecs = 557535 KB/s
2717908992 bytes / 4803621 usecs = 552543 KB/s
2717908992 bytes / 5069828 usecs = 523530 KB/s
431546 usecs to free memory
383397 usecs to free memory
456454 usecs to free memory
224487 usecs to free memory
/home/teawater/kernel/vm-scalability# cat /proc/pagetypeinfo
Page block order: 9
Pages per block:  512

Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
Node    0, zone      DMA, type    Unmovable      1      1      1      0      2      1      1      0      1      0      0
Node    0, zone      DMA, type      Movable      0      0      0      0      0      0      0      0      0      1      3
Node    0, zone      DMA, type  Reclaimable      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone      DMA, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone      DMA, type          CMA      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone      DMA, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone    DMA32, type    Unmovable     10      8     10      9     10      4      3      2      3      0      0
Node    0, zone    DMA32, type      Movable     18     12     14     16     16     11      9      5      5      6    775
Node    0, zone    DMA32, type  Reclaimable      0      0      0      0      0      0      0      0      0      0      1
Node    0, zone    DMA32, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone    DMA32, type          CMA      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone    DMA32, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone   Normal, type    Unmovable   2669   1236    452    118     37     14      4      1      2      3      0
Node    0, zone   Normal, type      Movable   3850   6086   5274   4327   3510   2494   1520    934    438    220    470
Node    0, zone   Normal, type  Reclaimable     56     93    155    124     47     31     17      7      3      0      0
Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone   Normal, type          CMA      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone   Normal, type      Isolate      0      0      0      0      0      0      0      0      0      0      0

Number of blocks type     Unmovable      Movable  Reclaimable   HighAtomic          CMA      Isolate
Node 0, zone      DMA            1            7            0            0            0            0
Node 0, zone    DMA32            4         1650            2            0            0            0
Node 0, zone   Normal           79         2326           26            0            0            0

You can see that the number of unmovable page blocks is decreased
when the kernel has this commit.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 mm/zswap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index a4e4d36ec085..c6bf92bf5890 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1006,6 +1006,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	char *buf;
 	u8 *src, *dst;
 	struct zswap_header zhdr = { .swpentry = swp_entry(type, offset) };
+	gfp_t gfp;
 
 	/* THP isn't supported */
 	if (PageTransHuge(page)) {
@@ -1079,9 +1080,10 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 
 	/* store */
 	hlen = zpool_evictable(entry->pool->zpool) ? sizeof(zhdr) : 0;
-	ret = zpool_malloc(entry->pool->zpool, hlen + dlen,
-			   __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM,
-			   &handle);
+	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
+	if (zpool_malloc_support_movable(entry->pool->zpool))
+		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
+	ret = zpool_malloc(entry->pool->zpool, hlen + dlen, gfp, &handle);
 	if (ret == -ENOSPC) {
 		zswap_reject_compress_poor++;
 		goto put_dstmem;
-- 
2.21.0 (Apple Git-120)

