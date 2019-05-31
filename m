Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31578C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BC326B96
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559315976;
	bh=URfSMtDYi+N/C9oylQ4TkXoqD24ZlG4i98jqimuvqKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k+XE3/q7XFJg8n78Nn8WU0ujUjp7EeUwyr8MModWMuB1sGrFfr3nK9OqM9dhEheHh
	 pmZJ3FxbM63u96YtPlKTyaIVq7CkCJu47D2XS/7fJ+BlIn+oaHALeu5YCAR7CzNaOJ
	 b9b3UUpQc5xo0oVa1xfyM5BmEZ4wj85QkQTH3H1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfEaPTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:19:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfEaPTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:19:33 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADAD726B93;
        Fri, 31 May 2019 15:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559315972;
        bh=URfSMtDYi+N/C9oylQ4TkXoqD24ZlG4i98jqimuvqKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JA0wYwjWpWBbt2zWiNYrl1DQECM+PbU+YZYDjC79gFh+xAh81bcxmcCYHQ+mzcrlo
         qF4AjbLljJFiDDajnCj2ZeDE92wkEap/eNg3xFJDHA1bzvyuWgNXjrU4FDYOvSktKH
         A7qlLPV9pF3UE6JAm48QhZOPHY5zVLqvSyiGnRps=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/21] tracing/probe: Add immediate parameter support
Date:   Sat,  1 Jun 2019 00:19:27 +0900
Message-Id: <155931596691.28323.8021073968189476540.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <155931578555.28323.16360245959211149678.stgit@devnote2>
References: <155931578555.28323.16360245959211149678.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/trace/kprobetrace.rst  |    1 +
 Documentation/trace/uprobetracer.rst |    1 +
 kernel/trace/trace.c                 |    2 +-
 kernel/trace/trace_probe.c           |   18 ++++++++++++++++++
 kernel/trace/trace_probe.h           |    1 +
 5 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index af776989caca..772467f65a36 100644
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
index ab13319c66ac..2b4697c0bed7 100644
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
index 73fbe3b0dd08..3608535f1935 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4846,7 +4846,7 @@ static const char readme_msg[] =
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

