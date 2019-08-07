Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBC5C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D3C20880
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfHGGkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 02:40:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3777 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727588AbfHGGkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 02:40:14 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ECCF7E8AB2CAFC5D4654;
        Wed,  7 Aug 2019 14:40:12 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 7 Aug 2019
 14:40:02 +0800
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
Subject: [PATCH v5 08/10] powerpc/fsl_booke/kaslr: clear the original kernel if randomized
Date:   Wed, 7 Aug 2019 14:57:04 +0800
Message-ID: <20190807065706.11411-9-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190807065706.11411-1-yanaijie@huawei.com>
References: <20190807065706.11411-1-yanaijie@huawei.com>
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
 arch/powerpc/kernel/kaslr_booke.c  | 11 +++++++++++
 arch/powerpc/mm/mmu_decl.h         |  2 ++
 arch/powerpc/mm/nohash/fsl_booke.c |  1 +
 3 files changed, 14 insertions(+)

diff --git a/arch/powerpc/kernel/kaslr_booke.c b/arch/powerpc/kernel/kaslr_booke.c
index 52b59b05f906..c6b326424b54 100644
--- a/arch/powerpc/kernel/kaslr_booke.c
+++ b/arch/powerpc/kernel/kaslr_booke.c
@@ -400,3 +400,14 @@ notrace void __init kaslr_early_init(void *dt_ptr, phys_addr_t size)
 
 	reloc_kernel_entry(dt_ptr, kimage_vaddr);
 }
+
+void __init kaslr_late_init(void)
+{
+	/* If randomized, clear the original kernel */
+	if (kimage_vaddr != KERNELBASE) {
+		unsigned long kernel_sz;
+
+		kernel_sz = (unsigned long)_end - kimage_vaddr;
+		memzero_explicit((void *)KERNELBASE, kernel_sz);
+	}
+}
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 9332772c8a66..f0a461482dba 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -150,8 +150,10 @@ extern void loadcam_multi(int first_idx, int num, int tmp_idx);
 
 #ifdef CONFIG_RANDOMIZE_BASE
 void kaslr_early_init(void *dt_ptr, phys_addr_t size);
+void kaslr_late_init(void);
 #else
 static inline void kaslr_early_init(void *dt_ptr, phys_addr_t size) {}
+static inline void kaslr_late_init(void) {}
 #endif
 
 struct tlbcam {
diff --git a/arch/powerpc/mm/nohash/fsl_booke.c b/arch/powerpc/mm/nohash/fsl_booke.c
index 8d25a8dc965f..e88fcc367600 100644
--- a/arch/powerpc/mm/nohash/fsl_booke.c
+++ b/arch/powerpc/mm/nohash/fsl_booke.c
@@ -269,6 +269,7 @@ notrace void __init relocate_init(u64 dt_ptr, phys_addr_t start)
 	kernstart_addr = start;
 	if (is_second_reloc) {
 		virt_phys_offset = PAGE_OFFSET - memstart_addr;
+		kaslr_late_init();
 		return;
 	}
 
-- 
2.17.2

