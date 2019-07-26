Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C6AC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B6E218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfGZTxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:53:34 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:11044 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727516AbfGZTxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:53:34 -0400
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6QJfxMW013589;
        Fri, 26 Jul 2019 19:52:19 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 2u04swsd90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 19:52:19 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id A4ABA54;
        Fri, 26 Jul 2019 19:52:18 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
        id 6412320291940; Fri, 26 Jul 2019 14:52:18 -0500 (CDT)
From:   Kyle Meyer <meyerk@hpe.com>
Cc:     Kyle Meyer <meyerk@hpe.com>, Kyle Meyer <kyle.meyer@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Replace MAX_NR_CPUS with nr_cpus_onln
Date:   Fri, 26 Jul 2019 14:51:39 -0500
Message-Id: <20190726195139.178560-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
X-Mailer: git-send-email 2.12.3
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907260231
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variables nr_cpus_onln and max_caches are dynamic alternatives for
MAX_NR_CPUS and MAX_CACHES as they are initialized at runtime. MAX_NR_CPUS
is still used by DECLARE_BITMAP() at compile time, however, nr_cpus_onln
replaces it elsewhere throughout perf.

This patch was tested using "perf record -a -g" on both an eight socket
(288 CPUs) system and a single socket (36 CPUs) system. Each system was then
rebooted single socket (36 CPUs) / eight socket (288 CPUs) and "perf
report" used to read the perf.data file. "perf report --header" was used to
confirm that each perf.data had information on 288 CPUs / 36 CPUs.

This patch is meant to be built against perf tools: Increase MAX_NR_CPUS and
MAX_CACHES (commit 9f94c7f947e919c343b30f080285af53d0fa9902).

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Cc: Russ Anderson <russ.anderson@hpe.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/perf.c           | 10 ++++++++++
 tools/perf/perf.h           |  1 +
 tools/perf/util/cpumap.c    |  6 +++---
 tools/perf/util/header.c    |  5 +++--
 tools/perf/util/machine.c   | 11 +++++------
 tools/perf/util/stat.c      |  4 ++--
 tools/perf/util/svghelper.c | 10 +++++-----
 7 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 97e2628ea5dd..0d0162fb4e24 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -428,6 +428,16 @@ int main(int argc, const char **argv)
 	const char *cmd;
 	char sbuf[STRERR_BUFSIZE];
 
+	nr_cpus_onln = sysconf(_SC_NPROCESSORS_ONLN);
+	if (nr_cpus_onln < 0) {
+		fprintf(stderr, "Cannot determine the number of CPUs currently online.\n");
+		goto out;
+	} 
+	if (nr_cpus_onln > MAX_NR_CPUS) {
+		fprintf(stderr, "The number of CPUs currently online is too large, consider raising MAX_NR_CPUS.\n");
+		nr_cpus_onln = MAX_NR_CPUS;
+	}
+
 	/* libsubcmd init */
 	exec_cmd_init("perf", PREFIX, PERF_EXEC_PATH, EXEC_PATH_ENVIRONMENT);
 	pager_init(PERF_PAGER_ENVIRONMENT);
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 74d0124d38f3..603391cac85b 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -29,6 +29,7 @@ static inline unsigned long long rdclock(void)
 #define MAX_NR_CPUS			2048
 #endif
 
+int nr_cpus_onln;
 extern const char *input_name;
 extern bool perf_host, perf_guest;
 extern const char perf_version_string[];
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 3acfbe34ebaf..f634c56b1388 100644
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
index c24db7f4909c..030c0a8f6664 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1125,11 +1125,12 @@ static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
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
index cf826eca3aaf..92720240676d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2615,7 +2615,7 @@ int __machine__synthesize_threads(struct machine *machine, struct perf_tool *too
 
 pid_t machine__get_current_tid(struct machine *machine, int cpu)
 {
-	if (cpu < 0 || cpu >= MAX_NR_CPUS || !machine->current_tid)
+	if (cpu < 0 || cpu >= nr_cpus_onln || !machine->current_tid)
 		return -1;
 
 	return machine->current_tid[cpu];
@@ -2632,16 +2632,15 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
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
 
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index db8a6cf336be..f87bdc140a4b 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -208,7 +208,7 @@ void perf_evlist__reset_stats(struct perf_evlist *evlist)
 static void zero_per_pkg(struct perf_evsel *counter)
 {
 	if (counter->per_pkg_mask)
-		memset(counter->per_pkg_mask, 0, MAX_NR_CPUS);
+		memset(counter->per_pkg_mask, 0, nr_cpus_onln);
 }
 
 static int check_per_pkg(struct perf_evsel *counter,
@@ -227,7 +227,7 @@ static int check_per_pkg(struct perf_evsel *counter,
 		return 0;
 
 	if (!mask) {
-		mask = zalloc(MAX_NR_CPUS);
+		mask = zalloc(nr_cpus_onln);
 		if (!mask)
 			return -ENOMEM;
 
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 76cc54000483..4c38f70520c5 100644
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

