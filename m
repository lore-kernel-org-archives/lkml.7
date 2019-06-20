Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B51C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AC62070B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="UL0KUfyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbfFTLXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 07:23:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37380 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731119AbfFTLXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 07:23:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id w13so4210805eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 04:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8cJoI3i9YR4Ig4tE+3YaTc5tEe16fiwRh4jCq3E/cWc=;
        b=UL0KUfyKxwCU0Cy/V4h2SzXHriXuysOoPrQPnUzuSCs+ifgA24oMhpxRR/HtCCpBwY
         tlahAn8T4LSMw2GNcE3I778hCYyWS5+eCSfatvePWlxbCD+lA2ntCQCm6ySp0Mb7ZK1u
         dpXkifS8B5IB/mfGUzFwQcpbgBgJdYXySW7YOEUumM90NJkBS5iXU+niEgbPF0fm853j
         VR8icu7BkLuX+kaMzlD6zJy9QYQxYUQL2xR+ZLDhnQFs/Ye1ZphjB/ncGWaRQaRYbbN4
         1zgs8BhaKzpzVaWU5y6YxJPoJD8RKM+06T874KCDZsiS25FYMNe/S/z/cfiWM4/GQQkG
         Ws0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8cJoI3i9YR4Ig4tE+3YaTc5tEe16fiwRh4jCq3E/cWc=;
        b=TtAmjVKR1GFaSzax0CgGIkRaHMfgCv+uibRhqZF1IFKy+FrhmLiXvHd5hJifpxypm+
         2AqqpCoIfrDIm3NiyLGop2zwCp45TLtoqfsJXSBR2ysNGhhQDI3Y+8mp3sTpjG8VgX8x
         9/EYYnCkNDr70biiKF9uBzmfseKjI2VPFmY2iG+urpgkcYdmVdxFwi8jpGgtGSu9lqs9
         KtQhimMVMm2xUGtXswcqXP2JpAqreocxCIr/f3+B0bT/c6yzUr2Sk611dW0fPs75ojN9
         3gScMQswIR8bHfC/wbsij5b393m1+E+ERq+z3jCZcwi7vFcPB2kZendCyvl6by2iWF0h
         0eYA==
X-Gm-Message-State: APjAAAX0zw79DTo0oQ3SvhQwXpbYlz6ZmZzaPnsyqkZVREN4PjLpVQCx
        25YK/yos74dP+6TcFkuUBcTgsg==
X-Google-Smtp-Source: APXvYqzDk51Q9wqGtmtlwUaZNBd8+gY1pnF7C8O2wzwqO5NnTZtRd9GJZjHUbDxOAsxsx3Mdkryb9A==
X-Received: by 2002:a50:8974:: with SMTP id f49mr83831272edf.95.1561029798612;
        Thu, 20 Jun 2019 04:23:18 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k51sm6761490edb.7.2019.06.20.04.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 04:23:17 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id AEEC11040F8; Thu, 20 Jun 2019 14:23:18 +0300 (+03)
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
Subject: [PATCH] x86/mm: Handle physical-virtual alignment mismatch in phys_p4d_init()
Date:   Thu, 20 Jun 2019 14:22:39 +0300
Message-Id: <20190620112239.28346-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle has reported that kernel crashes sometimes when it boots in
5-level paging mode with KASLR enabled:

[    0.000000] WARNING: CPU: 0 PID: 0 at arch/x86/mm/init_64.c:87 phys_p4d_init+0x1d4/0x1ea
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.2.0-rc5+ #27
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.4
[    0.000000] RIP: 0010:phys_p4d_init+0x1d4/0x1ea
[    0.000000] Code: 20 be 43 94 ff 45 cc 4c 89 e6 e9 90 fe ff ff 48 89 d8 eb 1d 48 8b 4d d0 48 8b 7d c0 45 0f b6 3
[    0.000000] RSP: 0000:ffffffff94403c70 EFLAGS: 00000046 ORIG_RAX: 0000000000000000
[    0.000000] RAX: 0000000000000000 RBX: 0000000340000000 RCX: 0000000000000007
[    0.000000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    0.000000] RBP: ffffffff94403cb8 R08: 0000000000000023 R09: ffffffff947fa680
[    0.000000] R10: 0000000000000008 R11: 0000000000000031 R12: 0000010000000000
[    0.000000] R13: 0000000340000000 R14: ffffffff94403d01 R15: ff484d01962014d0
[    0.000000] FS:  0000000000000000(0000) GS:ffffffff9468a000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ff484d0196201000 CR3: 0000000315b3e000 CR4: 00000000000016b0
[    0.000000] Call Trace:
[    0.000000]  __kernel_physical_mapping_init+0x10a/0x35c
[    0.000000]  kernel_physical_mapping_init+0xe/0x10
[    0.000000]  init_memory_mapping+0x1aa/0x3b0
[    0.000000]  init_range_memory_mapping+0xc8/0x116
[    0.000000]  init_mem_mapping+0x225/0x2eb
[    0.000000]  setup_arch+0x6ff/0xcf5
[    0.000000]  start_kernel+0x64/0x53b
[    0.000000]  ? copy_bootdata+0x1f/0xce
[    0.000000]  x86_64_start_reservations+0x24/0x26
[    0.000000]  x86_64_start_kernel+0x8a/0x8d
[    0.000000]  secondary_startup_64+0xb6/0xc0
[    0.000000] random: get_random_bytes called from print_oops_end_marker+0x3f/0x60 with crng_init=0
...
[    0.000000] BUG: unable to handle page fault for address: ff484d019580eff8
[    0.000000] #PF: supervisor read access in kernel mode
[    0.000000] #PF: error_code(0x0000) - not-present page
[    0.000000] BAD
[    0.000000] Oops: 0000 [#1] SMP NOPTI
[    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W         5.2.0-rc5+ #27
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.4
[    0.000000] RIP: 0010:fill_pud+0x13/0x130
[    0.000000] Code: 48 83 c4 08 b8 f4 ff ff ff 5b 41 5c 41 5d 41 5e 41 5f 5d c3 31 c0 c3 e8 2b ee d8 00 55 48 89 4
[    0.000000] RSP: 0000:ffffffff94403dc0 EFLAGS: 00000006
[    0.000000] RAX: 00000000000001ff RBX: ffffffffff5fd000 RCX: 0000000000000030
[    0.000000] RDX: 00000000000001ff RSI: ffffffffff5fd000 RDI: ff484d019580eff8
[    0.000000] RBP: ffffffff94403de0 R08: 0000000000000078 R09: 0000000000000002
[    0.000000] R10: ffffffff94403cb0 R11: 000000000000005b R12: ff484d019580eff8
[    0.000000] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    0.000000] FS:  0000000000000000(0000) GS:ffffffff9468a000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ff484d019580aa40 CR3: 000000031580a000 CR4: 00000000000016b0
[    0.000000] Call Trace:
[    0.000000]  set_pte_vaddr_p4d+0x2e/0x50
[    0.000000]  set_pte_vaddr+0x6f/0xb0
[    0.000000]  __native_set_fixmap+0x28/0x40
[    0.000000]  native_set_fixmap+0x39/0x70
[    0.000000]  register_lapic_address+0x49/0xb6
[    0.000000]  early_acpi_boot_init+0xa5/0xde
[    0.000000]  setup_arch+0x944/0xcf5
[    0.000000]  start_kernel+0x64/0x53b
[    0.000000]  ? copy_bootdata+0x1f/0xce
[    0.000000]  x86_64_start_reservations+0x24/0x26
[    0.000000]  x86_64_start_kernel+0x8a/0x8d
[    0.000000]  secondary_startup_64+0xb6/0xc0
[    0.000000] Modules linked in:
[    0.000000] CR2: ff484d019580eff8

Kyle bisected the issue to commmit b569c1843498 ("x86/mm/KASLR: Reduce
randomization granularity for 5-level paging to 1GB")

The commit relaxes KASLR alignment requirements and it can lead to
mismatch bentween 'i' and 'p4d_index(vaddr)' inside the loop in
phys_p4d_init(). The mismatch in its turn leads to clearing wrong p4d
entry and eventually to the oops.

The fix is to make phys_p4d_init() walk virtual address space, not
physical one.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-and-tested-by: Kyle Pelton <kyle.d.pelton@intel.com>
Fixes: b569c1843498 ("x86/mm/KASLR: Reduce randomization granularity for 5-level paging to 1GB")
Cc: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/init_64.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 693aaf28d5fe..4628ac9105a2 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -671,41 +671,34 @@ static unsigned long __meminit
 phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 	      unsigned long page_size_mask, bool init)
 {
-	unsigned long paddr_next, paddr_last = paddr_end;
-	unsigned long vaddr = (unsigned long)__va(paddr);
-	int i = p4d_index(vaddr);
+	unsigned long vaddr, vaddr_start, vaddr_end, vaddr_next, paddr_last;
+
+	paddr_last = paddr_end;
+	vaddr = (unsigned long)__va(paddr);
+	vaddr_end = (unsigned long)__va(paddr_end);
+	vaddr_start = vaddr;
 
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
 
-		if (paddr >= paddr_end) {
-			if (!after_bootmem &&
-			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
-					     E820_TYPE_RAM) &&
-			    !e820__mapped_any(paddr & P4D_MASK, paddr_next,
-					     E820_TYPE_RESERVED_KERN))
-				set_p4d_init(p4d, __p4d(0), init);
-			continue;
-		}
-
-		if (!p4d_none(*p4d)) {
-			pud = pud_offset(p4d, 0);
-			paddr_last = phys_pud_init(pud, paddr, paddr_end,
-						   page_size_mask, init);
+		if (p4d_val(*p4d)) {
+			pud = (pud_t *)p4d_page_vaddr(*p4d);
+			paddr_last = phys_pud_init(pud, __pa(vaddr),
+						   __pa(vaddr_end),
+						   page_size_mask,
+						   init);
 			continue;
 		}
 
 		pud = alloc_low_page();
-		paddr_last = phys_pud_init(pud, paddr, paddr_end,
+		paddr_last = phys_pud_init(pud, __pa(vaddr), __pa(vaddr_end),
 					   page_size_mask, init);
 
 		spin_lock(&init_mm.page_table_lock);
-- 
2.21.0

