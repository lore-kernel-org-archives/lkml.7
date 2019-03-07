Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFAAC10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5EF2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f3Wq8KQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfCGLxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:53:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50986 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfCGLw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B7hxdZ2vPFBYOi7Yp1RJm5VZYkQ7QHuzL1aJAJZr1W0=; b=f3Wq8KQ3gk5+af+TBuT85gcmMG
        OOK15BMjMLO8wICQl+XjWMo9AxNs4oliDgYEzqwn0cSxQdl5syVM9NqhZrRhmBnOt94n1HtANPyzf
        q67Ov9TQvyAx/RXkV38/E66A2dTWszCv/MfzhhcLNjj6qfAuZ7RJ2EeUQCXNoSOTE7j4xiVdcB8nY
        rFP8jNTQlehAqFWgMY/6+xDdRb8jPEISSnhdZ7MRrl1dhNDSC1x58c6ZUqaCsWYTtPjWvuWMUtF/h
        tIbvJxSvYwQ3Xe+FvLjRIbU153FTfXL85f3h/O3XMy2VUec+O6zF2qZSh2jB84YXFbzDlmwsjVT0j
        I0LWUDxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1rZo-0005Ph-EJ; Thu, 07 Mar 2019 11:52:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D6B5120291FC5; Thu,  7 Mar 2019 12:52:35 +0100 (CET)
Message-Id: <20190307115200.605521081@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 07 Mar 2019 12:45:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 17/20] objtool: Fix sibling call detection
References: <20190307114511.870090179@infradead.org>
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
who we're calling.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   79 +++++++++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 33 deletions(-)

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
 
@@ -1935,9 +1949,16 @@ static int validate_branch(struct objtoo
 
 		case INSN_JUMP_CONDITIONAL:
 		case INSN_JUMP_UNCONDITIONAL:
-			if (insn->jump_dest &&
-			    (!func || !insn->jump_dest->func ||
-			     insn->jump_dest->func->pfunc == func)) {
+			if (func && !insn->jump_dest) {
+do_sibling_call:
+				if (has_modified_stack_frame(&state)) {
+					WARN_FUNC("sibling call from callable instruction with modified stack frame",
+							sec, insn->offset);
+					return 1;
+				}
+			} else if (insn->jump_dest &&
+				   (!func || !insn->jump_dest->func ||
+				    insn->jump_dest->func->pfunc == func)) {
 				ret = validate_branch(file, insn->jump_dest,
 						      state);
 				if (ret) {
@@ -1945,25 +1966,17 @@ static int validate_branch(struct objtoo
 						BT_FUNC("(branch)", insn);
 					return ret;
 				}
-
-			} else if (func && has_modified_stack_frame(&state)) {
-				WARN_FUNC("sibling call from callable instruction with modified stack frame",
-					  sec, insn->offset);
-				return 1;
 			}
 
-			if (insn->type == INSN_JUMP_UNCONDITIONAL)
+			if (insn->type == INSN_JUMP_UNCONDITIONAL ||
+			    insn->type == INSN_JUMP_DYNAMIC)
 				return 0;
 
 			break;
 
 		case INSN_JUMP_DYNAMIC:
-			if (func && list_empty(&insn->alts) &&
-			    has_modified_stack_frame(&state)) {
-				WARN_FUNC("sibling call from callable instruction with modified stack frame",
-					  sec, insn->offset);
-				return 1;
-			}
+			if (func && list_empty(&insn->alts))
+				goto do_sibling_call;
 
 			return 0;
 


