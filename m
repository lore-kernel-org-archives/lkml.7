Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0A2C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928CD2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 05:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iMRw1gxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfFZFbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 01:31:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37187 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfFZFbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 01:31:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5Q5TlLW3964069
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 22:29:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5Q5TlLW3964069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561526988;
        bh=EgoGJW9P3ktIQSi4JWkNPryCeiAY/rGIvHxXiwc5nEM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=iMRw1gxnPl4DIcfLxeP1FUePUR6imwPZuu+HWln5FzlQvAZVDslkAQLHFmZ2tn5Fz
         at139i2ZYBpNKTZBc8laZi7ZLNo6PQBSSMYejHZ1YKGxYbIEugHHT2297CBxLXOH3g
         n43sRx/hIIpZA/YQHMU+jBsJXjJGuZm5S6oRnHUGRzpO9Sg3jxJ7+4S/MFJuvWcF5V
         EVdFLgrio84aXk6z7SlWS9PjDdcnD9i0vjXk1noFrTZHoRu00sNuutPRKoXlqqp3Rt
         TCvn1b5wmqdWIVCWsLvKHmrNK9V4zMkgXLJ/QgNM/fILVv6kd94gjfxFzkK8+g11+E
         LtkfHlZEkKfqw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5Q5TkkF3964065;
        Tue, 25 Jun 2019 22:29:46 -0700
Date:   Tue, 25 Jun 2019 22:29:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-432c833218dd0f75e7b56bd5e8658b72073158d2@git.kernel.org>
Cc:     kyle.d.pelton@intel.com, hpa@zytor.com,
        dave.hansen@linux.intel.com, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, bhe@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        kirill@shutemov.name, bp@alien8.de, kirill.shutemov@linux.intel.com
Reply-To: tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
          kyle.d.pelton@intel.com, linux-kernel@vger.kernel.org,
          dave.hansen@linux.intel.com, mingo@kernel.org,
          kirill@shutemov.name, luto@kernel.org, bp@alien8.de,
          bhe@redhat.com, kirill.shutemov@linux.intel.com
In-Reply-To: <20190624123150.920-1-kirill.shutemov@linux.intel.com>
References: <20190624123150.920-1-kirill.shutemov@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Handle physical-virtual alignment mismatch
 in phys_p4d_init()
Git-Commit-ID: 432c833218dd0f75e7b56bd5e8658b72073158d2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  432c833218dd0f75e7b56bd5e8658b72073158d2
Gitweb:     https://git.kernel.org/tip/432c833218dd0f75e7b56bd5e8658b72073158d2
Author:     Kirill A. Shutemov <kirill@shutemov.name>
AuthorDate: Mon, 24 Jun 2019 15:31:50 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 26 Jun 2019 07:25:09 +0200

x86/mm: Handle physical-virtual alignment mismatch in phys_p4d_init()

Kyle has reported occasional crashes when booting a kernel in 5-level
paging mode with KASLR enabled:

  WARNING: CPU: 0 PID: 0 at arch/x86/mm/init_64.c:87 phys_p4d_init+0x1d4/0x1ea
  RIP: 0010:phys_p4d_init+0x1d4/0x1ea
  Call Trace:
   __kernel_physical_mapping_init+0x10a/0x35c
   kernel_physical_mapping_init+0xe/0x10
   init_memory_mapping+0x1aa/0x3b0
   init_range_memory_mapping+0xc8/0x116
   init_mem_mapping+0x225/0x2eb
   setup_arch+0x6ff/0xcf5
   start_kernel+0x64/0x53b
   ? copy_bootdata+0x1f/0xce
   x86_64_start_reservations+0x24/0x26
   x86_64_start_kernel+0x8a/0x8d
   secondary_startup_64+0xb6/0xc0

which causes later:

  BUG: unable to handle page fault for address: ff484d019580eff8
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  BAD
  Oops: 0000 [#1] SMP NOPTI
  RIP: 0010:fill_pud+0x13/0x130
  Call Trace:
   set_pte_vaddr_p4d+0x2e/0x50
   set_pte_vaddr+0x6f/0xb0
   __native_set_fixmap+0x28/0x40
   native_set_fixmap+0x39/0x70
   register_lapic_address+0x49/0xb6
   early_acpi_boot_init+0xa5/0xde
   setup_arch+0x944/0xcf5
   start_kernel+0x64/0x53b

Kyle bisected the issue to commit b569c1843498 ("x86/mm/KASLR: Reduce
randomization granularity for 5-level paging to 1GB")

Before this commit PAGE_OFFSET was always aligned to P4D_SIZE when booting
5-level paging mode. But now only PUD_SIZE alignment is guaranteed.

In the case I was able to reproduce the following vaddr/paddr values were
observed in phys_p4d_init():

Iteration     vaddr			paddr
   1 	      0xff4228027fe00000 	0x033fe00000
   2	      0xff42287f40000000	0x8000000000

'vaddr' in both cases belongs to the same p4d entry.

But due to the original assumption that PAGE_OFFSET is aligned to P4D_SIZE
this overlap cannot be handled correctly. The code assumes strictly aligned
entries and unconditionally increments the index into the P4D table, which
creates false duplicate entries. Once the index reaches the end, the last
entry in the page table is missing.

Aside of that the 'paddr >= paddr_end' condition can evaluate wrong which
causes an P4D entry to be cleared incorrectly.

Change the loop in phys_p4d_init() to walk purely based on virtual
addresses like __kernel_physical_mapping_init() does. This makes it work
correctly with unaligned virtual addresses.

Fixes: b569c1843498 ("x86/mm/KASLR: Reduce randomization granularity for 5-level paging to 1GB")
Reported-by: Kyle Pelton <kyle.d.pelton@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kyle Pelton <kyle.d.pelton@intel.com>
Acked-by: Baoquan He <bhe@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190624123150.920-1-kirill.shutemov@linux.intel.com

---
 arch/x86/mm/init_64.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 693aaf28d5fe..0f01c7b1d217 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -671,23 +671,25 @@ static unsigned long __meminit
 phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 	      unsigned long page_size_mask, bool init)
 {
-	unsigned long paddr_next, paddr_last = paddr_end;
-	unsigned long vaddr = (unsigned long)__va(paddr);
-	int i = p4d_index(vaddr);
+	unsigned long vaddr, vaddr_end, vaddr_next, paddr_next, paddr_last;
+
+	paddr_last = paddr_end;
+	vaddr = (unsigned long)__va(paddr);
+	vaddr_end = (unsigned long)__va(paddr_end);
 
 	if (!pgtable_l5_enabled())
 		return phys_pud_init((pud_t *) p4d_page, paddr, paddr_end,
 				     page_size_mask, init);
 
-	for (; i < PTRS_PER_P4D; i++, paddr = paddr_next) {
-		p4d_t *p4d;
+	for (; vaddr < vaddr_end; vaddr = vaddr_next) {
+		p4d_t *p4d = p4d_page + p4d_index(vaddr);
 		pud_t *pud;
 
-		vaddr = (unsigned long)__va(paddr);
-		p4d = p4d_page + p4d_index(vaddr);
-		paddr_next = (paddr & P4D_MASK) + P4D_SIZE;
+		vaddr_next = (vaddr & P4D_MASK) + P4D_SIZE;
+		paddr = __pa(vaddr);
 
 		if (paddr >= paddr_end) {
+			paddr_next = __pa(vaddr_next);
 			if (!after_bootmem &&
 			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
 					     E820_TYPE_RAM) &&
@@ -699,13 +701,13 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 
 		if (!p4d_none(*p4d)) {
 			pud = pud_offset(p4d, 0);
-			paddr_last = phys_pud_init(pud, paddr, paddr_end,
-						   page_size_mask, init);
+			paddr_last = phys_pud_init(pud, paddr, __pa(vaddr_end),
+					page_size_mask, init);
 			continue;
 		}
 
 		pud = alloc_low_page();
-		paddr_last = phys_pud_init(pud, paddr, paddr_end,
+		paddr_last = phys_pud_init(pud, paddr, __pa(vaddr_end),
 					   page_size_mask, init);
 
 		spin_lock(&init_mm.page_table_lock);
