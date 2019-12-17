Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5075C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59D624679
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576594157;
	bh=8tEQnrjV2iZx6a6s8GZTx/5QLk5kJUnwb3yiaS8s5ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NafO9QsAQnyLkDpCZhRUe4y3j9oSbagmrFI+fox1ZMCz9bmCYqOsXqnjQjirBl5J6
	 kV/Af1TG4Tsqhy86TXsMzLAbxShItEQLuIHd8zw5gOzl79wFU3lWUOy2DheB+6OOQH
	 zV8nnLs4nTuaY5SVQuVCucCWmAaTmAFe3PyqRE6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfLQOtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:49:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729268AbfLQOtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:49:12 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 712892465E;
        Tue, 17 Dec 2019 14:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576594151;
        bh=8tEQnrjV2iZx6a6s8GZTx/5QLk5kJUnwb3yiaS8s5ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QrfXqrOamJfaTT3ZgL35itashIxsVkg0i4LTIJ8OhYs/nPYKa9Y1buHkYdpR7HKR/
         95ibpgrxhbb8X3b+Ipd+sGTsi0FU/ZLRtU1FwJ8Fq8YYaX/9dIVT0RPajVPoKafqW2
         q5DWPIHr/1Pg33PTy7i8G7wvUScPPd3+8ppt20uI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 06/12] perf report/top: Add 'k' hotkey to zoom directly into the kernel map
Date:   Tue, 17 Dec 2019 11:48:22 -0300
Message-Id: <20191217144828.2460-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217144828.2460-1-acme@kernel.org>
References: <20191217144828.2460-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As a convenience, equivalent to pressing Enter in a line with a kernel
symbol and then selecting "Zoom" into the kernel DSO.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-vbnlnrpyfvz9deqoobtc3dz7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 8aba1aeea0eb..6dfdd8d5a743 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -18,7 +18,9 @@
 #include "../../util/evlist.h"
 #include "../../util/header.h"
 #include "../../util/hist.h"
+#include "../../util/machine.h"
 #include "../../util/map.h"
+#include "../../util/maps.h"
 #include "../../util/symbol.h"
 #include "../../util/map_symbol.h"
 #include "../../util/branch.h"
@@ -2566,7 +2568,7 @@ add_dso_opt(struct hist_browser *browser, struct popup_action *act,
 	if (!hists__has(browser->hists, dso) || map == NULL)
 		return 0;
 
-	if (asprintf(optstr, "Zoom %s %s DSO",
+	if (asprintf(optstr, "Zoom %s %s DSO (use the 'k' hotkey to zoom directly into the kernel)",
 		     browser->hists->dso_filter ? "out of" : "into",
 		     __map__is_kernel(map) ? "the Kernel" : map->dso->short_name) < 0)
 		return 0;
@@ -2936,6 +2938,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 	"E             Expand all callchains\n"				\
 	"F             Toggle percentage of filtered entries\n"		\
 	"H             Display column headers\n"			\
+	"k             Zoom into the kernel map\n"			\
 	"L             Change percent limit\n"				\
 	"m             Display context menu\n"				\
 	"S             Zoom into current Processor Socket\n"		\
@@ -3033,6 +3036,10 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 			actions->ms.map = map;
 			do_zoom_dso(browser, actions);
 			continue;
+		case 'k':
+			if (browser->selection != NULL)
+				hists_browser__zoom_map(browser, browser->selection->maps->machine->vmlinux_map);
+			continue;
 		case 'V':
 			verbose = (verbose + 1) % 4;
 			browser->show_dso = verbose > 0;
-- 
2.21.0

