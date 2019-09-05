Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700E9C00306
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB802082C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390615AbfIEPnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:43:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390524AbfIEPnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:43:43 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DC4521929;
        Thu,  5 Sep 2019 15:43:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i5tvB-0007YT-Pw; Thu, 05 Sep 2019 11:43:41 -0400
Message-Id: <20190905154341.690280933@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 11:43:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 13/25] tracing/probe: Add immediate string parameter support
References: <20190905154258.573706229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add immediate string parameter (\"string") support to
probe events. This allows you to specify an immediate
(or dummy) parameter instead of fetching a string from
memory.

This feature looks odd, but imagine that you put a probe
on a code to trace some string data. If the code is
compiled into 2 instructions and 1 instruction has a
string on memory but other has no string since it is
optimized out. In that case, you can not fold those into
one event, even if ftrace supported multiple probes on
one event. With this feature, you can set a dummy string
like foo=\"(optimized)":string instead of something
like foo=+0(+0(%bp)):string.

Link: http://lkml.kernel.org/r/156095691687.28024.13372712423865047991.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c        |  2 +-
 kernel/trace/trace_kprobe.c |  3 ++
 kernel/trace/trace_probe.c  | 56 +++++++++++++++++++++++++++----------
 kernel/trace/trace_probe.h  |  2 ++
 kernel/trace/trace_uprobe.c |  3 ++
 5 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index fb4003c10151..3916b72de715 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4848,7 +4848,7 @@ static const char readme_msg[] =
 #else
 	"\t           $stack<index>, $stack, $retval, $comm,\n"
 #endif
-	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value\n"
+	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
 	"\t           <type>\\[<array-size>\\]\n"
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 18c4175b6585..7579c53bb053 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1083,6 +1083,9 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 	case FETCH_OP_COMM:
 		val = (unsigned long)current->comm;
 		break;
+	case FETCH_OP_DATA:
+		val = (unsigned long)code->data;
+		break;
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 	case FETCH_OP_ARG:
 		val = regs_get_kernel_argument(regs, code->param);
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index fb90baec3cd8..1e67fef06e53 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -327,6 +327,18 @@ static int str_to_immediate(char *str, unsigned long *imm)
 	return -EINVAL;
 }
 
+static int __parse_imm_string(char *str, char **pbuf, int offs)
+{
+	size_t len = strlen(str);
+
+	if (str[len - 1] != '"') {
+		trace_probe_log_err(offs + len, IMMSTR_NO_CLOSE);
+		return -EINVAL;
+	}
+	*pbuf = kstrndup(str, len - 1, GFP_KERNEL);
+	return 0;
+}
+
 /* Recursive argument parser */
 static int
 parse_probe_arg(char *arg, const struct fetch_type *type,
@@ -441,7 +453,8 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 			ret = parse_probe_arg(arg, t2, &code, end, flags, offs);
 			if (ret)
 				break;
-			if (code->op == FETCH_OP_COMM) {
+			if (code->op == FETCH_OP_COMM ||
+			    code->op == FETCH_OP_DATA) {
 				trace_probe_log_err(offs, COMM_CANT_DEREF);
 				return -EINVAL;
 			}
@@ -456,11 +469,19 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 		}
 		break;
 	case '\\':	/* Immediate value */
-		ret = str_to_immediate(arg + 1, &code->immediate);
-		if (ret)
-			trace_probe_log_err(offs + 1, BAD_IMM);
-		else
-			code->op = FETCH_OP_IMM;
+		if (arg[1] == '"') {	/* Immediate string */
+			ret = __parse_imm_string(arg + 2, &tmp, offs + 2);
+			if (ret)
+				break;
+			code->op = FETCH_OP_DATA;
+			code->data = tmp;
+		} else {
+			ret = str_to_immediate(arg + 1, &code->immediate);
+			if (ret)
+				trace_probe_log_err(offs + 1, BAD_IMM);
+			else
+				code->op = FETCH_OP_IMM;
+		}
 		break;
 	}
 	if (!ret && code->op == FETCH_OP_NOP) {
@@ -560,8 +581,11 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 		}
 	}
 
-	/* Since $comm can not be dereferred, we can find $comm by strcmp */
-	if (strcmp(arg, "$comm") == 0) {
+	/*
+	 * Since $comm and immediate string can not be dereferred,
+	 * we can find those by strcmp.
+	 */
+	if (strcmp(arg, "$comm") == 0 || strncmp(arg, "\\\"", 2) == 0) {
 		/* The type of $comm must be "string", and not an array. */
 		if (parg->count || (t && strcmp(t, "string")))
 			return -EINVAL;
@@ -598,7 +622,8 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 	if (!strcmp(parg->type->name, "string") ||
 	    !strcmp(parg->type->name, "ustring")) {
 		if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_UDEREF &&
-		    code->op != FETCH_OP_IMM && code->op != FETCH_OP_COMM) {
+		    code->op != FETCH_OP_IMM && code->op != FETCH_OP_COMM &&
+		    code->op != FETCH_OP_DATA) {
 			trace_probe_log_err(offset + (t ? (t - arg) : 0),
 					    BAD_STRING);
 			ret = -EINVAL;
@@ -607,9 +632,10 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 		if ((code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM) ||
 		     parg->count) {
 			/*
-			 * IMM and COMM is pointing actual address, those must
-			 * be kept, and if parg->count != 0, this is an array
-			 * of string pointers instead of string address itself.
+			 * IMM, DATA and COMM is pointing actual address, those
+			 * must be kept, and if parg->count != 0, this is an
+			 * array of string pointers instead of string address
+			 * itself.
 			 */
 			code++;
 			if (code->op != FETCH_OP_NOP) {
@@ -683,7 +709,8 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 fail:
 	if (ret) {
 		for (code = tmp; code < tmp + FETCH_INSN_MAX; code++)
-			if (code->op == FETCH_NOP_SYMBOL)
+			if (code->op == FETCH_NOP_SYMBOL ||
+			    code->op == FETCH_OP_DATA)
 				kfree(code->data);
 	}
 	kfree(tmp);
@@ -754,7 +781,8 @@ void traceprobe_free_probe_arg(struct probe_arg *arg)
 	struct fetch_insn *code = arg->code;
 
 	while (code && code->op != FETCH_OP_END) {
-		if (code->op == FETCH_NOP_SYMBOL)
+		if (code->op == FETCH_NOP_SYMBOL ||
+		    code->op == FETCH_OP_DATA)
 			kfree(code->data);
 		code++;
 	}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index cc113b82a4ce..f805cc4cbe7c 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -89,6 +89,7 @@ enum fetch_op {
 	FETCH_OP_COMM,		/* Current comm */
 	FETCH_OP_ARG,		/* Function argument : .param */
 	FETCH_OP_FOFFS,		/* File offset: .immediate */
+	FETCH_OP_DATA,		/* Allocated data: .data */
 	// Stage 2 (dereference) op
 	FETCH_OP_DEREF,		/* Dereference: .offset */
 	FETCH_OP_UDEREF,	/* User-space Dereference: .offset */
@@ -409,6 +410,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_REG_NAME,		"Invalid register name"),		\
 	C(BAD_MEM_ADDR,		"Invalid memory address"),		\
 	C(BAD_IMM,		"Invalid immediate value"),		\
+	C(IMMSTR_NO_CLOSE,	"String is not closed with '\"'"),	\
 	C(FILE_ON_KPROBE,	"File offset is not available with kprobe"), \
 	C(BAD_FILE_OFFS,	"Invalid file offset value"),		\
 	C(SYM_ON_UPROBE,	"Symbol is not available with uprobe"),	\
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 84925b5b6db5..cbf4da4bf367 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -248,6 +248,9 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
 	case FETCH_OP_COMM:
 		val = FETCH_TOKEN_COMM;
 		break;
+	case FETCH_OP_DATA:
+		val = (unsigned long)code->data;
+		break;
 	case FETCH_OP_FOFFS:
 		val = translate_user_vaddr(code->immediate);
 		break;
-- 
2.20.1


