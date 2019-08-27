Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F2DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DCA206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfH0Voi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:44:38 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:13052 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbfH0Vof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:44:35 -0400
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7RLauOY023135;
        Tue, 27 Aug 2019 21:44:24 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0a-002e3701.pphosted.com with ESMTP id 2umjkuudag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 21:44:24 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id A6EDCA0;
        Tue, 27 Aug 2019 21:44:23 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
        id 708EA201564D7; Tue, 27 Aug 2019 16:44:23 -0500 (CDT)
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
Subject: [PATCH v4 2/7] perf/util/svghelper: Replace MAX_NR_CPUS with env->nr_cpus_online
Date:   Tue, 27 Aug 2019 16:43:47 -0500
Message-Id: <20190827214352.94272-3-meyerk@stormcage.eag.rdlabs.hpecorp.net>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190827214352.94272-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
References: <20190827214352.94272-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-27_04:2019-08-27,2019-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908270202
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nr_cpus, the number of CPUs online during a record session bound by
MAX_NR_CPUS, can be used as a dynamic alternative for MAX_NR_CPUS in
svg_build_topology_map. The value of nr_cpus can be passed into
str_to_bitmap, scan_core_topology, and svg_build_topology_map to replace
MAX_NR_CPUS as well.

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
 tools/perf/util/svghelper.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 4d2ac55267fc..be0af04a76e0 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -696,7 +696,8 @@ struct topology {
 	int sib_thr_nr;
 };
 
-static void scan_thread_topology(int *map, struct topology *t, int cpu, int *pos)
+static void scan_thread_topology(int *map, struct topology *t, int cpu,
+				 int *pos, int nr_cpus)
 {
 	int i;
 	int thr;
@@ -705,28 +706,24 @@ static void scan_thread_topology(int *map, struct topology *t, int cpu, int *pos
 		if (!test_bit(cpu, cpumask_bits(&t->sib_thr[i])))
 			continue;
 
-		for_each_set_bit(thr,
-				 cpumask_bits(&t->sib_thr[i]),
-				 MAX_NR_CPUS)
+		for_each_set_bit(thr, cpumask_bits(&t->sib_thr[i]), nr_cpus)
 			if (map[thr] == -1)
 				map[thr] = (*pos)++;
 	}
 }
 
-static void scan_core_topology(int *map, struct topology *t)
+static void scan_core_topology(int *map, struct topology *t, int nr_cpus)
 {
 	int pos = 0;
 	int i;
 	int cpu;
 
 	for (i = 0; i < t->sib_core_nr; i++)
-		for_each_set_bit(cpu,
-				 cpumask_bits(&t->sib_core[i]),
-				 MAX_NR_CPUS)
-			scan_thread_topology(map, t, cpu, &pos);
+		for_each_set_bit(cpu, cpumask_bits(&t->sib_core[i]), nr_cpus)
+			scan_thread_topology(map, t, cpu, &pos, nr_cpus);
 }
 
-static int str_to_bitmap(char *s, cpumask_t *b)
+static int str_to_bitmap(char *s, cpumask_t *b, int nr_cpus)
 {
 	int i;
 	int ret = 0;
@@ -739,7 +736,7 @@ static int str_to_bitmap(char *s, cpumask_t *b)
 
 	for (i = 0; i < m->nr; i++) {
 		c = m->map[i];
-		if (c >= MAX_NR_CPUS) {
+		if (c >= nr_cpus) {
 			ret = -1;
 			break;
 		}
@@ -754,10 +751,12 @@ static int str_to_bitmap(char *s, cpumask_t *b)
 
 int svg_build_topology_map(struct perf_env *env)
 {
-	int i;
+	int i, nr_cpus;
 	struct topology t;
 	char *sib_core, *sib_thr;
 
+	nr_cpus = min(env->nr_cpus_online, MAX_NR_CPUS);
+
 	t.sib_core_nr = env->nr_sibling_cores;
 	t.sib_thr_nr = env->nr_sibling_threads;
 	t.sib_core = calloc(env->nr_sibling_cores, sizeof(cpumask_t));
@@ -772,7 +771,7 @@ int svg_build_topology_map(struct perf_env *env)
 	}
 
 	for (i = 0; i < env->nr_sibling_cores; i++) {
-		if (str_to_bitmap(sib_core, &t.sib_core[i])) {
+		if (str_to_bitmap(sib_core, &t.sib_core[i], nr_cpus)) {
 			fprintf(stderr, "topology: can't parse siblings map\n");
 			goto exit;
 		}
@@ -781,7 +780,7 @@ int svg_build_topology_map(struct perf_env *env)
 	}
 
 	for (i = 0; i < env->nr_sibling_threads; i++) {
-		if (str_to_bitmap(sib_thr, &t.sib_thr[i])) {
+		if (str_to_bitmap(sib_thr, &t.sib_thr[i], nr_cpus)) {
 			fprintf(stderr, "topology: can't parse siblings map\n");
 			goto exit;
 		}
@@ -789,16 +788,16 @@ int svg_build_topology_map(struct perf_env *env)
 		sib_thr += strlen(sib_thr) + 1;
 	}
 
-	topology_map = malloc(sizeof(int) * MAX_NR_CPUS);
+	topology_map = malloc(sizeof(int) * nr_cpus);
 	if (!topology_map) {
 		fprintf(stderr, "topology: no memory\n");
 		goto exit;
 	}
 
-	for (i = 0; i < MAX_NR_CPUS; i++)
+	for (i = 0; i < nr_cpus; i++)
 		topology_map[i] = -1;
 
-	scan_core_topology(topology_map, &t);
+	scan_core_topology(topology_map, &t, nr_cpus);
 
 	return 0;
 
-- 
2.12.3

