Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE66C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAE020870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbfCaWLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:11:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57595 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731580AbfCaWK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:10:29 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hAieo-0004qa-Hr; Mon, 01 Apr 2019 00:10:26 +0200
Message-Id: <20190331215135.223645571@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 31 Mar 2019 23:40:25 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [patch 05/14] x86/cpu_entry_area: Cleanup setup functions
References: <20190331214020.836098943@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No point in retrieving the entry area pointer over and over. Do it once and
use unsigned int for 'cpu' consistently.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/mm/cpu_entry_area.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -52,10 +52,10 @@ cea_map_percpu_pages(void *cea_vaddr, vo
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
@@ -79,8 +79,9 @@ static void __init percpu_setup_debug_st
 }
 
 /* Setup the fixmap mappings only once per-processor */
-static void __init setup_cpu_entry_area(int cpu)
+static void __init setup_cpu_entry_area(unsigned int cpu)
 {
+	struct cpu_entry_area *cea = get_cpu_entry_area(cpu);
 #ifdef CONFIG_X86_64
 	/* On 64-bit systems, we use a read-only fixmap GDT and TSS. */
 	pgprot_t gdt_prot = PAGE_KERNEL_RO;
@@ -101,10 +102,9 @@ static void __init setup_cpu_entry_area(
 	pgprot_t tss_prot = PAGE_KERNEL;
 #endif
 
-	cea_set_pte(&get_cpu_entry_area(cpu)->gdt, get_cpu_gdt_paddr(cpu),
-		    gdt_prot);
+	cea_set_pte(&cea->gdt, get_cpu_gdt_paddr(cpu), gdt_prot);
 
-	cea_map_percpu_pages(&get_cpu_entry_area(cpu)->entry_stack_page,
+	cea_map_percpu_pages(&cea->entry_stack_page,
 			     per_cpu_ptr(&entry_stack_storage, cpu), 1,
 			     PAGE_KERNEL);
 
@@ -128,19 +128,18 @@ static void __init setup_cpu_entry_area(
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


