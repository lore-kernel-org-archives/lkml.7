Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2CAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9AB20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GttlrqQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfCRPyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:54:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfCRPwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zfuHPECgi6nwVnpCak4+jQVpjTed9r1FGpJ/6hHjmWs=; b=GttlrqQa31AYCJgkecs/X17sax
        Hylc6ZADfkEcMxzatVUk7+bsWv4hltmIYhmXQo5ejl797u37kAMS3ZucnIQOVUsAMJBXNpbeDvD00
        3Hdae9qFEnR08VFqGHRtN2xmxOI7s13j2W+IK8hd5mf3QgoCJnsDQH5zorbOg3nId9gkOuodzPr3F
        7T7Karszd9CnIbOdK1tpbtlf7pyG9WayM2hMEmtdv9yfsSrAfbLLvWXW5gkTlzLCxf/iYyNRETEFe
        QgZmmOeyAiO5Kx7k+XuXSSuM/wQk8oyxIIc6oPR/sm9qWni6+osuizPrBgi/XHAf/5XJWQwO5Pjv2
        COnMUzCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5uZ7-0006kt-R7; Mon, 18 Mar 2019 15:52:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A21D825E45D71; Mon, 18 Mar 2019 16:52:38 +0100 (CET)
Message-Id: <20190318155140.536015958@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Mar 2019 16:38:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 07/25] x86/nospec,objtool: Introduce ANNOTATE_IGNORE_ALTERNATIVE
References: <20190318153840.906404905@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To facillitate other usage of ignoring alternatives; rename
ANNOTATE_NOSPEC_IGNORE to ANNOTATE_IGNORE_ALTERNATIVE.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/alternative-asm.h |   11 +++++++++++
 arch/x86/include/asm/alternative.h     |   10 ++++++++++
 arch/x86/include/asm/nospec-branch.h   |   28 +++++++++-------------------
 tools/objtool/check.c                  |    8 ++++----
 4 files changed, 34 insertions(+), 23 deletions(-)

--- a/arch/x86/include/asm/alternative-asm.h
+++ b/arch/x86/include/asm/alternative-asm.h
@@ -20,6 +20,17 @@
 #endif
 
 /*
+ * objtool annotation to ignore the alternatives and only consider the original
+ * instruction(s).
+ */
+.macro ANNOTATE_IGNORE_ALTERNATIVE
+	.Lannotate_\@:
+	.pushsection .discard.ignore_alts
+	.long .Lannotate_\@ - .
+	.popsection
+.endm
+
+/*
  * Issue one struct alt_instr descriptor entry (need to put it into
  * the section .altinstructions, see below). This entry contains
  * enough information for the alternatives patching code to patch an
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -45,6 +45,16 @@
 #define LOCK_PREFIX ""
 #endif
 
+/*
+ * objtool annotation to ignore the alternatives and only consider the original
+ * instruction(s).
+ */
+#define ANNOTATE_IGNORE_ALTERNATIVE				\
+	"999:\n\t"						\
+	".pushsection .discard.ignore_alts\n\t"			\
+	".long 999b - .\n\t"					\
+	".popsection\n\t"
+
 struct alt_instr {
 	s32 instr_offset;	/* original instruction */
 	s32 repl_offset;	/* offset to replacement instruction */
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -11,6 +11,15 @@
 #include <asm/msr-index.h>
 
 /*
+ * This should be used immediately before a retpoline alternative. It tells
+ * objtool where the retpolines are so that it can make sense of the control
+ * flow by just reading the original instruction(s) and ignoring the
+ * alternatives.
+ */
+#define ANNOTATE_NOSPEC_ALTERNATIVE \
+	ANNOTATE_IGNORE_ALTERNATIVE
+
+/*
  * Fill the CPU return stack buffer.
  *
  * Each entry in the RSB, if used for a speculative 'ret', contains an
@@ -57,19 +66,6 @@
 #ifdef __ASSEMBLY__
 
 /*
- * This should be used immediately before a retpoline alternative.  It tells
- * objtool where the retpolines are so that it can make sense of the control
- * flow by just reading the original instruction(s) and ignoring the
- * alternatives.
- */
-.macro ANNOTATE_NOSPEC_ALTERNATIVE
-	.Lannotate_\@:
-	.pushsection .discard.nospec
-	.long .Lannotate_\@ - .
-	.popsection
-.endm
-
-/*
  * This should be used immediately before an indirect jump/call. It tells
  * objtool the subsequent indirect jump/call is vouched safe for retpoline
  * builds.
@@ -152,12 +148,6 @@
 
 #else /* __ASSEMBLY__ */
 
-#define ANNOTATE_NOSPEC_ALTERNATIVE				\
-	"999:\n\t"						\
-	".pushsection .discard.nospec\n\t"			\
-	".long 999b - .\n\t"					\
-	".popsection\n\t"
-
 #define ANNOTATE_RETPOLINE_SAFE					\
 	"999:\n\t"						\
 	".pushsection .discard.retpoline_safe\n\t"		\
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -457,13 +457,13 @@ static void add_ignores(struct objtool_f
  * But it at least allows objtool to understand the control flow *around* the
  * retpoline.
  */
-static int add_nospec_ignores(struct objtool_file *file)
+static int add_ignore_alternatives(struct objtool_file *file)
 {
 	struct section *sec;
 	struct rela *rela;
 	struct instruction *insn;
 
-	sec = find_section_by_name(file->elf, ".rela.discard.nospec");
+	sec = find_section_by_name(file->elf, ".rela.discard.ignore_alts");
 	if (!sec)
 		return 0;
 
@@ -475,7 +475,7 @@ static int add_nospec_ignores(struct obj
 
 		insn = find_insn(file, rela->sym->sec, rela->addend);
 		if (!insn) {
-			WARN("bad .discard.nospec entry");
+			WARN("bad .discard.ignore_alts entry");
 			return -1;
 		}
 
@@ -1239,7 +1239,7 @@ static int decode_sections(struct objtoo
 
 	add_ignores(file);
 
-	ret = add_nospec_ignores(file);
+	ret = add_ignore_alternatives(file);
 	if (ret)
 		return ret;
 


