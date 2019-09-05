Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AB9C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA781206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390626AbfIEPnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390522AbfIEPnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:43:43 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DBA6214DB;
        Thu,  5 Sep 2019 15:43:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i5tvB-0007Xz-KC; Thu, 05 Sep 2019 11:43:41 -0400
Message-Id: <20190905154341.514883565@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Sep 2019 11:43:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 12/25] tracing/probe: Add immediate parameter support
References: <20190905154258.573706229@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add immediate value parameter (\1234) support to
probe events. This allows you to specify an immediate
(or dummy) parameter instead of fetching from memory
or register.

This feature looks odd, but imagine when you put a probe
on a code to trace some data. If the code is compiled into
2 instructions and 1 instruction has a value but other has
nothing since it is optimized out.
In that case, you can not fold those into one event, even
if ftrace supported multiple probes on one event.
With this feature, you can set a dummy value like
foo=\deadbeef instead of something like foo=%di.

Link: http://lkml.kernel.org/r/156095690733.28024.13258186548822649469.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/kprobetrace.rst  |  1 +
 Documentation/trace/uprobetracer.rst |  1 +
 kernel/trace/trace.c                 |  2 +-
 kernel/trace/trace_probe.c           | 18 ++++++++++++++++++
 kernel/trace/trace_probe.h           |  1 +
 5 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index fbb314bfa112..55993055902c 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -52,6 +52,7 @@ Synopsis of kprobe_events
   $retval	: Fetch return value.(\*2)
   $comm		: Fetch current task comm.
   +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*3)(\*4)
+  \IMM		: Store an immediate value to the argument.
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
 		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
diff --git a/Documentation/trace/uprobetracer.rst b/Documentation/trace/uprobetracer.rst
index 6e75a6c5a2c8..98cde99939d7 100644
--- a/Documentation/trace/uprobetracer.rst
+++ b/Documentation/trace/uprobetracer.rst
@@ -45,6 +45,7 @@ Synopsis of uprobe_tracer
    $retval	: Fetch return value.(\*1)
    $comm	: Fetch current task comm.
    +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*2)(\*3)
+   \IMM		: Store an immediate value to the argument.
    NAME=FETCHARG     : Set NAME as the argument name of FETCHARG.
    FETCHARG:TYPE     : Set TYPE as the type of FETCHARG. Currently, basic types
 		       (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c7797a81a37e..fb4003c10151 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4848,7 +4848,7 @@ static const char readme_msg[] =
 #else
 	"\t           $stack<index>, $stack, $retval, $comm,\n"
 #endif
-	"\t           +|-[u]<offset>(<fetcharg>)\n"
+	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value\n"
 	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
 	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
 	"\t           <type>\\[<array-size>\\]\n"
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index f8c3c65c035d..fb90baec3cd8 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -316,6 +316,17 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 	return -EINVAL;
 }
 
+static int str_to_immediate(char *str, unsigned long *imm)
+{
+	if (isdigit(str[0]))
+		return kstrtoul(str, 0, imm);
+	else if (str[0] == '-')
+		return kstrtol(str, 0, (long *)imm);
+	else if (str[0] == '+')
+		return kstrtol(str + 1, 0, (long *)imm);
+	return -EINVAL;
+}
+
 /* Recursive argument parser */
 static int
 parse_probe_arg(char *arg, const struct fetch_type *type,
@@ -444,6 +455,13 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 			code->offset = offset;
 		}
 		break;
+	case '\\':	/* Immediate value */
+		ret = str_to_immediate(arg + 1, &code->immediate);
+		if (ret)
+			trace_probe_log_err(offs + 1, BAD_IMM);
+		else
+			code->op = FETCH_OP_IMM;
+		break;
 	}
 	if (!ret && code->op == FETCH_OP_NOP) {
 		/* Parsed, but do not find fetch method */
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 2dcc4e317787..cc113b82a4ce 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -408,6 +408,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_VAR,		"Invalid $-valiable specified"),	\
 	C(BAD_REG_NAME,		"Invalid register name"),		\
 	C(BAD_MEM_ADDR,		"Invalid memory address"),		\
+	C(BAD_IMM,		"Invalid immediate value"),		\
 	C(FILE_ON_KPROBE,	"File offset is not available with kprobe"), \
 	C(BAD_FILE_OFFS,	"Invalid file offset value"),		\
 	C(SYM_ON_UPROBE,	"Symbol is not available with uprobe"),	\
-- 
2.20.1


