Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C8FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32FA20883
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfCVWWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:22:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36715 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfCVWWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:22:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMMEIL750613
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:22:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMMEuS750609;
        Fri, 22 Mar 2019 15:22:14 -0700
Date:   Fri, 22 Mar 2019 15:22:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-bpahyi6pr9r399mvihu65fvc@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com, mingo@kernel.org,
        jolsa@kernel.org
Reply-To: acme@redhat.com, hpa@zytor.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, ak@linux.intel.com,
          jolsa@kernel.org, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script: Support relative time
Git-Commit-ID: 90b10f47c0ee2a70bd036d9da5e810f522b54a8f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  90b10f47c0ee2a70bd036d9da5e810f522b54a8f
Gitweb:     https://git.kernel.org/tip/90b10f47c0ee2a70bd036d9da5e810f522b54a8f
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Thu, 14 Mar 2019 15:50:00 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:03 -0300

perf script: Support relative time

When comparing time stamps in 'perf script' traces it can be annoying to
work with the full perf time stamps.

Add a --reltime option that displays time stamps relative to the trace
start to make it easier to read the traces.

Note: not currently supported for --time. Report an error in this
case.

Before:

  % perf script
      swapper 0 [000] 245402.891216:    1 cycles:ppp: ffffffffa0068814 native_write_msr+0x4 ([kernel.kallsyms])
      swapper 0 [000] 245402.891223:    1 cycles:ppp: ffffffffa0068814 native_write_msr+0x4 ([kernel.kallsyms])
      swapper 0 [000] 245402.891227:    5 cycles:ppp: ffffffffa0068814 native_write_msr+0x4 ([kernel.kallsyms])
      swapper 0 [000] 245402.891231:   41 cycles:ppp: ffffffffa0068816 native_write_msr+0x6 ([kernel.kallsyms])
      swapper 0 [000] 245402.891235:  355 cycles:ppp: ffffffffa000dd51 intel_bts_enable_local+0x21 ([kernel.kallsyms])
      swapper 0 [000] 245402.891239: 3084 cycles:ppp: ffffffffa0a0150a end_repeat_nmi+0x48 ([kernel.kallsyms])

After:

  % perf script --reltime

      swapper 0 [000]     0.000000:    1 cycles:ppp: ffffffffa0068814 native_write_msr+0x4 ([kernel.kallsyms])
      swapper 0 [000]     0.000006:    1 cycles:ppp: ffffffffa0068814 native_write_msr+0x4 ([kernel.kallsyms])
      swapper 0 [000]     0.000010:    5 cycles:ppp: ffffffffa0068814 native_write_msr+0x4 ([kernel.kallsyms])
      swapper 0 [000]     0.000014:   41 cycles:ppp: ffffffffa0068816 native_write_msr+0x6 ([kernel.kallsyms])
      swapper 0 [000]     0.000018:  355 cycles:ppp: ffffffffa000dd51 intel_bts_enable_local+0x21 ([kernel.kallsyms])
      swapper 0 [000]     0.000022: 3084 cycles:ppp: ffffffffa0a0150a end_repeat_nmi+0x48 ([kernel.kallsyms])

Committer notes:

Do not use 'time' as the name of a variable, as this breaks the build on
older glibcs:

  cc1: warnings being treated as errors
  builtin-script.c: In function 'perf_sample__fprintf_start':
  builtin-script.c:691: warning: declaration of 'time' shadows a global declaration
  /usr/include/time.h:187: warning: shadowed declaration is here

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
LPU-Reference: 20190314225002.30108-8-andi@firstfloor.org
Link: https://lkml.kernel.org/n/tip-bpahyi6pr9r399mvihu65fvc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-script.txt |  3 +++
 tools/perf/builtin-script.c              | 18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 2e19fd7ffe35..9b0d04dd2a61 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -380,6 +380,9 @@ include::itrace.txt[]
 	Set the maximum number of program blocks to print with brstackasm for
 	each sample.
 
+--reltime::
+	Print time stamps relative to trace start.
+
 --per-event-dump::
 	Create per event files with a "perf.data.EVENT.dump" name instead of
         printing to stdout, useful, for instance, for generating flamegraphs.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 2f93d60c5a17..61cfd8f70989 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -53,6 +53,8 @@
 
 static char const		*script_name;
 static char const		*generate_script_lang;
+static bool			reltime;
+static u64			initial_time;
 static bool			debug_mode;
 static u64			last_timestamp;
 static u64			nr_unordered;
@@ -686,7 +688,13 @@ static int perf_sample__fprintf_start(struct perf_sample *sample,
 	}
 
 	if (PRINT_FIELD(TIME)) {
-		nsecs = sample->time;
+		u64 t = sample->time;
+		if (reltime) {
+			if (!initial_time)
+				initial_time = sample->time;
+			t = sample->time - initial_time;
+		}
+		nsecs = t;
 		secs = nsecs / NSEC_PER_SEC;
 		nsecs -= secs * NSEC_PER_SEC;
 
@@ -694,7 +702,7 @@ static int perf_sample__fprintf_start(struct perf_sample *sample,
 			printed += fprintf(fp, "%5lu.%09llu: ", secs, nsecs);
 		else {
 			char sample_time[32];
-			timestamp__scnprintf_usec(sample->time, sample_time, sizeof(sample_time));
+			timestamp__scnprintf_usec(t, sample_time, sizeof(sample_time));
 			printed += fprintf(fp, "%12s: ", sample_time);
 		}
 	}
@@ -3413,6 +3421,7 @@ int cmd_script(int argc, const char **argv)
 		     "Set the maximum stack depth when parsing the callchain, "
 		     "anything beyond the specified depth will be ignored. "
 		     "Default: kernel.perf_event_max_stack or " __stringify(PERF_MAX_STACK_DEPTH)),
+	OPT_BOOLEAN(0, "reltime", &reltime, "Show time stamps relative to start"),
 	OPT_BOOLEAN('I', "show-info", &show_full_info,
 		    "display extended information from perf.data file"),
 	OPT_BOOLEAN('\0', "show-kernel-path", &symbol_conf.show_kernel_path,
@@ -3487,6 +3496,11 @@ int cmd_script(int argc, const char **argv)
 		}
 	}
 
+	if (script.time_str && reltime) {
+		fprintf(stderr, "Don't combine --reltime with --time\n");
+		return -1;
+	}
+
 	if (itrace_synth_opts.callchain &&
 	    itrace_synth_opts.callchain_sz > scripting_max_stack)
 		scripting_max_stack = itrace_synth_opts.callchain_sz;
