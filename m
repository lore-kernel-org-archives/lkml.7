Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEADC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A842068E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfLDIen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:34:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56391 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfLDIdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:33:52 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icQ6J-0005Fm-4C; Wed, 04 Dec 2019 09:33:35 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C8E351C2656;
        Wed,  4 Dec 2019 09:33:34 +0100 (CET)
Date:   Wed, 04 Dec 2019 08:33:34 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] x86/alternatives: Sync bp_patching update for
 avoiding NULL pointer exception
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <157483421229.25881.15314414408559963162.stgit@devnote2>
References: <157483421229.25881.15314414408559963162.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <157544841472.21853.14922550331474190716.tip-bot2@tip-bot2>
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

Commit-ID:     285a54efe3861976af9d15e85ff8c91a78d1407b
Gitweb:        https://git.kernel.org/tip/285a54efe3861976af9d15e85ff8c91a78d1407b
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Wed, 27 Nov 2019 14:56:52 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 27 Nov 2019 07:44:25 +01:00

x86/alternatives: Sync bp_patching update for avoiding NULL pointer exception

ftracetest multiple_kprobes.tc testcase hits the following NULL pointer
exception:

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 PGD 800000007bf60067 P4D 800000007bf60067 PUD 7bf5f067 PMD 0
 Oops: 0000 [#1] PREEMPT SMP PTI
 RIP: 0010:poke_int3_handler+0x39/0x100
 Call Trace:
  <IRQ>
  do_int3+0xd/0xf0
  int3+0x42/0x50
  RIP: 0010:sched_clock+0x6/0x10

poke_int3_handler+0x39 was alternatives:958:

  static inline void *text_poke_addr(struct text_poke_loc *tp)
  {
          return _stext + tp->rel_addr; <------ Here is line #958
  }

This seems to be caused by tp (bp_patching.vec) being NULL but
bp_patching.nr_entries != 0. There is a small chance for this
to happen, because we have no synchronization between the zeroing
of bp_patching.nr_entries and before clearing bp_patching.vec.

Steve suggested we could fix this by adding sync_core(), because int3
is done with interrupts disabled, and the on_each_cpu() requires
all CPUs to have had their interrupts enabled.

 [ mingo: Edited the comments and the changelog. ]

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bristot@redhat.com
Fixes: c0213b0ac03c ("x86/alternative: Batch of patch operations")
Link: https://lkml.kernel.org/r/157483421229.25881.15314414408559963162.stgit@devnote2
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/alternative.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 4552795..30e8673 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1134,8 +1134,14 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * sync_core() implies an smp_mb() and orders this store against
 	 * the writing of the new instruction.
 	 */
-	bp_patching.vec = NULL;
 	bp_patching.nr_entries = 0;
+	/*
+	 * This sync_core () call ensures that all INT3 handlers in progress
+	 * have finished. This allows poke_int3_handler() after this to
+	 * avoid touching bp_paching.vec by checking nr_entries == 0.
+	 */
+	text_poke_sync();
+	bp_patching.vec = NULL;
 }
 
 void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
