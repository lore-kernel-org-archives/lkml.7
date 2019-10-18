Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F0CCA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F0821835
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409289AbfJRFGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:06:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2504056AbfJRFFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:05:13 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E250AB81BB81F92950E1;
        Fri, 18 Oct 2019 11:19:35 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Fri, 18 Oct 2019 11:19:28 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "Sergey Senozhatsky" <sergey.senozhatsky@gmail.com>
Subject: [PATCH v2 16/33] of: Use pr_warn instead of pr_warning
Date:   Fri, 18 Oct 2019 11:18:33 +0800
Message-ID: <20191018031850.48498-16-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018031850.48498-1-wangkefeng.wang@huawei.com>
References: <20191018031710.41052-1-wangkefeng.wang@huawei.com>
 <20191018031850.48498-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
pr_warning"), removing pr_warning so all logging messages use a
consistent <prefix>_warn style. Let's do it.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/of/fdt.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d01d834b26b0..2cdf64d2456f 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -412,8 +412,8 @@ void *__unflatten_device_tree(const void *blob,
 	/* Second pass, do actual unflattening */
 	unflatten_dt_nodes(blob, mem, dad, mynodes);
 	if (be32_to_cpup(mem + size) != 0xdeadbeef)
-		pr_warning("End of tree marker overwritten: %08x\n",
-			   be32_to_cpup(mem + size));
+		pr_warn("End of tree marker overwritten: %08x\n",
+			be32_to_cpup(mem + size));
 
 	if (detached && mynodes) {
 		of_node_set_flag(*mynodes, OF_DETACHED);
@@ -1120,25 +1120,25 @@ void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
 	size &= PAGE_MASK;
 
 	if (base > MAX_MEMBLOCK_ADDR) {
-		pr_warning("Ignoring memory block 0x%llx - 0x%llx\n",
-				base, base + size);
+		pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
+			base, base + size);
 		return;
 	}
 
 	if (base + size - 1 > MAX_MEMBLOCK_ADDR) {
-		pr_warning("Ignoring memory range 0x%llx - 0x%llx\n",
-				((u64)MAX_MEMBLOCK_ADDR) + 1, base + size);
+		pr_warn("Ignoring memory range 0x%llx - 0x%llx\n",
+			((u64)MAX_MEMBLOCK_ADDR) + 1, base + size);
 		size = MAX_MEMBLOCK_ADDR - base + 1;
 	}
 
 	if (base + size < phys_offset) {
-		pr_warning("Ignoring memory block 0x%llx - 0x%llx\n",
-			   base, base + size);
+		pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
+			base, base + size);
 		return;
 	}
 	if (base < phys_offset) {
-		pr_warning("Ignoring memory range 0x%llx - 0x%llx\n",
-			   base, phys_offset);
+		pr_warn("Ignoring memory range 0x%llx - 0x%llx\n",
+			base, phys_offset);
 		size -= phys_offset - base;
 		base = phys_offset;
 	}
-- 
2.20.1

