Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1772C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77FD21741
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WesuLTYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfDJWpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:45:13 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:49965 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfDJWpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554936312; x=1586472312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6yEgNpC7nkfK5Gt64tHVR1TWf8LgYKpoRswHlGybH9k=;
  b=WesuLTYuoDr4aSbtRzjFbyKdzfS0RbbUEXykMO4k2b0LjV52rurMQs6I
   ZQnFyNVEtFh8B9SBDvzHB8XN2BI2K6i8KaXhp1An7cxXeP+27v9fG1kuV
   iWi7SseHJb81cKcHjFMwPj64TghIzzl1+8vbd4/nWJvpG1wscGpNN6oKx
   KHxJPSStLedl1OI5lqgVlDJhtUIuq32iqIjGGc1ERad0WruU+XPgqCoHn
   HnCPcSJ7HviDf9AkBMyRnpR8OfB18XKUHcUeuMguCjctEvoqWzL4QMhXO
   ei7muFU5UtjuB8OSnq5s/ccqb4omlJiF053fa0FNu39Q9zLEmlplJKojo
   w==;
X-IronPort-AV: E=Sophos;i="5.60,335,1549900800"; 
   d="scan'208";a="105470411"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2019 06:45:11 +0800
IronPort-SDR: zhZITZdwmBB0kC8dxnS31dgSwEoT/u/ZCnXKN13+WvF+9SDGGkfBjGjuOA+JAedigN+yUWnXIk
 VvubPvY7Hwcj/Oy2qlY+GwkR7lD5rSJGgw0hRV0yRZE2OimI8gdXtt2C1fPaI1mASi5mK0B7bh
 5xo4eyLJGDoC5wDq2JXSt/h0f4HnG4fag6dHUfPyJ5MmzZwVkrZiq0H+xZo+IjZnzfHUt6qMD3
 J32lNZ0v3hGytm6Nw5jpRrySq9lQ2EESkgrwZZ9muHddS8JJFM4NZnBQtrHs7kudXy5oSnrkuW
 2/W2TSb/Wmypbu2w5DX1cor7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 10 Apr 2019 15:22:06 -0700
IronPort-SDR: P2tizofEJwBlpXqmdmig2RJ0YQsu23QOCnvgmUAG1H9rvnUHED5nQrQKgVeUFCSMXkVPqz1NFe
 jVls7ismmD3tpCPVsDdnoyEZqRXuR7C9+3hklSCia+lTFejGZIY6Q2TZc+TZk3F3ayZp+sYZL9
 cwsesGy1YxUmbyDiHop/skE8vqRZ3kJWRkllwFplbjXgILSGHQWar81YpZhK+vWWucV0XLsM1T
 qfB+wvJwOeof4gZPbGRNVWLyYP5n1fcfj873zD0K2rvuxAU5c3n5CefKEFwYSgkUKpPyxC6A78
 lYk=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Apr 2019 15:45:11 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Borislav Petkov <bp@alien8.de>, Gary Guo <gary@garyguo.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-riscv@lists.infradead.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [2/3] RISC-V: Update tlb flush counters
Date:   Wed, 10 Apr 2019 15:44:48 -0700
Message-Id: <20190410224449.10877-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190410224449.10877-1-atish.patra@wdc.com>
References: <20190410224449.10877-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TLB flush counters under vmstat seems to be very helpful while
debugging TLB flush performance in RISC-V.

Update the counters in every TLB flush methods respectively.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/tlbflush.h |  5 +++++
 arch/riscv/mm/tlbflush.c          | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 29a780ca232a..19779a083f52 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -9,6 +9,7 @@
 #define _ASM_RISCV_TLBFLUSH_H
 
 #include <linux/mm_types.h>
+#include <linux/vmstat.h>
 
 /*
  * Flush entire local TLB.  'sfence.vma' implicitly fences with the instruction
@@ -16,11 +17,13 @@
  */
 static inline void local_flush_tlb_all(void)
 {
+	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
 	__asm__ __volatile__ ("sfence.vma" : : : "memory");
 }
 
 static inline void local_flush_tlb_mm(struct mm_struct *mm)
 {
+	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
 	/* Flush ASID 0 so that global mappings are not affected */
 	__asm__ __volatile__ ("sfence.vma x0, %0" : : "r" (0) : "memory");
 }
@@ -28,6 +31,7 @@ static inline void local_flush_tlb_mm(struct mm_struct *mm)
 static inline void local_flush_tlb_page(struct vm_area_struct *vma,
 	unsigned long addr)
 {
+	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ONE);
 	__asm__ __volatile__ ("sfence.vma %0, %1"
 			      : : "r" (addr), "r" (0)
 			      : "memory");
@@ -35,6 +39,7 @@ static inline void local_flush_tlb_page(struct vm_area_struct *vma,
 
 static inline void local_flush_tlb_kernel_page(unsigned long addr)
 {
+	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ONE);
 	__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory");
 }
 
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index ceee76f14a0a..8072d7da32bb 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/mm.h>
+#include <linux/vmstat.h>
+#include <linux/cpumask.h>
 #include <asm/sbi.h>
 
 #define SFENCE_VMA_FLUSH_ALL ((unsigned long) -1)
@@ -110,6 +112,7 @@ static void ipi_remote_sfence_vma(void *info)
 	unsigned long size = data->size;
 	unsigned long i;
 
+	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
 	if (size == SFENCE_VMA_FLUSH_ALL) {
 		local_flush_tlb_all();
 	}
@@ -129,6 +132,8 @@ static void ipi_remote_sfence_vma_asid(void *info)
 	unsigned long size = data->size;
 	unsigned long i;
 
+	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
+	/* Flush entire MM context */
 	if (size == SFENCE_VMA_FLUSH_ALL) {
 		__asm__ __volatile__ ("sfence.vma x0, %0"
 				      : : "r" (asid)
@@ -158,6 +163,13 @@ static void remote_sfence_vma(unsigned long start, unsigned long size)
 static void remote_sfence_vma_asid(cpumask_t *mask, unsigned long start,
 				   unsigned long size, unsigned long asid)
 {
+	int cpuid = smp_processor_id();
+
+	if (cpumask_equal(mask, cpumask_of(cpuid)))
+		count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
+	else
+		count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
+
 	if (tlbi_ipi) {
 		struct tlbi info = {
 			.start = start,
-- 
2.21.0

