Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A028C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED12721530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557322367;
	bh=zyFzyqHWwvk3AR/sc8YizqObM/vTgzJgzNKVBsoDgcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1MHLsHGCszzgJefGKmUjA0uP5szEO8NSWt4cqzyaS/pW6f3R59foBEIgQDcq85UxX
	 6AH2o9UuuwbbjpANxcVB9dQyBe9Laozbr+bBkaEuls9HBBtv2/HiZqXpzMhfWCg3Wp
	 XJRjhNAQ2Ah4TDbUA3YJKQ3H5hkjHAUpFDdCEFpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfEHNcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfEHNcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:32:45 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0583320644;
        Wed,  8 May 2019 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557322364;
        bh=zyFzyqHWwvk3AR/sc8YizqObM/vTgzJgzNKVBsoDgcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IM5IcpB/pWblRWpoUgTuB2G3D3NvovnRvmUZxnEAndkD/6OhG31SoKLVi8oC9AN1v
         RKW0ZfzMfbbv+hOaRKh8ukCj7doN6hDhcrIKML/03Pq2x1HwGuZNj9AkRyoUGbTA0p
         OQ7T48aObEbxnG0XORFI3WXdAgmfn0XdBie79Hg0=
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
Subject: [PATCH v7 4/6] tracing/probe: Support user-space dereference
Date:   Wed,  8 May 2019 22:32:37 +0900
Message-Id: <155732235767.12756.13605765237848440988.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155732230159.12756.15040196512285621636.stgit@devnote2>
References: <155732230159.12756.15040196512285621636.stgit@devnote2>
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
index 101a5d09a632..006d4dda95bf 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4853,10 +4853,11 @@ static const char readme_msg[] =
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
index fcb8806fc93c..c8ff152ef054 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -945,6 +945,12 @@ probe_mem_read(void *dest, void *src, size_t size)
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
index 7df9f53a372d..d7c278760d88 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -324,6 +324,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 {
 	struct fetch_insn *code = *pcode;
 	unsigned long param;
+	int deref = FETCH_OP_DEREF;
 	long offset = 0;
 	char *tmp;
 	int ret = 0;
@@ -396,9 +397,14 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
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
 		if (!tmp) {
 			trace_probe_log_err(offs, DEREF_NEED_BRACE);
@@ -434,7 +440,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 			}
 			*pcode = code;
 
-			code->op = FETCH_OP_DEREF;
+			code->op = deref;
 			code->offset = offset;
 		}
 		break;
@@ -573,14 +579,15 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 	/* Store operation */
 	if (!strcmp(parg->type->name, "string") ||
 	    !strcmp(parg->type->name, "ustring")) {
-		if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_IMM &&
-		    code->op != FETCH_OP_COMM) {
+		if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_UDEREF
+		    && code->op != FETCH_OP_IMM && code->op != FETCH_OP_COMM) {
 			trace_probe_log_err(offset + (t ? (t - arg) : 0),
 					    BAD_STRING);
 			ret = -EINVAL;
 			goto fail;
 		}
-		if (code->op != FETCH_OP_DEREF || parg->count) {
+		if ((code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM)
+		    || parg->count) {
 			/*
 			 * IMM and COMM is pointing actual address, those must
 			 * be kept, and if parg->count != 0, this is an array
@@ -594,7 +601,8 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 			}
 		}
 		/* If op == DEREF, replace it with STRING */
-		if (!strcmp(parg->type->name, "ustring"))
+		if (!strcmp(parg->type->name, "ustring") ||
+		    code->op == FETCH_OP_UDEREF)
 			code->op = FETCH_OP_ST_USTRING;
 		else
 			code->op = FETCH_OP_ST_STRING;
@@ -603,6 +611,9 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
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
index c7546e7ff8e2..42816358dd48 100644
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
index 2e9e4dae8839..43abbc29479c 100644
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
index 852e998051f6..3d6b868830f3 100644
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

