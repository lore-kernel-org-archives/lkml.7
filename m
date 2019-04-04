Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D43C10F06
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F365217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="W2eIyqgl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5Mx+lgAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDDCJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:09:47 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39615 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbfDDCJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:09:45 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2AA8E2278E;
        Wed,  3 Apr 2019 22:01:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Apr 2019 22:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm3; bh=sXG3rQcTOdL12
        EImFulmnFrT8g5Zh7pYzesmPBFsvuo=; b=W2eIyqglUIoPdhEoBrYqkALYEwBAy
        mrWNgfESFLTDPFUr8KPyFvjQNgjXApnMept6L/h/0sWxRticLShbQa1oaFLnQCRW
        DnUl8I1fR3h9IQlZlZF774PzztAv7krSBVZ6DhzxiDEnlP7fLYLLOE3UMA2V4Njm
        3H+7nM6zpyg1hlfGO5sfueE6wAmk/nB7gjUOyFU2lYId1SqCbfmFeBy1HDQWnRz5
        yP3C4yLKR8WkjbVY96UVRLsppZuWTqlyHLENB5vevy7vOn5GbeGyMvdt3MHecMeJ
        ZIP2ZFMod9AoBzg2+OXGk0oV3acM/zNqbqVJl43nYYvkWRdQLW4Wfikeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=sXG3rQcTOdL12EImFulmnFrT8g5Zh7pYzesmPBFsvuo=; b=5Mx+lgAC
        KDkvHRxSZV/pLrpUHQNBSrBo8LVd9uBkAiMlkAhiEZ1cNvJ4pxFO/LRd8XMdWtHU
        Ohzw/EMVniSR+vaUuK5V+ql8WCZiCyvhodklOA0zsmesnYGMGm4IZ6bglJY9Cjym
        V9HzA44JzDt5L+UL3cHxreUqjHLB8G9I56oV9uE24yZh6xBb1e0Y+nrRXoEh/CHn
        4cgBQQLmAvIUKYp3d4l52Zdkur8nhh7NiWcYw3+2/swgm3ho1Dt6hrKXRNre8qil
        BIZnOmwQaUluPIXSGL3oqVEU9PvKavJ2BpPSL71EsKIsMrsVqud56v4BPMfiiOsN
        fXumJbx95Gdcfw==
X-ME-Sender: <xms:gGWlXD4kF-Jf5v3hPT1fHBuCyfKw9pOnPdiFYOxvVJElUCdxQY74pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeggdehudculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddt
    necuhfhrohhmpegkihcujggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucfkph
    epvdduiedrvddvkedrudduvddrvddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdr
    higrnhesshgvnhhtrdgtohhmnecuvehluhhsthgvrhfuihiivgepuddt
X-ME-Proxy: <xmx:gGWlXEn53tYAkqaqA_3J_TJ_Qi0ozDpkoHbc01QxwCoYD4if-fgHjg>
    <xmx:gGWlXBWypbq5SLtiskVavsqbZMMcSeejVy-GC070PDCaSOmwq1a13Q>
    <xmx:gGWlXI9x1AXCq_Sz2mM84CL1ghS22pb3IxRYn25gULrBelx7uHlXZw>
    <xmx:gWWlXMsa2Ye1jAzo-b01f_iu33SX3FS0iB6VJHvVbt0pzo8wFStYRw>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 244C210319;
        Wed,  3 Apr 2019 22:01:35 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Keith Busch <keith.busch@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        Javier Cabezas <jcabezas@nvidia.com>,
        David Nellans <dnellans@nvidia.com>, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 13/25] exchange pages: add multi-threaded exchange pages.
Date:   Wed,  3 Apr 2019 19:00:34 -0700
Message-Id: <20190404020046.32741-14-zi.yan@sent.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404020046.32741-1-zi.yan@sent.com>
References: <20190404020046.32741-1-zi.yan@sent.com>
Reply-To: ziy@nvidia.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Exchange two pages using multi threads. Exchange two lists of pages
using multi threads.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/Makefile        |   1 +
 mm/exchange.c      |  15 ++--
 mm/exchange_page.c | 229 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/internal.h      |   5 ++
 4 files changed, 245 insertions(+), 5 deletions(-)
 create mode 100644 mm/exchange_page.c

diff --git a/mm/Makefile b/mm/Makefile
index 5e6c591..2f1f1ad 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -46,6 +46,7 @@ obj-y += memblock.o
 
 obj-y += copy_page.o
 obj-y += exchange.o
+obj-y += exchange_page.o
 
 ifdef CONFIG_MMU
 	obj-$(CONFIG_ADVISE_SYSCALLS)	+= madvise.o
diff --git a/mm/exchange.c b/mm/exchange.c
index 626bbea..ce2c899 100644
--- a/mm/exchange.c
+++ b/mm/exchange.c
@@ -345,11 +345,16 @@ static int exchange_from_to_pages(struct page *to_page, struct page *from_page,
 
 	rc = -EFAULT;
 
-	if (PageHuge(from_page) || PageTransHuge(from_page))
-		exchange_huge_page(to_page, from_page);
-	else
-		exchange_highpage(to_page, from_page);
-	rc = 0;
+	if (mode & MIGRATE_MT)
+		rc = exchange_page_mthread(to_page, from_page,
+				hpage_nr_pages(from_page));
+	if (rc) {
+		if (PageHuge(from_page) || PageTransHuge(from_page))
+			exchange_huge_page(to_page, from_page);
+		else
+			exchange_highpage(to_page, from_page);
+		rc = 0;
+	}
 
 	exchange_page_flags(to_page, from_page);
 
diff --git a/mm/exchange_page.c b/mm/exchange_page.c
new file mode 100644
index 0000000..6054697
--- /dev/null
+++ b/mm/exchange_page.c
@@ -0,0 +1,229 @@
+/*
+ * Exchange page copy routine.
+ *
+ * Copyright 2019 by NVIDIA.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Authors: Zi Yan <ziy@nvidia.com>
+ *
+ */
+#include <linux/highmem.h>
+#include <linux/workqueue.h>
+#include <linux/slab.h>
+#include <linux/freezer.h>
+
+/*
+ * nr_copythreads can be the highest number of threads for given node
+ * on any architecture. The actual number of copy threads will be
+ * limited by the cpumask weight of the target node.
+ */
+extern unsigned int limit_mt_num;
+
+struct copy_page_info {
+	struct work_struct copy_page_work;
+	char *to;
+	char *from;
+	unsigned long chunk_size;
+};
+
+static void exchange_page_routine(char *to, char *from, unsigned long chunk_size)
+{
+	u64 tmp;
+	int i;
+
+	for (i = 0; i < chunk_size; i += sizeof(tmp)) {
+		tmp = *((u64*)(from + i));
+		*((u64*)(from + i)) = *((u64*)(to + i));
+		*((u64*)(to + i)) = tmp;
+	}
+}
+
+static void exchange_page_work_queue_thread(struct work_struct *work)
+{
+	struct copy_page_info *my_work = (struct copy_page_info*)work;
+
+	exchange_page_routine(my_work->to,
+							  my_work->from,
+							  my_work->chunk_size);
+}
+
+int exchange_page_mthread(struct page *to, struct page *from, int nr_pages)
+{
+	int total_mt_num = limit_mt_num;
+	int to_node = page_to_nid(to);
+	int i;
+	struct copy_page_info *work_items;
+	char *vto, *vfrom;
+	unsigned long chunk_size;
+	const struct cpumask *per_node_cpumask = cpumask_of_node(to_node);
+	int cpu_id_list[32] = {0};
+	int cpu;
+
+	total_mt_num = min_t(unsigned int, total_mt_num,
+						 cpumask_weight(per_node_cpumask));
+
+	if (total_mt_num > 1)
+		total_mt_num = (total_mt_num / 2) * 2;
+
+	if (total_mt_num > 32 || total_mt_num < 1)
+		return -ENODEV;
+
+	work_items = kvzalloc(sizeof(struct copy_page_info)*total_mt_num,
+						 GFP_KERNEL);
+	if (!work_items)
+		return -ENOMEM;
+
+	i = 0;
+	for_each_cpu(cpu, per_node_cpumask) {
+		if (i >= total_mt_num)
+			break;
+		cpu_id_list[i] = cpu;
+		++i;
+	}
+
+	/* XXX: assume no highmem  */
+	vfrom = kmap(from);
+	vto = kmap(to);
+	chunk_size = PAGE_SIZE*nr_pages / total_mt_num;
+
+	for (i = 0; i < total_mt_num; ++i) {
+		INIT_WORK((struct work_struct *)&work_items[i],
+				exchange_page_work_queue_thread);
+
+		work_items[i].to = vto + i * chunk_size;
+		work_items[i].from = vfrom + i * chunk_size;
+		work_items[i].chunk_size = chunk_size;
+
+		queue_work_on(cpu_id_list[i],
+					  system_highpri_wq,
+					  (struct work_struct *)&work_items[i]);
+	}
+
+	/* Wait until it finishes  */
+	flush_workqueue(system_highpri_wq);
+
+	kunmap(to);
+	kunmap(from);
+
+	kvfree(work_items);
+
+	return 0;
+}
+
+int exchange_page_lists_mthread(struct page **to, struct page **from, int nr_pages)
+{
+	int err = 0;
+	unsigned int total_mt_num = limit_mt_num;
+	int to_node = page_to_nid(*to);
+	int i;
+	struct copy_page_info *work_items;
+	int nr_pages_per_page = hpage_nr_pages(*from);
+	const struct cpumask *per_node_cpumask = cpumask_of_node(to_node);
+	int cpu_id_list[32] = {0};
+	int cpu;
+	int item_idx;
+
+
+	total_mt_num = min_t(unsigned int, total_mt_num,
+						 cpumask_weight(per_node_cpumask));
+
+	if (total_mt_num > 32 || total_mt_num < 1)
+		return -ENODEV;
+
+	if (nr_pages < total_mt_num) {
+		int residual_nr_pages = nr_pages - rounddown_pow_of_two(nr_pages);
+
+		if (residual_nr_pages) {
+			for (i = 0; i < residual_nr_pages; ++i) {
+				BUG_ON(hpage_nr_pages(to[i]) != hpage_nr_pages(from[i]));
+				err = exchange_page_mthread(to[i], from[i], hpage_nr_pages(to[i]));
+				VM_BUG_ON(err);
+			}
+			nr_pages = rounddown_pow_of_two(nr_pages);
+			to = &to[residual_nr_pages];
+			from = &from[residual_nr_pages];
+		}
+
+		work_items = kvzalloc(sizeof(struct copy_page_info)*total_mt_num,
+							 GFP_KERNEL);
+	} else
+		work_items = kvzalloc(sizeof(struct copy_page_info)*nr_pages,
+							 GFP_KERNEL);
+	if (!work_items)
+		return -ENOMEM;
+
+	i = 0;
+	for_each_cpu(cpu, per_node_cpumask) {
+		if (i >= total_mt_num)
+			break;
+		cpu_id_list[i] = cpu;
+		++i;
+	}
+
+	if (nr_pages < total_mt_num) {
+		for (cpu = 0; cpu < total_mt_num; ++cpu)
+			INIT_WORK((struct work_struct *)&work_items[cpu],
+					  exchange_page_work_queue_thread);
+		cpu = 0;
+		for (item_idx = 0; item_idx < nr_pages; ++item_idx) {
+			unsigned long chunk_size = nr_pages * PAGE_SIZE * hpage_nr_pages(from[item_idx]) / total_mt_num;
+			char *vfrom = kmap(from[item_idx]);
+			char *vto = kmap(to[item_idx]);
+			VM_BUG_ON(PAGE_SIZE * hpage_nr_pages(from[item_idx]) % total_mt_num);
+			VM_BUG_ON(total_mt_num % nr_pages);
+			BUG_ON(hpage_nr_pages(to[item_idx]) !=
+				   hpage_nr_pages(from[item_idx]));
+
+			for (i = 0; i < (total_mt_num/nr_pages); ++cpu, ++i) {
+				work_items[cpu].to = vto + chunk_size * i;
+				work_items[cpu].from = vfrom + chunk_size * i;
+				work_items[cpu].chunk_size = chunk_size;
+			}
+		}
+		if (cpu != total_mt_num)
+			pr_err("%s: only %d out of %d pages are transferred\n", __func__,
+				cpu - 1, total_mt_num);
+
+		for (cpu = 0; cpu < total_mt_num; ++cpu)
+			queue_work_on(cpu_id_list[cpu],
+						  system_highpri_wq,
+						  (struct work_struct *)&work_items[cpu]);
+	} else {
+		for (i = 0; i < nr_pages; ++i) {
+			int thread_idx = i % total_mt_num;
+
+			INIT_WORK((struct work_struct *)&work_items[i], exchange_page_work_queue_thread);
+
+			/* XXX: assume no highmem  */
+			work_items[i].to = kmap(to[i]);
+			work_items[i].from = kmap(from[i]);
+			work_items[i].chunk_size = PAGE_SIZE * hpage_nr_pages(from[i]);
+
+			BUG_ON(hpage_nr_pages(to[i]) != hpage_nr_pages(from[i]));
+
+			queue_work_on(cpu_id_list[thread_idx], system_highpri_wq, (struct work_struct *)&work_items[i]);
+		}
+	}
+
+	/* Wait until it finishes  */
+	flush_workqueue(system_highpri_wq);
+
+	for (i = 0; i < nr_pages; ++i) {
+			kunmap(to[i]);
+			kunmap(from[i]);
+	}
+
+	kvfree(work_items);
+
+	return err;
+}
+
diff --git a/mm/internal.h b/mm/internal.h
index 51f5e1b..a039459 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -561,4 +561,9 @@ extern int copy_page_lists_dma_always(struct page **to,
 extern int copy_page_lists_mt(struct page **to,
 			struct page **from, int nr_pages);
 
+extern int exchange_page_mthread(struct page *to, struct page *from,
+			int nr_pages);
+extern int exchange_page_lists_mthread(struct page **to,
+						  struct page **from, 
+						  int nr_pages);
 #endif	/* __MM_INTERNAL_H */
-- 
2.7.4

