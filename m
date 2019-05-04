Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4C1C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9683E206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfEDKZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 06:25:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57798 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726217AbfEDKZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 06:25:20 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5909689F2E5ECEAAF074;
        Sat,  4 May 2019 18:25:18 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Sat, 4 May 2019
 18:25:11 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <christophe.leroy@c-s.fr>,
        <aneesh.kumar@linux.vnet.ibm.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] powerpc/book3s64: Make some symbols static
Date:   Sat, 4 May 2019 18:24:27 +0800
Message-ID: <20190504102427.12332-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

arch/powerpc/mm/book3s64/radix_pgtable.c:326:13: warning: symbol 'radix_init_pgtable' was not declared. Should it be static?
arch/powerpc/mm/book3s64/hash_native.c:48:1: warning: symbol 'native_tlbie_lock' was not declared. Should it be static?
arch/powerpc/mm/book3s64/hash_utils.c:988:24: warning: symbol 'init_hash_mm_context' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/mm/book3s64/hash_native.c   | 2 +-
 arch/powerpc/mm/book3s64/hash_utils.c    | 2 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_native.c b/arch/powerpc/mm/book3s64/hash_native.c
index aaa28fd..47caecd 100644
--- a/arch/powerpc/mm/book3s64/hash_native.c
+++ b/arch/powerpc/mm/book3s64/hash_native.c
@@ -45,7 +45,7 @@
 #define HPTE_LOCK_BIT (56+3)
 #endif
 
-DEFINE_RAW_SPINLOCK(native_tlbie_lock);
+static DEFINE_RAW_SPINLOCK(native_tlbie_lock);
 
 static inline void tlbiel_hash_set_isa206(unsigned int set, unsigned int is)
 {
diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 919a861..1ff4518 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -985,7 +985,7 @@ void __init hash__early_init_devtree(void)
 	htab_scan_page_sizes();
 }
 
-struct hash_mm_context init_hash_mm_context;
+static struct hash_mm_context init_hash_mm_context;
 void __init hash__early_init_mmu(void)
 {
 #ifndef CONFIG_PPC_64K_PAGES
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index c9bcf42..c929d31 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -323,7 +323,7 @@ static int __meminit create_physical_mapping(unsigned long start,
 	return 0;
 }
 
-void __init radix_init_pgtable(void)
+static void __init radix_init_pgtable(void)
 {
 	unsigned long rts_field;
 	struct memblock_region *reg;
-- 
2.7.4


