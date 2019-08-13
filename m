Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667C5C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1162070D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfHMVGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:06:25 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:30310 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726560AbfHMVGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:06:24 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7DL0nd4026618;
        Tue, 13 Aug 2019 21:06:16 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 2uc1js9a9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Aug 2019 21:06:16 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id A77EF57;
        Tue, 13 Aug 2019 21:06:15 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
        id 6D89A20131367; Tue, 13 Aug 2019 16:06:15 -0500 (CDT)
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
Subject: [PATCH 2/2] perf: Replace MAX_NR_CPUS with dynamic alternatives
Date:   Tue, 13 Aug 2019 16:06:13 -0500
Message-Id: <20190813210613.99361-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
X-Mailer: git-send-email 2.12.3
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908130201
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both cpu__max_cpu and env.nr_cpus_online are dynamic alternatives for
MAX_NR_CPUS, a macro currently used throughout perf. The function cpu__max_cpu
returns the possible number of CPUS as defined in the sysfs, whereas
env.nr_cpus_online is the number of CPUs that were online during the recording
session. MAX_NR_CPUS is still used by DECLARE_BITMAP at compile time, however,
it's replaced elsewhere.

This patch was tested using "perf record -a -g" on both an eight socket 288 CPU
system and a single socket 36 CPU system. Each system was then rebooted single
socket and eight socket before "perf report" was used to read the perf.data out
file. "perf report --header" was used to confirm that each perf.data file had
information on the correct number of CPUs.

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
 tools/perf/util/header.c    |  6 +++---
 tools/perf/util/machine.c   | 11 ++++++-----
 tools/perf/util/session.c   |  6 +++---
 tools/perf/util/stat.c      |  4 ++--
 tools/perf/util/svghelper.c | 31 +++++++++++++++----------------
 5 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index b04c2b6b28b3..cf8ce839cb47 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1121,16 +1121,16 @@ static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
 	return 0;
 }
 
-#define MAX_CACHES (MAX_NR_CPUS * 4)
+#define MAX_CACHE_LVL 4
 
 static int write_cache(struct feat_fd *ff,
 		       struct evlist *evlist __maybe_unused)
 {
-	struct cpu_cache_level caches[MAX_CACHES];
+	struct cpu_cache_level caches[(cpu__max_cpu() * MAX_CACHE_LVL)];
 	u32 cnt = 0, i, version = 1;
 	int ret;
 
-	ret = build_caches(caches, MAX_CACHES, &cnt);
+	ret = build_caches(caches, (cpu__max_cpu() * MAX_CACHE_LVL), &cnt);
 	if (ret)
 		goto out;
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5734460fc89e..cf5f4b4eeea0 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2616,7 +2616,8 @@ int __machine__synthesize_threads(struct machine *machine, struct perf_tool *too
 
 pid_t machine__get_current_tid(struct machine *machine, int cpu)
 {
-	if (cpu < 0 || cpu >= MAX_NR_CPUS || !machine->current_tid)
+	int nr_cpus_online = machine->env->nr_cpus_online;
+	if (cpu < 0 || cpu >= nr_cpus_online || !machine->current_tid)
 		return -1;
 
 	return machine->current_tid[cpu];
@@ -2626,6 +2627,7 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
 			     pid_t tid)
 {
 	struct thread *thread;
+	int nr_cpus_online = machine->env->nr_cpus_online;
 
 	if (cpu < 0)
 		return -EINVAL;
@@ -2633,16 +2635,15 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
 	if (!machine->current_tid) {
 		int i;
 
-		machine->current_tid = calloc(MAX_NR_CPUS, sizeof(pid_t));
+		machine->current_tid = calloc(nr_cpus_online, sizeof(pid_t));
 		if (!machine->current_tid)
 			return -ENOMEM;
-		for (i = 0; i < MAX_NR_CPUS; i++)
+		for (i = 0; i < nr_cpus_online; i++)
 			machine->current_tid[i] = -1;
 	}
 
-	if (cpu >= MAX_NR_CPUS) {
+	if (cpu >= nr_cpus_online) {
 		pr_err("Requested CPU %d too large. ", cpu);
-		pr_err("Consider raising MAX_NR_CPUS\n");
 		return -EINVAL;
 	}
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 11e6093c941b..a9d244a94e24 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2275,6 +2275,7 @@ int perf_session__cpu_bitmap(struct perf_session *session,
 {
 	int i, err = -1;
 	struct perf_cpu_map *map;
+	int nr_cpus_online = session->header.env.nr_cpus_online;
 
 	for (i = 0; i < PERF_TYPE_MAX; ++i) {
 		struct evsel *evsel;
@@ -2299,9 +2300,8 @@ int perf_session__cpu_bitmap(struct perf_session *session,
 	for (i = 0; i < map->nr; i++) {
 		int cpu = map->map[i];
 
-		if (cpu >= MAX_NR_CPUS) {
-			pr_err("Requested CPU %d too large. "
-			       "Consider raising MAX_NR_CPUS\n", cpu);
+		if (cpu >= nr_cpus_online) {
+			pr_err("Requested CPU %d too large\n", cpu);
 			goto out_delete_map;
 		}
 
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index e4e4e3bf8b2b..199008ce936d 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -208,7 +208,7 @@ void perf_evlist__reset_stats(struct evlist *evlist)
 static void zero_per_pkg(struct evsel *counter)
 {
 	if (counter->per_pkg_mask)
-		memset(counter->per_pkg_mask, 0, MAX_NR_CPUS);
+		memset(counter->per_pkg_mask, 0, cpu__max_cpu());
 }
 
 static int check_per_pkg(struct evsel *counter,
@@ -227,7 +227,7 @@ static int check_per_pkg(struct evsel *counter,
 		return 0;
 
 	if (!mask) {
-		mask = zalloc(MAX_NR_CPUS);
+		mask = zalloc(cpu__max_cpu());
 		if (!mask)
 			return -ENOMEM;
 
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 1beeb7291361..6e8433e97f21 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -695,7 +695,8 @@ struct topology {
 	int sib_thr_nr;
 };
 
-static void scan_thread_topology(int *map, struct topology *t, int cpu, int *pos)
+static void scan_thread_topology(int *map, struct topology *t, int cpu,
+int *pos, int max_cpus)
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
+			env->nr_cpus_online)) {
 			fprintf(stderr, "topology: can't parse siblings map\n");
 			goto exit;
 		}
@@ -776,7 +774,8 @@ int svg_build_topology_map(struct perf_env *env)
 	}
 
 	for (i = 0; i < env->nr_sibling_threads; i++) {
-		if (str_to_bitmap(env->sibling_threads, &t.sib_thr[i])) {
+		if (str_to_bitmap(env->sibling_threads, &t.sib_thr[i],
+			env->nr_cpus_online)) {
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

