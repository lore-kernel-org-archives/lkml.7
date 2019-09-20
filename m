Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BD6C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EDD2070C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437929AbfITJ0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 05:26:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408517AbfITJZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 05:25:40 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5B0E1F2E217F8C24B938;
        Fri, 20 Sep 2019 17:25:34 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 20 Sep 2019
 17:25:23 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
        <diana.craciun@nxp.com>, <christophe.leroy@c-s.fr>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <keescook@chromium.org>,
        <kernel-hardening@lists.openwall.com>
CC:     <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <yebin10@huawei.com>, <thunder.leizhen@huawei.com>,
        <jingxiangfeng@huawei.com>, <zhaohongjiang@huawei.com>,
        <oss@buserror.net>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v7 08/12] powerpc/fsl_booke/kaslr: clear the original kernel if randomized
Date:   Fri, 20 Sep 2019 17:45:42 +0800
Message-ID: <20190920094546.44948-9-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190920094546.44948-1-yanaijie@huawei.com>
References: <20190920094546.44948-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original kernel still exists in the memory, clear it now.

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
 arch/powerpc/mm/mmu_decl.h           |  2 ++
 arch/powerpc/mm/nohash/fsl_booke.c   |  1 +
 arch/powerpc/mm/nohash/kaslr_booke.c | 11 +++++++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index a3a4937c0496..565731475a07 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -151,8 +151,10 @@ extern void loadcam_multi(int first_idx, int num, int tmp_idx);
 
 #ifdef CONFIG_RANDOMIZE_BASE
 void kaslr_early_init(void *dt_ptr, phys_addr_t size);
+void kaslr_late_init(void);
 #else
 static inline void kaslr_early_init(void *dt_ptr, phys_addr_t size) {}
+static inline void kaslr_late_init(void) {}
 #endif
 
 struct tlbcam {
diff --git a/arch/powerpc/mm/nohash/fsl_booke.c b/arch/powerpc/mm/nohash/fsl_booke.c
index 2dc27cf88add..b4eb06ceb189 100644
--- a/arch/powerpc/mm/nohash/fsl_booke.c
+++ b/arch/powerpc/mm/nohash/fsl_booke.c
@@ -269,6 +269,7 @@ notrace void __init relocate_init(u64 dt_ptr, phys_addr_t start)
 	kernstart_addr = start;
 	if (is_second_reloc) {
 		virt_phys_offset = PAGE_OFFSET - memstart_addr;
+		kaslr_late_init();
 		return;
 	}
 
diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
index 7b238fc2c8a9..aa1b60c782e7 100644
--- a/arch/powerpc/mm/nohash/kaslr_booke.c
+++ b/arch/powerpc/mm/nohash/kaslr_booke.c
@@ -381,3 +381,14 @@ notrace void __init kaslr_early_init(void *dt_ptr, phys_addr_t size)
 
 	reloc_kernel_entry(dt_ptr, kernstart_virt_addr);
 }
+
+void __init kaslr_late_init(void)
+{
+	/* If randomized, clear the original kernel */
+	if (kernstart_virt_addr != KERNELBASE) {
+		unsigned long kernel_sz;
+
+		kernel_sz = (unsigned long)_end - kernstart_virt_addr;
+		memzero_explicit((void *)KERNELBASE, kernel_sz);
+	}
+}
-- 
2.17.2

