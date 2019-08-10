Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6C4C31E40
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 01:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EC32166E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 01:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pCTrVaW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbfHJBnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 21:43:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36048 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfHJBnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 21:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565401399; x=1596937399;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ceojetfl5xNGShX/CCMjHmrFo8vU8SDmwPMikCGqbgM=;
  b=pCTrVaW0fsrVa9L95ZGEW0IeOYdJHsh2sSXiljE0A6zGtlIr9dnCvPTM
   lXjM170bMmLAor2TGYtgCawhpa1oqDyHuOGz235myHRzaoZ8a1KILSPcL
   YxehDEjeQEOFsyc9aDJC7QlGVwX0AP7m0MlbTZGJCtRJZI8EkGWVHxy1Z
   VXuTyWWWLBnlRKsHutBM3L8juGPgys94aQL9kLiMBKQSyGoG1wlRr1JHm
   G0kKS+7dbAqqdPkYucF+foVudR0OgGGktrGvY3qYsUuLEIdDxEIckwY5c
   ed9xXXi5nOM9MphkWOO2xagf9WOUjtnrOUj/mEF9XXg3ufNesXYoA/sO0
   g==;
IronPort-SDR: ZOkMS7SWKn6og2i3CpFR/I921imTa39c9cDcRvFImGL7ugiUCOmz4eoFWsgKDWlOLyWDiI5nXD
 6b1JR+QgjoctexHSb1HdD5UGiQtzp5bXjCz/u5HD9peEd7y7lWju9JNIktufDYc5xy6XR3w9HH
 QWH7kIVfzZiihymhRrWeW6Hdu8sS5VauUhhn1U1TCJ7FGCfG0oAeIFZNO3W0QYQKqHVoRRHfZI
 bmXhvUM99KWljqzDgyhEGCrBqL+Hv/d4fbywxQ9S0QM9aym1XGZEFSYolraNMHH6qd1FBKL/Re
 yFU=
X-IronPort-AV: E=Sophos;i="5.64,367,1559491200"; 
   d="scan'208";a="115536553"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2019 09:43:11 +0800
IronPort-SDR: AFnbuUyy/lRph9+KcYeXg3ey1XHcjVeLwHbsoTdxDjXuZ/47kGZXKg/Wwu2oA9LV+wuc+uPK1f
 b8vmdNGnLHAHuDJnsrcOe7bEPIkSQis+zrEO6RUGxmGO7kUMJFpLmMle+KfeLalUqWzWfywXuk
 LJoQIyo4tcemgmUZMdxcRi8MUkic2xQm/iLRlZojXjzs3ZoAYcsb0N0Di7YnwJy/p3urxDC4ob
 4pTxph44h61TatRGfhpIpnbXpQvjUPxojqqEdPMA0DfaQKFo229guU08e/4q3lDJNwnAbFpV29
 El7o8EAI/IXc34SQij8mXLDN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 18:40:52 -0700
IronPort-SDR: 5cO7xlMPnvqQEdneKaDfxVLumwgrPiNAymBKl7/ACH5XG2lPhxIzijuIs4b7a0bV3rgy0faDcB
 ebce1EgaxSH8raP3yBgpez9GcF0InYakqHxD/VnIKsghZ0zhQb1Iy8k3difYzr8N0o9J73R+Hj
 Xf8buN3qZImFqAxYfjldxM5/zUq/R8JpefLbstNZoTZv4Y1bsxC8urlyZjaG5wnlRDW7F5aLiP
 sMl2s/DI9qwPBxifEOubuhQ17pRYq+yEeDa9/b/prcOdTS6FQCK0zJknAIJehYGbtMe8TlYS6U
 Vaw=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Aug 2019 18:43:10 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH] RISC-V: Issue a local tlb flush if possible.
Date:   Fri,  9 Aug 2019 18:43:09 -0700
Message-Id: <20190810014309.20838-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In RISC-V, tlb flush happens via SBI which is expensive.
If the target cpumask contains a local hartid, some cost
can be saved by issuing a local tlb flush as we do that
in OpenSBI anyways.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/tlbflush.h | 33 +++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 687dd19735a7..b32ba4fa5888 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -8,6 +8,7 @@
 #define _ASM_RISCV_TLBFLUSH_H
 
 #include <linux/mm_types.h>
+#include <linux/sched.h>
 #include <asm/smp.h>
 
 /*
@@ -46,14 +47,38 @@ static inline void remote_sfence_vma(struct cpumask *cmask, unsigned long start,
 				     unsigned long size)
 {
 	struct cpumask hmask;
+	struct cpumask tmask;
+	int cpuid = smp_processor_id();
 
 	cpumask_clear(&hmask);
-	riscv_cpuid_to_hartid_mask(cmask, &hmask);
-	sbi_remote_sfence_vma(hmask.bits, start, size);
+	cpumask_clear(&tmask);
+
+	if (cmask)
+		cpumask_copy(&tmask, cmask);
+	else
+		cpumask_copy(&tmask, cpu_online_mask);
+
+	if (cpumask_test_cpu(cpuid, &tmask)) {
+		/* Save trap cost by issuing a local tlb flush here */
+		if ((start == 0 && size == -1) || (size > PAGE_SIZE))
+			local_flush_tlb_all();
+		else if (size == PAGE_SIZE)
+			local_flush_tlb_page(start);
+		cpumask_clear_cpu(cpuid, &tmask);
+	} else if (cpumask_empty(&tmask)) {
+		/* cpumask is empty. So just do a local flush */
+		local_flush_tlb_all();
+		return;
+	}
+
+	if (!cpumask_empty(&tmask)) {
+		riscv_cpuid_to_hartid_mask(&tmask, &hmask);
+		sbi_remote_sfence_vma(hmask.bits, start, size);
+	}
 }
 
-#define flush_tlb_all() sbi_remote_sfence_vma(NULL, 0, -1)
-#define flush_tlb_page(vma, addr) flush_tlb_range(vma, addr, 0)
+#define flush_tlb_all() remote_sfence_vma(NULL, 0, -1)
+#define flush_tlb_page(vma, addr) flush_tlb_range(vma, addr, (addr) + PAGE_SIZE)
 #define flush_tlb_range(vma, start, end) \
 	remote_sfence_vma(mm_cpumask((vma)->vm_mm), start, (end) - (start))
 #define flush_tlb_mm(mm) \
-- 
2.21.0

