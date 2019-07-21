Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052D1C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1812085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708734;
	bh=m06QlXuFCtftfHM8M0+SoBlLuhI+OyxKKFcJinSA6DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z2m2c0WIPrRsloCqyxlB33a+FoQaozKZLxLasVGgsL96nP+QWvSItuChMBGDKqOgc
	 paKU4KuDdUXEeoej5aB2GU0ryb7Aoc1vlOtU+n4IcmbujxNmC78vZtrKmUuDJjLttb
	 OV+R+PjofjsPpstohX1SQx3+M/ExYN0PmomT39vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfGULcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:32:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43788 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfGULcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:32:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0779308425C;
        Sun, 21 Jul 2019 11:32:11 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7E745D9D3;
        Sun, 21 Jul 2019 11:32:07 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 66/79] libperf: Add perf_cpu_map__for_each_cpu macro
Date:   Sun, 21 Jul 2019 13:24:53 +0200
Message-Id: <20190721112506.12306-67-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sun, 21 Jul 2019 11:32:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding following macro to libperf:
  perf_cpu_map__for_each_cpu

And its related functions:
  perf_cpu_map__cpu
  perf_cpu_map__nr

Link: http://lkml.kernel.org/n/tip-gi0e8h1qqrvh0enk43gp7d5g@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/cpumap.c              | 13 +++++++++++++
 tools/perf/lib/include/perf/cpumap.h |  7 +++++++
 tools/perf/lib/libperf.map           |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index a5d4f7ff7174..1ddb69e796e5 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -224,3 +224,16 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 out:
 	return cpus;
 }
+
+int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
+{
+	if (idx < cpus->nr)
+		return cpus->map[idx];
+
+	return -1;
+}
+
+int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
+{
+	return cpus ? cpus->nr : 1;
+}
diff --git a/tools/perf/lib/include/perf/cpumap.h b/tools/perf/lib/include/perf/cpumap.h
index b4a9283a5dfa..1b6e7db3fa2b 100644
--- a/tools/perf/lib/include/perf/cpumap.h
+++ b/tools/perf/lib/include/perf/cpumap.h
@@ -12,5 +12,12 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
 LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
+LIBPERF_API int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
+LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
+
+#define perf_cpu_map__for_each_cpu(cpu, idx, cpus)		\
+	for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);	\
+	     (idx) < perf_cpu_map__nr(cpus);			\
+	     (idx)++, (cpu) = perf_cpu_map__cpu(cpus, idx))
 
 #endif /* __LIBPERF_CPUMAP_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 5bd491ac1762..d4d34bea0b40 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -6,6 +6,8 @@ LIBPERF_0.0.1 {
 		perf_cpu_map__put;
 		perf_cpu_map__new;
 		perf_cpu_map__read;
+		perf_cpu_map__nr;
+		perf_cpu_map__cpu;
 		perf_thread_map__new_dummy;
 		perf_thread_map__set_pid;
 		perf_thread_map__comm;
-- 
2.21.0

