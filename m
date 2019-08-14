Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B495C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454A12083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfHNUjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:39:49 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:9216 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727516AbfHNUjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:39:48 -0400
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7EKV0mD020156;
        Wed, 14 Aug 2019 20:38:38 GMT
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 2ucpax9b9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Aug 2019 20:38:38 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 0C8E165;
        Wed, 14 Aug 2019 20:38:37 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
        id C650520131383; Wed, 14 Aug 2019 15:38:36 -0500 (CDT)
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
Subject: [PATCH v2 2/6] perf/util/svghelper: Replace MAX_NR_CPUS with env->nr_cpus_online
Date:   Wed, 14 Aug 2019 15:38:34 -0500
Message-Id: <20190814203834.204813-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
X-Mailer: git-send-email 2.12.3
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140187
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

env->nr_cpus_online, the number of CPUs online during a record session, can be
used as a dynamic alternative for MAX_NR_CPUS in svg_build_topology_map. The
value of env->nr_cpus_online can be passed into str_to_bitmap,
scan_core_topology, and svg_build_topology_map to replace MAX_NR_CPUS as well.

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
 tools/perf/util/svghelper.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 1beeb7291361..5128ea71b284 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -695,7 +695,8 @@ struct topology {
 	int sib_thr_nr;
 };
 
-static void scan_thread_topology(int *map, struct topology *t, int cpu, int *pos)
+static void scan_thread_topology(int *map, struct topology *t, int cpu,
+				 int *pos, int max_cpus)
 {
 	int i;
 	int thr;
@@ -704,28 +705,24 @@ static void scan_thread_topology(int *map, struct topology *t, int cpu, int *pos
 		if (!test_bit(cpu, cpumask_bits(&t->sib_thr[i])))
 			continue;
 
-		for_each_set_bit(thr,
-				 cpumask_bits(&t->sib_thr[i]),
-				 MAX_NR_CPUS)
+		for_each_set_bit(thr, cpumask_bits(&t->sib_thr[i]), max_cpus)
 			if (map[thr] == -1)
 				map[thr] = (*pos)++;
 	}
 }
 
-static void scan_core_topology(int *map, struct topology *t)
+static void scan_core_topology(int *map, struct topology *t, int max_cpus)
 {
 	int pos = 0;
 	int i;
 	int cpu;
 
 	for (i = 0; i < t->sib_core_nr; i++)
-		for_each_set_bit(cpu,
-				 cpumask_bits(&t->sib_core[i]),
-				 MAX_NR_CPUS)
-			scan_thread_topology(map, t, cpu, &pos);
+		for_each_set_bit(cpu, cpumask_bits(&t->sib_core[i]), max_cpus)
+			scan_thread_topology(map, t, cpu, &pos, max_cpus);
 }
 
-static int str_to_bitmap(char *s, cpumask_t *b)
+static int str_to_bitmap(char *s, cpumask_t *b, int max_cpus)
 {
 	int i;
 	int ret = 0;
@@ -738,7 +735,7 @@ static int str_to_bitmap(char *s, cpumask_t *b)
 
 	for (i = 0; i < m->nr; i++) {
 		c = m->map[i];
-		if (c >= MAX_NR_CPUS) {
+		if (c >= max_cpus) {
 			ret = -1;
 			break;
 		}
@@ -767,7 +764,8 @@ int svg_build_topology_map(struct perf_env *env)
 	}
 
 	for (i = 0; i < env->nr_sibling_cores; i++) {
-		if (str_to_bitmap(env->sibling_cores, &t.sib_core[i])) {
+		if (str_to_bitmap(env->sibling_cores, &t.sib_core[i],
+				  env->nr_cpus_online)) {
 			fprintf(stderr, "topology: can't parse siblings map\n");
 			goto exit;
 		}
@@ -776,7 +774,8 @@ int svg_build_topology_map(struct perf_env *env)
 	}
 
 	for (i = 0; i < env->nr_sibling_threads; i++) {
-		if (str_to_bitmap(env->sibling_threads, &t.sib_thr[i])) {
+		if (str_to_bitmap(env->sibling_threads, &t.sib_thr[i],
+				  env->nr_cpus_online)) {
 			fprintf(stderr, "topology: can't parse siblings map\n");
 			goto exit;
 		}
@@ -784,16 +783,16 @@ int svg_build_topology_map(struct perf_env *env)
 		env->sibling_threads += strlen(env->sibling_threads) + 1;
 	}
 
-	topology_map = malloc(sizeof(int) * MAX_NR_CPUS);
+	topology_map = malloc(sizeof(int) * env->nr_cpus_online);
 	if (!topology_map) {
 		fprintf(stderr, "topology: no memory\n");
 		goto exit;
 	}
 
-	for (i = 0; i < MAX_NR_CPUS; i++)
+	for (i = 0; i < env->nr_cpus_online; i++)
 		topology_map[i] = -1;
 
-	scan_core_topology(topology_map, &t);
+	scan_core_topology(topology_map, &t, env->nr_cpus_online);
 
 	return 0;
 
-- 
2.12.3

