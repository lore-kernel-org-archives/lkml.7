Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CC9C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CD12081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iik9WXhA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfCGLyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:54:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51000 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfCGLw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bSXKelPry7GsMf9J9KvkQq99PJX5C8KLRaYUkvVNO9M=; b=iik9WXhAHVghRSjWKTMqCf5v+W
        hrx3NBBIL9Ko+66xVeWJdP4/mFoJnP1bUciq1Wq3zv6A42h76BWF+uZKccZ/hZPJGDriMBdgQ86Ns
        NBE/cHlY+rxfZrhPaWIIk038K0f00Gm9vxzIF+0DsHqiB9ABDIO2QPxN0hxsj+nGExB0QLGrF0aUl
        WXxYd6ByXJOAdqsOfE3qUyjEySAc98LhkcODT05Y5xUz21txOSe5w8RyzRIhWXIjQIANHhlNez50m
        XZmLbXykViYphtHcUdfRilOPcJsRjAMQmTRCS6E197b8bXG0F6aOxDMsHGDcgk19b6m+ZrItrm0dS
        JkFAqJ4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1rZo-0005Pf-Dg; Thu, 07 Mar 2019 11:52:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CBA6C20291FC3; Thu,  7 Mar 2019 12:52:35 +0100 (CET)
Message-Id: <20190307115200.419834588@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 07 Mar 2019 12:45:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 15/20] objtool: Add --backtrace support
References: <20190307114511.870090179@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For when you want to know the path that reached your fail state.

$ ./objtool check --no-fp --backtrace arch/x86/lib/usercopy_64.o
arch/x86/lib/usercopy_64.o: warning: objtool: .altinstr_replacement+0x3: UACCESS disable without MEMOPs: __clear_user()
arch/x86/lib/usercopy_64.o: warning: objtool:   __clear_user()+0x3a: (alt)
arch/x86/lib/usercopy_64.o: warning: objtool:   __clear_user()+0x2e: (branch)
arch/x86/lib/usercopy_64.o: warning: objtool:   __clear_user()+0x18: (branch)
arch/x86/lib/usercopy_64.o: warning: objtool:   .altinstr_replacement+0xffffffffffffffff: (branch)
arch/x86/lib/usercopy_64.o: warning: objtool:   __clear_user()+0x5: (alt)
arch/x86/lib/usercopy_64.o: warning: objtool:   __clear_user()+0x0: <=== (func)

0000000000000000 <__clear_user>:
  0:   e8 00 00 00 00          callq  5 <__clear_user+0x5>
               1: R_X86_64_PLT32       __fentry__-0x4
  5:   90                      nop
  6:   90                      nop
  7:   90                      nop
  8:   48 89 f0                mov    %rsi,%rax
  b:   48 c1 ee 03             shr    $0x3,%rsi
  f:   83 e0 07                and    $0x7,%eax
 12:   48 89 f1                mov    %rsi,%rcx
 15:   48 85 c9                test   %rcx,%rcx
 18:   74 0f                   je     29 <__clear_user+0x29>
 1a:   48 c7 07 00 00 00 00    movq   $0x0,(%rdi)
 21:   48 83 c7 08             add    $0x8,%rdi
 25:   ff c9                   dec    %ecx
 27:   75 f1                   jne    1a <__clear_user+0x1a>
 29:   48 89 c1                mov    %rax,%rcx
 2c:   85 c9                   test   %ecx,%ecx
 2e:   74 0a                   je     3a <__clear_user+0x3a>
 30:   c6 07 00                movb   $0x0,(%rdi)
 33:   48 ff c7                inc    %rdi
 36:   ff c9                   dec    %ecx
 38:   75 f6                   jne    30 <__clear_user+0x30>
 3a:   90                      nop
 3b:   90                      nop
 3c:   90                      nop
 3d:   48 89 c8                mov    %rcx,%rax
 40:   c3                      retq


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/builtin-check.c |    3 ++-
 tools/objtool/builtin.h       |    2 +-
 tools/objtool/check.c         |   18 ++++++++++++++----
 tools/objtool/warn.h          |    8 ++++++++
 4 files changed, 25 insertions(+), 6 deletions(-)

--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -29,7 +29,7 @@
 #include "builtin.h"
 #include "check.h"
 
-bool no_fp, no_unreachable, retpoline, module;
+bool no_fp, no_unreachable, retpoline, module, backtrace;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -41,6 +41,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('u', "no-unreachable", &no_unreachable, "Skip 'unreachable instruction' warnings"),
 	OPT_BOOLEAN('r', "retpoline", &retpoline, "Validate retpoline assumptions"),
 	OPT_BOOLEAN('m', "module", &module, "Indicates the object will be part of a kernel module"),
+	OPT_BOOLEAN('b', "backtrace", &backtrace, "unwind on error"),
 	OPT_END(),
 };
 
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -20,7 +20,7 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline, module;
+extern bool no_fp, no_unreachable, retpoline, module, backtrace;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1885,8 +1885,11 @@ static int validate_branch(struct objtoo
 		if (!insn->ignore_alts) {
 			list_for_each_entry(alt, &insn->alts, list) {
 				ret = validate_branch(file, alt->insn, state);
-				if (ret)
-					return 1;
+				if (ret) {
+					if (backtrace)
+						BT_FUNC("(alt)", insn);
+					return ret;
+				}
 			}
 		}
 
@@ -1933,8 +1936,11 @@ static int validate_branch(struct objtoo
 			     insn->jump_dest->func->pfunc == func)) {
 				ret = validate_branch(file, insn->jump_dest,
 						      state);
-				if (ret)
-					return 1;
+				if (ret) {
+					if (backtrace)
+						BT_FUNC("(branch)", insn);
+					return ret;
+				}
 
 			} else if (func && has_modified_stack_frame(&state)) {
 				WARN_FUNC("sibling call from callable instruction with modified stack frame",
@@ -2005,6 +2011,8 @@ static int validate_unwind_hints(struct
 	for_each_insn(file, insn) {
 		if (insn->hint && !insn->visited) {
 			ret = validate_branch(file, insn, state);
+			if (ret && backtrace)
+				BT_FUNC("<=== (hint)", insn);
 			warnings += ret;
 		}
 	}
@@ -2133,6 +2141,8 @@ static int validate_functions(struct obj
 				continue;
 
 			ret = validate_branch(file, insn, state);
+			if (ret && backtrace)
+				BT_FUNC("<=== (func)", insn);
 			warnings += ret;
 		}
 	}
--- a/tools/objtool/warn.h
+++ b/tools/objtool/warn.h
@@ -64,6 +64,14 @@ static inline char *offstr(struct sectio
 	free(_str);					\
 })
 
+#define BT_FUNC(format, insn, ...)			\
+({							\
+	struct instruction *_insn = (insn);		\
+	char *_str = offstr(_insn->sec, _insn->offset); \
+	WARN("  %s: " format, _str, ##__VA_ARGS__);	\
+	free(_str);					\
+})
+
 #define WARN_ELF(format, ...)				\
 	WARN(format ": %s", ##__VA_ARGS__, elf_errmsg(-1))
 


