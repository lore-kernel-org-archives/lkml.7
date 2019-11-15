Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0633DC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2392077B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfKOMnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:43:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:58938 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727746AbfKOMnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:43:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 04:43:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="257749707"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.197])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2019 04:43:40 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] perf intel-pt: Add support for recording AUX area samples
Date:   Fri, 15 Nov 2019 14:42:23 +0200
Message-Id: <20191115124225.5247-14-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115124225.5247-1-adrian.hunter@intel.com>
References: <20191115124225.5247-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set up the default number of mmap pages, default sample size and default
psb_period for AUX area sampling. Add documentation also.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/intel-pt.txt | 59 ++++++++++++++++++-
 tools/perf/arch/x86/util/auxtrace.c   |  2 +
 tools/perf/arch/x86/util/intel-pt.c   | 81 ++++++++++++++++++++++++++-
 3 files changed, 139 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/intel-pt.txt b/tools/perf/Documentation/intel-pt.txt
index e0d9e7dd4f17..2cf2d9e9d0da 100644
--- a/tools/perf/Documentation/intel-pt.txt
+++ b/tools/perf/Documentation/intel-pt.txt
@@ -434,6 +434,56 @@ pwr_evt		Enable power events.  The power events provide information about
 		"0" otherwise.
 
 
+AUX area sampling option
+------------------------
+
+To select Intel PT "sampling" the AUX area sampling option can be used:
+
+	--aux-sample
+
+Optionally it can be followed by the sample size in bytes e.g.
+
+	--aux-sample=8192
+
+In addition, the Intel PT event to sample must be defined e.g.
+
+	-e intel_pt//u
+
+Samples on other events will be created containing Intel PT data e.g. the
+following will create Intel PT samples on the branch-misses event, note the
+events must be grouped using {}:
+
+	perf record --aux-sample -e '{intel_pt//u,branch-misses:u}'
+
+An alternative to '--aux-sample' is to add the config term 'aux-sample-size' to
+events.  In this case, the grouping is implied e.g.
+
+	perf record -e intel_pt//u -e branch-misses/aux-sample-size=8192/u
+
+is the same as:
+
+	perf record -e '{intel_pt//u,branch-misses/aux-sample-size=8192/u}'
+
+but allows for also using an address filter e.g.:
+
+	perf record -e intel_pt//u --filter 'filter * @/bin/ls' -e branch-misses/aux-sample-size=8192/u -- ls
+
+It is important to select a sample size that is big enough to contain at least
+one PSB packet.  If not a warning will be displayed:
+
+	Intel PT sample size (%zu) may be too small for PSB period (%zu)
+
+The calculation used for that is: if sample_size <= psb_period + 256 display the
+warning.  When sampling is used, psb_period defaults to 0 (2KiB).
+
+The default sample size is 4KiB.
+
+The sample size is passed in aux_sample_size in struct perf_event_attr.  The
+sample size is limited by the maximum event size which is 64KiB.  It is
+difficult to know how big the event might be without the trace sample attached,
+but the tool validates that the sample size is not greater than 60KiB.
+
+
 new snapshot option
 -------------------
 
@@ -487,8 +537,8 @@ their mlock limit (which defaults to 64KiB but is not multiplied by the number
 of cpus).
 
 In full-trace mode, powers of two are allowed for buffer size, with a minimum
-size of 2 pages.  In snapshot mode, it is the same but the minimum size is
-1 page.
+size of 2 pages.  In snapshot mode or sampling mode, it is the same but the
+minimum size is 1 page.
 
 The mmap size and auxtrace mmap size are displayed if the -vv option is used e.g.
 
@@ -501,12 +551,17 @@ Intel PT modes of operation
 
 Intel PT can be used in 2 modes:
 	full-trace mode
+	sample mode
 	snapshot mode
 
 Full-trace mode traces continuously e.g.
 
 	perf record -e intel_pt//u uname
 
+Sample mode attaches a Intel PT sample to other events e.g.
+
+	perf record --aux-sample -e intel_pt//u -e branch-misses:u
+
 Snapshot mode captures the available data when a signal is sent e.g.
 
 	perf record -v -e intel_pt//u -S ./loopy 1000000000 &
diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
index 96f4a2c11893..092543cad324 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -26,6 +26,8 @@ struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
 	bool found_bts = false;
 
 	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
+	if (intel_pt_pmu)
+		intel_pt_pmu->auxtrace = true;
 	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
 
 	evlist__for_each_entry(evlist, evsel) {
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index d6d26256915f..20df442fdf36 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -17,6 +17,7 @@
 #include "../../util/event.h"
 #include "../../util/evlist.h"
 #include "../../util/evsel.h"
+#include "../../util/evsel_config.h"
 #include "../../util/cpumap.h"
 #include "../../util/mmap.h"
 #include <subcmd/parse-options.h>
@@ -551,6 +552,43 @@ static int intel_pt_validate_config(struct perf_pmu *intel_pt_pmu,
 					evsel->core.attr.config);
 }
 
+static void intel_pt_config_sample_mode(struct perf_pmu *intel_pt_pmu,
+					struct evsel *evsel)
+{
+	struct perf_evsel_config_term *term;
+	u64 user_bits = 0, bits;
+
+	term = perf_evsel__get_config_term(evsel, CFG_CHG);
+	if (term)
+		user_bits = term->val.cfg_chg;
+
+	bits = perf_pmu__format_bits(&intel_pt_pmu->format, "psb_period");
+
+	/* Did user change psb_period */
+	if (bits & user_bits)
+		return;
+
+	/* Set psb_period to 0 */
+	evsel->core.attr.config &= ~bits;
+}
+
+static void intel_pt_min_max_sample_sz(struct evlist *evlist,
+				       size_t *min_sz, size_t *max_sz)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		size_t sz = evsel->core.attr.aux_sample_size;
+
+		if (!sz)
+			continue;
+		if (min_sz && (sz < *min_sz || !*min_sz))
+			*min_sz = sz;
+		if (max_sz && sz > *max_sz)
+			*max_sz = sz;
+	}
+}
+
 /*
  * Currently, there is not enough information to disambiguate different PEBS
  * events, so only allow one.
@@ -606,6 +644,11 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		return -EINVAL;
 	}
 
+	if (opts->auxtrace_snapshot_mode && opts->auxtrace_sample_mode) {
+		pr_err("Snapshot mode (" INTEL_PT_PMU_NAME " PMU) and sample trace cannot be used together\n");
+		return -EINVAL;
+	}
+
 	if (opts->use_clockid) {
 		pr_err("Cannot use clockid (-k option) with " INTEL_PT_PMU_NAME "\n");
 		return -EINVAL;
@@ -617,6 +660,9 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	if (!opts->full_auxtrace)
 		return 0;
 
+	if (opts->auxtrace_sample_mode)
+		intel_pt_config_sample_mode(intel_pt_pmu, intel_pt_evsel);
+
 	err = intel_pt_validate_config(intel_pt_pmu, intel_pt_evsel);
 	if (err)
 		return err;
@@ -666,6 +712,34 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 				    opts->auxtrace_snapshot_size, psb_period);
 	}
 
+	/* Set default sizes for sample mode */
+	if (opts->auxtrace_sample_mode) {
+		size_t psb_period = intel_pt_psb_period(intel_pt_pmu, evlist);
+		size_t min_sz = 0, max_sz = 0;
+
+		intel_pt_min_max_sample_sz(evlist, &min_sz, &max_sz);
+		if (!opts->auxtrace_mmap_pages && !privileged &&
+		    opts->mmap_pages == UINT_MAX)
+			opts->mmap_pages = KiB(256) / page_size;
+		if (!opts->auxtrace_mmap_pages) {
+			size_t sz = round_up(max_sz, page_size) / page_size;
+
+			opts->auxtrace_mmap_pages = roundup_pow_of_two(sz);
+		}
+		if (max_sz > opts->auxtrace_mmap_pages * (size_t)page_size) {
+			pr_err("Sample size %zu must not be greater than AUX area tracing mmap size %zu\n",
+			       max_sz,
+			       opts->auxtrace_mmap_pages * (size_t)page_size);
+			return -EINVAL;
+		}
+		pr_debug2("Intel PT min. sample size: %zu max. sample size: %zu\n",
+			  min_sz, max_sz);
+		if (psb_period &&
+		    min_sz <= psb_period + INTEL_PT_PSB_PERIOD_NEAR)
+			ui__warning("Intel PT sample size (%zu) may be too small for PSB period (%zu)\n",
+				    min_sz, psb_period);
+	}
+
 	/* Set default sizes for full trace mode */
 	if (opts->full_auxtrace && !opts->auxtrace_mmap_pages) {
 		if (privileged) {
@@ -682,7 +756,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		size_t sz = opts->auxtrace_mmap_pages * (size_t)page_size;
 		size_t min_sz;
 
-		if (opts->auxtrace_snapshot_mode)
+		if (opts->auxtrace_snapshot_mode || opts->auxtrace_sample_mode)
 			min_sz = KiB(4);
 		else
 			min_sz = KiB(8);
@@ -1136,5 +1210,10 @@ struct auxtrace_record *intel_pt_recording_init(int *err)
 	ptr->itr.parse_snapshot_options = intel_pt_parse_snapshot_options;
 	ptr->itr.reference = intel_pt_reference;
 	ptr->itr.read_finish = intel_pt_read_finish;
+	/*
+	 * Decoding starts at a PSB packet. Minimum PSB period is 2K so 4K
+	 * should give at least 1 PSB per sample.
+	 */
+	ptr->itr.default_aux_sample_size = 4096;
 	return &ptr->itr;
 }
-- 
2.17.1

