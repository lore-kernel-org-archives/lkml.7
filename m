Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9E4C33C9B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115CE2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfKNSUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:20:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbfKNSS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:26 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F9D02084E;
        Thu, 14 Nov 2019 18:18:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhJ-00014j-Hk; Thu, 14 Nov 2019 13:18:25 -0500
Message-Id: <20191114181825.435208993@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:17:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [for-next][PATCH 14/33] ftrace/x86: Tell objtool to ignore nondeterministic ftrace stack
 layout
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

Objtool complains about the new ftrace direct trampoline code:

  arch/x86/kernel/ftrace_64.o: warning: objtool: ftrace_regs_caller()+0x190: stack state mismatch: cfa1=7+16 cfa2=7+24

Typically, code has a deterministic stack layout, such that at a given
instruction address, the stack frame size is always the same.

That's not the case for the new ftrace_regs_caller() code after it
adjusts the stack for the direct case.  Just plead ignorance and assume
it's always the non-direct path.  Note this creates a tiny window for
ORC to get confused.

Link: http://lkml.kernel.org/r/20191108225100.ea3bhsbdf6oerj6g@treble

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/include/asm/unwind_hints.h |  8 ++++++++
 arch/x86/kernel/ftrace_64.S         | 12 +++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index 0bcdb1279361..f5e2eb12cb71 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -86,6 +86,14 @@
 	UNWIND_HINT sp_offset=\sp_offset
 .endm
 
+.macro UNWIND_HINT_SAVE
+	UNWIND_HINT type=UNWIND_HINT_TYPE_SAVE
+.endm
+
+.macro UNWIND_HINT_RESTORE
+	UNWIND_HINT type=UNWIND_HINT_TYPE_RESTORE
+.endm
+
 #else /* !__ASSEMBLY__ */
 
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 6ac7ff304886..b33abdd0a2db 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -178,6 +178,8 @@ ENTRY(ftrace_regs_caller)
 	/* Save the current flags before any operations that can change them */
 	pushfq
 
+	UNWIND_HINT_SAVE
+
 	/* added 8 bytes to save flags */
 	save_mcount_regs 8
 	/* save_mcount_regs fills in first two parameters */
@@ -250,8 +252,16 @@ GLOBAL(ftrace_regs_call)
 1:	restore_mcount_regs
 
 
+2:
+	/*
+	 * The stack layout is nondetermistic here, depending on which path was
+	 * taken.  This confuses objtool and ORC, rightfully so.  For now,
+	 * pretend the stack always looks like the non-direct case.
+	 */
+	UNWIND_HINT_RESTORE
+
 	/* Restore flags */
-2:	popfq
+	popfq
 
 	/*
 	 * As this jmp to ftrace_epilogue can be a short jump
-- 
2.23.0


