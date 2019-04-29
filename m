Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1F1C04AA6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6F521655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 19:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="la7J3wBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfD2T7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 15:59:16 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31850 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbfD2T7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 15:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556567953; x=1588103953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6yEgNpC7nkfK5Gt64tHVR1TWf8LgYKpoRswHlGybH9k=;
  b=la7J3wBvXstTbg4SiFPQvEBixJGU+7Mj/S4Eaip1+RpikvAxd5YZBEdQ
   8+WfACwWo/1zg9Ix6yiOCNxbVN2g721hbPG/MKeimYJI8W4RqBjeea89q
   KhvX0aWt8HA0uEQBnTzODhbA5KfRkvc3wi+3Fp4zCqzNoNZj+7ieocTq8
   Ml79LZalrcSSiYXNvQANMkrE/lfmHq4rysF4AT+TUAzwDpGNU7/ofkx8v
   hlCo1+Unz8PjnClvlm4RIMkuZ4ByIR0ueIl5bta7dr/YFE7dhm+qlKq9F
   xqiALXx8ybnI2h9FM8qlgiWFkvvc5Hr37bhoNDPNpVRKvx07Yzkcjn0uS
   g==;
X-IronPort-AV: E=Sophos;i="5.60,410,1549900800"; 
   d="scan'208";a="108309672"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2019 03:58:12 +0800
IronPort-SDR: nnE+7rywavW8XrFdWFwhckRYvq20jD3vo+5IYylD3Woye3i2B8kqy4RZ5TJjUCVBz+EWQeK8lq
 wT10IOdbjDKNhIsg7guSFvNvqN5zQLk8grfrU5lbM/kLOVLQ5EemytBN4yIe+ITQVUPJ6zzFCm
 nh8Yc9Fd8FvLwbYwMYx6bokq4DbgtEGOO/SJ3tWmrSIDlYIAswarS+K1Co9DAJ347L41u6FpDr
 JDfbqpaJ35IyXRkaasw2cLgHHPYvPa/jsK4431T/at6Qh0NU3wRpIcMyGlNFlAAJ9uzBkRIVnc
 91VnHZE1yVTSvVONqv20+QcQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 29 Apr 2019 12:34:35 -0700
IronPort-SDR: UFWPaNgFKiyS+kM5SJyaKOUbUteycQhA9GHu35ZdcqxcIAwpMq8jMx6cNKm2y61EvnKQIFA4g6
 adyt71wuZeOe/j/KIJZpFB2cH7aaoEu+AewDQCjkARDNK6tKK3Ss/l+or3zUgnpe45r8pEQkIk
 Y4X8GvyOZtE6EMtIew7DWbZqn+xPD9yVsW1Tg3JnbklQSamvfjNHbVdnBrVnlis/LKUG2/sMoI
 J22J0Ee7szjf8iEwrssNPsTdXyQfMfR6jgh0cXur2FRS7yIgCImTKqhsa+TrLQ0cRGszY6tVQd
 xPQ=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2019 12:58:12 -0700
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
Subject: [PATCH v2 3/3] RISC-V: Update tlb flush counters
Date:   Mon, 29 Apr 2019 12:57:59 -0700
Message-Id: <20190429195759.18330-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190429195759.18330-1-atish.patra@wdc.com>
References: <20190429195759.18330-1-atish.patra@wdc.com>
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

