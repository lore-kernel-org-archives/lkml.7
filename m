Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE26C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39F72073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfKOJnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:43:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42898 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfKOJnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:43:21 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVY8D-0004MZ-Dd; Fri, 15 Nov 2019 10:43:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0C8711C18B4;
        Fri, 15 Nov 2019 10:43:09 +0100 (CET)
Date:   Fri, 15 Nov 2019 09:43:08 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] x86/alternative: Remove text_poke_loc::len
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20191111132457.989922744@infradead.org>
References: <20191111132457.989922744@infradead.org>
MIME-Version: 1.0
Message-ID: <157381098865.29467.6521569703486012857.tip-bot2@tip-bot2>
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

Commit-ID:     a94d4b4a2a99d9c1277210ba7f74667e3a2bc76d
Gitweb:        https://git.kernel.org/tip/a94d4b4a2a99d9c1277210ba7f74667e3a2bc76d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 09 Oct 2019 12:44:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Nov 2019 09:07:43 +01:00

x86/alternative: Remove text_poke_loc::len

Per the BUG_ON(len != insn.length) in text_poke_loc_init(), tp->len
must indeed be the same as text_opcode_size(tp->opcode). Use this to
remove this field from the structure.

Sadly, due to 8 byte alignment, this only increases the structure
padding.

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
Link: https://lkml.kernel.org/r/20191111132457.989922744@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/alternative.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index cfcfadf..6e3ee73 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -938,7 +938,6 @@ static void do_sync_core(void *info)
 
 struct text_poke_loc {
 	void *addr;
-	int len;
 	s32 rel32;
 	u8 opcode;
 	const u8 text[POKE_MAX_OPCODE_SIZE];
@@ -965,6 +964,7 @@ int notrace poke_int3_handler(struct pt_regs *regs)
 {
 	struct text_poke_loc *tp;
 	void *ip;
+	int len;
 
 	/*
 	 * Having observed our INT3 instruction, we now must observe
@@ -1004,7 +1004,8 @@ int notrace poke_int3_handler(struct pt_regs *regs)
 			return 0;
 	}
 
-	ip += tp->len;
+	len = text_opcode_size(tp->opcode);
+	ip += len;
 
 	switch (tp->opcode) {
 	case INT3_INSN_OPCODE:
@@ -1085,10 +1086,12 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * Second step: update all but the first byte of the patched range.
 	 */
 	for (do_sync = 0, i = 0; i < nr_entries; i++) {
-		if (tp[i].len - sizeof(int3) > 0) {
+		int len = text_opcode_size(tp[i].opcode);
+
+		if (len - sizeof(int3) > 0) {
 			text_poke((char *)tp[i].addr + sizeof(int3),
 				  (const char *)tp[i].text + sizeof(int3),
-				  tp[i].len - sizeof(int3));
+				  len - sizeof(int3));
 			do_sync++;
 		}
 	}
@@ -1141,7 +1144,6 @@ void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 	BUG_ON(len != insn.length);
 
 	tp->addr = addr;
-	tp->len = len;
 	tp->opcode = insn.opcode.bytes[0];
 
 	switch (tp->opcode) {
