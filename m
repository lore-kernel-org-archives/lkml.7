Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84435C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B61624676
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576529291;
	bh=6z9EXVYxPD5AE487b0KhkyHjAyb52S1bb/qTHoIucDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P04qeTp3tFfdXeRcpT41T3cwG1Ic/5GVla4TUAzfVvPG21f/LoZ51TxNafGCZSRDS
	 v+sU6ZHgK7nV+D8S3DaINrqjbbVhZrr1KTBSrtBjhQG/1r36iaCLt7FFYmlMNRCZf2
	 5xof7KFgyq//kcEy7oYMgQXGGY3/1j1meN/mW6/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfLPUsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:48:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbfLPUsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:48:08 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E23D424650;
        Mon, 16 Dec 2019 20:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576529287;
        bh=6z9EXVYxPD5AE487b0KhkyHjAyb52S1bb/qTHoIucDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E1mO8soxEp7hxSs+YytPfb6wQ8KKpiEaHj4pplsOiXUiqPB726F2GhFnGNjlnvhZE
         YEVDJTd5jjxD3RMK4WlhS6WM3hICLbx9qZnHbcd9bk64RvSJJ8uK01XDFZFngsWsNI
         K9yBXSIBJmFgnshyNSj6EmoZbW5Vy6PcbUuOIbrM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Michael Petlan <mpetlan@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6/9] perf header: Fix false warning when there are no duplicate cache entries
Date:   Mon, 16 Dec 2019 17:47:35 -0300
Message-Id: <20191216204738.12107-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191216204738.12107-1-acme@kernel.org>
References: <20191216204738.12107-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Petlan <mpetlan@redhat.com>

Before this patch, perf expected that there might be NPROC*4 unique
cache entries at max, however, it also expected that some of them would
be shared and/or of the same size, thus the final number of entries
would be reduced to be lower than NPROC*4. In case the number of entries
hadn't been reduced (was NPROC*4), the warning was printed.

However, some systems might have unusual cache topology, such as the
following two-processor KVM guest:

	cpu  level  shared_cpu_list  size
	  0     1         0           32K
	  0     1         0           64K
	  0     2         0           512K
	  0     3         0           8192K
	  1     1         1           32K
	  1     1         1           64K
	  1     2         1           512K
	  1     3         1           8192K

This KVM guest has 8 (NPROC*4) unique cache entries, which used to make
perf printing the message, although there actually aren't "way too many
cpu caches".

v2: Removing unused argument.

v3: Unifying the way we obtain number of cpus.

v4: Removed '& UINT_MAX' construct which is redundant.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
LPU-Reference: 20191208162056.20772-1-mpetlan@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4d39a75551a0..93ad27830e2b 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1089,21 +1089,18 @@ static void cpu_cache_level__fprintf(FILE *out, struct cpu_cache_level *c)
 	fprintf(out, "L%d %-15s %8s [%s]\n", c->level, c->type, c->size, c->map);
 }
 
-static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
+#define MAX_CACHE_LVL 4
+
+static int build_caches(struct cpu_cache_level caches[], u32 *cntp)
 {
 	u32 i, cnt = 0;
-	long ncpus;
 	u32 nr, cpu;
 	u16 level;
 
-	ncpus = sysconf(_SC_NPROCESSORS_CONF);
-	if (ncpus < 0)
-		return -1;
-
-	nr = (u32)(ncpus & UINT_MAX);
+	nr = cpu__max_cpu();
 
 	for (cpu = 0; cpu < nr; cpu++) {
-		for (level = 0; level < 10; level++) {
+		for (level = 0; level < MAX_CACHE_LVL; level++) {
 			struct cpu_cache_level c;
 			int err;
 
@@ -1123,18 +1120,12 @@ static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
 				caches[cnt++] = c;
 			else
 				cpu_cache_level__free(&c);
-
-			if (WARN_ONCE(cnt == size, "way too many cpu caches.."))
-				goto out;
 		}
 	}
- out:
 	*cntp = cnt;
 	return 0;
 }
 
-#define MAX_CACHE_LVL 4
-
 static int write_cache(struct feat_fd *ff,
 		       struct evlist *evlist __maybe_unused)
 {
@@ -1143,7 +1134,7 @@ static int write_cache(struct feat_fd *ff,
 	u32 cnt = 0, i, version = 1;
 	int ret;
 
-	ret = build_caches(caches, max_caches, &cnt);
+	ret = build_caches(caches, &cnt);
 	if (ret)
 		goto out;
 
-- 
2.21.0

