Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7387AC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEBF21734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437872AbfFLJ5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:57:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731931AbfFLJ5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:57:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D7413082129;
        Wed, 12 Jun 2019 09:57:53 +0000 (UTC)
Received: from localhost.default (ovpn-116-101.phx2.redhat.com [10.3.116.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86A992CFA7;
        Wed, 12 Jun 2019 09:57:50 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: [PATCH V6 4/6] x86/alternative: Batch of patch operations
Date:   Wed, 12 Jun 2019 11:57:29 +0200
Message-Id: <ca506ed52584c80f64de23f6f55ca288e5d079de.1560325897.git.bristot@redhat.com>
In-Reply-To: <cover.1560325897.git.bristot@redhat.com>
References: <cover.1560325897.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 12 Jun 2019 09:57:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the patch of an address is done in three steps:

-- Pseudo-code #1 - Current implementation ---
        1) add an int3 trap to the address that will be patched
            sync cores (send IPI to all other CPUs)
        2) update all but the first byte of the patched range
            sync cores (send IPI to all other CPUs)
        3) replace the first byte (int3) by the first byte of replacing opcode
            sync cores (send IPI to all other CPUs)
-- Pseudo-code #1 ---

When a static key has more than one entry, these steps are called once for
each entry. The number of IPIs then is linear with regard to the number 'n' of
entries of a key: O(n*3), which is O(n).

This algorithm works fine for the update of a single key. But we think
it is possible to optimize the case in which a static key has more than
one entry. For instance, the sched_schedstats jump label has 56 entries
in my (updated) fedora kernel, resulting in 168 IPIs for each CPU in
which the thread that is enabling the key is _not_ running.

With this patch, rather than receiving a single patch to be processed, a vector
of patches is passed, enabling the rewrite of the pseudo-code #1 in this
way:

-- Pseudo-code #2 - This patch  ---
1)  for each patch in the vector:
        add an int3 trap to the address that will be patched

    sync cores (send IPI to all other CPUs)

2)  for each patch in the vector:
        update all but the first byte of the patched range

    sync cores (send IPI to all other CPUs)

3)  for each patch in the vector:
        replace the first byte (int3) by the first byte of replacing opcode

    sync cores (send IPI to all other CPUs)
-- Pseudo-code #2 - This patch  ---

Doing the update in this way, the number of IPI becomes O(3) with regard
to the number of keys, which is O(1).

The batch mode is done with the function text_poke_bp_batch(), that receives
two arguments: a vector of "struct text_to_poke", and the number of entries
in the vector.

The vector must be sorted by the addr field of the text_to_poke structure,
enabling the binary search of a handler in the poke_int3_handler function
(a fast path).

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Chris von Recklinghausen <crecklin@redhat.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Scott Wood <swood@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/text-patching.h |  15 +++
 arch/x86/kernel/alternative.c        | 154 +++++++++++++++++++++------
 2 files changed, 135 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 880b5515b1d6..e1ae038d44f8 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -18,6 +18,20 @@ static inline void apply_paravirt(struct paravirt_patch_site *start,
 #define __parainstructions_end	NULL
 #endif
 
+/*
+ * Currently, the max observed size in the kernel code is
+ * JUMP_LABEL_NOP_SIZE/RELATIVEJUMP_SIZE, which are 5.
+ * Raise it if needed.
+ */
+#define POKE_MAX_OPCODE_SIZE	5
+
+struct text_patch_loc {
+	void *detour;
+	void *addr;
+	size_t len;
+	const char opcode[POKE_MAX_OPCODE_SIZE];
+};
+
 extern void text_poke_early(void *addr, const void *opcode, size_t len);
 
 /*
@@ -38,6 +52,7 @@ extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
+extern void text_poke_bp_batch(struct text_patch_loc *tp, unsigned int nr_entries);
 extern int after_bootmem;
 extern __ro_after_init struct mm_struct *poking_mm;
 extern __ro_after_init unsigned long poking_addr;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 0d57015114e7..dc5dc697492a 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -14,6 +14,7 @@
 #include <linux/kdebug.h>
 #include <linux/kprobes.h>
 #include <linux/mmu_context.h>
+#include <linux/bsearch.h>
 #include <asm/text-patching.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
@@ -847,81 +848,133 @@ static void do_sync_core(void *info)
 	sync_core();
 }
 
-static bool bp_patching_in_progress;
-static void *bp_int3_handler, *bp_int3_addr;
+static struct bp_patching_desc {
+	struct text_patch_loc *vec;
+	int nr_entries;
+} bp_patching;
+
+static int patch_cmp(const void *key, const void *elt)
+{
+	struct text_patch_loc *tp = (struct text_patch_loc *) elt;
+
+	if (key < tp->addr)
+		return -1;
+	if (key > tp->addr)
+		return 1;
+	return 0;
+}
+NOKPROBE_SYMBOL(patch_cmp);
 
 int poke_int3_handler(struct pt_regs *regs)
 {
+	struct text_patch_loc *tp;
+	unsigned char int3 = 0xcc;
+	void *ip;
+
 	/*
 	 * Having observed our INT3 instruction, we now must observe
-	 * bp_patching_in_progress.
+	 * bp_patching.nr_entries.
 	 *
-	 * 	in_progress = TRUE		INT3
+	 * 	nr_entries != 0			INT3
 	 * 	WMB				RMB
-	 * 	write INT3			if (in_progress)
+	 * 	write INT3			if (nr_entries)
 	 *
-	 * Idem for bp_int3_handler.
+	 * Idem for other elements in bp_patching.
 	 */
 	smp_rmb();
 
-	if (likely(!bp_patching_in_progress))
+	if (likely(!bp_patching.nr_entries))
 		return 0;
 
-	if (user_mode(regs) || regs->ip != (unsigned long)bp_int3_addr)
+	if (user_mode(regs))
 		return 0;
 
-	/* set up the specified breakpoint handler */
-	regs->ip = (unsigned long) bp_int3_handler;
+	/*
+	 * Discount the sizeof(int3). See text_poke_bp_batch().
+	 */
+	ip = (void *) regs->ip - sizeof(int3);
+
+	/*
+	 * Skip the binary search if there is a single member in the vector.
+	 */
+	if (unlikely(bp_patching.nr_entries > 1)) {
+		tp = bsearch(ip, bp_patching.vec, bp_patching.nr_entries,
+			     sizeof(struct text_patch_loc),
+			     patch_cmp);
+		if (!tp)
+			return 0;
+	} else {
+		tp = bp_patching.vec;
+		if (tp->addr != ip)
+			return 0;
+	}
+
+	/* set up the specified breakpoint detour */
+	regs->ip = (unsigned long) tp->detour;
 
 	return 1;
 }
 NOKPROBE_SYMBOL(poke_int3_handler);
 
 /**
- * text_poke_bp() -- update instructions on live kernel on SMP
- * @addr:	address to patch
- * @opcode:	opcode of new instruction
- * @len:	length to copy
- * @handler:	address to jump to when the temporary breakpoint is hit
+ * text_poke_bp_batch() -- update instructions on live kernel on SMP
+ * @tp:			vector of instructions to patch
+ * @nr_entries:		number of entries in the vector
  *
  * Modify multi-byte instruction by using int3 breakpoint on SMP.
  * We completely avoid stop_machine() here, and achieve the
  * synchronization using int3 breakpoint.
  *
  * The way it is done:
- *	- add a int3 trap to the address that will be patched
+ * 	- For each entry in the vector:
+ *		- add a int3 trap to the address that will be patched
  *	- sync cores
- *	- update all but the first byte of the patched range
+ *	- For each entry in the vector:
+ *		- update all but the first byte of the patched range
  *	- sync cores
- *	- replace the first byte (int3) by the first byte of
- *	  replacing opcode
+ *	- For each entry in the vector:
+ *		- replace the first byte (int3) by the first byte of
+ *		  replacing opcode
  *	- sync cores
  */
-void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
+void text_poke_bp_batch(struct text_patch_loc *tp, unsigned int nr_entries)
 {
+	int patched_all_but_first = 0;
 	unsigned char int3 = 0xcc;
-
-	bp_int3_handler = handler;
-	bp_int3_addr = (u8 *)addr + sizeof(int3);
-	bp_patching_in_progress = true;
+	unsigned int i;
 
 	lockdep_assert_held(&text_mutex);
 
+	bp_patching.vec = tp;
+	bp_patching.nr_entries = nr_entries;
+
 	/*
 	 * Corresponding read barrier in int3 notifier for making sure the
-	 * in_progress and handler are correctly ordered wrt. patching.
+	 * nr_entries and handler are correctly ordered wrt. patching.
 	 */
 	smp_wmb();
 
-	text_poke(addr, &int3, sizeof(int3));
+	/*
+	 * First step: add a int3 trap to the address that will be patched.
+	 */
+	for (i = 0; i < nr_entries; i++)
+		text_poke(tp[i].addr, &int3, sizeof(int3));
 
 	on_each_cpu(do_sync_core, NULL, 1);
 
-	if (len - sizeof(int3) > 0) {
-		/* patch all but the first byte */
-		text_poke((char *)addr + sizeof(int3),
-			  (const char *) opcode + sizeof(int3),
-			  len - sizeof(int3));
+	/*
+	 * Second step: update all but the first byte of the patched range.
+	 */
+	for (i = 0; i < nr_entries; i++) {
+		if (tp[i].len - sizeof(int3) > 0) {
+			text_poke((char *)tp[i].addr + sizeof(int3),
+				  (const char *)tp[i].opcode + sizeof(int3),
+				  tp[i].len - sizeof(int3));
+			patched_all_but_first++;
+		}
+	}
+
+	if (patched_all_but_first) {
 		/*
 		 * According to Intel, this core syncing is very likely
 		 * not necessary and we'd be safe even without it. But
@@ -930,14 +983,47 @@ void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 		on_each_cpu(do_sync_core, NULL, 1);
 	}
 
-	/* patch the first byte */
-	text_poke(addr, opcode, sizeof(int3));
+	/*
+	 * Third step: replace the first byte (int3) by the first byte of
+	 * replacing opcode.
+	 */
+	for (i = 0; i < nr_entries; i++)
+		text_poke(tp[i].addr, tp[i].opcode, sizeof(int3));
 
 	on_each_cpu(do_sync_core, NULL, 1);
 	/*
 	 * sync_core() implies an smp_mb() and orders this store against
 	 * the writing of the new instruction.
 	 */
-	bp_patching_in_progress = false;
+	bp_patching.vec = NULL;
+	bp_patching.nr_entries = 0;
 }
 
+/**
+ * text_poke_bp() -- update instructions on live kernel on SMP
+ * @addr:	address to patch
+ * @opcode:	opcode of new instruction
+ * @len:	length to copy
+ * @handler:	address to jump to when the temporary breakpoint is hit
+ *
+ * Update a single instruction with the vector in the stack, avoiding
+ * dynamically allocated memory. This function should be used when it is
+ * not possible to allocate memory.
+ */
+void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
+{
+	struct text_patch_loc tp = {
+		.detour = handler,
+		.addr = addr,
+		.len = len,
+	};
+
+	if (len > POKE_MAX_OPCODE_SIZE) {
+		WARN_ONCE(1, "len is larger than %d\n", POKE_MAX_OPCODE_SIZE);
+		return;
+	}
+
+	memcpy((void *)tp.opcode, opcode, len);
+
+	text_poke_bp_batch(&tp, 1);
+}
-- 
2.20.1

