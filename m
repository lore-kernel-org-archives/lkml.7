Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCE1C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3AA2343A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340637;
	bh=V8h3g+xyOa4KhhorQl3xHhkUdfwleAE01OpEUBxXQjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1RfmHpKGzntMhxwoaH+xfLASMHzX4G5a+289iwO4y2AOwaQ2QI99CcN34Wg2oCJp/
	 oVY6WuHPdo9HSwAMRCtfnHASdJFmbmSePgROdPzcQpLU2jB2KsoSIGAEVfoJfcjGvK
	 8BT/olHC6V3lUIPrGwiCttZAyiA5m/p5arE3JnNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfIAMXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfIAMXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:23:46 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 251EC23429;
        Sun,  1 Sep 2019 12:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340625;
        bh=V8h3g+xyOa4KhhorQl3xHhkUdfwleAE01OpEUBxXQjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n16j9EYj4qrxGeRC5eMkLyPHWxCC8sN8AvCzy9X8OyXxseOqOBG9oHPX4iF5A1R7R
         Euk2gx8xLsTuQOa+mCDjunjRRQbL5SKKC/NBA6JqqMVf5TvjnEUI9o/YrA/FrSCUsu
         cpsHtcN89q0i9O8Kbg8BZbnIPhlMVc6uJFrTCJ7I=
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
Subject: [PATCH 03/47] perf svghelper: Replace MAX_NR_CPUS with perf_env::nr_cpus_online
Date:   Sun,  1 Sep 2019 09:22:42 -0300
Message-Id: <20190901122326.5793-4-acme@kernel.org>
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
index 2e9971590590..fef0f8a40e2f 100644
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
 
-- 
2.21.0

