Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42C2C0044D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCB32068E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfLDIef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:34:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56437 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfLDId7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:33:59 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icQ6P-0005JL-RL; Wed, 04 Dec 2019 09:33:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 69FBA1C2659;
        Wed,  4 Dec 2019 09:33:36 +0100 (CET)
Date:   Wed, 04 Dec 2019 08:33:36 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] x86/alternative: Shrink text_poke_loc
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191111132458.047052889@infradead.org>
References: <20191111132458.047052889@infradead.org>
MIME-Version: 1.0
Message-ID: <157544841633.21853.4174660841263079781.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/kprobes branch of tip:

Commit-ID:     4531ef6a8aaf132aa32e2e26670c652942540633
Gitweb:        https://git.kernel.org/tip/4531ef6a8aaf132aa32e2e26670c652942540633
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 09 Oct 2019 12:26:53 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 27 Nov 2019 07:44:24 +01:00

x86/alternative: Shrink text_poke_loc

Employ the fact that all text must be within a s32 displacement of one
another to shrink the text_poke_loc::addr field. Make it relative to
_stext.

This then shrinks struct text_poke_loc to 16 bytes, and consequently
increases TP_VEC_MAX from 170 to 256.

Tested-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191111132458.047052889@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/alternative.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 6e3ee73..526cc5f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -937,7 +937,7 @@ static void do_sync_core(void *info)
 }
 
 struct text_poke_loc {
-	void *addr;
+	s32 rel_addr; /* addr := _stext + rel_addr */
 	s32 rel32;
 	u8 opcode;
 	const u8 text[POKE_MAX_OPCODE_SIZE];
@@ -948,13 +948,18 @@ static struct bp_patching_desc {
 	int nr_entries;
 } bp_patching;
 
+static inline void *text_poke_addr(struct text_poke_loc *tp)
+{
+	return _stext + tp->rel_addr;
+}
+
 static int notrace patch_cmp(const void *key, const void *elt)
 {
 	struct text_poke_loc *tp = (struct text_poke_loc *) elt;
 
-	if (key < tp->addr)
+	if (key < text_poke_addr(tp))
 		return -1;
-	if (key > tp->addr)
+	if (key > text_poke_addr(tp))
 		return 1;
 	return 0;
 }
@@ -1000,7 +1005,7 @@ int notrace poke_int3_handler(struct pt_regs *regs)
 			return 0;
 	} else {
 		tp = bp_patching.vec;
-		if (tp->addr != ip)
+		if (text_poke_addr(tp) != ip)
 			return 0;
 	}
 
@@ -1078,7 +1083,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * First step: add a int3 trap to the address that will be patched.
 	 */
 	for (i = 0; i < nr_entries; i++)
-		text_poke(tp[i].addr, &int3, sizeof(int3));
+		text_poke(text_poke_addr(&tp[i]), &int3, sizeof(int3));
 
 	on_each_cpu(do_sync_core, NULL, 1);
 
@@ -1089,7 +1094,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 		int len = text_opcode_size(tp[i].opcode);
 
 		if (len - sizeof(int3) > 0) {
-			text_poke((char *)tp[i].addr + sizeof(int3),
+			text_poke(text_poke_addr(&tp[i]) + sizeof(int3),
 				  (const char *)tp[i].text + sizeof(int3),
 				  len - sizeof(int3));
 			do_sync++;
@@ -1113,7 +1118,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 		if (tp[i].text[0] == INT3_INSN_OPCODE)
 			continue;
 
-		text_poke(tp[i].addr, tp[i].text, sizeof(int3));
+		text_poke(text_poke_addr(&tp[i]), tp[i].text, sizeof(int3));
 		do_sync++;
 	}
 
@@ -1143,7 +1148,7 @@ void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 	BUG_ON(!insn_complete(&insn));
 	BUG_ON(len != insn.length);
 
-	tp->addr = addr;
+	tp->rel_addr = addr - (void *)_stext;
 	tp->opcode = insn.opcode.bytes[0];
 
 	switch (tp->opcode) {
@@ -1192,7 +1197,7 @@ static bool tp_order_fail(void *addr)
 		return true;
 
 	tp = &tp_vec[tp_vec_nr - 1];
-	if ((unsigned long)tp->addr > (unsigned long)addr)
+	if ((unsigned long)text_poke_addr(tp) > (unsigned long)addr)
 		return true;
 
 	return false;
