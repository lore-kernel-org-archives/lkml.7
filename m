Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36959C4CECD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1622D20644
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392420AbfITGJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:09:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57632 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437307AbfITGJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:09:08 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D06CA73DDC47281C735C;
        Fri, 20 Sep 2019 14:09:06 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Sep 2019 14:08:58 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>
CC:     <wangkefeng.wang@huawei.com>, Rob Herring <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>
Subject: [PATCH 16/32] of: Use pr_warn instead of pr_warning
Date:   Fri, 20 Sep 2019 14:25:28 +0800
Message-ID: <20190920062544.180997-17-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
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
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/of/fdt.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 223d617ecfe1..f1c23aad951e 100644
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

