Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85317C74A4B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6340820868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfGOAhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:37:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728984AbfGOAh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:37:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 037228535D;
        Mon, 15 Jul 2019 00:37:29 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3CEA5D9D2;
        Mon, 15 Jul 2019 00:37:27 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 02/22] x86/kvm: Fix fastop function ELF metadata
Date:   Sun, 14 Jul 2019 19:36:57 -0500
Message-Id: <649348878d7def10e578e7a85ef853b6314f8979.1563150885.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563150885.git.jpoimboe@redhat.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 15 Jul 2019 00:37:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the fastop functions, e.g. em_setcc(), are actually just used as
global labels which point to blocks of functions.  The global labels are
incorrectly annotated as functions.  Also the functions themselves don't
have size annotations.

Fixes a bunch of warnings like the following:

  arch/x86/kvm/emulate.o: warning: objtool: seto() is missing an ELF size annotation
  arch/x86/kvm/emulate.o: warning: objtool: em_setcc() is missing an ELF size annotation
  arch/x86/kvm/emulate.o: warning: objtool: setno() is missing an ELF size annotation
  arch/x86/kvm/emulate.o: warning: objtool: setc() is missing an ELF size annotation

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
---
 arch/x86/kvm/emulate.c | 44 +++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 8e409ad448f9..718f7d9afedc 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -312,29 +312,42 @@ static void invalidate_registers(struct x86_emulate_ctxt *ctxt)
 
 static int fastop(struct x86_emulate_ctxt *ctxt, void (*fop)(struct fastop *));
 
-#define FOP_FUNC(name) \
+#define __FOP_FUNC(name) \
 	".align " __stringify(FASTOP_SIZE) " \n\t" \
 	".type " name ", @function \n\t" \
 	name ":\n\t"
 
-#define FOP_RET   "ret \n\t"
+#define FOP_FUNC(name) \
+	__FOP_FUNC(#name)
+
+#define __FOP_RET(name) \
+	"ret \n\t" \
+	".size " name ", .-" name "\n\t"
+
+#define FOP_RET(name) \
+	__FOP_RET(#name)
 
 #define FOP_START(op) \
 	extern void em_##op(struct fastop *fake); \
 	asm(".pushsection .text, \"ax\" \n\t" \
 	    ".global em_" #op " \n\t" \
-	    FOP_FUNC("em_" #op)
+	    ".align " __stringify(FASTOP_SIZE) " \n\t" \
+	    "em_" #op ":\n\t"
 
 #define FOP_END \
 	    ".popsection")
 
+#define __FOPNOP(name) \
+	__FOP_FUNC(name) \
+	__FOP_RET(name)
+
 #define FOPNOP() \
-	FOP_FUNC(__stringify(__UNIQUE_ID(nop))) \
-	FOP_RET
+	__FOPNOP(__stringify(__UNIQUE_ID(nop)))
 
 #define FOP1E(op,  dst) \
-	FOP_FUNC(#op "_" #dst) \
-	"10: " #op " %" #dst " \n\t" FOP_RET
+	__FOP_FUNC(#op "_" #dst) \
+	"10: " #op " %" #dst " \n\t" \
+	__FOP_RET(#op "_" #dst)
 
 #define FOP1EEX(op,  dst) \
 	FOP1E(op, dst) _ASM_EXTABLE(10b, kvm_fastop_exception)
@@ -366,8 +379,9 @@ static int fastop(struct x86_emulate_ctxt *ctxt, void (*fop)(struct fastop *));
 	FOP_END
 
 #define FOP2E(op,  dst, src)	   \
-	FOP_FUNC(#op "_" #dst "_" #src) \
-	#op " %" #src ", %" #dst " \n\t" FOP_RET
+	__FOP_FUNC(#op "_" #dst "_" #src) \
+	#op " %" #src ", %" #dst " \n\t" \
+	__FOP_RET(#op "_" #dst "_" #src)
 
 #define FASTOP2(op) \
 	FOP_START(op) \
@@ -405,8 +419,9 @@ static int fastop(struct x86_emulate_ctxt *ctxt, void (*fop)(struct fastop *));
 	FOP_END
 
 #define FOP3E(op,  dst, src, src2) \
-	FOP_FUNC(#op "_" #dst "_" #src "_" #src2) \
-	#op " %" #src2 ", %" #src ", %" #dst " \n\t" FOP_RET
+	__FOP_FUNC(#op "_" #dst "_" #src "_" #src2) \
+	#op " %" #src2 ", %" #src ", %" #dst " \n\t"\
+	__FOP_RET(#op "_" #dst "_" #src "_" #src2)
 
 /* 3-operand, word-only, src2=cl */
 #define FASTOP3WCL(op) \
@@ -423,7 +438,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, void (*fop)(struct fastop *));
 	".type " #op ", @function \n\t" \
 	#op ": \n\t" \
 	#op " %al \n\t" \
-	FOP_RET
+	__FOP_RET(#op)
 
 asm(".pushsection .fixup, \"ax\"\n"
     ".global kvm_fastop_exception \n"
@@ -449,7 +464,10 @@ FOP_SETCC(setle)
 FOP_SETCC(setnle)
 FOP_END;
 
-FOP_START(salc) "pushf; sbb %al, %al; popf \n\t" FOP_RET
+FOP_START(salc)
+FOP_FUNC(salc)
+"pushf; sbb %al, %al; popf \n\t"
+FOP_RET(salc)
 FOP_END;
 
 /*
-- 
2.20.1

