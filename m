Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3363EC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4FF213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="jBfTo5nx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfFXMbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:31:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33023 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfFXMbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:31:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id i11so21594674edq.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 05:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tFm56QmTytg84qXew2YclW3TMekhbP3jpjd8esAI1kU=;
        b=jBfTo5nx93Xzhhvw7wvHHNb8SaG3gvfcaKNqjy3wd7jZ17Us25JgUM1vWunJqfNnN1
         QmHVb/VuieX4DT7wn3KeCrxh1M38Z3OAXYE+Y20VAuJbE6urpNAUhnulEadgqokQ+YvX
         XB0YHGiQt4jS5joZW5hndMtftv4RWF9C6JLDig6H3jjU9LZII1PI84YqUhgaWN6v2cyy
         7YykXrb1gLJbtUGrwwOeGmTXIR5mOYqW3ykAVynQY3j9Om7yoW1BjHBoufpLes8BEa8o
         c0OAzj228PrnAuzrW/EY9D8blhu8wyrLwOzGkZdFap6IkPgLb4VHeUXdfN9UbxIb52A7
         9dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tFm56QmTytg84qXew2YclW3TMekhbP3jpjd8esAI1kU=;
        b=cqwxpl1Cl4JX8jVZqf4shcruT1zM2iTXINsXkuK0jz4a0xyvDGOyoQEK8niqLAQZlZ
         98GtrHLC9zHLMFZwnaxiTBdcy/52hKW3ckSntSyqH4WHzo1kVZ6XfL7ZVrUWM65N1bZo
         M0iPLkN01UuEjm40i52o1UWwu/Phsv5cMCe6QI/kgC1+xmlHmshqTppoAPt4NaBZlxz1
         QcuBNmSPyOvTIfIsPTWciWBVYH6uU0QOD8eskA2Plh65UnNzNMkwmFViVRCVNoxezdje
         Xf28XGqRJmJt5zBNRVQFLlklNN1UGcxpCrTPOWEDFEj0RV2Ke2S1jWw5yVzm2p4XqbUz
         rmcA==
X-Gm-Message-State: APjAAAWRLdpJ+r2j2INMXBVzdVq+5VpxHYyd6sFHbmBIO8SmTbuuMYke
        9VV3XceIiGPlt9CtoFhN66tWeg==
X-Google-Smtp-Source: APXvYqwxi0JBz/8YExn0Q1IAk8/9QNOWXOHqeyo5aB7Vf0SLtq+llAgTf7VykYs2WIuVUQR53gpcBg==
X-Received: by 2002:a17:906:5a05:: with SMTP id p5mr80522171ejq.193.1561379507641;
        Mon, 24 Jun 2019 05:31:47 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i1sm1855170ejo.32.2019.06.24.05.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 05:31:47 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 6CDAD10439E; Mon, 24 Jun 2019 15:31:52 +0300 (+03)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kyle Pelton <kyle.d.pelton@intel.com>,
        Baoquan He <bhe@redhat.com>
Subject: [PATCHv2] x86/mm: Handle physical-virtual alignment mismatch in phys_p4d_init()
Date:   Mon, 24 Jun 2019 15:31:50 +0300
Message-Id: <20190624123150.920-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle has reported that kernel crashes sometimes when it boots in
5-level paging mode with KASLR enabled:

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

Before the commit PAGE_OFFSET is always aligned to P4D_SIZE if we boot in
5-level paging mode. But now only PUD_SIZE alignment is guaranteed.

For phys_p4d_init() it means that 'paddr_next' after the first iteration
can belong to the same p4d entry.

In the case I was able to reproduce the 'vaddr' on the first iteration
is 0xff4228027fe00000 and 'paddr' is 0x33fe00000. On the second
iteration 'vaddr' becomes 0xff42287f40000000 and 'paddr' is
0x8000000000. The 'vaddr' in both cases belong to the same p4d entry.

It screws up 'i' count: we miss the last entry in the page table
completely.  And it confuses the branch under 'paddr >= paddr_end'
condition: the p4d entry can be cleared where must not to.

The patch makes phys_p4d_init() walk by virtual address space, like
__kernel_physical_mapping_init() does. It makes it work correctly with
phys-virt mismatch.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-and-tested-by: Kyle Pelton <kyle.d.pelton@intel.com>
Fixes: b569c1843498 ("x86/mm/KASLR: Reduce randomization granularity for 5-level paging to 1GB")
Cc: Baoquan He <bhe@redhat.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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
-- 
2.21.0

