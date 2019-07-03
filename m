Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7B3C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99846218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfGCITc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:19:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8134 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727300AbfGCITb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:19:31 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BDC86B05E55C4D96440A;
        Wed,  3 Jul 2019 16:19:29 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Wed, 3 Jul 2019 16:19:24 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        "Christoph Lameter" <cl@linux.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] percpu: Make pcpu_setup_first_chunk() void function
Date:   Wed, 3 Jul 2019 16:25:52 +0800
Message-ID: <20190703082552.69951-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcpu_setup_first_chunk() will panic or BUG_ON if the are some
error and doesn't return any error, hence it can be defined to
return void.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/ia64/mm/contig.c    |  5 +----
 arch/ia64/mm/discontig.c |  5 +----
 include/linux/percpu.h   |  2 +-
 mm/percpu.c              | 17 ++++++-----------
 4 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
index d29fb6b9fa33..db09a693f094 100644
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -134,10 +134,7 @@ setup_per_cpu_areas(void)
 	ai->atom_size		= PAGE_SIZE;
 	ai->alloc_size		= PERCPU_PAGE_SIZE;
 
-	rc = pcpu_setup_first_chunk(ai, __per_cpu_start + __per_cpu_offset[0]);
-	if (rc)
-		panic("failed to setup percpu area (err=%d)", rc);
-
+	pcpu_setup_first_chunk(ai, __per_cpu_start + __per_cpu_offset[0]);
 	pcpu_free_alloc_info(ai);
 }
 #else
diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index 05490dd073e6..004dee231874 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -245,10 +245,7 @@ void __init setup_per_cpu_areas(void)
 		gi->cpu_map		= &cpu_map[unit];
 	}
 
-	rc = pcpu_setup_first_chunk(ai, base);
-	if (rc)
-		panic("failed to setup percpu area (err=%d)", rc);
-
+	pcpu_setup_first_chunk(ai, base);
 	pcpu_free_alloc_info(ai);
 }
 #endif
diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 9909dc0e273a..5e76af742c80 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -105,7 +105,7 @@ extern struct pcpu_alloc_info * __init pcpu_alloc_alloc_info(int nr_groups,
 							     int nr_units);
 extern void __init pcpu_free_alloc_info(struct pcpu_alloc_info *ai);
 
-extern int __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
+extern void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 					 void *base_addr);
 
 #ifdef CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK
diff --git a/mm/percpu.c b/mm/percpu.c
index 9821241fdede..ad32c3d11ca7 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2267,12 +2267,9 @@ static void pcpu_dump_alloc_info(const char *lvl,
  * share the same vm, but use offset regions in the area allocation map.
  * The chunk serving the dynamic region is circulated in the chunk slots
  * and available for dynamic allocation like any other chunk.
- *
- * RETURNS:
- * 0 on success, -errno on failure.
  */
-int __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
-				  void *base_addr)
+void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
+				   void *base_addr)
 {
 	size_t size_sum = ai->static_size + ai->reserved_size + ai->dyn_size;
 	size_t static_size, dyn_size;
@@ -2457,7 +2454,6 @@ int __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 
 	/* we're done */
 	pcpu_base_addr = base_addr;
-	return 0;
 }
 
 #ifdef CONFIG_SMP
@@ -2710,7 +2706,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 	struct pcpu_alloc_info *ai;
 	size_t size_sum, areas_size;
 	unsigned long max_distance;
-	int group, i, highest_group, rc;
+	int group, i, highest_group, rc = 0;
 
 	ai = pcpu_build_alloc_info(reserved_size, dyn_size, atom_size,
 				   cpu_distance_fn);
@@ -2795,7 +2791,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 		PFN_DOWN(size_sum), ai->static_size, ai->reserved_size,
 		ai->dyn_size, ai->unit_size);
 
-	rc = pcpu_setup_first_chunk(ai, base);
+	pcpu_setup_first_chunk(ai, base);
 	goto out_free;
 
 out_free_areas:
@@ -2920,7 +2916,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size,
 		unit_pages, psize_str, ai->static_size,
 		ai->reserved_size, ai->dyn_size);
 
-	rc = pcpu_setup_first_chunk(ai, vm.addr);
+	pcpu_setup_first_chunk(ai, vm.addr);
 	goto out_free_ar;
 
 enomem:
@@ -3014,8 +3010,7 @@ void __init setup_per_cpu_areas(void)
 	ai->groups[0].nr_units = 1;
 	ai->groups[0].cpu_map[0] = 0;
 
-	if (pcpu_setup_first_chunk(ai, fc) < 0)
-		panic("Failed to initialize percpu areas.");
+	pcpu_setup_first_chunk(ai, fc);
 	pcpu_free_alloc_info(ai);
 }
 
-- 
2.20.1

