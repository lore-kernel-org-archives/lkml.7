Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223EEC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14CC2189E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560956924;
	bh=E/0r/KaFhrZTkGfJ6EYsNFGxqT3zPbWUUN2Sr95DOOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qXKqaUTxxAmAf6dXE02Nq+EZRCq30mMBOoQcJMQr+zW9DPqOKH0UEs2rebDKzLxv1
	 7MAAPny0Eu8tVB8Uvd4yVe6bQALg2PBCBNora4O3lJEBEy97Zzn2UNQo/UpZrqxy87
	 g/1+ircF7FWKeRtHJc+Wyd5zRlBSwhtwI0kinuK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbfFSPIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfFSPIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:08:42 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3723F21883;
        Wed, 19 Jun 2019 15:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560956921;
        bh=E/0r/KaFhrZTkGfJ6EYsNFGxqT3zPbWUUN2Sr95DOOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AupWaP5uZU9KEWUWhJROdnQj8Z0WJLC73AsYdwMlGBR+kIN5K2nao6pVXN7S+mcXh
         5g7g4NjDmJ1Gk5HCIRuAyL06+abqkdin8lGeGFN9zDfLFDyXdR9LPgLLUeB+kEIxAq
         b9pClLOqsoDeMyTcvXg6/t6j/TTzp5MNMsUBu6do=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v2 09/12] tracing/probe: Add immediate string parameter support
Date:   Thu, 20 Jun 2019 00:08:37 +0900
Message-Id: <156095691687.28024.13372712423865047991.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156095682948.28024.14190188071338900568.stgit@devnote2>
References: <156095682948.28024.14190188071338900568.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace.c        |    2 +-
 kernel/trace/trace_kprobe.c |    3 ++
 kernel/trace/trace_probe.c  |   56 ++++++++++++++++++++++++++++++++-----------
 kernel/trace/trace_probe.h  |    2 ++
 kernel/trace/trace_uprobe.c |    3 ++
 5 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3608535f1935..ff9c9e627a87 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4846,7 +4846,7 @@ static const char readme_msg[] =
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
index 878219552177..89ab3972fc77 100644
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

