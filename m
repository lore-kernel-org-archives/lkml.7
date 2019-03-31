Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69BAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A13320870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbfCaWLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:11:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57599 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731583AbfCaWK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:10:29 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hAiep-0004qn-A2; Mon, 01 Apr 2019 00:10:27 +0200
Message-Id: <20190331215135.313058385@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 31 Mar 2019 23:40:26 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [patch 06/14] x86/exceptions: Add structs for exception stacks
References: <20190331214020.836098943@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment everything assumes a full linear mapping of the various
exception stacks. Adding guard pages to the cpu entry area mapping of the
exception stacks will break that assumption.

As a preparatory step convert both the real storage and the effective
mapping in the cpu entry area from character arrays to structures.

To ensure that both arrays have the same ordering and the same size of the
individual stacks fill the members with a macro. The guard size is the only
difference between the two resulting structures. For now both have guard
size 0 until the preparation of all usage sites is done.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/cpu_entry_area.h |   35 +++++++++++++++++++++++++++++-----
 arch/x86/kernel/cpu/common.c          |    2 -
 arch/x86/mm/cpu_entry_area.c          |    8 ++-----
 3 files changed, 34 insertions(+), 11 deletions(-)

--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -7,6 +7,34 @@
 #include <asm/processor.h>
 #include <asm/intel_ds.h>
 
+#ifdef CONFIG_X86_64
+
+/* Macro to enforce the same ordering and stack sizes */
+#define ESTACKS_MEMBERS(guardsize)		\
+	char	DF_stack[EXCEPTION_STKSZ];	\
+	char	DF_stack_guard[guardsize];	\
+	char	NMI_stack[EXCEPTION_STKSZ];	\
+	char	NMI_stack_guard[guardsize];	\
+	char	DB_stack[DEBUG_STKSZ];		\
+	char	DB_stack_guard[guardsize];	\
+	char	MCE_stack[EXCEPTION_STKSZ];	\
+	char	MCE_stack_guard[guardsize];	\
+
+/* The exception stacks linear storage. No guard pages required */
+struct exception_stacks {
+	ESTACKS_MEMBERS(0)
+};
+
+/*
+ * The effective cpu entry area mapping with guard pages. Guard size is
+ * zero until the code which makes assumptions about linear mapping is
+ * cleaned up.
+ */
+struct cea_exception_stacks {
+	ESTACKS_MEMBERS(0)
+};
+#endif
+
 /*
  * cpu_entry_area is a percpu region that contains things needed by the CPU
  * and early entry/exit code.  Real types aren't used for all fields here
@@ -32,12 +60,9 @@ struct cpu_entry_area {
 
 #ifdef CONFIG_X86_64
 	/*
-	 * Exception stacks used for IST entries.
-	 *
-	 * In the future, this should have a separate slot for each stack
-	 * with guard pages between them.
+	 * Exception stacks used for IST entries with guard pages.
 	 */
-	char exception_stacks[(N_EXCEPTION_STACKS - 1) * EXCEPTION_STKSZ + DEBUG_STKSZ];
+	struct cea_exception_stacks estacks;
 #endif
 #ifdef CONFIG_CPU_SUP_INTEL
 	/*
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1754,7 +1754,7 @@ void cpu_init(void)
 	 * set up and load the per-CPU TSS
 	 */
 	if (!oist->ist[0]) {
-		char *estacks = get_cpu_entry_area(cpu)->exception_stacks;
+		char *estacks = (char *)&get_cpu_entry_area(cpu)->estacks;
 
 		for (v = 0; v < N_EXCEPTION_STACKS; v++) {
 			estacks += exception_stack_sizes[v];
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -13,8 +13,7 @@
 static DEFINE_PER_CPU_PAGE_ALIGNED(struct entry_stack_page, entry_stack_storage);
 
 #ifdef CONFIG_X86_64
-static DEFINE_PER_CPU_PAGE_ALIGNED(char, exception_stacks
-	[(N_EXCEPTION_STACKS - 1) * EXCEPTION_STKSZ + DEBUG_STKSZ]);
+static DEFINE_PER_CPU_PAGE_ALIGNED(struct exception_stacks, exception_stacks);
 #endif
 
 struct cpu_entry_area *get_cpu_entry_area(int cpu)
@@ -138,9 +137,8 @@ static void __init setup_cpu_entry_area(
 #ifdef CONFIG_X86_64
 	BUILD_BUG_ON(sizeof(exception_stacks) % PAGE_SIZE != 0);
 	BUILD_BUG_ON(sizeof(exception_stacks) !=
-		     sizeof(((struct cpu_entry_area *)0)->exception_stacks));
-	cea_map_percpu_pages(&cea->exception_stacks,
-			     &per_cpu(exception_stacks, cpu),
+		     sizeof(((struct cpu_entry_area *)0)->estacks));
+	cea_map_percpu_pages(&cea->estacks, &per_cpu(exception_stacks, cpu),
 			     sizeof(exception_stacks) / PAGE_SIZE, PAGE_KERNEL);
 #endif
 	percpu_setup_debug_store(cpu);


