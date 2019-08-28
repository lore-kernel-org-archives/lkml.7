Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9D4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5115A22CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567000665;
	bh=mr75dRXUYaQnSrJyKiM/y8uvI65INP59M5pN6lv4X+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ukLRSZ/DimKK5pfp/GtW+ze8BLZ9gzQ+hMbOe/ECpm+N3FBmQC127N5Sc01/lQlEh
	 v7JN8pu0GJRogJ+eAsL1OWYMr4aoTXDNR9XTLzLu7TRIxpl/h5S22w56iy3g7Bz6h4
	 E44o0I3fm4npcjtk9/apptvMqgRSJl0fCArKWXH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfH1N5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:57:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbfH1N5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:57:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1FC88980E7;
        Wed, 28 Aug 2019 13:57:35 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AC551001B00;
        Wed, 28 Aug 2019 13:57:34 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 08/23] libperf: Add PERF_RECORD_AUXTRACE_INFO 'struct auxtrace_info_event' to perf/event.h
Date:   Wed, 28 Aug 2019 15:57:02 +0200
Message-Id: <20190828135717.7245-9-jolsa@kernel.org>
In-Reply-To: <20190828135717.7245-1-jolsa@kernel.org>
References: <20190828135717.7245-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Wed, 28 Aug 2019 13:57:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the PERF_RECORD_AUXTRACE_INFO event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Link: http://lkml.kernel.org/n/tip-794xxtrbjexwc0o0p2o79b1y@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/x86/util/intel-pt.c | 2 +-
 tools/perf/lib/include/perf/event.h | 7 +++++++
 tools/perf/util/arm-spe.c           | 2 +-
 tools/perf/util/event.h             | 7 -------
 tools/perf/util/intel-bts.c         | 2 +-
 tools/perf/util/intel-pt.c          | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 44cfe72c1a4c..d7125e331dda 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -327,7 +327,7 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 	unsigned long max_non_turbo_ratio;
 	size_t filter_str_len;
 	const char *filter;
-	u64 *info;
+	__u64 *info;
 	int err;
 
 	if (priv_size != ptr->priv_size)
diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index c68523c4fa01..02da73491451 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -201,4 +201,11 @@ struct id_index_event {
 	struct id_index_entry	 entries[0];
 };
 
+struct auxtrace_info_event {
+	struct perf_event_header header;
+	__u32			 type;
+	__u32			 reserved__; /* For alignment */
+	__u64			 priv[];
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index a314e5b26e9d..cd26315bc9aa 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -181,7 +181,7 @@ static const char * const arm_spe_info_fmts[] = {
 	[ARM_SPE_PMU_TYPE]		= "  PMU Type           %"PRId64"\n",
 };
 
-static void arm_spe_print_info(u64 *arr)
+static void arm_spe_print_info(__u64 *arr)
 {
 	if (!dump_trace)
 		return;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 82315d2845fe..ca2cae332c43 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -332,13 +332,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-struct auxtrace_info_event {
-	struct perf_event_header header;
-	u32 type;
-	u32 reserved__; /* For alignment */
-	u64 priv[];
-};
-
 struct auxtrace_event {
 	struct perf_event_header header;
 	u64 size;
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 8dc6408206b9..03c581a0d5d0 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -834,7 +834,7 @@ static const char * const intel_bts_info_fmts[] = {
 	[INTEL_BTS_SNAPSHOT_MODE]	= "  Snapshot mode      %"PRId64"\n",
 };
 
-static void intel_bts_print_info(u64 *arr, int start, int finish)
+static void intel_bts_print_info(__u64 *arr, int start, int finish)
 {
 	int i;
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index ea504fa9b623..c83a9a718c03 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3044,7 +3044,7 @@ static const char * const intel_pt_info_fmts[] = {
 	[INTEL_PT_FILTER_STR_LEN]	= "  Filter string len.  %"PRIu64"\n",
 };
 
-static void intel_pt_print_info(u64 *arr, int start, int finish)
+static void intel_pt_print_info(__u64 *arr, int start, int finish)
 {
 	int i;
 
@@ -3076,7 +3076,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	size_t min_sz = sizeof(u64) * INTEL_PT_PER_CPU_MMAPS;
 	struct intel_pt *pt;
 	void *info_end;
-	u64 *info;
+	__u64 *info;
 	int err;
 
 	if (auxtrace_info->header.size < sizeof(struct auxtrace_info_event) +
-- 
2.21.0

