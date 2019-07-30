Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E81C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2452171F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455701;
	bh=qqBTyvUWAKFhwMY3ttnNvN7TT1zqzfYzDHdYk/1ayMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0gjOJLfx7AP5q99qhtnmvcKe4y7OjtlEysoOeXIK8Cf3YCBuQfo527j4ag0t0AIan
	 HLdNm9sfFGDsfu9WPPdhMsvdfwH62uSgEAqzrT8WwyQkt1h5LuaqzRDMn68H1THwPa
	 f19VmZUsMI2AxWpbnA/RYci96m3wDKSFelIf0UXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbfG3DBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732635AbfG3DBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:01:37 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68005208E3;
        Tue, 30 Jul 2019 03:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455696;
        bh=qqBTyvUWAKFhwMY3ttnNvN7TT1zqzfYzDHdYk/1ayMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HHK+++FnP5tlU2RFHrlRqRk3anhl03AUclf5JkcZkxRrQqG0ugeHp5Y+h3sNDAyWY
         O27F/nxBgXSv/Jmg/i/Cp7MQeDQSCO4TjKqT0n5ioaeucf2Qaz8s0iRPfKiaXKK3//
         TaVMbjFjbvlTMIATwOmxup5cgClHVYmagaZZSvlg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 093/107] libperf: Add perf_cpu_map__for_each_cpu() macro
Date:   Mon, 29 Jul 2019 23:55:56 -0300
Message-Id: <20190730025610.22603-94-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add the following macro to libperf:

  perf_cpu_map__for_each_cpu()

And its related functions:

  perf_cpu_map__cpu()
  perf_cpu_map__nr()

That will allow hiding how it is implemented.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-67-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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

