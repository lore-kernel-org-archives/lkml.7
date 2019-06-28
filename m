Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE1EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B322064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfF1Pgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:36:49 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:65130 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbfF1Pgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:36:49 -0400
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5SFaDOi014358;
        Fri, 28 Jun 2019 15:36:23 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 2tdkwdgx1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jun 2019 15:36:23 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (unknown [128.162.236.70])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 1400C64;
        Fri, 28 Jun 2019 15:36:21 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
        id C842720204956; Fri, 28 Jun 2019 10:36:20 -0500 (CDT)
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
Subject: [PATCH] [PATCH v2] perf: Modify MAX_NR_CPUS and MAX_CACHES
Date:   Fri, 28 Jun 2019 10:35:55 -0500
Message-Id: <20190628153555.172539-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
X-Mailer: git-send-email 2.12.3
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280180
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf surpasses the limit of MAX_NR_CPUS and MAX_CACHES while attempting to
profile 1024 or more CPUs. Increase and/or make each limit dynamic to
regain normal functionality.

Before:
	perf record -a
	[ perf record: Woken up X times to write data ]
	way too many cpu caches..
	[ perf record: Captured and wrote X MB perf.data (X samples) ]

	perf report -C 1024
	Error: failed to set  cpu bitmap
	Requested CPU 1024 too large. Consider raising MAX_NR_CPUS

After:
	perf record -a
	[ perf record: Woken up X times to write data ]
	[ perf record: Captured and wrote X MB perf.data (X samples) ]

	perf report -C 1024
	...

The variables nr_cpus_onln and max_caches are alternatives for MAX_NR_CPUS
and MAX_CACHES, they are initialized at runtime. MAX_NR_CPUS is increased
from 1024 to 2048 as it is still used by DECLARE_BITMAP() at compile time,
nr_cpus_onln replaces it elsewhere throughout perf.

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
 tools/perf/perf.c           |  6 ++++++
 tools/perf/perf.h           |  3 ++-
 tools/perf/util/cpumap.c    |  6 +++---
 tools/perf/util/header.c    |  7 +++----
 tools/perf/util/machine.c   | 11 +++++------
 tools/perf/util/session.c   |  5 ++---
 tools/perf/util/stat.c      |  4 ++--
 tools/perf/util/svghelper.c | 10 +++++-----
 8 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 72df4b6fa36f..c2c22476a65f 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -427,6 +427,12 @@ int main(int argc, const char **argv)
 	const char *cmd;
 	char sbuf[STRERR_BUFSIZE];
 
+	nr_cpus_onln = sysconf(_SC_NPROCESSORS_ONLN);
+	if (nr_cpus_onln < 0) {
+		fprintf(stderr, "Cannot determine the number of CPUs currently online.\n");
+		goto out;
+	}
+	
 	/* libsubcmd init */
 	exec_cmd_init("perf", PREFIX, PERF_EXEC_PATH, EXEC_PATH_ENVIRONMENT);
 	pager_init(PERF_PAGER_ENVIRONMENT);
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 711e009381ec..603391cac85b 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -26,9 +26,10 @@ static inline unsigned long long rdclock(void)
 }
 
 #ifndef MAX_NR_CPUS
-#define MAX_NR_CPUS			1024
+#define MAX_NR_CPUS			2048
 #endif
 
+int nr_cpus_onln;
 extern const char *input_name;
 extern bool perf_host, perf_guest;
 extern const char perf_version_string[];
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index c11a459ca582..83c05afef063 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -72,7 +72,7 @@ struct cpu_map *cpu_map__read(FILE *file)
 			int new_max = nr_cpus + cpu - prev - 1;
 
 			if (new_max >= max_entries) {
-				max_entries = new_max + MAX_NR_CPUS / 2;
+				max_entries = new_max + nr_cpus_onln / 2;
 				tmp = realloc(tmp_cpus, max_entries * sizeof(int));
 				if (tmp == NULL)
 					goto out_free_tmp;
@@ -83,7 +83,7 @@ struct cpu_map *cpu_map__read(FILE *file)
 				tmp_cpus[nr_cpus++] = prev;
 		}
 		if (nr_cpus == max_entries) {
-			max_entries += MAX_NR_CPUS;
+			max_entries += nr_cpus_onln;
 			tmp = realloc(tmp_cpus, max_entries * sizeof(int));
 			if (tmp == NULL)
 				goto out_free_tmp;
@@ -170,7 +170,7 @@ struct cpu_map *cpu_map__new(const char *cpu_list)
 					goto invalid;
 
 			if (nr_cpus == max_entries) {
-				max_entries += MAX_NR_CPUS;
+				max_entries += nr_cpus_onln;
 				tmp = realloc(tmp_cpus, max_entries * sizeof(int));
 				if (tmp == NULL)
 					goto invalid;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 06ddb6618ef3..78f1acb069ed 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1121,16 +1121,15 @@ static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
 	return 0;
 }
 
-#define MAX_CACHES 2000
-
 static int write_cache(struct feat_fd *ff,
 		       struct perf_evlist *evlist __maybe_unused)
 {
-	struct cpu_cache_level caches[MAX_CACHES];
+	u32 max_caches = (nr_cpus_onln * 4);
+	struct cpu_cache_level caches[max_caches];
 	u32 cnt = 0, i, version = 1;
 	int ret;
 
-	ret = build_caches(caches, MAX_CACHES, &cnt);
+	ret = build_caches(caches, max_caches, &cnt);
 	if (ret)
 		goto out;
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 17eec39e775e..b4d792dbeb1f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2593,7 +2593,7 @@ int __machine__synthesize_threads(struct machine *machine, struct perf_tool *too
 
 pid_t machine__get_current_tid(struct machine *machine, int cpu)
 {
-	if (cpu < 0 || cpu >= MAX_NR_CPUS || !machine->current_tid)
+	if (cpu < 0 || cpu >= nr_cpus_onln || !machine->current_tid)
 		return -1;
 
 	return machine->current_tid[cpu];
@@ -2610,16 +2610,15 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
 	if (!machine->current_tid) {
 		int i;
 
-		machine->current_tid = calloc(MAX_NR_CPUS, sizeof(pid_t));
+		machine->current_tid = calloc(nr_cpus_onln, sizeof(pid_t));
 		if (!machine->current_tid)
 			return -ENOMEM;
-		for (i = 0; i < MAX_NR_CPUS; i++)
+		for (i = 0; i < nr_cpus_onln; i++)
 			machine->current_tid[i] = -1;
 	}
 
-	if (cpu >= MAX_NR_CPUS) {
-		pr_err("Requested CPU %d too large. ", cpu);
-		pr_err("Consider raising MAX_NR_CPUS\n");
+	if (cpu >= nr_cpus_onln) {
+		pr_err("Requested CPU %d too large, there are %d CPUs currently online.\n", cpu, nr_cpus_onln);
 		return -EINVAL;
 	}
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 54cf163347f7..8641364555fb 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2289,9 +2289,8 @@ int perf_session__cpu_bitmap(struct perf_session *session,
 	for (i = 0; i < map->nr; i++) {
 		int cpu = map->map[i];
 
-		if (cpu >= MAX_NR_CPUS) {
-			pr_err("Requested CPU %d too large. "
-			       "Consider raising MAX_NR_CPUS\n", cpu);
+		if (cpu >= nr_cpus_onln) {
+			pr_err("Requested CPU %d too large, there are %d CPUs currently online.\n", cpu, nr_cpus_onln);
 			goto out_delete_map;
 		}
 
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index d91fe754b6d2..9d4a3b96496a 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -207,7 +207,7 @@ void perf_evlist__reset_stats(struct perf_evlist *evlist)
 static void zero_per_pkg(struct perf_evsel *counter)
 {
 	if (counter->per_pkg_mask)
-		memset(counter->per_pkg_mask, 0, MAX_NR_CPUS);
+		memset(counter->per_pkg_mask, 0, nr_cpus_onln);
 }
 
 static int check_per_pkg(struct perf_evsel *counter,
@@ -226,7 +226,7 @@ static int check_per_pkg(struct perf_evsel *counter,
 		return 0;
 
 	if (!mask) {
-		mask = zalloc(MAX_NR_CPUS);
+		mask = zalloc(nr_cpus_onln);
 		if (!mask)
 			return -ENOMEM;
 
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index fab8a048d31b..6a8241932dce 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -705,7 +705,7 @@ static void scan_thread_topology(int *map, struct topology *t, int cpu, int *pos
 
 		for_each_set_bit(thr,
 				 cpumask_bits(&t->sib_thr[i]),
-				 MAX_NR_CPUS)
+				 nr_cpus_onln)
 			if (map[thr] == -1)
 				map[thr] = (*pos)++;
 	}
@@ -720,7 +720,7 @@ static void scan_core_topology(int *map, struct topology *t)
 	for (i = 0; i < t->sib_core_nr; i++)
 		for_each_set_bit(cpu,
 				 cpumask_bits(&t->sib_core[i]),
-				 MAX_NR_CPUS)
+				 nr_cpus_onln)
 			scan_thread_topology(map, t, cpu, &pos);
 }
 
@@ -737,7 +737,7 @@ static int str_to_bitmap(char *s, cpumask_t *b)
 
 	for (i = 0; i < m->nr; i++) {
 		c = m->map[i];
-		if (c >= MAX_NR_CPUS) {
+		if (c >= nr_cpus_onln) {
 			ret = -1;
 			break;
 		}
@@ -784,13 +784,13 @@ int svg_build_topology_map(char *sib_core, int sib_core_nr,
 		sib_thr += strlen(sib_thr) + 1;
 	}
 
-	topology_map = malloc(sizeof(int) * MAX_NR_CPUS);
+	topology_map = malloc(sizeof(int) * nr_cpus_onln);
 	if (!topology_map) {
 		fprintf(stderr, "topology: no memory\n");
 		goto exit;
 	}
 
-	for (i = 0; i < MAX_NR_CPUS; i++)
+	for (i = 0; i < nr_cpus_onln; i++)
 		topology_map[i] = -1;
 
 	scan_core_topology(topology_map, &t);
-- 
2.12.3

