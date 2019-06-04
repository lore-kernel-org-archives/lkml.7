Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF44C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC1720679
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfFDNBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:01:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:5100 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfFDNBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:01:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 06:01:51 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2019 06:01:49 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/19] perf auxtrace: Add perf time interval to itrace_synth_ops
Date:   Tue,  4 Jun 2019 15:59:59 +0300
Message-Id: <20190604130017.31207-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604130017.31207-1-adrian.hunter@intel.com>
References: <20190604130017.31207-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instruction trace decoders can optimize output based on what time intervals
will be filtered, so pass that information in itrace_synth_ops.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index c69bcd9a3091..c80c58eb7f4d 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -83,6 +83,8 @@ enum itrace_period_type {
  * @period_type: 'instructions' events period type
  * @initial_skip: skip N events at the beginning.
  * @cpu_bitmap: CPUs for which to synthesize events, or NULL for all
+ * @ptime_range: time intervals to trace or NULL
+ * @range_num: number of time intervals to trace
  */
 struct itrace_synth_opts {
 	bool			set;
@@ -107,6 +109,8 @@ struct itrace_synth_opts {
 	enum itrace_period_type	period_type;
 	unsigned long		initial_skip;
 	unsigned long		*cpu_bitmap;
+	struct perf_time_interval *ptime_range;
+	int			range_num;
 };
 
 /**
@@ -599,6 +603,21 @@ static inline void auxtrace__free(struct perf_session *session)
 "				PERIOD[ns|us|ms|i|t]:   specify period to sample stream\n" \
 "				concatenate multiple options. Default is ibxwpe or cewp\n"
 
+static inline
+void itrace_synth_opts__set_time_range(struct itrace_synth_opts *opts,
+				       struct perf_time_interval *ptime_range,
+				       int range_num)
+{
+	opts->ptime_range = ptime_range;
+	opts->range_num = range_num;
+}
+
+static inline
+void itrace_synth_opts__clear_time_range(struct itrace_synth_opts *opts)
+{
+	opts->ptime_range = NULL;
+	opts->range_num = 0;
+}
 
 #else
 
@@ -742,6 +761,21 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
 
 #define ITRACE_HELP ""
 
+static inline
+void itrace_synth_opts__set_time_range(struct itrace_synth_opts *opts
+				       __maybe_unused,
+				       struct perf_time_interval *ptime_range
+				       __maybe_unused,
+				       int range_num __maybe_unused)
+{
+}
+
+static inline
+void itrace_synth_opts__clear_time_range(struct itrace_synth_opts *opts
+					 __maybe_unused)
+{
+}
+
 #endif
 
 #endif
-- 
2.17.1

