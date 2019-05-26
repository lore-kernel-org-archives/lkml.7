Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6FAC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E2D216FD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfEZTTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 15:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbfEZTSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:18:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C3AF21743;
        Sun, 26 May 2019 19:18:48 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUyfP-0004Za-6k; Sun, 26 May 2019 15:18:47 -0400
Message-Id: <20190526191847.098319919@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 26 May 2019 15:18:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 05/16] tracing/probe: Add ustring type for user-space string
References: <20190526191828.466305460@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add "ustring" type for fetching user-space string from kprobe event.
User can specify ustring type at uprobe event, and it is same as
"string" for uprobe.

Note that probe-event provides this option but it doesn't choose the
correct type automatically since we have not way to decide the address
is in user-space or not on some arch (and on some other arch, you can
fetch the string by "string" type). So user must carefully check the
target code (e.g. if you see __user on the target variable) and
use this new type.

Link: http://lkml.kernel.org/r/155789871009.26965.14167558859557329331.stgit@devnote2

Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/kprobetrace.rst |  9 +++++--
 kernel/trace/trace.c                |  2 +-
 kernel/trace/trace_kprobe.c         | 42 ++++++++++++++++++++++++++---
 kernel/trace/trace_probe.c          | 14 +++++++---
 kernel/trace/trace_probe.h          |  1 +
 kernel/trace/trace_probe_tmpl.h     | 14 +++++++++-
 kernel/trace/trace_uprobe.c         | 12 +++++++++
 7 files changed, 84 insertions(+), 10 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 235ce2ab131a..a3ac7c9ac242 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -55,7 +55,8 @@ Synopsis of kprobe_events
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
 		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
-		  (x8/x16/x32/x64), "string" and bitfield are supported.
+		  (x8/x16/x32/x64), "string", "ustring" and bitfield
+		  are supported.
 
   (\*1) only for the probe on function entry (offs == 0).
   (\*2) only for return probe.
@@ -77,7 +78,11 @@ apply it to registers/stack-entries etc. (for example, '$stack1:x8[8]' is
 wrong, but '+8($stack):x8[8]' is OK.)
 String type is a special type, which fetches a "null-terminated" string from
 kernel space. This means it will fail and store NULL if the string container
-has been paged out.
+has been paged out. "ustring" type is an alternative of string for user-space.
+Note that kprobe-event provides string/ustring types, but doesn't change it
+automatically. So user has to decide if the targe string in kernel or in user
+space carefully. On some arch, if you choose wrong one, it always fails to
+record string data.
 The string array type is a bit different from other types. For other base
 types, <base-type>[1] is equal to <base-type> (e.g. +0(%di):x32[1] is same
 as +0(%di):x32.) But string[1] is not equal to string. The string type itself
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1c80521fd436..d3a477a16e70 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4847,7 +4847,7 @@ static const char readme_msg[] =
 	"\t           $stack<index>, $stack, $retval, $comm\n"
 #endif
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
-	"\t           b<bit-width>@<bit-offset>/<container-size>,\n"
+	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
 	"\t           <type>\\[<array-size>\\]\n"
 #ifdef CONFIG_HIST_TRIGGERS
 	"\t    field: <stype> <name>;\n"
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 7d736248a070..439bf04d14ce 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -886,6 +886,15 @@ fetch_store_strlen(unsigned long addr)
 	return (ret < 0) ? ret : len;
 }
 
+/* Return the length of string -- including null terminal byte */
+static nokprobe_inline int
+fetch_store_strlen_user(unsigned long addr)
+{
+	const void __user *uaddr =  (__force const void __user *)addr;
+
+	return strnlen_unsafe_user(uaddr, MAX_STRING_SIZE);
+}
+
 /*
  * Fetch a null-terminated string. Caller MUST set *(u32 *)buf with max
  * length and relative data location.
@@ -894,19 +903,46 @@ static nokprobe_inline int
 fetch_store_string(unsigned long addr, void *dest, void *base)
 {
 	int maxlen = get_loc_len(*(u32 *)dest);
-	u8 *dst = get_loc_data(dest, base);
+	void *__dest;
 	long ret;
 
 	if (unlikely(!maxlen))
 		return -ENOMEM;
+
+	__dest = get_loc_data(dest, base);
+
 	/*
 	 * Try to get string again, since the string can be changed while
 	 * probing.
 	 */
-	ret = strncpy_from_unsafe(dst, (void *)addr, maxlen);
+	ret = strncpy_from_unsafe(__dest, (void *)addr, maxlen);
+	if (ret >= 0)
+		*(u32 *)dest = make_data_loc(ret, __dest - base);
+
+	return ret;
+}
 
+/*
+ * Fetch a null-terminated string from user. Caller MUST set *(u32 *)buf
+ * with max length and relative data location.
+ */
+static nokprobe_inline int
+fetch_store_string_user(unsigned long addr, void *dest, void *base)
+{
+	const void __user *uaddr =  (__force const void __user *)addr;
+	int maxlen = get_loc_len(*(u32 *)dest);
+	void *__dest;
+	long ret;
+
+	if (unlikely(!maxlen))
+		return -ENOMEM;
+
+	__dest = get_loc_data(dest, base);
+
+	ret = strncpy_from_unsafe_user(__dest, uaddr, maxlen);
 	if (ret >= 0)
-		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
+		*(u32 *)dest = make_data_loc(ret, __dest - base);
+
 	return ret;
 }
 
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index a347faced959..5a0470f7b9de 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -78,6 +78,8 @@ static const struct fetch_type probe_fetch_types[] = {
 	/* Special types */
 	__ASSIGN_FETCH_TYPE("string", string, string, sizeof(u32), 1,
 			    "__data_loc char[]"),
+	__ASSIGN_FETCH_TYPE("ustring", string, string, sizeof(u32), 1,
+			    "__data_loc char[]"),
 	/* Basic types */
 	ASSIGN_FETCH_TYPE(u8,  u8,  0),
 	ASSIGN_FETCH_TYPE(u16, u16, 0),
@@ -569,7 +571,8 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 		goto fail;
 
 	/* Store operation */
-	if (!strcmp(parg->type->name, "string")) {
+	if (!strcmp(parg->type->name, "string") ||
+	    !strcmp(parg->type->name, "ustring")) {
 		if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_IMM &&
 		    code->op != FETCH_OP_COMM) {
 			trace_probe_log_err(offset + (t ? (t - arg) : 0),
@@ -590,7 +593,11 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 				goto fail;
 			}
 		}
-		code->op = FETCH_OP_ST_STRING;	/* In DEREF case, replace it */
+		/* If op == DEREF, replace it with STRING */
+		if (!strcmp(parg->type->name, "ustring"))
+			code->op = FETCH_OP_ST_USTRING;
+		else
+			code->op = FETCH_OP_ST_STRING;
 		code->size = parg->type->size;
 		parg->dynamic = true;
 	} else if (code->op == FETCH_OP_DEREF) {
@@ -618,7 +625,8 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 	/* Loop(Array) operation */
 	if (parg->count) {
 		if (scode->op != FETCH_OP_ST_MEM &&
-		    scode->op != FETCH_OP_ST_STRING) {
+		    scode->op != FETCH_OP_ST_STRING &&
+		    scode->op != FETCH_OP_ST_USTRING) {
 			trace_probe_log_err(offset + (t ? (t - arg) : 0),
 					    BAD_STRING);
 			ret = -EINVAL;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index f9a8c632188b..c7546e7ff8e2 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -96,6 +96,7 @@ enum fetch_op {
 	FETCH_OP_ST_RAW,	/* Raw: .size */
 	FETCH_OP_ST_MEM,	/* Mem: .offset, .size */
 	FETCH_OP_ST_STRING,	/* String: .offset, .size */
+	FETCH_OP_ST_USTRING,	/* User String: .offset, .size */
 	// Stage 4 (modify) op
 	FETCH_OP_MOD_BF,	/* Bitfield: .basesize, .lshift, .rshift */
 	// Stage 5 (loop) op
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index c30c61f12ddd..2e9e4dae8839 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -59,6 +59,9 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs,
 static nokprobe_inline int fetch_store_strlen(unsigned long addr);
 static nokprobe_inline int
 fetch_store_string(unsigned long addr, void *dest, void *base);
+static nokprobe_inline int fetch_store_strlen_user(unsigned long addr);
+static nokprobe_inline int
+fetch_store_string_user(unsigned long addr, void *dest, void *base);
 static nokprobe_inline int
 probe_mem_read(void *dest, void *src, size_t size);
 
@@ -91,6 +94,10 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 			ret = fetch_store_strlen(val + code->offset);
 			code++;
 			goto array;
+		} else if (code->op == FETCH_OP_ST_USTRING) {
+			ret += fetch_store_strlen_user(val + code->offset);
+			code++;
+			goto array;
 		} else
 			return -EILSEQ;
 	}
@@ -106,6 +113,10 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 		loc = *(u32 *)dest;
 		ret = fetch_store_string(val + code->offset, dest, base);
 		break;
+	case FETCH_OP_ST_USTRING:
+		loc = *(u32 *)dest;
+		ret = fetch_store_string_user(val + code->offset, dest, base);
+		break;
 	default:
 		return -EILSEQ;
 	}
@@ -123,7 +134,8 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 		total += ret;
 		if (++i < code->param) {
 			code = s3;
-			if (s3->op != FETCH_OP_ST_STRING) {
+			if (s3->op != FETCH_OP_ST_STRING &&
+			    s3->op != FETCH_OP_ST_USTRING) {
 				dest += s3->size;
 				val += s3->size;
 				goto stage3;
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index eb7e06b54741..852e998051f6 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -176,6 +176,12 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 	return ret;
 }
 
+static nokprobe_inline int
+fetch_store_string_user(unsigned long addr, void *dest, void *base)
+{
+	return fetch_store_string(addr, dest, base);
+}
+
 /* Return the length of string -- including null terminal byte */
 static nokprobe_inline int
 fetch_store_strlen(unsigned long addr)
@@ -191,6 +197,12 @@ fetch_store_strlen(unsigned long addr)
 	return (len > MAX_STRING_SIZE) ? 0 : len;
 }
 
+static nokprobe_inline int
+fetch_store_strlen_user(unsigned long addr)
+{
+	return fetch_store_strlen(addr);
+}
+
 static unsigned long translate_user_vaddr(unsigned long file_offset)
 {
 	unsigned long base_addr;
-- 
2.20.1


