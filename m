Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C9BC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C81721744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567426390;
	bh=ypMpWERHZbezGaBo/amYRWWWs1YLorJtc+VOg4MnC30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XMU9h17Dxk68PtSmR6RGoo/dbBHP036f+rJ/tbna41R/Dikrd9a6b5eLjjlZDzrST
	 7LXAaqo8z1wNrHX6oHrXzBVUuMa4UuP7YuuSARmFD6bHTvqPJIFBlagkgm/gA/dOQX
	 cO4USXUj3mt8UJordIu1pWlFOtcDJ3udqI79OiPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbfIBMNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 08:13:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729658AbfIBMNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:13:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA2F383BDC;
        Mon,  2 Sep 2019 12:13:07 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89BB360C05;
        Mon,  2 Sep 2019 12:13:05 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/3] perf tools: Add perf_env__numa_node function
Date:   Mon,  2 Sep 2019 14:12:54 +0200
Message-Id: <20190902121255.536-3-jolsa@kernel.org>
In-Reply-To: <20190902121255.536-1-jolsa@kernel.org>
References: <20190902121255.536-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Mon, 02 Sep 2019 12:13:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To speed up cpu to node lookup, adding perf_env__numa_node
function, that creates cpu array on the first lookup, that
holds numa nodes for each stored cpu.

Link: http://lkml.kernel.org/n/tip-qqwxklhissf3yjyuaszh6480@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/env.c | 35 +++++++++++++++++++++++++++++++++++
 tools/perf/util/env.h |  6 ++++++
 2 files changed, 41 insertions(+)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 3baca06786fb..6385961e45df 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -179,6 +179,7 @@ void perf_env__exit(struct perf_env *env)
 	zfree(&env->sibling_threads);
 	zfree(&env->pmu_mappings);
 	zfree(&env->cpu);
+	zfree(&env->numa_map);
 
 	for (i = 0; i < env->nr_numa_nodes; i++)
 		perf_cpu_map__put(env->numa_nodes[i].map);
@@ -338,3 +339,37 @@ const char *perf_env__arch(struct perf_env *env)
 
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
+		env->numa_map = zalloc(nr * sizeof(int));
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
index d8e083d42610..777008f8007a 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -86,6 +86,10 @@ struct perf_env {
 		struct rb_root		btfs;
 		u32			btfs_cnt;
 	} bpf_progs;
+
+	/* For fast cpu to numa node lookup via perf_env__numa_node */
+	int			*numa_map;
+	int			 nr_numa_map;
 };
 
 enum perf_compress_type {
@@ -118,4 +122,6 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 							__u32 prog_id);
 void perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
 struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
+
+int perf_env__numa_node(struct perf_env *env, int cpu);
 #endif /* __PERF_ENV_H */
-- 
2.21.0

