Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D724CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC382245C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbfJVAFM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:05:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387566AbfJVAFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:05:10 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgx3-00040Y-V8; Tue, 22 Oct 2019 01:19:02 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 49DC91C04D3;
        Tue, 22 Oct 2019 01:19:01 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:19:00 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Initialize evsel_trace->fmt for
 syscalls:sys_enter_* tracepoints
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-lc8h9jgvbnboe0g7ic8tra1y@git.kernel.org>
References: <tip-lc8h9jgvbnboe0g7ic8tra1y@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157169994085.29376.2672649081556176042.tip-bot2@tip-bot2>
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

Commit-ID:     362222f877f1369c0a8017c58b075abf30b16ab7
Gitweb:        https://git.kernel.org/tip/362222f877f1369c0a8017c58b075abf30b16ab7
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 17 Oct 2019 17:33:08 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 18 Oct 2019 12:07:42 -03:00

perf trace: Initialize evsel_trace->fmt for syscalls:sys_enter_* tracepoints

>From the syscall_fmts->arg entries for formatting strace-like syscalls.

This is when resolving the string "whence" on a filter expression for
the syscalls:sys_enter_lseek:

  Breakpoint 3, perf_evsel__syscall_arg_fmt (evsel=0xc91ed0, arg=0x7fffffff7cd0 "whence") at builtin-trace.c:3626
  3626	{
  (gdb) n
  3628		struct syscall_arg_fmt *fmt = __evsel__syscall_arg_fmt(evsel);
  (gdb) n
  3630		if (evsel->tp_format == NULL || fmt == NULL)
  (gdb) n
  3633		for (field = evsel->tp_format->format.fields; field; field = field->next, ++fmt)
  (gdb) n
  3634			if (strcmp(field->name, arg) == 0)
  (gdb) p field->name
  $3 = 0xc945e0 "__syscall_nr"
  (gdb) n
  3633		for (field = evsel->tp_format->format.fields; field; field = field->next, ++fmt)
  (gdb) p *fmt
  $4 = {scnprintf = 0x0, strtoul = 0x0, mask_val = 0x0, parm = 0x0, name = 0x0, nr_entries = 0, show_zero = false}
  (gdb) n
  3634			if (strcmp(field->name, arg) == 0)
  (gdb) p field->name
  $5 = 0xc94690 "fd"
  (gdb) n
  3633		for (field = evsel->tp_format->format.fields; field; field = field->next, ++fmt)
  (gdb) n
  3634			if (strcmp(field->name, arg) == 0)
  (gdb) n
  3633		for (field = evsel->tp_format->format.fields; field; field = field->next, ++fmt)
  (gdb) n
  3634			if (strcmp(field->name, arg) == 0)
  (gdb) p *fmt
  $9 = {scnprintf = 0x489be2 <syscall_arg__scnprintf_strarray>, strtoul = 0x0, mask_val = 0x0, parm = 0xa2da80 <strarray.whences>, name = 0x0,
    nr_entries = 0, show_zero = false}
  (gdb) p field->name
  $10 = 0xc947b0 "whence"
  (gdb) p fmt->parm
  $11 = (void *) 0xa2da80 <strarray.whences>
  (gdb) p *(struct strarray *)fmt->parm
  $12 = {offset = 0, nr_entries = 5, prefix = 0x724d37 "SEEK_", entries = 0xa2da40 <whences>}
  (gdb) p (struct strarray *)fmt->parm)->entries
  Junk after end of expression.
  (gdb) p ((struct strarray *)fmt->parm)->entries
  $13 = (const char **) 0xa2da40 <whences>
  (gdb) p ((struct strarray *)fmt->parm)->entries[0]
  $14 = 0x724d21 "SET"
  (gdb) p ((struct strarray *)fmt->parm)->entries[1]
  $15 = 0x724d25 "CUR"
  (gdb) p ((struct strarray *)fmt->parm)->entries[2]
  $16 = 0x724d29 "END"
  (gdb) p ((struct strarray *)fmt->parm)->entries[2]
  $17 = 0x724d29 "END"
  (gdb) p ((struct strarray *)fmt->parm)->entries[3]
  $18 = 0x724d2d "DATA"
  (gdb) p ((struct strarray *)fmt->parm)->entries[4]
  $19 = 0x724d32 "HOLE"
  (gdb)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lc8h9jgvbnboe0g7ic8tra1y@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5792278..3502417 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4366,6 +4366,25 @@ static void evlist__set_default_evsel_handler(struct evlist *evlist, void *handl
 	}
 }
 
+static void evsel__set_syscall_arg_fmt(struct evsel *evsel, const char *name)
+{
+	struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
+
+	if (fmt) {
+		struct syscall_fmt *scfmt = syscall_fmt__find(name);
+
+		if (scfmt) {
+			int skip = 0;
+
+			if (strcmp(evsel->tp_format->format.fields->name, "__syscall_nr") == 0 ||
+			    strcmp(evsel->tp_format->format.fields->name, "nr") == 0)
+				++skip;
+
+			memcpy(fmt + skip, scfmt->arg, (evsel->tp_format->format.nr_fields - skip) * sizeof(*fmt));
+		}
+	}
+}
+
 static int evlist__set_syscall_tp_fields(struct evlist *evlist)
 {
 	struct evsel *evsel;
@@ -4387,11 +4406,15 @@ static int evlist__set_syscall_tp_fields(struct evlist *evlist)
 
 			if (__tp_field__init_ptr(&sc->args, sc->id.offset + sizeof(u64)))
 				return -1;
+
+			evsel__set_syscall_arg_fmt(evsel, evsel->tp_format->name + sizeof("sys_enter_") - 1);
 		} else if (!strncmp(evsel->tp_format->name, "sys_exit_", 9)) {
 			struct syscall_tp *sc = __evsel__syscall_tp(evsel);
 
 			if (__tp_field__init_uint(&sc->ret, sizeof(u64), sc->id.offset + sizeof(u64), evsel->needs_swap))
 				return -1;
+
+			evsel__set_syscall_arg_fmt(evsel, evsel->tp_format->name + sizeof("sys_exit_") - 1);
 		}
 	}
 
