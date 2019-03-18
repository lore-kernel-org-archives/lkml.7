Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8D0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F072087E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zyEV6god"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfCRPyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:54:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58746 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbfCRPxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2CI0umJLsrxlB4HBXrCEBIdxBhVPylJITwtQNctE51Q=; b=zyEV6godxY/eGIQtn9ahWPMGIv
        1OMEG7r1+M/rSLrjykySsK1Xn7kzJVdeTy1SrfA6wy3MXhIEzycleAHIHFG2scbdGIcHWk26GY3Za
        dsTeFQTTGiHdqLqFOACUtCzlaKbEz6FV2hleUwwZqhUVHegNUlnhGJCM7XsFZjyNmkB2NldKK2z15
        GMMz2cm3SlJloiO8duUFmlUnrEdJ+4vHS1aBuEp7t5q8FAYjDu+VeQ+S352NN6FNru5WYybu62PqI
        XyyXPXViRmalvlGGeCk4uB4xL80b1vzsDfYNLZ3l4kqi+UB3p/sp+F/WuV69zJDcBQiJiWKNNhCIo
        B1CcqRmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5uZA-0005VS-GC; Mon, 18 Mar 2019 15:52:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 00578238A0164; Mon, 18 Mar 2019 16:52:38 +0100 (CET)
Message-Id: <20190318155142.025214872@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 18 Mar 2019 16:39:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: [PATCH 23/25] objtool: Add UACCESS validation
References: <20190318153840.906404905@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is important that UACCESS regions are as small as possible;
furthermore the UACCESS state is not scheduled, so doing anything that
might directly call into the scheduler will cause random code to be
ran with UACCESS enabled.

Teach objtool too track UACCESS state and warn about any CALL made
while UACCESS is enabled. This very much includes the __fentry__()
and __preempt_schedule() calls.

Note that exceptions _do_ save/restore the UACCESS state, and therefore
they can drive preemption. This also means that all exception handlers
must have an otherwise redundant UACCESS disable instruction;
therefore ignore this warning for !STT_FUNC code (exception handlers
are not normal functions).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 scripts/Makefile.build          |    3 
 tools/objtool/arch.h            |    4 
 tools/objtool/arch/x86/decode.c |    9 +-
 tools/objtool/builtin-check.c   |    3 
 tools/objtool/builtin.h         |    2 
 tools/objtool/check.c           |  169 +++++++++++++++++++++++++++++++++++++---
 tools/objtool/check.h           |    2 
 tools/objtool/elf.h             |    1 
 tools/objtool/special.c         |   18 ++++
 tools/objtool/special.h         |    1 
 10 files changed, 196 insertions(+), 16 deletions(-)

--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -225,6 +225,9 @@ endif
 ifdef CONFIG_RETPOLINE
   objtool_args += --retpoline
 endif
+ifdef CONFIG_X86_SMAP
+  objtool_args += --uaccess
+endif
 
 # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -33,7 +33,9 @@
 #define INSN_STACK		8
 #define INSN_BUG		9
 #define INSN_NOP		10
-#define INSN_OTHER		11
+#define INSN_STAC		11
+#define INSN_CLAC		12
+#define INSN_OTHER		13
 #define INSN_LAST		INSN_OTHER
 
 enum op_dest_type {
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -369,7 +369,14 @@ int arch_decode_instruction(struct elf *
 
 	case 0x0f:
 
-		if (op2 >= 0x80 && op2 <= 0x8f) {
+		if (op2 == 0x01) {
+
+			if (modrm == 0xca)
+				*type = INSN_CLAC;
+			else if (modrm == 0xcb)
+				*type = INSN_STAC;
+
+		} else if (op2 >= 0x80 && op2 <= 0x8f) {
 
 			*type = INSN_JUMP_CONDITIONAL;
 
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -29,7 +29,7 @@
 #include "builtin.h"
 #include "check.h"
 
-bool no_fp, no_unreachable, retpoline, module, backtrace;
+bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -42,6 +42,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('r', "retpoline", &retpoline, "Validate retpoline assumptions"),
 	OPT_BOOLEAN('m', "module", &module, "Indicates the object will be part of a kernel module"),
 	OPT_BOOLEAN('b', "backtrace", &backtrace, "unwind on error"),
+	OPT_BOOLEAN('a', "uaccess", &uaccess, "enable uaccess checking"),
 	OPT_END(),
 };
 
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -20,7 +20,7 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline, module, backtrace;
+extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -443,6 +443,82 @@ static void add_ignores(struct objtool_f
 }
 
 /*
+ * This is a whitelist of functions that is allowed to be called with AC set.
+ * The list is meant to be minimal and only contains compiler instrumentation
+ * ABI and a few functions used to implement *_{to,from}_user() functions.
+ *
+ * These functions must not directly change AC, but may PUSHF/POPF.
+ */
+static const char *uaccess_safe_builtin[] = {
+	/* KASAN */
+	"kasan_report",
+	"check_memory_region",
+	/* KASAN out-of-line */
+	"__asan_loadN_noabort",
+	"__asan_load1_noabort",
+	"__asan_load2_noabort",
+	"__asan_load4_noabort",
+	"__asan_load8_noabort",
+	"__asan_load16_noabort",
+	"__asan_storeN_noabort",
+	"__asan_store1_noabort",
+	"__asan_store2_noabort",
+	"__asan_store4_noabort",
+	"__asan_store8_noabort",
+	"__asan_store16_noabort",
+	/* KASAN in-line */
+	"__asan_report_load_n_noabort",
+	"__asan_report_load1_noabort",
+	"__asan_report_load2_noabort",
+	"__asan_report_load4_noabort",
+	"__asan_report_load8_noabort",
+	"__asan_report_load16_noabort",
+	"__asan_report_store_n_noabort",
+	"__asan_report_store1_noabort",
+	"__asan_report_store2_noabort",
+	"__asan_report_store4_noabort",
+	"__asan_report_store8_noabort",
+	"__asan_report_store16_noabort",
+	/* KCOV */
+	"write_comp_data",
+	"__sanitizer_cov_trace_pc",
+	"__sanitizer_cov_trace_const_cmp1",
+	"__sanitizer_cov_trace_const_cmp2",
+	"__sanitizer_cov_trace_const_cmp4",
+	"__sanitizer_cov_trace_const_cmp8",
+	"__sanitizer_cov_trace_cmp1",
+	"__sanitizer_cov_trace_cmp2",
+	"__sanitizer_cov_trace_cmp4",
+	"__sanitizer_cov_trace_cmp8",
+	/* UBSAN */
+	"ubsan_type_mismatch_common",
+	"__ubsan_handle_type_mismatch",
+	"__ubsan_handle_type_mismatch_v1",
+	/* misc */
+	"csum_partial_copy_generic",
+	"__memcpy_mcsafe",
+	"ftrace_likely_update", /* CONFIG_TRACE_BRANCH_PROFILING */
+	NULL
+};
+
+static void add_uaccess_safe(struct objtool_file *file)
+{
+	struct symbol *func;
+	const char **name;
+
+	if (!uaccess)
+		return;
+
+	for (name = uaccess_safe_builtin; *name; name++) {
+		func = find_symbol_by_name(file->elf, *name);
+		if (!func)
+			continue;
+
+		func->alias->uaccess_safe = true;
+	}
+}
+
+/*
  * FIXME: For now, just ignore any alternatives which add retpolines.  This is
  * a temporary hack, as it doesn't allow ORC to unwind from inside a retpoline.
  * But it at least allows objtool to understand the control flow *around* the
@@ -818,6 +894,7 @@ static int add_special_section_alts(stru
 
 		alt->insn = new_insn;
 		alt->skip_orig = special_alt->skip_orig;
+		orig_insn->ignore_alts |= special_alt->skip_alt;
 		list_add_tail(&alt->list, &orig_insn->alts);
 
 		list_del(&special_alt->list);
@@ -1239,6 +1316,7 @@ static int decode_sections(struct objtoo
 		return ret;
 
 	add_ignores(file);
+	add_uaccess_safe(file);
 
 	ret = add_ignore_alternatives(file);
 	if (ret)
@@ -1799,6 +1877,33 @@ static bool insn_state_match(struct inst
 	return false;
 }
 
+static inline bool func_uaccess_safe(struct symbol *func)
+{
+	if (func)
+		return func->alias->uaccess_safe;
+
+	return false;
+}
+
+static inline const char *insn_dest_name(struct instruction *insn)
+{
+	if (insn->call_dest)
+		return insn->call_dest->name;
+
+	return "{dynamic}";
+}
+
+static int validate_call(struct instruction *insn, struct insn_state *state)
+{
+	if (state->uaccess && !func_uaccess_safe(insn->call_dest)) {
+		WARN_FUNC("call to %s() with UACCESS enabled",
+				insn->sec, insn->offset, insn_dest_name(insn));
+		return 1;
+	}
+
+	return 0;
+}
+
 static int validate_sibling_call(struct instruction *insn, struct insn_state *state)
 {
 	if (has_modified_stack_frame(state)) {
@@ -1807,7 +1912,7 @@ static int validate_sibling_call(struct
 		return 1;
 	}
 
-	return 0;
+	return validate_call(insn, state);
 }
 
 /*
@@ -1855,7 +1960,9 @@ static int validate_branch(struct objtoo
 			if (!insn->hint && !insn_state_match(insn, &state))
 				return 1;
 
-			return 0;
+			/* If we were here with AC=0, but now have AC=1, go again */
+			if (insn->state.uaccess || !state.uaccess)
+				return 0;
 		}
 
 		if (insn->hint) {
@@ -1925,6 +2032,16 @@ static int validate_branch(struct objtoo
 		switch (insn->type) {
 
 		case INSN_RETURN:
+			if (state.uaccess && !func_uaccess_safe(func)) {
+				WARN_FUNC("return with UACCESS enabled", sec, insn->offset);
+				return 1;
+			}
+
+			if (!state.uaccess && func_uaccess_safe(func)) {
+				WARN_FUNC("return with UACCESS disabled from a UACCESS-safe function", sec, insn->offset);
+				return 1;
+			}
+
 			if (func && has_modified_stack_frame(&state)) {
 				WARN_FUNC("return with modified stack frame",
 					  sec, insn->offset);
@@ -1940,17 +2057,22 @@ static int validate_branch(struct objtoo
 			return 0;
 
 		case INSN_CALL:
-			if (is_fentry_call(insn))
-				break;
+		case INSN_CALL_DYNAMIC:
+			ret = validate_call(insn, &state);
+			if (ret)
+				return ret;
 
-			ret = dead_end_function(file, insn->call_dest);
-			if (ret == 1)
-				return 0;
-			if (ret == -1)
-				return 1;
+			if (insn->type == INSN_CALL) {
+				if (is_fentry_call(insn))
+					break;
+
+				ret = dead_end_function(file, insn->call_dest);
+				if (ret == 1)
+					return 0;
+				if (ret == -1)
+					return 1;
+			}
 
-			/* fallthrough */
-		case INSN_CALL_DYNAMIC:
 			if (!no_fp && func && !has_valid_stack_frame(&state)) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
@@ -2005,6 +2127,29 @@ static int validate_branch(struct objtoo
 
 			break;
 
+		case INSN_STAC:
+			if (state.uaccess) {
+				WARN_FUNC("recursive UACCESS enable", sec, insn->offset);
+				return 1;
+			}
+
+			state.uaccess = true;
+			break;
+
+		case INSN_CLAC:
+			if (!state.uaccess && insn->func) {
+				WARN_FUNC("redundant UACCESS disable", sec, insn->offset);
+				return 1;
+			}
+
+			if (func_uaccess_safe(func)) {
+				WARN_FUNC("UACCESS-safe disables UACCESS", sec, insn->offset);
+				return 1;
+			}
+
+			state.uaccess = false;
+			break;
+
 		default:
 			break;
 		}
@@ -2168,6 +2313,8 @@ static int validate_functions(struct obj
 			if (!insn || insn->ignore)
 				continue;
 
+			state.uaccess = func->alias->uaccess_safe;
+
 			ret = validate_branch(file, insn, state);
 			if (ret && backtrace)
 				BT_FUNC("<=== (func)", insn);
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -31,7 +31,7 @@ struct insn_state {
 	int stack_size;
 	unsigned char type;
 	bool bp_scratch;
-	bool drap, end;
+	bool drap, end, uaccess;
 	int drap_reg, drap_offset;
 	struct cfi_reg vals[CFI_NUM_REGS];
 };
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -62,6 +62,7 @@ struct symbol {
 	unsigned long offset;
 	unsigned int len;
 	struct symbol *pfunc, *cfunc, *alias;
+	bool uaccess_safe;
 };
 
 struct rela {
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -23,6 +23,7 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include "builtin.h"
 #include "special.h"
 #include "warn.h"
 
@@ -42,6 +43,7 @@
 #define ALT_NEW_LEN_OFFSET	11
 
 #define X86_FEATURE_POPCNT (4*32+23)
+#define X86_FEATURE_SMAP   (9*32+20)
 
 struct special_entry {
 	const char *sec;
@@ -110,6 +112,22 @@ static int get_alt_entry(struct elf *elf
 		 */
 		if (feature == X86_FEATURE_POPCNT)
 			alt->skip_orig = true;
+
+		/*
+		 * If UACCESS validation is enabled; force that alternative;
+		 * otherwise force it the other way.
+		 *
+		 * What we want to avoid is having both the original and the
+		 * alternative code flow at the same time, in that case we can
+		 * find paths that see the STAC but take the NOP instead of
+		 * CLAC and the other way around.
+		 */
+		if (feature == X86_FEATURE_SMAP) {
+			if (uaccess)
+				alt->skip_orig = true;
+			else
+				alt->skip_alt = true;
+		}
 	}
 
 	orig_rela = find_rela_by_dest(sec, offset + entry->orig);
--- a/tools/objtool/special.h
+++ b/tools/objtool/special.h
@@ -26,6 +26,7 @@ struct special_alt {
 
 	bool group;
 	bool skip_orig;
+	bool skip_alt;
 	bool jump_or_nop;
 
 	struct section *orig_sec;


