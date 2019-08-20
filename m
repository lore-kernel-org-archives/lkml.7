Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1E1C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D991F22CEC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o3erKTMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfHTArf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:47:35 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:9732 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbfHTArf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566262056; x=1597798056;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K72wUoRoiZYo201g6jH46rLjKbp7qhzsddIk/Fsw3jQ=;
  b=o3erKTMoFWIat89ceJeggGkDCtOqbKLBS4bbOO+5dKiLnAQuxj1QSfhC
   +4Z9DEJukM/psn84rOOtOMdNkg6RMRRcixyORJp6vODnaEPaYMt9UqIZR
   S74GswVSR+U3Q7TrIhVKXtEhVm16esUx6omXLoV1V+yoD63PUfiuvHWU9
   F8c63/x745CWjrMjGj3sBAzwLVleEMzMfyAl8AkDE9ww4HfzfflkqYD2S
   c5sLvZDvN+FdASXko+QcdeXdvE2sgml5dlI5bXJCnQQ8sBKWQKi5+Kh5v
   rXL5nMlSQygT44OiROEw5qpqV7t1NXlinX+k0vwD2uR9L0kLe9t5fXJHh
   w==;
IronPort-SDR: P9RY2wxIImsWl95EXzEaX/4eVxQ1hkjGtZD9A70WFIz7fOBVQeOvPsGWZ1WAlcPHv2yWtFEnwC
 p4BIP3qDBk3HwbA8rckWbMRNdXewM+e7JDU/p6YZfeUwzWdao7u79/Q81LauAl58Hp5ZhS2WbW
 9k8ezoAS6q+ollyPZVCcTU7DuVdg6RIMgZI2cdDDzB6jnSbHW23YMsP/CPQG3Wbvh7ILskFkgH
 kZjL/xgNVkmnadOEXjS1Fvil31RO+9e0mFwb8Tee1vVYlxd5zRwu7PIy3n4s+8H0nqoFTsuOD/
 iug=
X-IronPort-AV: E=Sophos;i="5.64,406,1559491200"; 
   d="scan'208";a="120780482"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 08:47:35 +0800
IronPort-SDR: 5nS99llAu88XxqlHGdN1T0iUUBC4todiWifbW1yVhPLmjEYoRICbyjt1wrF/HE98By+3IFr+e9
 Xu9m1bLGMJaoSZx/9vFOwdUq6wob9xC7XLtEL4A0F6Uit294eI8mf5mjBwApd5rVw2yhvVuyOs
 3hWolbuvlB1aYBS9jAPPUBHVlTdHa0+F3HfJNmVfqDLCAkuxk9+61T1GQYHxRrJXTPxCogIuwK
 xI5aHXfvm3SJCqODxuA1Q3LtQgEMUGVgNmBqtrzC2QUvzGoWxQHwVqw9WWz4b2nn2Uhizf68ll
 GFYAOWqpZZ8dysZP2neH3/kE
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 17:44:58 -0700
IronPort-SDR: QUGX6k+unjABn9xPyz6wOgy7JlhI2PTBquwhT+WcUUrHHUCjrc6UH7ZC1m4QWhHBegR2fG1KcJ
 q+dCZBr1btcfDxqHePphKryzHyKAJFrUyfc58C2a18MN1Xan3qlYGclN3daB4FmUYmFaUr6YNG
 wiba5lVIp6CT8RxMyisHZkzGp3PPQDVoYx09EzcFVLmwLxw+s03Uqzw7+n1sVVlZ8QWwj7TxL1
 0mo4dgELx9Wa7YG5zH18uTxNGNQqtiCYTCUwvuzMssNyTyi+tLNzgsK1w41Af/LyQ83VLSzsHC
 kW8=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Aug 2019 17:47:35 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: [v2 PATCH] RISC-V: Optimize tlb flush path.
Date:   Mon, 19 Aug 2019 17:47:35 -0700
Message-Id: <20190820004735.18518-1-atish.patra@wdc.com>
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
in OpenSBI anyways. There is also no need of SBI call if
cpumask is empty.

Do a local flush first if current cpu is present in cpumask.
Invoke SBI call only if target cpumask contains any cpus
other than local cpu.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/tlbflush.h | 37 ++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index b5e64dc19b9e..3f9cd17b5402 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -8,6 +8,7 @@
 #define _ASM_RISCV_TLBFLUSH_H
 
 #include <linux/mm_types.h>
+#include <linux/sched.h>
 #include <asm/smp.h>
 
 /*
@@ -42,20 +43,44 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
 
 #include <asm/sbi.h>
 
-static inline void remote_sfence_vma(struct cpumask *cmask, unsigned long start,
-				     unsigned long size)
+static void __riscv_flush_tlb(struct cpumask *cmask, unsigned long start,
+			      unsigned long size)
 {
 	struct cpumask hmask;
+	unsigned int hartid;
+	unsigned int cpuid;
 
 	cpumask_clear(&hmask);
+
+	if (!cmask) {
+		riscv_cpuid_to_hartid_mask(cpu_online_mask, &hmask);
+		goto issue_sfence;
+	}
+
+	cpuid = get_cpu();
+	if (cpumask_test_cpu(cpuid, cmask)) {
+		/* Save trap cost by issuing a local tlb flush here */
+		if ((start == 0 && size == -1) || (size > PAGE_SIZE))
+			local_flush_tlb_all();
+		else if (size == PAGE_SIZE)
+			local_flush_tlb_page(start);
+	}
+	if (cpumask_any_but(cmask, cpuid) >= nr_cpu_ids)
+		goto done;
+
 	riscv_cpuid_to_hartid_mask(cmask, &hmask);
+	hartid = cpuid_to_hartid_map(cpuid);
+	cpumask_clear_cpu(hartid, &hmask);
+
+issue_sfence:
 	sbi_remote_sfence_vma(hmask.bits, start, size);
+done:
+	put_cpu();
 }
 
-#define flush_tlb_all() sbi_remote_sfence_vma(NULL, 0, -1)
-
+#define flush_tlb_all() __riscv_flush_tlb(NULL, 0, -1)
 #define flush_tlb_range(vma, start, end) \
-	remote_sfence_vma(mm_cpumask((vma)->vm_mm), start, (end) - (start))
+	__riscv_flush_tlb(mm_cpumask((vma)->vm_mm), start, (end) - (start))
 
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 				  unsigned long addr) {
@@ -63,7 +88,7 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
 }
 
 #define flush_tlb_mm(mm)				\
-	remote_sfence_vma(mm_cpumask(mm), 0, -1)
+	__riscv_flush_tlb(mm_cpumask(mm), 0, -1)
 
 #endif /* CONFIG_SMP */
 
-- 
2.21.0

