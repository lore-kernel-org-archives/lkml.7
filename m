Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E33CC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E199B205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="h5Lfrj4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388181AbfGPQ4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 12:56:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43357 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388111AbfGPQ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 12:56:45 -0400
Received: by mail-qt1-f195.google.com with SMTP id w17so20286925qto.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JkgYB201+YgtZ67xz124QalImKwHhD6hCX1vEDo1XAU=;
        b=h5Lfrj4oD0WIqU6ygkd/Fq6YtgSA5kUklS4HcoiluHDChhEtO4DfF3FXAOHZoNSeCm
         Qhej/p8oi+GphDHnwLxKOaFOAJeBkg6l9mlc/+E4PJtYlKxvBn+HtZ4Ta4dpZVmxhbZX
         1K9RtH/Q50Ei12r27O9HiDA+aOe1WIV7OpE+Ur5ro2lt2huOfTy2h/vYCnccPex7x35l
         bxf3Hq39Q/gK7xyaA+Ok5qq5QKv5KwayqGxpnxBPP38fc9PySfALkm1xG8plhfjIY5au
         Ubi4eL+bANK8Z/oL4+ZVTiLwR63VOBupKwcL+wUi6xtjo6aMfBD77X+qKxDGAflTHmNX
         oCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JkgYB201+YgtZ67xz124QalImKwHhD6hCX1vEDo1XAU=;
        b=keTh5DqedeV1n8Gs5fiG/rkOf6rBPDvVsDK6FzHjy9gQ+8kyGALcR80Q7Op86/rpFy
         PY3DQP7UnwkyoBbtPW5sF9vS0onqoxPZ3qj0E2NyiHPMvMHOYKcBlkwdXG4f0LQaSPda
         nR6H7Ox3Z4f7GF2BT//+SHywgr1ZBNhkkZxjybkcQv0dHqhC11rVWE7LTxvk8KdmLp03
         qYH0Py4oqSCXWhRJV+w5bSKRaq8q03/cuGFVeOU3FpnfudaKeCNVIhSTaWB6xugHDNJv
         9qPUGV9rVLxFSjyVkjRujRSan2gvED9F0/wIrhnRHFD3e8fdAXr2bQ29O1W2US4jG4Nn
         n8wg==
X-Gm-Message-State: APjAAAWQU944tCdJLiZmTIu9dfIaCZqNF+25xHyBYqkSpvj/CavOEdBo
        rQLd4v0zxzoTYB7dU1Lquo0=
X-Google-Smtp-Source: APXvYqwZZYB7JTSxjflHH6PzEmuWW65i2dKDOtRvxBkvqU4u3mcg8TDxomQhWhsJDugWob8iCPoiBw==
X-Received: by 2002:ac8:2b49:: with SMTP id 9mr24808489qtv.343.1563296204311;
        Tue, 16 Jul 2019 09:56:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id f20sm8519538qkh.15.2019.07.16.09.56.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 09:56:43 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC v1 1/4] arm64, mm: identity mapped page table
Date:   Tue, 16 Jul 2019 12:56:38 -0400
Message-Id: <20190716165641.6990-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190716165641.6990-1-pasha.tatashin@soleen.com>
References: <20190716165641.6990-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Created identiy mapped page table that maps 1 to 1 virtual to physical
addresses.

Similarly to x86, this table can be used in kasan, hibernate, and kexec.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/ident_map.h | 26 ++++++++
 arch/arm64/mm/Makefile             |  1 +
 arch/arm64/mm/ident_map.c          | 99 ++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 arch/arm64/include/asm/ident_map.h
 create mode 100644 arch/arm64/mm/ident_map.c

diff --git a/arch/arm64/include/asm/ident_map.h b/arch/arm64/include/asm/ident_map.h
new file mode 100644
index 000000000000..1bb9fcd27368
--- /dev/null
+++ b/arch/arm64/include/asm/ident_map.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ * Pavel Tatashin <patatash@linux.microsoft.com>
+ */
+
+#ifndef _ASM_IDENT_MAP_H
+#define _ASM_IDENT_MAP_H
+
+#include <linux/types.h>
+#include <asm/pgtable.h>
+
+struct ident_map_info {
+	void * (*alloc_pgt_page)(void *);	/* allocate a page  */
+	void *alloc_arg;			/* arg. for alloc_pgt_page */
+	unsigned long page_flags;		/* PMD or PUD flags */
+	unsigned long offset;			/* ident mapping offset */
+	bool pud_pages;				/* PUD level huge pages */
+};
+
+int ident_map_pgd_populate(struct ident_map_info *info,
+			   phys_addr_t pgd_page,
+			   phys_addr_t addr,
+			   phys_addr_t end);
+
+#endif /* _ASM_ARM64_IDENT_MAP_H */
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 849c1df3d214..dfa5a074a360 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -5,6 +5,7 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
 				   context.o proc.o pageattr.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_ARM64_PTDUMP_CORE)	+= dump.o
+obj-$(CONFIG_KEXEC_CORE)	+= ident_map.o
 obj-$(CONFIG_ARM64_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
 obj-$(CONFIG_NUMA)		+= numa.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
diff --git a/arch/arm64/mm/ident_map.c b/arch/arm64/mm/ident_map.c
new file mode 100644
index 000000000000..bcfff5e2573b
--- /dev/null
+++ b/arch/arm64/mm/ident_map.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, Microsoft Corporation.
+ * Pavel Tatashin <patatash@linux.microsoft.com>
+ */
+
+#include <asm/ident_map.h>
+#include <asm/pgalloc.h>
+
+/* Initialize PMD size huge entries in page table */
+static void ident_map_pmd_init(struct ident_map_info *info,
+			       phys_addr_t pmd_page, phys_addr_t addr,
+			       phys_addr_t end)
+{
+	const unsigned long flags = info->page_flags;
+	const unsigned long offset = info->offset;
+	pmd_t *pmdp = (pmd_t *)__va(pmd_page) + pmd_index(addr);
+
+	addr &= PMD_MASK;
+	for (; addr < end; addr += PMD_SIZE, pmdp++) {
+		set_pmd(pmdp, __pmd(__phys_to_pmd_val(addr - offset) | flags));
+	}
+}
+
+/* Initialize PUD size huge entries in page table */
+static void ident_map_pud_init(struct ident_map_info *info,
+			       phys_addr_t pud_page, phys_addr_t addr,
+			       phys_addr_t end)
+{
+	const unsigned long flags = info->page_flags;
+	const unsigned long offset = info->offset;
+	pud_t *pudp = (pud_t *)__va(pud_page) + pud_index(addr);
+
+	addr &= PUD_MASK;
+	for (; addr < end; addr += PUD_SIZE, pudp++) {
+		set_pud(pudp, __pud(__phys_to_pud_val(addr - offset) | flags));
+	}
+}
+
+/* Populate PUD level with PMD entries */
+static int ident_map_pud_populate(struct ident_map_info *info,
+				  phys_addr_t pud_page, phys_addr_t addr,
+				  phys_addr_t end)
+{
+	pud_t *pudp = (pud_t *)__va(pud_page) + pud_index(addr);
+	phys_addr_t pmd_page, next;
+
+	for (; addr < end; addr = next, pudp++) {
+		next = pud_addr_end(addr, end);
+		if (pud_none(*pudp)) {
+			void *pmd = info->alloc_pgt_page(info->alloc_arg);
+
+			if (!pmd)
+				return -ENOMEM;
+
+			clear_page(pmd);
+			__pud_populate(pudp, __pa(pmd), PUD_TYPE_TABLE);
+		}
+		pmd_page = __pud_to_phys(*pudp);
+		ident_map_pmd_init(info, pmd_page, addr, next);
+	}
+
+	return 0;
+}
+
+/* Populate identify mapped page table with physical range[addr, end) */
+int ident_map_pgd_populate(struct ident_map_info *info,
+			   phys_addr_t pgd_page, phys_addr_t addr,
+			   phys_addr_t end)
+{
+	const bool pud_pages = info->pud_pages;
+	pgd_t *pgdp = (pgd_t *)__va(pgd_page) + pgd_index(addr);
+	phys_addr_t pud_page, next;
+
+	for (; addr < end; addr = next, pgdp++) {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none(*pgdp)) {
+			void *pud = info->alloc_pgt_page(info->alloc_arg);
+
+			if (!pud)
+				return -ENOMEM;
+
+			clear_page(pud);
+			__pgd_populate(pgdp, __pa(pud), PUD_TYPE_TABLE);
+		}
+		pud_page = __pgd_to_phys(*pgdp);
+		if (pud_pages) {
+			ident_map_pud_init(info, pud_page, addr, next);
+		} else {
+			int rv = ident_map_pud_populate(info, pud_page, addr,
+				 next);
+
+			if (rv)
+				return rv;
+		}
+	}
+
+	return 0;
+}
-- 
2.22.0

