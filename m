Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DFDC74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 23:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F1D20665
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 23:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfGJXWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 19:22:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbfGJXWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 19:22:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4FA338552A;
        Wed, 10 Jul 2019 23:22:47 +0000 (UTC)
Received: from treble (ovpn-122-237.rdu2.redhat.com [10.10.122.237])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EF6EE5D9CC;
        Wed, 10 Jul 2019 23:22:45 +0000 (UTC)
Date:   Wed, 10 Jul 2019 18:22:44 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Craig Topper <craig.topper@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Bill Wendling <morbo@google.com>,
        Stephen Hines <srhines@google.com>
Subject: Re: objtool warnings in prerelease clang-9
Message-ID: <20190710232244.to73phlufdetf5os@treble>
References: <CAKwvOdnGL_9cJ+ETNce89+z7CTDctjACS8DFsLu=ev4+vkVkUw@mail.gmail.com>
 <alpine.DEB.2.21.1907022332000.1802@nanos.tec.linutronix.de>
 <20190706155001.yrfxqj7c2bmqtbid@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190706155001.yrfxqj7c2bmqtbid@treble>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 10 Jul 2019 23:22:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 06, 2019 at 10:50:01AM -0500, Josh Poimboeuf wrote:
> On Tue, Jul 02, 2019 at 11:58:27PM +0200, Thomas Gleixner wrote:
> > platform-quirks.o:
> > 
> >         if (x86_platform.set_legacy_features)
> >   74:   4c 8b 1d 00 00 00 00    mov    0x0(%rip),%r11        # 7b <x86_early_init_platform_quirks+0x7b>
> >   7b:   4d 85 db                test   %r11,%r11
> >   7e:   0f 85 00 00 00 00       jne    84 <x86_early_init_platform_quirks+0x84>
> >                 x86_platform.set_legacy_features();
> > }
> >   84:   c3                      retq   
> > 
> > That jne jumps to __x86_indirect_thunk_r11, aka. ratpoutine.
> > 
> > No idea why objtool thinks that the instruction at 0x84 is not
> > reachable. Josh?
> 
> That's a conditional tail call, which is something GCC never does.
> Objtool doesn't understand that, so we'll need to fix it.

Can somebody test this patch to see if it fixes the platform-quirks.o
warning?

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 27818a93f0b1..42fe09a93593 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -97,6 +97,36 @@ static struct instruction *next_insn_same_func(struct objtool_file *file,
 	for (insn = next_insn_same_sec(file, insn); insn;		\
 	     insn = next_insn_same_sec(file, insn))
 
+static bool is_sibling_call(struct instruction *insn)
+{
+	struct symbol *insn_func, *dest_func;
+
+	/* Only C code does sibling calls. */
+	if (!insn->func)
+		return false;
+
+	/* An indirect jump is either a sibling call or a jump to a table. */
+	if (insn->type == INSN_JUMP_DYNAMIC)
+		return list_empty(&insn->alts);
+
+	if (insn->type != INSN_JUMP_CONDITIONAL &&
+	    insn->type != INSN_JUMP_UNCONDITIONAL)
+		return false;
+
+	/* A direct jump to outside the .o file is a sibling call. */
+	if (!insn->jump_dest)
+		return true;
+
+	if (!insn->jump_dest->func)
+		return false;
+
+	/* A direct jump to the beginning of a function is a sibling call. */
+	insn_func = insn->func->pfunc;
+	dest_func = insn->jump_dest->func->pfunc;
+	return insn_func != dest_func &&
+	       insn->jump_dest->offset == dest_func->offset;
+}
+
 /*
  * This checks to see if the given function is a "noreturn" function.
  *
@@ -169,34 +199,25 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 	 * of the sibling call returns.
 	 */
 	func_for_each_insn_all(file, func, insn) {
-		if (insn->type == INSN_JUMP_UNCONDITIONAL) {
+		if (is_sibling_call(insn)) {
 			struct instruction *dest = insn->jump_dest;
 
 			if (!dest)
 				/* sibling call to another file */
 				return 0;
 
-			if (dest->func && dest->func->pfunc != insn->func->pfunc) {
-
-				/* local sibling call */
-				if (recursion == 5) {
-					/*
-					 * Infinite recursion: two functions
-					 * have sibling calls to each other.
-					 * This is a very rare case.  It means
-					 * they aren't dead ends.
-					 */
-					return 0;
-				}
-
-				return __dead_end_function(file, dest->func,
-							   recursion + 1);
+			/* local sibling call */
+			if (recursion == 5) {
+				/*
+				 * Infinite recursion: two functions have
+				 * sibling calls to each other.  This is a very
+				 * rare case.  It means they aren't dead ends.
+				 */
+				return 0;
 			}
-		}
 
-		if (insn->type == INSN_JUMP_DYNAMIC && list_empty(&insn->alts))
-			/* sibling call */
-			return 0;
+			return __dead_end_function(file, dest->func, recursion+1);
+		}
 	}
 
 	return 1;
@@ -635,7 +656,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			} else if (insn->jump_dest->func->pfunc != insn->func->pfunc &&
 				   insn->jump_dest->offset == insn->jump_dest->func->offset) {
 
-				/* sibling class */
+				/* sibling calls */
 				insn->call_dest = insn->jump_dest->func;
 				insn->jump_dest = NULL;
 			}
@@ -2100,7 +2121,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 
 		case INSN_JUMP_CONDITIONAL:
 		case INSN_JUMP_UNCONDITIONAL:
-			if (func && !insn->jump_dest) {
+			if (is_sibling_call(insn)) {
 				ret = validate_sibling_call(insn, &state);
 				if (ret)
 					return ret;
@@ -2123,7 +2144,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
 			break;
 
 		case INSN_JUMP_DYNAMIC:
-			if (func && list_empty(&insn->alts)) {
+			if (is_sibling_call(insn)) {
 				ret = validate_sibling_call(insn, &state);
 				if (ret)
 					return ret;
