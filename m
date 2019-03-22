Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E05C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F7C21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257364;
	bh=SPGBBFlhDeXCvcNzV56+nEJeslCF3XtixKVPsQXxPqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=01ZNSiXSNm5E16NMCN8hou58n6LhVXS2EEfYei7UtGe20X18zO5Hfz4GxP/BzSxQV
	 UVY/4mWDGct60rwLFoB8APYm3zWfrb1JwCuQo3QOl52rGxhAb/5DFet2vFcb0U55HK
	 qprLnsnuQdy4vo5dYCe4RaTighzLDNUGlzRkGXes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391046AbfCVMWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390690AbfCVMWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:22:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBFEB218A1;
        Fri, 22 Mar 2019 12:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257356;
        bh=SPGBBFlhDeXCvcNzV56+nEJeslCF3XtixKVPsQXxPqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OUF+olZ10MKRJi6mGM4SD/DIheRJ2ir4w+tuQQYYeonXC51aBv/C2j+E+17DocytA
         VZ8c9wutCL7V6+uGGnAsHVVh39wFlbL0L27K6rRsIByHp/gaKe2833Sd0SJsb1tDLC
         MGLlSyhy6LfxQb+bpgsr8WTEReX3lX6Co2FKwl8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.0 208/238] x86/ftrace: Fix warning and considate ftrace_jmp_replace() and ftrace_call_replace()
Date:   Fri, 22 Mar 2019 12:17:07 +0100
Message-Id: <20190322111310.514952475@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 745cfeaac09ce359130a5451d90cb0bd4094c290 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/ftrace.c |   42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -49,7 +49,7 @@ int ftrace_arch_code_modify_post_process
 union ftrace_code_union {
 	char code[MCOUNT_INSN_SIZE];
 	struct {
-		unsigned char e8;
+		unsigned char op;
 		int offset;
 	} __attribute__((packed));
 };
@@ -59,20 +59,23 @@ static int ftrace_calc_offset(long ip, l
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
 
@@ -963,6 +950,11 @@ void arch_ftrace_trampoline_free(struct
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


