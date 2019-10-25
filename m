Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AB0CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F30021D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408611AbfJYJAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:00:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36311 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392171AbfJYJAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:00:23 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iNvRw-0003GO-UW; Fri, 25 Oct 2019 11:00:01 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6E9AE1C0086;
        Fri, 25 Oct 2019 11:00:00 +0200 (CEST)
Date:   Fri, 25 Oct 2019 09:00:00 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/ftrace: Get rid of function_hook
Cc:     Borislav Petkov <bp@suse.de>, Jiri Slaby <jslaby@suse.cz>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
In-Reply-To: <20191018124800.0a7006bb@gandalf.local.home>
References: <20191018124800.0a7006bb@gandalf.local.home>
MIME-Version: 1.0
Message-ID: <157199400012.29376.15138755769283504073.tip-bot2@tip-bot2>
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

Commit-ID:     0f42c1ad44d437f75b840b572376fd538fbb9643
Gitweb:        https://git.kernel.org/tip/0f42c1ad44d437f75b840b572376fd538fbb9643
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 21 Oct 2019 17:18:23 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 25 Oct 2019 10:52:22 +02:00

x86/ftrace: Get rid of function_hook

History lesson courtesy of Steve:

"When ftrace first was introduced to the kernel, it used gcc's
mcount profiling mechanism. The mcount mechanism would add a call to
"mcount" at the start of every function but after the stack frame was
set up. Later, in gcc 4.6, gcc introduced -mfentry, that would create a
call to "__fentry__" instead of "mcount", before the stack frame was
set up. In order to handle both cases, ftrace defined a macro
"function_hook" that would be either "mcount" or "__fentry__" depending
on which one was being used.

The Linux kernel no longer supports the "mcount" method, thus there's
no reason to keep the "function_hook" define around. Simply use
"__fentry__", as there is no ambiguity to the name anymore."

Drop it everywhere.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jiri Slaby <jslaby@suse.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/20191018124800.0a7006bb@gandalf.local.home
---
 Documentation/asm-annotations.rst |  4 ++--
 arch/x86/kernel/ftrace_32.S       |  8 +++-----
 arch/x86/kernel/ftrace_64.S       | 13 ++++++-------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
index 29ccd6e..f55c2bb 100644
--- a/Documentation/asm-annotations.rst
+++ b/Documentation/asm-annotations.rst
@@ -117,9 +117,9 @@ This section covers ``SYM_FUNC_*`` and ``SYM_CODE_*`` enumerated above.
   So in most cases, developers should write something like in the following
   example, having some asm instructions in between the macros, of course::
 
-    SYM_FUNC_START(function_hook)
+    SYM_FUNC_START(memset)
         ... asm insns ...
-    SYM_FUNC_END(function_hook)
+    SYM_FUNC_END(memset)
 
   In fact, this kind of annotation corresponds to the now deprecated ``ENTRY``
   and ``ENDPROC`` macros.
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index 8ed1f5d..e8a9f83 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -12,18 +12,16 @@
 #include <asm/frame.h>
 #include <asm/asm-offsets.h>
 
-# define function_hook	__fentry__
-EXPORT_SYMBOL(__fentry__)
-
 #ifdef CONFIG_FRAME_POINTER
 # define MCOUNT_FRAME			1	/* using frame = true  */
 #else
 # define MCOUNT_FRAME			0	/* using frame = false */
 #endif
 
-SYM_FUNC_START(function_hook)
+SYM_FUNC_START(__fentry__)
 	ret
-SYM_FUNC_END(function_hook)
+SYM_FUNC_END(__fentry__)
+EXPORT_SYMBOL(__fentry__)
 
 SYM_CODE_START(ftrace_caller)
 
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 69c8d1b..6e8961c 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -14,9 +14,6 @@
 	.code64
 	.section .entry.text, "ax"
 
-# define function_hook	__fentry__
-EXPORT_SYMBOL(__fentry__)
-
 #ifdef CONFIG_FRAME_POINTER
 /* Save parent and function stack frames (rip and rbp) */
 #  define MCOUNT_FRAME_SIZE	(8+16*2)
@@ -132,9 +129,10 @@ EXPORT_SYMBOL(__fentry__)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
-SYM_FUNC_START(function_hook)
+SYM_FUNC_START(__fentry__)
 	retq
-SYM_FUNC_END(function_hook)
+SYM_FUNC_END(__fentry__)
+EXPORT_SYMBOL(__fentry__)
 
 SYM_FUNC_START(ftrace_caller)
 	/* save_mcount_regs fills in first two parameters */
@@ -248,7 +246,7 @@ SYM_FUNC_END(ftrace_regs_caller)
 
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
-SYM_FUNC_START(function_hook)
+SYM_FUNC_START(__fentry__)
 	cmpq $ftrace_stub, ftrace_trace_function
 	jnz trace
 
@@ -279,7 +277,8 @@ trace:
 	restore_mcount_regs
 
 	jmp fgraph_trace
-SYM_FUNC_END(function_hook)
+SYM_FUNC_END(__fentry__)
+EXPORT_SYMBOL(__fentry__)
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
