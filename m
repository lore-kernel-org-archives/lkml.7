Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F55CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A848C214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665181;
	bh=kDlqqhxo9pbZ856JNlvJVFd+gSQwLxs5OvLPz21HNmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bc+S1Fc5bmQEcQI5ZZz6nA7zsXX6DBu4D0IGYfbxOppU409r2a4jeneNUlLTe2biR
	 Uwx3zPSSVqvS+tCo1sTRQeiCjelCAXOYBPACN0kACef1dbytT5bvUZhBFdv3IaQWww
	 D5vQ+q+OR2Zb8OMN7XmwG/TUY4p9POJ1DT2xl2II=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfJUNjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:39:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729295AbfJUNjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:39:39 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AF6C21BE5;
        Mon, 21 Oct 2019 13:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665177;
        bh=kDlqqhxo9pbZ856JNlvJVFd+gSQwLxs5OvLPz21HNmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y+ogXMlwU6Y904B8BZEvsd8n/74VmOdBWmwjbV8Ipi+SNFpOfGET6+ZrJ65U974HG
         LSpvZudw/JKRCLNq0tZAFO5/VwD+xzDDcFJmuEUhopubsHavNUTGE3XmnwJf3kZgvc
         K1JtAe1XUPneNIXhhZtkX69XV492piglvLhLADS8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 17/57] perf trace: Filter own pid to avoid a feedback look in 'perf trace record -a'
Date:   Mon, 21 Oct 2019 10:37:54 -0300
Message-Id: <20191021133834.25998-18-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index 467e18e6f8ec..cdee22dac2b3 100644
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
-- 
2.21.0

