Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B39C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 12:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E172184B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 12:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfEKMj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 08:39:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfEKMj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 08:39:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D65D3208C0;
        Sat, 11 May 2019 12:39:55 +0000 (UTC)
Date:   Sat, 11 May 2019 08:39:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Subject: [PATCH] x86: Hide the int3_emulate_call/jmp functions from UML
Message-ID: <20190511083954.23a60052@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

User Mode Linux does not have access to the ip or sp fields of the
pt_regs, and accessing them causes UML to fail to build. Hide the
int3_emulate_jmp() and int3_emulate_call() instructions from UML, as it
doesn't need them anyway.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---

[ I added this to my queue to test too ]

 arch/x86/include/asm/text-patching.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/text-patching.h
b/arch/x86/include/asm/text-patching.h index 05861cc08787..0bbb07eaed6b
100644 --- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -39,6 +39,7 @@ extern int poke_int3_handler(struct pt_regs *regs);
 extern void *text_poke_bp(void *addr, const void *opcode, size_t len,
void *handler); extern int after_bootmem;
 
+#ifndef CONFIG_UML_X86
 static inline void int3_emulate_jmp(struct pt_regs *regs, unsigned
long ip) {
 	regs->ip = ip;
@@ -65,6 +66,7 @@ static inline void int3_emulate_call(struct pt_regs
*regs, unsigned long func) int3_emulate_push(regs, regs->ip -
INT3_INSN_SIZE + CALL_INSN_SIZE); int3_emulate_jmp(regs, func);
 }
-#endif
+#endif /* CONFIG_X86_64 */
+#endif /* !CONFIG_UML_X86 */
 
 #endif /* _ASM_X86_TEXT_PATCHING_H */
-- 
2.20.1

