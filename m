Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB8EC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CB42183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555573507;
	bh=M2QbLBK51VNvph5XiTAcdn8muKKzRlES3W454C1hHhk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=YIdZgmeAwnAcSOlW3OHLfbwVk04FqP5oYO42oawjBzB2AEysbgU/tJ0niWApdh1DV
	 8VJxMgPe/yu0P8x0jviqW7veGUEo6cMZlqv5kJayhfk2i1tzi/zP5hF6U2UloT4WMf
	 tYR4eOLuB9xw0kS4tP4jti581567kMtLGYOmv1Do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388187AbfDRHpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:45:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731317AbfDRHpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 03:45:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F9FC308621F;
        Thu, 18 Apr 2019 07:45:04 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29D1E5D9CC;
        Thu, 18 Apr 2019 07:45:01 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf stat: display cvs output for --null runs
Date:   Thu, 18 Apr 2019 09:45:01 +0200
Message-Id: <20190418074501.6009-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 18 Apr 2019 07:45:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support to display CVS values for --null runs as requested
by Ingo. It's only for --null run so it does not mess up with
standard CVS output.

For single --null run in CSV mode perf displays elapsed time:

  $ perf stat --null -x ';' true
  0.000496

For multiple --null run in CSV mode perf displays fields in this order:

  - average elapsed time
  - standard deviation

  $ perf stat -r 5  --null -x ';' true
  0.000339;0.000026

If --table is specified for above case, perf also displays new line
for every individual run with fields:

  - elapsed time
  - delta from average ellapsed time

  $ perf stat -r 5 --table  --null -x ';' true
  0.000496;0.000106
  0.000363;-0.000027
  0.000355;-0.000035
  0.000372;-0.000018
  0.000361;-0.000029
  0.000390;0.000027

The last line shows average elapsed time with standard deviation.

Requested-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Ingo Molnar <mingo@kernel.org>
Link: http://lkml.kernel.org/n/tip-l44kt096zzsjwi3l9hjw1lle@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-stat.txt | 30 ++++++++++++++++
 tools/perf/util/stat-display.c         | 48 +++++++++++++++++++-------
 2 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 39c05f89104e..c07f018f3b4b 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -368,6 +368,36 @@ The fields are in this order:
 
 Additional metrics may be printed with all earlier fields being empty.
 
+For single --null run in CSV mode perf displays elapsed time:
+
+  $ perf stat --null -x ';' true
+  0.000496
+
+For multiple --null run in CSV mode perf displays fields in this order:
+
+  - average elapsed time
+  - standard deviation
+
+  $ perf stat -r 5  --null -x ';' true
+  0.000339;0.000026
+
+If --table is specified for above case, perf also displays new line
+for every individual run with fields:
+
+  - elapsed time
+  - delta from average ellapsed time
+
+  $ perf stat -r 5 --table  --null -x ';' true
+  0.000496;0.000106
+  0.000363;-0.000027
+  0.000355;-0.000035
+  0.000372;-0.000018
+  0.000361;-0.000029
+  0.000390;0.000027
+
+The last line shows average elapsed time with standard deviation.
+
+
 SEE ALSO
 --------
 linkperf:perf-top[1], linkperf:perf-list[1]
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 3324f23c7efc..8cb4e37a0417 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1013,22 +1013,29 @@ static void print_table(struct perf_stat_config *config,
 	while (tmp[indent] == ' ')
 		indent++;
 
-	fprintf(output, "%*s# Table of individual measurements:\n", indent, "");
+	if (!config->csv_output)
+		fprintf(output, "%*s# Table of individual measurements:\n", indent, "");
 
 	for (idx = 0; idx < config->run_count; idx++) {
 		double run = (double) config->walltime_run[idx] / NSEC_PER_SEC;
 		int h, n = 1 + abs((int) (100.0 * (run - avg)/run) / 5);
 
-		fprintf(output, " %17.*f (%+.*f) ",
-			precision, run, precision, run - avg);
+		if (!config->csv_output) {
+			fprintf(output, " %17.*f (%+.*f) ",
+				precision, run, precision, run - avg);
 
-		for (h = 0; h < n; h++)
-			fprintf(output, "#");
+			for (h = 0; h < n; h++)
+				fprintf(output, "#");
+
+		} else {
+			fprintf(output, "%f%s%f", run, config->csv_sep, run - avg);
+		}
 
 		fprintf(output, "\n");
 	}
 
-	fprintf(output, "\n%*s# Final result:\n", indent, "");
+	if (!config->csv_output)
+		fprintf(output, "\n%*s# Final result:\n", indent, "");
 }
 
 static double timeval2double(struct timeval *t)
@@ -1042,13 +1049,23 @@ static void print_footer(struct perf_stat_config *config)
 	FILE *output = config->output;
 	int n;
 
-	if (!config->null_run)
+	/*
+	 * Display csv output for null run, but do
+	 * not mess up with standard csv mode.
+	 */
+	if (config->csv_output && !config->null_run)
+		return;
+
+	if (!config->csv_output && !config->null_run)
 		fprintf(output, "\n");
 
 	if (config->run_count == 1) {
-		fprintf(output, " %17.9f seconds time elapsed", avg);
+		if (!config->csv_output)
+			fprintf(output, " %17.9f seconds time elapsed", avg);
+		else
+			fprintf(output, "%f", avg);
 
-		if (config->ru_display) {
+		if (!config->csv_output && config->ru_display) {
 			double ru_utime = timeval2double(&config->ru_data.ru_utime);
 			double ru_stime = timeval2double(&config->ru_data.ru_stime);
 
@@ -1067,11 +1084,16 @@ static void print_footer(struct perf_stat_config *config)
 		if (config->walltime_run_table)
 			print_table(config, output, precision, avg);
 
-		fprintf(output, " %17.*f +- %.*f seconds time elapsed",
-			precision, avg, precision, sd);
+		if (!config->csv_output) {
+			fprintf(output, " %17.*f +- %.*f seconds time elapsed",
+				precision, avg, precision, sd);
 
-		print_noise_pct(config, sd, avg);
+			print_noise_pct(config, sd, avg);
+		} else {
+			fprintf(output, "%f%s%f", avg, config->csv_sep, sd);
+		}
 	}
+
 	fprintf(output, "\n\n");
 
 	if (config->print_free_counters_hint &&
@@ -1148,7 +1170,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 		break;
 	}
 
-	if (!interval && !config->csv_output)
+	if (!interval)
 		print_footer(config);
 
 	fflush(config->output);
-- 
2.20.1

