Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E7CC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE27E22DD6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfIBIQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:16:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56186 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730130AbfIBIQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:38 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hVh-0007xA-5X; Mon, 02 Sep 2019 10:16:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C00921C0793;
        Mon,  2 Sep 2019 10:16:23 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:23 -0000
From:   "tip-bot2 for Kyle Meyer" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf svghelper: Replace MAX_NR_CPUS with
 perf_env::nr_cpus_online
Cc:     Kyle Meyer <kyle.meyer@hpe.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190827214352.94272-3-meyerk@stormcage.eag.rdlabs.hpecorp.net>
References: <20190827214352.94272-3-meyerk@stormcage.eag.rdlabs.hpecorp.net>
MIME-Version: 1.0
Message-ID: <156741218370.17269.13149756432525958447.tip-bot2@tip-bot2>
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

Commit-ID:     f78f96676a256d7fa171a54b271a2ad2c6555c9c
Gitweb:        https://git.kernel.org/tip/f78f96676a256d7fa171a54b271a2ad2c6555c9c
Author:        Kyle Meyer <meyerk@hpe.com>
AuthorDate:    Tue, 27 Aug 2019 16:43:47 -05:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 17:38:32 -03:00

perf svghelper: Replace MAX_NR_CPUS with perf_env::nr_cpus_online

'nr_cpus', the number of CPUs online during a record session bound by
MAX_NR_CPUS, can be used as a dynamic alternative for MAX_NR_CPUS in
svg_build_topology_map().

The value of nr_cpus can be passed into str_to_bitmap(),
scan_core_topology(), and svg_build_topology_map() to replace
MAX_NR_CPUS as well.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russ Anderson <russ.anderson@hpe.com>
Link: http://lore.kernel.org/lkml/20190827214352.94272-3-meyerk@stormcage.eag.rdlabs.hpecorp.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/svghelper.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 2e99715..fef0f8a 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -697,7 +697,8 @@ struct topology {
 	int sib_thr_nr;
 };
 
-static void scan_thread_topology(int *map, struct topology *t, int cpu, int *pos)
+static void scan_thread_topology(int *map, struct topology *t, int cpu,
+				 int *pos, int nr_cpus)
 {
 	int i;
 	int thr;
@@ -706,28 +707,24 @@ static void scan_thread_topology(int *map, struct topology *t, int cpu, int *pos
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
@@ -740,7 +737,7 @@ static int str_to_bitmap(char *s, cpumask_t *b)
 
 	for (i = 0; i < m->nr; i++) {
 		c = m->map[i];
-		if (c >= MAX_NR_CPUS) {
+		if (c >= nr_cpus) {
 			ret = -1;
 			break;
 		}
@@ -755,10 +752,12 @@ static int str_to_bitmap(char *s, cpumask_t *b)
 
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
@@ -773,7 +772,7 @@ int svg_build_topology_map(struct perf_env *env)
 	}
 
 	for (i = 0; i < env->nr_sibling_cores; i++) {
-		if (str_to_bitmap(sib_core, &t.sib_core[i])) {
+		if (str_to_bitmap(sib_core, &t.sib_core[i], nr_cpus)) {
 			fprintf(stderr, "topology: can't parse siblings map\n");
 			goto exit;
 		}
@@ -782,7 +781,7 @@ int svg_build_topology_map(struct perf_env *env)
 	}
 
 	for (i = 0; i < env->nr_sibling_threads; i++) {
-		if (str_to_bitmap(sib_thr, &t.sib_thr[i])) {
+		if (str_to_bitmap(sib_thr, &t.sib_thr[i], nr_cpus)) {
 			fprintf(stderr, "topology: can't parse siblings map\n");
 			goto exit;
 		}
@@ -790,16 +789,16 @@ int svg_build_topology_map(struct perf_env *env)
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
 
