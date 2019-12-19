Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B3DC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D147D222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfLSGKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 01:10:05 -0500
Received: from mga03.intel.com ([134.134.136.65]:43463 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfLSGKF (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 01:10:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 22:10:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,330,1571727600"; 
   d="scan'208";a="390418552"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by orsmga005.jf.intel.com with ESMTP; 18 Dec 2019 22:10:02 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 1/4] perf report: Fix incorrectly added dimensions as switch perf data file
Date:   Thu, 19 Dec 2019 14:09:26 +0800
Message-Id: <20191219060929.3714-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We observed an issue that was some extra columns displayed after switching
perf data file in browser. The steps to reproduce:

1. perf record -a -e cycles,instructions -- sleep 3
2. perf report --group
3. In browser, we use hotkey 's' to switch to another perf.data
4. Now in browser, the extra columns 'Self' and 'Children' are displayed.

The issue is setup_sorting() executed again after repeat path, so dimensions
are added again.

This patch checks the last key returned from __cmd_report(). If it's
K_SWITCH_INPUT_DATA, skips the setup_sorting().

 v5:
 ---
 New patch in v5.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-report.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 387311c67264..de988589d99b 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1076,6 +1076,7 @@ int cmd_report(int argc, const char **argv)
 	struct stat st;
 	bool has_br_stack = false;
 	int branch_mode = -1;
+	int last_key = 0;
 	bool branch_call_mode = false;
 #define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
 	static const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
@@ -1450,7 +1451,8 @@ int cmd_report(int argc, const char **argv)
 		sort_order = sort_tmp;
 	}
 
-	if (setup_sorting(session->evlist) < 0) {
+	if ((last_key != K_SWITCH_INPUT_DATA) &&
+	    (setup_sorting(session->evlist) < 0)) {
 		if (sort_order)
 			parse_options_usage(report_usage, options, "s", 1);
 		if (field_order)
@@ -1530,6 +1532,7 @@ int cmd_report(int argc, const char **argv)
 	ret = __cmd_report(&report);
 	if (ret == K_SWITCH_INPUT_DATA) {
 		perf_session__delete(session);
+		last_key = K_SWITCH_INPUT_DATA;
 		goto repeat;
 	} else
 		ret = 0;
-- 
2.17.1

