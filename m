Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185AEC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43BF2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oILNkBTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfD0Gow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:44:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33570 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfD0GnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:43:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id y3so1735586plp.0;
        Fri, 26 Apr 2019 23:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uR9dojmxOmmxTLzrNkqbIEwKeNq3pUquy4Aauxui5YA=;
        b=oILNkBTMPI8hbOfV9CTJU+m4eHw0hAUfxbTTNr2/RxOTWPpKbRKo8diZaBeA/Rmbm3
         h5rZrB3HG0y3SmWymgT3Ka+NNLrVVEWGy5GTcbQKRQEA3wiSNrIdF0YIzNUEW260wZEH
         KE+3wzmKUfVn5aWbi1XY/cRblwX7PCPz65YSoU43s/26wSMoHptHFPQTS+iXil5iGEw+
         MKuU4t2I8rSFdXKCm6I3uOxZEQ1YYZq5IGQ+JuIwxQpw5oc2ihHafO/Cd4i7/tLG7zpn
         Edmk3MnDF5/iWexA4JDZ+DyyFjQlaqdQ8ZangVzJbGAkvZg6LY9bd008qQlPu4OkFzMW
         +mVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uR9dojmxOmmxTLzrNkqbIEwKeNq3pUquy4Aauxui5YA=;
        b=nptgxHFBLqFEODoHlGZciETAIKKIVwAxD4g/OUwG5sL3lzUAu0kiOBuheipDAsMRkJ
         Fu9WJFJoAcWAAIvTIGMcEdl4JDgPFPMgTLn53+dyrWSO270qBcdYfpCd2GwQjBIJVRXq
         VXzA8WCOjVD8hLH+++AiDVCUlykBqt7EAENqehgb5BRKy8FH13JjXzrolot50E4JnN3R
         xknmGB8SbbuFl/um7bWWQ/qe9V8GpYurEr7hLqq/WimcXcp5XN2yOCI08/EnZ8WBrP+4
         hcfzJy+K99lrpTs5fiXGQbvpjrojkkqaUS+9uaGH4ghWdsE44gda8Au0vI5ugCl7biyU
         dQzA==
X-Gm-Message-State: APjAAAUr8epavH373chztnRgEaFBaNlg/KeDFbhnEdAM08jQ5mG8Mf1J
        LYceWKH+Okq5l7Zqd2yWDeQ=
X-Google-Smtp-Source: APXvYqxGAw4qwJwGwZPBWfL5T3kXq42Nxulr2Eo5xhNgNYA2PVHpEfWTNqR9D9nfEhSjkOIDkP0Vjg==
X-Received: by 2002:a17:902:e683:: with SMTP id cn3mr6142181plb.115.1556347395492;
        Fri, 26 Apr 2019 23:43:15 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j22sm36460145pfn.129.2019.04.26.23.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 23:43:14 -0700 (PDT)
From:   nadav.amit@gmail.com
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v6 08/24] x86/alternative: Use temporary mm for text poking
Date:   Fri, 26 Apr 2019 16:22:47 -0700
Message-Id: <20190426232303.28381-9-nadav.amit@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426232303.28381-1-nadav.amit@gmail.com>
References: <20190426232303.28381-1-nadav.amit@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

text_poke() can potentially compromise security as it sets temporary
PTEs in the fixmap. These PTEs might be used to rewrite the kernel code
from other cores accidentally or maliciously, if an attacker gains the
ability to write onto kernel memory.

Moreover, since remote TLBs are not flushed after the temporary PTEs are
removed, the time-window in which the code is writable is not limited if
the fixmap PTEs - maliciously or accidentally - are cached in the TLB.
To address these potential security hazards, use a temporary mm for
patching the code.

Finally, text_poke() is also not conservative enough when mapping pages,
as it always tries to map 2 pages, even when a single one is sufficient.
So try to be more conservative, and do not map more than needed.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/fixmap.h |   2 -
 arch/x86/kernel/alternative.c | 108 +++++++++++++++++++++++++++-------
 arch/x86/xen/mmu_pv.c         |   2 -
 3 files changed, 86 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index 50ba74a34a37..9da8cccdf3fb 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -103,8 +103,6 @@ enum fixed_addresses {
 #ifdef CONFIG_PARAVIRT
 	FIX_PARAVIRT_BOOTMAP,
 #endif
-	FIX_TEXT_POKE1,	/* reserve 2 pages for text_poke() */
-	FIX_TEXT_POKE0, /* first page is last, because allocation is backward */
 #ifdef	CONFIG_X86_INTEL_MID
 	FIX_LNW_VRTC,
 #endif
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 11d5c710a94f..599203876c32 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/kdebug.h>
 #include <linux/kprobes.h>
+#include <linux/mmu_context.h>
 #include <asm/text-patching.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
@@ -684,41 +685,104 @@ __ro_after_init unsigned long poking_addr;
 
 static void *__text_poke(void *addr, const void *opcode, size_t len)
 {
+	bool cross_page_boundary = offset_in_page(addr) + len > PAGE_SIZE;
+	struct page *pages[2] = {NULL};
+	temp_mm_state_t prev;
 	unsigned long flags;
-	char *vaddr;
-	struct page *pages[2];
-	int i;
+	pte_t pte, *ptep;
+	spinlock_t *ptl;
+	pgprot_t pgprot;
 
 	/*
-	 * While boot memory allocator is runnig we cannot use struct
-	 * pages as they are not yet initialized.
+	 * While boot memory allocator is running we cannot use struct pages as
+	 * they are not yet initialized. There is no way to recover.
 	 */
 	BUG_ON(!after_bootmem);
 
 	if (!core_kernel_text((unsigned long)addr)) {
 		pages[0] = vmalloc_to_page(addr);
-		pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
+		if (cross_page_boundary)
+			pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
 	} else {
 		pages[0] = virt_to_page(addr);
 		WARN_ON(!PageReserved(pages[0]));
-		pages[1] = virt_to_page(addr + PAGE_SIZE);
+		if (cross_page_boundary)
+			pages[1] = virt_to_page(addr + PAGE_SIZE);
 	}
-	BUG_ON(!pages[0]);
+	/*
+	 * If something went wrong, crash and burn since recovery paths are not
+	 * implemented.
+	 */
+	BUG_ON(!pages[0] || (cross_page_boundary && !pages[1]));
+
 	local_irq_save(flags);
-	set_fixmap(FIX_TEXT_POKE0, page_to_phys(pages[0]));
-	if (pages[1])
-		set_fixmap(FIX_TEXT_POKE1, page_to_phys(pages[1]));
-	vaddr = (char *)fix_to_virt(FIX_TEXT_POKE0);
-	memcpy(&vaddr[(unsigned long)addr & ~PAGE_MASK], opcode, len);
-	clear_fixmap(FIX_TEXT_POKE0);
-	if (pages[1])
-		clear_fixmap(FIX_TEXT_POKE1);
-	local_flush_tlb();
-	sync_core();
-	/* Could also do a CLFLUSH here to speed up CPU recovery; but
-	   that causes hangs on some VIA CPUs. */
-	for (i = 0; i < len; i++)
-		BUG_ON(((char *)addr)[i] != ((char *)opcode)[i]);
+
+	/*
+	 * Map the page without the global bit, as TLB flushing is done with
+	 * flush_tlb_mm_range(), which is intended for non-global PTEs.
+	 */
+	pgprot = __pgprot(pgprot_val(PAGE_KERNEL) & ~_PAGE_GLOBAL);
+
+	/*
+	 * The lock is not really needed, but this allows to avoid open-coding.
+	 */
+	ptep = get_locked_pte(poking_mm, poking_addr, &ptl);
+
+	/*
+	 * This must not fail; preallocated in poking_init().
+	 */
+	VM_BUG_ON(!ptep);
+
+	pte = mk_pte(pages[0], pgprot);
+	set_pte_at(poking_mm, poking_addr, ptep, pte);
+
+	if (cross_page_boundary) {
+		pte = mk_pte(pages[1], pgprot);
+		set_pte_at(poking_mm, poking_addr + PAGE_SIZE, ptep + 1, pte);
+	}
+
+	/*
+	 * Loading the temporary mm behaves as a compiler barrier, which
+	 * guarantees that the PTE will be set at the time memcpy() is done.
+	 */
+	prev = use_temporary_mm(poking_mm);
+
+	kasan_disable_current();
+	memcpy((u8 *)poking_addr + offset_in_page(addr), opcode, len);
+	kasan_enable_current();
+
+	/*
+	 * Ensure that the PTE is only cleared after the instructions of memcpy
+	 * were issued by using a compiler barrier.
+	 */
+	barrier();
+
+	pte_clear(poking_mm, poking_addr, ptep);
+	if (cross_page_boundary)
+		pte_clear(poking_mm, poking_addr + PAGE_SIZE, ptep + 1);
+
+	/*
+	 * Loading the previous page-table hierarchy requires a serializing
+	 * instruction that already allows the core to see the updated version.
+	 * Xen-PV is assumed to serialize execution in a similar manner.
+	 */
+	unuse_temporary_mm(prev);
+
+	/*
+	 * Flushing the TLB might involve IPIs, which would require enabled
+	 * IRQs, but not if the mm is not used, as it is in this point.
+	 */
+	flush_tlb_mm_range(poking_mm, poking_addr, poking_addr +
+			   (cross_page_boundary ? 2 : 1) * PAGE_SIZE,
+			   PAGE_SHIFT, false);
+
+	/*
+	 * If the text does not match what we just wrote then something is
+	 * fundamentally screwy; there's nothing we can really do about that.
+	 */
+	BUG_ON(memcmp(addr, opcode, len));
+
+	pte_unmap_unlock(ptep, ptl);
 	local_irq_restore(flags);
 	return addr;
 }
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index a21e1734fc1f..beb44e22afdf 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2318,8 +2318,6 @@ static void xen_set_fixmap(unsigned idx, phys_addr_t phys, pgprot_t prot)
 #elif defined(CONFIG_X86_VSYSCALL_EMULATION)
 	case VSYSCALL_PAGE:
 #endif
-	case FIX_TEXT_POKE0:
-	case FIX_TEXT_POKE1:
 		/* All local page mappings */
 		pte = pfn_pte(phys, prot);
 		break;
-- 
2.17.1

