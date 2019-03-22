Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAAFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCC22190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfCVWAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:00:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51775 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfCVWAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:00:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MLxr0Z744855
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 14:59:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MLxrfT744851;
        Fri, 22 Mar 2019 14:59:53 -0700
Date:   Fri, 22 Mar 2019 14:59:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-52bab8868211b7c504146f6239e101421d4d125b@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        namhyung@kernel.org, jolsa@kernel.org, acme@redhat.com,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: mingo@kernel.org, namhyung@kernel.org, ak@linux.intel.com,
          linux-kernel@vger.kernel.org, jolsa@kernel.org, acme@redhat.com,
          hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20190305144758.12397-5-andi@firstfloor.org>
References: <20190305144758.12397-5-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf report: Support output in nanoseconds
Git-Commit-ID: 52bab8868211b7c504146f6239e101421d4d125b
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

Commit-ID:  52bab8868211b7c504146f6239e101421d4d125b
Gitweb:     https://git.kernel.org/tip/52bab8868211b7c504146f6239e101421d4d125b
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Tue, 5 Mar 2019 06:47:47 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 11:56:02 -0300

perf report: Support output in nanoseconds

Upcoming changes add timestamp output in perf report. Add a --ns
argument similar to perf script to support nanoseconds resolution when
needed.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20190305144758.12397-5-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt |  3 +++
 tools/perf/builtin-report.c              |  1 +
 tools/perf/builtin-script.c              | 11 +++++------
 tools/perf/util/symbol.c                 |  1 +
 tools/perf/util/symbol_conf.h            |  1 +
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 1a27bfe05039..51dbc519dbce 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -477,6 +477,9 @@ include::itrace.txt[]
 	Please note that not all mmaps are stored, options affecting which ones
 	are include 'perf record --data', for instance.
 
+--ns::
+	Show time stamps in nanoseconds.
+
 --stats::
 	Display overall events statistics without any further processing.
 	(like the one at the end of the perf report -D command)
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ee93c18a6685..515864ba504a 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1147,6 +1147,7 @@ int cmd_report(int argc, const char **argv)
 	OPT_CALLBACK(0, "percent-type", &report.annotation_opts, "local-period",
 		     "Set percent type local/global-period/hits",
 		     annotate_parse_percent_type),
+	OPT_BOOLEAN(0, "ns", &symbol_conf.nanosecs, "Show times in nanosecs"),
 	OPT_END()
 	};
 	struct perf_data data = {
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index a5080afd361d..111787e83784 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -60,7 +60,6 @@ static bool			no_callchain;
 static bool			latency_format;
 static bool			system_wide;
 static bool			print_flags;
-static bool			nanosecs;
 static const char		*cpu_list;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 static struct perf_stat_config	stat_config;
@@ -691,7 +690,7 @@ static int perf_sample__fprintf_start(struct perf_sample *sample,
 		secs = nsecs / NSEC_PER_SEC;
 		nsecs -= secs * NSEC_PER_SEC;
 
-		if (nanosecs)
+		if (symbol_conf.nanosecs)
 			printed += fprintf(fp, "%5lu.%09llu: ", secs, nsecs);
 		else {
 			char sample_time[32];
@@ -3244,7 +3243,7 @@ static int parse_insn_trace(const struct option *opt __maybe_unused,
 {
 	parse_output_fields(NULL, "+insn,-event,-period", 0);
 	itrace_parse_synth_opts(opt, "i0ns", 0);
-	nanosecs = true;
+	symbol_conf.nanosecs = true;
 	return 0;
 }
 
@@ -3262,7 +3261,7 @@ static int parse_call_trace(const struct option *opt __maybe_unused,
 {
 	parse_output_fields(NULL, "-ip,-addr,-event,-period,+callindent", 0);
 	itrace_parse_synth_opts(opt, "cewp", 0);
-	nanosecs = true;
+	symbol_conf.nanosecs = true;
 	return 0;
 }
 
@@ -3272,7 +3271,7 @@ static int parse_callret_trace(const struct option *opt __maybe_unused,
 {
 	parse_output_fields(NULL, "-ip,-addr,-event,-period,+callindent,+flags", 0);
 	itrace_parse_synth_opts(opt, "crewp", 0);
-	nanosecs = true;
+	symbol_conf.nanosecs = true;
 	return 0;
 }
 
@@ -3408,7 +3407,7 @@ int cmd_script(int argc, const char **argv)
 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
 	OPT_INTEGER(0, "max-blocks", &max_blocks,
 		    "Maximum number of code blocks to dump with brstackinsn"),
-	OPT_BOOLEAN(0, "ns", &nanosecs,
+	OPT_BOOLEAN(0, "ns", &symbol_conf.nanosecs,
 		    "Use 9 decimal places when displaying time"),
 	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
 			    "Instruction Tracing options\n" ITRACE_HELP,
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 758bf5f74e6e..eb873ea1c405 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -39,6 +39,7 @@ int vmlinux_path__nr_entries;
 char **vmlinux_path;
 
 struct symbol_conf symbol_conf = {
+	.nanosecs		= false,
 	.use_modules		= true,
 	.try_vmlinux_path	= true,
 	.demangle		= true,
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index fffea68c1203..095a297c8b47 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -8,6 +8,7 @@ struct strlist;
 struct intlist;
 
 struct symbol_conf {
+	bool		nanosecs;
 	unsigned short	priv_size;
 	bool		try_vmlinux_path,
 			init_annotation,
