Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF554C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D1A2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cn9+BQDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfF1Ngd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:36:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43256 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfF1NgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vnE+x2ECRCteGktx7zBzJWESW14d+4IL+cy0q0uzTns=; b=cn9+BQDxkRTs0PCdZAnuNiaXKG
        y1cqbEMAkbqkRszRWPcP6YuKfw8hR84HEi1VKNEquWIUQcwltqduhSyoFrNHgCRoPNTOsuKh4eluH
        GQ3+Rw5rT6vwQ+t/SnyIyW9pqp03oxOBTMsW3LLPjmzGWollv/EPbLypAXmwWTWddwtuZIv7uHv9g
        rcpNBoh48etcn8SKckpXSdroxMCpOdrOJgt120WuNzRwLYwZFzylthWhCzHFkeH9HErWc45oBBssK
        Rmis6oBhfj+wzgBRvKdadRyVDjY2CEgb+jGJF4bFe0qOHL7tgvE0e1M2Jzi9cljYVWNWLGctxk0iM
        ZE47IIcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgr2s-0000nG-Ht; Fri, 28 Jun 2019 13:36:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9A77D20AB8995; Fri, 28 Jun 2019 15:36:03 +0200 (CEST)
Message-Id: <20190628103224.888336008@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 28 Jun 2019 12:21:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC][PATCH 8/8] jump_label, x86: Enable JMP8/NOP2 support
References: <20190628102113.360432762@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable and emit short JMP/NOP jump_label entries.

Much thanks to Josh for (re)discovering the .skip trick to
conditionally emit variable length text.

Due to how early we enable jump_labels on x86, if any of this comes
apart, the machine is completely dead. Qemu+GDB saved the day this
time.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/jump_label.h |   37 +++++++++++++++++++++++++++++++------
 arch/x86/kernel/jump_label.c      |    5 ++++-
 2 files changed, 35 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -31,7 +31,35 @@
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
 	asm_volatile_goto("1:"
-		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
+
+		".set disp, %l[l_yes] - (1b + 2) \n\t"
+		".set sign, disp >> 31 \n\t"
+		".set res, (disp >> 7) ^ sign \n\t"
+		".set is_byte, -(res == 0) \n\t"
+		".set is_long, -(res != 0) \n\t"
+
+#ifdef CONFIG_X86_64
+		".skip is_byte, 0x66 \n\t"
+		".skip is_byte, 0x90 \n\t"
+#else
+		".skip is_byte, 0x89 \n\t"
+		".skip is_byte, 0xf6 \n\t"
+#endif
+
+#ifdef CONFIG_X86_64
+		".skip is_long, 0x0f \n\t"
+		".skip is_long, 0x1f \n\t"
+		".skip is_long, 0x44 \n\t"
+		".skip is_long, 0x00 \n\t"
+		".skip is_long, 0x00 \n\t"
+#else
+		".skip is_long, 0x3e \n\t"
+		".skip is_long, 0x8d \n\t"
+		".skip is_long, 0x74 \n\t"
+		".skip is_long, 0x26 \n\t"
+		".skip is_long, 0x00 \n\t"
+#endif
+
 		JUMP_TABLE_ENTRY
 		: :  "i" (key), "i" (branch) : : l_yes);
 
@@ -43,8 +71,7 @@ static __always_inline bool arch_static_
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
 	asm_volatile_goto("1:"
-		".byte 0xe9 \n\t"
-		".long %l[l_yes] - (. + 4) \n\t"
+		"jmp %l[l_yes] \n\t"
 		JUMP_TABLE_ENTRY
 		: :  "i" (key), "i" (branch) : : l_yes);
 
@@ -59,9 +86,7 @@ extern int arch_jump_entry_size(struct j
 
 .macro STATIC_BRANCH_FALSE_LIKELY target, key
 .Lstatic_jump_\@:
-	/* Equivalent to "jmp.d32 \target" */
-	.byte		0xe9
-	.long		\target - (. + 4)
+	jmp \target
 
 	.pushsection __jump_table, "aw"
 	_ASM_ALIGN
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -29,7 +29,10 @@ union jump_code_union {
 
 static inline bool __jump_disp_is_byte(s32 disp)
 {
-	return false;
+	s32 sign;
+	disp -= JMP8_INSN_SIZE;
+	sign = disp >> 31;
+	return ((disp >> 7) ^ sign) == 0;
 }
 
 int arch_jump_entry_size(struct jump_entry *entry)


