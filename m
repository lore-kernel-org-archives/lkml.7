Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DC4C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E5A2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g+7Po1Ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfFENYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:24:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbfFENXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KVJ1t/UYBqXXzj0ALAl4nH4LZGpkZsyrFG8koy1geJI=; b=g+7Po1Ngf3mxYhAFS+zBZSLhTn
        gAk13KR9h9sNg/w3e3QP/JILNEGtGxSEoke82dVfGMhf0fU5O8KA5n60pILnpFINFJR0b6oxbPMXj
        y5fpW/P3TrnX3KYUrJw1tX5Z8abM1+5cZWTKuwvVRTgILrMGkhU/Ct6Y4Yj+ZlJ1ZAgJwQUyG+t2C
        0bSV3D82X5+YqpNyAUkFHaduB8p0MSMepS1C+Ixq+Zifv78IsZaQkGLCBAJo9LIfnrVkqIh8vqkWB
        VJ0WWZRzujjHIiir+mZBuuJYb5L2YQ5hHY7Oex4I/hrSPyfOYepgk4V47PaIdATmw2sfqgS6J8q/i
        Jp/W2ycw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYVsJ-0004qV-2p; Wed, 05 Jun 2019 13:22:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8395E2025D9C8; Wed,  5 Jun 2019 15:22:39 +0200 (CEST)
Message-Id: <20190605131944.888069781@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Jun 2019 15:07:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 06/15] x86_32: Allow int3_emulate_push()
References: <20190605130753.327195108@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that x86_32 has an unconditional gap on the kernel stack frame,
the int3_emulate_push() thing will work without further changes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/text-patching.h |    2 --
 arch/x86/kernel/ftrace.c             |    7 -------
 2 files changed, 9 deletions(-)

--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -51,7 +51,6 @@ static inline void int3_emulate_jmp(stru
 #define INT3_INSN_SIZE 1
 #define CALL_INSN_SIZE 5
 
-#ifdef CONFIG_X86_64
 static inline void int3_emulate_push(struct pt_regs *regs, unsigned long val)
 {
 	/*
@@ -69,7 +68,6 @@ static inline void int3_emulate_call(str
 	int3_emulate_push(regs, regs->ip - INT3_INSN_SIZE + CALL_INSN_SIZE);
 	int3_emulate_jmp(regs, func);
 }
-#endif /* CONFIG_X86_64 */
 #endif /* !CONFIG_UML_X86 */
 
 #endif /* _ASM_X86_TEXT_PATCHING_H */
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -300,7 +300,6 @@ int ftrace_int3_handler(struct pt_regs *
 
 	ip = regs->ip - INT3_INSN_SIZE;
 
-#ifdef CONFIG_X86_64
 	if (ftrace_location(ip)) {
 		int3_emulate_call(regs, (unsigned long)ftrace_regs_caller);
 		return 1;
@@ -312,12 +311,6 @@ int ftrace_int3_handler(struct pt_regs *
 		int3_emulate_call(regs, ftrace_update_func_call);
 		return 1;
 	}
-#else
-	if (ftrace_location(ip) || is_ftrace_caller(ip)) {
-		int3_emulate_jmp(regs, ip + CALL_INSN_SIZE);
-		return 1;
-	}
-#endif
 
 	return 0;
 }


