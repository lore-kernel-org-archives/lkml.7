Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96796C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74BE3218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388901AbfB1ShD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:37:03 -0500
Received: from mga18.intel.com ([134.134.136.126]:32793 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387947AbfB1Sfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:35:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 10:35:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,423,1544515200"; 
   d="scan'208";a="121589633"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga008.jf.intel.com with ESMTP; 28 Feb 2019 10:35:53 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 18846300512; Thu, 28 Feb 2019 10:35:53 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v3 03/11] perf tools report: Support nano seconds
Date:   Thu, 28 Feb 2019 10:35:42 -0800
Message-Id: <20190228183550.14126-4-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190228183550.14126-1-andi@firstfloor.org>
References: <20190228183550.14126-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Upcoming changes add timestamp output in perf report. Add a --ns
argument similar to perf script to support nanoseconds resolution
when needed.

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---
v2:
Move flag into symbol_conf and change all users
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
index 1532ebde6c4b..09180e559ad6 100644
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
index fbc440bdf880..6575322c61c0 100644
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
-- 
2.17.2

