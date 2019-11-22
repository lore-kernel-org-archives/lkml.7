Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E244C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD72E2068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="CbMuYu9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfKVRBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:01:06 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33978 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVRBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:01:06 -0500
Received: by mail-qt1-f194.google.com with SMTP id i17so8598600qtq.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 09:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pWsBqIbKYWYWQhST9oJt9JgHbawkwTncjF3B7rnat0w=;
        b=CbMuYu9hYHEWliCO6W1ulBmLeJrmf0Xlhc7Bphy1lYpCeTgBVL22O/X2RK0pgMK+EE
         ZrWi5mXtdHqw5ec/shCd7FwhYRr1A9dZiUfp/wfu5tNgJe0czTTbT1JYcWeij67g/esT
         7CUOcrX6TriEv+QrftR2fWaFVihjkgetIyUHsvlYZInYBCuZVEKokWhvWTvdvYGL1tmn
         9/ElsgEm+PhJcfl0TD2UbHjk/bMeyC3Aexc48jR6+mvFjk/jlgXtlUAFLX8uiQAKfLab
         rzBVlprhMyZH/3UCsPvhX3i1/CV+yf3OeRf6FdaSiiuOX6XusjlbVhxeRehyHCP+BzZS
         VBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pWsBqIbKYWYWQhST9oJt9JgHbawkwTncjF3B7rnat0w=;
        b=rWoaSwLSMbXd5+kz4p1R7VNwD93JCdIJCppu0AyitEOjqoQDSu/r/2gmh8r3LC752V
         Sa1PaqJ7mIihVddWpaNuP3U83iqylqjSmLp9Mxfz/54k3qsMcymKcfBqpmi2Rl5HHE24
         h/q1a3mzm8mfpwNToTJzzziE3QHZyCFpMiYdvGj1kdlODQnD2dQ2NTGa/g5rGIyxdfvP
         xAqoqqHXa+LS+C0uTyVLgGkaEObWOsbMQ1WIyMhqYDaYADZFqPWG//ppzeL8l/2CDCA2
         /tlImSeKq/6EkzRV3XIS2Rg6p7h6R77C0zIefhDxs/oC2fTTlBUeLZDxfZyXQB9KfLvN
         NhLA==
X-Gm-Message-State: APjAAAUpKmnff11Rk+5dRdpXGsMmU7JmmG1vcDqZITQjoqSXtmrwQ672
        evrO6p4Av+8MZpywMOm6H+57gA==
X-Google-Smtp-Source: APXvYqzhCO0YqZ3MbISkcxOuab42Hq7epijhhLR0FagPFiSheL2qamzu2VSRis3ydcI5BIKnVqrfLw==
X-Received: by 2002:aed:3762:: with SMTP id i89mr15676564qtb.69.1574442064122;
        Fri, 22 Nov 2019 09:01:04 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c21sm3688975qtg.61.2019.11.22.09.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 09:01:03 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     jroedel@suse.de
Cc:     joe@perches.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v3] iommu/iova: silence warnings under memory pressure
Date:   Fri, 22 Nov 2019 12:00:45 -0500
Message-Id: <1574442045-9210-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running heavy memory pressure workloads, this 5+ old system is
throwing endless warnings below because disk IO is too slow to recover
from swapping. Since the volume from alloc_iova_fast() could be large,
once it calls printk(), it will trigger disk IO (writing to the log
files) and pending softirqs which could cause an infinite loop and make
no progress for days by the ongoimng memory reclaim. This is the counter
part for Intel where the AMD part has already been merged. See the
commit 3d708895325b ("iommu/amd: Silence warnings under memory
pressure"). Since the allocation failure will be reported in
intel_alloc_iova(), so just call printk_ratelimted() there and silence
the one in alloc_iova_mem() to avoid the expensive warn_alloc().

 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 slab_out_of_memory: 66 callbacks suppressed
 SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
   cache: iommu_iova, object size: 40, buffer size: 448, default order:
0, min order: 0
   node 0: slabs: 1822, objs: 16398, free: 0
   node 1: slabs: 2051, objs: 18459, free: 31
 SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
   cache: iommu_iova, object size: 40, buffer size: 448, default order:
0, min order: 0
   node 0: slabs: 1822, objs: 16398, free: 0
   node 1: slabs: 2051, objs: 18459, free: 31
 SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
   cache: iommu_iova, object size: 40, buffer size: 448, default order:
0, min order: 0
 SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
 SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
 SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
 SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
 SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
   cache: skbuff_head_cache, object size: 208, buffer size: 640, default
order: 0, min order: 0
   cache: skbuff_head_cache, object size: 208, buffer size: 640, default
order: 0, min order: 0
   cache: skbuff_head_cache, object size: 208, buffer size: 640, default
order: 0, min order: 0
   cache: skbuff_head_cache, object size: 208, buffer size: 640, default
order: 0, min order: 0
   node 0: slabs: 697, objs: 4182, free: 0
   node 0: slabs: 697, objs: 4182, free: 0
   node 0: slabs: 697, objs: 4182, free: 0
   node 0: slabs: 697, objs: 4182, free: 0
   node 1: slabs: 381, objs: 2286, free: 27
   node 1: slabs: 381, objs: 2286, free: 27
   node 1: slabs: 381, objs: 2286, free: 27
   node 1: slabs: 381, objs: 2286, free: 27
   node 0: slabs: 1822, objs: 16398, free: 0
   cache: skbuff_head_cache, object size: 208, buffer size: 640, default
order: 0, min order: 0
   node 1: slabs: 2051, objs: 18459, free: 31
   node 0: slabs: 697, objs: 4182, free: 0
 SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
   node 1: slabs: 381, objs: 2286, free: 27
   cache: skbuff_head_cache, object size: 208, buffer size: 640, default
order: 0, min order: 0
   node 0: slabs: 697, objs: 4182, free: 0
   node 1: slabs: 381, objs: 2286, free: 27
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 warn_alloc: 96 callbacks suppressed
 kworker/11:1H: page allocation failure: order:0,
mode:0xa20(GFP_ATOMIC), nodemask=(null),cpuset=/,mems_allowed=0-1
 CPU: 11 PID: 1642 Comm: kworker/11:1H Tainted: G    B
 Hardware name: HP ProLiant XL420 Gen9/ProLiant XL420 Gen9, BIOS U19
12/27/2015
 Workqueue: kblockd blk_mq_run_work_fn
 Call Trace:
  dump_stack+0xa0/0xea
  warn_alloc.cold.94+0x8a/0x12d
  __alloc_pages_slowpath+0x1750/0x1870
  __alloc_pages_nodemask+0x58a/0x710
  alloc_pages_current+0x9c/0x110
  alloc_slab_page+0xc9/0x760
  allocate_slab+0x48f/0x5d0
  new_slab+0x46/0x70
  ___slab_alloc+0x4ab/0x7b0
  __slab_alloc+0x43/0x70
  kmem_cache_alloc+0x2dd/0x450
 SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
  alloc_iova+0x33/0x210
   cache: skbuff_head_cache, object size: 208, buffer size: 640, default
order: 0, min order: 0
   node 0: slabs: 697, objs: 4182, free: 0
  alloc_iova_fast+0x62/0x3d1
   node 1: slabs: 381, objs: 2286, free: 27
  intel_alloc_iova+0xce/0xe0
  intel_map_sg+0xed/0x410
  scsi_dma_map+0xd7/0x160
  scsi_queue_rq+0xbf7/0x1310
  blk_mq_dispatch_rq_list+0x4d9/0xbc0
  blk_mq_sched_dispatch_requests+0x24a/0x300
  __blk_mq_run_hw_queue+0x156/0x230
  blk_mq_run_work_fn+0x3b/0x40
  process_one_work+0x579/0xb90
  worker_thread+0x63/0x5b0
  kthread+0x1e6/0x210
  ret_from_fork+0x3a/0x50
 Mem-Info:
 active_anon:2422723 inactive_anon:361971 isolated_anon:34403
  active_file:2285 inactive_file:1838 isolated_file:0
  unevictable:0 dirty:1 writeback:5 unstable:0
  slab_reclaimable:13972 slab_unreclaimable:453879
  mapped:2380 shmem:154 pagetables:6948 bounce:0
  free:19133 free_pcp:7363 free_cma:0

Signed-off-by: Qian Cai <cai@lca.pw>
---

v3: insert a "\n" in dev_err_ratelimited() per Joe.
v2: use dev_err_ratelimited() and improve the commit messages.

 drivers/iommu/intel-iommu.c | 3 ++-
 drivers/iommu/iova.c        | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0c8d81f56a30..855a7bb272d8 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3406,7 +3406,8 @@ static unsigned long intel_alloc_iova(struct device *dev,
 	iova_pfn = alloc_iova_fast(&domain->iovad, nrpages,
 				   IOVA_PFN(dma_mask), true);
 	if (unlikely(!iova_pfn)) {
-		dev_err(dev, "Allocating %ld-page iova failed", nrpages);
+		dev_err_ratelimited(dev, "Allocating %ld-page iova failed\n",
+				    nrpages);
 		return 0;
 	}
 
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 41c605b0058f..aa1a56aaa5ee 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -233,7 +233,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 
 struct iova *alloc_iova_mem(void)
 {
-	return kmem_cache_alloc(iova_cache, GFP_ATOMIC);
+	return kmem_cache_alloc(iova_cache, GFP_ATOMIC | __GFP_NOWARN);
 }
 EXPORT_SYMBOL(alloc_iova_mem);
 
-- 
1.8.3.1

