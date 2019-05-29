Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD17C04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E916D2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfE2BWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 21:22:54 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:11864 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbfE2BWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 21:22:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TSv6CYB_1559092963;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0TSv6CYB_1559092963)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 May 2019 09:22:50 +0800
From:   Hui Zhu <teawaterz@linux.alibaba.com>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [UPSTREAM KERNEL] mm/zsmalloc.c: Add module parameter malloc_force_movable
Date:   Wed, 29 May 2019 09:22:30 +0800
Message-Id: <20190529012230.89042-1-teawaterz@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zswap compresses swap pages into a dynamically allocated RAM-based
memory pool.  The memory pool should be zbud, z3fold or zsmalloc.
All of them will allocate unmovable pages.  It will increase the
number of unmovable page blocks that will bad for anti-fragment.

zsmalloc support page migration if request movable page:
        handle = zs_malloc(zram->mem_pool, comp_len,
                GFP_NOIO | __GFP_HIGHMEM |
                __GFP_MOVABLE);

This commit adds module parameter malloc_force_movable to enable
or disable zs_malloc force allocate block with gfp
__GFP_HIGHMEM | __GFP_MOVABLE (disabled by default).

Following part is test log in a pc that has 8G memory and 2G swap.

When it disabled:
~# echo lz4 > /sys/module/zswap/parameters/compressor
~# echo zsmalloc > /sys/module/zswap/parameters/zpool
~# echo 1 > /sys/module/zswap/parameters/enabled
~# swapon /swapfile
~# cd /home/teawater/kernel/vm-scalability/
/home/teawater/kernel/vm-scalability# export unit_size=$((9 * 1024 * 1024 * 1024))
/home/teawater/kernel/vm-scalability# ./case-anon-w-seq
2717908992 bytes / 4410183 usecs = 601836 KB/s
2717908992 bytes / 4524375 usecs = 586646 KB/s
2717908992 bytes / 4558583 usecs = 582244 KB/s
2717908992 bytes / 4824261 usecs = 550179 KB/s
348046 usecs to free memory
401680 usecs to free memory
369660 usecs to free memory
180867 usecs to free memory
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
Node    0, zone    DMA32, type    Unmovable     13     11     10     11     10      6      7      3      1      0      0
Node    0, zone    DMA32, type      Movable     36     26     39     40     37     36     24     29     14      6    767
Node    0, zone    DMA32, type  Reclaimable      0      0      0      0      0      0      0      0      0      0      1
Node    0, zone    DMA32, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone    DMA32, type          CMA      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone    DMA32, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone   Normal, type    Unmovable   7744   7519   6900   5964   4583   2878   1346    448    146      1      0
Node    0, zone   Normal, type      Movable    645   1930   1685   1339   1020    670    363    210    106    310    399
Node    0, zone   Normal, type  Reclaimable     53     70    116     48     13      0      0      0      0      0      0
Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone   Normal, type          CMA      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone   Normal, type      Isolate      0      0      0      0      0      0      0      0      0      0      0

Number of blocks type     Unmovable      Movable  Reclaimable   HighAtomic          CMA      Isolate
Node 0, zone      DMA            1            7            0            0            0            0
Node 0, zone    DMA32            4         1650            2            0            0            0
Node 0, zone   Normal          947         1469           15            0            0            0

When it enabled:
~# echo 1 > /sys/module/zsmalloc/parameters/malloc_force_movable
~# echo lz4 > /sys/module/zswap/parameters/compressor
~# echo zsmalloc > /sys/module/zswap/parameters/zpool
~# echo 1 > /sys/module/zswap/parameters/enabled
~# swapon /swapfile
~# cd /home/teawater/kernel/vm-scalability/
/home/teawater/kernel/vm-scalability# export unit_size=$((9 * 1024 * 1024 * 1024))
/home/teawater/kernel/vm-scalability# ./case-anon-w-seq
2717908992 bytes / 4779235 usecs = 555362 KB/s
2717908992 bytes / 4856673 usecs = 546507 KB/s
2717908992 bytes / 4920079 usecs = 539464 KB/s
2717908992 bytes / 4935505 usecs = 537778 KB/s
354839 usecs to free memory
368167 usecs to free memory
355460 usecs to free memory
385452 usecs to free memory
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
Node    0, zone    DMA32, type    Unmovable      9     15     13     10     13      9      3      2      2      0      0
Node    0, zone    DMA32, type      Movable     16     19     10     14     17     17     16      8      5      6    775
Node    0, zone    DMA32, type  Reclaimable      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone    DMA32, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone    DMA32, type          CMA      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone    DMA32, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone   Normal, type    Unmovable   2525   1347    603    181     55     14      4      1      6      0      0
Node    0, zone   Normal, type      Movable   5255   6069   5007   3978   2885   1940   1164    732    485    276    511
Node    0, zone   Normal, type  Reclaimable    103    104    140     87     31     21      7      3      2      1      1
Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone   Normal, type          CMA      0      0      0      0      0      0      0      0      0      0      0
Node    0, zone   Normal, type      Isolate      0      0      0      0      0      0      0      0      0      0      0

Number of blocks type     Unmovable      Movable  Reclaimable   HighAtomic          CMA      Isolate
Node 0, zone      DMA            1            7            0            0            0            0
Node 0, zone    DMA32            4         1652            0            0            0            0
Node 0, zone   Normal           78         2330           23            0            0            0

You can see that the number of unmovable page blocks is decreased
when malloc_force_movable is enabled.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 mm/zsmalloc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 0787d33b80d8..7d44c7ccd882 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -178,6 +178,13 @@ static struct dentry *zs_stat_root;
 static struct vfsmount *zsmalloc_mnt;
 #endif
 
+/* Enable/disable zs_malloc force allocate block with
+ *  gfp __GFP_HIGHMEM | __GFP_MOVABLE (disabled by default).
+ */
+static bool __read_mostly zs_malloc_force_movable;
+module_param_cb(malloc_force_movable, &param_ops_bool,
+		&zs_malloc_force_movable, 0644);
+
 /*
  * We assign a page to ZS_ALMOST_EMPTY fullness group when:
  *	n <= N / f, where
@@ -1479,6 +1486,9 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	if (unlikely(!size || size > ZS_MAX_ALLOC_SIZE))
 		return 0;
 
+	if (zs_malloc_force_movable)
+		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
+
 	handle = cache_alloc_handle(pool, gfp);
 	if (!handle)
 		return 0;
-- 
2.20.1 (Apple Git-117)

