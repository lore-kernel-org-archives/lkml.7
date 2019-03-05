Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA63FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BA720842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfCEOsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:48:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:28781 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbfCEOsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 09:48:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 06:48:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,444,1544515200"; 
   d="scan'208";a="121150046"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga006.jf.intel.com with ESMTP; 05 Mar 2019 06:48:14 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B3FB0301BC6; Tue,  5 Mar 2019 06:48:14 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v4 15/15] perf tools ui: Fix ui popup browser for many entries
Date:   Tue,  5 Mar 2019 06:47:58 -0800
Message-Id: <20190305144758.12397-16-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190305144758.12397-1-andi@firstfloor.org>
References: <20190305144758.12397-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Fix the argv ui browser code to correctly display more entries
than fit on the screen without crashing. The problem was some type
confusion with pointer types in the ->seek function. Do
the argv arithmetic correctly with char ** pointers. Also
add some asserts to find overruns and limit the display function
correctly.

Then finally remove a workaround for this in the res sample
browser.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/ui/browser.c             | 10 +++++++---
 tools/perf/ui/browsers/res_sample.c |  3 ---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 4f75561424ed..4ad37d8c7d6a 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -611,14 +611,16 @@ void ui_browser__argv_seek(struct ui_browser *browser, off_t offset, int whence)
 		browser->top = browser->entries;
 		break;
 	case SEEK_CUR:
-		browser->top = browser->top + browser->top_idx + offset;
+		browser->top = (char **)browser->top + offset;
 		break;
 	case SEEK_END:
-		browser->top = browser->top + browser->nr_entries - 1 + offset;
+		browser->top = (char **)browser->entries + browser->nr_entries - 1 + offset;
 		break;
 	default:
 		return;
 	}
+	assert((char **)browser->top < (char **)browser->entries + browser->nr_entries);
+	assert((char **)browser->top >= (char **)browser->entries);
 }
 
 unsigned int ui_browser__argv_refresh(struct ui_browser *browser)
@@ -630,7 +632,9 @@ unsigned int ui_browser__argv_refresh(struct ui_browser *browser)
 		browser->top = browser->entries;
 
 	pos = (char **)browser->top;
-	while (idx < browser->nr_entries) {
+	while (idx < browser->nr_entries &&
+	       row < (unsigned)SLtt_Screen_Rows - 1) {
+		assert(pos < (char **)browser->entries + browser->nr_entries);
 		if (!browser->filter || !browser->filter(browser, *pos)) {
 			ui_browser__gotorc(browser, row, 0);
 			browser->write(browser, pos, row);
diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
index 8b045482744e..62775efc32b4 100644
--- a/tools/perf/ui/browsers/res_sample.c
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -23,9 +23,6 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
 	struct res_sample *r;
 	char extra_format[256];
 
-	/* For now since ui__popup_menu doesn't like lists that don't fit */
-	num_res = max(min(SLtt_Screen_Rows - 4, num_res), 0);
-
 	names = calloc(num_res, sizeof(char *));
 	if (!names)
 		return -1;
-- 
2.20.1

