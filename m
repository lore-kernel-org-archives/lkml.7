Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CB1CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F9E222C6
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j8pjLamO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504794AbfJRHvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:51:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34294 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504771AbfJRHvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AaATmhSi7E/xpNheLLhgNiTpYtvpLuJ1d3ohRJveXHc=; b=j8pjLamOqNQUd2Z4USPp1NJ3j4
        rYvzJq6Rxaq65KQsC7NCaKJY81BPc9ROhC20QA70R/MObCd0ZzvZJqB+91h3LcC1D/SU5qgi+pkLg
        ZpABhdcGmrXp6bzmqonEGkUREK+VgnSNmCbqF6wAMD3DAU5MGXXnMJrQff7s34w2W2SzFgTyZ6mim
        /BZSLjnx42c6f2UwHDD6pHfcLGCt8pquOxz+NVf7XF3UC0pLePa8g/IJNiNb6tXL8NFRWgT3T8JzI
        WstGYAYg9QpZoIXHBjVkjvjgHtvnpxg/OEDGDxyaXETBF2Iyj3Nkw8mEEiMmFRlkMuMFCQdRw3qr+
        T6nImgWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLN2c-0007mv-M0; Fri, 18 Oct 2019 07:51:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F15F9306BB6;
        Fri, 18 Oct 2019 09:50:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4E8E92B178114; Fri, 18 Oct 2019 09:51:15 +0200 (CEST)
Message-Id: <20191018074634.400398363@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 18 Oct 2019 09:35:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org
Subject: [PATCH v4 08/16] x86/ftrace: Use text_gen_insn()
References: <20191018073525.768931536@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the ftrace_code_union with the generic text_gen_insn() helper,
which does exactly this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/text-patching.h |   25 ++++++++++++++++++++++++-
 arch/x86/kernel/alternative.c        |   26 --------------------------
 arch/x86/kernel/ftrace.c             |   32 +++++++-------------------------
 3 files changed, 31 insertions(+), 52 deletions(-)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -80,7 +80,30 @@ static inline int text_opcode_size(u8 op
 	return size;
 }
 
-extern void *text_gen_insn(u8 opcode, const void *addr, const void *dest);
+union text_poke_insn {
+	u8 text[POKE_MAX_OPCODE_SIZE];
+	struct {
+		u8 opcode;
+		s32 disp;
+	} __attribute__((packed));
+};
+
+static __always_inline
+void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
+{
+	static union text_poke_insn insn; /* per instance */
+	int size = text_opcode_size(opcode);
+
+	insn.opcode = opcode;
+
+	if (size > 1) {
+		insn.disp = (long)dest - (long)(addr + size);
+		if (size == 2)
+			BUG_ON((insn.disp >> 31) != (insn.disp >> 7));
+	}
+
+	return &insn.text;
+}
 
 extern int after_bootmem;
 extern __ro_after_init struct mm_struct *poking_mm;
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1247,29 +1247,3 @@ void __ref text_poke_bp(void *addr, cons
 	text_poke_loc_init(&tp, addr, opcode, len, emulate);
 	text_poke_bp_batch(&tp, 1);
 }
-
-union text_poke_insn {
-	u8 text[POKE_MAX_OPCODE_SIZE];
-	struct {
-		u8 opcode;
-		s32 disp;
-	} __attribute__((packed));
-};
-
-void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
-{
-	static union text_poke_insn insn; /* text_mutex */
-	int size = text_opcode_size(opcode);
-
-	lockdep_assert_held(&text_mutex);
-
-	insn.opcode = opcode;
-
-	if (size > 1) {
-		insn.disp = (long)dest - (long)(addr + size);
-		if (size == 2)
-			BUG_ON((insn.disp >> 31) != (insn.disp >> 7));
-	}
-
-	return &insn.text;
-}
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -58,24 +58,6 @@ int ftrace_arch_code_modify_post_process
 	return 0;
 }
 
-union ftrace_code_union {
-	char code[MCOUNT_INSN_SIZE];
-	struct {
-		char op;
-		int offset;
-	} __attribute__((packed));
-};
-
-static const char *ftrace_text_replace(char op, unsigned long ip, unsigned long addr)
-{
-	static union ftrace_code_union calc;
-
-	calc.op = op;
-	calc.offset = (int)(addr - (ip + MCOUNT_INSN_SIZE));
-
-	return calc.code;
-}
-
 static const char *ftrace_nop_replace(void)
 {
 	return ideal_nops[NOP_ATOMIC5];
@@ -83,7 +65,7 @@ static const char *ftrace_nop_replace(vo
 
 static const char *ftrace_call_replace(unsigned long ip, unsigned long addr)
 {
-	return ftrace_text_replace(CALL_INSN_OPCODE, ip, addr);
+	return text_gen_insn(CALL_INSN_OPCODE, (void *)ip, (void *)addr);
 }
 
 static int ftrace_verify_code(unsigned long ip, const char *old_code)
@@ -475,20 +457,20 @@ void arch_ftrace_update_trampoline(struc
 /* Return the address of the function the trampoline calls */
 static void *addr_from_call(void *ptr)
 {
-	union ftrace_code_union calc;
+	union text_poke_insn call;
 	int ret;
 
-	ret = probe_kernel_read(&calc, ptr, MCOUNT_INSN_SIZE);
+	ret = probe_kernel_read(&call, ptr, CALL_INSN_SIZE);
 	if (WARN_ON_ONCE(ret < 0))
 		return NULL;
 
 	/* Make sure this is a call */
-	if (WARN_ON_ONCE(calc.op != 0xe8)) {
-		pr_warn("Expected e8, got %x\n", calc.op);
+	if (WARN_ON_ONCE(call.opcode != CALL_INSN_OPCODE)) {
+		pr_warn("Expected E8, got %x\n", call.opcode);
 		return NULL;
 	}
 
-	return ptr + MCOUNT_INSN_SIZE + calc.offset;
+	return ptr + CALL_INSN_SIZE + call.disp;
 }
 
 void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
@@ -557,7 +539,7 @@ extern void ftrace_graph_call(void);
 
 static const char *ftrace_jmp_replace(unsigned long ip, unsigned long addr)
 {
-	return ftrace_text_replace(JMP32_INSN_OPCODE, ip, addr);
+	return text_gen_insn(JMP32_INSN_OPCODE, (void *)ip, (void *)addr);
 }
 
 static int ftrace_mod_jmp(unsigned long ip, void *func)


