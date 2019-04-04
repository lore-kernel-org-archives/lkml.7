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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D91C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B97020820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="uEpllha3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qLsh8QQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfDDCJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:09:55 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50557 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726600AbfDDCJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:09:48 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F0B7A21FAE;
        Wed,  3 Apr 2019 22:01:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Apr 2019 22:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm3; bh=CjIqcHjtGoHFP
        W1884J+3zbLpqMgt9/Z/pz8Qn99yHE=; b=uEpllha3uvC3u8tcgOeoEFcXkG5l/
        kmY8OsTWncvsDv4bYW4h5o21393tnwIs+WUiL4zrefo1QL4rQ+ZvDAp/hsBq25q9
        uVHArQYBQcDX9GZwkZYjsUUeXypWjMdGbZg5ms0VemMPA6NwIaek4m1xG7N78fec
        d17GfR4Za/gg5jSTifdKj3kChmqv3B7rSvfts7eTeeibCJZY3T4+ElpOWrIJBFBM
        jlSc4VcmSJhkJ7vE7upfE2AIhLZ36JPrcByF5POiSfNUdPldR6LxDikHzEhcKr+p
        QOjf+Zaw26zJdM9tQN8ZLb0xj+vnVNcnUL7Hv3S4ojZwFrFo83T0iPJlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=CjIqcHjtGoHFPW1884J+3zbLpqMgt9/Z/pz8Qn99yHE=; b=qLsh8QQG
        SvXnhLHkzdEuprx7pRLulPcYDKK8+yCfY+Kl3tLISnITQUlI4zDeAu04tVbgiLKs
        vyIus0Y1JCSJt6G9if22pfcQ+bGMaxt0H439gBf6FtSx/3+dG2fsgeD7/NcQC71u
        9cgyqjh5LMUpuoE1ijA1YjYpppZR32P0Bc8aihs7JSoSgjCqIcqREl3ftSqbfGP2
        /ksAOF5L619riBCPlfOHGOjDverDWuDtE1/E7kWlUUHoBN6tdcj2+whK1a8F8c1b
        PHKiJ2pjh4CAHbQdZ698Kq5rqe/MFpha3MpXWi+ztNbT1IgfKsEUAE4wk5RK0sZ6
        +RqqLRKWtVu5iA==
X-ME-Sender: <xms:bWWlXKXbLZRGhZ_BYL7MgfWO219e2m19XdPigh3upQnyUcN2ql5UJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeggdehudculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddt
    necuhfhrohhmpegkihcujggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucfkph
    epvdduiedrvddvkedrudduvddrvddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdr
    higrnhesshgvnhhtrdgtohhmnecuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:bWWlXHUhz9fR08dhTQZbxxhAGDYr7Lp7A7Ku6pDda024WfEoH6KuFA>
    <xmx:bWWlXCOcEd17rmDGXrIVtN2KXVOOA3zW0252iTFN1bPJS9gvg1cJBA>
    <xmx:bWWlXC6bJJem6534sA2xbEKKqjqvMHL51RMmi0lozGUv6KEn5Rq9oA>
    <xmx:bWWlXFDamIitD2AQHm7yvul_jLeH6RdzpBXj_gfjQQDwbSh8sCqA9Q>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1744410316;
        Wed,  3 Apr 2019 22:01:16 -0400 (EDT)
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
Subject: [RFC PATCH 03/25] mm: migrate: Add a multi-threaded page migration function.
Date:   Wed,  3 Apr 2019 19:00:24 -0700
Message-Id: <20190404020046.32741-4-zi.yan@sent.com>
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

copy_page_multithread() function is added to migrate huge pages
in multi-threaded way, which provides higher throughput than
a single-threaded way.

Internally, copy_page_multithread() splits and distributes a huge page
into multiple threads, then send them as jobs to system_highpri_wq.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/highmem.h |   2 +
 mm/Makefile             |   2 +
 mm/copy_page.c          | 128 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+)
 create mode 100644 mm/copy_page.c

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index ea5cdbd8c..0f50dc5 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -276,4 +276,6 @@ static inline void copy_highpage(struct page *to, struct page *from)
 
 #endif
 
+int copy_page_multithread(struct page *to, struct page *from, int nr_pages);
+
 #endif /* _LINUX_HIGHMEM_H */
diff --git a/mm/Makefile b/mm/Makefile
index d210cc9..fa02a9f 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -44,6 +44,8 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 obj-y += init-mm.o
 obj-y += memblock.o
 
+obj-y += copy_page.o
+
 ifdef CONFIG_MMU
 	obj-$(CONFIG_ADVISE_SYSCALLS)	+= madvise.o
 endif
diff --git a/mm/copy_page.c b/mm/copy_page.c
new file mode 100644
index 0000000..9cf849c
--- /dev/null
+++ b/mm/copy_page.c
@@ -0,0 +1,128 @@
+/*
+ * Enhanced page copy routine.
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
+
+#include <linux/highmem.h>
+#include <linux/workqueue.h>
+#include <linux/slab.h>
+#include <linux/freezer.h>
+
+
+const unsigned int limit_mt_num = 4;
+
+/* ======================== multi-threaded copy page ======================== */
+
+struct copy_item {
+	char *to;
+	char *from;
+	unsigned long chunk_size;
+};
+
+struct copy_page_info {
+	struct work_struct copy_page_work;
+	unsigned long num_items;
+	struct copy_item item_list[0];
+};
+
+static void copy_page_routine(char *vto, char *vfrom,
+	unsigned long chunk_size)
+{
+	memcpy(vto, vfrom, chunk_size);
+}
+
+static void copy_page_work_queue_thread(struct work_struct *work)
+{
+	struct copy_page_info *my_work = (struct copy_page_info *)work;
+	int i;
+
+	for (i = 0; i < my_work->num_items; ++i)
+		copy_page_routine(my_work->item_list[i].to,
+						  my_work->item_list[i].from,
+						  my_work->item_list[i].chunk_size);
+}
+
+int copy_page_multithread(struct page *to, struct page *from, int nr_pages)
+{
+	unsigned int total_mt_num = limit_mt_num;
+	int to_node = page_to_nid(to);
+	int i;
+	struct copy_page_info *work_items[NR_CPUS] = {0};
+	char *vto, *vfrom;
+	unsigned long chunk_size;
+	const struct cpumask *per_node_cpumask = cpumask_of_node(to_node);
+	int cpu_id_list[NR_CPUS] = {0};
+	int cpu;
+	int err = 0;
+
+	total_mt_num = min_t(unsigned int, total_mt_num,
+						 cpumask_weight(per_node_cpumask));
+	if (total_mt_num > 1)
+		total_mt_num = (total_mt_num / 2) * 2;
+
+	if (total_mt_num > num_online_cpus() || total_mt_num <=1)
+		return -ENODEV;
+
+	for (cpu = 0; cpu < total_mt_num; ++cpu) {
+		work_items[cpu] = kzalloc(sizeof(struct copy_page_info)
+						+ sizeof(struct copy_item), GFP_KERNEL);
+		if (!work_items[cpu]) {
+			err = -ENOMEM;
+			goto free_work_items;
+		}
+	}
+
+	i = 0;
+	for_each_cpu(cpu, per_node_cpumask) {
+		if (i >= total_mt_num)
+			break;
+		cpu_id_list[i] = cpu;
+		++i;
+	}
+
+	vfrom = kmap(from);
+	vto = kmap(to);
+	chunk_size = PAGE_SIZE*nr_pages / total_mt_num;
+
+	for (i = 0; i < total_mt_num; ++i) {
+		INIT_WORK((struct work_struct *)work_items[i],
+				  copy_page_work_queue_thread);
+
+		work_items[i]->num_items = 1;
+		work_items[i]->item_list[0].to = vto + i * chunk_size;
+		work_items[i]->item_list[0].from = vfrom + i * chunk_size;
+		work_items[i]->item_list[0].chunk_size = chunk_size;
+
+		queue_work_on(cpu_id_list[i],
+					  system_highpri_wq,
+					  (struct work_struct *)work_items[i]);
+	}
+
+	/* Wait until it finishes  */
+	for (i = 0; i < total_mt_num; ++i)
+		flush_work((struct work_struct *)work_items[i]);
+
+	kunmap(to);
+	kunmap(from);
+
+free_work_items:
+	for (cpu = 0; cpu < total_mt_num; ++cpu)
+		if (work_items[cpu])
+			kfree(work_items[cpu]);
+
+	return err;
+}
-- 
2.7.4

