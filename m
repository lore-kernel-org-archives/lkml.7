Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EE8ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A46E21655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KY2kUs1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfJGLXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:23:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50170 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbfJGLXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zVQ033DHYBrINJK02LYJoI4IG8nnnQgx+qACnvNJ5D0=; b=KY2kUs1Lx23xwJNyCy+RzDHrGZ
        SbRDq6IsqgMK2skhTxieGYXTUjHJFRFn1dkVRwPCdAytCpKH/pdrZaGe9pW0ABl6xXDxX6k7MPe0j
        afNnkhNXl8dAaBAX67D0t2lbslaFwQITbqLSd3hitF12wzGHuUrM4wrCm/dSjDELzw3mE4hbkQoP2
        BEMW/R206NyckwFHJS89pX8zrK6DJCCE0Su73vRB46KJSkEPDp/pilzyL2k7HDboJ1OMsdLAjY5ei
        iuSltO5N9ia5+PUBrufAJNXSmBskAi782CunGsOoWWb5nLemFFXTgMaVULb8L0vZ8FsyFRczu6Rw4
        tIkRVYTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6z-0003Ht-Vn; Mon, 07 Oct 2019 11:23:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3A2FB3060EB;
        Mon,  7 Oct 2019 13:22:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DB25820244E3A; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007083831.09800500.5@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:27:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [PATCH v2 10/13] static_call: Add static_cond_call()
References: <20191007082708.01393931.1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the static_call infrastructure to optimize the following common
pattern:

	if (func_ptr)
		func_ptr(args...)

For the trampoline (which is in effect a tail-call), we patch the
JMP.d32 into a RET, which then directly consumes the trampoline call.

For the in-line sites we replace the CALL with a NOP5.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/static_call.c |   42 ++++++++++++++++++++++++++++++++----------
 include/linux/static_call.h   |    7 +++++++
 2 files changed, 39 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -4,19 +4,41 @@
 #include <linux/bug.h>
 #include <asm/text-patching.h>
 
-static void __static_call_transform(void *insn, u8 opcode, void *func)
+enum insn_type {
+	call = 0, /* site call */
+	nop = 1,  /* site cond-call */
+	jmp = 2,  /* tramp / site tail-call */
+	ret = 3,  /* tramp / site cond-tail-call */
+};
+
+static void __static_call_transform(void *insn, enum insn_type type, void *func)
 {
-	const void *code = text_gen_insn(opcode, (long)insn, (long)func);
+	int size = CALL_INSN_SIZE;
+	const void *code;
 
-	if (WARN_ONCE(*(u8 *)insn != opcode,
-		      "unexpected static call insn opcode 0x%x at %pS\n",
-		      opcode, insn))
-		return;
+	switch (type) {
+	case call:
+		code = text_gen_insn(CALL_INSN_OPCODE, insn, func);
+		break;
+
+	case nop:
+		code = ideal_nops[NOP_ATOMIC5];
+		break;
+
+	case jmp:
+		code = text_gen_insn(JMP32_INSN_OPCODE, insn, func);
+		break;
+
+	case ret:
+		code = text_gen_insn(RET_INSN_OPCODE, insn, func);
+		size = RET_INSN_SIZE;
+		break;
+	}
 
-	if (memcmp(insn, code, CALL_INSN_SIZE) == 0)
+	if (memcmp(insn, code, size) == 0)
 		return;
 
-	text_poke_bp(insn, code, CALL_INSN_SIZE, NULL);
+	text_poke_bp(insn, code, size, NULL);
 }
 
 void arch_static_call_transform(void *site, void *tramp, void *func)
@@ -24,10 +46,10 @@ void arch_static_call_transform(void *si
 	mutex_lock(&text_mutex);
 
 	if (tramp)
-		__static_call_transform(tramp, JMP32_INSN_OPCODE, func);
+		__static_call_transform(tramp, jmp + !func, func);
 
 	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site)
-		__static_call_transform(site, CALL_INSN_OPCODE, func);
+		__static_call_transform(site, !func, func);
 
 	mutex_unlock(&text_mutex);
 }
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -17,6 +17,7 @@
  *   DECLARE_STATIC_CALL(name, func);
  *   DEFINE_STATIC_CALL(name, func);
  *   static_call(name)(args...);
+ *   static_cond_call(name)(args...)
  *   static_call_update(name, func);
  *
  * Usage example:
@@ -105,6 +106,7 @@ extern int static_call_text_reserved(voi
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
 #define static_call(name)	STATIC_CALL_TRAMP(name)
+#define static_cond_call(name)	STATIC_CALL_TRAMP(name)
 
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_NAME(name));				\
@@ -128,6 +130,7 @@ struct static_call_key {
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
 #define static_call(name)	STATIC_CALL_TRAMP(name)
+#define static_cond_call(name)	STATIC_CALL_TRAMP(name)
 
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
@@ -161,6 +164,10 @@ struct static_call_key {
 #define static_call(name)						\
 	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_NAME(name).func))
 
+#define static_cond_call(name)						\
+	if (STATIC_CALL_NAME(name).func)				\
+		((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_NAME(name).func))
+
 static inline
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {


