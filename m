Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2DDC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A629F21556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfLKHbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 02:31:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:35977 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfLKHbO (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 02:31:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 23:31:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="scan'208";a="238435818"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 10 Dec 2019 23:31:12 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 2/3] perf report: Support a new key to reload the browser
Date:   Wed, 11 Dec 2019 15:30:35 +0800
Message-Id: <20191211073036.31504-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211073036.31504-1-yao.jin@linux.intel.com>
References: <20191211073036.31504-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we may need to reload the browser to update the output since
some options are changed.

This patch creates a new key K_RELOAD. Once the __cmd_report() returns
K_RELOAD, it would repeat the whole process, such as, read samples from
data file, sort the data and display in the browser.

 v2:
 ---
 This is a new patch created in v2.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-report.c | 4 ++--
 tools/perf/ui/keysyms.h     | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 729cf7611d8a..02178fc54d67 100644
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

