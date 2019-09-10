Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECC3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D20120872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404012AbfIJGlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:41:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53005 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730080AbfIJGlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:41:32 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i7Zpv-0006wR-1M; Tue, 10 Sep 2019 08:41:11 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 688E41C0714;
        Tue, 10 Sep 2019 08:41:10 +0200 (CEST)
Date:   Tue, 10 Sep 2019 06:41:10 -0000
From:   "tip-bot2 for Brendan Shanks" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/umip: Add emulation (spoofing) for UMIP covered
 instructions in 64-bit processes as well
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Brendan Shanks <bshanks@codeweavers.com>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190905232222.14900-1-bshanks@codeweavers.com>
References: <20190905232222.14900-1-bshanks@codeweavers.com>
MIME-Version: 1.0
Message-ID: <156809767030.24167.5942247529564112051.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     e86c2c8b9380440bbe761b8e2f63ab6b04a45ac2
Gitweb:        https://git.kernel.org/tip/e86c2c8b9380440bbe761b8e2f63ab6b04a45ac2
Author:        Brendan Shanks <bshanks@codeweavers.com>
AuthorDate:    Thu, 05 Sep 2019 16:22:21 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Sep 2019 08:36:16 +02:00

x86/umip: Add emulation (spoofing) for UMIP covered instructions in 64-bit processes as well

Add emulation (spoofing) of the SGDT, SIDT, and SMSW instructions for 64-bit
processes.

Wine users have encountered a number of 64-bit Windows games that use
these instructions (particularly SGDT), and were crashing when run on
UMIP-enabled systems.

Originally-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Brendan Shanks <bshanks@codeweavers.com>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190905232222.14900-1-bshanks@codeweavers.com
[ Minor edits: capitalization, added 'spoofing' wording. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/umip.c | 65 +++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 5b345ad..548fefe 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -19,7 +19,7 @@
 /** DOC: Emulation for User-Mode Instruction Prevention (UMIP)
  *
  * The feature User-Mode Instruction Prevention present in recent Intel
- * processor prevents a group of instructions (sgdt, sidt, sldt, smsw, and str)
+ * processor prevents a group of instructions (SGDT, SIDT, SLDT, SMSW and STR)
  * from being executed with CPL > 0. Otherwise, a general protection fault is
  * issued.
  *
@@ -36,8 +36,8 @@
  * DOSEMU2) rely on this subset of instructions to function.
  *
  * The instructions protected by UMIP can be split in two groups. Those which
- * return a kernel memory address (sgdt and sidt) and those which return a
- * value (sldt, str and smsw).
+ * return a kernel memory address (SGDT and SIDT) and those which return a
+ * value (SLDT, STR and SMSW).
  *
  * For the instructions that return a kernel memory address, applications
  * such as WineHQ rely on the result being located in the kernel memory space,
@@ -45,15 +45,13 @@
  * value that, lies close to the top of the kernel memory. The limit for the GDT
  * and the IDT are set to zero.
  *
- * Given that sldt and str are not commonly used in programs that run on WineHQ
+ * Given that SLDT and STR are not commonly used in programs that run on WineHQ
  * or DOSEMU2, they are not emulated.
  *
  * The instruction smsw is emulated to return the value that the register CR0
  * has at boot time as set in the head_32.
  *
- * Also, emulation is provided only for 32-bit processes; 64-bit processes
- * that attempt to use the instructions that UMIP protects will receive the
- * SIGSEGV signal issued as a consequence of the general protection fault.
+ * Emulation is provided for both 32-bit and 64-bit processes.
  *
  * Care is taken to appropriately emulate the results when segmentation is
  * used. That is, rather than relying on USER_DS and USER_CS, the function
@@ -63,17 +61,18 @@
  * application uses a local descriptor table.
  */
 
-#define UMIP_DUMMY_GDT_BASE 0xfffe0000
-#define UMIP_DUMMY_IDT_BASE 0xffff0000
+#define UMIP_DUMMY_GDT_BASE 0xfffffffffffe0000ULL
+#define UMIP_DUMMY_IDT_BASE 0xffffffffffff0000ULL
 
 /*
  * The SGDT and SIDT instructions store the contents of the global descriptor
  * table and interrupt table registers, respectively. The destination is a
  * memory operand of X+2 bytes. X bytes are used to store the base address of
- * the table and 2 bytes are used to store the limit. In 32-bit processes, the
- * only processes for which emulation is provided, X has a value of 4.
+ * the table and 2 bytes are used to store the limit. In 32-bit processes X
+ * has a value of 4, in 64-bit processes X has a value of 8.
  */
-#define UMIP_GDT_IDT_BASE_SIZE 4
+#define UMIP_GDT_IDT_BASE_SIZE_64BIT 8
+#define UMIP_GDT_IDT_BASE_SIZE_32BIT 4
 #define UMIP_GDT_IDT_LIMIT_SIZE 2
 
 #define	UMIP_INST_SGDT	0	/* 0F 01 /0 */
@@ -189,6 +188,7 @@ static int identify_insn(struct insn *insn)
  * @umip_inst:	A constant indicating the instruction to emulate
  * @data:	Buffer into which the dummy result is stored
  * @data_size:	Size of the emulated result
+ * @x86_64:	true if process is 64-bit, false otherwise
  *
  * Emulate an instruction protected by UMIP and provide a dummy result. The
  * result of the emulation is saved in @data. The size of the results depends
@@ -202,11 +202,8 @@ static int identify_insn(struct insn *insn)
  * 0 on success, -EINVAL on error while emulating.
  */
 static int emulate_umip_insn(struct insn *insn, int umip_inst,
-			     unsigned char *data, int *data_size)
+			     unsigned char *data, int *data_size, bool x86_64)
 {
-	unsigned long dummy_base_addr, dummy_value;
-	unsigned short dummy_limit = 0;
-
 	if (!data || !data_size || !insn)
 		return -EINVAL;
 	/*
@@ -219,6 +216,9 @@ static int emulate_umip_insn(struct insn *insn, int umip_inst,
 	 * is always returned irrespective of the operand size.
 	 */
 	if (umip_inst == UMIP_INST_SGDT || umip_inst == UMIP_INST_SIDT) {
+		u64 dummy_base_addr;
+		u16 dummy_limit = 0;
+
 		/* SGDT and SIDT do not use registers operands. */
 		if (X86_MODRM_MOD(insn->modrm.value) == 3)
 			return -EINVAL;
@@ -228,13 +228,24 @@ static int emulate_umip_insn(struct insn *insn, int umip_inst,
 		else
 			dummy_base_addr = UMIP_DUMMY_IDT_BASE;
 
-		*data_size = UMIP_GDT_IDT_LIMIT_SIZE + UMIP_GDT_IDT_BASE_SIZE;
+		/*
+		 * 64-bit processes use the entire dummy base address.
+		 * 32-bit processes use the lower 32 bits of the base address.
+		 * dummy_base_addr is always 64 bits, but we memcpy the correct
+		 * number of bytes from it to the destination.
+		 */
+		if (x86_64)
+			*data_size = UMIP_GDT_IDT_BASE_SIZE_64BIT;
+		else
+			*data_size = UMIP_GDT_IDT_BASE_SIZE_32BIT;
+
+		memcpy(data + 2, &dummy_base_addr, *data_size);
 
-		memcpy(data + 2, &dummy_base_addr, UMIP_GDT_IDT_BASE_SIZE);
+		*data_size += UMIP_GDT_IDT_LIMIT_SIZE;
 		memcpy(data, &dummy_limit, UMIP_GDT_IDT_LIMIT_SIZE);
 
 	} else if (umip_inst == UMIP_INST_SMSW) {
-		dummy_value = CR0_STATE;
+		unsigned long dummy_value = CR0_STATE;
 
 		/*
 		 * Even though the CR0 register has 4 bytes, the number
@@ -290,11 +301,10 @@ static void force_sig_info_umip_fault(void __user *addr, struct pt_regs *regs)
  * fixup_umip_exception() - Fixup a general protection fault caused by UMIP
  * @regs:	Registers as saved when entering the #GP handler
  *
- * The instructions sgdt, sidt, str, smsw, sldt cause a general protection
- * fault if executed with CPL > 0 (i.e., from user space). If the offending
- * user-space process is not in long mode, this function fixes the exception
- * up and provides dummy results for sgdt, sidt and smsw; str and sldt are not
- * fixed up. Also long mode user-space processes are not fixed up.
+ * The instructions SGDT, SIDT, STR, SMSW and SLDT cause a general protection
+ * fault if executed with CPL > 0 (i.e., from user space). This function fixes
+ * the exception up and provides dummy results for SGDT, SIDT and SMSW; STR
+ * and SLDT are not fixed up.
  *
  * If operands are memory addresses, results are copied to user-space memory as
  * indicated by the instruction pointed by eIP using the registers indicated in
@@ -373,13 +383,14 @@ bool fixup_umip_exception(struct pt_regs *regs)
 	umip_pr_warning(regs, "%s instruction cannot be used by applications.\n",
 			umip_insns[umip_inst]);
 
-	/* Do not emulate SLDT, STR or user long mode processes. */
-	if (umip_inst == UMIP_INST_STR || umip_inst == UMIP_INST_SLDT || user_64bit_mode(regs))
+	/* Do not emulate (spoof) SLDT or STR. */
+	if (umip_inst == UMIP_INST_STR || umip_inst == UMIP_INST_SLDT)
 		return false;
 
 	umip_pr_warning(regs, "For now, expensive software emulation returns the result.\n");
 
-	if (emulate_umip_insn(&insn, umip_inst, dummy_data, &dummy_data_size))
+	if (emulate_umip_insn(&insn, umip_inst, dummy_data, &dummy_data_size,
+			      user_64bit_mode(regs)))
 		return false;
 
 	/*
