Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A753C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFAAD20848
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578326908;
	bh=Ni0BZItV0xm/STZtM8JMvqpY6hVmDf7fLnZwSuec7Go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M1X6ZoyJnte9me25XMZBEzdscq3JBX5GZKfbAgAI1pPXPddnZ0ayf7MIuVRMLXTtI
	 CnzmytWHt9zKqa1XKQ92R7WxW3FnaoC+G5/aAPs5x72khjXr+oLUvTovmEtRPHPuZM
	 7ctCpJsExbCd6r3JOpPp2fX+VY3Hikkkxlun469Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgAFQI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:08:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbgAFQIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:08:25 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E30E5208C4;
        Mon,  6 Jan 2020 16:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578326904;
        bh=Ni0BZItV0xm/STZtM8JMvqpY6hVmDf7fLnZwSuec7Go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AowMrD95HW6w2UJR+8uwwlz2LOPYvcjnjLKVc/uzIspGI+3Sshk0bylHTdEno8gQK
         Fi5L/juHiTRvcHH/GFsR6KkDVFtFzIOzVrAeJIZ1IPDUYwQc6nsaN2PtuuC7wXtJ1C
         ebwHS2Ju+0nnJ8RjsitRKjOsDaoXPjb592Y2plh8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 19/20] perf report/top: Make 'e' visible in the help and make it toggle showing callchains
Date:   Mon,  6 Jan 2020 13:07:04 -0300
Message-Id: <20200106160705.10899-20-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200106160705.10899-1-acme@kernel.org>
References: <20200106160705.10899-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The 'e' and 'c' hotkeys were present for a long time, but not documented
in the help window, change 'e' to be a toggle so that it gets consistent
with other toggles like '+' and document it in the help window.

Keep 'c' as is for people used to it but don't document, as it is easier
to just use 'e' to show/hide all the callchains for a top level
histogram entry.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-pmyi5x34stlqmyu81rci94x9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 3bec8de89880..f36dee499320 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -407,6 +407,11 @@ static bool hist_browser__selection_has_children(struct hist_browser *browser)
 	return container_of(ms, struct callchain_list, ms)->has_children;
 }
 
+static bool hist_browser__he_selection_unfolded(struct hist_browser *browser)
+{
+	return browser->he_selection ? browser->he_selection->unfolded : false;
+}
+
 static bool hist_browser__selection_unfolded(struct hist_browser *browser)
 {
 	struct hist_entry *he = browser->he_selection;
@@ -727,7 +732,7 @@ static int hist_browser__handle_hotkey(struct hist_browser *browser, bool warn_l
 		break;
 	case 'e':
 		/* Expand the selected entry. */
-		hist_browser__set_folding_selected(browser, true);
+		hist_browser__set_folding_selected(browser, !hist_browser__he_selection_unfolded(browser));
 		break;
 	case 'H':
 		browser->show_headers = !browser->show_headers;
@@ -2942,6 +2947,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 	"a             Annotate current symbol\n"			\
 	"C             Collapse all callchains\n"			\
 	"d             Zoom into current DSO\n"				\
+	"e             Expand/Collapse main entry callchains\n"	\
 	"E             Expand all callchains\n"				\
 	"F             Toggle percentage of filtered entries\n"		\
 	"H             Display column headers\n"			\
-- 
2.21.1

