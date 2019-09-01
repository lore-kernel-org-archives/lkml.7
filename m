Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9B1C3A5A7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842222339D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340624;
	bh=R6U6P1kxmHoX+PerBAKuW53s3W1IlKx4XIZZVYcWbSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zOtaRDY9SeWuL/uWvoWpU27e2V0Zf2ctqIp85vZ6qPPY4CdHqew3U9j3PWi1LcESP
	 TBNOlnGgCcQEAhu4yFjgT4TK5kOCFvI8yBuGzdbV6m7ewHbwPkVrjJHmPlRA2EDWA0
	 DZAp3sdbdOPtkCyu8j+5Kx9XLXXnldZcSXF62cGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfIAMXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfIAMXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:23:42 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9057A233A2;
        Sun,  1 Sep 2019 12:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340621;
        bh=R6U6P1kxmHoX+PerBAKuW53s3W1IlKx4XIZZVYcWbSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FtQkzzqqx+DLeamyw9fxMPlLUWcjy2pBawPm3lJyf2a9I2yObSco33VjIb8od83v3
         bCo0bnAIEskugMefzvaeLkN/5MIHAAm0fZKMq40OSET3B/rmsUC0MfvQKaTh4stIvn
         7uCgm3TMyofuCs5l6AQH31kbX0d2ewGsBQcztA0E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kyle Meyer <meyerk@hpe.com>, Kyle Meyer <kyle.meyer@hpe.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/47] perf timechart: Refactor svg_build_topology_map()
Date:   Sun,  1 Sep 2019 09:22:41 -0300
Message-Id: <20190901122326.5793-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle Meyer <meyerk@hpe.com>

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
index 7d6a6ecf4e02..1ff81a790931 100644
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
index bbdd87163285..2e9971590590 100644
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
index e55338d5c3bd..81823e8bae3e 100644
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
-- 
2.21.0

