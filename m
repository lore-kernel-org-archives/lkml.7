Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB855C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCFC21582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 02:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLRCZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 21:25:13 -0500
Received: from mga09.intel.com ([134.134.136.24]:58186 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfLRCZM (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 21:25:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 18:25:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,327,1571727600"; 
   d="scan'208";a="227709517"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by orsmga002.jf.intel.com with ESMTP; 17 Dec 2019 18:25:10 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 2/3] perf report: Support a new key to reload the browser
Date:   Wed, 18 Dec 2019 10:24:42 +0800
Message-Id: <20191218022443.18958-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218022443.18958-1-yao.jin@linux.intel.com>
References: <20191218022443.18958-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we may need to reload the browser to update the output since
some options are changed.

This patch creates a new key K_RELOAD. Once the __cmd_report() returns
K_RELOAD, it would repeat the whole process, such as, read samples from
data file, sort the data and display in the browser.

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
 tools/perf/builtin-report.c    | 4 ++--
 tools/perf/ui/browsers/hists.c | 1 +
 tools/perf/ui/keysyms.h        | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 664e2e94d97d..defd734ca31c 100644
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
@@ -1538,7 +1538,7 @@ int cmd_report(int argc, const char **argv)
 	sort__setup_elide(stdout);
 
 	ret = __cmd_report(&report);
-	if (ret == K_SWITCH_INPUT_DATA) {
+	if (ret == K_SWITCH_INPUT_DATA || ret == K_RELOAD) {
 		perf_session__delete(session);
 		goto repeat;
 	} else
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
-- 
2.17.1

