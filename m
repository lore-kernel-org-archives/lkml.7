Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023D4C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC60D21882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153574;
	bh=GW9DDPUhIS2WomVrJzb6KTKqKcdBgfn6Vbhsyfh2J7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FIpQtyTc0ho4xSDYYD1s0y8FHyRwT2Z9ZxPB6C6rPiT73vjnz9A5gCI9dSIySyINp
	 RDpz0lNNp1ocHvStsI5a+fDdwBc6PWoPe8/bSHExVDCQT9hYCm9DdK/RSZ/WHoEDMo
	 DE1egGKVfL5INUHVBbO9Y20YgpOe9Bm0oakES544=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfKGTGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:06:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:44546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbfKGTGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:06:13 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A402121D7B;
        Thu,  7 Nov 2019 19:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153572;
        bh=GW9DDPUhIS2WomVrJzb6KTKqKcdBgfn6Vbhsyfh2J7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uwtta9L4+pGqjZtcDPjHW9e9t/CniTJCSsBh49cfKF2FTLjgZI3MMD8mWteRxokmf
         NExFQ6pSXtXmdQ3+2ZvIHapHgYdMLZi3XUrarrJwDhrCXYqxst3IstFC5Dyc/MJ9bs
         NHuQ9Xnu82iIIjhIlwitaq5twk37C3VLd0WIjsEs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 37/63] perf env: Add perf_env__numa_node()
Date:   Thu,  7 Nov 2019 15:59:45 -0300
Message-Id: <20191107190011.23924-38-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
index 2a91a10ccfcc..6242a9215df7 100644
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
index a3059dc1abe5..11d05ae3606a 100644
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
-- 
2.21.0

