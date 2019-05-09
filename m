Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B4CC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7352173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557414836;
	bh=OVQElM/76jTzfcjfFTfRJ/8pMuflNKws28Ul3QyoEao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m5KIGBgh4ahphwSae3DINFteGhqpouGx3f2QgDOPC+EGvHy07Vu4VA9GzM8swCXUp
	 cWQviIIvRIpcEut7GiRldfIvnoZjPS7vs8KwGoWDc4Ze3oVviCOU4pw+7rXVSW/yW5
	 PqgJFjQa5S9C2E0lwhggtkI+E+ZpXzfSN2qFNFHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfEIPNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 11:13:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfEIPNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 11:13:55 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98381216C4;
        Thu,  9 May 2019 15:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557414833;
        bh=OVQElM/76jTzfcjfFTfRJ/8pMuflNKws28Ul3QyoEao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CUgGJy8brvhKqegqv6P9tKKFHI9F8xRyQbvf3VqbQC8tZQt7kgOkKbf0J4zK5b21e
         ZMAMuOKH6FjmqD/LPnss53qd6MRvtsrBy0N0VCukzrt/lKlNb8Py6xdChCWr2f5QDe
         kS9ycLmAEFJOFKofZ5/N6p9Y8Gv6Bucs6OwnkBRg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: [PATCH -tip v8 4/6] tracing/probe: Support user-space dereference
Date:   Fri, 10 May 2019 00:13:47 +0900
Message-Id: <155741482716.28419.742818300507337118.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155741476971.28419.15837024173365724167.stgit@devnote2>
References: <155741476971.28419.15837024173365724167.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support user-space dereference syntax for probe event arguments
to dereference the data-structure or array in user-space.

The syntax is just adding 'u' before an offset value.

 +|-u<OFFSET>(<FETCHARG>)

e.g. +u8(%ax), +u0(+0(%si))

For example, if you probe do_sched_setscheduler(pid, policy,
param) and record param->sched_priority, you can add new
probe as below;

 p do_sched_setscheduler priority=+u0($arg3)

Note that kprobe event provides this and it doesn't change the
dereference method automatically because we do not know whether
the given address is in userspace or kernel on some archs.

So as same as "ustring", this is an option for user, who has to
carefully choose the dereference method.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Changes in v7:
  - Fix typos and update document according to Steve's comment.
 Changes in v4:
  - Fix a bug for parsing argument and simplify code.
  - Fix documents accroding to Steve's comment.
 Changes in v3:
  - Add a section for user memory access to the document.
---
 Documentation/trace/kprobetrace.rst  |   27 ++++++++++++++++++++++-----
 Documentation/trace/uprobetracer.rst |   10 ++++++----
 kernel/trace/trace.c                 |    5 +++--
 kernel/trace/trace_kprobe.c          |    6 ++++++
 kernel/trace/trace_probe.c           |   25 ++++++++++++++++++-------
 kernel/trace/trace_probe.h           |    2 ++
 kernel/trace/trace_probe_tmpl.h      |   23 ++++++++++++++++++-----
 kernel/trace/trace_uprobe.c          |    7 +++++++
 8 files changed, 82 insertions(+), 23 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index a3ac7c9ac242..09ff474493e1 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -51,7 +51,7 @@ Synopsis of kprobe_events
   $argN		: Fetch the Nth function argument. (N >= 1) (\*1)
   $retval	: Fetch return value.(\*2)
   $comm		: Fetch current task comm.
-  +|-offs(FETCHARG) : Fetch memory at FETCHARG +|- offs address.(\*3)
+  +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*3)(\*4)
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
 		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
@@ -61,6 +61,7 @@ Synopsis of kprobe_events
   (\*1) only for the probe on function entry (offs == 0).
   (\*2) only for return probe.
   (\*3) this is useful for fetching a field of data structures.
+  (\*4) "u" means user-space dereference. See :ref:`user_mem_access`.
 
 Types
 -----
@@ -79,10 +80,7 @@ wrong, but '+8($stack):x8[8]' is OK.)
 String type is a special type, which fetches a "null-terminated" string from
 kernel space. This means it will fail and store NULL if the string container
 has been paged out. "ustring" type is an alternative of string for user-space.
-Note that kprobe-event provides string/ustring types, but doesn't change it
-automatically. So user has to decide if the targe string in kernel or in user
-space carefully. On some arch, if you choose wrong one, it always fails to
-record string data.
+See :ref:`user_mem_access` for more info..
 The string array type is a bit different from other types. For other base
 types, <base-type>[1] is equal to <base-type> (e.g. +0(%di):x32[1] is same
 as +0(%di):x32.) But string[1] is not equal to string. The string type itself
@@ -97,6 +95,25 @@ Symbol type('symbol') is an alias of u32 or u64 type (depends on BITS_PER_LONG)
 which shows given pointer in "symbol+offset" style.
 For $comm, the default type is "string"; any other type is invalid.
 
+.. _user_mem_access:
+User Memory Access
+------------------
+Kprobe events supports user-space memory access. For that purpose, you can use
+either user-space dereference syntax or 'ustring' type.
+
+The user-space dereference syntax allows you to access a field of a data
+structure in user-space. This is done by adding the "u" prefix to the
+dereference syntax. For example, +u4(%si) means it will read memory from the
+address in the register %si offset by 4, and the memory is expected to be in
+user-space. You can use this for strings too, e.g. +u0(%si):string will read
+a string from the address in the register %si that is expected to be in user-
+space. 'ustring' is a shortcut way of performing the same task. That is,
++0(%si):ustring is equivalent to +u0(%si):string.
+
+Note that kprobe-event provides the user-memory access syntax but it doesn't
+use it transparently. This means if you use normal dereference or string type
+for user memory, it might fail, and may always fail on some archs. The user
+has to carefully check if the target data is in kernel or user space.
 
 Per-Probe Event Filtering
 -------------------------
diff --git a/Documentation/trace/uprobetracer.rst b/Documentation/trace/uprobetracer.rst
index 4346e23e3ae7..ab13319c66ac 100644
--- a/Documentation/trace/uprobetracer.rst
+++ b/Documentation/trace/uprobetracer.rst
@@ -42,16 +42,18 @@ Synopsis of uprobe_tracer
    @+OFFSET	: Fetch memory at OFFSET (OFFSET from same file as PATH)
    $stackN	: Fetch Nth entry of stack (N >= 0)
    $stack	: Fetch stack address.
-   $retval	: Fetch return value.(*)
+   $retval	: Fetch return value.(\*1)
    $comm	: Fetch current task comm.
-   +|-offs(FETCHARG) : Fetch memory at FETCHARG +|- offs address.(**)
+   +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*2)(\*3)
    NAME=FETCHARG     : Set NAME as the argument name of FETCHARG.
    FETCHARG:TYPE     : Set TYPE as the type of FETCHARG. Currently, basic types
 		       (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
 		       (x8/x16/x32/x64), "string" and bitfield are supported.
 
-  (*) only for return probe.
-  (**) this is useful for fetching a field of data structures.
+  (\*1) only for return probe.
+  (\*2) this is useful for fetching a field of data structures.
+  (\*3) Unlike kprobe event, "u" prefix will just be ignored, becuse uprobe
+        events can access only user-space memory.
 
 Types
 -----
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 69687ad83228..a5ec61866cd6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4807,10 +4807,11 @@ static const char readme_msg[] =
 	"\t     args: <name>=fetcharg[:type]\n"
 	"\t fetcharg: %<register>, @<address>, @<symbol>[+|-<offset>],\n"
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
-	"\t           $stack<index>, $stack, $retval, $comm, $arg<N>\n"
+	"\t           $stack<index>, $stack, $retval, $comm, $arg<N>,\n"
 #else
-	"\t           $stack<index>, $stack, $retval, $comm\n"
+	"\t           $stack<index>, $stack, $retval, $comm,\n"
 #endif
+	"\t           +|-[u]<offset>(<fetcharg>)\n"
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
 	"\t           <type>\\[<array-size>\\]\n"
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 6279ed26a739..3663ae6bd735 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -932,6 +932,12 @@ probe_mem_read(void *dest, void *src, size_t size)
 	return probe_kernel_read(dest, src, size);
 }
 
+static nokprobe_inline int
+probe_mem_read_user(void *dest, void *src, size_t size)
+{
+	return probe_user_read(dest, src, size);
+}
+
 /* Note that we don't verify it, since the code does not come from user space */
 static int
 process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 30054136cfde..00771e7b6ef8 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -253,6 +253,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 {
 	struct fetch_insn *code = *pcode;
 	unsigned long param;
+	int deref = FETCH_OP_DEREF;
 	long offset = 0;
 	char *tmp;
 	int ret = 0;
@@ -315,9 +316,14 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		break;
 
 	case '+':	/* deref memory */
-		arg++;	/* Skip '+', because kstrtol() rejects it. */
-		/* fall through */
 	case '-':
+		if (arg[1] == 'u') {
+			deref = FETCH_OP_UDEREF;
+			arg[1] = arg[0];
+			arg++;
+		}
+		if (arg[0] == '+')
+			arg++;	/* Skip '+', because kstrtol() rejects it. */
 		tmp = strchr(arg, '(');
 		if (!tmp)
 			return -EINVAL;
@@ -343,7 +349,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 				return -E2BIG;
 			*pcode = code;
 
-			code->op = FETCH_OP_DEREF;
+			code->op = deref;
 			code->offset = offset;
 		}
 		break;
@@ -459,13 +465,14 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 	/* Store operation */
 	if (!strcmp(parg->type->name, "string") ||
 	    !strcmp(parg->type->name, "ustring")) {
-		if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_IMM &&
-		    code->op != FETCH_OP_COMM) {
+		if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_UDEREF
+		    && code->op != FETCH_OP_IMM && code->op != FETCH_OP_COMM) {
 			pr_info("string only accepts memory or address.\n");
 			ret = -EINVAL;
 			goto fail;
 		}
-		if (code->op != FETCH_OP_DEREF || parg->count) {
+		if ((code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM)
+		    || parg->count) {
 			/*
 			 * IMM and COMM is pointing actual address, those must
 			 * be kept, and if parg->count != 0, this is an array
@@ -478,7 +485,8 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 			}
 		}
 		/* If op == DEREF, replace it with STRING */
-		if (!strcmp(parg->type->name, "ustring"))
+		if (!strcmp(parg->type->name, "ustring") ||
+		    code->op == FETCH_OP_UDEREF)
 			code->op = FETCH_OP_ST_USTRING;
 		else
 			code->op = FETCH_OP_ST_STRING;
@@ -487,6 +495,9 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 	} else if (code->op == FETCH_OP_DEREF) {
 		code->op = FETCH_OP_ST_MEM;
 		code->size = parg->type->size;
+	} else if (code->op == FETCH_OP_UDEREF) {
+		code->op = FETCH_OP_ST_UMEM;
+		code->size = parg->type->size;
 	} else {
 		code++;
 		if (code->op != FETCH_OP_NOP) {
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 94cdcfdaced0..0feac0a81f82 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -92,9 +92,11 @@ enum fetch_op {
 	FETCH_OP_FOFFS,		/* File offset: .immediate */
 	// Stage 2 (dereference) op
 	FETCH_OP_DEREF,		/* Dereference: .offset */
+	FETCH_OP_UDEREF,	/* User-space Dereference: .offset */
 	// Stage 3 (store) ops
 	FETCH_OP_ST_RAW,	/* Raw: .size */
 	FETCH_OP_ST_MEM,	/* Mem: .offset, .size */
+	FETCH_OP_ST_UMEM,	/* Mem: .offset, .size */
 	FETCH_OP_ST_STRING,	/* String: .offset, .size */
 	FETCH_OP_ST_USTRING,	/* User String: .offset, .size */
 	// Stage 4 (modify) op
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 7526f6f8d7b0..06f2d901c4cf 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -64,6 +64,8 @@ static nokprobe_inline int
 fetch_store_string_user(unsigned long addr, void *dest, void *base);
 static nokprobe_inline int
 probe_mem_read(void *dest, void *src, size_t size);
+static nokprobe_inline int
+probe_mem_read_user(void *dest, void *src, size_t size);
 
 /* From the 2nd stage, routine is same */
 static nokprobe_inline int
@@ -77,14 +79,21 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 
 stage2:
 	/* 2nd stage: dereference memory if needed */
-	while (code->op == FETCH_OP_DEREF) {
-		lval = val;
-		ret = probe_mem_read(&val, (void *)val + code->offset,
-					sizeof(val));
+	do {
+		if (code->op == FETCH_OP_DEREF) {
+			lval = val;
+			ret = probe_mem_read(&val, (void *)val + code->offset,
+					     sizeof(val));
+		} else if (code->op == FETCH_OP_UDEREF) {
+			lval = val;
+			ret = probe_mem_read_user(&val,
+				 (void *)val + code->offset, sizeof(val));
+		} else
+			break;
 		if (ret)
 			return ret;
 		code++;
-	}
+	} while (1);
 
 	s3 = code;
 stage3:
@@ -109,6 +118,10 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 	case FETCH_OP_ST_MEM:
 		probe_mem_read(dest, (void *)val + code->offset, code->size);
 		break;
+	case FETCH_OP_ST_UMEM:
+		probe_mem_read_user(dest, (void *)val + code->offset,
+				    code->size);
+		break;
 	case FETCH_OP_ST_STRING:
 		loc = *(u32 *)dest;
 		ret = fetch_store_string(val + code->offset, dest, base);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index f4e37c4f8a21..5bc8c3686f6f 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -140,6 +140,13 @@ probe_mem_read(void *dest, void *src, size_t size)
 
 	return copy_from_user(dest, vaddr, size) ? -EFAULT : 0;
 }
+
+static nokprobe_inline int
+probe_mem_read_user(void *dest, void *src, size_t size)
+{
+	return probe_mem_read(dest, src, size);
+}
+
 /*
  * Fetch a null-terminated string. Caller MUST set *(u32 *)dest with max
  * length and relative data location.

