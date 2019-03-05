Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2169AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED10213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfCENwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:52:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbfCENws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:52:48 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A75D2147A;
        Tue,  5 Mar 2019 13:52:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1h1AUw-00030k-Eh; Tue, 05 Mar 2019 08:52:46 -0500
Message-Id: <20190305135246.331543727@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 05 Mar 2019 08:52:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [for-next][PATCH 4/6] x86/ftrace: Fix warning and considate ftrace_jmp_replace() and
 ftrace_call_replace()
References: <20190305135223.360347148@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

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
Acked-by: Arnd Bergmann <arnd@arndb.de>
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


