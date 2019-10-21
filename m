Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C68CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523FC20882
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbfJVAEf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:04:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730711AbfJVAEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:04:32 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgxG-00048j-LQ; Tue, 22 Oct 2019 01:19:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E1C021C047B;
        Tue, 22 Oct 2019 01:19:10 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:19:10 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Support tracepoint dynamic char arrays
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-950p0m842fe6n7sxsdwqj5i2@git.kernel.org>
References: <tip-950p0m842fe6n7sxsdwqj5i2@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157169995045.29376.16397510322929162849.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c5e006cdbd278a8a5185a3a56acdba161cf159ea
Gitweb:        https://git.kernel.org/tip/c5e006cdbd278a8a5185a3a56acdba161cf159ea
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 15 Oct 2019 08:26:47 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 13:03:58 -03:00

perf trace: Support tracepoint dynamic char arrays

Things like:

  # grep __data_loc /sys/kernel/debug/tracing/events/sched/sched_process_exec/format
	field:__data_loc char[] filename;	offset:8;	size:4;	signed:1;
  #

That, at that offset (8) and with that size(8) have an integer that
contains the real length and offset for the contents of that array.

Now this works:

  # perf trace --max-events 1 -e sched:*exec -a
     0.000 sed/19441 sched:sched_process_exec(filename: "/usr/bin/sync", pid: 19441 (sync), old_pid: 19441 (sync))
  #

As when using the libtraceevent based beautifier:

  # perf trace --libtraceevent --max-events 1 -e sched:*exec -a
     0.000 sync/19463 sched:sched_process_exec(filename=/usr/bin/sync pid=19463 old_pid=19463)
  #

I.e. that 'filename' is implemented as a dynamic char array.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-950p0m842fe6n7sxsdwqj5i2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 19 ++++++++++++++-----
 tools/perf/trace/beauty/beauty.h |  2 ++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index cdee22d..907eaf3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -563,7 +563,7 @@ static size_t syscall_arg__scnprintf_char_array(char *bf, size_t size, struct sy
 	// XXX Hey, maybe for sched:sched_switch prev/next comm fields we can
 	//     fill missing comms using thread__set_comm()...
 	//     here or in a special syscall_arg__scnprintf_pid_sched_tp...
-	return scnprintf(bf, size, "\"%-.*s\"", arg->fmt->nr_entries, arg->val);
+	return scnprintf(bf, size, "\"%-.*s\"", arg->fmt->nr_entries ?: arg->len, arg->val);
 }
 
 #define SCA_CHAR_ARRAY syscall_arg__scnprintf_char_array
@@ -1559,7 +1559,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			arg->scnprintf = SCA_PID;
 		else if (strcmp(field->type, "umode_t") == 0)
 			arg->scnprintf = SCA_MODE_T;
-		else if ((field->flags & TEP_FIELD_IS_ARRAY) && strstarts(field->type, "char")) {
+		else if ((field->flags & TEP_FIELD_IS_ARRAY) && strstr(field->type, "char")) {
 			arg->scnprintf = SCA_CHAR_ARRAY;
 			arg->nr_entries = field->arraylen;
 		} else if ((strcmp(field->type, "int") == 0 ||
@@ -2523,10 +2523,19 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		if (syscall_arg.mask & bit)
 			continue;
 
+		syscall_arg.len = 0;
 		syscall_arg.fmt = arg;
-		if (field->flags & TEP_FIELD_IS_ARRAY)
-			val = (uintptr_t)(sample->raw_data + field->offset);
-		else
+		if (field->flags & TEP_FIELD_IS_ARRAY) {
+			int offset = field->offset;
+
+			if (field->flags & TEP_FIELD_IS_DYNAMIC) {
+				offset = format_field__intval(field, sample, evsel->needs_swap);
+				syscall_arg.len = offset >> 16;
+				offset &= 0xffff;
+			}
+
+			val = (uintptr_t)(sample->raw_data + offset);
+		} else
 			val = format_field__intval(field, sample, evsel->needs_swap);
 		/*
 		 * Some syscall args need some mask, most don't and
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 77ad80a..0dee0cf 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -87,6 +87,7 @@ struct syscall_arg_fmt;
 
 /**
  * @val: value of syscall argument being formatted
+ * @len: for tracepoint dynamic arrays, if fmt->nr_entries == 0, then its not a fixed array, look at arg->len
  * @args: All the args, use syscall_args__val(arg, nth) to access one
  * @augmented_args: Extra data that can be collected, for instance, with eBPF for expanding the pathname for open, etc
  * @augmented_args_size: augmented_args total payload size
@@ -109,6 +110,7 @@ struct syscall_arg {
 	struct thread *thread;
 	struct trace  *trace;
 	void	      *parm;
+	u16	      len;
 	u8	      idx;
 	u8	      mask;
 	bool	      show_string_prefix;
