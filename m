Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6E2C4646D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF550217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279944;
	bh=EuKMviOyObXq+UYRuWgfqDPJZP3aGH7U3hpkhZb0hRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vt/04Yw02thpxMQLNhTdIDs+CA7CmvGbljyGKk1bNjPtgbG0rLzjajgCJCRtWtCr3
	 iubv5jJVUqkYGOT5glYsS+PwPjeMkrXEiOK7M5D7uYMw6OWgRxc+qD54/weaDEtGQj
	 dFDDIk4bd0LMEsKju4f7PHhCFcWchJatSWX5LUeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392569AbfFKTDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388229AbfFKTDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:03:36 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACEFF21841;
        Tue, 11 Jun 2019 19:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279815;
        bh=EuKMviOyObXq+UYRuWgfqDPJZP3aGH7U3hpkhZb0hRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MJD9knhmVGZwElgLhQYFiN9n7OgZJZJKnSkjh/PyzGMXZnnTr8ng9kXMTOeuOzKTW
         MSSnaPJK59p4N20VcvGgI/v6s8AMHn+39T02mZIFZT1ILhmIJFyM2716FYEPQSwR4K
         miKfHlXCj+PSVegcq+4hd9SG6qgFCAyHyZa33r0U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 58/85] perf tools: Apply new CPU topology sysfs attributes
Date:   Tue, 11 Jun 2019 15:58:44 -0300
Message-Id: <20190611185911.11645-59-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The existing "thread_siblings" and "thread_siblings_list" attribute will
be deprecated.

Use the new CPU topology sysfs attributes, "core_cpus" and
"core_cpus_list", which are synonymous with the deprecated attributes.

Check the new name first. If not available, use the deprecated name to
be compatible with old kernel.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1559688644-106558-5-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cputopo.c | 8 +++++++-
 tools/perf/util/smt.c     | 8 ++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 85fa87fc30cf..26e73a4bd4fe 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -15,6 +15,8 @@
 	"%s/devices/system/cpu/cpu%d/topology/die_cpus_list"
 #define THRD_SIB_FMT \
 	"%s/devices/system/cpu/cpu%d/topology/thread_siblings_list"
+#define THRD_SIB_FMT_NEW \
+	"%s/devices/system/cpu/cpu%d/topology/core_cpus_list"
 #define NODE_ONLINE_FMT \
 	"%s/devices/system/node/online"
 #define NODE_MEMINFO_FMT \
@@ -91,8 +93,12 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
 	ret = 0;
 
 try_threads:
-	scnprintf(filename, MAXPATHLEN, THRD_SIB_FMT,
+	scnprintf(filename, MAXPATHLEN, THRD_SIB_FMT_NEW,
 		  sysfs__mountpoint(), cpu);
+	if (access(filename, F_OK) == -1) {
+		scnprintf(filename, MAXPATHLEN, THRD_SIB_FMT,
+			  sysfs__mountpoint(), cpu);
+	}
 	fp = fopen(filename, "r");
 	if (!fp)
 		goto done;
diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 453f6f6f29f3..3b791ef2cd50 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -23,8 +23,12 @@ int smt_on(void)
 		char fn[256];
 
 		snprintf(fn, sizeof fn,
-			"devices/system/cpu/cpu%d/topology/thread_siblings",
-			cpu);
+			"devices/system/cpu/cpu%d/topology/core_cpus", cpu);
+		if (access(fn, F_OK) == -1) {
+			snprintf(fn, sizeof fn,
+				"devices/system/cpu/cpu%d/topology/thread_siblings",
+				cpu);
+		}
 		if (sysfs__read_str(fn, &str, &strlen) < 0)
 			continue;
 		/* Entry is hex, but does not have 0x, so need custom parser */
-- 
2.20.1

