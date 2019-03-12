Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BA3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB0D214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552356150;
	bh=nRqU8G4fjuVX1EKxctFWDMy4ZPTvimzvcowJBbkcJ48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KH0s/zP5tMN0eAq4pG1SCp+vom6c3/g20/3LcsWnP1NJzBCvtuiW6L+uaR00WE6K4
	 H7BZ4YqMxOn+PZ2eOB5aGGAyRg/pMVK3NVpdmufCsTeGmI7H9h1iRiAUJ7KhcCQsGL
	 /DcbZ+IXA1zfgscnM43L4fl+N4s4Rj9AJqTeXrz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfCLCC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:02:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbfCLCCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:02:25 -0400
Received: from quaco.meukeo.local (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D5BE2171F;
        Tue, 12 Mar 2019 02:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552356144;
        bh=nRqU8G4fjuVX1EKxctFWDMy4ZPTvimzvcowJBbkcJ48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yA1aqnXmXGQOHmrFxsI/MXC6waVkys5RiKyoRs2V48pA57+FEhvsSrbghfEM2cRnt
         zoEBOHT7BXf4sguPekuX8gKb9x3YxhD+Ub9/M112h/emN6skRTr/zgyTK+K7zVp8TK
         zEJyEoiXHOQoIHTEgBj/5aLclRnSqt5Oz2YbY+Ps=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/30] perf report: Support output in nanoseconds
Date:   Mon, 11 Mar 2019 23:01:37 -0300
Message-Id: <20190312020204.22092-4-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

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
-- 
2.20.1

