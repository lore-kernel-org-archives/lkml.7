Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2386AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2E92075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfC0Vg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:36:58 -0400
Received: from ale.deltatee.com ([207.54.116.67]:58666 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbfC0Vgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:36:50 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1h9GE4-0006DL-EI; Wed, 27 Mar 2019 15:36:49 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1h9GE2-0006Ck-Bm; Wed, 27 Mar 2019 15:36:46 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Logan Gunthorpe <logang@deltatee.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong@andestech.com>, Guo Ren <ren_guo@c-sky.com>
Date:   Wed, 27 Mar 2019 15:36:41 -0600
Message-Id: <20190327213643.23789-6-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327213643.23789-1-logang@deltatee.com>
References: <20190327213643.23789-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, sbates@raithlin.com, hch@lst.de, aou@eecs.berkeley.edu, logang@deltatee.com, rppt@linux.vnet.ibm.com, anup.patel@wdc.com, atish.patra@wdc.com, palmer@sifive.com, paul.walmsley@sifive.com, zong@andestech.com, ren_guo@c-sky.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 5/7] RISC-V: Implement memory hotplug
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to define ARCH_ENABLE_MEMORY_HOTPLUG we need to implement
arch_add_memory() and vmemmap_free().

arch_add_memory() is very similar to the x86 versions except we
don't need to fuss with the mapping as we've already mapped the
entire linear region in riscv.

For now, vmemmap_free() is empty which is similar to other arches that
don't implement hot remove.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Zong Li <zong@andestech.com>
Cc: Guo Ren <ren_guo@c-sky.com>
---
 arch/riscv/Kconfig   |  3 +++
 arch/riscv/mm/init.c | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d21e6a12e8b6..9477214a00e7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -83,6 +83,9 @@ config ARCH_SPARSEMEM_ENABLE
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool ARCH_SPARSEMEM_ENABLE
 
+config ARCH_ENABLE_MEMORY_HOTPLUG
+	def_bool y
+
 config STACKTRACE_SUPPORT
 	def_bool y
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 315194557c3d..0a54c3adf0ac 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -238,3 +238,30 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	return vmemmap_populate_basepages(start, end, node);
 }
 #endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+void vmemmap_free(unsigned long start, unsigned long end,
+		  struct vmem_altmap *altmap)
+{
+}
+
+int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
+		    bool want_memblock)
+{
+	unsigned long start_pfn = start >> PAGE_SHIFT;
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	int ret;
+
+	if ((start + size) > -va_pa_offset) {
+		pr_err("Cannot hotplug memory from %08llx to %08llx as it doesn't fall within the linear mapping\n",
+		       start, start + size);
+		return -EFAULT;
+	}
+
+	ret = __add_pages(nid, start_pfn, nr_pages, altmap, want_memblock);
+	WARN_ON_ONCE(ret);
+
+	return ret;
+}
+
+#endif
-- 
2.20.1

