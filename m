Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7300C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B780C217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fs0OZdHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbfDQOIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:08:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39329 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbfDQOIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:08:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HE86Ng3933424
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:08:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HE86Ng3933424
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510086;
        bh=5l5PWGYmVDMIRsdgHjIT3d955sYZBjK0smycVSsAYZU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=fs0OZdHshc1hsX/kNhEwEx8FSvdE3j0F6rKdYur+hXdQpXNbkI9nQOFyhx8KQ0qv4
         JSsNppmCxwkW3MyBXwg65VCU5Ta0+9dL64o1TQ9ORL2BXZOAl9hIq4vyBsXpRh7K+4
         LrBpOSrC8W/8wxqDQELL0JbdFF0xbA/w2sDyVCGb+Eq4gkJWURdtYnNdV6UEut4rud
         5fFpLKIWdmBEQBBt8YstuKXHzZAZq1+mqjSfs/kX2+ZsW4rU1ysiCAisUwrHtiwCjL
         6Y3V5xk9v0qxSN/RQlUj0bE+7udcrpEEPMmS3iGYYyysTlOjKWatvXYBwf8jRccyHs
         Gv+7eHNBZzWNA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HE858g3933421;
        Wed, 17 Apr 2019 07:08:05 -0700
Date:   Wed, 17 Apr 2019 07:08:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-881a463cf21dbf83aab2cf6c9a359f34f88c2491@git.kernel.org>
Cc:     sean.j.christopherson@intel.com, mingo@redhat.com, hpa@zytor.com,
        mingo@kernel.org, bp@suse.de, x86@kernel.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de,
        jpoimboe@redhat.com
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          x86@kernel.org, bp@suse.de, mingo@redhat.com,
          sean.j.christopherson@intel.com, jpoimboe@redhat.com,
          tglx@linutronix.de, dave.hansen@linux.intel.com, luto@kernel.org,
          mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20190414160144.419653165@linutronix.de>
References: <20190414160144.419653165@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/cpu_entry_area: Cleanup setup functions
Git-Commit-ID: 881a463cf21dbf83aab2cf6c9a359f34f88c2491
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

Commit-ID:  881a463cf21dbf83aab2cf6c9a359f34f88c2491
Gitweb:     https://git.kernel.org/tip/881a463cf21dbf83aab2cf6c9a359f34f88c2491
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 17:59:46 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 12:50:46 +0200

x86/cpu_entry_area: Cleanup setup functions

No point in retrieving the entry area pointer over and over. Do it once
and use unsigned int for 'cpu' everywhere.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160144.419653165@linutronix.de
---
 arch/x86/mm/cpu_entry_area.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 19c6abf9ea31..c2a54f75d335 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -52,10 +52,10 @@ cea_map_percpu_pages(void *cea_vaddr, void *ptr, int pages, pgprot_t prot)
 		cea_set_pte(cea_vaddr, per_cpu_ptr_to_phys(ptr), prot);
 }
 
-static void __init percpu_setup_debug_store(int cpu)
+static void __init percpu_setup_debug_store(unsigned int cpu)
 {
 #ifdef CONFIG_CPU_SUP_INTEL
-	int npages;
+	unsigned int npages;
 	void *cea;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
@@ -79,8 +79,9 @@ static void __init percpu_setup_debug_store(int cpu)
 }
 
 /* Setup the fixmap mappings only once per-processor */
-static void __init setup_cpu_entry_area(int cpu)
+static void __init setup_cpu_entry_area(unsigned int cpu)
 {
+	struct cpu_entry_area *cea = get_cpu_entry_area(cpu);
 #ifdef CONFIG_X86_64
 	/* On 64-bit systems, we use a read-only fixmap GDT and TSS. */
 	pgprot_t gdt_prot = PAGE_KERNEL_RO;
@@ -101,10 +102,9 @@ static void __init setup_cpu_entry_area(int cpu)
 	pgprot_t tss_prot = PAGE_KERNEL;
 #endif
 
-	cea_set_pte(&get_cpu_entry_area(cpu)->gdt, get_cpu_gdt_paddr(cpu),
-		    gdt_prot);
+	cea_set_pte(&cea->gdt, get_cpu_gdt_paddr(cpu), gdt_prot);
 
-	cea_map_percpu_pages(&get_cpu_entry_area(cpu)->entry_stack_page,
+	cea_map_percpu_pages(&cea->entry_stack_page,
 			     per_cpu_ptr(&entry_stack_storage, cpu), 1,
 			     PAGE_KERNEL);
 
@@ -128,19 +128,18 @@ static void __init setup_cpu_entry_area(int cpu)
 	BUILD_BUG_ON((offsetof(struct tss_struct, x86_tss) ^
 		      offsetofend(struct tss_struct, x86_tss)) & PAGE_MASK);
 	BUILD_BUG_ON(sizeof(struct tss_struct) % PAGE_SIZE != 0);
-	cea_map_percpu_pages(&get_cpu_entry_area(cpu)->tss,
-			     &per_cpu(cpu_tss_rw, cpu),
+	cea_map_percpu_pages(&cea->tss, &per_cpu(cpu_tss_rw, cpu),
 			     sizeof(struct tss_struct) / PAGE_SIZE, tss_prot);
 
 #ifdef CONFIG_X86_32
-	per_cpu(cpu_entry_area, cpu) = get_cpu_entry_area(cpu);
+	per_cpu(cpu_entry_area, cpu) = cea;
 #endif
 
 #ifdef CONFIG_X86_64
 	BUILD_BUG_ON(sizeof(exception_stacks) % PAGE_SIZE != 0);
 	BUILD_BUG_ON(sizeof(exception_stacks) !=
 		     sizeof(((struct cpu_entry_area *)0)->exception_stacks));
-	cea_map_percpu_pages(&get_cpu_entry_area(cpu)->exception_stacks,
+	cea_map_percpu_pages(&cea->exception_stacks,
 			     &per_cpu(exception_stacks, cpu),
 			     sizeof(exception_stacks) / PAGE_SIZE, PAGE_KERNEL);
 #endif
