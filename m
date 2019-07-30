Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62275C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F72720679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FrFrCcd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388524AbfG3S5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:57:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39131 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388084AbfG3S5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:57:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIv4gZ3337057
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:57:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIv4gZ3337057
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564513025;
        bh=qYRLRka48z7/vFG6fVo+uZFiXMXhdERbN7DLu42o3XE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=FrFrCcd7NwbeLSL2ZiktahiudbZ/dgMZSNb+e1LzVUKrovIz4qUAWCJClWsJDh5Be
         JitWz15/NSq9u9KMkQ2omprk/sD17V60KRafpg1+Tj3+iPrcsV+d/JJkcPjHkjhryX
         tWrEhe1m5EwAmLnjo1JuRQU7b76I/tCGH3KJnnrc/rOHZ7FW4FAmeugKY15sCbVZr6
         dZ81bYLfTHkBqdkUs7E9LExPTI+DYgSFNlJ862VeseQ2UPPWcfnEPY5JljfN24OkE0
         TxGM09rzjgweDdfofrmnO/juqQjpT6R1KA0dI5khczAs4moaaNIDl7cM87Gi2bW3iw
         ZmKbILso2hg1w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIv4Hn3337001;
        Tue, 30 Jul 2019 11:57:04 -0700
Date:   Tue, 30 Jul 2019 11:57:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-09145d26b608e886415396e9277ae08f0617d21b@git.kernel.org>
Cc:     tglx@linutronix.de, jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, mpetlan@redhat.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        alexey.budankov@linux.intel.com, peterz@infradead.org,
        acme@redhat.com, ak@linux.intel.com
Reply-To: tglx@linutronix.de, jolsa@kernel.org, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          mpetlan@redhat.com, alexander.shishkin@linux.intel.com,
          hpa@zytor.com, alexey.budankov@linux.intel.com,
          peterz@infradead.org, acme@redhat.com, ak@linux.intel.com
In-Reply-To: <20190721112506.12306-67-jolsa@kernel.org>
References: <20190721112506.12306-67-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_cpu_map__for_each_cpu() macro
Git-Commit-ID: 09145d26b608e886415396e9277ae08f0617d21b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  09145d26b608e886415396e9277ae08f0617d21b
Gitweb:     https://git.kernel.org/tip/09145d26b608e886415396e9277ae08f0617d21b
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:53 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:46 -0300

libperf: Add perf_cpu_map__for_each_cpu() macro

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
@@ -224,3 +224,16 @@ invalid:
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
