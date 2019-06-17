Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D13C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572A1206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="wjc4Ijnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfFQOQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:16:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57339 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQOQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:16:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEFC6j3452293
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:15:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEFC6j3452293
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560780913;
        bh=5S1G3wfh/Qv3zSbWoGKS+ny1FXD0wxd0bocMu9kjhfw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=wjc4Ijndo5W9f9yxQNXeMHXYb3dWcCrqfeDQorH8NWpqam6531hpbJX3dDwpXOKnx
         zeAVVbIR1pduLz5nMFEmBEb/cEH5YSS7OPT+37AOsMGV1bywo6RTZJ8MU63Zvt7a88
         hC2yIJ8IiRCP74Sh28Bh69PnbiMS9t3EE/Lu40oBke42XhyN/hwSc+3gfjHpnBChy/
         HGjP/xrt1cZYSGTpSy7RS7eXIds8dd+LDefuJWpIaIBC3ehLmJmkeJ+d/sT7Q+YJpc
         DPOa+Ne2ezvZaV089u7emtkha8i+k1GcbCpcoubYMaemLnyDM0knAb/NQHQ0LSF4PF
         t/bhWA1ae88xQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEFCiW3452290;
        Mon, 17 Jun 2019 07:15:12 -0700
Date:   Mon, 17 Jun 2019 07:15:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Bristot de Oliveira <tipbot@zytor.com>
Message-ID: <tip-c0213b0ac03cf69f90fe5c6a8fe2c986630940fa@git.kernel.org>
Cc:     crecklin@redhat.com, peterz@infradead.org, jkosina@suse.cz,
        gregkh@linuxfoundation.org, bp@alien8.de, swood@redhat.com,
        bristot@redhat.com, hpa@zytor.com, williams@redhat.com,
        torvalds@linux-foundation.org, mhiramat@kernel.org,
        jpoimboe@redhat.com, jbaron@akamai.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, mtosatti@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de
Reply-To: crecklin@redhat.com, bristot@redhat.com, hpa@zytor.com,
          williams@redhat.com, jkosina@suse.cz, gregkh@linuxfoundation.org,
          peterz@infradead.org, bp@alien8.de, swood@redhat.com,
          mhiramat@kernel.org, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, mtosatti@redhat.com,
          rostedt@goodmis.org, tglx@linutronix.de, jbaron@akamai.com,
          jpoimboe@redhat.com, mingo@kernel.org
In-Reply-To: <ca506ed52584c80f64de23f6f55ca288e5d079de.1560325897.git.bristot@redhat.com>
References: <ca506ed52584c80f64de23f6f55ca288e5d079de.1560325897.git.bristot@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] x86/alternative: Batch of patch operations
Git-Commit-ID: c0213b0ac03cf69f90fe5c6a8fe2c986630940fa
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

Commit-ID:  c0213b0ac03cf69f90fe5c6a8fe2c986630940fa
Gitweb:     https://git.kernel.org/tip/c0213b0ac03cf69f90fe5c6a8fe2c986630940fa
Author:     Daniel Bristot de Oliveira <bristot@redhat.com>
AuthorDate: Wed, 12 Jun 2019 11:57:29 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:09:21 +0200

x86/alternative: Batch of patch operations

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Chris von Recklinghausen <crecklin@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Scott Wood <swood@redhat.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/ca506ed52584c80f64de23f6f55ca288e5d079de.1560325897.git.bristot@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/text-patching.h |  15 ++++
 arch/x86/kernel/alternative.c        | 154 +++++++++++++++++++++++++++--------
 2 files changed, 135 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 880b5515b1d6..d83e9f771d86 100644
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
+struct text_poke_loc {
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
+extern void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries);
 extern int after_bootmem;
 extern __ro_after_init struct mm_struct *poking_mm;
 extern __ro_after_init unsigned long poking_addr;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 390596b761e3..bd542f9b0953 100644
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
@@ -848,81 +849,133 @@ static void do_sync_core(void *info)
 	sync_core();
 }
 
-static bool bp_patching_in_progress;
-static void *bp_int3_handler, *bp_int3_addr;
+static struct bp_patching_desc {
+	struct text_poke_loc *vec;
+	int nr_entries;
+} bp_patching;
+
+static int patch_cmp(const void *key, const void *elt)
+{
+	struct text_poke_loc *tp = (struct text_poke_loc *) elt;
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
+	struct text_poke_loc *tp;
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
+			     sizeof(struct text_poke_loc),
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
+void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
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
@@ -931,14 +984,47 @@ void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
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
+	struct text_poke_loc tp = {
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
