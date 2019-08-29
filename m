Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FA9C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BC72166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfH2TDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:03:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51434 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbfH2TCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:02:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3PgC-00058l-LZ; Thu, 29 Aug 2019 21:01:56 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CBE9B1C07C3;
        Thu, 29 Aug 2019 21:01:54 +0200 (CEST)
Date:   Thu, 29 Aug 2019 19:01:54 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add PERF_RECORD_AUXTRACE_INFO 'struct
 auxtrace_info_event' to perf/event.h
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190828135717.7245-9-jolsa@kernel.org>
References: <20190828135717.7245-9-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156710531472.10564.7212248501250738285.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9a8dad0419552934573ddf94d11146faeda465b5
Gitweb:        https://git.kernel.org/tip/9a8dad0419552934573ddf94d11146faeda465b5
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Wed, 28 Aug 2019 15:57:02 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 08:34:52 -03:00

libperf: Add PERF_RECORD_AUXTRACE_INFO 'struct auxtrace_info_event' to perf/event.h

Move the PERF_RECORD_AUXTRACE_INFO event definition to libperf's
event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8' types used
events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-9-jolsa@kernel.org
[ Fix cs_etm__print_auxtrace_info() arg to be __u64 too to fix the CORESIGHT=1 build ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 2 +-
 tools/perf/lib/include/perf/event.h | 7 +++++++
 tools/perf/util/arm-spe.c           | 2 +-
 tools/perf/util/cs-etm.c            | 2 +-
 tools/perf/util/event.h             | 7 -------
 tools/perf/util/intel-bts.c         | 2 +-
 tools/perf/util/intel-pt.c          | 4 ++--
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 04b424a..89fe30d 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -328,7 +328,7 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 	unsigned long max_non_turbo_ratio;
 	size_t filter_str_len;
 	const char *filter;
-	u64 *info;
+	__u64 *info;
 	int err;
 
 	if (priv_size != ptr->priv_size)
diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index c68523c..02da734 100644
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
index a314e5b..cd26315 100644
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
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index b3a5daa..e210c1d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2370,7 +2370,7 @@ static const char * const cs_etmv4_priv_fmts[] = {
 	[CS_ETMV4_TRCAUTHSTATUS] = "	TRCAUTHSTATUS		       %llx\n",
 };
 
-static void cs_etm__print_auxtrace_info(u64 *val, int num)
+static void cs_etm__print_auxtrace_info(__u64 *val, int num)
 {
 	int i, j, cpu = 0;
 
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 82315d2..ca2cae3 100644
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
index 8dc6408..03c581a 100644
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
index ea504fa..c83a9a7 100644
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
