Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116FCC17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65EF2246F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfKLLVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:21:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33729 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfKLLSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:16 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBQ-0000Qp-Rd; Tue, 12 Nov 2019 12:18:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B7B9E1C04CB;
        Tue, 12 Nov 2019 12:18:00 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:00 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf env: Add perf_env__numa_node()
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190904073415.723-3-jolsa@kernel.org>
References: <20190904073415.723-3-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157355748043.29376.17683018661132241456.tip-bot2@tip-bot2>
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

Commit-ID:     389799a7a1e86c55f38897e679762efadcc9dedd
Gitweb:        https://git.kernel.org/tip/389799a7a1e86c55f38897e679762efadcc9dedd
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Thu, 29 Aug 2019 13:31:48 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:49:39 -03:00

perf env: Add perf_env__numa_node()

To speed up cpu to node lookup, add perf_env__numa_node(), that creates
cpu array on the first lookup, that holds numa nodes for each stored
cpu.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20190904073415.723-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/env.c | 40 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/env.h |  6 ++++++
 2 files changed, 46 insertions(+)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 2a91a10..6242a92 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -180,6 +180,7 @@ void perf_env__exit(struct perf_env *env)
 	zfree(&env->sibling_threads);
 	zfree(&env->pmu_mappings);
 	zfree(&env->cpu);
+	zfree(&env->numa_map);
 
 	for (i = 0; i < env->nr_numa_nodes; i++)
 		perf_cpu_map__put(env->numa_nodes[i].map);
@@ -354,3 +355,42 @@ const char *perf_env__arch(struct perf_env *env)
 
 	return normalize_arch(arch_name);
 }
+
+
+int perf_env__numa_node(struct perf_env *env, int cpu)
+{
+	if (!env->nr_numa_map) {
+		struct numa_node *nn;
+		int i, nr = 0;
+
+		for (i = 0; i < env->nr_numa_nodes; i++) {
+			nn = &env->numa_nodes[i];
+			nr = max(nr, perf_cpu_map__max(nn->map));
+		}
+
+		nr++;
+
+		/*
+		 * We initialize the numa_map array to prepare
+		 * it for missing cpus, which return node -1
+		 */
+		env->numa_map = malloc(nr * sizeof(int));
+		if (!env->numa_map)
+			return -1;
+
+		for (i = 0; i < nr; i++)
+			env->numa_map[i] = -1;
+
+		env->nr_numa_map = nr;
+
+		for (i = 0; i < env->nr_numa_nodes; i++) {
+			int tmp, j;
+
+			nn = &env->numa_nodes[i];
+			perf_cpu_map__for_each_cpu(j, tmp, nn->map)
+				env->numa_map[j] = i;
+		}
+	}
+
+	return cpu >= 0 && cpu < env->nr_numa_map ? env->numa_map[cpu] : -1;
+}
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index a3059dc..11d05ae 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -87,6 +87,10 @@ struct perf_env {
 		struct rb_root		btfs;
 		u32			btfs_cnt;
 	} bpf_progs;
+
+	/* For fast cpu to numa node lookup via perf_env__numa_node */
+	int			*numa_map;
+	int			 nr_numa_map;
 };
 
 enum perf_compress_type {
@@ -120,4 +124,6 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 							__u32 prog_id);
 void perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
 struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
+
+int perf_env__numa_node(struct perf_env *env, int cpu);
 #endif /* __PERF_ENV_H */
