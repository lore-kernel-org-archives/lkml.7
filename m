Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93753C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680EA20684
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfDNQCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:02:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43259 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbfDNQCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 12:02:38 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFhaW-0002cQ-KO; Sun, 14 Apr 2019 18:02:36 +0200
Message-Id: <20190414160144.680960459@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 14 Apr 2019 17:59:49 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V3 13/32] x86/cpu_entry_area: Provide exception stack accessor
References: <20190414155936.679808307@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store a pointer to the per cpu entry area exception stack mappings to allow
fast retrieval.

Required for converting various places from using the shadow IST array to
directly doing address calculations on the actual mapping address.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/cpu_entry_area.h |    4 ++++
 arch/x86/mm/cpu_entry_area.c          |    4 ++++
 2 files changed, 8 insertions(+)

--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -98,6 +98,7 @@ struct cpu_entry_area {
 #define CPU_ENTRY_AREA_TOT_SIZE	(CPU_ENTRY_AREA_SIZE * NR_CPUS)
 
 DECLARE_PER_CPU(struct cpu_entry_area *, cpu_entry_area);
+DECLARE_PER_CPU(struct cea_exception_stacks *, cea_exception_stacks);
 
 extern void setup_cpu_entry_areas(void);
 extern void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags);
@@ -117,4 +118,7 @@ static inline struct entry_stack *cpu_en
 	return &get_cpu_entry_area(cpu)->entry_stack_page.stack;
 }
 
+#define __this_cpu_ist_top_va(name)					\
+	CEA_ESTACK_TOP(__this_cpu_read(cea_exception_stacks), name)
+
 #endif
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -14,6 +14,7 @@ static DEFINE_PER_CPU_PAGE_ALIGNED(struc
 
 #ifdef CONFIG_X86_64
 static DEFINE_PER_CPU_PAGE_ALIGNED(struct exception_stacks, exception_stacks);
+DEFINE_PER_CPU(struct cea_exception_stacks*, cea_exception_stacks);
 #endif
 
 struct cpu_entry_area *get_cpu_entry_area(int cpu)
@@ -92,6 +93,9 @@ static void __init percpu_setup_exceptio
 	unsigned int npages;
 
 	BUILD_BUG_ON(sizeof(exception_stacks) % PAGE_SIZE != 0);
+
+	per_cpu(cea_exception_stacks, cpu) = &cea->estacks;
+
 	/*
 	 * The exceptions stack mappings in the per cpu area are protected
 	 * by guard pages so each stack must be mapped separately.


