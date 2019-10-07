Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE04C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F179D21655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fCY19u1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbfJGLZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:25:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50178 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbfJGLXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WQUFbJDM4xq1CnLIHjC4m7essw7xSgWyQuR0HHIpJP0=; b=fCY19u1rKl/R2nnjV30ES5+CNb
        Ad8YdmN51MJf/5BLuo7H19CYXcPiYBZS7OWv0PUv+taWeBUMe5jPOKwqdO2jV+zrbbyqRcIpYZi4d
        +Itg+rpKVpk2EXdxQUW7Me+96O5mpXiWddS1sRlnRHQVM1tdPddQYxyXdGi0/dB1uVbEsMVQXS2cW
        1RFq16qYQLTb2vKXnvIDQlnXiPpibU5nXTyxkpbviJytaheIUhQ2+rdYY5ILLi4H/7Boy3NFsxLL+
        yzw4r8DkW1Ms+H1zyOs0YVDam+ufQ+IdD5L/rm/VtfR6SJcCkZdP43xU41qONu8D1QNZ9KQ+YrHbH
        fppad7xw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6x-0003GW-5s; Mon, 07 Oct 2019 11:23:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 38240307099;
        Mon,  7 Oct 2019 13:22:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D7235202A194E; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007083831.04166929.2@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:27:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [PATCH v2 09/13] x86/alternatives: Teach text_poke_bp() to emulate RET
References: <20191007082708.01393931.1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Future patches will need to poke a RET instruction, provide the
infrastructure required for this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/text-patching.h |   16 ++++++++++++++++
 arch/x86/kernel/alternative.c        |    6 ++++++
 2 files changed, 22 insertions(+)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -64,6 +64,9 @@ static inline void int3_emulate_jmp(stru
 #define INT3_INSN_SIZE		1
 #define INT3_INSN_OPCODE	0xCC
 
+#define RET_INSN_SIZE		1
+#define RET_INSN_OPCODE		0xC3
+
 #define CALL_INSN_SIZE		5
 #define CALL_INSN_OPCODE	0xE8
 
@@ -88,11 +91,24 @@ static inline void int3_emulate_push(str
 	*(unsigned long *)regs->sp = val;
 }
 
+static inline unsigned long int3_emulate_pop(struct pt_regs *regs)
+{
+	unsigned long val = *(unsigned long *)regs->sp;
+	regs->sp += sizeof(unsigned long);
+	return val;
+}
+
 static inline void int3_emulate_call(struct pt_regs *regs, unsigned long func)
 {
 	int3_emulate_push(regs, regs->ip - INT3_INSN_SIZE + CALL_INSN_SIZE);
 	int3_emulate_jmp(regs, func);
 }
+
+static inline void int3_emulate_ret(struct pt_regs *regs)
+{
+	unsigned long ip = int3_emulate_pop(regs);
+	int3_emulate_jmp(regs, ip);
+}
 #endif /* !CONFIG_UML_X86 */
 
 #endif /* _ASM_X86_TEXT_PATCHING_H */
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1014,6 +1014,10 @@ int notrace poke_int3_handler(struct pt_
 		 */
 		return 0;
 
+	case RET_INSN_OPCODE:
+		int3_emulate_ret(regs);
+		break;
+
 	case CALL_INSN_OPCODE:
 		int3_emulate_call(regs, (long)ip + tp->rel32);
 		break;
@@ -1146,6 +1150,7 @@ void text_poke_loc_init(struct text_poke
 
 	switch (tp->opcode) {
 	case INT3_INSN_OPCODE:
+	case RET_INSN_OPCODE:
 		break;
 
 	case CALL_INSN_OPCODE:
@@ -1260,6 +1265,7 @@ void *text_gen_insn(u8 opcode, unsigned
 
 	switch(opcode) {
 	__CASE(INT3);
+	__CASE(RET);
 	__CASE(CALL);
 	__CASE(JMP32);
 	__CASE(JMP8);


