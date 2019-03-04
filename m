Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC3AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58C420823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfCDVnK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:43:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:48138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfCDVnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:43:10 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F2FF206B6;
        Mon,  4 Mar 2019 21:43:08 +0000 (UTC)
Date:   Mon, 4 Mar 2019 16:43:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/ftrace: avoid an unused-function warning
Message-ID: <20190304164306.4b76acc1@gandalf.local.home>
In-Reply-To: <20190304200748.1418790-1-arnd@arndb.de>
References: <20190304200748.1418790-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Mar 2019 21:07:39 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> Depending on the configuration, ftrace_jmp_replace() sometimes
> has no callers at all, since one of the users was removed:
> 
> arch/x86/kernel/ftrace.c:669:23: error: 'ftrace_jmp_replace' defined but not used [-Werror=unused-function]
> 
> Rather than trying to figure out the correct #ifdef check for this
> time, just mark it __maybe_unused and let the compiler drop it
> silently.
> 

Actually, its now only used in one place (that git grep shows).
Changing it to "__maybe_unused" is a copout, and really shouldn't be
something we do for a static function, especially since it's only used
in a single location.

Also, it's basically identical to ftrace_call_replace(). I'm going to
combine the two and move the jmp replace and have it do this instead.

-- Steve

From 8e5c6a3255de709ee0d699494243328cd5a11276 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Mon, 4 Mar 2019 16:35:22 -0500
Subject: [PATCH] x86/ftrace: Fix warning and considate ftrace_jmp_replace()
 and ftrace_call_replace()

Arnd reported the following compiler warning:

arch/x86/kernel/ftrace.c:669:23: error: 'ftrace_jmp_replace' defined but not used [-Werror=unused-function]

The ftrace_jmp_replace() function now only has a single user and should be
simply moved by that user. But looking at the code, it shows that
ftrace_jmp_replace() is similar to ftrace_call_replace() except that instead
of using the opcode of 0xe8 it uses 0xe9. It makes more sense to consolidate
that function into one implementation that both ftrace_jmp_replace() and
ftrace_call_replace() use by passing in the op code separate.

The structure in ftrace_code_union is also modified to replace the "e8"
field with the more appropriate name "op".

Cc: stable@vger.kernel.org
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: http://lkml.kernel.org/r/20190304200748.1418790-1-arnd@arndb.de
Fixes: d2a68c4effd8 ("x86/ftrace: Do not call function graph from dynamic trampolines")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/ftrace.c | 42 ++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 8257a59704ae..763d4264d16a 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -49,7 +49,7 @@ int ftrace_arch_code_modify_post_process(void)
 union ftrace_code_union {
 	char code[MCOUNT_INSN_SIZE];
 	struct {
-		unsigned char e8;
+		unsigned char op;
 		int offset;
 	} __attribute__((packed));
 };
@@ -59,20 +59,23 @@ static int ftrace_calc_offset(long ip, long addr)
 	return (int)(addr - ip);
 }
 
-static unsigned char *ftrace_call_replace(unsigned long ip, unsigned long addr)
+static unsigned char *
+ftrace_text_replace(unsigned char op, unsigned long ip, unsigned long addr)
 {
 	static union ftrace_code_union calc;
 
-	calc.e8		= 0xe8;
+	calc.op		= op;
 	calc.offset	= ftrace_calc_offset(ip + MCOUNT_INSN_SIZE, addr);
 
-	/*
-	 * No locking needed, this must be called via kstop_machine
-	 * which in essence is like running on a uniprocessor machine.
-	 */
 	return calc.code;
 }
 
+static unsigned char *
+ftrace_call_replace(unsigned long ip, unsigned long addr)
+{
+	return ftrace_text_replace(0xe8, ip, addr);
+}
+
 static inline int
 within(unsigned long addr, unsigned long start, unsigned long end)
 {
@@ -664,22 +667,6 @@ int __init ftrace_dyn_arch_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_X86_64) || defined(CONFIG_FUNCTION_GRAPH_TRACER)
-static unsigned char *ftrace_jmp_replace(unsigned long ip, unsigned long addr)
-{
-	static union ftrace_code_union calc;
-
-	/* Jmp not a call (ignore the .e8) */
-	calc.e8		= 0xe9;
-	calc.offset	= ftrace_calc_offset(ip + MCOUNT_INSN_SIZE, addr);
-
-	/*
-	 * ftrace external locks synchronize the access to the static variable.
-	 */
-	return calc.code;
-}
-#endif
-
 /* Currently only x86_64 supports dynamic trampolines */
 #ifdef CONFIG_X86_64
 
@@ -891,8 +878,8 @@ static void *addr_from_call(void *ptr)
 		return NULL;
 
 	/* Make sure this is a call */
-	if (WARN_ON_ONCE(calc.e8 != 0xe8)) {
-		pr_warn("Expected e8, got %x\n", calc.e8);
+	if (WARN_ON_ONCE(calc.op != 0xe8)) {
+		pr_warn("Expected e8, got %x\n", calc.op);
 		return NULL;
 	}
 
@@ -963,6 +950,11 @@ void arch_ftrace_trampoline_free(struct ftrace_ops *ops)
 #ifdef CONFIG_DYNAMIC_FTRACE
 extern void ftrace_graph_call(void);
 
+static unsigned char *ftrace_jmp_replace(unsigned long ip, unsigned long addr)
+{
+	return ftrace_text_replace(0xe9, ip, addr);
+}
+
 static int ftrace_mod_jmp(unsigned long ip, void *func)
 {
 	unsigned char *new;
-- 
2.20.1

