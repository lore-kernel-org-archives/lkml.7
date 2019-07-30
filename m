Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059B2C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B262087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbfG3HZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:25:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3244 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729407AbfG3HZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:25:31 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EA7D461F1782D299E9AC;
        Tue, 30 Jul 2019 15:25:29 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 30 Jul 2019
 15:25:23 +0800
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
Subject: [PATCH v2 01/10] powerpc: unify definition of M_IF_NEEDED
Date:   Tue, 30 Jul 2019 15:42:16 +0800
Message-ID: <20190730074225.39544-2-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190730074225.39544-1-yanaijie@huawei.com>
References: <20190730074225.39544-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

M_IF_NEEDED is defined too many times. Move it to a common place.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
Cc: Diana Craciun <diana.craciun@nxp.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Kees Cook <keescook@chromium.org>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/mmu-book3e.h  | 10 ++++++++++
 arch/powerpc/kernel/exceptions-64e.S          | 10 ----------
 arch/powerpc/kernel/fsl_booke_entry_mapping.S | 10 ----------
 arch/powerpc/kernel/misc_64.S                 |  5 -----
 4 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/mmu-book3e.h b/arch/powerpc/include/asm/nohash/mmu-book3e.h
index 4c9777d256fb..0877362e48fa 100644
--- a/arch/powerpc/include/asm/nohash/mmu-book3e.h
+++ b/arch/powerpc/include/asm/nohash/mmu-book3e.h
@@ -221,6 +221,16 @@
 #define TLBILX_T_CLASS2			6
 #define TLBILX_T_CLASS3			7
 
+/*
+ * The mapping only needs to be cache-coherent on SMP, except on
+ * Freescale e500mc derivatives where it's also needed for coherent DMA.
+ */
+#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
+#define M_IF_NEEDED	MAS2_M
+#else
+#define M_IF_NEEDED	0
+#endif
+
 #ifndef __ASSEMBLY__
 #include <asm/bug.h>
 
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 1cfb3da4a84a..fd49ec07ce4a 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -1342,16 +1342,6 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	sync
 	isync
 
-/*
- * The mapping only needs to be cache-coherent on SMP, except on
- * Freescale e500mc derivatives where it's also needed for coherent DMA.
- */
-#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
-#define M_IF_NEEDED	MAS2_M
-#else
-#define M_IF_NEEDED	0
-#endif
-
 /* 6. Setup KERNELBASE mapping in TLB[0]
  *
  * r3 = MAS0 w/TLBSEL & ESEL for the entry we started in
diff --git a/arch/powerpc/kernel/fsl_booke_entry_mapping.S b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
index ea065282b303..de0980945510 100644
--- a/arch/powerpc/kernel/fsl_booke_entry_mapping.S
+++ b/arch/powerpc/kernel/fsl_booke_entry_mapping.S
@@ -153,16 +153,6 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	tlbivax 0,r9
 	TLBSYNC
 
-/*
- * The mapping only needs to be cache-coherent on SMP, except on
- * Freescale e500mc derivatives where it's also needed for coherent DMA.
- */
-#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
-#define M_IF_NEEDED	MAS2_M
-#else
-#define M_IF_NEEDED	0
-#endif
-
 #if defined(ENTRY_MAPPING_BOOT_SETUP)
 
 /* 6. Setup KERNELBASE mapping in TLB1[0] */
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index b55a7b4cb543..26074f92d4bc 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -432,11 +432,6 @@ kexec_create_tlb:
 	rlwimi	r9,r10,16,4,15		/* Setup MAS0 = TLBSEL | ESEL(r9) */
 
 /* Set up a temp identity mapping v:0 to p:0 and return to it. */
-#if defined(CONFIG_SMP) || defined(CONFIG_PPC_E500MC)
-#define M_IF_NEEDED	MAS2_M
-#else
-#define M_IF_NEEDED	0
-#endif
 	mtspr	SPRN_MAS0,r9
 
 	lis	r9,(MAS1_VALID|MAS1_IPROT)@h
-- 
2.17.2

