Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4073FC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF1424680
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfLTBiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 20:38:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:39282 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbfLTBiE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:38:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 17:38:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,333,1571727600"; 
   d="scan'208";a="241357894"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 19 Dec 2019 17:38:01 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 4/4] perf report: support hotkey to let user select any event for sorting
Date:   Fri, 20 Dec 2019 09:37:22 +0800
Message-Id: <20191220013722.20592-4-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220013722.20592-1-yao.jin@linux.intel.com>
References: <20191220013722.20592-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When performing "perf report --group", it shows the event group information
together. In previous patch, we have supported a new option "--group-sort-idx"
to sort the output by the event at the index n in event group.

It would be nice if we can use a hotkey in browser to select a event
to sort.

For example,

  # perf report --group

 Samples: 12K of events 'cpu/instructions,period=2000003/, cpu/cpu-cycles,period=200003/, ...
                        Overhead  Command    Shared Object            Symbol
  92.19%  98.68%   0.00%  93.30%  mgen       mgen                     [.] LOOP1
   3.12%   0.29%   0.00%   0.16%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x0000000000049515
   1.56%   0.03%   0.00%   0.04%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494b7
   1.56%   0.01%   0.00%   0.00%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494ce
   1.56%   0.00%   0.00%   0.00%  mgen       [kernel.kallsyms]        [k] task_tick_fair
   0.00%   0.15%   0.00%   0.04%  perf       [kernel.kallsyms]        [k] smp_call_function_single
   0.00%   0.13%   0.00%   6.08%  swapper    [kernel.kallsyms]        [k] intel_idle
   0.00%   0.03%   0.00%   0.00%  gsd-color  libglib-2.0.so.0.5600.4  [.] g_main_context_check
   0.00%   0.03%   0.00%   0.00%  swapper    [kernel.kallsyms]        [k] apic_timer_interrupt
   0.00%   0.03%   0.00%   0.00%  swapper    [kernel.kallsyms]        [k] check_preempt_curr

When user press hotkey '3' (event index, starting from 0), it indicates
to sort output by the forth event in group.

  Samples: 12K of events 'cpu/instructions,period=2000003/, cpu/cpu-cycles,period=200003/, ...
                        Overhead  Command    Shared Object            Symbol
  92.19%  98.68%   0.00%  93.30%  mgen       mgen                     [.] LOOP1
   0.00%   0.13%   0.00%   6.08%  swapper    [kernel.kallsyms]        [k] intel_idle
   3.12%   0.29%   0.00%   0.16%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x0000000000049515
   0.00%   0.00%   0.00%   0.06%  swapper    [kernel.kallsyms]        [k] hrtimer_start_range_ns
   1.56%   0.03%   0.00%   0.04%  gsd-color  libglib-2.0.so.0.5600.4  [.] 0x00000000000494b7
   0.00%   0.15%   0.00%   0.04%  perf       [kernel.kallsyms]        [k] smp_call_function_single
   0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] update_curr
   0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] apic_timer_interrupt
   0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] native_apic_msr_eoi_write
   0.00%   0.00%   0.00%   0.02%  mgen       [kernel.kallsyms]        [k] __update_load_avg_se

 v6:
 ---
 Jiri provided a good improvement to eliminate unneeded refresh.
 This improvement is added to v6.

 v5:
 ---
 No change

 v4:
 ---
 No change

 v3:
 ---
 No change

 v2:
 ---
 1. Report warning at helpline when index is invalid.
 2. Report warning at helpline when it's not group event.
 3. Use "case '0' ... '9'" to refine the code
 4. Split K_RELOAD implementation to another patch.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/ui/browsers/hists.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 096b3bc0fbef..9f5dd48500a2 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2876,7 +2876,8 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 	"s             Switch to another data file in PWD\n"
 	"t             Zoom into current Thread\n"
 	"V             Verbose (DSO names in callchains, etc)\n"
-	"/             Filter symbol by name";
+	"/             Filter symbol by name\n"
+	"0-9           Sort by event n in group";
 	static const char top_help[] = HIST_BROWSER_HELP_COMMON
 	"P             Print histograms to perf.hist.N\n"
 	"t             Zoom into current Thread\n"
@@ -2937,6 +2938,31 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 			 * go to the next or previous
 			 */
 			goto out_free_stack;
+		case '0' ... '9':
+			if (!symbol_conf.event_group ||
+			    evsel->core.nr_members < 2) {
+				snprintf(buf, sizeof(buf),
+					 "Sort by index only available with group events!");
+				helpline = buf;
+				continue;
+			}
+
+			if (key - '0' == symbol_conf.group_sort_idx)
+				continue;
+
+			symbol_conf.group_sort_idx = key - '0';
+
+			if (symbol_conf.group_sort_idx >= evsel->core.nr_members) {
+				snprintf(buf, sizeof(buf),
+					 "Max event group index to sort is %d (index from 0 to %d)",
+					 evsel->core.nr_members - 1,
+					 evsel->core.nr_members - 1);
+				helpline = buf;
+				continue;
+			}
+
+			key = K_RELOAD;
+			goto out_free_stack;
 		case 'a':
 			if (!hists__has(hists, sym)) {
 				ui_browser__warning(&browser->b, delay_secs * 2,
-- 
2.17.1

