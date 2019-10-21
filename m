Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F396CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1422084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbfJVAEZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:04:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387508AbfJVAEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:04:23 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgxK-00049G-ES; Tue, 22 Oct 2019 01:19:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 894361C04D7;
        Tue, 22 Oct 2019 01:19:11 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:19:11 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Filter own pid to avoid a feedback look
 in 'perf trace record -a'
Cc:     Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-uysx5w8f2y5ndoln5cq370tv@git.kernel.org>
References: <tip-uysx5w8f2y5ndoln5cq370tv@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157169995114.29376.6162722012242994606.tip-bot2@tip-bot2>
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

Commit-ID:     7fbfe22cf4cfe01a88704dd76ca65d108039d297
Gitweb:        https://git.kernel.org/tip/7fbfe22cf4cfe01a88704dd76ca65d108039d297
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 14 Oct 2019 20:13:51 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 13:03:57 -03:00

perf trace: Filter own pid to avoid a feedback look in 'perf trace record -a'

When doing a system wide 'perf trace record' we need, just like in 'perf
trace' live mode, to filter out perf trace's own pid, so set up a
tracepoint filter for the raw_syscalls tracepoints right after adding
them to the argv array that is set up to then call cmd_record().

Reported-by: Andi Kleen <ak@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-uysx5w8f2y5ndoln5cq370tv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 467e18e..cdee22d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2796,21 +2796,23 @@ static int trace__record(struct trace *trace, int argc, const char **argv)
 		"-m", "1024",
 		"-c", "1",
 	};
-
+	pid_t pid = getpid();
+	char *filter = asprintf__tp_filter_pids(1, &pid);
 	const char * const sc_args[] = { "-e", };
 	unsigned int sc_args_nr = ARRAY_SIZE(sc_args);
 	const char * const majpf_args[] = { "-e", "major-faults" };
 	unsigned int majpf_args_nr = ARRAY_SIZE(majpf_args);
 	const char * const minpf_args[] = { "-e", "minor-faults" };
 	unsigned int minpf_args_nr = ARRAY_SIZE(minpf_args);
+	int err = -1;
 
-	/* +1 is for the event string below */
-	rec_argc = ARRAY_SIZE(record_args) + sc_args_nr + 1 +
+	/* +3 is for the event string below and the pid filter */
+	rec_argc = ARRAY_SIZE(record_args) + sc_args_nr + 3 +
 		majpf_args_nr + minpf_args_nr + argc;
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
 
-	if (rec_argv == NULL)
-		return -ENOMEM;
+	if (rec_argv == NULL || filter == NULL)
+		goto out_free;
 
 	j = 0;
 	for (i = 0; i < ARRAY_SIZE(record_args); i++)
@@ -2827,11 +2829,13 @@ static int trace__record(struct trace *trace, int argc, const char **argv)
 			rec_argv[j++] = "syscalls:sys_enter,syscalls:sys_exit";
 		else {
 			pr_err("Neither raw_syscalls nor syscalls events exist.\n");
-			free(rec_argv);
-			return -1;
+			goto out_free;
 		}
 	}
 
+	rec_argv[j++] = "--filter";
+	rec_argv[j++] = filter;
+
 	if (trace->trace_pgfaults & TRACE_PFMAJ)
 		for (i = 0; i < majpf_args_nr; i++)
 			rec_argv[j++] = majpf_args[i];
@@ -2843,7 +2847,11 @@ static int trace__record(struct trace *trace, int argc, const char **argv)
 	for (i = 0; i < (unsigned int)argc; i++)
 		rec_argv[j++] = argv[i];
 
-	return cmd_record(j, rec_argv);
+	err = cmd_record(j, rec_argv);
+out_free:
+	free(filter);
+	free(rec_argv);
+	return err;
 }
 
 static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp);
