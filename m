Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AFAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E55C20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbfCaWKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:10:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57628 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731645AbfCaWKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:10:33 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hAiet-0004rS-GT; Mon, 01 Apr 2019 00:10:31 +0200
Message-Id: <20190331215135.858900919@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 31 Mar 2019 23:40:32 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [patch 12/14] x86/cpu: Prepare TSS.IST setup for guard pages
References: <20190331214020.836098943@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the TSS.IST setup code to use the cpu entry area information
directly instead of assuming a linear mapping of the IST stacks.

The store to orig_ist[] is not longer required as there are no users
anymore.

This is the last preparatory step for IST guard pages.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/common.c |   35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -507,19 +507,6 @@ void load_percpu_segment(int cpu)
 DEFINE_PER_CPU(struct cpu_entry_area *, cpu_entry_area);
 #endif
 
-#ifdef CONFIG_X86_64
-/*
- * Special IST stacks which the CPU switches to when it calls
- * an IST-marked descriptor entry. Up to 7 stacks (hardware
- * limit), all of them are 4K, except the debug stack which
- * is 8K.
- */
-static const unsigned int exception_stack_sizes[N_EXCEPTION_STACKS] = {
-	  [0 ... N_EXCEPTION_STACKS - 1]	= EXCEPTION_STKSZ,
-	  [DEBUG_IST]				= DEBUG_STKSZ
-};
-#endif
-
 /* Load the original GDT from the per-cpu structure */
 void load_direct_gdt(int cpu)
 {
@@ -1690,17 +1677,14 @@ static void setup_getcpu(int cpu)
  * initialized (naturally) in the bootstrap process, such as the GDT
  * and IDT. We reload them nevertheless, this function acts as a
  * 'CPU state barrier', nothing should get across.
- * A lot of state is already set up in PDA init for 64 bit
  */
 #ifdef CONFIG_X86_64
 
 void cpu_init(void)
 {
-	struct orig_ist *oist;
+	int cpu = raw_smp_processor_id();
 	struct task_struct *me;
 	struct tss_struct *t;
-	unsigned long v;
-	int cpu = raw_smp_processor_id();
 	int i;
 
 	wait_for_master_cpu(cpu);
@@ -1715,7 +1699,6 @@ void cpu_init(void)
 		load_ucode_ap();
 
 	t = &per_cpu(cpu_tss_rw, cpu);
-	oist = &per_cpu(orig_ist, cpu);
 
 #ifdef CONFIG_NUMA
 	if (this_cpu_read(numa_node) == 0 &&
@@ -1753,16 +1736,12 @@ void cpu_init(void)
 	/*
 	 * set up and load the per-CPU TSS
 	 */
-	if (!oist->ist[0]) {
-		char *estacks = (char *)&get_cpu_entry_area(cpu)->estacks;
-
-		for (v = 0; v < N_EXCEPTION_STACKS; v++) {
-			estacks += exception_stack_sizes[v];
-			oist->ist[v] = t->x86_tss.ist[v] =
-					(unsigned long)estacks;
-			if (v == DEBUG_IST)
-				per_cpu(debug_stack_addr, cpu) = (unsigned long)estacks;
-		}
+	if (!t->x86_tss.ist[0]) {
+		t->x86_tss.ist[DOUBLEFAULT_IST] = __this_cpu_ist_top_va(DF);
+		t->x86_tss.ist[NMI_IST] = __this_cpu_ist_top_va(NMI);
+		t->x86_tss.ist[DEBUG_IST] = __this_cpu_ist_top_va(DB);
+		t->x86_tss.ist[MCE_IST] = __this_cpu_ist_top_va(MCE);
+		per_cpu(debug_stack_addr, cpu) = t->x86_tss.ist[DEBUG_IST];
 	}
 
 	t->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET;


