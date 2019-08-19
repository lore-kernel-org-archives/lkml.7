Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75752C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D6022DA7
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfHSUXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 16:23:16 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:50518 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728055AbfHSUXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 16:23:16 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JKLq2o009314;
        Mon, 19 Aug 2019 20:23:08 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 2ufy9phees-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 20:23:08 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 9092556;
        Mon, 19 Aug 2019 20:23:06 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
        id 580E52014C869; Mon, 19 Aug 2019 15:23:06 -0500 (CDT)
From:   Kyle Meyer <meyerk@hpe.com>
Cc:     Kyle Meyer <meyerk@hpe.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Russ Anderson <russ.anderson@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH v3 1/6] perf: Refactor svg_build_topology_map
Date:   Mon, 19 Aug 2019 15:23:03 -0500
Message-Id: <20190819202303.87876-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
X-Mailer: git-send-email 2.12.3
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190207
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exchange the parameters of svg_build_topology_map with struct perf_env *env and
adjust the function accordingly. This patch should not change any behavior, it
is merely refactoring for the following patch.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Russ Anderson <russ.anderson@hpe.com>
Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
---
 tools/perf/builtin-timechart.c |  5 +----
 tools/perf/util/svghelper.c    | 19 +++++++++++--------
 tools/perf/util/svghelper.h    |  4 +++-
 3 files changed, 15 insertions(+), 13 deletions(-)

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
index ae6a534a7a80..efe642b6c99d 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -751,23 +751,26 @@ static int str_to_bitmap(char *s, cpumask_t *b)
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
@@ -776,7 +779,7 @@ int svg_build_topology_map(char *sib_core, int sib_core_nr,
 		sib_core += strlen(sib_core) + 1;
 	}
 
-	for (i = 0; i < sib_thr_nr; i++) {
+	for (i = 0; i < env->nr_sibling_threads; i++) {
 		if (str_to_bitmap(sib_thr, &t.sib_thr[i])) {
 			fprintf(stderr, "topology: can't parse siblings map\n");
 			goto exit;
diff --git a/tools/perf/util/svghelper.h b/tools/perf/util/svghelper.h
index e55338d5c3bd..2add34c75733 100644
--- a/tools/perf/util/svghelper.h
+++ b/tools/perf/util/svghelper.h
@@ -4,6 +4,8 @@
 
 #include <linux/types.h>
 
+#include "env.h"
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
2.12.3

