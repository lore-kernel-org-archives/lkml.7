Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA8EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D4620728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfKOMn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:43:28 -0500
Received: from mga14.intel.com ([192.55.52.115]:58938 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbfKOMn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:43:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 04:43:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="257749655"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.197])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2019 04:43:24 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] perf tools: Add AUX area sample parsing
Date:   Fri, 15 Nov 2019 14:42:12 +0200
Message-Id: <20191115124225.5247-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115124225.5247-1-adrian.hunter@intel.com>
References: <20191115124225.5247-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for parsing samples containing AUX area data
i.e. PERF_SAMPLE_AUX.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/sample-parsing.c         | 16 +++++++++++++++-
 tools/perf/util/event.h                   |  6 ++++++
 tools/perf/util/evsel.c                   | 13 +++++++++++++
 tools/perf/util/perf_event_attr_fprintf.c |  2 +-
 tools/perf/util/synthetic-events.c        | 12 ++++++++++++
 5 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 3a02426db9a6..2762e1155238 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -150,6 +150,15 @@ static bool samples_same(const struct perf_sample *s1,
 	if (type & PERF_SAMPLE_PHYS_ADDR)
 		COMP(phys_addr);
 
+	if (type & PERF_SAMPLE_AUX) {
+		COMP(aux_sample.size);
+		if (memcmp(s1->aux_sample.data, s2->aux_sample.data,
+			   s1->aux_sample.size)) {
+			pr_debug("Samples differ at 'aux_sample'\n");
+			return false;
+		}
+	}
+
 	return true;
 }
 
@@ -182,6 +191,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 	u64 regs[64];
 	const u64 raw_data[] = {0x123456780a0b0c0dULL, 0x1102030405060708ULL};
 	const u64 data[] = {0x2211443366558877ULL, 0, 0xaabbccddeeff4321ULL};
+	const u64 aux_data[] = {0xa55a, 0, 0xeeddee, 0x0282028202820282};
 	struct perf_sample sample = {
 		.ip		= 101,
 		.pid		= 102,
@@ -218,6 +228,10 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 			.regs	= regs,
 		},
 		.phys_addr	= 113,
+		.aux_sample	= {
+			.size	= sizeof(aux_data),
+			.data	= (void *)aux_data,
+		},
 	};
 	struct sample_read_value values[] = {{1, 5}, {9, 3}, {2, 7}, {6, 4},};
 	struct perf_sample sample_out;
@@ -317,7 +331,7 @@ int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_u
 	 * were added.  Please actually update the test rather than just change
 	 * the condition below.
 	 */
-	if (PERF_SAMPLE_MAX > PERF_SAMPLE_PHYS_ADDR << 1) {
+	if (PERF_SAMPLE_MAX > PERF_SAMPLE_AUX << 1) {
 		pr_debug("sample format has changed, some new PERF_SAMPLE_ bit was introduced - test needs updating\n");
 		return -1;
 	}
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index a0a0c91cde4a..85223159737c 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -114,6 +114,11 @@ enum {
 
 #define MAX_INSN 16
 
+struct aux_sample {
+	u64 size;
+	void *data;
+};
+
 struct perf_sample {
 	u64 ip;
 	u32 pid, tid;
@@ -142,6 +147,7 @@ struct perf_sample {
 	struct regs_dump  intr_regs;
 	struct stack_dump user_stack;
 	struct sample_read read;
+	struct aux_sample aux_sample;
 };
 
 #define PERF_MEM_DATA_SRC_NONE \
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1bf60f325608..772f4879c492 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2209,6 +2209,19 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array++;
 	}
 
+	if (type & PERF_SAMPLE_AUX) {
+		OVERFLOW_CHECK_u64(array);
+		sz = *array++;
+
+		OVERFLOW_CHECK(array, sz, max_size);
+		/* Undo swap of data */
+		if (swapped)
+			mem_bswap_64((char *)array, sz);
+		data->aux_sample.size = sz;
+		data->aux_sample.data = (char *)array;
+		array = (void *)array + sz;
+	}
+
 	return 0;
 }
 
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 06add607e72d..651203126c71 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -34,7 +34,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
 		bit_name(PERIOD), bit_name(STREAM_ID), bit_name(RAW),
 		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
 		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
-		bit_name(WEIGHT), bit_name(PHYS_ADDR),
+		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(AUX),
 		{ .name = NULL, }
 	};
 #undef bit_name
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index cfa3c9f67141..48c3f8b9c852 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1228,6 +1228,11 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_PHYS_ADDR)
 		result += sizeof(u64);
 
+	if (type & PERF_SAMPLE_AUX) {
+		result += sizeof(u64);
+		result += sample->aux_sample.size;
+	}
+
 	return result;
 }
 
@@ -1396,6 +1401,13 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 		array++;
 	}
 
+	if (type & PERF_SAMPLE_AUX) {
+		sz = sample->aux_sample.size;
+		*array++ = sz;
+		memcpy(array, sample->aux_sample.data, sz);
+		array = (void *)array + sz;
+	}
+
 	return 0;
 }
 
-- 
2.17.1

