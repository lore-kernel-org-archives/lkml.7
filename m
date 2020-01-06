Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13C9C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938C52146E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578326877;
	bh=ptcskTN6aKlqg8INg//CL4MOgSyfhlrgyApp0l8lHnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pycHQadnTU8/AxuBbV/AoLCFd2iSjeRJUmdd2VpTJQVsuLIPkIwPhaj14Ytrg4J5R
	 f8x9kHP0Vwg5wT60nO7z8HUtOWYuEhz/ApQotBHHCBQkWF9a6pTr9I0UaS2ou38geT
	 oJXDC69ABYA062jgYgF6cg6Lf6J82yckkqh33eWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgAFQH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:07:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbgAFQHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:07:52 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1708E2467A;
        Mon,  6 Jan 2020 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578326872;
        bh=ptcskTN6aKlqg8INg//CL4MOgSyfhlrgyApp0l8lHnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TnALOwCEjEwILvjZhfsTJl4XAzH1tvTddolEYil8/Iec1P78018EuSYhDetH135i/
         JhApJiXM5vCk9BZYdSctlR3/h/6ugWWC6hqUUHpbi0exLKfPYiabyx4zrmz6DkhZoW
         dQYoPnpu2dioZbogliWY7hpnycEYE+fcOsRxH7Wg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>
Subject: [PATCH 10/20] perf report/top: Make ENTER consistently bring up menu
Date:   Mon,  6 Jan 2020 13:06:55 -0300
Message-Id: <20200106160705.10899-11-acme@kernel.org>
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

When callchains are present the ENTER key switches from bringing up the
menu that offers Annotation, Zoom by DSO, etc to expanding/collapsing
one callchain level, causing confusion, fix it by making it consistently
bring up the menu and use '+' to expand/collapse one callchain level.

Next patch will also add an entry to the menu to allow
expanding/collapsing, so that people used to ENTER expanding one
callchain level can quickly find it and use it instead.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-bjz35omktig8cwn6lbj1ifns@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index cfc6172ecab7..fefa505d4fa8 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -706,7 +706,7 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
 			browser->show_headers = !browser->show_headers;
 			hist_browser__update_rows(browser);
 			break;
-		case K_ENTER:
+		case '+':
 			if (hist_browser__toggle_fold(browser))
 				break;
 			/* fall thru */
@@ -2858,6 +2858,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 	"For symbolic views (--sort has sym):\n\n"			\
 	"ENTER         Zoom into DSO/Threads & Annotate current symbol\n" \
 	"ESC           Zoom out\n"					\
+	"+             Expand/Collapse one callchain level\n"		\
 	"a             Annotate current symbol\n"			\
 	"C             Collapse all callchains\n"			\
 	"d             Zoom into current DSO\n"				\
-- 
2.21.1

