Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEAAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA7D2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cey9WQH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfCRPxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:53:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58734 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfCRPw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pyj763edcoR1fXUgw30kmDTCNPBEafwnGfeuN8Fg/aw=; b=Cey9WQH525Ph0UlBqjbmCCbw1i
        SRo7gRU/xeQygvKEt/50YHXmBaEu/PE7mbdAGC1h808o47q33fw1N7cFA434MVp5eQo7hi3qaPspg
        wcdPcnADkQjO4bFv5XzDgCOZsNae+hJbBZF1J2W8nKXT6xKo55/HRxDu10nmfPuqzulB56WOZTlbi
        35MRXH3zX4T0ToCVQC/sJn3loRFEDsPRUZLxgjKm42aE+YjRSnjvdzPC3BHrQJHYRzc0YXBluKQLg
        PUk/ztrbDZL8lSlGnejrw2Q8gca2nu3rsAYtFKe/xUUL2/ORFR3gC4fygIafFlLh5lhO4NtXLsUBj
        05gmZWzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5uZ9-0005VB-BK; Mon, 18 Mar 2019 15:52:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EEDC9238A0163; Mon, 18 Mar 2019 16:52:38 +0100 (CET)
Message-Id: <20190318155141.935005169@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Mar 2019 16:39:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 22/25] objtool: Fix sibling call detection
References: <20190318153840.906404905@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turned out that we failed to detect some sibling calls;
specifically those without relocation records; like:

$ ./objdump-func.sh defconfig-build/mm/kasan/generic.o __asan_loadN
0000 0000000000000840 <__asan_loadN>:
0000  840:      48 8b 0c 24             mov    (%rsp),%rcx
0004  844:      31 d2                   xor    %edx,%edx
0006  846:      e9 45 fe ff ff          jmpq   690 <check_memory_region>

So extend the cross-function jump to also consider those that are not
between known (or newly detected) parent/child functions, as
sibling-cals when they jump to the start of the function.

The second part of that condition is to deal with random jumps to the
middle of other function, as can be found in
arch/x86/lib/copy_user_64.S for example.

This then (with later patches applied) makes the above recognise the
sibling call:

mm/kasan/generic.o: warning: objtool: __asan_loadN()+0x6: call to check_memory_region() with UACCESS enabled

Also make sure to set insn->call_dest for sibling calls so we can know
who we're calling. This is useful information when printing validation
warnings later.


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   86 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 31 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -515,7 +515,8 @@ static int add_jump_destinations(struct
 			continue;
 		} else {
 			/* sibling call */
-			insn->jump_dest = 0;
+			insn->call_dest = rela->sym;
+			insn->jump_dest = NULL;
 			continue;
 		}
 
@@ -537,25 +538,38 @@ static int add_jump_destinations(struct
 		}
 
 		/*
-		 * For GCC 8+, create parent/child links for any cold
-		 * subfunctions.  This is _mostly_ redundant with a similar
-		 * initialization in read_symbols().
-		 *
-		 * If a function has aliases, we want the *first* such function
-		 * in the symbol table to be the subfunction's parent.  In that
-		 * case we overwrite the initialization done in read_symbols().
-		 *
-		 * However this code can't completely replace the
-		 * read_symbols() code because this doesn't detect the case
-		 * where the parent function's only reference to a subfunction
-		 * is through a switch table.
+		 * Cross-function jump.
 		 */
 		if (insn->func && insn->jump_dest->func &&
-		    insn->func != insn->jump_dest->func &&
-		    !strstr(insn->func->name, ".cold.") &&
-		    strstr(insn->jump_dest->func->name, ".cold.")) {
-			insn->func->cfunc = insn->jump_dest->func;
-			insn->jump_dest->func->pfunc = insn->func;
+		    insn->func != insn->jump_dest->func) {
+
+			/*
+			 * For GCC 8+, create parent/child links for any cold
+			 * subfunctions.  This is _mostly_ redundant with a
+			 * similar initialization in read_symbols().
+			 *
+			 * If a function has aliases, we want the *first* such
+			 * function in the symbol table to be the subfunction's
+			 * parent.  In that case we overwrite the
+			 * initialization done in read_symbols().
+			 *
+			 * However this code can't completely replace the
+			 * read_symbols() code because this doesn't detect the
+			 * case where the parent function's only reference to a
+			 * subfunction is through a switch table.
+			 */
+			if (!strstr(insn->func->name, ".cold.") &&
+			    strstr(insn->jump_dest->func->name, ".cold.")) {
+				insn->func->cfunc = insn->jump_dest->func;
+				insn->jump_dest->func->pfunc = insn->func;
+
+			} else if (insn->jump_dest->func->pfunc != insn->func->pfunc &&
+				   insn->jump_dest->offset == insn->jump_dest->func->offset) {
+
+				/* sibling class */
+				insn->call_dest = insn->jump_dest->func;
+				insn->jump_dest = NULL;
+			}
 		}
 	}
 
@@ -1785,6 +1799,17 @@ static bool insn_state_match(struct inst
 	return false;
 }
 
+static int validate_sibling_call(struct instruction *insn, struct insn_state *state)
+{
+	if (has_modified_stack_frame(state)) {
+		WARN_FUNC("sibling call from callable instruction with modified stack frame",
+				insn->sec, insn->offset);
+		return 1;
+	}
+
+	return 0;
+}
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -1935,9 +1960,14 @@ static int validate_branch(struct objtoo
 
 		case INSN_JUMP_CONDITIONAL:
 		case INSN_JUMP_UNCONDITIONAL:
-			if (insn->jump_dest &&
-			    (!func || !insn->jump_dest->func ||
-			     insn->jump_dest->func->pfunc == func)) {
+			if (func && !insn->jump_dest) {
+				ret = validate_sibling_call(insn, &state);
+				if (ret)
+					return ret;
+
+			} else if (insn->jump_dest &&
+				   (!func || !insn->jump_dest->func ||
+				    insn->jump_dest->func->pfunc == func)) {
 				ret = validate_branch(file, insn->jump_dest,
 						      state);
 				if (ret) {
@@ -1945,11 +1975,6 @@ static int validate_branch(struct objtoo
 						BT_FUNC("(branch)", insn);
 					return ret;
 				}
-
-			} else if (func && has_modified_stack_frame(&state)) {
-				WARN_FUNC("sibling call from callable instruction with modified stack frame",
-					  sec, insn->offset);
-				return 1;
 			}
 
 			if (insn->type == INSN_JUMP_UNCONDITIONAL)
@@ -1958,11 +1983,10 @@ static int validate_branch(struct objtoo
 			break;
 
 		case INSN_JUMP_DYNAMIC:
-			if (func && list_empty(&insn->alts) &&
-			    has_modified_stack_frame(&state)) {
-				WARN_FUNC("sibling call from callable instruction with modified stack frame",
-					  sec, insn->offset);
-				return 1;
+			if (func && list_empty(&insn->alts)) {
+				ret = validate_sibling_call(insn, &state);
+				if (ret)
+					return ret;
 			}
 
 			return 0;


