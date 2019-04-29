Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64547C004C9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2194821734
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qFV6oej8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbfD2V2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 17:28:01 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37434 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729472AbfD2V16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556573278; x=1588109278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6yEgNpC7nkfK5Gt64tHVR1TWf8LgYKpoRswHlGybH9k=;
  b=qFV6oej8ZiMi/3N42HtMykVcr51YOR7jpcrd5FGkvRujsCRu/7D6ihQR
   jPQ4vVDCR6FG0hfxCw8aSRUzN9Q+PMlOnzPzvkk30PTYF7pZOEr23FkZH
   b5nDbo9t0a3SIeHGy3AO7t7vqdS6NzBNbPlnYBwy7KlY9PxnufFHxrlJP
   c8kjS8NObeo1R15C1fcVL84koCFVWL1DIjy7pofNNS0Pr7fCk//vqTg0A
   gwsirVIVOZox2WbicHttWyiI222bWTIyPjnjeGKfMZxe2R6+fxiF2JdS5
   /i5n6KK56qLJC4epXrEXAHmt0MsJ5H5y1Sl+/80ZuJ1s5dDTCr96D8gwi
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,411,1549900800"; 
   d="scan'208";a="108317119"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2019 05:27:57 +0800
IronPort-SDR: XySzfO7/Hs3o7bUTXppuoEJP5isH9hWHvrlvFkQuoHnlX4XJiU+1rfwSXdpzqLifRAHQzD8ij4
 VapGnqX1PKKp0Xds8Q+7oftDpjc++4xkm5b8W3X5SIrrjkYxwET+xwBqEfrs/qOecYcDZA2jrI
 HX/gahDE+Azyo8W4q12jxioytQsH+5TFshxwFr5r3CExjtANOF6/R7k95SJ2sQgpF2L3erPiWg
 OJBYN1CKtGM3zohTLaO4sX2xrVrXO6CABKyKXa4EQpzo7mDGggpHqIuTOxcWYox62pQDdac6PU
 Rm7DBZTxba2Qmm16GvTi5xFt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 29 Apr 2019 14:06:27 -0700
IronPort-SDR: AeMSfyunL2LsJhLHPw2d6fgcuYcVNj32UjjthqEnf0K3EjrF0GfZMDuDh2OiloNPAlz1aVw0i+
 rx3dfrB4ctlfgfcrvEiWMY+xU/qL+lKYERo0bkL1QP8bZFPZXWNmK7AHG7clayjGa0Lj8ENMyx
 1wOmvOtnbDL3ngbhjQJ8wQKU3EyfHbxJyNq4JwOyOf6ZFZT8aE5nKv3MOFwnA7Y9OWIXRSIzTU
 D9skxvS/yaP+Q4I3XwxKDgiOXhch58PXoMJmzb/ezPJ2i0WDiO2HBIWmE1psz19MgvK5WqcNgm
 V3M=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Apr 2019 14:27:57 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Borislav Petkov <bp@alien8.de>,
        Changbin Du <changbin.du@intel.com>,
        Gary Guo <gary@garyguo.net>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 3/3] RISC-V: Update tlb flush counters
Date:   Mon, 29 Apr 2019 14:27:50 -0700
Message-Id: <20190429212750.26165-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190429212750.26165-1-atish.patra@wdc.com>
References: <20190429212750.26165-1-atish.patra@wdc.com>
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

