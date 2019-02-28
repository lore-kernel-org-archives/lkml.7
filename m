Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8924EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EE42184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eAZlNiJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbfB1PFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:05:41 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46186 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732081AbfB1PFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=apl5/JV+iRzv9P2F8c9qiW8vKTj+8qTuyZCCuPPE964=; b=eAZlNiJyCN8d6HXsVhOpHSWCRP
        9yYdnVJrfcELLPBedbKuCXhLUmtuJUMSkLIyyvrTazAENQj3cvSdyq1kmUL+UicP89q65WdkZJIfI
        qH9pVJ/ztFXZSZJDKvKaAmL4444uszQzWO9RSOVmWZY/mKtEDndy6ZMW/3sEpWZZNqmgkjq3wpDzd
        E263cvR8E3Jy9fYT/QZoju4aY237yPkK9n5HOWp/Krt2BcgIT0jc27QbffWe6pCligrGgJXyEYstC
        oIcgkmKiH6yVOCK4jZaGOC478xeyOcm3QijppZ62XfTmo9WW/g5AxoCSP2l5wCupRuME1nHHKujkT
        UJP6I0Ow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzNFI-0005bb-Q4; Thu, 28 Feb 2019 15:05:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D4406202C2DA8; Thu, 28 Feb 2019 16:05:08 +0100 (CET)
Message-Id: <20190228150152.444459219@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 28 Feb 2019 15:54:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 5/8] objtool: Rewrite add_ignores()
References: <20190228145450.289603901@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole add_ignores() thing was wildly weird; rewrite it according
to 'modern' ways.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   51 +++++++++++++++++++-------------------------------
 tools/objtool/check.h |    1 
 2 files changed, 20 insertions(+), 32 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -105,29 +105,6 @@ static struct instruction *next_insn_sam
 	     insn = next_insn_same_sec(file, insn))
 
 /*
- * Check if the function has been manually whitelisted with the
- * STACK_FRAME_NON_STANDARD macro, or if it should be automatically whitelisted
- * due to its use of a context switching instruction.
- */
-static bool ignore_func(struct objtool_file *file, struct symbol *func)
-{
-	struct rela *rela;
-
-	/* check for STACK_FRAME_NON_STANDARD */
-	if (file->whitelist && file->whitelist->rela)
-		list_for_each_entry(rela, &file->whitelist->rela->rela_list, list) {
-			if (rela->sym->type == STT_SECTION &&
-			    rela->sym->sec == func->sec &&
-			    rela->addend == func->offset)
-				return true;
-			if (rela->sym->type == STT_FUNC && rela->sym == func)
-				return true;
-		}
-
-	return false;
-}
-
-/*
  * This checks to see if the given function is a "noreturn" function.
  *
  * For global functions which are outside the scope of this object file, we
@@ -436,18 +413,31 @@ static void add_ignores(struct objtool_f
 	struct instruction *insn;
 	struct section *sec;
 	struct symbol *func;
+	struct rela *rela;
 
-	for_each_sec(file, sec) {
-		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->type != STT_FUNC)
-				continue;
+	sec = find_section_by_name(file->elf, ".rela.discard.func_stack_frame_non_standard");
+	if (!sec)
+		return;
 
-			if (!ignore_func(file, func))
+	list_for_each_entry(rela, &sec->rela_list, list) {
+		switch (rela->sym->type) {
+		case STT_FUNC:
+			func = rela->sym;
+			break;
+
+		case STT_SECTION:
+			func = find_symbol_by_offset(rela->sym->sec, rela->addend);
+			if (!func || func->type != STT_FUNC)
 				continue;
+			break;
 
-			func_for_each_insn_all(file, func, insn)
-				insn->ignore = true;
+		default:
+			WARN("unexpected relation symbol type in %s: %d", sec->name, rela->sym->type);
+			continue;
 		}
+
+		func_for_each_insn_all(file, func, insn)
+			insn->ignore = true;
 	}
 }
 
@@ -2198,7 +2188,6 @@ int check(const char *_objname, bool orc
 
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
-	file.whitelist = find_section_by_name(file.elf, ".discard.func_stack_frame_non_standard");
 	file.c_file = find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -60,7 +60,6 @@ struct objtool_file {
 	struct elf *elf;
 	struct list_head insn_list;
 	DECLARE_HASHTABLE(insn_hash, 16);
-	struct section *whitelist;
 	bool ignore_unreachables, c_file, hints, rodata;
 };
 


