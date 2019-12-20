Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FF8C2D0D1
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B816024680
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfLTBiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 20:38:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:39282 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbfLTBiC (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:38:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 17:38:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,333,1571727600"; 
   d="scan'208";a="241357879"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 19 Dec 2019 17:38:00 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 3/4] perf report: Support a new key to reload the browser
Date:   Fri, 20 Dec 2019 09:37:21 +0800
Message-Id: <20191220013722.20592-3-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220013722.20592-1-yao.jin@linux.intel.com>
References: <20191220013722.20592-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we may need to reload the browser to update the output since
some options are changed.

This patch creates a new key K_RELOAD. Once the __cmd_report() returns
K_RELOAD, it would repeat the whole process, such as, read samples from
data file, sort the data and display in the browser.

 v6:
 ---
 No change.

 v5:
 ---
 1. Fix the 'make NO_SLANG=1' error. Define K_RELOAD in util/hist.h.
 2. Skip setup_sorting() in repeat path if last key is K_RELOAD.

 v4:
 ---
 Need to quit in perf_evsel_menu__run if key is K_RELOAD.

 v3:
 ---
 No change.

 v2:
 ---
 This is a new patch created in v2.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-report.c    | 6 +++---
 tools/perf/ui/browsers/hists.c | 1 +
 tools/perf/ui/keysyms.h        | 1 +
 tools/perf/util/hist.h         | 1 +
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 4c80a3ba73c3..6f7c7cf061d6 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -635,7 +635,7 @@ static int report__browse_hists(struct report *rep)
 		 * Usually "ret" is the last pressed key, and we only
 		 * care if the key notifies us to switch data file.
 		 */
-		if (ret != K_SWITCH_INPUT_DATA)
+		if (ret != K_SWITCH_INPUT_DATA && ret != K_RELOAD)
 			ret = 0;
 		break;
 	case 2:
@@ -1461,7 +1461,7 @@ int cmd_report(int argc, const char **argv)
 		sort_order = sort_tmp;
 	}
 
-	if ((last_key != K_SWITCH_INPUT_DATA) &&
+	if ((last_key != K_SWITCH_INPUT_DATA && last_key != K_RELOAD) &&
 	    (setup_sorting(session->evlist) < 0)) {
 		if (sort_order)
 			parse_options_usage(report_usage, options, "s", 1);
@@ -1540,7 +1540,7 @@ int cmd_report(int argc, const char **argv)
 	sort__setup_elide(stdout);
 
 	ret = __cmd_report(&report);
-	if (ret == K_SWITCH_INPUT_DATA) {
+	if (ret == K_SWITCH_INPUT_DATA || ret == K_RELOAD) {
 		perf_session__delete(session);
 		last_key = K_SWITCH_INPUT_DATA;
 		goto repeat;
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index d4d3558fdef4..096b3bc0fbef 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3335,6 +3335,7 @@ static int perf_evsel_menu__run(struct evsel_menu *menu,
 					pos = perf_evsel__prev(pos);
 				goto browse_hists;
 			case K_SWITCH_INPUT_DATA:
+			case K_RELOAD:
 			case 'q':
 			case CTRL('c'):
 				goto out;
diff --git a/tools/perf/ui/keysyms.h b/tools/perf/ui/keysyms.h
index fbfac29077f2..04cc4e5c031f 100644
--- a/tools/perf/ui/keysyms.h
+++ b/tools/perf/ui/keysyms.h
@@ -25,5 +25,6 @@
 #define K_ERROR	 -2
 #define K_RESIZE -3
 #define K_SWITCH_INPUT_DATA -4
+#define K_RELOAD -5
 
 #endif /* _PERF_KEYSYMS_H_ */
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 45286900aacb..93ea84009393 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -536,6 +536,7 @@ static inline int block_hists_tui_browse(struct block_hist *bh __maybe_unused,
 #define K_LEFT  -1000
 #define K_RIGHT -2000
 #define K_SWITCH_INPUT_DATA -3000
+#define K_RELOAD -4000
 #endif
 
 unsigned int hists__sort_list_width(struct hists *hists);
-- 
2.17.1

