Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E95C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB28621655
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557322355;
	bh=bIDDdgM+V+5voRxNyAAAx5cUXWPLqvhDMcDZdQQX7Vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sPsmB1gNk85MGx1PWKTSi/Bz/lB/qx7wyM9zKZ+G4E51yxjNMz2p4kOjDyHyLyPEW
	 plQUMufgxj39b0lyxVH75anmIBPTgHX/5ITUzUjyucsxvttzSYtGcSQYC/sdmf4OPe
	 ZtyuHyD7XaOG/W2YVJIfNSD2GSTviT9H05ZgaL6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfEHNce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEHNcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:32:33 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BE65205ED;
        Wed,  8 May 2019 13:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557322352;
        bh=bIDDdgM+V+5voRxNyAAAx5cUXWPLqvhDMcDZdQQX7Vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFoIf1y/QVzWdi0iVb4nS/VRFQEyR0cAUwt8N0iXShZeh3POPU9zA/YpbshygdH3n
         oDNCCn4vRL2Ae9CdMSrXLu7TfTef4UIgIbG91NGY37ICFgtG6aI3HFHi87wDT6y2sE
         T+5+kjaAw0SO6F85mBeOm/iu8d2eH36REaJDElHc=
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
Subject: [PATCH v7 3/6] tracing/probe: Add ustring type for user-space string
Date:   Wed,  8 May 2019 22:32:25 +0900
Message-Id: <155732234578.12756.9934987812691940806.stgit@devnote2>
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

Add "ustring" type for fetching user-space string from kprobe event.
User can specify ustring type at uprobe event, and it is same as
"string" for uprobe.

Note that probe-event provides this option but it doesn't choose the
correct type automatically since we have not way to decide the address
is in user-space or not on some arch (and on some other arch, you can
fetch the string by "string" type). So user must carefully check the
target code (e.g. if you see __user on the target variable) and
use this new type.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

---
 Changes in v5:
 - Use strnlen_unsafe_user() in fetch_store_strlen_user().
 Changes in v2:
 - Use strnlen_user() instead of open code for fetch_store_strlen_user().
---
 Documentation/trace/kprobetrace.rst |    9 +++++++--
 kernel/trace/trace.c                |    2 +-
 kernel/trace/trace_kprobe.c         |   29 +++++++++++++++++++++++++++++
 kernel/trace/trace_probe.c          |   14 +++++++++++---
 kernel/trace/trace_probe.h          |    1 +
 kernel/trace/trace_probe_tmpl.h     |   14 +++++++++++++-
 kernel/trace/trace_uprobe.c         |   12 ++++++++++++
 7 files changed, 74 insertions(+), 7 deletions(-)

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
index dcb9adb44be9..101a5d09a632 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4858,7 +4858,7 @@ static const char readme_msg[] =
 	"\t           $stack<index>, $stack, $retval, $comm\n"
 #endif
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
-	"\t           b<bit-width>@<bit-offset>/<container-size>,\n"
+	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
 	"\t           <type>\\[<array-size>\\]\n"
 #ifdef CONFIG_HIST_TRIGGERS
 	"\t    field: <stype> <name>;\n"
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 7d736248a070..fcb8806fc93c 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -886,6 +886,14 @@ fetch_store_strlen(unsigned long addr)
 	return (ret < 0) ? ret : len;
 }
 
+/* Return the length of string -- including null terminal byte */
+static nokprobe_inline int
+fetch_store_strlen_user(unsigned long addr)
+{
+	return strnlen_unsafe_user((__force const void __user *)addr,
+				   MAX_STRING_SIZE);
+}
+
 /*
  * Fetch a null-terminated string. Caller MUST set *(u32 *)buf with max
  * length and relative data location.
@@ -910,6 +918,27 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 	return ret;
 }
 
+/*
+ * Fetch a null-terminated string from user. Caller MUST set *(u32 *)buf
+ * with max length and relative data location.
+ */
+static nokprobe_inline int
+fetch_store_string_user(unsigned long addr, void *dest, void *base)
+{
+	int maxlen = get_loc_len(*(u32 *)dest);
+	u8 *dst = get_loc_data(dest, base);
+	long ret;
+
+	if (unlikely(!maxlen))
+		return -ENOMEM;
+	ret = strncpy_from_unsafe_user(dst, (__force const void __user *)addr,
+				       maxlen);
+
+	if (ret >= 0)
+		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
+	return ret;
+}
+
 static nokprobe_inline int
 probe_mem_read(void *dest, void *src, size_t size)
 {
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e0d1d5353464..7df9f53a372d 100644
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

