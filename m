Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D854C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A399217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 06:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfHEGmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 02:42:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59414 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbfHEGmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 02:42:44 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2F7A7A7224D5A53CE50D;
        Mon,  5 Aug 2019 14:26:37 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 5 Aug 2019
 14:26:27 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <diana.craciun@nxp.com>, <christophe.leroy@c-s.fr>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>
CC:     <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <yebin10@huawei.com>, <thunder.leizhen@huawei.com>,
        <jingxiangfeng@huawei.com>, <fanchengyang@huawei.com>,
        <zhaohongjiang@huawei.com>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v4 02/10] powerpc: move memstart_addr and kernstart_addr to init-common.c
Date:   Mon, 5 Aug 2019 14:43:27 +0800
Message-ID: <20190805064335.19156-3-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190805064335.19156-1-yanaijie@huawei.com>
References: <20190805064335.19156-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two variables are both defined in init_32.c and init_64.c. Move
them to init-common.c.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Cc: Diana Craciun <diana.craciun@nxp.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Diana Craciun <diana.craciun@nxp.com>
Tested-by: Diana Craciun <diana.craciun@nxp.com>
---
 arch/powerpc/mm/init-common.c | 5 +++++
 arch/powerpc/mm/init_32.c     | 5 -----
 arch/powerpc/mm/init_64.c     | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index a84da92920f7..152ae0d21435 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -21,6 +21,11 @@
 #include <asm/pgtable.h>
 #include <asm/kup.h>
 
+phys_addr_t memstart_addr = (phys_addr_t)~0ull;
+EXPORT_SYMBOL_GPL(memstart_addr);
+phys_addr_t kernstart_addr;
+EXPORT_SYMBOL_GPL(kernstart_addr);
+
 static bool disable_kuep = !IS_ENABLED(CONFIG_PPC_KUEP);
 static bool disable_kuap = !IS_ENABLED(CONFIG_PPC_KUAP);
 
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index b04896a88d79..872df48ae41b 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -56,11 +56,6 @@
 phys_addr_t total_memory;
 phys_addr_t total_lowmem;
 
-phys_addr_t memstart_addr = (phys_addr_t)~0ull;
-EXPORT_SYMBOL(memstart_addr);
-phys_addr_t kernstart_addr;
-EXPORT_SYMBOL(kernstart_addr);
-
 #ifdef CONFIG_RELOCATABLE
 /* Used in __va()/__pa() */
 long long virt_phys_offset;
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index a44f6281ca3a..c836f1269ee7 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -63,11 +63,6 @@
 
 #include <mm/mmu_decl.h>
 
-phys_addr_t memstart_addr = ~0;
-EXPORT_SYMBOL_GPL(memstart_addr);
-phys_addr_t kernstart_addr;
-EXPORT_SYMBOL_GPL(kernstart_addr);
-
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 /*
  * Given an address within the vmemmap, determine the pfn of the page that
-- 
2.17.2

