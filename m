Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB753C432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61142190F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408382AbfIWXdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 19:33:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:54857 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbfIWXdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 19:33:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 16:33:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,542,1559545200"; 
   d="scan'208";a="213494680"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga004.fm.intel.com with ESMTP; 23 Sep 2019 16:33:45 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 75109301C03; Mon, 23 Sep 2019 16:33:45 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 3/3] perf, stat: Fix free memory access / memory leaks in metrics
Date:   Mon, 23 Sep 2019 16:33:39 -0700
Message-Id: <20190923233339.25326-3-andi@firstfloor.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190923233339.25326-1-andi@firstfloor.org>
References: <20190923233339.25326-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Make sure to not free the name passed in by the caller, but free
all the allocated ids when parsing expressions.

The loop at the end knows that the first entry shouldn't be freed,
so make sure the caller name is the first entry.

Fixes

% perf stat -M IpB,IpCall,IpTB,IPC,Retiring_SMT,Frontend_Bound_SMT,Kernel_Utilization,CPU_Utilization --metric-only -a -I 1000 sleep 2

valgrind:
     1.009943231 ==21527== Invalid read of size 1
==21527==    at 0x483CB74: strcmp (vg_replace_strmem.c:849)
==21527==    by 0x582CF8: collect_all_aliases (stat-display.c:554)
==21527==    by 0x582EB3: collect_data (stat-display.c:577)
==21527==    by 0x583A32: print_counter_aggr (stat-display.c:806)
==21527==    by 0x584FAD: perf_evlist__print_counters (stat-display.c:1200)
==21527==    by 0x45133A: print_counters (builtin-stat.c:655)
==21527==    by 0x450629: process_interval (builtin-stat.c:353)
==21527==    by 0x450FBD: __run_perf_stat (builtin-stat.c:564)
==21527==    by 0x451285: run_perf_stat (builtin-stat.c:636)
==21527==    by 0x454619: cmd_stat (builtin-stat.c:1966)
==21527==    by 0x4D557D: run_builtin (perf.c:310)
==21527==    by 0x4D57EA: handle_internal_command (perf.c:362)
==21527==  Address 0x12826cd0 is 0 bytes inside a block of size 25 free'd
==21527==    at 0x4839A0C: free (vg_replace_malloc.c:540)
==21527==    by 0x627041: __zfree (zalloc.c:13)
==21527==    by 0x57F66A: generic_metric (stat-shadow.c:814)
==21527==    by 0x580B21: perf_stat__print_shadow_stats (stat-shadow.c:1057)
==21527==    by 0x58418E: print_metric_headers (stat-display.c:943)
==21527==    by 0x5844BC: print_interval (stat-display.c:1004)
==21527==    by 0x584DEB: perf_evlist__print_counters (stat-display.c:1172)
==21527==    by 0x45133A: print_counters (builtin-stat.c:655)
==21527==    by 0x450629: process_interval (builtin-stat.c:353)
==21527==    by 0x450FBD: __run_perf_stat (builtin-stat.c:564)
==21527==    by 0x451285: run_perf_stat (builtin-stat.c:636)
==21527==    by 0x454619: cmd_stat (builtin-stat.c:1966)
==21527==  Block was alloc'd at
==21527==    at 0x483880B: malloc (vg_replace_malloc.c:309)
==21527==    by 0x51677DE: strdup (in /usr/lib64/libc-2.29.so)
==21527==    by 0x506457: parse_events_name (parse-events.c:1754)
==21527==    by 0x5550BB: parse_events_parse (parse-events.y:214)
==21527==    by 0x50694D: parse_events__scanner (parse-events.c:1887)
==21527==    by 0x506AEF: parse_events (parse-events.c:1927)
==21527==    by 0x521D8B: metricgroup__parse_groups (metricgroup.c:527)
==21527==    by 0x45156F: parse_metric_groups (builtin-stat.c:721)
==21527==    by 0x6228A9: get_value (parse-options.c:243)
==21527==    by 0x62363F: parse_short_opt (parse-options.c:348)
==21527==    by 0x62363F: parse_options_step (parse-options.c:536)
==21527==    by 0x62363F: parse_options_subcommand (parse-options.c:651)
==21527==    by 0x453C1D: cmd_stat (builtin-stat.c:1718)
==21527==    by 0x4D557D: run_builtin (perf.c:310)

and also a leak report.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/stat-shadow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 70c87fdb2a43..2c41d47f6f83 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -738,6 +738,8 @@ static void generic_metric(struct perf_stat_config *config,
 	char *n, *pn;
 
 	expr__ctx_init(&pctx);
+	/* Must be first id entry */
+	expr__add_id(&pctx, name, avg);
 	for (i = 0; metric_events[i]; i++) {
 		struct saved_value *v;
 		struct stats *stats;
@@ -776,8 +778,6 @@ static void generic_metric(struct perf_stat_config *config,
 			expr__add_id(&pctx, n, avg_stats(stats)*scale);
 	}
 
-	expr__add_id(&pctx, name, avg);
-
 	if (!metric_events[i]) {
 		const char *p = metric_expr;
 
-- 
2.21.0

