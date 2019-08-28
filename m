Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D9CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C35222DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567000693;
	bh=JoIvGNR8rN58iFoPvIz4mbIGU27EXkLce0Wp4iJMcWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s8DjgmxjG13aPhtRkKEOyAMlbVthjchtkbUaUQSo7O46cM+QYeyE862ZyRe3YDM8/
	 jPdLMhz57BxWT61P9zaIdk1SoDte729p3s36c5K8p9nXS2L6Vj37Us4gB3hMwKkIg+
	 qGvWZ0yBRDir7rq/DxWUJNb/bUyPwFadlamhbYTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfH1N6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:58:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbfH1N6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:58:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BAC5D3695F;
        Wed, 28 Aug 2019 13:58:05 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B87C1001B0B;
        Wed, 28 Aug 2019 13:58:03 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 21/23] libperf: Add 'union perf_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:57:15 +0200
Message-Id: <20190828135717.7245-22-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 28 Aug 2019 13:58:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So it's available for libperf's users.

Link: http://lkml.kernel.org/n/tip-2b9e9f0y7szdwtgnyua58b88@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/include/perf/event.h | 36 +++++++++++++++++++++++++++++
 tools/perf/util/event.h             | 36 -----------------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index ef7a46e82a6d..a5b08ef118a7 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -323,4 +323,40 @@ struct compressed_event {
 	char			 data[];
 };
 
+union perf_event {
+	struct perf_event_header	header;
+	struct perf_record_mmap		mmap;
+	struct perf_record_mmap2	mmap2;
+	struct perf_record_comm		comm;
+	struct perf_record_namespaces	namespaces;
+	struct perf_record_fork		fork;
+	struct perf_record_lost		lost;
+	struct perf_record_lost_samples	lost_samples;
+	struct perf_record_read		read;
+	struct perf_record_throttle	throttle;
+	struct perf_record_sample	sample;
+	struct perf_record_bpf_event	bpf;
+	struct perf_record_ksymbol	ksymbol;
+	struct attr_event		attr;
+	struct event_update_event	event_update;
+	struct event_type_event		event_type;
+	struct tracing_data_event	tracing_data;
+	struct build_id_event		build_id;
+	struct id_index_event		id_index;
+	struct auxtrace_info_event	auxtrace_info;
+	struct auxtrace_event		auxtrace;
+	struct auxtrace_error_event	auxtrace_error;
+	struct aux_event		aux;
+	struct itrace_start_event	itrace_start;
+	struct context_switch_event	context_switch;
+	struct thread_map_event		thread_map;
+	struct cpu_map_event		cpu_map;
+	struct stat_config_event	stat_config;
+	struct stat_event		stat;
+	struct stat_round_event		stat_round;
+	struct time_conv_event		time_conv;
+	struct feature_event		feat;
+	struct compressed_event		pack;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index ee2ee23e4c46..e15eed53ce90 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,42 +337,6 @@ enum {
 	PERF_STAT_ROUND_TYPE__FINAL	= 1,
 };
 
-union perf_event {
-	struct perf_event_header	header;
-	struct perf_record_mmap		mmap;
-	struct perf_record_mmap2	mmap2;
-	struct perf_record_comm		comm;
-	struct perf_record_namespaces	namespaces;
-	struct perf_record_fork		fork;
-	struct perf_record_lost		lost;
-	struct perf_record_lost_samples	lost_samples;
-	struct perf_record_read		read;
-	struct perf_record_throttle	throttle;
-	struct perf_record_sample	sample;
-	struct perf_record_bpf_event	bpf;
-	struct perf_record_ksymbol	ksymbol;
-	struct attr_event		attr;
-	struct event_update_event	event_update;
-	struct event_type_event		event_type;
-	struct tracing_data_event	tracing_data;
-	struct build_id_event		build_id;
-	struct id_index_event		id_index;
-	struct auxtrace_info_event	auxtrace_info;
-	struct auxtrace_event		auxtrace;
-	struct auxtrace_error_event	auxtrace_error;
-	struct aux_event		aux;
-	struct itrace_start_event	itrace_start;
-	struct context_switch_event	context_switch;
-	struct thread_map_event		thread_map;
-	struct cpu_map_event		cpu_map;
-	struct stat_config_event	stat_config;
-	struct stat_event		stat;
-	struct stat_round_event		stat_round;
-	struct time_conv_event		time_conv;
-	struct feature_event		feat;
-	struct compressed_event		pack;
-};
-
 void perf_event__print_totals(void);
 
 struct perf_tool;
-- 
2.21.0

