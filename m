Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BBBC0044D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EAB2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfLDIds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:33:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56343 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfLDIdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:33:47 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icQ6J-0005Fp-9a; Wed, 04 Dec 2019 09:33:35 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EFB611C2657;
        Wed,  4 Dec 2019 09:33:34 +0100 (CET)
Date:   Wed, 04 Dec 2019 08:33:34 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] x86/alternatives: Use INT3_INSN_SIZE
Cc:     Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191111132458.460144656@infradead.org>
References: <20191111132458.460144656@infradead.org>
MIME-Version: 1.0
Message-ID: <157544841488.21853.11724270583897887740.tip-bot2@tip-bot2>
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

Commit-ID:     76ffa7204b1ad7d321ac3a0292fdf3975d14866b
Gitweb:        https://git.kernel.org/tip/76ffa7204b1ad7d321ac3a0292fdf3975d14866b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 11 Nov 2019 14:08:26 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 27 Nov 2019 07:44:25 +01:00

x86/alternatives: Use INT3_INSN_SIZE

Use INT3_INSN_SIZE instead of sizeof(int3).

Suggested-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191111132458.460144656@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/alternative.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 6455902..4552795 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1088,7 +1088,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * First step: add a int3 trap to the address that will be patched.
 	 */
 	for (i = 0; i < nr_entries; i++)
-		text_poke(text_poke_addr(&tp[i]), &int3, sizeof(int3));
+		text_poke(text_poke_addr(&tp[i]), &int3, INT3_INSN_SIZE);
 
 	text_poke_sync();
 
@@ -1098,10 +1098,10 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	for (do_sync = 0, i = 0; i < nr_entries; i++) {
 		int len = text_opcode_size(tp[i].opcode);
 
-		if (len - sizeof(int3) > 0) {
-			text_poke(text_poke_addr(&tp[i]) + sizeof(int3),
-				  (const char *)tp[i].text + sizeof(int3),
-				  len - sizeof(int3));
+		if (len - INT3_INSN_SIZE > 0) {
+			text_poke(text_poke_addr(&tp[i]) + INT3_INSN_SIZE,
+				  (const char *)tp[i].text + INT3_INSN_SIZE,
+				  len - INT3_INSN_SIZE);
 			do_sync++;
 		}
 	}
@@ -1123,7 +1123,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 		if (tp[i].text[0] == INT3_INSN_OPCODE)
 			continue;
 
-		text_poke(text_poke_addr(&tp[i]), tp[i].text, sizeof(int3));
+		text_poke(text_poke_addr(&tp[i]), tp[i].text, INT3_INSN_SIZE);
 		do_sync++;
 	}
 
