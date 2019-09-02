Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF01C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E3E2173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbfIBITq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:19:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56145 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729964AbfIBIQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:35 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVf-0007wn-OG; Mon, 02 Sep 2019 10:16:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5B26C1C0DE7;
        Mon,  2 Sep 2019 10:16:23 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:23 -0000
From:   "tip-bot2 for Kyle Meyer" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf timechart: Refactor svg_build_topology_map()
Cc:     Kyle Meyer <kyle.meyer@hpe.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190827214352.94272-2-meyerk@stormcage.eag.rdlabs.hpecorp.net>
References: <20190827214352.94272-2-meyerk@stormcage.eag.rdlabs.hpecorp.net>
MIME-Version: 1.0
Message-ID: <156741218328.17265.12865594530636474273.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0ac1dd5b4a70cfc8591dd9426f800b484765badb
Gitweb:        https://git.kernel.org/tip/0ac1dd5b4a70cfc8591dd9426f800b484765badb
Author:        Kyle Meyer <meyerk@hpe.com>
AuthorDate:    Tue, 27 Aug 2019 16:43:46 -05:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 17:38:31 -03:00

perf timechart: Refactor svg_build_topology_map()

Exchange the parameters of svg_build_topology_map() with 'struct
perf_env *env' and adjust the function accordingly.

This patch should not change any behavior, it is merely refactoring for
the following patch.

Committer notes:

No need to include env.h from svghelper.h, all it needs is a forward
declaration for 'struct perf_env', so move the include directive to
svghelper.c, where it is really needed.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russ Anderson <russ.anderson@hpe.com>
Link: http://lore.kernel.org/lkml/20190827214352.94272-2-meyerk@stormcage.eag.rdlabs.hpecorp.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-timechart.c |  5 +----
 tools/perf/util/svghelper.c    | 20 ++++++++++++--------
 tools/perf/util/svghelper.h    |  4 +++-
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 7d6a6ec..1ff81a7 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1518,10 +1518,7 @@ static int process_header(struct perf_file_section *section __maybe_unused,
 		if (!tchart->topology)
 			break;
 
-		if (svg_build_topology_map(ph->env.sibling_cores,
-					   ph->env.nr_sibling_cores,
-					   ph->env.sibling_threads,
-					   ph->env.nr_sibling_threads))
+		if (svg_build_topology_map(&ph->env))
 			fprintf(stderr, "problem building topology\n");
 		break;
 
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index bbdd871..2e99715 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -19,6 +19,7 @@
 #include <linux/zalloc.h>
 #include <perf/cpumap.h>
 
+#include "env.h"
 #include "perf.h"
 #include "svghelper.h"
 #include "cpumap.h"
@@ -752,23 +753,26 @@ static int str_to_bitmap(char *s, cpumask_t *b)
 	return ret;
 }
 
-int svg_build_topology_map(char *sib_core, int sib_core_nr,
-			   char *sib_thr, int sib_thr_nr)
+int svg_build_topology_map(struct perf_env *env)
 {
 	int i;
 	struct topology t;
+	char *sib_core, *sib_thr;
 
-	t.sib_core_nr = sib_core_nr;
-	t.sib_thr_nr = sib_thr_nr;
-	t.sib_core = calloc(sib_core_nr, sizeof(cpumask_t));
-	t.sib_thr = calloc(sib_thr_nr, sizeof(cpumask_t));
+	t.sib_core_nr = env->nr_sibling_cores;
+	t.sib_thr_nr = env->nr_sibling_threads;
+	t.sib_core = calloc(env->nr_sibling_cores, sizeof(cpumask_t));
+	t.sib_thr = calloc(env->nr_sibling_threads, sizeof(cpumask_t));
+
+	sib_core = env->sibling_cores;
+	sib_thr = env->sibling_threads;
 
 	if (!t.sib_core || !t.sib_thr) {
 		fprintf(stderr, "topology: no memory\n");
 		goto exit;
 	}
 
-	for (i = 0; i < sib_core_nr; i++) {
+	for (i = 0; i < env->nr_sibling_cores; i++) {
 		if (str_to_bitmap(sib_core, &t.sib_core[i])) {
 			fprintf(stderr, "topology: can't parse siblings map\n");
 			goto exit;
@@ -777,7 +781,7 @@ int svg_build_topology_map(char *sib_core, int sib_core_nr,
 		sib_core += strlen(sib_core) + 1;
 	}
 
-	for (i = 0; i < sib_thr_nr; i++) {
+	for (i = 0; i < env->nr_sibling_threads; i++) {
 		if (str_to_bitmap(sib_thr, &t.sib_thr[i])) {
 			fprintf(stderr, "topology: can't parse siblings map\n");
 			goto exit;
diff --git a/tools/perf/util/svghelper.h b/tools/perf/util/svghelper.h
index e55338d..81823e8 100644
--- a/tools/perf/util/svghelper.h
+++ b/tools/perf/util/svghelper.h
@@ -4,6 +4,8 @@
 
 #include <linux/types.h>
 
+struct perf_env;
+
 void open_svg(const char *filename, int cpus, int rows, u64 start, u64 end);
 void svg_ubox(int Yslot, u64 start, u64 end, double height, const char *type, int fd, int err, int merges);
 void svg_lbox(int Yslot, u64 start, u64 end, double height, const char *type, int fd, int err, int merges);
@@ -28,7 +30,7 @@ void svg_partial_wakeline(u64 start, int row1, char *desc1, int row2, char *desc
 void svg_interrupt(u64 start, int row, const char *backtrace);
 void svg_text(int Yslot, u64 start, const char *text);
 void svg_close(void);
-int svg_build_topology_map(char *sib_core, int sib_core_nr, char *sib_thr, int sib_thr_nr);
+int svg_build_topology_map(struct perf_env *env);
 
 extern int svg_page_width;
 extern u64 svg_highlight;
